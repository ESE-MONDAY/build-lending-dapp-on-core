// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CoreLoanPlatform {
    
    // state variables - exist throughout the contract

    uint public collateralRatio = 150;
    uint public interestRate = 5;
    uint public borrowableRatio = 80;
    uint public loanDuration = 30 days;
    uint private totalBTCborrowed = 0;
    uint private totalBTCstaked = 0;


    struct Loan {
        uint256 amount;
        uint256 timestamp;
        uint256 collateral;
        bool active;
    }

    mapping(address => Loan) public loans;
    mapping(address => uint256) public lenderBalance;
    mapping(address => uint256) public userCollateral;


    IERC20 public immutable USD;
    IERC20 public immutable BTC;


    function depositCollateral(uint256 _amount) external{

    }

    function withdrawCollateral(uint256 _amount) external{

    }
    function borrowBTC(uint256 _amount) external{

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
    function getUserCollateral(address user) external view returns (uint256){

    }
    function getUserStaked(address user) external view returns (uint256){

    }

}
