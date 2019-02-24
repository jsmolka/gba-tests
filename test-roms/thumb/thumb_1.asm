format binary as 'gba'

include '../lib/header.inc'
include '../lib/test.inc'

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

  ; LSL
  mov r0, 1
  lsl r0, r0, 3
  cmp r0, 8
  bne infinite

  lsl r1, r0, 3
  cmp r1, 64
  bne infinite

  ; LSL N flag
  mov r0, 1
  lsl r0, r0, 31
  bpl infinite

  ; LSL Z and C flag
  mov r0, 2
  lsl r0, r0, 31
  bcc infinite
  bne infinite

  ; LSR
  mov r0, 64
  lsr r0, r0, 3
  cmp r0, 8
  bne infinite

  lsr r1, r0, 3
  cmp r1, 1
  bne infinite

  ; LSR Z and C flag
  mov r0, 2
  lsr r0, r0, 2
  bcc infinite
  bne infinite

  ; ASR
  mov r0, 64
  asr r0, r0, 3
  cmp r0, 8
  bne infinite

  asr r1, r0, 3
  cmp r1, 1
  bne infinite

  lsl r0, r1, 31
  asr r0, r0, 3
  mov r1, 0xF
  lsl r1, r1, 28
  cmp r0, r1
  bne infinite

  ; ASR Z and C flag
  mov r0, 2
  asr r0, r0, 2
  bcc infinite
  bne infinite

  TestPassed

  infinite:
    b infinite