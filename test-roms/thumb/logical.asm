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

  ; AND
  ; Thumb 4: and rd, rs
  mov r0, 0xFF
  mov r1, 0xF
  and r0, r1
  cmp r0, 0xF
  bne infinite

  and r0, r1
  cmp r0, 0xF
  bne infinite

  mov r1, 0
  and r0, r1
  cmp r0, 0
  bne infinite

  ; EOR
  ; Thumb 4: eor rd, rs
  mov r0, 0xF0
  mov r1, 0xF
  eor r0, r1
  cmp r0, 0xFF
  bne infinite

  eor r0, r1
  cmp r0, 0xF0
  bne infinite

  eor r0, r0
  cmp r0, 0
  bne infinite

  ; TST sets condition codes of AND

  TestPassed

  infinite:
    b infinite