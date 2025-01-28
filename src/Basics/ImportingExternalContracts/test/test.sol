// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";
import "../MathLibrary.sol";

contract ImportingExternalContractsTest is Test {
    ImportingExternalContracts private contractInstance;

    function setUp() public {
        // Deploy the contract before each test
        contractInstance = new ImportingExternalContracts();
    }

    function testOwner() public view {
        address expectedOwner = address(this);
        assertEq(contractInstance.owner(), expectedOwner, "Owner should be the deployer");
    }

    function testAddNumbers() public view {
        uint256 a = 10;
        uint256 b = 15;

        uint256 result = contractInstance.addNumbers(a, b);
        assertEq(result, 25, "Addition result should be 25");
    }

    function testSubtractNumbers() public view {
        uint256 a = 20;
        uint256 b = 10;

        uint256 result = contractInstance.subtractNumbers(a, b);
        assertEq(result, 10, "Subtraction result should be 10");
    }

    function testSubtractNumbersFailsOnUnderflow() public {
        uint256 a = 10;
        uint256 b = 20;

        // Expect a revert due to underflow handled in MathLibrary
        vm.expectRevert(abi.encodeWithSelector(MathLibrary.SubtractionUnderflow.selector, "Math: subtraction underflow"));
        contractInstance.subtractNumbers(a, b);
    }

}
