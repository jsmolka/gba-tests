format binary as 'gba'

include '../../lib/thumb.inc'

header:
        include '../../lib/header.asm'

main:
        adr     r0, main_thumb + 1
        bx      r0

code16
align 2
main_thumb:
        ; Setup red color
        mov     r0, 0x1F
        imm32   r1, 0x5000000
        strh    r0, [r1]

        ; Setup DISPCNT
        mov     r0, 1
        lsl     r0, 8
        imm32   r1, 0x4000000
        strh    r0, [r1]

        ; Setup BG0CNT
        mov     r0, 0
        add     r1, 8
        strh    r0, [r1]

infinite:
        b       infinite