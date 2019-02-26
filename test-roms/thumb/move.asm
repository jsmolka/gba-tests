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

  ; MOV
  ; Thumb 3: mov rd, offset8
  mov r0, 0
  cmp r0, 0
  bne infinite

  mov r0, 8
  cmp r0, 8
  bne infinite

  mov r0, 0xFF
  cmp r0, 0xFF
  bne infinite

  TestPassed

  infinite:
    b infinite