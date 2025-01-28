// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract GlobalVariablesTest is Test {
    GlobalVariables private globalVariables;
    address private user = address(0x123);

    function setUp() public {
        // Deploy the contract before each test
        globalVariables = new GlobalVariables();
        vm.deal(user, 10 ether); // Assign some Ether to the test user
    }

    function testUpdateGlobalVariables() public {
        // Prank as the test user and send 1 ether
        vm.prank(user);
        globalVariables.updateGlobalVariables{value: 1 ether}();

        // Validate global variables
        (address lastCaller, uint256 lastValueSent, uint256 lastTimestamp, uint256 lastBlockNumber) =
            globalVariables.getTransactionDetails();

        assertEq(lastCaller, user, "Last caller should match the user address");
        assertEq(lastValueSent, 1 ether, "Last value sent should be 1 ether");
        assertEq(lastTimestamp, block.timestamp, "Last timestamp should match the current block timestamp");
        assertEq(lastBlockNumber, block.number, "Last block number should match the current block number");
    }

    function testGetTransactionDetails() public {
        vm.prank(user);
        globalVariables.updateGlobalVariables{value: 1 ether}();

        (address lastCaller, uint256 lastValueSent, uint256 lastTimestamp, uint256 lastBlockNumber) =
            globalVariables.getTransactionDetails();

        assertEq(lastCaller, user, "Transaction details should return the correct caller");
        assertEq(lastValueSent, 1 ether, "Transaction details should return the correct value sent");
        assertEq(lastTimestamp, block.timestamp, "Transaction details should return the correct timestamp");
        assertEq(lastBlockNumber, block.number, "Transaction details should return the correct block number");
    }

    function testGetGasPrice() public view {
        uint256 gasPrice = tx.gasprice;

        uint256 contractGasPrice = globalVariables.getGasPrice();
        assertEq(contractGasPrice, gasPrice, "Gas price should match the transaction gas price");
    }

    function testGetRemainingGas() public view {
        uint256 initialGas = gasleft();

        uint256 remainingGas = globalVariables.getRemainingGas();
        assertGt(initialGas, remainingGas, "Remaining gas should be less than initial gas");
    }

    function testGetBlockDifficulty() public view {
        uint256 blockDifficulty = block.prevrandao;

        uint256 contractDifficulty = globalVariables.getBlockDifficulty();
        assertEq(contractDifficulty, blockDifficulty, "Block difficulty should match the current block difficulty");
    }

    function testGetChainId() public view {
        uint256 chainId = block.chainid;

        uint256 contractChainId = globalVariables.getChainId();
        assertEq(contractChainId, chainId, "Chain ID should match the current chain ID");
    }
}
