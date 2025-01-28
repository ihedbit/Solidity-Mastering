// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title VisibilitySpecifiers
 * @dev Demonstrates the use of public, private, internal, and external access modifiers in Solidity.
 */
contract VisibilitySpecifiers {

    // Public state variable: can be accessed externally and internally
    uint256 public publicVar = 100;

    // Private state variable: accessible only within this contract
    uint256 private privateVar = 200;

    // Internal state variable: accessible within this contract and derived contracts
    uint256 internal internalVar = 300;

    // External function: can only be called from outside the contract
    function setPublicVar(uint256 _value) external {
        publicVar = _value;
    }

    /**
     * @dev Public function - Can be called externally and internally
     */
    function getPublicVar() public view returns (uint256) {
        return publicVar;
    }

    /**
     * @dev Private function - Only accessible within this contract
     */
    function getPrivateVar() private view returns (uint256) {
        return privateVar;
    }

    /**
     * @dev Internal function - Accessible within this contract and derived contracts
     */
    function getInternalVar() internal view returns (uint256) {
        return internalVar;
    }

    /**
     * @dev External function - Can be called externally but not internally
     */
    function getExternalVar() external view returns (uint256) {
        return internalVar + publicVar; // Can access internal and public within the contract
    }

    /**
     * @dev Public function that calls a private function
     */
    function fetchPrivateVar() public view returns (uint256) {
        return getPrivateVar();
    }
}

/**
 * @dev Derived contract to demonstrate `internal` visibility.
 */
contract DerivedVisibility is VisibilitySpecifiers {

    /**
     * @dev Function to access inherited internal variable and function.
     */
    function accessInternal() public view returns (uint256) {
        return getInternalVar();
    }
}
