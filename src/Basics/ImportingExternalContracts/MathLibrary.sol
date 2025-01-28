// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MathLibrary
 * @dev Provides basic math operations as a library.
 */
library MathLibrary {
    error SubtractionUnderflow(string message);

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) internal pure returns (uint256) {
        if (b > a) {
            revert SubtractionUnderflow("Math: subtraction underflow");
        }
        return a - b;
    }
}
