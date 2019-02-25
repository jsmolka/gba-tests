format binary as 'gba'

include '../lib/header.inc'
include '../lib/test.inc'
include '../lib/utility.inc'

main:
  b main_arm
  Header

main_arm:
  adr r0, main_thumb + 1
  bx r0

code16
align 2
main_thumb:
  TestInit

  ; Add
  mov r0, 0
  add r0, 0xF
  mov r1, 0
  add r1, 0xF0
  add r0, r1
  cmp r0, 0xFF
  bne infinite

  mov r0, 0
  mov r1, 0
  add r1, 3
  add r0, r1
  cmp r0, 3
  bne infinite

  ; Add Z and C flag
  imm32t r1, 0xFFFFFF00
  add r1, 0xFF
  add r0, r1, 1
  bne infinite
  bcc infinite

  ; Add N flag
  mov r0, 0
  mov r1, 0
  add r1, 1
  lsl r1, 31
  add r0, r1
  bpl infinite

  ; Add V flag
  mov r0, 1
  lsl r0, 31
  mov r1, 0
  add r1, 1
  add r0, r1
  bvs infinite

  add r0, r0
  bvc infinite

  imm32t r0, 0x7FFFFF00
  add r0, 0xFF
  add r0, r1
  bvc infinite

  ; Sub
  mov r0, 0xFF
  mov r1, 0x0F
  sub r0, r1
  sub r0, 0xF0
  cmp r0, 0
  bne infinite

  mov r0, 0xFF
  sub r0, 0xF0
  mov r1, 0
  add r1, 2
  sub r0, r1
  cmp r0, 0xD
  bne infinite

  ; Sub Z and N flag
  mov r0, 0
  mov r1, 2
  sub r1, 1
  sub r0, r1
  beq infinite
  bpl infinite

  ; Sub N flag
  mov r0, 0xF
  sub r0, 0xD
  sub r0, r1
  bcc infinite

  mov r0, 4
  sub r0, 2
  mov r1, 8
  sub r1, 6
  sub r0, r1
  bcc infinite

  ; Sub V flag
  mov r0, 1
  lsl r0, 31
  mov r1, 0xFF
  sub r1, 0xFE
  add r0, r1
  sub r0, r1
  bvs infinite

  sub r0, r1
  bvc infinite

  TestPassed

  infinite:
    b infinite