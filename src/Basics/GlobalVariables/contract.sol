// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title GlobalVariables
 * @dev Demonstrates the use of Solidity's globally available variables.
 */
contract GlobalVariables {
    
    // Stores the sender's address
    address public lastCaller;

    // Stores the value sent with the last transaction
    uint256 public lastValueSent;

    // Stores the block timestamp when the last function was called
    uint256 public lastTimestamp;

    // Stores the current block number when the last function was called
    uint256 public lastBlockNumber;

    /**
     * @dev Function to update global variables based on transaction data.
     */
    function updateGlobalVariables() public payable {
        lastCaller = msg.sender;  // The address calling the function
        lastValueSent = msg.value;  // The Ether value sent with the function call
        lastTimestamp = block.timestamp;  // The current block timestamp
        lastBlockNumber = block.number;  // The current block number
    }

    /**
     * @dev Returns transaction details of the last call.
     */
    function getTransactionDetails() public view returns (address, uint256, uint256, uint256) {
        return (lastCaller, lastValueSent, lastTimestamp, lastBlockNumber);
    }

    /**
     * @dev Returns the gas price of the current transaction.
     */
    function getGasPrice() public view returns (uint256) {
        return tx.gasprice;
    }

    /**
     * @dev Returns the remaining gas available for execution.
     */
    function getRemainingGas() public view returns (uint256) {
        return gasleft();
    }

    /**
     * @dev Returns the difficulty of the current block.
     */
    function getBlockDifficulty() public view returns (uint256) {
        return block.prevrandao;
    }

    /**
     * @dev Returns the current chain ID.
     */
    function getChainId() public view returns (uint256) {
        return block.chainid;
    }
}
