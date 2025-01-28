# EventIndexedParameters Smart Contract

The **EventIndexedParameters** contract demonstrates how to use indexed parameters in Solidity events to enable efficient filtering and tracking of specific transaction data on the blockchain.

---

## 📄 Key Features

- **Indexed Event Parameters:**  
  - Allows for efficient filtering of logs by `userAddress`, `userId`, and other key parameters.

- **User Registration System:**  
  - Users can register and be assigned unique IDs.

- **Funds Management:**  
  - Users can deposit and withdraw funds, with event logging.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `mapping(address => User) users`: Stores user details mapped by their address.
   - `mapping(address => uint256) balances`: Tracks user balances.
   - `uint256 private userIdCounter`: Counter to assign unique user IDs.

2. **Events**
   - `UserRegistered(address indexed userAddress, uint256 indexed userId, string userName)`: Logs user registration.
   - `FundsDeposited(address indexed depositor, uint256 amount)`: Logs deposits.
   - `FundsWithdrawn(address indexed withdrawer, uint256 amount)`: Logs withdrawals.

3. **Functions**
   - `registerUser(string memory _name)`: Registers a new user and emits an event.
   - `depositFunds()`: Allows users to deposit funds.
   - `withdrawFunds(uint256 _amount)`: Enables users to withdraw funds.
   - `getUser(address _userAddress)`: Retrieves user information.
   - `getBalance(address _userAddress)`: Returns the user's balance.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `registerUser("Alice")` to register a new user.  
   - Send Ether to the contract and call `depositFunds()` to store balance.  
   - Call `withdrawFunds(1000000000000000000)` to withdraw funds.  
   - Check user details with `getUser(address)`.  
   - View funds with `getBalance(address)`.

---

## 📌 Example Usage

1. Deploy the contract.  
2. Call `registerUser("Alice")` → Emits `UserRegistered` event.  
3. Send `1 ETH` to contract and call `depositFunds()` → Emits `FundsDeposited` event.  
4. Call `getBalance(msg.sender)` → Expect `1 ETH`.  
5. Call `withdrawFunds(0.5 ETH)` → Emits `FundsWithdrawn` event.  

---

## ⚙️ Indexed Event Parameters

In Solidity, indexed event parameters are stored in topics, making them easily searchable in the Ethereum logs. Up to **3 parameters** can be indexed in an event.

**Advantages of Indexed Parameters:**

1. **Efficient Search:** Enables quick filtering of logs based on indexed fields.
2. **Reduced Gas Costs:** Logs are cheaper than storing data on-chain.
3. **Event Monitoring:** Useful for off-chain applications like dApps and analytics tools.

**Example Query via Web3.js:**
```js
contractInstance.getPastEvents('UserRegistered', {
    filter: { userAddress: "0x123..." }, 
    fromBlock: 0, 
    toBlock: 'latest'
});
```

---

## ⚠️ Important Considerations

- **Gas Efficiency:**  
  - Emitting events with indexed parameters is cost-effective for tracking.
  - Avoid over-indexing to minimize gas costs.

- **Security:**  
  - Ensure data consistency in emitted events to avoid discrepancies.

- **Limitations:**  
  - Indexed parameters can only be of **up to three fields per event**.
  - Strings and dynamic arrays cannot be indexed.

---

## ⚙️ Event Use Cases

| Use Case                | Suggested Event Structure                      |
|-------------------------|------------------------------------------------|
| User registration       | `UserRegistered(address, uint256, string)`     |
| Fund transfers          | `FundsDeposited(address, uint256)`             |
| Voting event tracking   | `VoteCast(address, uint256, uint8)`             |
| Ownership changes       | `OwnershipTransferred(address, address)`       |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
