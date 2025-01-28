// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title EventIndexedParameters
 * @dev Demonstrates the use of indexed parameters in events for efficient filtering in transaction logs.
 */
contract EventIndexedParameters {
    
    // Define an event with indexed parameters for efficient filtering
    event UserRegistered(address indexed userAddress, uint256 indexed userId, string userName);
    event FundsDeposited(address indexed depositor, uint256 amount);
    event FundsWithdrawn(address indexed withdrawer, uint256 amount);
    
    struct User {
        string name;
        uint256 id;
    }

    mapping(address => User) public users;
    mapping(address => uint256) public balances;
    uint256 private userIdCounter;

    /**
     * @dev Registers a new user and emits an event with indexed parameters.
     * @param _name The name of the user.
     */
    function registerUser(string memory _name) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(users[msg.sender].id == 0, "User already registered");

        userIdCounter++;
        users[msg.sender] = User(_name, userIdCounter);

        emit UserRegistered(msg.sender, userIdCounter, _name);
    }

    /**
     * @dev Deposits funds to the user's balance and emits an event.
     */
    function depositFunds() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;

        emit FundsDeposited(msg.sender, msg.value);
    }

    /**
     * @dev Withdraws funds from the user's balance and emits an event.
     * @param _amount The amount to withdraw.
     */
    function withdrawFunds(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        emit FundsWithdrawn(msg.sender, _amount);
    }

    /**
     * @dev Retrieves the user's information.
     * @param _userAddress The address of the user.
     * @return string The user's name.
     * @return uint256 The user's ID.
     */
    function getUser(address _userAddress) public view returns (string memory, uint256) {
        User memory user = users[_userAddress];
        return (user.name, user.id);
    }

    /**
     * @dev Gets the balance of a user.
     * @param _userAddress The address of the user.
     * @return uint256 The user's balance.
     */
    function getBalance(address _userAddress) public view returns (uint256) {
        return balances[_userAddress];
    }
}
