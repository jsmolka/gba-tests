psr_transfer:
        ; Tests for the PSR transfer instruction

t250:
        ; ARM 4: msr cpsr_flg, <op>
        mov     r0, 0

        msr     cpsr_f, r0
        beq     t250f
        bmi     t250f
        bcs     t250f
        bvs     t250f

        b       t251

t250f:
        failed  250

t251:
        msr     cpsr_f, 0xF0000000
        bne     t251f
        bpl     t251f
        bcc     t251f
        bvc     t251f

        b       t252

t251f:
        failed  251

t252:
        ; ARM 4: msr cpsr_ctl, <op>
        mov     r8, 0xA
        mov     r9, 0xB

        msr     cpsr_c, MODE_FIQ
        mov     r8, 0xC
        mov     r9, 0xD

        msr     cpsr_c, MODE_SYS
        cmp     r8, 0xA
        bne     t252f
        cmp     r9, 0xB
        bne     t252f

        b       t253

t252f:
        failed  252

t253:
        ; ARM 4: mrs rd, cpsr / spsr
        ; ARM 4: msr cpsr / spsr, rs
        msr     cpsr_f, 0xF0000000

        mrs     r0, cpsr
        bic     r0, 0xF0000000
        msr     cpsr, r0

        beq     t253f
        bmi     t253f
        bcs     t253f
        bvs     t253f

        b       psr_transfer_passed

t253f:
        failed  253

psr_transfer_passed:
