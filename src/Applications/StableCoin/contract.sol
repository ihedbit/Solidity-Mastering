// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Blocklist} from "@openzeppelin/community-contracts/contracts/token/ERC20/extensions/ERC20Blocklist.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {ERC20Votes} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {Nonces} from "@openzeppelin/contracts/utils/Nonces.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact ihedbit@gmail.com
contract HEDStableCoin is ERC20, ERC20Blocklist, Ownable, ERC20Permit, ERC20Votes {
    constructor(address initialOwner)
        ERC20("HED StableCoin", "USDH")
        Ownable(initialOwner)
        ERC20Permit("HED StableCoin")
    {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function blockUser(address user) public onlyOwner {
        _blockUser(user);
    }

    function unblockUser(address user) public onlyOwner {
        _unblockUser(user);
    }

    function clock() public view override returns (uint48) {
        return uint48(block.timestamp);
    }

    // solhint-disable-next-line func-name-mixedcase
    function CLOCK_MODE() public pure override returns (string memory) {
        return "mode=timestamp";
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Blocklist, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function _approve(address owner, address spender, uint256 value, bool emitEvent)
        internal
        override(ERC20, ERC20Blocklist)
    {
        super._approve(owner, spender, value, emitEvent);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}
