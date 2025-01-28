// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title DynamicDataStructures
 * @dev Demonstrates dynamic mappings and nested mappings in Solidity.
 */
contract DynamicDataStructures {

    // Mapping of addresses to their balance (dynamic mapping)
    mapping(address => uint256) public balances;

    // Nested mapping: mapping from an address to another mapping of uint256 to string
    mapping(address => mapping(uint256 => string)) private userNotes;

    // Nested mapping to track allowances (e.g. ERC20 style)
    mapping(address => mapping(address => uint256)) public allowances;

    /**
     * @dev Deposits Ether and updates the user's balance.
     */
    function deposit() public payable {
        require(msg.value > 0, "Must deposit more than zero");
        balances[msg.sender] += msg.value;
    }

    /**
     * @dev Retrieves the balance of a given address.
     * @param _account The address whose balance is to be checked.
     * @return uint256 The balance of the specified address.
     */
    function getBalance(address _account) public view returns (uint256) {
        return balances[_account];
    }

    /**
     * @dev Adds a note for a user using nested mappings.
     * @param _index The index to store the note under.
     * @param _note The content of the note.
     */
    function addUserNote(uint256 _index, string memory _note) public {
        userNotes[msg.sender][_index] = _note;
    }

    /**
     * @dev Retrieves a stored note for a user.
     * @param _account The address of the user.
     * @param _index The index of the note.
     * @return string The note stored at the given index.
     */
    function getUserNote(address _account, uint256 _index) public view returns (string memory) {
        return userNotes[_account][_index];
    }

    /**
     * @dev Sets allowance for a spender to use a specific amount of tokens on behalf of the owner.
     * @param _spender The address that will be allowed to spend.
     * @param _amount The amount allowed to spend.
     */
    function setAllowance(address _spender, uint256 _amount) public {
        allowances[msg.sender][_spender] = _amount;
    }

    /**
     * @dev Gets the allowance for a spender.
     * @param _owner The address of the funds owner.
     * @param _spender The address that is allowed to spend.
     * @return uint256 The amount allowed.
     */
    function getAllowance(address _owner, address _spender) public view returns (uint256) {
        return allowances[_owner][_spender];
    }

    /**
     * @dev Transfers Ether from sender to a recipient if sufficient balance is available.
     * @param _to The recipient's address.
     * @param _amount The amount to transfer.
     */
    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
