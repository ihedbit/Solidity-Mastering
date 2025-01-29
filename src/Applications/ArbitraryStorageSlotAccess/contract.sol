// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ArbitraryStorageAccess
 * @dev Allows access and manipulation of arbitrary storage slots within a contract.
 */
contract ArbitraryStorageAccess {
    event StorageUpdated(bytes32 indexed slot, bytes32 oldValue, bytes32 newValue);

    /**
     * @dev Writes a value to a specific storage slot.
     * @param _slot The storage slot to write to.
     * @param _value The value to write to the slot.
     */
    function writeStorage(bytes32 _slot, bytes32 _value) public {
        bytes32 oldValue;
        assembly {
            oldValue := sload(_slot)
            sstore(_slot, _value)
        }
        emit StorageUpdated(_slot, oldValue, _value);
    }

    /**
     * @dev Reads a value from a specific storage slot.
     * @param _slot The storage slot to read from.
     * @return value The value stored in the slot.
     */
    function readStorage(bytes32 _slot) public view returns (bytes32 value) {
        assembly {
            value := sload(_slot)
        }
    }

    /**
     * @dev Resets a specific storage slot to zero.
     * @param _slot The storage slot to reset.
     */
    function resetStorage(bytes32 _slot) public {
        bytes32 oldValue;
        assembly {
            oldValue := sload(_slot)
            sstore(_slot, 0)
        }
        emit StorageUpdated(_slot, oldValue, 0);
    }
}
