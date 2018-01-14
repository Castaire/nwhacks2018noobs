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
        Participant[] involvedParticipants;
    }


    uint numTrips = 0;
    Trip[] allTrips;
    mapping(address => Participant) participants;

    /// Create a new trip with given params.
    function TravelManager() {
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

        trip.tripId = numTrips++;

        allTrips.push(trip);
        
        return trip.tripId;
    }


    // ASSUME: participant has enough money
    // WARNING: underscore before 'success' (bool)?
    /// adds new participant
    function addInvolvedParticipant(uint tripId) returns (bool success) {
    	Trip storage trip = allTrips[tripId];

    	if (trip.numParticipants == trip.maxParticipants) {
    		return false;
    	}

    	// add participant
    	Participant storage currentParticipant = participants[msg.sender];
    	trip.involvedParticipants.push(currentParticipant);
    	trip.numParticipants++;
    	
    	return true;
    }

}
