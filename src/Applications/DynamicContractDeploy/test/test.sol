// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

/**
 * @title DynamicContractDeployerTest
 * @dev Tests for the DynamicContractDeployer contract.
 */
contract DynamicContractDeployerTest is Test {
    DynamicContractDeployer private deployer;
    bytes private testBytecode;
    bytes32 private salt;

    function setUp() public {
        // Deploy the DynamicContractDeployer contract
        deployer = new DynamicContractDeployer();

        // Example contract bytecode: A simple contract that does nothing
        testBytecode = hex"6080604052348015600f57600080fd5b5060c08061001e6000396000f3fe6080604052600080fdfea26469706673582212206d3a3f8d3f8b7c9e4b95d8c931a9d36f68e8fdc041ec129a07b8ec0dcb9dcb1c64736f6c63430008060033";

        // Set a deterministic salt for CREATE2 deployments
        salt = keccak256(abi.encodePacked("test-salt"));
    }

    function testDeployContract() public {
        // Deploy contract dynamically
        address deployedAddress = deployer.deployContract(testBytecode);
        
        // Verify that the contract was deployed successfully
        assertTrue(deployedAddress.code.length > 0, "Contract should be deployed");
    }

    function testDeployContractDeterministic() public {
        // Compute the expected contract address using this contract's address as deployer
        address expectedAddress = deployer.computeContractAddress(
            address(deployer),  // ✅ Use the actual deployer address
            testBytecode,
            salt
        );

        // Deploy the contract deterministically using CREATE2
        address deployedAddress = deployer.deployContractDeterministic(testBytecode, salt);

        // ✅ Ensure that deployed address matches computed address
        assertEq(deployedAddress, expectedAddress, "Deployed address should match computed address");

        // ✅ Ensure the contract was successfully deployed
        assertTrue(deployedAddress.code.length > 0, "Contract should be deployed");
    }

    function testComputeContractAddress() public {
        // Compute predicted address
        address predictedAddress = deployer.computeContractAddress(address(this), testBytecode, salt);

        // Ensure the computed address is valid
        assertTrue(predictedAddress != address(0), "Predicted address should not be zero");
    }
}
