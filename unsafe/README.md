# Warning
I don't feel comfortable putting these tests into the test suite. The failures on hardware are probably caused by the flash card.

## SRAM Mirror
This test checks the following GBATEK statement:

> The 64K SRAM area is mirrored across the whole 32MB area at E000000h-FFFFFFFh, also, inside of the 64K SRAM field, 32K SRAM chips are repeated twice.

It passes on No$GBA and mGBA but not on real hardware.

## Zero Padded ROM
The ROM area appears to be zero padded up to the next power of two.

The test passes on No$GBA, mGBA and real hardware.

## Unused ROM Reads
This test checks the following GBATEK statement:

> Because Gamepak uses the same signal-lines for both 16bit data and for lower 16bit halfword address, the entire gamepak ROM area is effectively filled by incrementing 16bit values (Address/2 AND FFFFh).

It passes on mGBA but not on No$GBA or real hardware.
