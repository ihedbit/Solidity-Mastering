// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title LoopsWithBreakContinue
 * @dev Demonstrates the use of break and continue statements in Solidity loops.
 */
contract LoopsWithBreakContinue {

    uint256[] public numbers;

    /**
     * @dev Adds numbers to the array, skips number 5, and stops when it reaches 10.
     */
    function populateNumbers() public {
        delete numbers;  // Reset the array

        for (uint256 i = 1; i <= 15; i++) {
            if (i == 5) {
                continue;  // Skip number 5
            }
            if (i == 10) {
                break;  // Stop the loop when i reaches 10
            }
            numbers.push(i);
        }
    }

    /**
     * @dev Finds the first occurrence of a number in the array and returns its index.
     * @param _value The number to find.
     * @return uint256 Index of the value or -1 if not found.
     */
    function findNumber(uint256 _value) public view returns (int256) {
        for (uint256 i = 0; i < numbers.length; i++) {
            if (numbers[i] == _value) {
                return int256(i);  // Found, return the index
            }
        }
        return -1;  // Not found
    }

    /**
     * @dev Skips even numbers and counts odd numbers in the array.
     * @return uint256 The count of odd numbers.
     */
    function countOddNumbers() public view returns (uint256) {
        uint256 count = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                continue;  // Skip even numbers
            }
            count++;  // Increment count for odd numbers
        }
        return count;
    }

    /**
     * @dev Returns the full list of stored numbers.
     * @return uint256[] The numbers in the array.
     */
    function getNumbers() public view returns (uint256[] memory) {
        return numbers;
    }
}
