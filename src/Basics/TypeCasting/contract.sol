// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title TypeCasting
 * @dev Demonstrates type casting between different Solidity data types.
 */
contract TypeCasting {

    // State variables
    uint256 public largeNumber = 1000;
    uint8 public smallNumber;
    int256 public signedNumber = -500;
    bool public isPositive;

    /**
     * @dev Converts a uint256 to uint8
     */
    function castUint256ToUint8(uint256 _value) public {
        smallNumber = uint8(_value);
    }

    /**
     * @dev Converts an int256 to uint256
     */
    function castInt256ToUint256(int256 _value) public {
        largeNumber = uint256(_value);
    }

    /**
     * @dev Converts a uint256 to boolean
     */
    function castUint256ToBool(uint256 _value) public {
        isPositive = (_value > 0);
    }

    /**
     * @dev Casts bytes to uint256
     */
    function castBytesToUint256(bytes memory _data) public pure returns (uint256) {
        return uint256(bytes32(_data));
    }

    /**
     * @dev Casts address to uint160
     */
    function castAddressToUint160(address _addr) public pure returns (uint160) {
        return uint160(_addr);
    }

    /**
     * @dev Demonstrates implicit and explicit casting of data types
     */
    function demonstrateCasting() public pure returns (uint256, uint256) {
        uint8 a = 255;
        uint256 b = uint256(a);  // Implicit casting from uint8 to uint256

        int256 c = -100;
        uint256 d = uint256(c);  // Explicit casting from int256 to uint256

        return (b, d);
    }

}
