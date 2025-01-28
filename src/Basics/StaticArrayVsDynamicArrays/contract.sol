// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title StaticVsDynamicArrays
 * @dev Demonstrates the differences between fixed-size (static) and dynamically sized arrays in Solidity.
 */
contract StaticVsDynamicArrays {

    // Static (fixed-size) array: Size is defined at compile time
    uint256[5] public staticArray = [1, 2, 3, 4, 5];

    // Dynamic array: Can change size during runtime
    uint256[] public dynamicArray;

    /**
     * @dev Updates a value in the static array at a specific index.
     * @param _index The index to update.
     * @param _value The new value to assign.
     */
    function updateStaticArray(uint256 _index, uint256 _value) public {
        require(_index < staticArray.length, "Index out of bounds");
        staticArray[_index] = _value;
    }

    /**
     * @dev Adds a new element to the dynamic array.
     * @param _value The value to add to the array.
     */
    function addToDynamicArray(uint256 _value) public {
        dynamicArray.push(_value);
    }

    /**
     * @dev Removes the last element from the dynamic array.
     */
    function removeFromDynamicArray() public {
        require(dynamicArray.length > 0, "Dynamic array is empty");
        dynamicArray.pop();
    }

    /**
     * @dev Retrieves the length of the static array.
     * @return uint256 Length of the static array.
     */
    function getStaticArrayLength() public pure returns (uint256) {
        return 5;  // Static size is fixed at compile time
    }

    /**
     * @dev Retrieves the length of the dynamic array.
     * @return uint256 Length of the dynamic array.
     */
    function getDynamicArrayLength() public view returns (uint256) {
        return dynamicArray.length;
    }

    /**
     * @dev Returns the value of a static array element at a given index.
     * @param _index The index to fetch.
     * @return uint256 The value at the specified index.
     */
    function getStaticArrayElement(uint256 _index) public view returns (uint256) {
        require(_index < staticArray.length, "Index out of bounds");
        return staticArray[_index];
    }

    /**
     * @dev Returns the value of a dynamic array element at a given index.
     * @param _index The index to fetch.
     * @return uint256 The value at the specified index.
     */
    function getDynamicArrayElement(uint256 _index) public view returns (uint256) {
        require(_index < dynamicArray.length, "Index out of bounds");
        return dynamicArray[_index];
    }
}
