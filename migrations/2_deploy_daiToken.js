const DaiToken = artifacts.require("daiToken");

module.exports = function(deployer) {
  deployer.deploy(DaiToken);
};
