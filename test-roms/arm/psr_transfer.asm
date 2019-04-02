psr_transfer:
        ; Tests for the PSR transfer instruction

t250:
        ; ARM 4: msr cpsr_flg, <op>
        mov     r0, 0

        msr     cpsr_flg, r0
        beq     t250f
        bmi     t250f
        bcs     t250f
        bvs     t250f

        b       t251

t250f:
        failed  250

t251:
        msr     cpsr_flg, 0xF0000000
        bne     t251f
        bpl     t251f
        bcc     t251f
        bvc     t251f

        b       t252

t251f:
        failed  251

t252:
        ; ARM 4: mrs rd, cpsr / spsr
        ; ARM 4: msr cpsr / spsr, rs
        msr     cpsr_flg, 0xF0000000

        mrs     r0, cpsr
        bic     r0, 0xF0000000
        msr     cpsr, r0

        beq     t252f
        bmi     t252f
        bcs     t252f
        bvs     t252f

        b       psr_transfer_passed

t252f:
        failed  252

psr_transfer_passed:
