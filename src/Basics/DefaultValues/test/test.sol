// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract DefaultValuesTest is Test {
    DefaultValues private defaultValues;

    function setUp() public {
        // Deploy the contract before each test
        defaultValues = new DefaultValues();
    }

    function testDefaultBool() public view {
        assertFalse(defaultValues.defaultBool(), "Default value of bool should be false");
    }

    function testDefaultUint() public view {
        assertEq(defaultValues.defaultUint(), 0, "Default value of uint256 should be 0");
    }

    function testDefaultInt() public view {
        assertEq(defaultValues.defaultInt(), 0, "Default value of int256 should be 0");
    }

    function testDefaultAddress() public view {
        assertEq(defaultValues.defaultAddress(), address(0), "Default value of address should be 0x0000000000000000000000000000000000000000");
    }

    function testDefaultBytes32() public view {
        assertEq(defaultValues.defaultBytes32(), bytes32(0), "Default value of bytes32 should be 0x000...000");
    }

    function testDefaultString() public view {
        assertEq(defaultValues.defaultString(), "", "Default value of string should be an empty string");
    }

    function testDefaultBytes() public view {
        bytes memory emptyBytes;
        assertEq(defaultValues.defaultBytes(), emptyBytes, "Default value of bytes should be an empty byte array");
    }

    function testDefaultMapping() public view {
        address randomAddress = address(0x1234);
        assertEq(defaultValues.getDefaultMappingValue(randomAddress), 0, "Default value of a mapping key should be 0");
    }

    function testDefaultArrayLength() public view  {
        uint256 defaultArrayLength = defaultValues.getDefaultArrayLength();
        assertEq(defaultArrayLength, 0, "Default length of a dynamically-sized array should be 0");
    }

    function testLocalVariableDefault() public view 
    {
        uint256 localVarDefault = defaultValues.getLocalVariableDefault();
        assertEq(localVarDefault, 0, "Default value of an uninitialized local variable should be 0");
    }

    function testIsDefaultArrayEmpty() public view {
        assertTrue(defaultValues.isDefaultArrayEmpty(), "Default array should be empty");
    }
}
