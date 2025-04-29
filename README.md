# Nanoprocessor Design Project – CS1050

## 📘 Summary

This project involves designing a simple 4-bit nanoprocessor that can execute a limited instruction set: `MOVI`, `ADD`, `NEG`, and `JZR`. The nanoprocessor will include a basic ALU, multiplexers, register bank, program counter, ROM, and an instruction decoder. It will simulate and run a basic assembly program, hardcoded into ROM, and the output will be displayed via LEDs and 7-segment displays on a BASYS 3 FPGA board.

---

> [!NOTE]
> This `README` is a draft

## ✅ To-Do List for VHDL Components

### 1. Arithmetic & Logic Units
- [ ] **4-bit Add/Subtract Unit**
  - Signed 2’s complement arithmetic
- [ ] **3-bit Adder**
  - Used to increment the Program Counter

### 2. Program Control
- [ ] **3-bit Program Counter (PC)**
  - Use D Flip-Flops with asynchronous reset
- [ ] **Instruction Decoder**
  - Decodes instructions and activates necessary control lines
  - Supports `MOVI`, `ADD`, `NEG`, and `JZR`

### 3. Multiplexers / Data Selection
- [ ] **2-way 3-bit Multiplexer**
- [ ] **2-way 4-bit Multiplexer**
- [ ] **8-way 4-bit Multiplexer**
  - May also use tri-state buffer approach instead

### 4. Registers and Memory
- [ ] **Register Bank**
  - 8 registers, 4-bit wide each
  - R0 hardcoded to 0
  - Use D Flip-Flops with reset
- [ ] **3-to-8 Decoder**
  - Used for register enable lines
- [ ] **Program ROM**
  - Stores assembly program as binary
  - Extend from Lab 7 LUT-based ROM

### 5. Miscellaneous
- [ ] **Tri-state Buffers (optional)**
  - Investigate implementation in VHDL as alternative to muxes
- [ ] **Bus definitions**
  - Use clean bus labels (e.g., `D(3 downto 0)`, `I(11 downto 0)`)

### 6. Top-Level Design
- [ ] Integrate all components into a top-level architecture
- [ ] Simulate to verify correct functionality

### 7. Assembly Program
- [ ] Write a simple program to sum integers 1 through 3
- [ ] Convert to machine code and hardcode into ROM

### 8. Output Handling
- [ ] Connect R7 to LEDs and 7-segment display
- [ ] Connect carry/zero flags to LD14 and LD15

### 9. Final Steps
- [ ] Deploy design on BASYS 3
- [ ] Demonstrate and document functionality
- [ ] Prepare lab report

---

## 🔧 Basic Components (To be reused or modified)

- [x] **Half Adder**
- [x] **Full Adder**
- [x] **Ripple Carry Adder (RCA) 4-bit**
- [ ] **Ripple Carry Adder (RCA) 3-bit**
- [ ] **D Flip-Flop**
- [x] **2-to-4 Decoder**
- [x] **3-to-8 Decoder**
- [x] **2-to-1 Multiplexers**
- [x] **4-to-1 Multiplexers**

---

## 💡 Optional for Extra Credit
- [ ] Optimize for minimal gate usage
- [ ] Add creative extensions (e.g., more instructions, better flags)

---

> [!IMPORTANT]
> Be sure to clearly document each team member's contributions and hours spent in the final report.