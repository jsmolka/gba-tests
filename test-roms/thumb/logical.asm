logical:
        ; Tests for logical operations

t1:
        ; Zero flag
        mov     r0, 0
        bne     t1f

        mov     r0, 1
        beq     t1f

        b       t2

t1f:
        Failed 1

t2:
        ; Negative flag
        mov     r0, 0
        bmi     t2f

        mvn     r0, r0
        bpl     t2f

        b       t3

t2f:
        Failed 2

t3:
        ; Thumb 3: mov rd, offset8
        mov     r0, 0
        bne     t3f

        mov     r0, 255
        cmp     r0, 255
        bne     t3f

        b       t4

t3f:
        Failed 3

t4:
        ; Thumb 2: mov rd, rs
        mov     r1, 0
        mov     r2, 255

        mov     r0, r1
        bne     t4f

        mov     r0, r2
        cmp     r0, r2
        bne     t4f

        b       t5

t4f:
        Failed 4

t5:
        ; Thumb 5: mov rd, rs (high registers)
        mov     r0, 1
        mov     r8, r0
        mov     r9, r8
        mov     r0, r9
        cmp     r0, 1
        bne     t5f

        b       t6

t5f:
        Failed 5

t6:
        ; Thumb 4: mvn rd, rs
        mov     r0, 0
        imm32   r1, 0xFFFFFFFF

        mvn     r2, r0
        cmp     r2, r1
        bne     t6f

        mvn     r2, r1
        bne     t6f

        b       t7

t6f:
        Failed 6

t7:
        ; Thumb 4: and rd, rs
        mov     r0, 0xFF
        mov     r1, 0x0F

        and     r0, r1
        cmp     r0, 0xF
        bne     t7f

        mov     r1, 0

        and     r0, r1
        bne     t7f

        b       t8

t7f:
        Failed 7

t8:
        ; Thumb 4: tst rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F

        tst     r0, r1
        bne     t8f
        bmi     t8f

        mov     r0, 0
        mvn     r0, r0

        tst     r0, r0
        beq     t8f
        bpl     t8f

        b       t9

t8f:
        Failed 8

t9:
        ; Thumb 4: bic rd, rs
        mov     r0, 0xFF
        mov     r1, 0xF0

        bic     r0, r1
        cmp     r0, 0xF
        bne     t9f

        bic     r0, r0
        bne     t9f

        b       t10

t9f:
        Failed 9

t10:
        ; Thumb 4: orr rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F

        orr     r0, r1
        cmp     r0, 0xFF
        bne     t10f

        orr     r0, r0
        cmp     r0, 0xFF
        bne     t10f

        b       t11

t10f:
        Failed 10

t11:
        ; Thumb 4: eor rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F

        eor     r0, r1
        cmp     r0, 0xFF
        bne     t11f

        eor     r0, r0
        bne     t11f

        ; Branch to shifts.asm
        b       shifts

t11f:
        Failed 11
