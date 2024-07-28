const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
module.exports = buildModule("TestContractModule", (m) => {
  const TestDeploymentContract = m.contract("TestDeployment", []);
  return { TestDeploymentContract };
});