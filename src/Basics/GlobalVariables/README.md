### README for `GlobalVariables` Contract

# GlobalVariables Smart Contract

The **GlobalVariables** smart contract demonstrates how to use Solidity's globally available variables to access key blockchain-related data such as transaction sender, value, block timestamp, and more.

---

## 📄 Features

- Track and store details of the last function caller and transaction.
- Retrieve blockchain-related global variables such as:
  - `msg.sender` → The caller's address.
  - `msg.value` → Ether sent with the transaction.
  - `block.timestamp` → The current block timestamp.
  - `block.number` → The current block number.
  - `tx.gasprice` → The gas price of the transaction.
  - `gasleft()` → The remaining gas available.
  - `block.difficulty` → Mining difficulty of the current block.
  - `block.chainid` → The network chain ID.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `address public lastCaller;` → Stores the address of the last function caller.
   - `uint256 public lastValueSent;` → Stores the Ether sent in the last transaction.
   - `uint256 public lastTimestamp;` → Records the timestamp of the last call.
   - `uint256 public lastBlockNumber;` → Stores the block number of the last transaction.

2. **Functions**
   - `updateGlobalVariables()`: Updates the state with transaction and block details.
   - `getTransactionDetails()`: Returns the caller's address, sent value, timestamp, and block number.
   - `getGasPrice()`: Retrieves the current gas price for the transaction.
   - `getRemainingGas()`: Checks the remaining gas left for execution.
   - `getBlockDifficulty()`: Fetches the current block difficulty.
   - `getChainId()`: Retrieves the current blockchain's chain ID.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `updateGlobalVariables()` with some Ether to store the transaction details.
   - Query `getTransactionDetails()` to retrieve stored sender, value, and block data.
   - Use `getGasPrice()` to view the current transaction gas price.
   - Call `getBlockDifficulty()` to fetch the mining difficulty.

---

## 📌 Example Usage

1. Deploy the contract.
2. Send `0.01 ETH` while calling `updateGlobalVariables()`.
3. Call `getTransactionDetails()` to verify the sender and sent Ether.
4. Check gas-related values with `getGasPrice()` and `getRemainingGas()`.
5. View blockchain parameters with `getChainId()` and `getBlockDifficulty()`.

---

## ⚠️ Important Considerations

- **`msg.sender`** always refers to the address that called the contract function.
- **`msg.value`** is zero unless Ether is explicitly sent with the transaction.
- **`block.timestamp`** is subject to manipulation by miners, avoid using it for critical logic.
- **`gasleft()`** can vary between function calls and should be used carefully in gas-sensitive operations.

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any questions or contributions, feel free to reach out via GitHub or email.
