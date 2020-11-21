# Attention
Unsafe tests check the following [GBATEK](https://problemkaputt.de/gbatek.htm#gbaunpredictablethings) statement.

> The 64K SRAM area is mirrored across the whole 32MB area at E000000h-FFFFFFFh, also, inside of the 64K SRAM field, 32K SRAM chips are repeated twice.

They pass in mGBA and No$GBA but not on real hardware in combination with an EZ-Flash Omega. Please open an issue if you know why.
