# 16-bit Arithmetic Logic Unit (ALU) Design in VHDL

![Language](https://img.shields.io/badge/Language-VHDL-blue)
![Tools](https://img.shields.io/badge/Tools-Xilinx_Vivado%20%7C%20ModelSim-green)
![Status](https://img.shields.io/badge/Status-Verified-success)

## 📌 Project Overview
This repository contains the VHDL implementation of a versatile **16-bit Arithmetic Logic Unit (ALU)**. The design is engineered to perform **15 distinct operations**, ranging from standard arithmetic to advanced bit manipulations relevant to Digital Signal Processing (DSP) and Cryptography.

The architecture processes two 8-bit inputs combined to support 16-bit operations and is optimized for timing efficiency, achieving a theoretical maximum frequency of **70.003 MHz**.

## 🚀 Key Features
* **Architecture:** 16-bit operation support using dual 8-bit input logic.
* **Operations:** 15-function instruction set controlled by a 4-bit Opcode.
* **Optimization:** Critical path analysis indicates performance up to **70 MHz** (selectively optimized).
* **Advanced Logic:** Includes hardware-level support for **Hamming Weight** and **Parity Checking**.

## 🛠 Instruction Set (Opcode Table)
The ALU supports the following operations based on the 4-bit selection line:

| Opcode | Operation | Description |
| :--- | :--- | :--- |
| `0000` | **ADD** | Standard Addition |
| `0001` | **SUB** | Subtraction |
| `0010` | **MUL** | Multiplication (Low complexity) |
| `0011` | **DIV** | Division |
| `0100` | **AND** | Bitwise AND |
| `0101` | **OR** | Bitwise OR |
| `0110` | **XOR** | Bitwise XOR |
| `0111` | **NAND** | Bitwise NAND |
| `1000` | **NOR** | Bitwise NOR |
| `1001` | **LSL** | Logical Shift Left |
| `1010` | **LSR** | Logical Shift Right |
| `1011` | **ROL** | Rotate Left |
| `1100` | **ROR** | Rotate Right |
| `1101` | **Hamming** | Calculate Hamming Weight |
| `1110` | **Parity** | Parity Check (Error Detection) |

## 📊 Performance & Simulation
The design was verified using **Testbenches** covering all corner cases (Overflow, Negative results, Zero flag).

* **Simulation Tools:** [Insert Tool Name, e.g., Xilinx Vivado / ModelSim]
* **Max Frequency:** ~25 MHz (Standard) / ~70 MHz (Optimized)
* **Latency:** Single-cycle execution for logical operations.

### Waveform Output
*(Add a screenshot of your waveform simulation here. It proves the code works!)*
![Waveform Simulation](images/waveform_screenshot.png)

## 📁 File Structure
* `src/`: Contains the main VHDL entity and architecture files.
* `sim/`: Contains the Testbench (`alu_tb.vhd`) files.
* `docs/`: Full Project Report and Schematic diagrams.

## 👥 Authors & Contributors
* **Priyanshu Patel** - *Architecture Design & Optimization*
* **Yash Patel** - *Simulation & Verification*

---
*This project was developed as part of the Electronics & Communication Engineering curriculum at Dharmsinh Desai University.*
