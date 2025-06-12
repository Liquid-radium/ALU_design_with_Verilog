### ALU deisgn with Verilog

This project implements a 32-bit Arithmetic Logic Unit (ALU) designed in Verilog, capable of performing a wide range of arithmetic and logical operations suitable for integration into a RISC-V processor core. The testbench is written using [cocotb](https://www.cocotb.org/), a coroutine-based Python framework for testing VHDL and Verilog RTL using Python.

## Features

The ALU supports the following operations:

| ALU Control Code | Operation    |
| ---------------- | ------------ |
| 0                | OR           |
| 1                | AND          |
| 2                | NAND         |
| 3                | NOR          |
| 4                | NOT A        |
| 5                | XOR          |
| 6                | ADD          |
| 7                | SUB          |
| 8                | Shift Left   |
| 9                | Shift Right  |
| 10               | Compare      |
| 11               | Left Rotate  |
| 12               | Right Rotate |

Additional status flags:

* `zero_flag`: Set if the result is zero
* `neg_flag`: Set if the result is negative (MSB = 1)
* `carry_flag`: Set based on arithmetic carry-out
* `overflow_flag`: Set on arithmetic overflow

## 📁 File Structure

```
.
├── alu.v             # ALU top-level Verilog module
├── adder.v           # Adder submodule
├── sub.v             # Subtractor submodule
├── cmp.v             # Comparator submodule
├── right_rotate.v    # Right rotate submodule
├── left_rotate.v     # Left rotate submodule
├── tb_alu.py         # cocotb-based Python testbench
├── Makefile          # cocotb-compatible makefile
└── README.md         # This file
```

## How to Run the Simulation

### Prerequisites

* Python 3.6+
* Icarus Verilog (`iverilog`)
* cocotb
* GTKWave (for waveform viewing, optional)

## Testbench

The testbench applies a set of predefined test vectors using cocotb and checks the ALU output and flags. It helps validate the correctness of each ALU operation.

Test cases cover edge scenarios like:

* Zero results
* Overflow
* Negative results
* Logical and shift operations

## License

This project is open-source under the MIT License.

## ✍️ Author

Shruti Hegde
GitHub: [@Liquid-radium](https://github.com/Liquid-radium)
