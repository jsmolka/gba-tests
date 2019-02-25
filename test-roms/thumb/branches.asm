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

  ; Positive branch
  b success

  infinite:
    b infinite

success:
  TestPassed
  ; Negative branch
  b infinite