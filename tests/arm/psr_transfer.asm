psr_transfer:
        ; Tests for the PSR transfer instruction

t250:
        ; ARM 4: Read / write PSR
        mrs     r0, cpsr
        bic     r0, 0xF0000000
        msr     cpsr, r0
        beq     f250
        bmi     f250
        bcs     f250
        bvs     f250

        b       t251

f250:
        failed  250

t251:
        ; ARM 4: Write flag bits
        msr     cpsr_f, 0xF0000000
        bne     f251
        bpl     f251
        bcc     f251
        bvc     f251

        b       t252

f251:
        failed  251

t252:
        ; ARM 4: Write control bits
        msr     cpsr_c, MODE_FIQ
        mrs     r0, cpsr
        and     r0, 0x1F
        cmp     r0, MODE_FIQ
        bne     f252

        msr     cpsr_c, MODE_SYS

        b       t253

f252:
        failed  252

t253:
        ; ARM 4: Register banking
        mov     r0, 16
        mov     r8, 32
        msr     cpsr_c, MODE_FIQ
        mov     r0, 32
        mov     r8, 64
        msr     cpsr_c, MODE_SYS
        cmp     r0, 32
        bne     f253
        cmp     r8, 32
        bne     f253

        b       t254

f253:
        failed  253

t254:
        ; ARM 4: Accessing SPSR
        mrs     r0, cpsr
        msr     spsr, r0
        mrs     r1, spsr
        cmp     r1, r0
        bne     f254

        b       psr_transfer_passed

f254:
        failed  254

psr_transfer_passed:
