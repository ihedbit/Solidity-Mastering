# BooleanOperations Smart Contract

The `BooleanOperations` smart contract demonstrates how to use **boolean operations** in Solidity, including logical AND (`&&`), logical OR (`||`), and logical NOT (`!`). This contract allows toggling contract states and checking different logical conditions.

## 📄 Features

- **Toggle Contract Status**: Change the `isContractActive` state variable using the `toggleContractStatus` function.
- **Set Admin Status**: Assign or remove admin privileges with `setAdminStatus`.
- **Logical Operations**:  
  - `isAdminAndActive()` → Checks if both contract is active and admin exists.  
  - `isInactiveOrAdmin()` → Checks if the contract is inactive or an admin exists.  
  - `isNeitherActiveNorAdmin()` → Verifies if neither condition is met.

---

## 🛠️ Contract Breakdown

1. **State Variables**  
   - `bool public isContractActive = true;` → Represents the contract's current state (active/inactive).  
   - `bool public isAdmin = false;` → Indicates if an admin has been assigned.

2. **Functions**  
   - `toggleContractStatus()` → Toggles the `isContractActive` state between `true` and `false`.  
   - `setAdminStatus(bool _status)` → Sets the admin privilege using a boolean input.  
   - `isAdminAndActive()` → Returns `true` if both the contract is active and an admin is set.  
   - `isInactiveOrAdmin()` → Returns `true` if either the contract is inactive or admin is assigned.  
   - `isNeitherActiveNorAdmin()` → Returns `true` if both the contract is inactive and admin is not assigned.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) or Hardhat to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `toggleContractStatus()` to activate/deactivate the contract.  
   - Use `setAdminStatus(true)` to assign an admin.  
   - Verify conditions using `isAdminAndActive()`, `isInactiveOrAdmin()`, and `isNeitherActiveNorAdmin()`.

---

## 📌 Example Usage

1. Deploy the contract.  
2. Call `isAdminAndActive()` initially → Should return `false`.  
3. Call `setAdminStatus(true)` → Set admin to `true`.  
4. Call `isAdminAndActive()` → Now returns `true`.  
5. Call `toggleContractStatus()` → Deactivates contract.  
6. Call `isInactiveOrAdmin()` → Returns `true` as admin exists.  

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development environment (Remix, Hardhat, or Truffle)
- Metamask for testing interactions on testnets.

---

## 📧 Contact

For feedback or contributions, reach out via GitHub or email.
