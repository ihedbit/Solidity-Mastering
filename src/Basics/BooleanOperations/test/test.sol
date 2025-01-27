// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract BooleanOperationsTest is Test {
    BooleanOperations private booleanOps;
    address private owner;

    function setUp() public {
        owner = address(this); // Assign the test contract as the owner
        booleanOps = new BooleanOperations();
    }

    function testInitialState() public view {
        assertTrue(booleanOps.isContractActive(), "Initial state: Contract should be active");
        assertFalse(booleanOps.isAdmin(), "Initial state: Admin should not be assigned");
    }

    function testToggleContractStatus() public {
        booleanOps.toggleContractStatus();
        assertFalse(booleanOps.isContractActive(), "Contract should be inactive after toggle");

        booleanOps.toggleContractStatus();
        assertTrue(booleanOps.isContractActive(), "Contract should be active after second toggle");
    }

    function testSetAdminStatus() public {
        booleanOps.setAdminStatus(true);
        assertTrue(booleanOps.isAdmin(), "Admin should be set to true");

        booleanOps.setAdminStatus(false);
        assertFalse(booleanOps.isAdmin(), "Admin should be set to false");
    }

    function testIsAdminAndActive() public {
        booleanOps.setAdminStatus(true);
        assertTrue(booleanOps.isAdmin(), "Admin status should be true");
        assertTrue(booleanOps.isAdminAndActive(), "Contract should be active and admin should be assigned");

        booleanOps.toggleContractStatus();
        assertFalse(booleanOps.isAdminAndActive(), "Contract should not be active but admin is assigned");
    }

    function testIsInactiveOrAdmin() public {
        booleanOps.setAdminStatus(false);
        booleanOps.toggleContractStatus();
        assertTrue(booleanOps.isInactiveOrAdmin(), "Contract should be inactive or admin should be assigned");

        booleanOps.setAdminStatus(true);
        assertTrue(booleanOps.isInactiveOrAdmin(), "Should be true when admin is assigned");
    }

    function testIsNeitherActiveNorAdmin() public {
        booleanOps.toggleContractStatus();
        booleanOps.setAdminStatus(false);
        assertTrue(booleanOps.isNeitherActiveNorAdmin(), "Should be true when contract is inactive and no admin");

        booleanOps.setAdminStatus(true);
        assertFalse(booleanOps.isNeitherActiveNorAdmin(), "Should be false when admin is assigned");

        booleanOps.toggleContractStatus();
        assertFalse(booleanOps.isNeitherActiveNorAdmin(), "Should be false when contract is active");
    }

    function testToggleAndAdminTogether() public {
        booleanOps.toggleContractStatus();
        booleanOps.setAdminStatus(true);
        assertTrue(booleanOps.isInactiveOrAdmin(), "Contract should be inactive but admin assigned");

        booleanOps.toggleContractStatus();
        assertTrue(booleanOps.isAdminAndActive(), "Contract should be active and admin assigned");

        booleanOps.setAdminStatus(false);
        assertFalse(booleanOps.isAdminAndActive(), "Contract should be active but admin is removed");
    }

    function testAdminStatusToggle() public {
        booleanOps.setAdminStatus(true);
        assertTrue(booleanOps.isAdmin(), "Admin should be set to true");

        booleanOps.setAdminStatus(false);
        assertFalse(booleanOps.isAdmin(), "Admin should be set to false again");

        booleanOps.setAdminStatus(true);
        assertTrue(booleanOps.isAdmin(), "Admin should be set back to true");
    }
}
