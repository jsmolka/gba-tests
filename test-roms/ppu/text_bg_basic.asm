format binary as 'gba'

main:
  b main_arm
  include '../inc/header.inc'

main_arm:
  adr r0, main_thumb + 1
  bx r0

code16
align 2
main_thumb:
  ; Generate 15-bit color for red
  mov r0, 0x1F

  ; Store color at palette 0 color 0 (0x5000000)
  mov r1, 0x5
  lsl r1, r1, 24
  strh r0, [r1]

  ; Generate BG0CNT value
  mov r0, 0

  ; Store BG0CNT (0x4000008)
  mov r1, 1
  lsl r1, 26
  add r1, 8
  str r0, [r1]

  ; Generate value for DISPCNT
  mov r0, 1
  lsl r0, 8

  ; Store DISPCNT (0x4000000)
  sub r1, 8
  str r0, [r1]

infinite:
  b infinite
