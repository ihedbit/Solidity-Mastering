// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title EtherWallet
 * @dev A simple smart contract wallet for storing and transferring Ether securely.
 */
contract EtherWallet {
    address public owner;
    bool public isDestroyed = false;

    /**
     * @dev Modifier to restrict functions to the contract owner only.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    /**
     * @dev Modifier to check if the contract is active.
     */
    modifier contractActive() {
        require(!isDestroyed, "Contract is destroyed");
        _;
    }

    /**
     * @dev Sets the contract deployer as the owner upon deployment.
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Fallback function to receive Ether.
     */
    receive() external payable contractActive {}

    /**
     * @dev Function to deposit Ether into the wallet.
     */
    function deposit() public payable contractActive {
        require(msg.value > 0, "Deposit amount must be greater than zero");
    }

    /**
     * @dev Transfers Ether from the contract to a specified recipient.
     * @param _to The recipient address.
     * @param _amount The amount to transfer (in wei).
     */
    function transfer(address payable _to, uint256 _amount) public onlyOwner contractActive {
        require(address(this).balance >= _amount, "Insufficient balance");
        require(_to != address(0), "Invalid recipient address");

        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");
    }

    /**
     * @dev Retrieves the contract's Ether balance.
     * @return uint256 The balance of the wallet in wei.
     */
    function getBalance() public view contractActive returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev Allows the owner to withdraw all Ether from the wallet.
     */
    function withdrawAll() public onlyOwner contractActive {
        payable(owner).transfer(address(this).balance);
    }

    /**
     * @dev Disables the contract by withdrawing all funds and marking it as destroyed.
     */
    function disableWallet() public onlyOwner contractActive {
        payable(owner).transfer(address(this).balance);
        isDestroyed = true;
    }
}
