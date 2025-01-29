// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../contract.sol";

contract DecentralizedCrowdfundingTest is Test {
    DecentralizedCrowdfunding private crowdfunding;
    address payable private campaignOwner;
    address payable private contributor;
    uint256 private campaignId;
    uint256 private campaignGoal = 10 ether;
    uint256 private campaignDuration = 3600; // 1 hour

    function setUp() public {
        crowdfunding = new DecentralizedCrowdfunding();

        // Assign test addresses
        campaignOwner = payable(address(0x1234));
        contributor = payable(address(0x5678));

        // Fund accounts
        vm.deal(campaignOwner, 50 ether);
        vm.deal(contributor, 20 ether);

        // Create a campaign from campaignOwner
        vm.prank(campaignOwner);
        crowdfunding.createCampaign(campaignGoal, campaignDuration);

        // Retrieve campaign ID
        campaignId = crowdfunding.campaignCount();
    }

    function testCampaignCreation() public view {
        (address owner, uint256 goal, uint256 deadline, , bool claimed) = crowdfunding.getCampaignDetails(campaignId);

        assertEq(owner, campaignOwner, "Incorrect campaign owner");
        assertEq(goal, campaignGoal, "Incorrect campaign goal");
        assertEq(deadline, block.timestamp + campaignDuration, "Incorrect campaign deadline");
        assertFalse(claimed, "Campaign should not be claimed initially");
    }

    function testContributeToCampaign() public {
        uint256 contributionAmount = 5 ether;

        vm.prank(contributor);
        crowdfunding.contribute{value: contributionAmount}(campaignId);

        (, , , uint256 totalFunds, ) = crowdfunding.getCampaignDetails(campaignId);
        assertEq(totalFunds, contributionAmount, "Contribution amount should be recorded correctly");
    }

    function testClaimFundsSuccess() public {
        uint256 fullContribution = campaignGoal;

        // Contribute full amount
        vm.prank(contributor);
        crowdfunding.contribute{value: fullContribution}(campaignId);

        // Fast forward time to reach deadline
        vm.warp(block.timestamp + campaignDuration);

        uint256 initialBalance = campaignOwner.balance;

        // Claim funds
        vm.prank(campaignOwner);
        crowdfunding.claimFunds(campaignId);

        // Verify campaign status
        (, , , uint256 totalFunds, bool claimed) = crowdfunding.getCampaignDetails(campaignId);
        assertTrue(claimed, "Funds should be claimed");
        assertEq(totalFunds, 0, "Campaign balance should be zero after claim");

        // Verify funds transfer
        assertEq(campaignOwner.balance, initialBalance + campaignGoal, "Owner should receive full campaign funds");
    }

    function testRefundWhenGoalNotMet() public {
        uint256 partialContribution = 4 ether;

        // Contribute a partial amount
        vm.prank(contributor);
        crowdfunding.contribute{value: partialContribution}(campaignId);

        // Fast forward time to deadline
        vm.warp(block.timestamp + campaignDuration);

        uint256 initialBalance = contributor.balance;

        // Refund contributor
        vm.prank(contributor);
        crowdfunding.refund(campaignId);

        // Verify refund success
        assertEq(contributor.balance, initialBalance + partialContribution, "Contributor should receive refund");
    }

    function testCannotContributeAfterDeadline() public {
        vm.warp(block.timestamp + campaignDuration + 1); // Move past the deadline

        vm.expectRevert("Campaign has ended");
        vm.prank(contributor);
        crowdfunding.contribute{value: 1 ether}(campaignId);
    }

    function testCannotClaimBeforeDeadline() public {
        vm.expectRevert("Campaign is still running");
        vm.prank(campaignOwner);
        crowdfunding.claimFunds(campaignId);
    }

    function testCannotClaimIfGoalNotMet() public {
        uint256 partialContribution = 3 ether;

        // Contribute partially
        vm.prank(contributor);
        crowdfunding.contribute{value: partialContribution}(campaignId);

        // Fast forward to deadline
        vm.warp(block.timestamp + campaignDuration);

        vm.expectRevert("Funding goal not met");
        vm.prank(campaignOwner);
        crowdfunding.claimFunds(campaignId);
    }

    function testCannotRefundIfGoalMet() public {
        uint256 fullContribution = campaignGoal;

        // Contribute full amount
        vm.prank(contributor);
        crowdfunding.contribute{value: fullContribution}(campaignId);

        // Fast forward time to deadline
        vm.warp(block.timestamp + campaignDuration);

        vm.expectRevert("Funding goal met, refunds not available");
        vm.prank(contributor);
        crowdfunding.refund(campaignId);
    }
}
