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
        ; Setup red color
        mov     r0, 0x1F
        imm32t  r1, 0x5000000
        strh    r0, [r1]

        ; Setup green color
        lsl     r0, 5
        add     r1, 2
        strh    r0, [r1]

        ; Generate green tile
        mov     r0, 0x11
        imm32t  r1, 0x6004000
        mov     r2, 32

loop_tile:
        strb    r0, [r1]
        add     r1, 1
        sub     r2, 1
        bne     loop_tile

        ; Generate map in alternating order
        mov     r0, 1
        imm32t  r1, 0x6000800
        imm16t  r2, 0x800

loop_map:
        strh    r0, [r1]
        add     r1, 4
        sub     r2, 4
        bne     loop_map

        ; Setup DISPCNT
        mov     r0, 1
        lsl     r0, 8
        imm32t  r1, 0x4000000
        str     r0, [r1]

        ; Setup BG0CNT
        mov     r0, 0x41
        lsl     r0, 2
        add     r1, 8
        str     r0, [r1]

infinite:
        b       infinite