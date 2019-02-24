format binary as 'gba'

include '../inc/header.inc'
include '../inc/test.inc'

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

  b success

  infinite:
    b infinite

success:
  TestSuccessful
  b infinite