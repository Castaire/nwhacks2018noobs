App = {
  web3Provider: null,
  contracts: {},
  account: 0x0,
  loading: false

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    /*
     * Replace me...
     */

    return App.initContract();
  },

  initContract: function() {

        $.getJSON('TravelManager.json', function(chainListArtifact) {
          // Get the necessary contract artifact file and use it to instantiate a truffle contract abstraction.
          App.contracts.TravelManager = TruffleContract(chainListArtifact);
          // Set the provider for our contract.
          App.contracts.TravelManager.setProvider(App.web3Provider);
          // Listen for events
          App.listenToEvents();
          // Retrieve the article from the smart contract
          return App.reloadArticles();

        });
  },

  reloadArticles: function() {
    if(App.loading){
      return;
    }
    App.loading = true;
    var TravelManagerInstance;
    App.contracts.TravelManager.deployed().then(function(instance) {TravelManagerInstance = instance;});
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  markAdopted: function(adopters, account) {
    /*
     * Replace me...
     */
  },

  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    /*
     * Replace me...
     */
  }

};

$(function() {
  $(window).load(function() {
    App.init();
      // var Web3 = require('web3');
      // var web3 = new Web3();
      //
      // var addTrip = function() {
      //   web3.eth.defaultAccount = web3.eth.accounts[0];
      //
      //   var myContract = web3.eth.contract();
      //   var result = myContract.at('');
      //   console.log(result);
      }

  });
});
