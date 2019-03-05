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

  ; B
  ; Thumb 18: b label
  b label_b
  success_b:

  ; BL
  ; Thumb 19: bl label
  bl label_bl
  success_bl:

  TestPassed

  infinite:
    b infinite

label_b:
  b success_b

label_bl:
  bl success_bl