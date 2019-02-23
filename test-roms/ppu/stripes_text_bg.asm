format binary as 'gba'

main:
  b main_arm
  include '../common/header.asm'

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

  ; Generate 15-bit color for green
  mov r0, 0x1F
  lsl r0, r0, 8

  ; Store color at palette 0 color 1 (0x5000002)
  add r1, 2
  strh r0, [r1]

  ; Generate green background tile data
  mov r0, 0x11

  ; Generate address for background tiles (0x6004000)
  mov r1, 6
  lsl r1, r1, 12
  add r1, 4
  lsl r1, r1, 12

  ; Generate green background tile
  mov r2, 0x20

loop_data:
  strb r0, [r1]
  add r1, 2
  sub r2, 2
  bne loop_data

  ; Generate address for background map (0x6000800)
  mov r1, 6
  lsl r1, r1, 16
  add r1, 8
  lsl r1, r1, 8

  ; Generate map value for green tile
  mov r0, 1

  ; Write background tiles in alternating order 0x800 times
  mov r2, 0x80
  lsl r2, r2, 4

loop_map:
  strh r0, [r1]
  add r1, 4
  sub r2, 4
  bne loop_map

  ; Generate BG0CNT value
  mov r0, 0x41
  lsl r0, 2

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
