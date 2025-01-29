// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract ArbitraryStorageAccessTest is Test {
    ArbitraryStorageAccess private storageAccess;

    function setUp() public {
        // Deploy the contract before each test
        storageAccess = new ArbitraryStorageAccess();
    }

    function testWriteStorage() public {
        // We choose an arbitrary storage slot
        bytes32 slot = keccak256("example.slot");
        // We'll write this value
        bytes32 newValue = keccak256("hello world");

        // Expect an event with the old and new values
        vm.expectEmit(true, true, false, true);
        emit ArbitraryStorageAccess.StorageUpdated(slot, 0, newValue);

        // Write the value
        storageAccess.writeStorage(slot, newValue);

        // Read it back
        bytes32 storedValue = storageAccess.readStorage(slot);
        assertEq(storedValue, newValue, "The written value should match the stored value");
    }

    function testOverwriteStorage() public {
        // Overwrite an existing slot
        bytes32 slot = keccak256("example.slot");
        bytes32 initialValue = keccak256("initial");
        bytes32 newValue = keccak256("overwritten");

        // Write an initial value
        storageAccess.writeStorage(slot, initialValue);

        // Expect an event showing oldValue -> newValue
        vm.expectEmit(true, true, false, true);
        emit ArbitraryStorageAccess.StorageUpdated(slot, initialValue, newValue);

        // Overwrite the slot
        storageAccess.writeStorage(slot, newValue);

        // Confirm the slot was updated
        bytes32 storedValue = storageAccess.readStorage(slot);
        assertEq(storedValue, newValue, "The storage slot should have been overwritten");
    }

    function testResetStorage() public {
        // We'll write a value, then reset it to zero
        bytes32 slot = keccak256("slot.to.reset");
        bytes32 value = bytes32(uint256(999));

        // Write
        storageAccess.writeStorage(slot, value);

        // Expect an event with oldValue -> 0
        vm.expectEmit(true, true, false, true);
        emit ArbitraryStorageAccess.StorageUpdated(slot, value, 0);

        // Reset
        storageAccess.resetStorage(slot);

        // Read back the slot
        bytes32 storedValue = storageAccess.readStorage(slot);
        assertEq(storedValue, 0, "The storage slot should be reset to zero");
    }

    // Log watchers
    event StorageUpdated(bytes32 indexed slot, bytes32 oldValue, bytes32 newValue);
}
