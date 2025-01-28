# DynamicDataStructures Smart Contract

The **DynamicDataStructures** smart contract demonstrates the implementation of **dynamic mappings** and **nested mappings** in Solidity. These features allow developers to create efficient and scalable data storage structures in smart contracts.

---

## 📄 Key Features

- **Dynamic Mappings:**  
  - Store balances dynamically by mapping user addresses to amounts.
  - Efficient way to track user funds without predefining storage.
  
- **Nested Mappings:**  
  - Store user-specific data in an organized way.
  - Implement allowances like in ERC20 token contracts.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `mapping(address => uint256) balances`: Stores user balances dynamically.
   - `mapping(address => mapping(uint256 => string)) userNotes`: Nested mapping for user notes.
   - `mapping(address => mapping(address => uint256)) allowances`: Nested mapping for tracking allowances.

2. **Functions**
   - `deposit()`: Allows users to deposit Ether into the contract.
   - `getBalance(address)`: Retrieves the balance of a user.
   - `addUserNote(uint256, string)`: Stores user-specific notes dynamically.
   - `getUserNote(address, uint256)`: Retrieves a stored note by index.
   - `setAllowance(address, uint256)`: Allows a spender to use funds on behalf of the user.
   - `getAllowance(address, address)`: Retrieves the allowance of a spender.
   - `transfer(address, uint256)`: Transfers funds between addresses.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.
   - Fund the contract with some Ether.

2. **Interact with the Contract:**  
   - Call `deposit()` with Ether to store balance.
   - Call `getBalance(msg.sender)` to check deposited balance.
   - Call `addUserNote(1, "Hello, Solidity!")` to store notes.
   - Call `getUserNote(msg.sender, 1)` to retrieve stored notes.
   - Call `setAllowance(spenderAddress, 500)` to allow a spender.
   - Call `getAllowance(ownerAddress, spenderAddress)` to check allowance.
   - Call `transfer(recipientAddress, amount)` to send funds.

---

## 📌 Example Usage

1. Deploy the contract.
2. Send 1 ETH to the contract and call `deposit()` to update balance.
3. Call `getBalance(msg.sender)` → Expect output `1 ETH`.
4. Call `addUserNote(0, "This is my first note.")`.
5. Call `getUserNote(msg.sender, 0)` → Expect output `"This is my first note."`.
6. Call `setAllowance(address(0xabc...), 100)` to allow another account to spend funds.
7. Call `getAllowance(msg.sender, address(0xabc...))` → Expect `100`.
8. Transfer 0.5 ETH using `transfer(address, 0.5 ETH)`.

---

## ⚠️ Important Considerations

- **Gas Efficiency:**  
  - Mappings are more gas-efficient than arrays for lookups.
  - Deleting mappings does not free storage; setting values to zero is recommended.

- **Security:**  
  - Ensure only authorized users modify mappings when necessary.
  - Implement access control when handling allowances to prevent misuse.

- **Limitations:**  
  - Mappings do not allow iteration, meaning you cannot retrieve all keys efficiently.
  - Data stored in mappings cannot be reset or deleted, only overwritten.

---

## ⚙️ When to Use Mappings

| Use Case                        | Suitable Mapping Type                     |
|---------------------------------|-------------------------------------------|
| User balances (token tracking)  | `mapping(address => uint256)`             |
| Nested permissions              | `mapping(address => mapping(address => uint256))` |
| User-generated content          | `mapping(address => mapping(uint256 => string))`  |
| Voting systems                  | `mapping(uint256 => bool)`                 |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
