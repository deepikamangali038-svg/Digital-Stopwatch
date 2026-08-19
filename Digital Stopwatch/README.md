# Digital Stopwatch using Verilog

A simple digital stopwatch implemented using pure Verilog HDL.

The stopwatch displays time in the format:

    MM:SS

It supports:

- Reset
- Start
- Stop
- Seconds counting
- Minutes counting
- Automatic rollover

## Project Description

This project implements a digital stopwatch using Verilog.

The stopwatch counts from:

    00:00

up to:

    59:59

After 59:59, the stopwatch rolls over to:

    00:00

The design uses counters to generate the seconds and minutes digits.

## Features

- Pure Verilog HDL
- Start/Stop control
- Reset control
- MM:SS time format
- Seconds counter
- Minutes counter
- Automatic rollover
- Verilog testbench
- Simulation output

## Time Format

The four output digits represent:

```text
minutes_tens minutes_units : seconds_tens seconds_units

       0          0              0           0

                  00:00
