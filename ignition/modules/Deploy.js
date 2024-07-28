const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
module.exports = buildModule("CoreLoanPlatform", (m) => {
  const CoreLoanPlatformContract = m.contract("CoreLoanPlatform", []);
  return { CoreLoanPlatformContract };
});