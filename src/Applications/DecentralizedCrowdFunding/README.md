# DecentralizedCrowdfunding Smart Contract

The **DecentralizedCrowdfunding** smart contract allows users to create and contribute to crowdfunding campaigns securely and transparently on the blockchain. Campaign owners can withdraw funds if the goal is met, while contributors can receive refunds if the campaign fails.

---

## 📄 Key Features

- **Campaign Creation:**  
  - Users can create crowdfunding campaigns with a specific funding goal and duration.

- **Contributions Tracking:**  
  - Contributions are stored on-chain, ensuring full transparency.

- **Fund Withdrawal:**  
  - The campaign owner can withdraw funds if the goal is reached after the campaign ends.

- **Refunds:**  
  - Contributors can claim refunds if the campaign goal is not met within the timeframe.

- **Transparency:**  
  - View all campaign details, contributions, and remaining time.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `campaignCount`: Tracks the total number of campaigns.
   - `Campaign`: Struct that holds campaign details.
   - `campaigns`: Mapping of campaign IDs to their details.

2. **Functions**
   - `createCampaign(uint256 _goal, uint256 _duration)`: Allows users to create campaigns.
   - `contribute(uint256 _campaignId)`: Enables users to contribute ETH to a campaign.
   - `claimFunds(uint256 _campaignId)`: Allows campaign owners to withdraw funds if the goal is met.
   - `refund(uint256 _campaignId)`: Contributors can claim refunds if the campaign fails.
   - `getCampaignDetails(uint256 _campaignId)`: Retrieves campaign details.
   - `getRemainingTime(uint256 _campaignId)`: Returns remaining campaign time.

3. **Events**
   - `CampaignCreated(uint256 campaignId, address owner, uint256 goal, uint256 deadline)`: Emitted when a new campaign is created.
   - `ContributionMade(uint256 campaignId, address contributor, uint256 amount)`: Emitted when a user contributes to a campaign.
   - `FundsClaimed(uint256 campaignId, uint256 amount)`: Emitted when the campaign owner claims funds.
   - `RefundIssued(uint256 campaignId, address contributor, uint256 amount)`: Emitted when contributors receive refunds.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Deploy with default values.

2. **Create a Campaign:**  
   - Call `createCampaign(goal, duration)` to start a new campaign.

3. **Contribute to a Campaign:**  
   - Call `contribute(campaignId)` and send ETH.

4. **Claim Funds:**  
   - If the goal is met, the owner calls `claimFunds(campaignId)` after the campaign ends.

5. **Request Refund:**  
   - If the goal isn't met, contributors can call `refund(campaignId)` to retrieve their ETH.

---

## 📌 Example Usage

1. **Deploy the contract.**  
2. **Create a campaign:**  
   ```solidity
   createCampaign(5 ether, 604800); // 5 ETH goal, 7 days duration
   ```

3. **Contribute to the campaign:**  
   ```solidity
   contribute(1) { value: 2 ether }
   ```

4. **Check campaign details:**  
   ```solidity
   getCampaignDetails(1);
   ```

5. **Claim funds after reaching the goal:**  
   ```solidity
   claimFunds(1);
   ```

6. **Refund if goal not reached:**  
   ```solidity
   refund(1);
   ```

---

## ⚠️ Important Considerations

- **Security:**  
  - Campaign creators cannot withdraw funds unless the goal is met.
  - Contributors can only refund if the campaign fails.

- **Gas Costs:**  
  - Each contribution and withdrawal incurs gas fees.

- **Campaign Deadlines:**  
  - Contributions are only accepted before the deadline.

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
