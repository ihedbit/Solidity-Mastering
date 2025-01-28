// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MathOperations
 * @dev Demonstrates basic arithmetic operations in Solidity including addition, subtraction, multiplication, and division.
 */
contract MathOperations {
    
    /**
     * @dev Adds two numbers and returns the result.
     * @param _a First number.
     * @param _b Second number.
     * @return uint256 The sum of _a and _b.
     */
    function add(uint256 _a, uint256 _b) public pure returns (uint256) {
        return _a + _b;
    }

    /**
     * @dev Subtracts two numbers and returns the result.
     * @param _a First number.
     * @param _b Second number.
     * @return uint256 The difference of _a and _b.
     */
    function subtract(uint256 _a, uint256 _b) public pure returns (uint256) {
        require(_a >= _b, "Underflow error: _a should be greater than or equal to _b");
        return _a - _b;
    }

    /**
     * @dev Multiplies two numbers and returns the result.
     * @param _a First number.
     * @param _b Second number.
     * @return uint256 The product of _a and _b.
     */
    function multiply(uint256 _a, uint256 _b) public pure returns (uint256) {
        return _a * _b;
    }

    /**
     * @dev Divides two numbers and returns the quotient.
     * @param _a Numerator.
     * @param _b Denominator.
     * @return uint256 The quotient of _a divided by _b.
     */
    function divide(uint256 _a, uint256 _b) public pure returns (uint256) {
        require(_b > 0, "Division by zero is not allowed");
        return _a / _b;
    }

    /**
     * @dev Calculates the remainder of division.
     * @param _a Numerator.
     * @param _b Denominator.
     * @return uint256 The remainder of _a divided by _b.
     */
    function modulus(uint256 _a, uint256 _b) public pure returns (uint256) {
        require(_b > 0, "Modulo by zero is not allowed");
        return _a % _b;
    }
}
