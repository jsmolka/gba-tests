test_arithmetic:
        ; Tests for arithmetic operations

test_100:
        ; Carry flag addition
        imm32   r0, 0xFFFFFFFE

        add     r0, 1
        bcs     test_100f

        add     r0, 1
        bcc     test_100f

        b       test_101

test_100f:
        TestFailed 100

test_101:
        ; Carry flag subtraction
        mov     r0, 1

        sub     r0, 2
        bcs     test_101f

        mov     r0, 3

        sub     r0, 2
        bcc     test_101f

        sub     r0, 1
        bcc     test_101f

        b       test_102

test_101f:
        TestFailed 101

test_102:
        ; Overflow flag addition
        imm32   r0, 0x7FFFFFFE

        add     r0, 1
        bvs     test_102f

        add     r0, 1
        bvc     test_102f

        b       test_103

test_102f:
        TestFailed 102

test_103:
        ; Overflow flag subtraction
        imm32   r0, 0x80000001

        sub     r0, 1
        bvs     test_103f

        sub     r0, 1
        bvc     test_103f

        b       test_104

test_103f:
        TestFailed 103

test_104:
        ; Thumb 2: add rd, rs, offset3
        mov     r0, 0

        add     r0, r0, 3
        add     r0, r0, 7
        cmp     r0, 10
        bne     test_104f

        b       test_105

test_104f:
        TestFailed 104

test_105:
        ; Thumb 3: add rd, offset8
        mov     r0, 0

        add     r0, 128
        add     r0, 127
        cmp     r0, 255
        bne     test_105f

        b       test_106

test_105f:
        TestFailed 105

test_106:
        ; Thumb 5: add rd, rs (high registers)
        mov     r0, 1
        mov     r1, 0
        mov     r8, r1
        mov     r9, r1

        add     r8, r0
        add     r9, r8
        add     r0, r9
        cmp     r0, 2
        bne     test_106f

        b       test_107

test_106f:
        TestFailed 106

test_107:
        ; Thumb 12: add rd, sp, offset8
        mov     r0, sp
        add     r0, 128
        mov     r1, 0

        add     r1, sp, 128
        cmp     r1, r0
        bne     test_107f

        b       test_108

test_107f:
        TestFailed 107

test_108:
        ; Thumb 12: add rd, pc, offset8
        mov     r0, pc
        add     r0, 10
        mov     r1, 0

        add     r1, pc, 4
        cmp     r1, r0
        bne     test_108f

        b       test_109

test_108f:
        TestFailed 108

test_109:
        ; Thumb 13: add sp, sword7
        mov     r0, sp

        add     sp, 128
        add     sp, -128
        cmp     sp, r0
        bne     test_109f

        b       test_110

test_109f:
        TestFailed 109

test_110:
        ; Thumb 4: adc rd, rs
        mov     r0, 8
        cmn     r0, r0

        adc     r0, r0
        cmp     r0, 16
        bne     test_110f

        cmp     r0, r0

        adc     r0, r0
        cmp     r0, 33
        bne     test_110f

        b       test_111

test_110f:
        TestFailed 110

test_111:
        ; Thumb 2: sub rd, rs, offset3
        mov     r0, 10

        sub     r0, r0, 3
        sub     r0, r0, 7
        bne     test_111f

        b       test_112

test_111f:
        TestFailed 111

test_112:
        ; Thumb 3: sub rd, offset8
        mov     r0, 255
        add     r0, 10

        sub     r0, 255
        sub     r0, 10
        bne     test_112f

        b       test_113

test_112f:
        TestFailed 112

test_113:
        ; Thumb 2: sub rd, rs, rn
        mov     r0, 255
        add     r0, 10

        mov     r1, 255
        mov     r2, 10

        sub     r0, r1
        sub     r0, r2
        bne     test_113f

        b       test_114

test_113f:
        TestFailed 113

test_114:
        ; Thumb 4: sbc rd, rs
        mov     r0, 64
        mov     r1, 16
        cmn     r0, r0

        sbc     r0, r1
        cmp     r0, 47
        bne     test_114f

        cmp     r0, r0

        sbc     r0, r1
        cmp     r0, 31
        bne     test_114f

        b       test_115

test_114f:
        TestFailed 114

test_115:
        ; Thumb 4: neg rd, rs
        mov     r0, 4
        mov     r1, 0
        sub     r1, r0

        neg     r0, r0
        cmp     r0, r1
        bne     test_115f

        b       test_116

test_115f:
        TestFailed 115

test_116:
        ; Thumb 3: cmp rd, offset8
        mov     r0, 128

        cmp     r0, 128
        bne     test_116f
        bmi     test_116f
        bcc     test_116f
        bvs     test_116f

        cmp     r0, 255
        beq     test_116f
        bpl     test_116f
        bcs     test_116f

        mov     r0, 1
        lsl     r0, 31

        cmp     r0, 255
        bvc     test_116f

        b       test_117

test_116f:
        TestFailed 116

test_117:
        ; Thumb 4: cmp rd, rs
        mov     r0, 128
        mov     r1, 255

        cmp     r0, r0
        bne     test_117f
        bmi     test_117f
        bcc     test_117f
        bvs     test_117f

        cmp     r0, r1
        beq     test_117f
        bpl     test_117f
        bcs     test_117f

        mov     r0, 1
        lsl     r0, 31

        cmp     r0, r1
        bvc     test_117f

        b       test_118

test_117f:
        TestFailed 117

test_118:
        ; Thumb 5: cmp rd, rs
        mov     r0, 128
        mov     r1, 255
        mov     r8, r0
        mov     r9, r1

        cmp     r8, r8
        bne     test_118f
        bmi     test_118f
        bcc     test_118f
        bvs     test_118f

        cmp     r8, r9
        beq     test_118f
        bpl     test_118f
        bcs     test_118f

        mov     r0, 1
        lsl     r0, 31
        mov     r8, r0

        cmp     r8, r9
        bvc     test_118f

        b       test_119

test_118f:
        TestFailed 118

test_119:
        ; Thumb 4: cmn rd, rs
        mov     r0, 128

        cmn     r0, r0
        beq     test_119f
        bmi     test_119f
        bcs     test_119f
        bvs     test_119f

        mov     r0, 0

        cmn     r0, r0
        bne     test_119f

        mvn     r0, r0

        cmn     r0, r0
        bpl     test_119f
        bcc     test_119f

        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        mov     r1, 1

        cmn     r0, r1
        bvc     test_119f

        b       test_120

test_119f:
        TestFailed 119

test_120:
        ; Thumb 4: mul rd, rs
        mov     r0, 2

        mul     r0, r0
        mul     r0, r0
        cmp     r0, 16
        bne     test_120f

        ; Branch to branches.asm
        b       test_branches

test_120f:
        TestFailed 120
