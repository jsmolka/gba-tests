# GBA Suite
A Game Boy Advance test suite.

## Usage
The suite contains separate tests for the ARM and Thumb instruction set. They display either a green background on success or a red background on failure. The failed test's ID is stored in R12 (ARM) or R7 (Thumb).

## Building
All tests can be assembled with [FASMARM](https://arm.flatassembler.net/).
