format binary as 'gba'

include '../lib/arm.inc'

main:
        b       main_arm
        include '../lib/header.asm'

main_arm:
        mov     r0, 0x05000000
        imm32   r1, 0xFFFFFFFF
        mov     r2, 4
        mov     r3, 1

        ; Simple store
        str     r1, [r0]

        ; Store r1 at r0 + r2
        str     r1, [r0, r2]

        ; Store r1 at r0 + r2 and writeback
        str     r1, [r0, r2]!

        ; Store r1 at r0 + 4 and writeback
        str     r1, [r0, 4]!

        ; Store r1 at r0 - 1 << 3 and writeback
        str     r1, [r0], -r3, lsl 3]!

loop:
        b       loop
