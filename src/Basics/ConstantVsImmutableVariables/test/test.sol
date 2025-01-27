// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract ConstantVsImmutableTest is Test {
    ConstantVsImmutable contractInstance;
    uint256 immutableTestValue = 500;

    function setUp() public {
        // Deploy the contract with an immutable value of 500
        contractInstance = new ConstantVsImmutable(immutableTestValue);
    }

    function testConstantValue() public view {
        uint256 expectedConstant = 100;
        assertEq(contractInstance.getConstantValue(), expectedConstant, "Constant value should be 100");
    }

    function testImmutableValue() public view {
        uint256 deployedValue = contractInstance.getImmutableValue();
        assertEq(deployedValue, immutableTestValue, "Immutable value should match the constructor input");
    }

    function testContractOwner() public view {
        address deployer = address(this);
        assertEq(contractInstance.getOwner(), deployer, "Owner should be set to the contract deployer");
    }

    function testImmutableValuesAfterDeployment() public view {
        uint256 storedValue = contractInstance.getImmutableValue();
        assertEq(storedValue, immutableTestValue, "Immutable value should remain unchanged after deployment");

        address storedOwner = contractInstance.getOwner();
        assertEq(storedOwner, address(this), "Contract owner should not change after deployment");
    }
}
