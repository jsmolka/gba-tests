format binary as 'gba'

code32

main:
        b rom_start
        include "common/header.asm"

org 0xC0
rom_start:
        adr r0, thumb_start + 1
        bx r0

code16  ; Enter thumb mode

align 2
thumb_start:
        ; Generate 15-bit color for red
        mov r0, 0
        add r0, 0x1F

        ; Generate address for palette #0, color #1 (0x5000002)
        mov r1, 0
        add r1, 5
        lsl r1, r1, 24

        ; Store color
        strh r0, [r1]

        ; Generate BG0CNT value
        lsr r0, 31
        add r0, 0x41
        lsl r0, 2

        ; Generate address for BG0CNT
        lsr r1, 31
        add r1, r1, 1
        lsl r1, 26
        add r1, 8
        str r0, [r1]

        ; Generate value for DISPCNT
        lsr r0, 31
        add r0, r0, 1
        lsl r0, 8

        ; Generate address for DISPCNT
        sub r1, 8
        str r0, [r1]

infinite:
        lsl r0, r0, 0
        lsl r0, r0, 0
        lsl r0, r0, 0

        b infinite
