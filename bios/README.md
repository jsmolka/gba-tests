# BIOS
These tests are made for the BIOS paragraph in [GBATEK's Unpredictable Things](https://problemkaputt.de/gbatek.htm#gbaunpredictablethings).

> The BIOS memory is protected against reading, the GBA allows to read opcodes or data only if the program counter is located inside of the BIOS area. If the program counter is not in the BIOS area, reading will return the most recent successfully fetched BIOS opcode (eg. the opcode at [00DCh+8] after startup and SoftReset, the opcode at [0134h+8] during IRQ execution, and opcode at [013Ch+8] after IRQ execution, and opcode at [0188h+8] after SWI execution).

Which means that BIOS reads return:
- 0xE129F000 (address 0x0DC+8) after startup
- 0xE3A02004 (address 0x188+8) after SWI
- 0x03007FFC (address 0x134+8) during IRQ
- 0xE55EC002 (address 0x13C+8) after IRQ

The values have been verified on mGBA and No$GBA. For some reason the second test, BIOS read after SWI execution, fails on real hardware in combination with an EZ-Flash Omega. Please let me know if you have any explanation on why this is happening.
