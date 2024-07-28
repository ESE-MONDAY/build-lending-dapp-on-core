// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CoreLoanPlatform is Ownable {
     using SafeERC20 for IERC20;
      struct Loan {
        uint256 amount;
        uint256 timestamp;
        uint256 collateral;
        bool active;
    }
    
    // state variables - exist throughout the contract
    uint public collateralRatio = 150;
    uint public interestRate = 5;
    uint public borrowableRatio = 80;
    uint public loanDuration = 30 days;
    uint private totalBTCborrowed = 0;
    uint private totalBTCstaked = 0;


   

// Mappings
    mapping(address => Loan) public loans;
    mapping(address => uint256) public lenderBalance;
    mapping(address => uint256) public userCollateral;

// Interface Immutable
    IERC20 public immutable USD;
    IERC20 public immutable BTC;

 constructor(address _USD, address _BTC) Ownable(msg.sender) {
      require(_USD != address(0) && _BTC != address(0), "Invalid token addresses");
      USD = IERC20(_USD);
      BTC = IERC20(_BTC);
    }


// Events
    event CollateralDeposited(address indexed user, uint256 amount);
    event collaterWithdrawn(address indexed user, uint256 amount);
    event loanTaken(address indexed borrower, uint256 amount, uint256 collateral);

   


    function depositCollateral(uint256 _amount) external{
        require(_amount > 0 , "amount must be greater than 0");
        USD.safeTransferFrom(msg.sender, address(this), _amount);
        userCollateral[msg.sender] += _amount;
        emit CollateralDeposited(msg.sender, _amount);

    }

    function withdrawCollateral(uint256 _amount) external{
        require(_amount > 0 , "amount must be greater than 0");
        require(userCollateral[msg.sender] >= _amount, "Insufficient collateral");
        uint256 borrowedAmount = loans[msg.sender].active ? loans[msg.sender].amount : 0;
        uint256 requiredCollateral = (borrowedAmount * collateralRatio) / 100;

        require(userCollateral[msg.sender] - _amount >= requiredCollateral, "Cannot withdraw this amount, Withdrawal will undercollaterize loan");
        USD.safeTransfer(msg.sender, _amount);
        emit collaterWithdrawn(msg.sender, _amount);


    }
    function borrowBTC(uint256 _amount) external{
        require(_amount > 0 , "amount must be greater than 0");
        require(!loans[msg.sender].active , "Existing loan must be repayed first");

        uint256 requiredCollateral = (_amount * collateralRatio) / 100;
        require(userCollateral[msg.sender] >= requiredCollateral, "Insufficient collateral");

        uint256 maxBorrowable = (userCollateral[msg.sender] * borrowableRatio) / 100;
        require( _amount <= maxBorrowable, "Loan amount exceeds borrowable limit");
        require(BTC.balanceOf(address(this)) >= _amount, "Insufficient funds in the pool");


        loans[msg.sender] = Loan(_amount, block.timestamp, requiredCollateral, true);
        BTC.safeTransfer(msg.sender, _amount);
        totalBTCborrowed = totalBTCborrowed + _amount;
        emit loanTaken(msg.sender, _amount, requiredCollateral);

    }
    function repayLoan(address _user) external{

    }
    function depositBTC(uint256 _amount) external{

    }
    function withdrawBTC(uint256 _amount) external{

    }
    function calculateInterest(address _user) external view returns (uint256){

    }
    function getBorrowableAmount(address _user) external view returns (uint256){
        return (userCollateral[_user] * borrowableRatio) / 100;

    }
    function getLoanDetails(address _borrower) external view returns (Loan memory){

    }
    function getLenderBalance(address lender) external view returns (uint256){

    }
    function getTotalStaked() external view returns (uint256){

    }
    function getTotalBorrowed() external view returns (uint256){

    }
    function getCurrentApy() external pure returns (uint256){

    }
    function getUserCollateral(address _user) external view returns (uint256){
        return userCollateral[_user];

    }
    function getUserStaked(address user) external view returns (uint256){

    }

}
