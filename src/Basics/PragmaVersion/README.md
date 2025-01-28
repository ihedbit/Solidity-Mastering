# VersionExample Smart Contract

This is a simple Solidity smart contract that demonstrates the use of **Solidity version pragma**, ensuring compatibility with specific compiler versions.

## 📄 Contract Overview

The contract contains:

- A **Solidity version pragma** to specify the required compiler version.
- A **public state variable** `ver` initialized to `1`.

## 🛠️ Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VersionExample {
    uint256 public ver = 1;
}
```

## 📝 Explanation

1. **SPDX License Identifier**  
   - `// SPDX-License-Identifier: MIT` → Specifies that the contract uses the MIT open-source license.

2. **Solidity Version**  
   - `pragma solidity ^0.8.0;` → Ensures the contract is compiled with Solidity 0.8.x but below 0.9.0.

3. **State Variable**  
   - `uint256 public ver = 1;` → A public variable accessible externally that stores an initial value of `1`.

## 🚀 Deployment Steps

1. Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
2. Ensure Solidity compiler version `0.8.x` is selected in Remix.
3. Deploy the contract and interact with the `ver` variable to retrieve its value.

## 📌 Usage

- After deployment, call the `ver()` function to read the stored value.
- Modify and extend the contract to include more functionalities.

## ⚙️ Requirements

- Solidity compiler version `0.8.x`
- Ethereum development tools like **Remix**, **Hardhat**, or **Truffle**

## 📧 Contact

For questions or contributions, feel free to reach out.
