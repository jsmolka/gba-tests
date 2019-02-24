format binary as 'gba'

include '../inc/header.inc'

main:
  b main_arm
  Header

main_arm:
  adr r0, main_thumb + 1
  bx r0

code16
align 2
main_thumb:
  ; Setup red color (0x5000000)
  mov r0, 0x1F
  mov r1, 0x5
  lsl r1, r1, 24
  strh r0, [r1]

  ; Setup BG0CNT (0x4000008)
  mov r0, 0
  mov r1, 1
  lsl r1, 26
  add r1, 8
  strh r0, [r1]

  ; Setup DISPCNT (0x4000000)
  mov r0, 1
  lsl r0, 8
  sub r1, 8
  strh r0, [r1]

  infinite:
    b infinite
