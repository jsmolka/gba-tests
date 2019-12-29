format binary as 'gba'

include '../lib/memory.inc'

header:
        include '../lib/header.asm'

main:
        ; Setup DISPCNT
        mov     r0, 1 shl 8
        mov     r1, IO
        strh    r0, [r1, DISPCNT]

        ; Setup BG0CNT
        mov     r0, 0
        mov     r1, IO
        strh    r0, [r1, BG0CNT]

        ; Setup red color
        mov     r0, 0x1F
        mov     r1, PALETTE
        strh    r0, [r1]

loop:
        b       loop