psr_transfer:
        ; Tests for the PSR transfer instruction

t250:
        ; ARM 4: Read / write CPSR / SPSR
        mrs     r0, cpsr
        bic     r0, 0xF0000000
        orr     r0, FLAG_V
        msr     cpsr, r0
        bvc     f250

        b       t251

f250:
        failed  250

t251:
        ; ARM 4: Write flag bits
        msr     cpsr_f, FLAG_V
        bvc     f251

        b       t252

f251:
        failed  251

t252:
        ; ARM 4: Write control bits
        mov     r8, 32
        msr     cpsr_c, MODE_FIQ
        mov     r8, 64
        msr     cpsr_c, MODE_SYS
        cmp     r8, 32
        bne     f252

        b       t253

f252:
        failed  252

t253:
        ; ARM 4: Operand types
        mov     r0, FLAG_V
        msr     cpsr_f, r0
        bvc     f253

        msr     cpsr_f, 0
        bvs     f253

        b       psr_transfer_passed

f253:
        failed  253

psr_transfer_passed:
