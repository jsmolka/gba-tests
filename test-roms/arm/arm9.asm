arm9:
        ; Tests for Arm 9 instruction

t350:
        mov     r0, 0
        mov     r1, 1
        mov     r2, 2
        mov     r3, 3
        mov     r4, 4
        mov     r5, 5

        stmfd   sp!, {r0-r5}
        ldmfd   sp!, {r6-r11}

        cmp     r0, r6
        bne     t350f
        cmp     r1, r7
        bne     t350f
        cmp     r2, r8
        bne     t350f
        cmp     r3, r9
        bne     t350f
        cmp     r4, r10
        bne     t350f
        cmp     r5, r11
        bne     t350f

        b       passed

t350f:
        Failed 350
