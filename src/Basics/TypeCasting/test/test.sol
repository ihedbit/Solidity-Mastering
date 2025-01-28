// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract TypeCastingTest is Test {
    TypeCasting private typeCasting;

    function setUp() public {
        // Deploy the contract before each test
        typeCasting = new TypeCasting();
    }

    function testCastUint256ToUint8() public {
        // Overflow for uint8 (max 255)
        uint256 input = 300;
        typeCasting.castUint256ToUint8(input);

        // 300 mod 256 = 44 => that’s what gets stored in a uint8
        assertEq(typeCasting.smallNumber(), uint8(input), "Casting uint256 to uint8 did not overflow correctly");
    }

    function testCastInt256ToUint256() public {
        // Negative value => large positive when cast to uint256
        int256 input = -100;
        typeCasting.castInt256ToUint256(input);

        // The result is 2^256 - 100
        uint256 expected = type(uint256).max - 99; // max = (2^256 - 1), so max - 99 = 2^256 - 100
        assertEq(typeCasting.largeNumber(), expected, "Casting negative int256 to uint256 failed");
    }

    function testCastUint256ToBool() public {
        // Zero => false
        typeCasting.castUint256ToBool(0);
        assertFalse(typeCasting.isPositive(), "0 should cast to false");

        // Non-zero => true
        typeCasting.castUint256ToBool(12345);
        assertTrue(typeCasting.isPositive(), "Non-zero should cast to true");
    }

    function testCastBytesToUint256() public {
        // Encode a small number as bytes
        bytes memory input = abi.encodePacked(uint256(12345));
        uint256 result = typeCasting.castBytesToUint256(input);

        assertEq(result, 12345, "Casting bytes to uint256 failed");
    }

    function testCastAddressToUint160() public {
        // Use a checksummed address
        address testAddress = address(0x1234567890AbcdEF1234567890aBcdef12345678);
        uint160 castResult = typeCasting.castAddressToUint160(testAddress);

        assertEq(castResult, uint160(testAddress), "Casting address to uint160 failed");
    }

    function testDemonstrateCasting() public {
        // This function returns two values:
        // 1) casting uint8(255) => uint256
        // 2) casting int256(-100) => uint256
        (uint256 b, uint256 d) = typeCasting.demonstrateCasting();

        // b = 255
        assertEq(b, 255, "Implicit casting from uint8 to uint256 failed");

        // d = 2^256 - 100
        uint256 expected = type(uint256).max - 99;
        assertEq(d, expected, "Explicit casting from int256 to uint256 failed");
    }
}
