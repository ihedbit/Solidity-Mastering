// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MappingWithStructs
 * @dev Demonstrates how to combine mappings with structs to create organized data structures.
 */
contract MappingWithStructs {
    
    // Struct to store user details
    struct User {
        string name;
        uint256 age;
        address walletAddress;
        bool active;
    }

    // Mapping from user address to User struct
    mapping(address => User) private users;

    // Tracks whether a user is registered
    mapping(address => bool) private registered;

    /**
     * @dev Registers a new user with their details.
     * @param _name The name of the user.
     * @param _age The age of the user.
     */
    function registerUser(string memory _name, uint256 _age) public {
        require(!registered[msg.sender], "User already registered");

        users[msg.sender] = User({
            name: _name,
            age: _age,
            walletAddress: msg.sender,
            active: true
        });

        registered[msg.sender] = true;
    }

    /**
     * @dev Retrieves user details by address.
     * @param _userAddress The address of the user to fetch details for.
     * @return name, age, walletAddress, active status of the user.
     */
    function getUser(address _userAddress) public view returns (string memory, uint256, address, bool) {
        require(registered[_userAddress], "User not found");
        User memory user = users[_userAddress];
        return (user.name, user.age, user.walletAddress, user.active);
    }

    /**
     * @dev Updates the age of a registered user.
     * @param _newAge The new age to update.
     */
    function updateAge(uint256 _newAge) public {
        require(registered[msg.sender], "User not registered");
        users[msg.sender].age = _newAge;
    }

    /**
     * @dev Deletes a user from the mapping.
     */
    function deleteUser() public {
        require(registered[msg.sender], "User not registered");
        delete users[msg.sender];
        registered[msg.sender] = false;
    }

    /**
     * @dev Checks if an address is registered as a user.
     * @param _userAddress The address to check.
     * @return bool Whether the user is registered.
     */
    function isUserRegistered(address _userAddress) public view returns (bool) {
        return registered[_userAddress];
    }
}
