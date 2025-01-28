# VisibilitySpecifiers Smart Contract

The **VisibilitySpecifiers** contract demonstrates how to use Solidity’s four visibility specifiers: **public, private, internal, and external.** These specifiers determine how functions and variables can be accessed within and outside the contract.

---

## 📄 Visibility Specifiers Overview

1. **Public (`public`)**  
   - Accessible both **internally** (within the contract) and **externally** (from other contracts and web interfaces).
   - Automatically creates a getter function for public state variables.

2. **Private (`private`)**  
   - Accessible **only within** the contract where it is declared.
   - Cannot be inherited or accessed from derived contracts.

3. **Internal (`internal`)**  
   - Accessible within the contract **and derived contracts**.
   - Similar to `private` but allows inheritance access.

4. **External (`external`)**  
   - Accessible **only from outside** the contract.
   - Cannot be called from within the contract but can be accessed via other contracts or web3 interfaces.

---

## 🛠️ Contract Breakdown

1. **State Variables with Different Visibility Levels**
   - `publicVar` (public) → Accessible internally and externally.
   - `privateVar` (private) → Only accessible inside the contract.
   - `internalVar` (internal) → Accessible inside and in derived contracts.

2. **Functions Demonstrating Visibility**
   - `getPublicVar()` (public) → Can be called both externally and internally.
   - `getPrivateVar()` (private) → Only accessible inside the contract.
   - `getInternalVar()` (internal) → Accessible within this and derived contracts.
   - `getExternalVar()` (external) → Accessible only externally.
   - `fetchPrivateVar()` (public) → Calls a private function to return its value.

3. **Derived Contract (`DerivedVisibility`)**
   - Demonstrates access to internal functions and variables from an inherited contract.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `setPublicVar(500)` to update the public variable.  
   - Call `getPublicVar()` to read the updated value.  
   - Call `fetchPrivateVar()` to get the value of the private variable.  
   - Call `getExternalVar()` externally to see the sum of internal and public values.  
   - Deploy `DerivedVisibility` and call `accessInternal()` to access inherited internal function.

---

## 📌 Example Usage

1. Deploy `VisibilitySpecifiers` contract.  
2. Call `getPublicVar()` → Expect output `100` (default value).  
3. Call `setPublicVar(500)` → Update the value.  
4. Call `getPublicVar()` again → Expect output `500`.  
5. Call `fetchPrivateVar()` → Expect output `200`.  
6. Deploy `DerivedVisibility` and call `accessInternal()` → Expect output `300`.

---

## ⚠️ Important Considerations

- **Public Variables:** Automatically have getter functions, so explicit getters are unnecessary.  
- **Private Variables:** Cannot be accessed in derived contracts, ensuring encapsulation.  
- **Internal Variables:** Useful for inheritance, preventing direct external access.  
- **External Functions:** Cannot be called internally but are cost-efficient for interactions.

---

## ⚙️ Visibility Specifier Use Cases

| Visibility | Access Level | Common Use Cases |
|------------|-------------|------------------|
| Public     | Internal & External | Functions meant for public interaction |
| Private    | Internal Only | Internal logic, sensitive data |
| Internal   | Internal & Inherited | Reusable functions across contracts |
| External   | External Only | Contract interaction, cost-efficient calls |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development environment (Remix, Hardhat, or Truffle)
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
