// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title DynamicContractDeployer
 * @dev Provides functionality to dynamically deploy smart contracts using raw bytecode.
 */
contract DynamicContractDeployer {
    event ContractDeployed(address indexed deployedAddress);

    /**
     * @dev Deploys a contract dynamically using raw bytecode.
     * @param _bytecode The contract's bytecode to deploy.
     * @return deployedAddress The address of the deployed contract.
     */
    function deployContract(bytes memory _bytecode) public returns (address deployedAddress) {
        require(_bytecode.length > 0, "Bytecode cannot be empty");

        assembly {
            deployedAddress := create(0, add(_bytecode, 0x20), mload(_bytecode))
            if iszero(deployedAddress) {
                revert(0, 0)
            }
        }

        emit ContractDeployed(deployedAddress);
    }

    /**
     * @dev Deploys a contract deterministically using CREATE2 opcode.
     * @param _bytecode The contract's bytecode to deploy.
     * @param _salt A unique salt to allow deterministic address calculation.
     * @return deployedAddress The address of the deployed contract.
     */
    function deployContractDeterministic(bytes memory _bytecode, bytes32 _salt) public returns (address deployedAddress) {
        require(_bytecode.length > 0, "Bytecode cannot be empty");

        assembly {
            deployedAddress := create2(0, add(_bytecode, 0x20), mload(_bytecode), _salt)
            if iszero(deployedAddress) {
                revert(0, 0)
            }
        }

        emit ContractDeployed(deployedAddress);
    }

    /**
     * @dev Computes the deterministic address for a contract before deployment using CREATE2.
     * @param _deployer The address deploying the contract.
     * @param _bytecode The contract's bytecode to deploy.
     * @param _salt A unique salt to allow deterministic address calculation.
     * @return predictedAddress The computed contract address.
     */
    function computeContractAddress(address _deployer, bytes memory _bytecode, bytes32 _salt) public pure returns (address predictedAddress) {
        bytes32 bytecodeHash = keccak256(_bytecode);
        predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            _deployer,
            _salt,
            bytecodeHash
        )))));
    }
}
