// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MemoryManagement
 * @dev Demonstrates how memory allocation works in Solidity for efficient contract execution.
 */
contract MemoryManagement {

    /**
     * @dev Demonstrates memory vs. storage behavior with arrays.
     * @param _inputArray An array of uint256 values passed to the function.
     * @return uint256[] Returns a modified copy of the input array.
     */
    function processArray(uint256[] memory _inputArray) public pure returns (uint256[] memory) {
        uint256[] memory tempArray = new uint256[](_inputArray.length);

        for (uint256 i = 0; i < _inputArray.length; i++) {
            tempArray[i] = _inputArray[i] * 2;  // Double each element
        }

        return tempArray;  // Returns the modified array stored in memory
    }

    /**
     * @dev Demonstrates memory vs. storage by modifying a struct.
     */
    struct Data {
        uint256 id;
        string name;
    }

    Data public storedData;

    /**
     * @dev Updates struct data stored in storage.
     * @param _id The new ID value.
     * @param _name The new name value.
     */
    function updateStoredData(uint256 _id, string memory _name) public {
        storedData.id = _id;
        storedData.name = _name;
    }

    /**
     * @dev Demonstrates struct memory allocation without affecting storage.
     * @param _id The ID value.
     * @param _name The name value.
     * @return Data Returns a temporary struct stored in memory.
     */
    function getTemporaryData(uint256 _id, string memory _name) public pure returns (Data memory) {
        Data memory tempData = Data(_id, _name);
        return tempData;
    }

    /**
     * @dev Concatenates two strings using memory allocation.
     * @param _first First string.
     * @param _second Second string.
     * @return string The concatenated result.
     */
    function concatenateStrings(string memory _first, string memory _second) public pure returns (string memory) {
        return string(abi.encodePacked(_first, " ", _second));
    }

    /**
     * @dev Returns a fixed-size memory array.
     */
    function getFixedSizeArray() public pure returns (uint256[3] memory) {
        uint256[3] memory fixedArray = [uint256(10), 20, 30];
        return fixedArray;
    }
}
