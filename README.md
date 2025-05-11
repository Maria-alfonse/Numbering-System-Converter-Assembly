# Numbering System Converter (Assembly)
A MIPS assembly program to convert numbers between different bases (2–16), including binary, octal, decimal, and hexadecimal.

## 📌 Overview
- Written in MIPS Assembly for the MARS simulator.
- Takes 3 user inputs:
  1. Input base (e.g., 2, 10, 16)
  2. Number in that base
  3. Target base to convert to
- Converts using two main procedures:
  - `OtherToDecimal`: Converts any base to decimal
  - `DecimalToOther`: Converts decimal to any base

## ✅ Features
- Supports arbitrary base conversions (2–16)
- Input validation with error messages for invalid digits
- Clear prompts and output

## 🧪 Example
Enter the current system: 2
Enter the number: 100101
Enter the new system: 10

The number in the new system: 37

## ▶ How to Run
1. Open `project.asm` in [MARS](http://courses.missouristate.edu/kenvollmar/mars/)
2. Assemble and run (F5)
3. Follow input prompts

## 📂 Files
- `project.asm`: Full source code with labeled procedures

## 🏷️ Notes
- Built for Cairo University's Computer Architecture course (Fall 2024)
- MARS Simulator is required
- Bonus: Input base-check validation included
