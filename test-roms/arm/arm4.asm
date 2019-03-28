arm4:
        ; Tests for Arm 4 instruction

t300:
        ; Set carry
        cmp     r0, r0
        mrs     r0, cpsr
        ; Clear carry
        bic     r0, r0, 0x20000000
        msr     cpsr, r0

        bcs     t300f

        b       t301

t300f:
        Failed 300

t301:
        cmp     r0, r0
        msr     cpsr_flg, 0x00000000

        beq     t301f
        bmi     t301f
        bcs     t301f
        bvs     t301f

        b       passed

t301f:
        Failed 301




