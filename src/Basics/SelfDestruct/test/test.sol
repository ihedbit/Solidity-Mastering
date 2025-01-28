// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract SelfDestructAlternativeTest is Test {
    SelfDestructAlternative private selfDestructAlt;
    address private owner;
    address private recipient;
    address private nonOwner;

    function setUp() public {
        // Assign test addresses
        owner = address(this);
        recipient = address(0x1234);
        nonOwner = address(0x5678);

        // Fund the test addresses
        vm.deal(owner, 10 ether);
        vm.deal(nonOwner, 5 ether);

        // Deploy the contract
        selfDestructAlt = new SelfDestructAlternative();

        // Sanity check
        assertEq(selfDestructAlt.owner(), owner, "Owner should be set to deploying address");
        assertTrue(selfDestructAlt.isActive(), "Contract should start active");
    }

    /**
     * @dev Test initial state (owner and isActive).
     */
    function testInitialState() public {
        assertEq(selfDestructAlt.owner(), owner, "Owner should be correct");
        assertTrue(selfDestructAlt.isActive(), "Contract should initially be active");
    }

    /**
     * @dev Test depositing Ether into contract via receive().
     */
    function testDeposit() public {
        // Send 2 ETH from owner to contract
        vm.prank(owner);
        (bool success, ) = address(selfDestructAlt).call{value: 2 ether}("");
        assertTrue(success, "Deposit transaction should succeed");

        uint256 contractBalance = selfDestructAlt.getBalance();
        assertEq(contractBalance, 2 ether, "Contract balance should be 2 ETH");
    }

    /**
     * @dev Test withdrawing funds to a valid recipient as owner.
     */
    function testWithdrawFunds() public {
        // Deposit 3 ETH
        vm.prank(owner);
        (bool success, ) = address(selfDestructAlt).call{value: 3 ether}("");
        assertTrue(success, "Deposit transaction should succeed");

        // Check balance
        assertEq(selfDestructAlt.getBalance(), 3 ether, "Contract balance should be 3 ETH");

        // Withdraw to recipient
        vm.prank(owner);
        selfDestructAlt.withdrawFunds(payable(recipient));

        // Contract should be zero; recipient up by 3 ETH
        assertEq(selfDestructAlt.getBalance(), 0, "Contract balance should be 0 after withdrawal");
        assertEq(recipient.balance, 3 ether, "Recipient should have received 3 ETH");
    }

    /**
     * @dev Test withdrawing funds fails if caller is not owner.
     */
    function testWithdrawFailsWhenNotOwner() public {
        // Deposit 1 ETH from the owner
        vm.prank(owner);
        address(selfDestructAlt).call{value: 1 ether}("");

        // Attempt withdrawal from a non-owner
        vm.prank(nonOwner);
        vm.expectRevert("Not the contract owner");
        selfDestructAlt.withdrawFunds(payable(recipient));
    }

    /**
     * @dev Test withdrawing fails if no funds are available.
     */
    function testWithdrawFailsWhenNoFunds() public {
        // Attempt withdrawal with zero balance
        vm.prank(owner);
        vm.expectRevert("No funds available");
        selfDestructAlt.withdrawFunds(payable(recipient));
    }

    /**
     * @dev Test deactivating the contract prevents further withdrawals.
     */
    function testDeactivateContractPreventsWithdraw() public {
        // Deposit 2 ETH from the owner
        vm.prank(owner);
        address(selfDestructAlt).call{value: 2 ether}("");

        // Deactivate the contract
        vm.prank(owner);
        selfDestructAlt.deactivateContract();

        // Attempt to withdraw after deactivation
        vm.prank(owner);
        vm.expectRevert("Contract is inactive");
        selfDestructAlt.withdrawFunds(payable(recipient));
    }

    /**
     * @dev Test that only the owner can deactivate the contract.
     */
    function testOnlyOwnerCanDeactivate() public {
        // Attempt to deactivate from non-owner
        vm.prank(nonOwner);
        vm.expectRevert("Not the contract owner");
        selfDestructAlt.deactivateContract();

        // Confirm it's still active
        assertTrue(selfDestructAlt.isActive(), "Contract should still be active");

        // Deactivate from the owner
        vm.prank(owner);
        selfDestructAlt.deactivateContract();
        assertFalse(selfDestructAlt.isActive(), "Contract should be inactive");
    }
}
