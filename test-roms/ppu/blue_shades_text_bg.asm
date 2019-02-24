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
  ; Setup palette for different blue shades (0x5000000)
  mov r0, 0
  mov r1, 5
  lsl r1, r1, 24

  ; Loop over all 16 shades
  mov r2, 16
  loop_color:
    strh r0, [r1]

    ; Increment color
    lsr r0, r0, 10
    add r0, 2
    lsl r0, r0, 10

    add r1, 2
    sub r2, 1
    bne loop_color

  ; Generate base address for background tiles (0x6004000)
  mov r1, 6
  lsl r1, r1, 12
  add r1, 4
  lsl r1, r1, 12

  ; Generate background tiles (tile for each color)
  mov r0, 0
  mov r2, 16
  loop_tiles:

     mov r4, 32
     loop_tile:
       strb r0, [r1]
       add r1, 1
       sub r4, 1
       bne loop_tile

    add r0, 0x11
    sub r2, 1
    bne loop_tiles

  ; Generate base address for background map (0x6000800)
  mov r1, 6
  lsl r1, r1, 16
  add r1, 8
  lsl r1, r1, 8

  ; Generate background map
  mov r2, 32
  loop_map_row:
    mov r0, 0

    mov r3, 32
    loop_map_col:
      strh r0, [r1]
      add r1, 2
      strh r0, [r1]
      add r1, 2

      add r0, 1
      sub r3, 2
      bne loop_map_col

    sub r2, 1
    bne loop_map_row

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