// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title DefaultFunctionParameters
 * @dev Demonstrates how to define and use functions with default values for parameters in Solidity.
 */
contract DefaultFunctionParameters {

    // State variable to store a default greeting message
    string public greeting = "Hello, Solidity!";
    
    // State variable to track stored numbers
    uint256 public storedNumber;

    /**
     * @dev Sets a new greeting message, with a default value if no argument is provided.
     * @param _message The new greeting message. Defaults to "Hello, Blockchain!" if not provided.
     */
    function setGreeting(string memory _message) public {
        greeting = bytes(_message).length > 0 ? _message : "Hello, Blockchain!";
    }

    /**
     * @dev Stores a number with an optional default value.
     * @param _num The number to store. Defaults to 100 if zero is passed.
     */
    function storeNumber(uint256 _num) public {
        storedNumber = _num > 0 ? _num : 100;
    }

    /**
     * @dev Adds two numbers, using default values if arguments are zero.
     * @param _a The first number. Defaults to 10 if zero is provided.
     * @param _b The second number. Defaults to 5 if zero is provided.
     * @return The sum of _a and _b.
     */
    function addNumbers(uint256 _a, uint256 _b) public pure returns (uint256) {
        uint256 a = _a > 0 ? _a : 10;
        uint256 b = _b > 0 ? _b : 5;
        return a + b;
    }

    /**
     * @dev Gets the current greeting message.
     * @return The stored greeting string.
     */
    function getGreeting() public view returns (string memory) {
        return greeting;
    }

    /**
     * @dev Gets the stored number.
     * @return The stored number value.
     */
    function getStoredNumber() public view returns (uint256) {
        return storedNumber;
    }
}
