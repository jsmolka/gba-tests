; Utility functions

; Load immediate values using arm instructions

macro imm32 reg, imm {
      mov   reg, imm and 0xFF
      orr   reg, imm and 0xFF00
      orr   reg, imm and 0xFF0000
      orr   reg, imm and 0xFF000000
}

macro imm24 reg, imm {
      mov   reg, imm and 0xFF
      orr   reg, imm and 0xFF00
      orr   reg, imm and 0xFF0000
}

macro imm16 reg, imm {
      mov   reg, imm and 0xFF
      orr   reg, imm and 0xFF00
}

; Load immediate values using thumb instructions

macro imm32t reg, imm {
      mov    reg, imm shr 24 and 0xFF
      lsl    reg, 8
      add    reg, imm shr 16 and 0xFF
      lsl    reg, 8
      add    reg, imm shr 8 and 0xFF
      lsl    reg, 8
      add    reg, imm and 0xFF
}

macro imm24t reg, imm {
      mov    reg, imm shr 16 and 0xFF
      lsl    reg, 8
      add    reg, imm shr 8 and 0xFF
      lsl    reg, 8
      add    reg, imm and 0xFF
}

macro imm16t reg, imm {
      mov    reg, imm shr 8 and 0xFF
      lsl    reg, 8
      add    reg, imm and 0xFF
}