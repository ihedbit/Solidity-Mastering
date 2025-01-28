// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title CustomErrors
 * @dev Demonstrates how to use custom error types in Solidity for gas optimization and better debugging.
 */
contract CustomErrors {

    // State variables
    address public owner;
    uint256 public balance;

    /**
     * @dev Custom error definitions for better gas efficiency and debugging.
     */
    error NotOwner(address caller);  // Error when caller is not the owner
    error InsufficientBalance(uint256 available, uint256 required);  // Error for insufficient funds
    error InvalidAmount(uint256 provided);  // Error for invalid amount input

    /**
     * @dev Constructor to set contract deployer as owner and initialize balance.
     */
    constructor() {
        owner = msg.sender;
        balance = 100;  // Initial balance for demonstration
    }

    /**
     * @dev Modifier to restrict function calls to the contract owner.
     */
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner(msg.sender);
        }
        _;
    }

    /**
     * @dev Adds to the balance with a custom error for invalid input.
     * @param _amount The amount to add to the balance.
     */
    function addBalance(uint256 _amount) public onlyOwner {
        if (_amount <= 0) {
            revert InvalidAmount(_amount);
        }
        balance += _amount;
    }

    /**
     * @dev Withdraws a specified amount from the contract balance.
     * @param _amount The amount to withdraw.
     */
    function withdraw(uint256 _amount) public onlyOwner {
        if (_amount > balance) {
            revert InsufficientBalance(balance, _amount);
        }
        balance -= _amount;
    }

    /**
     * @dev Retrieves the current balance.
     * @return uint256 The current contract balance.
     */
    function getBalance() public view returns (uint256) {
        return balance;
    }
}
