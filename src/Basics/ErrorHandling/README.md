# ErrorHandling Smart Contract

The **ErrorHandling** contract demonstrates how to use Solidity's built-in error handling mechanisms: **require, assert, and revert.** Proper error handling is crucial for ensuring the stability and security of smart contracts by preventing invalid operations.

---

## 📄 Features

- **Require Statement:** Used to validate inputs and conditions before executing a function.
- **Assert Statement:** Ensures internal contract invariants hold true at runtime.
- **Revert Statement:** Used for conditional errors that require complex logic.
- **Owner-Only Access:** Restricted functions using `require` within a modifier.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `address public owner;` → Stores the contract owner's address.
   - `uint256 public balance;` → Tracks the contract balance.

2. **Functions**
   - `addBalance(uint256 _amount)`: Uses `require` to validate positive input.
   - `withdraw(uint256 _amount)`: Checks sufficient balance using `require`.
   - `validateBalance()`: Uses `assert` to verify internal state consistency.
   - `customRevert(bool _condition)`: Demonstrates `revert` for condition-based errors.
   - `getBalance()`: Returns the current contract balance.

---

## 🚀 Error Handling Statements Overview

### 1. **`require(condition, message)`**  
Used to validate inputs and preconditions. If the condition fails, the transaction is reverted, and an error message is returned.

**Example:**
```solidity
require(msg.sender == owner, "Caller is not the owner");
```
**Use Cases:**
- Input validation
- Access control
- Checking contract state

---

### 2. **`assert(condition)`**  
Used to check for internal errors and invariants. It should only be used for conditions that should **never fail**. If the condition is false, it reverts the transaction and consumes all gas.

**Example:**
```solidity
assert(balance >= 0);
```
**Use Cases:**
- Internal consistency checks
- Validating mathematical calculations

---

### 3. **`revert(message)`**  
Used for handling more complex conditions and custom logic. It explicitly reverts the transaction, and the provided error message is returned.

**Example:**
```solidity
if (_condition) {
    revert("Operation failed due to invalid condition");
}
```
**Use Cases:**
- Manual error throwing
- Nested condition checks
- Complex state validation

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `addBalance(50)` → Adds to the balance if input is valid.  
   - Call `withdraw(200)` → Fails with "Insufficient balance" if balance is too low.  
   - Call `validateBalance()` → Checks internal balance consistency.  
   - Call `customRevert(true)` → Triggers a revert message.

---

## 📌 Example Usage

1. Deploy the contract.
2. Call `addBalance(100)` → Should succeed and update balance.
3. Call `withdraw(50)` → Withdraw the balance successfully.
4. Call `withdraw(200)` → Expect revert with "Insufficient balance".
5. Call `customRevert(true)` → Expect revert with "Custom revert triggered due to the condition being true".

---

## ⚠️ Important Considerations

- **Gas Consumption:**  
  - `require` and `revert` refund unused gas when conditions fail.  
  - `assert` consumes all gas when it fails, so use it sparingly.

- **Proper Usage:**  
  - Use `require` for user input validation.  
  - Use `assert` only for internal checks that should never be false.  
  - Use `revert` for conditional failures requiring message customization.

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools (Remix, Hardhat, or Truffle)
- MetaMask for contract interaction

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
