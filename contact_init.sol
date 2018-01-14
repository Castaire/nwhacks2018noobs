pragma solidity ^0.4.0;
contract TravelPlan {

    struct Participant {
        address id;
        string firstName;
        string lastName;
        string streetAddress;
        uint age;
        string64 biblio;
    }
    struct Trip {
        uint tripId;
        address ownerParticipant;
        string64 tripSummary;
        string location;
        Purchase[] purchases;
        uint8 numParticipants;
        uint8 maxParticipants;
        bool isCancelled;
        Participant[] involvedParticipants;
    }
    struct Purchase {
        string itemType;
        string url;
        uint price;
    }


    uint constant numTrips = 0;
    Trip[] allTrips;
    mapping(address => Participant) participants;

    /// Create a new trip with given params.
    function TravelPlan(uint8 maxParticipants, string64 tripSummary, string location, Purchase[] purchases) public {

    	Trip trip; 
        trip.ownerParticipant = msg.sender;
        trip.maxParticipants = maxParticipants;
        trip.tripSummary = tripSummary;
        trip.location = location;
        trip.purchases = purchases;
        trip.isCancelled = false;
        trip.involvedParticipants.length = maxParticipants;

        trip.tripId = numTrips++;

        allTrips.push(trip);
    }


    // ASSUME: participant has enough money
    // WARNING: underscore before 'success' (bool)?
    /// adds new participant
    function addInvolvedParticipant(uint tripId) returns (bool success) {
    	Trip trip = allTrips[tripId];

    	if(trip.numParticipants == trip.maxParticipants){
    		return false;
    	}

    	// add participant
    	Participant currentParticipant = trip.participants[msg.sender];
    	trip.involvedParticipants.push(currentParticipant);
    	trip.numParticipants++;
    	
    	
    }








    /// Give $(toVoter) the right to vote on this ballot.
    /// May only be called by $(chairperson).
    function giveRightToVote(address toVoter) public {
        if (msg.sender != chairperson || voters[toVoter].voted) {
            return;
        }
        voters[toVoter].weight = 1;
    }

    /// Delegate your vote to the voter $(to).
    function delegate(address to) public {
        Voter storage sender = voters[msg.sender]; // assigns reference
        if (sender.voted){
            return;
        }
        while (voters[to].delegate != address(0) && voters[to].delegate != msg.sender)
            to = voters[to].delegate;
        if (to == msg.sender) return;
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegateTo = voters[to];
        if (delegateTo.voted)
            proposals[delegateTo.vote].voteCount += sender.weight;
        else
            delegateTo.weight += sender.weight;
    }

    /// Give a single vote to proposal $(toProposal).
    function vote(uint8 toProposal) public {
        Voter storage sender = voters[msg.sender];
        if (sender.voted || toProposal >= proposals.length) return;
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
    }

    function winningProposal() public constant returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
    }
}