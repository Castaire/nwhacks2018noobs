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
        mapping(address => uint) registrationPaid;
    }


    uint numTrips = 0;
    Trip[] allTrips;
    mapping(address => Participant) participants;

    // Events
//    event addNewTripEvent(uint totalPrice);
    event addNewParticipant(
      uint tripId,
      uint age,
      address pAddress
      );
    event getTripStatus(
      uint tripId,
      address ownerParticipant,
      string beginDate,
      uint8 numParticipants);

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

        allTrips[trip.tripId] = trip;

        //addNewTripEvent
         /* addNewTripEvent(totalPrice,totalPrice,
          uint currentPaticipants
          ); */


        return trip.tripId;
    }


    // ASSUME: participant has enough money
    // WARNING: underscore before 'success' (bool)?
    /// adds new participant
    function addInvolvedParticipant(uint tripId, string firstName, string lastName, string streetAddress, uint age, string biblio) payable public {
    	Trip storage trip = allTrips[tripId];
      /* require(tripId <= numTrips);
      require(trip.numParticipants <= trip.maxParticipants);
      require(msg.value <= trip.totalPrice); */
      // number of trips should be greater than 0
      /* require(numTrips >= 0);
      // tripsId should be valid
      require(tripId < numTrips);
      // retrieve the trip
      /* Trip storage trip = allTrips[tripId]; */
//      require(trip.numParticipants <= trip.maxParticipants); */
      // here we hard coded the amount of money has to be the same as the average price of total price
//      require(msg.value == trip.totalPrice/trip.maxParticipants);

    	/* if (trip.numParticipants == trip.maxParticipants) {
    		return false;
    	} */

    	// add participant

    	participants[msg.sender].firstName = firstName;
    	participants[msg.sender].lastName = lastName;
    	participants[msg.sender].streetAddress = streetAddress;
    	participants[msg.sender].age = age;
    	participants[msg.sender].biblio = biblio;
    	trip.participantAddresses.push(msg.sender);
    	trip.numParticipants++;
      // lock down the value
      trip.registrationPaid[msg.sender] = msg.value;
      // if we reached the maximum then all
      if(trip.numParticipants == trip.maxParticipants){
        suicide(trip.ownerParticipant);
      }
      addNewParticipant(tripId,age,msg.sender);

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
            getTripStatus(t.tripId,t.ownerParticipant,t.beginDate,t.numParticipants);

        }

}
