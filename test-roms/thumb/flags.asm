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

  ; Z flag
  mov r0, 1
  beq infinite

  mov r0, 0
  bne infinite

  ; N flag
  mov r0, 1
  bmi infinite

  lsl r0, 31
  bpl infinite

  ; C flag LSL
  mov r0, 1
  lsl r0, 31
  bcs infinite

  lsl r0, 1
  bcc infinite

  ; C flag LSR
  mov r0, 2
  lsr r0, 1
  bcs infinite

  lsr r0, 1
  bcc infinite

  ; C flag ASR
  mov r0, 2
  lsr r0, 1
  bcs infinite

  lsr r0, 1
  bcc infinite

  ; C flag ADD
  imm32t r0, 0xFFFFFFFE
  add r0, 1
  bcs infinite

  add r0, 1
  bcc infinite

  ; C flag SUB
  mov r0, 4
  sub r0, 8
  bcs infinite

  mov r0, 8
  sub r0, 4
  bcc infinite

  sub r0, 4
  bcc infinite

  ; V flag ADD
  imm32t r0, 0x7FFFFFFE
  add r0, 1
  bvs infinite

  add r0, 1
  bvc infinite

  ; V flag SUB
  imm32t r0, 0x80000001
  sub r0, 1
  bvs infinite

  sub r0, 1
  bvc infinite

  TestPassed

  infinite:
    b infinite