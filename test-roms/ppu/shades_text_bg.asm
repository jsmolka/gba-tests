format binary as 'gba'

include '../lib/header.inc'
include '../lib/utility.inc'

main:
        b       main_arm
        Header

main_arm:
        adr     r0, main_thumb + 1
        bx      r0

code16
align 2
main_thumb:
        ; Setup shades of blue
        mov     r0, 0
        imm32t  r1, 0x5000000
        mov     r2, 16

loop_color:
        strh    r0, [r1]

        ; Increment color
        lsr     r0, 10
        add     r0, 2
        lsl     r0, 10

        add     r1, 2
        sub     r2, 1
        bne     loop_color

        ; Generate 16 background tiles
        mov     r0, 0
        imm32t  r1, 0x6004000
        mov     r2, 16

loop_tiles:
        mov     r4, 32

loop_tile:
        strb    r0, [r1]
        add     r1, 1
        sub     r4, 1
        bne     loop_tile

        add     r0, 0x11
        sub     r2, 1
        bne     loop_tiles

        ; Generate background map
        imm32t  r1, 0x6000800
        mov     r2, 32

loop_map_row:
        mov     r0, 0
        mov     r3, 32

loop_map_col:
        strh    r0, [r1]
        add     r1, 2
        strh    r0, [r1]
        add     r1, 2

        add     r0, 1
        sub     r3, 2
        bne     loop_map_col

        sub     r2, 1
        bne     loop_map_row

        ; Setup DISPCNT
        mov    r0, 1
        lsl    r0, 8
        imm32t r1, 0x4000000
        str    r0, [r1]

        ; Setup BG0CNT
        mov    r0, 0x41
        lsl    r0, 2
        add    r1, 8
        str    r0, [r1]

infinite:
        b      infinite