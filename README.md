# GBA Suite
A Game Boy Advance test suite.

## General
There are separate tests for the ARM and Thumb instruction set. They display either a green background on success or a red background on failure. The ID of the failed test can be found in R12 for ARM tests and R7 for Thumb tests.

## Building
All tests can be assembled with [FASMARM](https://arm.flatassembler.net/).
