// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ERC20Token
 * @dev A basic implementation of the ERC20 Token standard.
 */
contract ERC20Token {
    // Public state variables for readability
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    // Mappings to track balances and allowances
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Events as required by the ERC20 standard
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Constructor to initialize the token with a name, symbol, decimals, and initial supply.
     * @param _name The name of your token, e.g., \"MyToken\"
     * @param _symbol The symbol of your token, e.g., \"MTK\"
     * @param _decimals Number of decimal places your token uses (commonly 18)
     * @param _initialSupply The initial supply of tokens (in whole units, without decimals)
     *
     * Example:
     *  - If _initialSupply = 1000000 and _decimals = 18, totalSupply = 1000000 * 10^18.
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;

        // Set the totalSupply and assign all tokens to contract deployer
        totalSupply = _initialSupply * (10 ** uint256(_decimals));
        balanceOf[msg.sender] = totalSupply;

        // Emit a Transfer event from address(0) to mark the creation of tokens
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    /**
     * @dev Transfer tokens from the caller to a recipient.
     * @param _to The recipient address.
     * @param _value The amount of tokens to transfer (in smallest units).
     */
    function transfer(address _to, uint256 _value) external returns (bool) {
        require(_to != address(0), "ERC20: transfer to the zero address");
        require(balanceOf[msg.sender] >= _value, "ERC20: insufficient balance");

        // Adjust balances
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        // Emit event
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * @dev Approve a spender to transfer tokens from your account.
     * @param _spender The address allowed to spend your tokens.
     * @param _value The amount of tokens they can spend (in smallest units).
     */
    function approve(address _spender, uint256 _value) external returns (bool) {
        require(_spender != address(0), "ERC20: approve to the zero address");

        // Set the allowance
        allowance[msg.sender][_spender] = _value;

        // Emit event
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * @dev Transfer tokens on behalf of another address, if allowed.
     * @param _from The address from which tokens are to be transferred.
     * @param _to The address to which tokens will be sent.
     * @param _value The amount of tokens to transfer (in smallest units).
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool) {
        require(_to != address(0), "ERC20: transfer to the zero address");
        require(balanceOf[_from] >= _value, "ERC20: insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "ERC20: allowance exceeded");

        // Adjust balances and allowance
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;

        // Emit event
        emit Transfer(_from, _to, _value);
        return true;
    }
}
