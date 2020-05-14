format binary as 'gba'

include '../lib/arm.inc'
include '../lib/constants.inc'

header:
        include '../lib/header.asm'

main:
        ; Setup DISPCNT
        mov     r0, 1 shl 8
        mov     r1, IO
        str     r0, [r1, DISPCNT]

        ; Setup BG0CNT
        mov     r0, 0x41 shl 2
        mov     r1, IO
        str     r0, [r1, BG0CNT]

        ; Setup color 1
        immh    r0, 0x560B
        mov     r1, PALETTE
        strh    r0, [r1]

        ; Setup green color
        immh    r0, 0x6290
        mov     r1, PALETTE
        strh    r0, [r1, 2]

        ; Generate tiles
        immw    r0, 0x11111111
        mov     r1, VRAM
        add     r1, 0x4000
        mov     r2, 32

.loop_tile:
        subs    r2, 4
        str     r0, [r1, r2]
        bne     .loop_tile

        ; Generate map in alternating order
        mov     r0, 1
        mov     r1, VRAM
        add     r1, 0x800
        mov     r2, 0x800

.loop_map:
        strh    r0, [r1]
        add     r1, 4
        subs    r2, 4
        bne     .loop_map

idle:
        b       idle