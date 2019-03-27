arm6:
        ; Tests for Arm 6 instruction

t100:
        ; Arm 6: umull{cond}{s} rdlo, rdhi, rm, rs (regs != 15)
        mov     r0, 2
        mov     r1, 8
        umull   r0, r1, r0, r1

        cmp     r0, 16
        bne     t100f

        cmp     r1, 0
        bne     t100f

        b       t101

t100f:
        Failed 100

t101:
        mov     r0, 2
        mov     r1, 8
        umull   r1, r0, r0, r1

        cmp     r1, 16
        bne     t101f

        cmp     r0, 0
        bne     t101f

        b       t102

t101f:
        Failed 101

t102:
        mov     r0, 2
        mov     r1, 0xFF000000
        umull   r0, r1, r0, r1

        cmp     r0, 0xFE000000
        bne     t102f

        cmp     r1, 1
        bne     t102f

        b       t103

t102f:
        Failed 102

t103:
        mov     r0, 2
        mov     r1, 0xFF000000
        umull   r1, r0, r0, r1

        cmp     r1, 0xFE000000
        bne     t103f

        cmp     r0, 1
        bne     t103f

        b       t104

t103f:
        Failed 103

t104:
        ; Arm 6: umlal{cond}{s} rdlo, rdhi, rm, rs (regs != 15)
        mov     r0, 1
        mov     r1, 0xFF000000
        mov     r2, r1
        mov     r3, 2
        umlal   r0, r1, r2, r3

        add     r2, 1
        mov     r3, 0xFE000000
        add     r3, 1

        cmp     r0, r3
        bne     t104f

        cmp     r1, r2
        bne     t104f

        b       t105

t104f:
        Failed 104

t105:
        ; Arm 6: smull{cond}{s} rdlo, rdhi, rm, rs (regs != 15)
        mov     r0, 2
        mov     r1, 8
        smull   r0, r1, r0, r1

        cmp     r0, 16
        bne     t105f

        cmp     r1, 0
        bne     t105f

        b       t106

t105f:
        Failed 105

t106:
        mov     r0, 2
        ; -5 in two's complement
        imm32   r1, 0xFFFFFFFB
        smull   r0, r1, r0, r1

        imm32   r2, 0xFFFFFFFF
        cmp     r1, r2
        bne     t106f

        imm32   r3, 0xFFFFFFF6
        cmp     r0, r3
        bne     t106f

        b       t107

t106f:
        Failed 106

t107:
        ; Arm 6: smlal{cond}{s} rdlo, rdhi, rm, rs (regs != 15)
        mov     r0, 0x000000FF
        mov     r3, r0
        mov     r1, 0xFF000000
        mov     r4, r1
        mov     r2, 0

        smlal   r3, r4, r2, r2

        cmp     r3, r0
        bne     t107f

        cmp     r4, r1
        bne     t107f

        b       passed

t107f:
        Failed 107
