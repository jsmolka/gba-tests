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
        ; Carry flag subtraction
        mov     r0, 1
        subs    r0, 0
        bcc     f103

        mov     r0, 1
        subs    r0, 1
        bcc     f103

        mov     r0, 1
        subs    r0, 2
        bcs     f103

        b       t104

f103:
        failed  103

t104:
        ; Overflow flag addition
        immw    r0, 0x7FFFFFFF
        adds    r0, 1
        bvc     f104

        mov     r0, 0
        adds    r0, 1
        bvs     f104

        b       t105

f104:
        failed  104

t105:
        ; Overflow flag subtraction
        mov     r0, 1 shl 31
        subs    r0, 1
        bvc     f105

        mov     r0, 1
        subs    r0, 1
        bcc     f105

        b       flags_passed

f105:
        failed  105

flags_passed:
