flags:
        ; Tests for flags

t100:
        ; Zero flag
        movs    r0, 0
        bne     t100f

        movs    r0, 1
        beq     t100f

        b       t101

t100f:
        failed  100

t101:
        ; Negative flag
        movs    r0, 0
        bmi     t101f

        mvns    r0, 0
        bpl     t101f

        b       t102

t101f:
        failed  101

t102:
        ; Carry flag addition
        mvn     r0, 0

        adds    r0, 1
        bcc     t102f

        adds    r0, 1
        bcs     t102f

        b       t103

t102f:
        failed  102

t103:
        ; Carry flag subtraction
        mov     r0, 1

        subs    r0, 2
        bcs     t103f

        mov     r0, 3

        subs    r0, 2
        bcc     t103f

        subs    r0, 1
        bcc     t103f

        b       t104

t103f:
        failed  103

t104:
        ; Overflow flag addition
        mov     r0, 0x80000000
        sub     r0, 1

        adds    r0, 1
        bvc     t104f

        adds    r0, 1
        bvs     t104f

        b       t105

t104f:
        failed  104

t105:
        ; Overflow flag subtraction
        mov     r0, 0x80000000

        subs    r0, 1
        bvc     t105f

        subs    r0, 1
        bcc     t105f

        b       flags_end

t105f:
        failed  105

flags_end:




