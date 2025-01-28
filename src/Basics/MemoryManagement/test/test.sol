// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract MemoryManagementTest is Test {
    MemoryManagement private memoryMgmt;

    function setUp() public {
        // Deploy the MemoryManagement contract before each test
        memoryMgmt = new MemoryManagement();
    }

    function testProcessArray() public  view {
        // Declare and initialize input array
        uint256[] memory input = new uint256[](3);
        input[0] = 1;
        input[1] = 2;
        input[2] = 3;

        // Declare and initialize expected output array
        uint256[] memory expected = new uint256[](3);
        expected[0] = 2;
        expected[1] = 4;
        expected[2] = 6;

        // Process the input array through the contract
        uint256[] memory result = memoryMgmt.processArray(input);

        // Assert results
        assertEq(result.length, expected.length, "Array lengths should match");
        for (uint256 i = 0; i < result.length; i++) {
            assertEq(result[i], expected[i], "Array element mismatch at index");
        }
    }

    function testUpdateStoredData() public {
        // Update the stored struct data
        memoryMgmt.updateStoredData(123, "TestName");

        // Destructure the two fields returned by the auto-generated getter
        (uint256 id, string memory name) = memoryMgmt.storedData();

        // Validate
        assertEq(id, 123, "ID should match the updated value");
        assertEq(name, "TestName", "Name should match the updated value");
    }


    function testGetTemporaryData() public view {
        // Retrieve a temporary struct
        MemoryManagement.Data memory temp = memoryMgmt.getTemporaryData(42, "TemporaryStruct");

        // Assert the struct fields
        assertEq(temp.id, 42, "ID should match the provided value");
        assertEq(temp.name, "TemporaryStruct", "Name should match the provided value");
    }

    function testConcatenateStrings() public view {
        // Concatenate two strings
        string memory result = memoryMgmt.concatenateStrings("Hello", "World");

        // Assert the concatenated result
        assertEq(result, "Hello World", "Concatenated result should match");
    }

    function testGetFixedSizeArray() public view {
        // Retrieve the fixed-size array
        uint256[3] memory result = memoryMgmt.getFixedSizeArray();

        // Assert the array values
        assertEq(result[0], 10, "First element should be 10");
        assertEq(result[1], 20, "Second element should be 20");
        assertEq(result[2], 30, "Third element should be 30");
    }
}
