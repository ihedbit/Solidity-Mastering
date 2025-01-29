// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract ERC20TokenTest is Test {
    ERC20Token private token;
    address private deployer;
    address private user1;
    address private user2;
    uint256 private initialSupply = 1_000_000 * (10 ** 18); // 1 million tokens with 18 decimals

    function setUp() public {
        deployer = address(0x1);
        user1 = address(0x2);
        user2 = address(0x3);

        // Deploy the ERC20 token contract with deployer as msg.sender
        vm.prank(deployer);
        token = new ERC20Token("TestToken", "TTK", 18, 1_000_000);
    }

    function testDeployment() public {
        assertEq(token.name(), "TestToken", "Incorrect token name");
        assertEq(token.symbol(), "TTK", "Incorrect token symbol");
        assertEq(token.decimals(), 18, "Incorrect token decimals");
        assertEq(token.totalSupply(), initialSupply, "Incorrect total supply");
        assertEq(token.balanceOf(deployer), initialSupply, "Deployer should have full supply");
    }

    function testTransferSuccess() public {
        uint256 transferAmount = 100 * (10 ** 18);

        // Fund deployer for gas transactions
        vm.deal(deployer, 10 ether);
        vm.startPrank(deployer);

        // Transfer from deployer to user1
        bool success = token.transfer(user1, transferAmount);
        assertTrue(success, "Transfer should succeed");
        assertEq(token.balanceOf(user1), transferAmount, "User1 balance should match transfer amount");
        assertEq(token.balanceOf(deployer), initialSupply - transferAmount, "Deployer balance should decrease");
    }

    function testFailTransferExceedingBalance() public {
        uint256 transferAmount = initialSupply + 1;
        vm.prank(user1);
        token.transfer(user2, transferAmount); // ❌ Should fail: User1 has 0 balance
    }

    function testApproveAndTransferFrom() public {
        uint256 allowanceAmount = 200 * (10 ** 18);
        uint256 transferAmount = 150 * (10 ** 18);

        // Fund deployer and approve allowance
        vm.deal(deployer, 10 ether);
        vm.startPrank(deployer); // Start a persistent prank
        token.approve(user1, allowanceAmount);
        assertEq(token.allowance(deployer, user1), allowanceAmount, "Allowance should be set correctly");
        vm.stopPrank(); // Stop pranking deployer

        // Transfer on behalf of deployer by user1
        vm.startPrank(user1); // Start prank for user1
        bool success = token.transferFrom(deployer, user1, transferAmount);
        assertTrue(success, "TransferFrom should succeed");
        vm.stopPrank(); // Stop pranking user1

        // Assertions
        assertEq(token.balanceOf(user1), transferAmount, "User1 should receive transferred amount");
        assertEq(token.balanceOf(deployer), initialSupply - transferAmount, "Deployer balance should decrease");
        assertEq(token.allowance(deployer, user1), allowanceAmount - transferAmount, "Allowance should decrease");
    }


    function testFailTransferFromWithoutApproval() public {
        uint256 transferAmount = 100 * (10 ** 18);

        // User1 tries to transfer from deployer's balance without approval
        vm.prank(user1);
        token.transferFrom(deployer, user2, transferAmount); // ❌ Should fail: No allowance given
    }
}
