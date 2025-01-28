# StaticVsDynamicArrays Smart Contract

The **StaticVsDynamicArrays** contract demonstrates the key differences between **fixed-size (static) arrays** and **dynamically sized arrays** in Solidity. Understanding these differences helps in optimizing storage and gas costs while developing smart contracts.

---

## 📄 Key Differences

| Feature              | Static Arrays                          | Dynamic Arrays                      |
|---------------------|--------------------------------------|-----------------------------------|
| Size                | Fixed at compile-time                | Can grow or shrink at runtime    |
| Memory Usage        | More predictable and gas efficient   | Can consume more gas due to resizing  |
| Initialization      | Must be initialized with fixed size  | Can start empty and grow dynamically |
| Access & Modification | Faster due to fixed length           | May require resizing and more operations |

---

## 🛠️ Contract Breakdown

1. **State Variables**
   - `uint256[5] public staticArray`: A fixed-size array initialized with values.
   - `uint256[] public dynamicArray`: A dynamic array with no predefined size.

2. **Functions**
   - `updateStaticArray(uint256 _index, uint256 _value)`: Updates a static array element.
   - `addToDynamicArray(uint256 _value)`: Adds a new element to the dynamic array.
   - `removeFromDynamicArray()`: Removes the last element from the dynamic array.
   - `getStaticArrayLength()`: Retrieves the static array length (always `5`).
   - `getDynamicArrayLength()`: Retrieves the current dynamic array length.
   - `getStaticArrayElement(uint256 _index)`: Fetches a specific static array value.
   - `getDynamicArrayElement(uint256 _index)`: Fetches a specific dynamic array value.

---

## 🚀 How to Use

1. **Compile and Deploy:**  
   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - Ensure Solidity compiler version `^0.8.0` is selected.

2. **Interact with the Contract:**  
   - Call `getStaticArrayLength()` → Returns `5` as the fixed size.
   - Call `addToDynamicArray(10)` → Adds `10` to the dynamic array.
   - Call `getDynamicArrayLength()` → Returns current dynamic array length.
   - Call `updateStaticArray(2, 99)` → Updates index `2` to `99` in the static array.
   - Call `removeFromDynamicArray()` → Removes the last element from the dynamic array.

---

## 📌 Example Usage

1. Deploy the contract.
2. Call `getStaticArrayElement(0)` → Expect output `1`.
3. Call `updateStaticArray(0, 50)` → Update first element to `50`.
4. Call `getStaticArrayElement(0)` → Expect output `50`.
5. Call `addToDynamicArray(25)` → Adds value `25` to dynamic array.
6. Call `getDynamicArrayElement(0)` → Expect output `25`.
7. Call `removeFromDynamicArray()` → Removes the last element.

---

## ⚠️ Important Considerations

- **Gas Costs:**  
  - Static arrays consume less gas due to their fixed nature.
  - Dynamic arrays are more flexible but may lead to higher gas costs.

- **Bounds Checking:**  
  - Always check array bounds using `require()` to avoid runtime errors.
  - Solidity does not allow dynamic resizing of static arrays.

- **Default Values:**  
  - Static arrays have all elements initialized to zero by default.
  - Dynamic arrays start empty and can be resized as needed.

---

## ⚙️ When to Use

| Scenario                         | Suggested Array Type |
|---------------------------------|----------------------|
| Fixed-size data like top 10 scores | Static Array         |
| Variable-length lists like user addresses | Dynamic Array        |
| Predictable storage costs        | Static Array         |
| Flexible and expandable data     | Dynamic Array        |

---

## ⚙️ Requirements

- Solidity compiler version `^0.8.0`
- Ethereum development tools like **Remix, Hardhat, or Truffle**
- MetaMask for interacting with deployed contracts

---

## 📧 Contact

For any inquiries or contributions, feel free to reach out via GitHub or email.
