// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract VisibilitySpecifiersTest is Test {
    VisibilitySpecifiers private visibilityContract;
    DerivedVisibility private derivedContract;

    function setUp() public {
        // Deploy both contracts before each test
        visibilityContract = new VisibilitySpecifiers();
        derivedContract = new DerivedVisibility();
    }

    /**
     * @dev Test initial public variable value.
     */
    function testInitialPublicVar() public view {
        // publicVar is initialized to 100
        uint256 initialValue = visibilityContract.publicVar();
        assertEq(initialValue, 100, "publicVar should initially be 100");
    }

    /**
     * @dev Test that we can update publicVar using the external function setPublicVar.
     */
    function testSetPublicVar() public {
        visibilityContract.setPublicVar(555);
        uint256 updatedValue = visibilityContract.publicVar();
        assertEq(updatedValue, 555, "publicVar should be updated to 555");
    }

    /**
     * @dev Test retrieving the public variable using a public function.
     */
    function testGetPublicVar() public view {
        uint256 publicValue = visibilityContract.getPublicVar();
        assertEq(publicValue, 100, "getPublicVar should return 100 by default");
    }

    /**
     * @dev Test that we can call getExternalVar externally to read internal/public variables.
     */
    function testGetExternalVar() public view {
        // getExternalVar = internalVar (300) + publicVar (100) => 400
        uint256 result = visibilityContract.getExternalVar();
        assertEq(result, 400, "getExternalVar should return 400 by default");
    }

    /**
     * @dev Test that private variable can be read through a public wrapper function.
     */
    function testFetchPrivateVar() public view {
        // fetchPrivateVar calls the private function getPrivateVar()
        uint256 privateValue = visibilityContract.fetchPrivateVar();
        // privateVar = 200 by default
        assertEq(privateValue, 200, "Private var should be 200");
    }

    /**
     * @dev Attempting to call the private function or variable directly from the test won't compile;
     *      hence we rely on fetchPrivateVar for testing the private variable.
     */

    /**
     * @dev Validate internal variable usage from the derived contract.
     */
    function testAccessInternalFromDerived() public view {
        // In DerivedVisibility, accessInternal() calls getInternalVar() => 300 by default
        uint256 internalValue = derivedContract.accessInternal();
        assertEq(internalValue, 300, "Internal var should be 300 by default");
    }

    /**
     * @dev Confirm that external function cannot be called from inside this contract directly.
     *      We must do a low-level call or treat it as an external call.
     */
    function testExternalCallAsLowLevel() public  {
        // getExternalVar() is external, so we can't call it by name within the same contract
        // Use a low-level call
        (bool success, bytes memory data) =
            address(visibilityContract).call(abi.encodeWithSelector(visibilityContract.getExternalVar.selector));
        assertTrue(success, "Low-level call to getExternalVar should succeed");

        // Decode the returned value
        uint256 result = abi.decode(data, (uint256));
        assertEq(result, 400, "Result of getExternalVar should be 400");
    }
}