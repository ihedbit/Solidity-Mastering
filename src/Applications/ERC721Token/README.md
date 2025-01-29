# ERC721NFT Smart Contract

The **ERC721NFT** contract implements the ERC721 standard to create and manage **non-fungible tokens (NFTs)**, representing unique digital assets. It allows for the minting, transfer, and burning of NFTs, following best practices.

---

## 📄 Key Features

- **ERC721 Standard Compliance:**  
  - Supports all standard ERC721 functionalities, including ownership tracking and metadata management.

- **Minting and Burning:**  
  - Owners can mint new NFTs and remove them from circulation.

- **Metadata Storage:**  
  - Supports token URI storage for linking metadata (e.g., images, descriptions).

- **Ownership Control:**  
  - Only the contract owner can mint and burn NFTs.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `_tokenIdCounter`: Tracks the current token ID for minting.
  
2. **Functions**
   - `mintNFT(address, string)`: Mints a new NFT and assigns it to the specified address.
   - `getOwner(uint256)`: Retrieves the owner of a given NFT.
   - `burnNFT(uint256)`: Burns an existing NFT.
   - `totalSupply()`: Returns the total number of NFTs minted.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Deploy with arguments for `name` and `symbol` of the NFT collection.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `mintNFT(toAddress, tokenURI)` to create a new NFT.  
   - Call `getOwner(tokenId)` to check ownership.  
   - Call `burnNFT(tokenId)` to remove an NFT from circulation.  
   - Call `totalSupply()` to see the number of minted NFTs.

---

## 📌 Example Usage

1. Deploy the contract with `name = "MyNFT"` and `symbol = "MNFT"`.  
2. Call `mintNFT(0xRecipient, "https://my-metadata.com/1.json")` → Mints NFT #1.  
3. Call `getOwner(1)` → Returns the address of the owner.  
4. Call `burnNFT(1)` → Destroys NFT #1.  
5. Call `totalSupply()` → Returns `0`.

---

## ⚠️ Important Considerations

- **Security Best Practices:**  
  - Only authorized accounts should mint or burn NFTs.
  - Use IPFS or reliable storage for metadata links to ensure permanence.

- **Gas Optimization:**  
  - Keep metadata URIs short to minimize gas fees during minting.

- **Token Transfers:**  
  - Standard ERC721 functions like `transferFrom` and `safeTransferFrom` can be used for token transfers.

---

## ⚙️ ERC721 Token Use Cases

| Use Case               | Explanation                          |
|-----------------------|--------------------------------------|
| Digital Art            | Unique pieces of digital art        |
| Collectibles           | Trading cards and collectibles      |
| Identity Verification  | Digital identity and credentials    |
| Gaming Assets          | Unique in-game items and characters |
| Real Estate            | Tokenized property assets           |

---

## ⚙️ ERC721 vs ERC20 Differences

| Feature         | ERC20 (Fungible Token)       | ERC721 (Non-Fungible Token) |
|----------------|-----------------------------|-----------------------------|
| Token Type     | Fungible (Identical units)   | Non-Fungible (Unique assets) |
| Divisibility   | Yes, fractional units         | No, whole units only         |
| Ownership      | Can own multiple identical   | Each token is unique         |
| Use Cases      | Payments, staking, DeFi      | Art, collectibles, real estate |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
