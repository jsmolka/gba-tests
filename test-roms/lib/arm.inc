; Utility functions for ARM

macro imm32 reg, imm {
        mov     reg, imm and 0xFF
        orr     reg, imm and 0xFF00
        orr     reg, imm and 0xFF0000
        orr     reg, imm and 0xFF000000
}

macro imm24 reg, imm {
        mov     reg, imm and 0xFF
        orr     reg, imm and 0xFF00
        orr     reg, imm and 0xFF0000
}

macro imm16 reg, imm {
        mov     reg, imm and 0xFF
        orr     reg, imm and 0xFF00
}

