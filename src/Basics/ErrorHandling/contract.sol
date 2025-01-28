// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ErrorHandling
 * @dev Demonstrates the use of require, assert, and revert for error management in Solidity.
 */
contract ErrorHandling {
    
    address public owner;
    uint256 public balance;

    /**
     * @dev Sets the contract deployer as the owner.
     */
    constructor() {
        owner = msg.sender;
        balance = 100;  // Initial balance for demonstration
    }

    /**
     * @dev Modifier to check if the caller is the contract owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    /**
     * @dev Function to update balance with require statement for validation.
     * @param _amount The amount to add.
     */
    function addBalance(uint256 _amount) public {
        require(_amount > 0, "Amount must be greater than zero");
        balance += _amount;
    }

    /**
     * @dev Function to withdraw balance using require to check sufficient funds.
     * @param _amount The amount to withdraw.
     */
    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount <= balance, "Insufficient balance");
        balance -= _amount;
    }

    /**
     * @dev Function using assert to check for internal contract consistency.
     */
    function validateBalance() public view {
        assert(balance >= 0);
    }

    /**
     * @dev Function demonstrating revert statement for complex conditions.
     * @param _condition A boolean condition to trigger revert.
     */
    function customRevert(bool _condition) public pure {
        if (_condition) {
            revert("Custom revert triggered due to the condition being true");
        }
    }

    /**
     * @dev Retrieves the current balance.
     */
    function getBalance() public view returns (uint256) {
        return balance;
    }
}
