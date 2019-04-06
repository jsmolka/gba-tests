arithmetic:
        ; Tests for arithmetic operations

t100:
        ; Carry addition
        mov     r0, 1
        mvn     r0, r0

        add     r0, 1
        bcs     t100f

        add     r0, 1
        bcc     t100f

        b       t101

t100f:
        failed  100

t101:
        ; Carry subtraction
        mov     r0, 1
        sub     r0, 2
        bcs     t101f

        mov     r0, 1
        sub     r0, 1
        bcc     t101f

        mov     r0, 1
        sub     r0, 0
        bcc     t101f

        b       t102

t101f:
        failed  101

t102:
        ; Overflow addition
        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1

        add     r0, 1
        bvc     t102f

        add     r0, 1
        bvs     t102f

        b       t103

t102f:
        failed  102

t103:
        ; Overflow subtraction
        mov     r0, 1
        lsl     r0, 31

        sub     r0, 1
        bvc     t103f

        sub     r0, 1
        bvs     t103f

        b       t104

t103f:
        failed  103

t104:
        ; THUMB 2: add rd, rs, imm3
        mov     r0, 0
        add     r0, 4
        add     r0, 4
        cmp     r0, 8
        bne     t104f

        b       t105

t104f:
        failed  104

t105:
        ; THUMB 3: add rd, imm8
        mov     r0, 0
        add     r0, 64
        add     r0, 128
        cmp     r0, 192
        bne     t105f

        b       t106

t105f:
        failed  105

t106:
        ; THUMB 5: add rd, rs (high registers)
        mov     r0, 1
        mov     r1, 0
        mov     r8, r1
        mov     r9, r1

        add     r8, r0
        add     r9, r8
        add     r0, r9
        cmp     r0, 2
        bne     t106f

        b       t107

t106f:
        failed  106

t107:
        ; THUMB 12: add rd, sp, imm8 << 2
        add     r0, sp, 64
        mov     r1, sp
        add     r1, 64
        cmp     r1, r0
        bne     t107f

        b       t108

t107f:
        failed  107

t108:
        ; THUMB 12: add rd, pc, imm8 << 2
        add     r0, pc, 64
        mov     r1, pc
        add     r1, 62
        cmp     r1, r0
        bne     t108f

        b       t109

t108f:
        failed  108

t109:
        ; THUMB 13: add sp, imm7 << 2
        mov     r0, sp
        add     sp, 64
        add     sp, -64
        cmp     sp, r0
        bne     t109f

        b       t110

t109f:
        failed  109

t110:
        ; THUMB 4: adc rd, rs
        mov     r0, 8

        cmn     r0, r0
        adc     r0, r0
        cmp     r0, 16
        bne     t110f

        cmp     r0, r0
        adc     r0, r0
        cmp     r0, 33
        bne     t110f

        b       t111

t110f:
        failed  110

t111:
        ; THUMB 2: sub rd, rs, imm3
        mov     r0, 14
        sub     r0, 7
        sub     r0, 7
        bne     t111f

        b       t112

t111f:
        failed  111

t112:
        ; THUMB 3: sub rd, imm8
        mov     r0, 64
        sub     r0, 32
        sub     r0, 32
        bne     t112f

        b       t113

t112f:
        failed  112

t113:
        ; THUMB 2: sub rd, rs, rn
        mov     r0, 64
        mov     r1, 32
        sub     r0, r1
        sub     r0, r1
        bne     t113f

        b       t114

t113f:
        failed  113

t114:
        ; THUMB 4: sbc rd, rs
        mov     r0, 32
        mov     r1, 8

        cmn     r0, r0
        sbc     r0, r1
        cmp     r0, 23
        bne     t114f

        cmp     r0, r0
        sbc     r0, r1
        cmp     r0, 15
        bne     t114f

        b       t115

t114f:
        failed  114

t115:
        ; THUMB 4: neg rd, rs
        mov     r0, 4
        mov     r1, 0
        sub     r1, r0
        neg     r0, r0
        cmp     r0, r1
        bne     t115f

        b       t116

t115f:
        failed  115

t116:
        ; THUMB 3: cmp rd, imm8
        mov     r0, 32

        cmp     r0, 32
        bne     t116f
        bmi     t116f
        bcc     t116f
        bvs     t116f

        cmp     r0, 64
        beq     t116f
        bpl     t116f
        bcs     t116f

        mov     r0, 1
        lsl     r0, 31
        cmp     r0, 32
        bvc     t116f

        b       t117

t116f:
        failed  116

t117:
        ; THUMB 4: cmp rd, rs
        mov     r0, 32
        mov     r1, 64

        cmp     r0, r0
        bne     t117f
        bmi     t117f
        bcc     t117f
        bvs     t117f

        cmp     r0, r1
        beq     t117f
        bpl     t117f
        bcs     t117f

        mov     r0, 1
        lsl     r0, 31
        cmp     r0, r1
        bvc     t117f

        b       t118

t117f:
        failed  117

t118:
        ; THUMB 5: cmp rd, rs (high registers)
        mov     r0, 32
        mov     r1, 64
        mov     r8, r0
        mov     r9, r1

        cmp     r8, r8
        bne     t118f
        bmi     t118f
        bcc     t118f
        bvs     t118f

        cmp     r8, r9
        beq     t118f
        bpl     t118f
        bcs     t118f

        mov     r0, 1
        lsl     r0, 31
        mov     r8, r0
        cmp     r8, r9
        bvc     t118f

        b       t119

t118f:
        failed  118

t119:
        ; THUMB 4: cmn rd, rs
        mov     r0, 32
        cmn     r0, r0
        beq     t119f
        bmi     t119f
        bcs     t119f
        bvs     t119f

        mov     r0, 0
        cmn     r0, r0
        bne     t119f

        mov     r0, 0
        mvn     r0, r0
        cmn     r0, r0
        bpl     t119f
        bcc     t119f

        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        mov     r1, 1
        cmn     r0, r1
        bvc     t119f

        b       t120

t119f:
        failed  119

t120:
        ; THUMB 4: mul rd, rs
        mov     r0, 2
        mul     r0, r0
        mul     r0, r0
        cmp     r0, 16
        bne     t120f

        b       arithmetic_passed

t120f:
        failed  120

arithmetic_passed:
