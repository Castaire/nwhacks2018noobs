// TODO: change varaible to our .sol file
var travels = artifacts.require("./TravelManager.sol");
// TODO: change the deploy parameter
module.exports = function(deployer) {
  deployer.deploy(travels);
};
