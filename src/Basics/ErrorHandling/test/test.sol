// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract ErrorHandlingTest is Test {
    ErrorHandling private errorHandling;
    address private owner = address(this); // The deployer (test contract) is the owner
    address private nonOwner = address(0x1234); // A random address

    function setUp() public {
        // Deploy the contract before each test
        errorHandling = new ErrorHandling();
    }

    function testInitialState() public view {
        assertEq(errorHandling.owner(), owner, "The owner should be the deployer");
        assertEq(errorHandling.getBalance(), 100, "Initial balance should be 100");
    }

    function testAddBalance() public {
        errorHandling.addBalance(50);
        assertEq(errorHandling.getBalance(), 150, "Balance should increase by 50");
    }

    function testAddBalanceRevertsForZeroAmount() public {
        vm.expectRevert("Amount must be greater than zero");
        errorHandling.addBalance(0);
    }

    function testWithdraw() public {
        errorHandling.withdraw(50);
        assertEq(errorHandling.getBalance(), 50, "Balance should decrease by 50 after withdrawal");
    }

    function testWithdrawRevertsForInsufficientBalance() public {
        vm.expectRevert("Insufficient balance");
        errorHandling.withdraw(200); // Attempt to withdraw more than the balance
    }

    function testWithdrawRevertsForNonOwner() public {
        vm.prank(nonOwner); // Change the caller to a non-owner
        vm.expectRevert("Caller is not the owner");
        errorHandling.withdraw(10);
    }

    function testValidateBalance() public view {
        errorHandling.validateBalance();
    }

    function testValidateBalanceFailsOnNegative() public {
        errorHandling.withdraw(100); // Reduce balance to 0
        vm.expectRevert(); // `assert` failure doesn't return a message
        errorHandling.withdraw(1); // This should trigger an assert
    }

    function testCustomRevertConditionFalse() public view {
        errorHandling.customRevert(false); // Should pass without errors
    }

    function testCustomRevertConditionTrue() public {
        vm.expectRevert("Custom revert triggered due to the condition being true");
        errorHandling.customRevert(true); // Should revert
    }
}
