const DemurrageToken = artifacts.require("DemurrageToken");

module.exports = function(deployer) {
  deployer.deploy(DemurrageToken);
};
