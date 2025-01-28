// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract VersionExampleTest is Test {
    VersionExample private versionExample;

    function setUp() public {
        // Deploy the contract before each test
        versionExample = new VersionExample();
    }

    function testInitialVersion() public {
        // Verify that the initial version is set to 1
        assertEq(versionExample.ver(), 1, "Initial version should be 1");
    }
}
