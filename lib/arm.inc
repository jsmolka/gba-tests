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
