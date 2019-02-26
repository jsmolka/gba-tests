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

  ; ADD
  ; Thumb 2: add rd, rs, rn / offset3
  mov r0, 8
  add r1, r0, r0
  cmp r1, 16
  bne infinite

  add r0, r0, r1
  cmp r0, 24
  bne infinite

  ; Thumb 3: add rd, offset8
  mov r0, 8
  add r0, 8
  cmp r0, 16
  bne infinite

  add r0, 8
  cmp r0, 24
  bne infinite

  ; ADC
  ; Thumb 4: adc rd, rs
  mov r0, 8
  mov r1, 8
  cmp r0, r1
  adc r0, r1
  cmp r0, 17
  bne infinite

  mov r0, 1
  lsl r0, 3
  adc r0, r0
  cmp r0, 16
  bne infinite

  ; SUB
  ; Thumb 2: add rd, rs, rn / offset3
  mov r0, 34
  sub r1, r0, 4
  cmp r1, 30
  bne infinite

  sub r0, r1, 2
  cmp r0, 28
  bne infinite

  ; Thumb 3: add rd, offset8
  mov r0, 16
  sub r0, 8
  cmp r0, 8
  bne infinite

  mov r0, 0xFF
  sub r0, 0xF0
  cmp r0, 0xF
  bne infinite

  ; SBC
  ; Thumb 4: sbc rd, rs
  mov r0, 32
  mov r1, 8
  mov r2, 2
  lsl r2, 31
  sbc r0, r1
  cmp r0, 24
  bne infinite

  mov r1, 1
  lsl r1, 3
  sbc r0, r1
  cmp r0, 15
  bne infinite

  ; CMP sets condition codes of SUB

  TestPassed

  infinite:
    b infinite