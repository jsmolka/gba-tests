test_logical:
        ; Tests for logical operations

test_1:
        ; Zero flag
        mov     r0, 0
        bne     test_1f

        mov     r0, 1
        beq     test_1f

        b       test_2

test_1f:
        TestFailed 1

test_2:
        ; Negative flag
        mov     r0, 0
        bmi     test_2f

        mvn     r0, r0
        bpl     test_2f

        b       test_3

test_2f:
        TestFailed 2

test_3:
        ; Thumb 3: mov rd, offset8
        mov     r0, 0
        bne     test_3f

        mov     r0, 255
        cmp     r0, 255
        bne     test_3f

        b       test_4

test_3f:
        TestFailed 3

test_4:
        ; Thumb 2: mov rd, rs
        mov     r1, 0
        mov     r2, 255

        mov     r0, r1
        bne     test_4f

        mov     r0, r2
        cmp     r0, r2
        bne     test_4f

        b       test_5

test_4f:
        TestFailed 4

test_5:
        ; Thumb 5: mov rd, rs (high registers)
        mov     r0, 1
        mov     r8, r0
        mov     r9, r8
        mov     r0, r9
        cmp     r0, 1
        bne     test_5f

        b       test_6

test_5f:
        TestFailed 5

test_6:
        ; Thumb 4: mvn rd, rs
        mov     r0, 0
        imm32   r1, 0xFFFFFFFF

        mvn     r2, r0
        cmp     r2, r1
        bne     test_6f

        mvn     r2, r1
        bne     test_6f

        b       test_7

test_6f:
        TestFailed 6

test_7:
        ; Thumb 4: and rd, rs
        mov     r0, 0xFF
        mov     r1, 0x0F

        and     r0, r1
        cmp     r0, 0xF
        bne     test_7f

        mov     r1, 0

        and     r0, r1
        bne     test_7f

        b       test_8

test_7f:
        TestFailed 7

test_8:
        ; Thumb 4: tst rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F

        tst     r0, r1
        bne     test_8f
        bmi     test_8f

        mov     r0, 0
        mvn     r0, r0

        tst     r0, r0
        beq     test_8f
        bpl     test_8f

        b       test_9

test_8f:
        TestFailed 8

test_9:
        ; Thumb 4: bic rd, rs
        mov     r0, 0xFF
        mov     r1, 0xF0

        bic     r0, r1
        cmp     r0, 0xF
        bne     test_9f

        bic     r0, r0
        bne     test_9f

        b       test_10

test_9f:
        TestFailed 9

test_10:
        ; Thumb 4: orr rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F

        orr     r0, r1
        cmp     r0, 0xFF
        bne     test_10f

        orr     r0, r0
        cmp     r0, 0xFF
        bne     test_10f

        b       test_11

test_10f:
        TestFailed 10

test_11:
        ; Thumb 4: eor rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F

        eor     r0, r1
        cmp     r0, 0xFF
        bne     test_11f

        eor     r0, r0
        bne     test_11f

        ; Branch to shifts.asm
        b       test_shifts

test_11f:
        TestFailed 11
