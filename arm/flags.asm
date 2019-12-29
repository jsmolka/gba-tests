flags:
        ; Tests for flags

t100:
        ; Zero flag
        movs    r0, 0
        bne     f100

        movs    r0, 1
        beq     f100

        b       t101

f100:
        failed  100

t101:
        ; Negative flag
        movs    r0, 1 shl 31
        bpl     f101

        movs    r0, 0
        bmi     f101

        b       t102

f101:
        failed  101

t102:
        ; Carry flag addition
        mvn     r0, 0
        adds    r0, 1
        bcc     f102

        mov     r0, 0
        adds    r0, 1
        bcs     f102

        b       t103

f102:
        failed  102

t103:
        ; Carry flag addition with carry
        mvn     r0, 0
        sub     r0, 1
        msr     cpsr_f, FLAG_C
        adcs    r0, 1
        bcc     f103

        mov     r0, 0
        msr     cpsr_f, FLAG_C
        adcs    r0, 1
        bcs     f103

        b       t104

f103:
        failed  103

t104:
        ; Carry flag subtraction
        mov     r0, 1
        subs    r0, 0
        bcc     f104

        mov     r0, 1
        subs    r0, 1
        bcc     f104

        mov     r0, 1
        subs    r0, 2
        bcs     f104

        b       t105

f104:
        failed  104

t105:
        ; Carry flag subtraction with carry
        mov     r0, 2
        msr     cpsr_f, 0
        sbcs    r0, 0
        bcc     f105

        mov     r0, 2
        msr     cpsr_f, 0
        sbcs    r0, 1
        bcc     f105

        mov     r0, 2
        msr     cpsr_f, 0
        sbcs    r0, 2
        bcs     f105

        b       t106

f105:
        failed  105

t106:
        ; Overflow flag addition
        immw    r0, 0x7FFFFFFF
        adds    r0, 1
        bvc     f106

        mov     r0, 0
        adds    r0, 1
        bvs     f106

        b       t107

f106:
        failed  106

t107:
        ; Overflow flag addition with carry
        immw    r0, 0x7FFFFFFE
        msr     cpsr_f, FLAG_C
        adcs    r0, 1
        bvc     f107

        mov     r0, 0
        msr     cpsr_f, FLAG_C
        adcs    r0, 1
        bvs     f107

        b       t108

f107:
        failed  107

t108:
        ; Overflow flag subtraction
        mov     r0, 1 shl 31
        subs    r0, 1
        bvc     f108

        mov     r0, 1
        subs    r0, 1
        bvs     f108

        b       t109

f108:
        failed  108

t109:
        ; Overflow flag subtraction with carry
        immw    r0, 0x80000001
        msr     cpsr_f, 0
        sbcs    r0, 1
        bvc     f109

        mov     r0, 2
        msr     cpsr_f, 0
        sbcs    r0, 1
        bvs     f109

        b       flags_passed

f109:
        failed  109

flags_passed:
