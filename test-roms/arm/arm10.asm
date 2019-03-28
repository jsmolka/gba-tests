arm10:
        ; Tests for Arm 10 instruction
        mov     r12, 0x05000000

t250:
        mvn     r0, 0
        str     r0, [r12]
        mov     r1, 0xDD000000

        swp     r2, r1, [r12]
        cmp     r2, r0
        bne     t250f

        ldr     r3, [r12]
        cmp     r3, r1
        bne     t250f

        b       t251

t250f:
        Failed 250

t251:
        imm32   r0, 0xEEEEEEEE
        str     r0, [r12]
        mov     r1, 0xAA

        swp     r1, r1, [r12]
        cmp     r1, r0
        bne     t251f

        ldr     r0, [r12]
        cmp     r0, 0xAA
        bne     t251f

        b       passed

t251f:
        Failed 251



