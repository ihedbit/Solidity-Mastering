// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ConstantVsImmutable
 * @dev Demonstrates the differences between constant and immutable variables in Solidity.
 */
contract ConstantVsImmutable {
    
    // Constant variables must be assigned at compile-time and cannot be modified later.
    uint256 public constant CONSTANT_VALUE = 100;

    // Immutable variables can be assigned at deployment time in the constructor but not changed afterward.
    uint256 public immutable immutableValue;
    address public immutable contractOwner;

    /**
     * @dev Constructor to initialize immutable variables.
     * @param _value The value to assign to the immutable variable.
     */
    constructor(uint256 _value) {
        immutableValue = _value; // Set only once during deployment
        contractOwner = msg.sender; // Store the deployer's address as an immutable value
    }

    /**
     * @dev Returns the constant value.
     */
    function getConstantValue() public pure returns (uint256) {
        return CONSTANT_VALUE;
    }

    /**
     * @dev Returns the immutable value.
     */
    function getImmutableValue() public view returns (uint256) {
        return immutableValue;
    }

    /**
     * @dev Returns the contract owner's address.
     */
    function getOwner() public view returns (address) {
        return contractOwner;
    }
}
