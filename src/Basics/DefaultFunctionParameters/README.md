# DefaultFunctionParameters Smart Contract

The **DefaultFunctionParameters** smart contract demonstrates how to set and use default values for function parameters in Solidity. Since Solidity does not natively support default parameters like other programming languages, default values can be implemented using conditional logic inside the function.

---

## 📄 Features

- **Default Greeting Message:**  
  - If no custom message is provided, a default greeting is used.
- **Default Number Storage:**  
  - If no number is provided or zero is passed, a default value is stored.
- **Conditional Defaults for Arithmetic:**  
  - Addition function with optional values, using defaults when zero is passed.

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `greeting` (string) → Stores a greeting message with a default value.
   - `storedNumber` (uint256) → Holds a stored number with default logic.

2. **Functions**
   - `setGreeting(string memory _message)`: Sets a greeting message, defaults to `"Hello, Blockchain!"`.
   - `storeNumber(uint256 _num)`: Stores a number, defaults to `100` if zero is passed.
   - `addNumbers(uint256 _a, uint256 _b)`: Adds two numbers, with default values of `10` and `5` if zeros are passed.
   - `getGreeting()`: Retrieves the current greeting message.
   - `getStoredNumber()`: Returns the stored number.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `setGreeting("")` → Should store "Hello, Blockchain!".  
   - Call `storeNumber(0)` → Should store `100` as default.  
   - Call `addNumbers(0, 0)` → Should return `15` (default values).  

---

## 📌 Example Usage

1. Deploy the contract.
2. Call `getGreeting()` → Expect `"Hello, Solidity!"`.
3. Call `setGreeting("")` → Expect `"Hello, Blockchain!"`.
4. Call `storeNumber(0)` → Expect `100` stored.
5. Call `addNumbers(0, 0)` → Expect `15` (default values: 10 + 5).

---

## ⚠️ Important Considerations

- Solidity **does not support** default function parameters directly; logic-based defaults must be implemented inside functions.
- Using conditional checks ensures valid values are set while avoiding unnecessary reverts.
- Default values can help reduce gas costs by avoiding unnecessary input data.

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
