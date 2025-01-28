// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract MappingWithStructsTest is Test {
    MappingWithStructs private mappingWithStructs;

    function setUp() public {
        // Deploy the contract before each test
        mappingWithStructs = new MappingWithStructs();
    }

    function testRegisterUser() public {
        // Register a user
        mappingWithStructs.registerUser("Alice", 25);

        // Verify the user is registered
        (string memory name, uint256 age, address walletAddress, bool active) = mappingWithStructs.getUser(
            address(this)
        );
        assertEq(name, "Alice", "User name should be Alice");
        assertEq(age, 25, "User age should be 25");
        assertEq(walletAddress, address(this), "Wallet address should match caller");
        assertTrue(active, "User should be active");
    }

    function testRegisterUserAlreadyRegistered() public {
        // Register the user
        mappingWithStructs.registerUser("Alice", 25);

        // Attempt to register the same user again and expect a revert
        vm.expectRevert("User already registered");
        mappingWithStructs.registerUser("Bob", 30);
    }

    function testUpdateAge() public {
        // Register the user
        mappingWithStructs.registerUser("Alice", 25);

        // Update the user's age
        mappingWithStructs.updateAge(30);

        // Verify the user's age is updated
        (, uint256 age, , ) = mappingWithStructs.getUser(address(this));
        assertEq(age, 30, "User age should be updated to 30");
    }

    function testUpdateAgeUserNotRegistered() public {
        // Attempt to update age without registering
        vm.expectRevert("User not registered");
        mappingWithStructs.updateAge(30);
    }

    function testDeleteUser() public {
        // Register the user
        mappingWithStructs.registerUser("Alice", 25);

        // Delete the user
        mappingWithStructs.deleteUser();

        // Verify the user is no longer registered
        bool isRegistered = mappingWithStructs.isUserRegistered(address(this));
        assertFalse(isRegistered, "User should no longer be registered");

        // Attempt to fetch user details and expect a revert
        vm.expectRevert("User not found");
        mappingWithStructs.getUser(address(this));
    }

    function testDeleteUserNotRegistered() public {
        // Attempt to delete without registering
        vm.expectRevert("User not registered");
        mappingWithStructs.deleteUser();
    }

    function testIsUserRegistered() public {
        // Register the user
        mappingWithStructs.registerUser("Alice", 25);

        // Check if the user is registered
        bool isRegistered = mappingWithStructs.isUserRegistered(address(this));
        assertTrue(isRegistered, "User should be registered");

        // Delete the user
        mappingWithStructs.deleteUser();

        // Check if the user is still registered
        isRegistered = mappingWithStructs.isUserRegistered(address(this));
        assertFalse(isRegistered, "User should no longer be registered");
    }

    function testGetUserNotFound() public {
        // Attempt to get user details without registering
        vm.expectRevert("User not found");
        mappingWithStructs.getUser(address(this));
    }
}
