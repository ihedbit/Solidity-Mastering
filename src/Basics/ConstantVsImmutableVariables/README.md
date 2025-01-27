# ConstantVsImmutable Smart Contract

The **ConstantVsImmutable** contract demonstrates the key differences between **constant** and **immutable** variables in Solidity. Both types help optimize gas costs by storing fixed values that cannot be changed after deployment.

---

## 📄 Key Differences

| Feature          | Constant                           | Immutable                          |
|------------------|-----------------------------------|------------------------------------|
| Assignment       | Must be assigned at compile-time  | Assigned at deployment (constructor) |
| Modifiability    | Cannot be modified after compile  | Cannot be changed after deployment |
| Storage Location | Stored in bytecode (cheaper gas)  | Stored in contract storage (slightly more gas) |
| Use Cases        | Fixed values like tax rates      | Dynamic values like deployment settings |

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `CONSTANT_VALUE (constant)`: Stores a fixed value that cannot be modified.
   - `immutableValue (immutable)`: Value assigned once during deployment.
   - `contractOwner (immutable)`: Stores the address of the contract deployer.

2. **Functions**
   - `getConstantValue()`: Returns the constant value.
   - `getImmutableValue()`: Returns the immutable value assigned during deployment.
   - `getOwner()`: Returns the immutable contract owner address.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.
   - Deploy the contract by passing an initial value for `immutableValue`.

2. **Interact with the Contract:**  
   - Call `getConstantValue()` → Should return `100` (fixed).  
   - Call `getImmutableValue()` → Should return the value set during deployment.  
   - Call `getOwner()` → Should return the contract deployer's address.

---

## 📌 Example Usage

1. Deploy the contract with `_value = 500`.  
2. Call `getConstantValue()` → Expect output `100`.  
3. Call `getImmutableValue()` → Expect output `500`.  
4. Call `getOwner()` → Expect deployer's address.  

---

## ⚠️ Important Considerations

- **Gas Efficiency:**  
  - Use `constant` for values known at compile time to optimize gas costs.
  - Use `immutable` for values that need to be set dynamically at deployment.
  
- **Deployment-Time Restrictions:**  
  - `constant` values cannot depend on runtime conditions.
  - `immutable` values can be assigned using constructor parameters.

- **Storage Costs:**  
  - Constant variables are stored in bytecode, reducing storage costs.
  - Immutable variables occupy storage slots, making them slightly more expensive.

---

## ⚙️ When to Use Constant vs. Immutable

| Scenario                            | Suggested Type |
|-------------------------------------|----------------|
| Fixed tax rate, token name, decimals | `constant`      |
| Owner address, max supply            | `immutable`      |
| Mathematical constants               | `constant`      |
| System configurations                | `immutable`      |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
