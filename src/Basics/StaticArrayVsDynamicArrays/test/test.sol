// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract StaticVsDynamicArraysTest is Test {
    StaticVsDynamicArrays private staticVsDynamicArrays;

    function setUp() public {
        // Deploy the contract before each test
        staticVsDynamicArrays = new StaticVsDynamicArrays();
    }

    function testStaticArrayInitialValues() public {
        // Assert initial values of the static array
        for (uint256 i = 0; i < 5; i++) {
            assertEq(staticVsDynamicArrays.getStaticArrayElement(i), i + 1, "Static array element mismatch");
        }
    }

    function testUpdateStaticArray() public {
        // Update a value in the static array
        staticVsDynamicArrays.updateStaticArray(2, 42);

        // Assert the updated value
        assertEq(staticVsDynamicArrays.getStaticArrayElement(2), 42, "Static array element update failed");
    }

    function testStaticArrayLength() public {
        // Assert the static array length
        assertEq(staticVsDynamicArrays.getStaticArrayLength(), 5, "Static array length should be 5");
    }

    function testAddToDynamicArray() public {
        // Add elements to the dynamic array
        staticVsDynamicArrays.addToDynamicArray(10);
        staticVsDynamicArrays.addToDynamicArray(20);

        // Assert the length and values
        assertEq(staticVsDynamicArrays.getDynamicArrayLength(), 2, "Dynamic array length mismatch");
        assertEq(staticVsDynamicArrays.getDynamicArrayElement(0), 10, "Dynamic array element mismatch at index 0");
        assertEq(staticVsDynamicArrays.getDynamicArrayElement(1), 20, "Dynamic array element mismatch at index 1");
    }

    function testRemoveFromDynamicArray() public {
        // Add elements to the dynamic array
        staticVsDynamicArrays.addToDynamicArray(10);
        staticVsDynamicArrays.addToDynamicArray(20);

        // Remove the last element
        staticVsDynamicArrays.removeFromDynamicArray();

        // Assert the length and remaining value
        assertEq(staticVsDynamicArrays.getDynamicArrayLength(), 1, "Dynamic array length mismatch after pop");
        assertEq(staticVsDynamicArrays.getDynamicArrayElement(0), 10, "Dynamic array element mismatch after pop");
    }

    function testDynamicArrayLength() public {
        // Initially, the dynamic array should be empty
        assertEq(staticVsDynamicArrays.getDynamicArrayLength(), 0, "Dynamic array length should initially be 0");

        // Add elements and check length
        staticVsDynamicArrays.addToDynamicArray(5);
        staticVsDynamicArrays.addToDynamicArray(15);
        assertEq(staticVsDynamicArrays.getDynamicArrayLength(), 2, "Dynamic array length mismatch after adding elements");
    }

    function testGetDynamicArrayElement() public {
        // Add elements to the dynamic array
        staticVsDynamicArrays.addToDynamicArray(10);
        staticVsDynamicArrays.addToDynamicArray(20);

        // Assert the values at specific indices
        assertEq(staticVsDynamicArrays.getDynamicArrayElement(0), 10, "Dynamic array element mismatch at index 0");
        assertEq(staticVsDynamicArrays.getDynamicArrayElement(1), 20, "Dynamic array element mismatch at index 1");
    }

    function testGetDynamicArrayElementOutOfBounds() public {
        // Add one element to the dynamic array
        staticVsDynamicArrays.addToDynamicArray(10);

        // Expect revert when accessing out-of-bounds index
        vm.expectRevert("Index out of bounds");
        staticVsDynamicArrays.getDynamicArrayElement(1);
    }
}
