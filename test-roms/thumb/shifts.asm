test_shifts:
        ; Tests for shifts

test_50:
        ; Thumb 1: lsl rd, rs, offset5
        mov     r0, 1

        lsl     r0, r0, 6
        lsl     r0, r0, 1
        cmp     r0, 128
        bne     test_50f

        b       test_51

test_50f:
        TestFailed 50

test_51:
        ; Thumb 4: lsl rd, rs
        mov     r0, 1
        mov     r1, 6

        lsl     r0, r1

        mov     r1, 1

        lsl     r0, r1
        cmp     r0, 128
        bne     test_51f

        b       test_52

test_51f:
        TestFailed 51

test_52:
        ; Carry flag lsl
        mov     r0, 0

        lsl     r0, 1
        bcs     test_52f

        mvn     r0, r0

        lsl     r0, 1
        bcc     test_52f

        b       test_53

test_52f:
        TestFailed 52

test_53:
        ; Special case lsl
        mov     r0, 1
        mov     r1, 0
        cmn     r0, r0

        lsl     r0, r1
        bcs     test_53f

        cmp     r0, r0

        lsl     r0, r1
        bcc     test_53f

        cmp     r0, 1
        bne     test_53f

        b       test_54

test_53f:
        TestFailed 53

test_54:
        ; Thumb 1: lsr rd, rs, offset5
        mov     r0, 128

        lsr     r0, r0, 6
        lsr     r0, r0, 1
        cmp     r0, 1
        bne     test_54f

        b       test_55

test_54f:
        TestFailed 54

test_55:
        ; Thumb 4: lsr rd, rs
        mov     r0, 128
        mov     r1, 6

        lsr     r0, r1

        mov     r1, 1

        lsr     r0, r1
        cmp     r0, 1
        bne     test_55f

        b       test_56

test_55f:
        TestFailed 55

test_56:
        ; Carry flag lsr
        mov     r0, 2

        lsr     r0, 1
        bcs     test_56f

        lsr     r0, 1
        bcc     test_56f

        b       test_57

test_56f:
        TestFailed 56

test_57:
        ; Special case lsr
        mov     r0, 1

        lsr     r0, 32
        bne     test_57f
        bcs     test_57f

        mov     r0, 1
        lsl     r0, 31

        lsr     r0, 32
        bne     test_57f
        bcc     test_57f

        b       test_58

test_57f:
        TestFailed 57

test_58:
        ; Thumb 1: asr rd, rs, offset8
        mov     r0, 128

        asr     r0, r0, 6
        asr     r0, r0, 1
        cmp     r0, 1
        bne     test_58f

        mov     r0, 1
        lsl     r0, 31
        mov     r1, 0
        mvn     r1, r1

        asr     r0, r0, 31
        cmp     r0, r1
        bne     test_58f

        b       test_59

test_58f:
        TestFailed 58

test_59:
        ; Thumb 4: asr rd, rs
        mov     r0, 128
        mov     r1, 6

        asr     r0, r1

        mov     r1, 1

        asr     r0, r1
        cmp     r0, 1
        bne     test_59f

        mov     r0, 1
        lsl     r0, 31
        mov     r1, 31
        mov     r2, 0
        mvn     r2, r2

        asr     r0, r1
        cmp     r0, r2
        bne     test_59f

        b       test_60

test_59f:
        TestFailed 59

test_60:
        ; Carry flag asr
        mov     r0, 2

        asr     r0, 1
        bcs     test_60f

        asr     r0, 1
        bcc     test_60f

        b       test_61

test_60f:
        TestFailed 60

test_61:
        ; Special case asr
        mov     r0, 1

        asr     r0, 32
        bne     test_61f
        bcs     test_61f

        mov     r0, 1
        lsl     r0, 31

        asr     r0, 32
        bcc     test_61f

        mov     r1, 0
        mvn     r1, r1
        cmp     r0, r1
        bne     test_61f

        b       test_62

test_61f:
        TestFailed 61

test_62:
        ; Thumb 4: ror rd, rs
        mov     r0, 0xF0
        mov     r1, 4

        ror     r0, r1
        cmp     r0, 0xF
        bne     test_62f

        imm32   r2, 0xF0000000

        ror     r0, r1
        cmp     r0, r2
        bne     test_62f

        b       test_63

test_62f:
        TestFailed 62

test_63:
        ; Carry flag ror
        mov     r0, 2
        mov     r1, 1

        ror     r0, r1
        bcs     test_63f

        ror     r0, r1
        bcc     test_63f

        b       test_64

test_63f:
        TestFailed 63

test_64:
        ; Special case ror

        ; Todo: which mnemonic should be used?

        ; Branch to arithmetic.asm
        b       test_arithmetic

test_64f:
       TestFailed 64
