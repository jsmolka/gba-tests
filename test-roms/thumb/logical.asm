logical:
        ; Tests for logical operations

t1:
        ; Zero
        mov     r0, 0
        bne     t1f

        mov     r0, 1
        beq     t1f

        b       t2

t1f:
        failed  1

t2:
        ; Negative
        mov     r0, 0
        bmi     t2f

        mov     r0, 1
        lsl     r0, 31
        mov     r0, r0
        bpl     t2f

        b       t3

t2f:
        failed  2

t3:
        ; THUMB 3: mov rd, imm8
        mov     r0, 32
        cmp     r0, 32
        bne     t3f

        mov     r0, 255
        cmp     r0, 255
        bne     t3f

        b       t4

t3f:
        failed  3

t4:
        ; THUMB 2: mov rd, rs
        mov     r0, 32
        mov     r1, r0
        cmp     r1, r0
        bne     t4f

        mov     r0, 255
        mov     r1, r0
        cmp     r1, r0
        bne     t4f

        b       t5

t4f:
        failed  4

t5:
        ; THUMB 5: mov rd, rs (high registers)
        mov     r0, 1
        mov     r8, r0
        mov     r9, r8
        mov     r0, r9
        cmp     r0, 1
        bne     t5f

        b       t6

t5f:
        failed  5

t6:
        ; THUMB 4: mvn rd, rs
        mov     r0, 0
        sub     r1, r0, 1

        mvn     r2, r0
        cmp     r2, r1
        bne     t6f

        mvn     r2, r1
        cmp     r2, r0
        bne     t6f

        b       t7

t6f:
        failed  6

t7:
        ; THUMB 4: and rd, rs
        mov     r0, 0xFF
        mov     r1, 0xF
        and     r0, r1
        cmp     r0, r1
        bne     t7f

        mov     r0, 0xFF
        mov     r1, 0
        and     r0, r1
        cmp     r0, r1
        bne     t7f

        b       t8

t7f:
        failed  7

t8:
        ; THUMB 4: tst rd, rs
        mov     r0, 0
        tst     r0, r0
        bne     t8f
        bmi     t8f

        mov     r0, 0
        mvn     r0, r0
        tst     r0, r0
        beq     t8f
        bpl     t8f

        b       t9

t8f:
        failed  8

t9:
        ; THUMB 4: bic rd, rs
        mov     r0, 0xFF
        mov     r1, 0xF0
        bic     r0, r1
        cmp     r0, 0xF
        bne     t9f

        bic     r0, r0
        bne     t9f

        b       t10

t9f:
        failed  9

t10:
        ; THUMB 4: orr rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F
        orr     r0, r1
        cmp     r0, 0xFF
        bne     t10f

        mov     r0, 0xFF
        mov     r1, 0xF0
        orr     r0, r1
        cmp     r0, 0xFF
        bne     t10f

        b       t11

t10f:
        failed  10

t11:
        ; THUMB 4: eor rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F
        eor     r0, r1
        cmp     r0, 0xFF
        bne     t11f

        mov     r0, 0xFF
        mov     r1, 0xF0
        eor     r0, r1
        cmp     r0, 0xF
        bne     t11f

        b       t12

t11f:
        failed  11

t12:
        ; THUMB 5: Write to PC
        adr     r0, t13
        mov     pc, r0

t12f:
        failed  12

t13:
        ; THUMB 5: PC alignment
        adr     r0, logical_passed
        add     r0, 1
        mov     pc, r0

t13f:
        failed  13

logical_passed:
