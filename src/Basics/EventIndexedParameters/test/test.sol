// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract EventIndexedParametersTest is Test {
    EventIndexedParameters private contractInstance;
    address private user1 = address(0x123);
    address private user2 = address(0x456);

    function setUp() public {
        contractInstance = new EventIndexedParameters();
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    function testRegisterUser() public {
        vm.prank(user1);
        vm.expectEmit(true, true, false, true);
        emit EventIndexedParameters.UserRegistered(user1, 1, "Alice");
        contractInstance.registerUser("Alice");

        (string memory name, uint256 id) = contractInstance.getUser(user1);
        assertEq(name, "Alice", "User name should be Alice");
        assertEq(id, 1, "User ID should be 1");
    }

    function testRegisterUserFailsIfAlreadyRegistered() public {
        vm.prank(user1);
        contractInstance.registerUser("Alice");

        vm.expectRevert("User already registered");
        vm.prank(user1);
        contractInstance.registerUser("Alice");
    }

    function testRegisterUserFailsIfNameIsEmpty() public {
        vm.expectRevert("Name cannot be empty");
        vm.prank(user1);
        contractInstance.registerUser("");
    }

    function testDepositFunds() public {
        vm.prank(user1);
        vm.expectEmit(true, true, false, true);
        emit EventIndexedParameters.FundsDeposited(user1, 1 ether);
        contractInstance.depositFunds{value: 1 ether}();

        uint256 balance = contractInstance.getBalance(user1);
        assertEq(balance, 1 ether, "User1 balance should be 1 ether");
    }

    function testDepositFundsFailsIfZeroValue() public {
        vm.expectRevert("Deposit amount must be greater than zero");
        vm.prank(user1);
        contractInstance.depositFunds{value: 0}();
    }

    function testWithdrawFunds() public {
        vm.prank(user1);
        contractInstance.depositFunds{value: 2 ether}();

        vm.prank(user1);
        vm.expectEmit(true, true, false, true);
        emit EventIndexedParameters.FundsWithdrawn(user1, 1 ether);
        contractInstance.withdrawFunds(1 ether);

        uint256 balance = contractInstance.getBalance(user1);
        assertEq(balance, 1 ether, "User1 balance should be 1 ether after withdrawal");
    }

    function testWithdrawFundsFailsIfInsufficientBalance() public {
        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        contractInstance.withdrawFunds(1 ether);
    }

    function testGetUser() public {
        vm.prank(user1);
        contractInstance.registerUser("Alice");

        (string memory name, uint256 id) = contractInstance.getUser(user1);
        assertEq(name, "Alice", "User name should be Alice");
        assertEq(id, 1, "User ID should be 1");
    }

    function testGetBalance() public {
        vm.prank(user1);
        contractInstance.depositFunds{value: 1 ether}();

        uint256 balance = contractInstance.getBalance(user1);
        assertEq(balance, 1 ether, "User1 balance should be 1 ether");
    }
}
