; Load immediate word
macro immw reg, imm {
        mov     reg, imm and 0xFF
        orr     reg, imm and 0xFF00
        orr     reg, imm and 0xFF0000
        orr     reg, imm and 0xFF000000
}

; Load immediate halfword
macro immh reg, imm {
        mov     reg, imm and 0xFF
        orr     reg, imm and 0xFF00
}

; CPSR flag modifiers
FLAG_N = 1 shl 31
FLAG_Z = 1 shl 30
FLAG_C = 1 shl 29
FLAG_V = 1 shl 28

; CPSR mode modifiers
MODE_USR = 0x10
MODE_FIQ = 0x11
MODE_IRQ = 0x12
MODE_SVC = 0x13
MODE_ABT = 0x17
MODE_SYS = 0x1F
