# MathOperations Smart Contract

The **MathOperations** smart contract demonstrates basic arithmetic operations in Solidity, including **addition, subtraction, multiplication, division, and modulus.** These operations are fundamental in many smart contract use cases, such as financial calculations and token transfers.

---

## 📄 Features

- **Addition (`+`)** → Adds two numbers.
- **Subtraction (`-`)** → Subtracts the second number from the first.
- **Multiplication (`*`)** → Multiplies two numbers.
- **Division (`/`)** → Divides the first number by the second.
- **Modulus (`%`)** → Calculates the remainder of division.

---

## 🛠️ Contract Breakdown

1. **Functions**
   - `add(uint256 _a, uint256 _b)`: Adds two numbers and returns the result.
   - `subtract(uint256 _a, uint256 _b)`: Subtracts the second number from the first (checks for underflow).
   - `multiply(uint256 _a, uint256 _b)`: Multiplies two numbers and returns the result.
   - `divide(uint256 _a, uint256 _b)`: Divides the first number by the second (checks for zero division).
   - `modulus(uint256 _a, uint256 _b)`: Returns the remainder of division (checks for zero division).

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `add(10, 20)` → Should return `30`.  
   - Call `subtract(50, 25)` → Should return `25`.  
   - Call `multiply(6, 7)` → Should return `42`.  
   - Call `divide(100, 5)` → Should return `20`.  
   - Call `modulus(17, 5)` → Should return `2`.

---

## 📌 Example Usage

1. Deploy the contract.
2. Call `add(100, 200)` → Expect output: `300`.
3. Call `subtract(10, 5)` → Expect output: `5`.
4. Call `divide(15, 3)` → Expect output: `5`.
5. Call `modulus(17, 5)` → Expect output: `2`.
6. Attempt `divide(10, 0)` → Expect revert "Division by zero is not allowed".

---

## ⚠️ Important Considerations

- **Safe Arithmetic:**  
  - Solidity 0.8.x includes built-in overflow and underflow protection.
  - Always use `require()` to avoid division by zero.
  
- **Gas Efficiency:**  
  - Multiplication is cheaper than division in terms of gas consumption.
  - Consider reusing calculated values rather than recalculating in loops.

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development environment (Remix, Hardhat, or Truffle)
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.

