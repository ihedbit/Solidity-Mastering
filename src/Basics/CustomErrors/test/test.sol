// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract CustomErrorsTest is Test {
    CustomErrors private customErrors;
    address private owner;
    address private nonOwner;

    function setUp() public {
        owner = address(this); // Set the test contract as the owner
        nonOwner = address(0x1234); // Define a non-owner address
        customErrors = new CustomErrors();
    }

    function testInitialState() public view {
        assertEq(customErrors.owner(), owner, "Owner should be the deployer");
        assertEq(customErrors.getBalance(), 100, "Initial balance should be 100");
    }

    function testAddBalanceSuccess() public {
        customErrors.addBalance(50);
        assertEq(customErrors.getBalance(), 150, "Balance should increase to 150");
    }

    function testAddBalanceRevertsForInvalidAmount() public {
        vm.expectRevert(abi.encodeWithSelector(CustomErrors.InvalidAmount.selector, 0));
        customErrors.addBalance(0); // Passing 0 should revert
    }

    function testWithdrawSuccess() public {
        customErrors.withdraw(50);
        assertEq(customErrors.getBalance(), 50, "Balance should decrease to 50");
    }

    function testWithdrawRevertsForInsufficientBalance() public {
        vm.expectRevert(abi.encodeWithSelector(CustomErrors.InsufficientBalance.selector, 100, 150));
        customErrors.withdraw(150); // Trying to withdraw more than the balance should revert
    }

    function testOnlyOwnerCanAddBalance() public {
        vm.prank(nonOwner);
        vm.expectRevert(abi.encodeWithSelector(CustomErrors.NotOwner.selector, nonOwner));
        customErrors.addBalance(50); // Non-owner calling addBalance should revert
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(nonOwner);
        vm.expectRevert(abi.encodeWithSelector(CustomErrors.NotOwner.selector, nonOwner));
        customErrors.withdraw(50); // Non-owner calling withdraw should revert
    }
}