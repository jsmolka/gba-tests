; Utility functions for THUMB

macro imm32 reg, imm {
        mov     reg, imm shr 24 and 0xFF
        lsl     reg, 8
        add     reg, imm shr 16 and 0xFF
        lsl     reg, 8
        add     reg, imm shr 8 and 0xFF
        lsl     reg, 8
        add     reg, imm and 0xFF
}

macro imm24 reg, imm {
        mov     reg, imm shr 16 and 0xFF
        lsl     reg, 8
        add     reg, imm shr 8 and 0xFF
        lsl     reg, 8
        add     reg, imm and 0xFF
}

macro imm16 reg, imm {
        mov     reg, imm shr 8 and 0xFF
        lsl     reg, 8
        add     reg, imm and 0xFF
}
