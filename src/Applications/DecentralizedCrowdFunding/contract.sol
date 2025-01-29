// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title DecentralizedCrowdfunding
 * @dev A crowdfunding smart contract that allows users to create and contribute to campaigns.
 */
contract DecentralizedCrowdfunding {
    struct Campaign {
        address payable owner;
        uint256 goal;
        uint256 deadline;
        uint256 totalFunds;
        bool claimed;
        mapping(address => uint256) contributions;
    }

    uint256 public campaignCount;
    mapping(uint256 => Campaign) public campaigns;

    event CampaignCreated(uint256 indexed campaignId, address owner, uint256 goal, uint256 deadline);
    event ContributionMade(uint256 indexed campaignId, address contributor, uint256 amount);
    event FundsClaimed(uint256 indexed campaignId, uint256 amount);
    event RefundIssued(uint256 indexed campaignId, address contributor, uint256 amount);

    /**
     * @dev Create a new crowdfunding campaign.
     * @param _goal The funding goal in wei.
     * @param _duration The campaign duration in seconds.
     */
    function createCampaign(uint256 _goal, uint256 _duration) public {
        require(_goal > 0, "Goal must be greater than 0");
        require(_duration > 0, "Duration must be greater than 0");

        campaignCount++;
        Campaign storage newCampaign = campaigns[campaignCount];
        newCampaign.owner = payable(msg.sender);
        newCampaign.goal = _goal;
        newCampaign.deadline = block.timestamp + _duration;
        newCampaign.claimed = false;

        emit CampaignCreated(campaignCount, msg.sender, _goal, newCampaign.deadline);
    }

    /**
     * @dev Contribute to an existing campaign.
     * @param _campaignId The ID of the campaign to contribute to.
     */
    function contribute(uint256 _campaignId) public payable {
        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp < campaign.deadline, "Campaign has ended");
        require(msg.value > 0, "Contribution must be greater than 0");

        campaign.totalFunds += msg.value;
        campaign.contributions[msg.sender] += msg.value;

        emit ContributionMade(_campaignId, msg.sender, msg.value);
    }

    /**
     * @dev Allows the campaign owner to claim funds if the goal is met.
     * @param _campaignId The ID of the campaign.
     */
    function claimFunds(uint256 _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];

        require(msg.sender == campaign.owner, "Only the campaign owner can claim funds");
        require(block.timestamp >= campaign.deadline, "Campaign is still running");
        require(campaign.totalFunds >= campaign.goal, "Funding goal not met");
        require(!campaign.claimed, "Funds have already been claimed");

        campaign.claimed = true;
        uint256 amount = campaign.totalFunds;
        campaign.totalFunds = 0;
        campaign.owner.transfer(amount);

        emit FundsClaimed(_campaignId, amount);
    }

    /**
     * @dev Allows contributors to get a refund if the campaign fails.
     * @param _campaignId The ID of the campaign.
     */
    function refund(uint256 _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];

        require(block.timestamp >= campaign.deadline, "Campaign is still running");
        require(campaign.totalFunds < campaign.goal, "Funding goal met, refunds not available");

        uint256 contributedAmount = campaign.contributions[msg.sender];
        require(contributedAmount > 0, "No contributions to refund");

        campaign.contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributedAmount);

        emit RefundIssued(_campaignId, msg.sender, contributedAmount);
    }

    /**
     * @dev Get campaign details.
     * @param _campaignId The ID of the campaign.
     */
    function getCampaignDetails(uint256 _campaignId) public view returns (
        address owner,
        uint256 goal,
        uint256 deadline,
        uint256 totalFunds,
        bool claimed
    ) {
        Campaign storage campaign = campaigns[_campaignId];
        return (campaign.owner, campaign.goal, campaign.deadline, campaign.totalFunds, campaign.claimed);
    }

    /**
     * @dev Check remaining time for a campaign.
     * @param _campaignId The ID of the campaign.
     */
    function getRemainingTime(uint256 _campaignId) public view returns (uint256) {
        Campaign storage campaign = campaigns[_campaignId];

        if (block.timestamp >= campaign.deadline) {
            return 0;
        }
        return campaign.deadline - block.timestamp;
    }
}
