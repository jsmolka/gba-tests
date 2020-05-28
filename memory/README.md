# Attention
The tests in `mirrors32.asm` check the following [GBATEK](https://problemkaputt.de/gbatek.htm#gbaunpredictablethings) statements.

> Even though VRAM is sized 96K (64K+32K), it is repeated in steps of 128K (64K+32K+32K, the two 32K blocks itself being mirrors of each other).

> The 64K SRAM area is mirrored across the whole 32MB area at E000000h-FFFFFFFh, also, inside of the 64K SRAM field, 32K SRAM chips are repeated twice.

They pass in mGBA and No$GBA but not on real hardware in combination with an EZ-Flash Omega. Please open an issue if you know why.
