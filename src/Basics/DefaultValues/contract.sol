// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title DefaultValues
 * @dev Demonstrates default initialization values for various Solidity data types.
 */
contract DefaultValues {
    
    // Default values of different Solidity data types
    bool public defaultBool;               // false
    uint256 public defaultUint;            // 0
    int256 public defaultInt;              // 0
    address public defaultAddress;         // 0x0000000000000000000000000000000000000000
    bytes32 public defaultBytes32;         // 0x0000000000000000000000000000000000000000000000000000000000000000
    string public defaultString;           // ""
    bytes public defaultBytes;             // ""
    mapping(address => uint256) public defaultMapping; // default value for any key is 0
    uint256[] private defaultArray;        // Dynamically sized array

    /**
     * @dev Returns the length of the default array.
     * @return uint256 Length of the array.
     */
    function getDefaultArrayLength() public view returns (uint256) {
        return defaultArray.length;
    }

    /**
     * @dev Returns the default value of an uninitialized local variable.
     * @return uint256 Default value of a local variable.
     */
    function getLocalVariableDefault() public pure returns (uint256) {
        uint256 localVar;  // Uninitialized local variable defaults to 0
        return localVar;
    }

    /**
     * @dev Checks if a dynamically-sized array is empty.
     * @return bool True if empty, false otherwise.
     */
    function isDefaultArrayEmpty() public view returns (bool) {
        return defaultArray.length == 0;
    }

    /**
     * @dev Checks the default value of a mapping key.
     * @param _addr Address to check in the mapping.
     * @return uint256 The default value associated with the key.
     */
    function getDefaultMappingValue(address _addr) public view returns (uint256) {
        return defaultMapping[_addr];
    }
}
