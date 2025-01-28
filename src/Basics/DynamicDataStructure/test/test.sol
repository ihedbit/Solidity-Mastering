// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract DynamicDataStructuresTest is Test {
    DynamicDataStructures private contractInstance;
    address private user1 = address(0x123);
    address private user2 = address(0x456);

    function setUp() public {
        contractInstance = new DynamicDataStructures();
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    function testDeposit() public {
        vm.prank(user1);
        contractInstance.deposit{value: 1 ether}();
        assertEq(contractInstance.getBalance(user1), 1 ether, "User1 balance should be 1 ether after deposit");

        vm.prank(user2);
        contractInstance.deposit{value: 2 ether}();
        assertEq(contractInstance.getBalance(user2), 2 ether, "User2 balance should be 2 ether after deposit");
    }

    function testAddUserNote() public {
        vm.prank(user1);
        contractInstance.addUserNote(0, "Hello, World!");
        string memory note = contractInstance.getUserNote(user1, 0);
        assertEq(note, "Hello, World!", "User1's note at index 0 should be 'Hello, World!'");
    }

    function testSetAllowance() public {
        vm.prank(user1);
        contractInstance.setAllowance(user2, 1000);
        uint256 allowance = contractInstance.getAllowance(user1, user2);
        assertEq(allowance, 1000, "User1's allowance for User2 should be 1000");
    }

    function testTransfer() public {
        vm.prank(user1);
        contractInstance.deposit{value: 5 ether}();

        vm.prank(user1);
        contractInstance.transfer(user2, 2 ether);

        assertEq(contractInstance.getBalance(user1), 3 ether, "User1 balance should be 3 ether after transfer");
        assertEq(contractInstance.getBalance(user2), 2 ether, "User2 balance should be 2 ether after transfer");
    }

    function testTransferRevertsOnInsufficientBalance() public {
        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        contractInstance.transfer(user2, 1 ether); // Should revert because User1 hasn't deposited funds
    }

    function testGetDefaultBalance() public view {
        uint256 balance = contractInstance.getBalance(user1);
        assertEq(balance, 0, "Default balance for any user should be 0");
    }

    function testRetrieveDefaultNote() public view {
        string memory note = contractInstance.getUserNote(user1, 0);
        assertEq(note, "", "Default note should be an empty string");
    }

    function testRetrieveDefaultAllowance() public view {
        uint256 allowance = contractInstance.getAllowance(user1, user2);
        assertEq(allowance, 0, "Default allowance should be 0");
    }
}
