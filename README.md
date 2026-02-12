# Smart Home Automation – Verilog

This project implements a synchronous smart home automation controller using Verilog.

## Overview
The design controls multiple home appliances based on mode selection and an enable signal, ensuring state retention across clock cycles.

## Features
- FSM-style, clocked control logic
- Independent control of multiple appliances
- Enable-gated updates for state persistence
- Reset handling and synchronous operation

## Controlled Outputs
- Light
- Fan
- Air Conditioner
- Heater
- Washing Machine
- Water Alarm

## Verification
- Directed Verilog testbench
- Reset validation
- Mode decoding checks
- State retention verification
- Simulation-based waveform analysis

## Tools Used
- Verilog HDL
- Xilinx Vivado (simulation)

This project was developed as part of VLSI design training coursework.
