// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract MathOperationsTest is Test {
    MathOperations private mathOps;

    function setUp() public {
        // Deploy the MathOperations contract before each test
        mathOps = new MathOperations();
    }

    function testAddition() public view {
        uint256 result = mathOps.add(10, 15);
        assertEq(result, 25, "10 + 15 should equal 25");
    }

    function testSubtraction() public view {
        uint256 result = mathOps.subtract(20, 5);
        assertEq(result, 15, "20 - 5 should equal 15");
    }

    function testSubtractionUnderflow() public {
        vm.expectRevert("Underflow error: _a should be greater than or equal to _b");
        mathOps.subtract(5, 10);
    }

    function testMultiplication() public view {
        uint256 result = mathOps.multiply(6, 7);
        assertEq(result, 42, "6 * 7 should equal 42");
    }

    function testMultiplicationByZero() public view {
        uint256 result = mathOps.multiply(10, 0);
        assertEq(result, 0, "10 * 0 should equal 0");
    }

    function testDivision() public view {
        uint256 result = mathOps.divide(20, 5);
        assertEq(result, 4, "20 / 5 should equal 4");
    }

    function testDivisionByZero() public {
        vm.expectRevert("Division by zero is not allowed");
        mathOps.divide(10, 0);
    }

    function testModulus() public view {
        uint256 result = mathOps.modulus(10, 3);
        assertEq(result, 1, "10 % 3 should equal 1");
    }

    function testModulusByZero() public {
        vm.expectRevert("Modulo by zero is not allowed");
        mathOps.modulus(10, 0);
    }

    function testZeroAddition() public view {
        uint256 result = mathOps.add(0, 0);
        assertEq(result, 0, "0 + 0 should equal 0");
    }

    function testZeroDivision() public view {
        uint256 result = mathOps.divide(0, 1);
        assertEq(result, 0, "0 / 1 should equal 0");
    }

    function testEdgeCases() public view {
        uint256 maxUint = type(uint256).max;

        uint256 result = mathOps.add(maxUint, 0);
        assertEq(result, maxUint, "Max uint + 0 should equal max uint");

        result = mathOps.multiply(maxUint, 1);
        assertEq(result, maxUint, "Max uint * 1 should equal max uint");
    }
}
