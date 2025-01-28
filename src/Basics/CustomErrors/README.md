# CustomErrors Smart Contract

The **CustomErrors** contract demonstrates the usage of Solidity's custom error types to improve gas efficiency and debugging in smart contracts. Using custom errors instead of standard `require` and `revert` statements helps in reducing contract deployment and transaction costs.

---

## 📄 Features

- **Define Custom Errors:** Create meaningful error messages without excessive gas costs.
- **Gas Optimization:** Custom errors consume less gas compared to string-based error messages.
- **Enhanced Debugging:** Identify and handle specific failure cases easily.

---

## 🛠️ Contract Breakdown

1. **Custom Error Types**
   - `error NotOwner(address caller);` → Thrown when a non-owner calls a restricted function.
   - `error InsufficientBalance(uint256 available, uint256 required);` → Triggered on insufficient withdrawal attempts.
   - `error InvalidAmount(uint256 provided);` → Raised when an invalid amount is passed.

2. **State Variables**
   - `address public owner;` → Stores the owner's address.
   - `uint256 public balance;` → Tracks the contract balance.

3. **Functions**
   - `addBalance(uint256 _amount)`: Allows the owner to increase the balance with validation.
   - `withdraw(uint256 _amount)`: Enables the owner to withdraw funds with sufficient balance checks.
   - `getBalance()`: Returns the current balance.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `addBalance(50)` → Adds to the balance if input is valid.  
   - Call `withdraw(200)` → Fails with `InsufficientBalance` if balance is too low.  
   - Call `getBalance()` → Retrieves the current contract balance.

---

## 📌 Example Usage

1. Deploy the contract.  
2. Call `addBalance(100)` → Should succeed and increase balance.  
3. Call `withdraw(50)` → Withdraw the funds successfully.  
4. Call `withdraw(200)` → Expect a revert with `InsufficientBalance(balance, _amount)`.  
5. Call `addBalance(0)` → Expect a revert with `InvalidAmount(provided)`.  

---

## ⚠️ Advantages of Custom Errors Over Require

| Feature           | Standard Require | Custom Errors |
|------------------ |---------------- |---------------|
| Gas Cost          | Higher (due to string storage) | Lower (due to encoded data) |
| Error Readability | Less informative | More descriptive |
| Debugging         | Harder to trace | Easier with error details |
| Function Size     | Larger due to strings | Smaller due to minimal data |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development environment (Remix, Hardhat, or Truffle)
- MetaMask for contract interaction

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
