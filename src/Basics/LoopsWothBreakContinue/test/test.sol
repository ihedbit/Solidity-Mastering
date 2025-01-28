// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract LoopsWithBreakContinueTest is Test {
    LoopsWithBreakContinue private loops;

    function setUp() public {
        // Deploy the contract before each test
        loops = new LoopsWithBreakContinue();
    }

    function testPopulateNumbers() public {
        loops.populateNumbers();
        uint256[] memory numbers = loops.getNumbers();

        // Correctly allocate and initialize the `expected` array
        uint256[] memory expected = new uint256[](8);
        expected[0] = 1;
        expected[1] = 2;
        expected[2] = 3;
        expected[3] = 4;
        expected[4] = 6;
        expected[5] = 7;
        expected[6] = 8;
        expected[7] = 9;

        assertEq(numbers.length, expected.length, "Array length mismatch");
        for (uint256 i = 0; i < numbers.length; i++) {
            assertEq(numbers[i], expected[i], "Element mismatch at index");
        }
    }

    function testFindNumberExists() public {
        loops.populateNumbers();
        int256 index = loops.findNumber(6);
        // `6` is at index 4 in [1,2,3,4,6,7,8,9]
        assertEq(index, 4, "Index of 6 should be 4");
    }

    function testFindNumberNotExists() public {
        loops.populateNumbers();
        // We intentionally skip `5` in populateNumbers(), so it won't exist
        int256 index = loops.findNumber(5);
        assertEq(index, -1, "Index of 5 should be -1 (not found)");
    }

    function testCountOddNumbers() public {
        loops.populateNumbers();
        // The final array is [1,2,3,4,6,7,8,9]
        // Odd numbers are 1,3,7,9 => 4 in total
        uint256 oddCount = loops.countOddNumbers();
        assertEq(oddCount, 4, "Odd numbers count should be 4");
    }

    function testGetNumbers() public {
        loops.populateNumbers();
        uint256[] memory numbers = loops.getNumbers();

        // Correctly allocate and initialize the `expected` array
        uint256[] memory expected = new uint256[](8);
        expected[0] = 1;
        expected[1] = 2;
        expected[2] = 3;
        expected[3] = 4;
        expected[4] = 6;
        expected[5] = 7;
        expected[6] = 8;
        expected[7] = 9;

        assertEq(numbers.length, expected.length, "Array length mismatch");
        for (uint256 i = 0; i < numbers.length; i++) {
            assertEq(numbers[i], expected[i], "Element mismatch at index");
        }
    }
}
