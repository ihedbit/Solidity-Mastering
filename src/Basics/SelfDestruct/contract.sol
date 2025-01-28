// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelfDestructAlternative {
    address public owner;
    bool public isActive = true;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    modifier contractActive() {
        require(isActive, "Contract is inactive");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdrawFunds(address payable _recipient) public onlyOwner contractActive {
        require(_recipient != address(0), "Invalid recipient address");
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available");
        (bool success, ) = _recipient.call{value: balance}("");
        require(success, "Transfer failed");
    }

    function deactivateContract() public onlyOwner {
        isActive = false;
    }
}
