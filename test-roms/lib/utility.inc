; Utility functions

; Load immediate values using arm instructions

macro imm32 reg, immediate {
  mov reg, immediate and $FF
  orr reg, immediate and $FF00
  orr reg, immediate and $FF0000
  orr reg, immediate and $FF000000
}

macro imm24 reg, immediate {
  mov reg, immediate and $FF
  orr reg, immediate and $FF00
  orr reg, immediate and $FF0000
}

macro imm16 reg, immediate {
  mov reg, immediate and $FF
  orr reg, immediate and $FF00
}

; Load immediate values using thumb instructions

macro imm32t reg, immediate {
  mov reg, immediate shr 24 and 0xFF
  lsl reg, 8
  add reg, immediate shr 16 and 0xFF
  lsl reg, 8
  add reg, immediate shr 8 and 0xFF
  lsl reg, 8
  add reg, immediate and 0xFF
}

macro imm24t reg, immediate {
  mov reg, immediate shr 16 and 0xFF
  lsl reg, 8
  add reg, immediate shr 8 and 0xFF
  lsl reg, 8
  add reg, immediate and 0xFF
}

macro imm16t reg, immediate {
  mov reg, immediate shr 8 and 0xFF
  lsl reg, 8
  add reg, immediate and 0xFF
}