# README for Final Project

## Overview
This project designs a game inspired by SuperMario Bros, mostly written by SystemVerilog, along with software supporting the USB driver.

## How to run
To get started with this project, you need to set up an FPGA development environment and a C compilation environment:
1. Install the required software for FPGA development (e.g., Xilinx Vivado).
2. Set up your C environment compatible with the hardware for USB control (e.g., ARM GCC Compiler).
3. Compile the SystemVerilog files using your FPGA development tools.
4. Import the xsa bitstream and compile `lw_usb_main.c` using your C compiler and upload it to the corresponding hardware.
5. Run the code
