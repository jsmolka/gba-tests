arithmetic:
        ; Tests for arithmetic operations

t100:
        ; Carry flag addition
        mov     r0, 0
        mvn     r0, r0
        add     r0, 1
        bcc     f100

        mov     r0, 0
        add     r0, 1
        bcs     f100

        b       t101

f100:
        failed  100

t101:
        ; Carry flag subtraction
        mov     r0, 2
        sub     r0, 3
        bcs     f101

        mov     r0, 2
        sub     r0, 2
        bcc     f101

        mov     r0, 2
        sub     r0, 1
        bcc     f101

        b       t102

f101:
        failed  101

t102:
        ; Overflow flag addition
        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        add     r0, 1
        bvc     f102

        mov     r0, 0
        add     r0, 1
        bvs     f102

        b       t103

f102:
        failed  102

t103:
        ; Overflow flag subtraction
        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        bvc     f103

        mov     r0, 1
        sub     r0, 1
        bvs     f103

        b       t104

f103:
        failed  103

t104:
        ; THUMB 2: add rd, rs, imm3
        mov     r0, 0
        add     r0, 4
        cmp     r0, 4
        bne     f104

        b       t105

f104:
        failed  104

t105:
        ; THUMB 3: add rd, imm8
        mov     r0, 32
        add     r0, 32
        cmp     r0, 64
        bne     f105

        b       t106

f105:
        failed  105

t106:
        ; THUMB 5: add rd, rs (high registers)
        mov     r0, 32
        mov     r1, 0
        mov     r8, r1
        mov     r9, r1
        add     r8, r0
        add     r9, r8
        add     r0, r9
        cmp     r0, 64
        bne     f106

        b       t107

f106:
        failed  106

t107:
        ; THUMB 12: add rd, sp, imm8 << 2
        add     r0, sp, 32
        mov     r1, sp
        add     r1, 32
        cmp     r1, r0
        bne     f107

        b       t108

f107:
        failed  107

t108:
        ; THUMB 12: add rd, pc, imm8 << 2
        add     r0, pc, 32
        mov     r1, pc
        add     r1, 28
        cmp     r1, r0
        bne     f108

        b       t109

f108:
        failed  108

t109:
        ; THUMB 13: add sp, imm7 << 2
        mov     r0, sp
        add     sp, 32
        add     sp, -32
        cmp     sp, r0
        bne     f109

        b       t110

f109:
        failed  109

t110:
        ; THUMB 4: adc rd, rs
        mov     r0, 16
        cmn     r0, r0
        adc     r0, r0
        cmp     r0, 32
        bne     f110

        mov     r0, 16
        cmp     r0, r0
        adc     r0, r0
        cmp     r0, 33
        bne     f110

        b       t111

f110:
        failed  110

t111:
        ; THUMB 2: sub rd, rs, imm3
        mov     r0, 8
        sub     r0, 4
        cmp     r0, 4
        bne     f111

        b       t112

f111:
        failed  111

t112:
        ; THUMB 3: sub rd, imm8
        mov     r0, 64
        sub     r0, 32
        cmp     r0, 32
        bne     f112

        b       t113

f112:
        failed  112

t113:
        ; THUMB 2: sub rd, rs, rn
        mov     r0, 64
        mov     r1, 32
        sub     r0, r1
        cmp     r0, r1
        bne     f113

        b       t114

f113:
        failed  113

t114:
        ; THUMB 4: sbc rd, rs
        mov     r0, 32
        mov     r1, 16
        cmn     r0, r0
        sbc     r0, r1
        cmp     r0, 15
        bne     f114

        mov     r0, 32
        mov     r1, 16
        cmp     r0, r0
        sbc     r0, r1
        cmp     r0, 16
        bne     f114

        b       t115

f114:
        failed  114

t115:
        ; THUMB 4: neg rd, rs
        mov     r0, 32
        mov     r1, 0
        sub     r1, r0
        neg     r0, r0
        cmp     r0, r1
        bne     f115

        b       t116

f115:
        failed  115

t116:
        ; THUMB 3: cmp rd, imm8
        mov     r0, 32
        cmp     r0, 32
        bne     f116

        b       t117

f116:
        failed  116

t117:
        ; THUMB 4: cmp rd, rs
        mov     r0, 32
        cmp     r0, r0
        bne     f117

        b       t118

f117:
        failed  117

t118:
        ; THUMB 5: cmp rd, rs (high registers)
        mov     r0, 32
        mov     r8, r0
        cmp     r8, r8
        bne     f118

        b       t119

f118:
        failed  118

t119:
        ; THUMB 4: cmn rd, rs
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 1
        cmn     r0, r1
        bne     f119

        b       t120

f119:
        failed  119

t120:
        ; THUMB 4: mul rd, rs
        mov     r0, 32
        mov     r1, 2
        mul     r0, r1
        cmp     r0, 64
        bne     f120

        b       arithmetic_passed

f120:
        failed  120

arithmetic_passed:
