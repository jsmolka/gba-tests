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
  ; Thumb 1: lsl rd, rs, offset5
  mov r0, 1
  lsl r1, r0, 3
  cmp r1, 8
  bne infinite

  lsl r0, r1, 3
  cmp r0, 64
  bne infinite

  ; Thumb 4: lsl rd, rs
  mov r0, 1
  mov r1, 3
  lsl r0, r1
  cmp r0, 8
  bne infinite

  lsl r0, r1
  cmp r0, 64
  bne infinite

  ; Special case
  mov r0, 1
  mov r1, 0
  cmp r0, 2
  lsl r0, r1
  bcs infinite
  cmp r0, 1
  bne infinite

  mov r0, 1
  cmp r0, r0
  lsl r0, r1
  bcc infinite
  cmp r0, 1
  bne infinite

  ; LSR
  ; Thumb 1: lsr rd, rs, offset5
  mov r0, 64
  lsr r1, r0, 3
  cmp r1, 8
  bne infinite

  lsr r0, r1, 3
  cmp r0, 1
  bne infinite

  ; Thumb 4: lsr rd, rs
  mov r0, 64
  mov r1, 3
  lsr r0, r1
  cmp r0, 8
  bne infinite

  lsr r0, r1
  cmp r0, 1
  bne infinite

  ; Special case
  mov r0, 1
  lsr r0, 32
  bne infinite
  bcs infinite

  mov r0, 1
  lsl r0, 31
  lsr r0, 32
  bne infinite
  bcc infinite

  ; ASR
  ; Thumb 1: asr rd, rs, offset5
  mov r0, 64
  asr r1, r0, 3
  cmp r1, 8
  bne infinite

  asr r0, r1, 3
  cmp r0, 1
  bne infinite

  mov r0, 1
  lsl r0, 31
  asr r1, r0, 3
  mov r0, 0xF
  lsl r0, 28
  cmp r0, r1
  bne infinite

  ; Thumb 4: asr rd, rs
  mov r0, 64
  mov r1, 3
  asr r0, r1
  cmp r0, 8
  bne infinite

  asr r0, r1
  cmp r0, 1
  bne infinite

  mov r0, 1
  lsl r0, 31
  mov r1, 3
  asr r0, r1
  mov r1, 0xF
  lsl r1, 28
  cmp r0, r1
  bne infinite

  ; Special case
  mov r0, 1
  asr r0, 32
  bne infinite
  bcs infinite

  imm32t r1, 0xFFFFFFFF
  mov r0, 1
  lsl r0, 31
  asr r0, 32
  bcc infinite
  cmp r0, r1
  bne infinite

  ; ROR
  ; Thumb 4: ror rd, rs
  mov r0, 0xF0
  mov r1, 4
  ror r0, r1
  cmp r0, 0xF
  bne infinite

  mov r0, 0xFF
  imm32t r2, 0xF000000F
  ror r0, r1
  cmp r0, r2
  bne infinite

  ; Special case
  ; mov r0, 1
  ; mov r1, 0
  ; mov r2, 1
  ; lsl r2, 31
  ; cmp r0, r0
  ; ror r0, r1
  ; cmp r0, r2
  ; bne infinite
  ; bcc infinite

  TestPassed

  infinite:
    b infinite