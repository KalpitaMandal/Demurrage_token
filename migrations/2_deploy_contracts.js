const Demurrage = artifacts.require("Demurrage");

module.exports = function(deployer) {
  deployer.deploy(Demurrage);
};
