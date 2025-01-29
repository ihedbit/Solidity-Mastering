# ERC1155MultiToken Smart Contract

The **ERC1155MultiToken** smart contract implements the ERC1155 standard, allowing the management of multiple token types within a single contract. This standard is particularly useful for managing fungible and non-fungible tokens in the same contract.

---

## 📄 Key Features

- **Multi-Token Management:**  
  - Manage multiple token types (fungible and non-fungible) within one contract.

- **Batch Transfers:**  
  - Efficiently transfer multiple token types in a single transaction.

- **Minting & Burning:**  
  - Ability to mint new tokens and burn them to reduce supply.

- **Metadata URI:**  
  - Support for token metadata through a base URI.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `mapping(uint256 => uint256) _totalSupply`: Tracks total supply of each token ID.

2. **Functions**
   - `mint(address, uint256, uint256, bytes)`: Mints a specific token to an address.
   - `mintBatch(address, uint256[], uint256[], bytes)`: Mints multiple tokens in batch.
   - `burn(address, uint256, uint256)`: Burns tokens from an address.
   - `totalSupply(uint256)`: Returns the total supply of a specific token ID.
   - `supportsInterface(bytes4)`: Checks supported interfaces.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Set the base URI for the token metadata during deployment.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `mint(to, id, amount, data)` to create new tokens.  
   - Call `mintBatch(to, ids, amounts, data)` to create multiple tokens.  
   - Call `totalSupply(id)` to check the total supply of a token.  
   - Call `burn(from, id, amount)` to burn tokens.

---

## 📌 Example Usage

1. Deploy the contract with URI `"https://mytoken-metadata.com/{id}.json"`.  
2. Call `mint(0xRecipient, 1, 100, "")` → Mints 100 units of token ID `1`.  
3. Call `mintBatch(0xRecipient, [2, 3], [50, 25], "")` → Mints multiple tokens.  
4. Call `totalSupply(1)` → Expect `100`.  
5. Call `burn(0xRecipient, 1, 50)` → Burns 50 units of token ID `1`.  
6. Call `totalSupply(1)` → Expect `50`.

---

## ⚠️ Important Considerations

- **Security Best Practices:**  
  - Ensure only the contract owner can mint/burn tokens.
  - Use URI services like IPFS for reliable metadata storage.

- **Gas Efficiency:**  
  - Batch operations reduce gas fees compared to individual transfers.

- **Compatibility:**  
  - The contract is compatible with ERC1155-compliant wallets and marketplaces.

---

## ⚙️ ERC1155 Token Use Cases

| Use Case             | Explanation                                   |
|---------------------|-----------------------------------------------|
| Gaming Assets       | Manage multiple in-game items and currencies |
| Digital Collectibles| Representing unique or semi-fungible items    |
| Multi-Tiered Systems| Creating tokenized membership levels          |
| Supply Chain        | Tracking multiple products on-chain           |

---

## ⚙️ ERC1155 vs ERC20 vs ERC721

| Feature              | ERC20 (Fungible) | ERC721 (Non-Fungible) | ERC1155 (Multi-Token) |
|---------------------|-----------------|----------------------|----------------------|
| Token Type          | Fungible         | Non-Fungible          | Both                 |
| Batch Transfers     | No               | No                    | Yes                   |
| Gas Efficiency      | Moderate         | Expensive              | Highly Efficient      |
| Use Case            | Payments         | Digital Assets         | Mixed Assets          |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
