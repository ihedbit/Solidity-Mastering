// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import an external contract from another Solidity file
import "./MathLibrary.sol";

/**
 * @title ImportingExternalContracts
 * @dev Demonstrates how to import and reuse code from external contracts and libraries.
 */
contract ImportingExternalContracts {
    
    using MathLibrary for uint256;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Modifier to restrict access to the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    /**
     * @dev Calls an imported library function to add two numbers.
     * @param _a The first number.
     * @param _b The second number.
     * @return uint256 The sum of the numbers.
     */
    function addNumbers(uint256 _a, uint256 _b) public pure returns (uint256) {
        return _a.add(_b);
    }

    /**
     * @dev Calls an imported library function to subtract two numbers.
     * @param _a The first number.
     * @param _b The second number.
     * @return uint256 The result of subtraction.
     */
    function subtractNumbers(uint256 _a, uint256 _b) public pure returns (uint256) {
        return _a.subtract(_b);
    }
}
