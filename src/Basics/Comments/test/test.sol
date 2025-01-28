// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract SolidityCommentsTest is Test {
    SolidityComments private commentsContract;
    address private owner;
    address private nonOwner;

    function setUp() public {
        // Initialize owner and non-owner accounts
        owner = address(this);
        nonOwner = address(0x1234);

        // Deploy the contract with an initial greeting message
        commentsContract = new SolidityComments("Hello, Solidity!");
    }

    function testInitialState() public view {
        // Verify the owner is set correctly
        assertEq(commentsContract.owner(), owner, "Owner should be the deployer");
        
        // Verify the initial greeting is set correctly
        assertEq(commentsContract.getGreeting(), "Hello, Solidity!", "Initial greeting should match the constructor argument");
    }

    function testSetGreetingByOwner() public {
        // Update the greeting as the owner
        commentsContract.setGreeting("New Greeting");

        // Verify the updated greeting
        assertEq(commentsContract.getGreeting(), "New Greeting", "Greeting should be updated by the owner");
    }

    function testSetGreetingByNonOwner() public {
        // Try to update the greeting as a non-owner
        vm.prank(nonOwner);
        vm.expectRevert("Caller is not the owner");
        commentsContract.setGreeting("Unauthorized Greeting");

        // Verify the greeting remains unchanged
        assertEq(commentsContract.getGreeting(), "Hello, Solidity!", "Greeting should not change when called by a non-owner");
    }

    function testGetGreeting() public view {
        // Verify the current greeting is retrieved correctly
        string memory greeting = commentsContract.getGreeting();
        assertEq(greeting, "Hello, Solidity!", "Greeting should match the stored value");
    }

    function testOnlyOwnerModifier() public {
        // Verify only the owner can call owner-restricted functions
        vm.prank(nonOwner);
        vm.expectRevert("Caller is not the owner");
        commentsContract.setGreeting("Unauthorized Greeting");
    }
}
