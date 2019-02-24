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
  ; Setup cyan color (0x5000000)
  mov r0, 0x1F
  lsl r0, r0, 5
  add r0, 0x1F
  lsl r0, r0, 5
  mov r1, 0x5
  lsl r1, r1, 24
  strh r0, [r1]

  ; Setup magenta color (0x5000002)
  mov r0, 0x1F
  lsl r0, r0, 10
  add r0, 0x1F
  add r1, 2
  strh r0, [r1]

  ; Generate base address for background tiles (0x6004000)
  mov r1, 6
  lsl r1, r1, 12
  add r1, 4
  lsl r1, r1, 12

  ; Generate magenta background tile
  mov r0, 0x11
  mov r2, 32
  loop_tile:
    strb r0, [r1]
    add r1, 1
    sub r2, 1
    bne loop_tile

  ; Generate base address for background map (0x6000800)
  mov r1, 6
  lsl r1, r1, 16
  add r1, 8
  lsl r1, r1, 8

  ; Generate background map in alternating order 0x800 times
  mov r0, 1
  mov r2, 0x80
  lsl r2, r2, 4
  loop_map:
    strh r0, [r1]
    add r1, 4
    sub r2, 4
    bne loop_map

  ; Setup BG0CNT (0x4000008)
  mov r0, 0x41
  lsl r0, 2
  mov r1, 1
  lsl r1, 26
  add r1, 8
  str r0, [r1]

  ; Setup DISPCNT (0x4000000)
  mov r0, 1
  lsl r0, 8
  sub r1, 8
  str r0, [r1]

  infinite:
    b infinite
