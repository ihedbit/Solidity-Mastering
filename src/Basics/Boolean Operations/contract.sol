// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title BooleanOperations
 * @dev Demonstrates the use of boolean operations in Solidity.
 */
contract BooleanOperations {
    
    // State variables
    bool public isContractActive = true;
    bool public isAdmin = false;

    /**
     * @dev Toggles the contract's active status.
     */
    function toggleContractStatus() public {
        isContractActive = !isContractActive;
    }

    /**
     * @dev Sets the admin status.
     * @param _status Boolean value to set admin status.
     */
    function setAdminStatus(bool _status) public {
        isAdmin = _status;
    }

    /**
     * @dev Checks if contract is active and admin is assigned.
     * @return bool True if contract is active and admin exists, otherwise false.
     */
    function isAdminAndActive() public view returns (bool) {
        return isContractActive && isAdmin;
    }

    /**
     * @dev Checks if contract is inactive or admin is assigned.
     * @return bool True if contract is inactive or admin exists, otherwise false.
     */
    function isInactiveOrAdmin() public view returns (bool) {
        return !isContractActive || isAdmin;
    }

    /**
     * @dev Checks if both conditions are false.
     * @return bool True if both contract is inactive and admin does not exist.
     */
    function isNeitherActiveNorAdmin() public view returns (bool) {
        return !isContractActive && !isAdmin;
    }
}