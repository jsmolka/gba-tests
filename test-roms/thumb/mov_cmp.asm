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

  ; Mov / cmp
  mov r0, 1
  cmp r0, 1
  bne infinite

  mov r0, 0xFF
  cmp r0, 0xFF
  bne infinite

  mov r0, 1
  cmp r0, 0
  beq infinite

  ; Mov Z flag
  mov r0, 0
  bne infinite

  ; Cmp Z flag
  mov r0, 0xFF
  cmp r0, 0xFF
  bne infinite

  ; Cmp N flag
  mov r0, 0
  cmp r0, 1
  bpl infinite

  ; Cmp C flag
  mov r0, 2
  cmp r0, 1
  bcc infinite

  mov r0, 1
  cmp r0, 1
  bcc infinite

  ; Cmp V flag
  mov r0, 1
  lsl r0, 31
  cmp r0, 1
  bvc infinite

  ; Add and sub have been tested in thumb 2

  TestPassed

  infinite:
    b infinite