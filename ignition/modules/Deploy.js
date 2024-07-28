const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
module.exports = buildModule("BTCFi", (m) => {
  const BTC = m.contract("Bitcoin",["Bitcon", "BTC"])
  const USD = m.contract("USD",["US Dollar", "USD"])
  const lending = m.contract("CoreLoanPlatform",  [USD, BTC]);
  m.call(BTC, "transferOwnership", [lending]);
	m.call(USD, "transferOwnership", [lending]);
  return { lending, BTC, USD };
});