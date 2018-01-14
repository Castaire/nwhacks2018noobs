pragma solidity ^0.4.0;
contract TravelManager {

    struct Participant {
        address id;
        string firstName;
        string lastName;
        string streetAddress;
        uint age;
        string biblio;
    }
    struct Trip {
        uint tripId;
        address ownerParticipant;
        string beginDate; // YYYY-MM-DD
        string tripSummary;
        string location;
        uint totalPrice;
        uint8 numParticipants;
        uint8 maxParticipants;
        bool isCancelled;
        address[] participantAddresses;
    }


    uint numTrips;
    Trip[] allTrips;
    mapping(address => Participant) participants;

    /// Create a new trip with given params.
    function TravelManager() {
        numTrips = 0;
    }
    
    function addNewTrip(string beginDate, string tripSummary, string location, uint totalPrice, uint8 maxParticipants) public returns (uint id){
        
    
    	Trip storage trip; 
        trip.ownerParticipant = msg.sender;
        trip.beginDate = beginDate;
        trip.numParticipants = 0;
        trip.maxParticipants = maxParticipants;
        trip.tripSummary = tripSummary;
        trip.location = location;
        trip.totalPrice = totalPrice;
        trip.isCancelled = false;
        // trip.involvedParticipants.length = maxParticipants;

        trip.tripId = numTrips;
        numTrips++;

        allTrips[trip.tripId] = trip;
        
        return trip.tripId;
    }


    // ASSUME: participant has enough money
    // WARNING: underscore before 'success' (bool)?
    /// adds new participant
    function addInvolvedParticipant(uint tripId, string firstName, string lastName, string streetAddress, uint age, string biblio) returns (bool) {
    	Trip storage trip = allTrips[tripId];

    	if (trip.numParticipants == trip.maxParticipants) {
    		return false;
    	}

    	// add participant

    	participants[msg.sender].firstName = firstName;
    	participants[msg.sender].lastName = lastName;
    	participants[msg.sender].streetAddress = streetAddress;
    	participants[msg.sender].age = age;
    	participants[msg.sender].biblio = biblio;
    	trip.participantAddresses.push(msg.sender);
    	trip.numParticipants++;
    	
    	return true;
    }
    
    function getTripById(uint tId) public constant returns (
        uint tripId,
        address ownerParticipant,
        string beginDate,
        uint8 numParticipants,
        uint8 maxParticipants,
        string tripSummary,
        string location,
        uint totalPrice,
        bool isCancelled) {
            Trip storage t = allTrips[tId];
            return (t.tripId, t.ownerParticipant, t.beginDate, t.numParticipants, t.maxParticipants, t.tripSummary, t.location, t.totalPrice, t.isCancelled);
        }

    function getParticipantsInTrip(uint tId, uint i) public constant returns ( // FOR DEBUGGING PURPOSES ONLY
        string firstNames,
        string lastNames,
        uint ages
    ){
        Trip storage t = allTrips[tId];
        return (participants[t.participantAddresses[i]].firstName, participants[t.participantAddresses[i]].lastName, participants[t.participantAddresses[i]].age);
    }

}