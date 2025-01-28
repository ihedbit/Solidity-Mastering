// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SolidityComments
 * @dev Demonstrates best practices for writing single-line and multi-line comments in Solidity.
 */
contract SolidityComments {
    
    // State variable to store contract owner's address
    address public owner;

    // Stores a greeting message
    string public greeting;

    /**
     * @dev Constructor to initialize contract with a greeting message.
     * @param _greeting Initial greeting message.
     */
    constructor(string memory _greeting) {
        owner = msg.sender; // Assign deployer as contract owner
        greeting = _greeting; // Set the initial greeting message
    }

    /**
     * @notice Updates the greeting message.
     * @dev This function allows the contract owner to change the stored greeting message.
     * @param _newGreeting The new greeting message to store.
     */
    function setGreeting(string memory _newGreeting) public onlyOwner {
        greeting = _newGreeting;
    }

    /**
     * @dev Returns the current greeting message.
     * @return The stored greeting string.
     */
    function getGreeting() public view returns (string memory) {
        return greeting; // Return the stored greeting message
    }

    /**
     * @dev Modifier to restrict function access to the contract owner only.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _; // Continue execution of the function
    }
}
