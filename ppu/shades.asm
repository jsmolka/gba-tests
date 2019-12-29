format binary as 'gba'

include '../lib/memory.inc'

header:
        include '../lib/header.asm'

main:
        ; Setup DISPCNT
        mov    r0, 1 shl 8
        mov    r1, IO
        str    r0, [r1, DISPCNT]

        ; Setup BG0CNT
        mov    r0, 0x41 shl 2
        mov    r1, IO
        str    r0, [r1, BG0CNT]

        ; Setup shades of blue
        mov     r0, 0
        mov     r1, PALETTE
        mov     r2, 16

loop_color:
        strh    r0, [r1]
        add     r0, 2 shl 10
        add     r1, 2
        subs    r2, 1
        bne     loop_color

        ; Generate 16 background tiles
        mov     r0, 0
        mov     r1, VRAM
        add     r1, 0x4000
        mov     r2, 16

loop_tiles:
        mov     r4, 32

loop_tile:
        strb    r0, [r1]
        add     r1, 1
        subs    r4, 1
        bne     loop_tile

        add     r0, 0x11
        subs    r2, 1
        bne     loop_tiles

        ; Generate background map
        mov     r1, VRAM
        add     r1, 0x800
        mov     r2, 32

loop_map_row:
        mov     r0, 0
        mov     r3, 32

loop_map_col:
        strh    r0, [r1]
        strh    r0, [r1, 2]
        add     r1, 4

        add     r0, 1
        subs    r3, 2
        bne     loop_map_col

        subs    r2, 1
        bne     loop_map_row

loop:
        b      loop