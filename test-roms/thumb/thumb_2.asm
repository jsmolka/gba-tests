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
  mov r0, 0xF
  mov r1, 0xF0
  add r0, r1
  cmp r0, 0xFF
  bne infinite

  mov r0, 0xF
  add r0, 0xF0
  cmp r0, 0xFF
  bne infinite

  ; Add Z and C flag
  imm32t r0, 0xFFFFFFFF
  add r0, 1
  bne infinite
  bcc infinite

  ; Add N flag
  mov r0, 0
  mov r1, 1
  lsl r1, r1, 31
  add r0, r1
  bpl infinite

  ; Add V flag
  mov r0, 1
  lsl r0, r0, 31
  add r0, 1
  bvs infinite

  add r0, r0
  bvc infinite

  imm32t r0, 0x7FFFFFFF
  add r0, 1
  bvc infinite

  ; Sub
  mov r0, 0xFF
  mov r1, 0xF0
  sub r0, r1
  cmp r0, 0xF
  bne infinite

  mov r0, 0xFF
  sub r0, 0xF0
  cmp r0, 0xF
  bne infinite

  ; Sub Z and N flag
  mov r0, 0
  sub r0, 1
  beq infinite
  bpl infinite

  ; Sub N flag
  mov r0, 2
  sub r0, 1
  bcc infinite

  mov r0, 2
  sub r0, 2
  bcc infinite

  ; Sub V flag
  mov r0, 1
  lsl r0, r0, 31
  add r0, 1
  sub r0, 1
  bvs infinite

  sub r0, 1
  bvc infinite

  TestPassed

  infinite:
    b infinite