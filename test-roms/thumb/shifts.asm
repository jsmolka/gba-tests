shifts:
        ; Tests for shifts
        bl      t64

t50:
        ; Thumb 1: lsl rd, rs, offset5
        mov     r0, 1

        lsl     r0, r0, 6
        lsl     r0, r0, 1
        cmp     r0, 128
        bne     t50f

        b       t51

t50f:
        Failed 50

t51:
        ; Thumb 4: lsl rd, rs
        mov     r0, 1
        mov     r1, 6

        lsl     r0, r1

        mov     r1, 1

        lsl     r0, r1
        cmp     r0, 128
        bne     t51f

        b       t52

t51f:
        Failed 51

t52:
        ; Carry flag lsl
        mov     r0, 0

        lsl     r0, 1
        bcs     t52f

        mvn     r0, r0

        lsl     r0, 1
        bcc     t52f

        b       t53

t52f:
        Failed 52

t53:
        ; Special case lsl
        mov     r0, 1
        mov     r1, 0
        cmn     r0, r0

        lsl     r0, r1
        bcs     t53f

        cmp     r0, r0

        lsl     r0, r1
        bcc     t53f

        cmp     r0, 1
        bne     t53f

        b       t54

t53f:
        Failed 53

t54:
        ; Thumb 1: lsr rd, rs, offset5
        mov     r0, 128

        lsr     r0, r0, 6
        lsr     r0, r0, 1
        cmp     r0, 1
        bne     t54f

        b       t55

t54f:
        Failed 54

t55:
        ; Thumb 4: lsr rd, rs
        mov     r0, 128
        mov     r1, 6

        lsr     r0, r1

        mov     r1, 1

        lsr     r0, r1
        cmp     r0, 1
        bne     t55f

        b       t56

t55f:
        Failed 55

t56:
        ; Carry flag lsr
        mov     r0, 2

        lsr     r0, 1
        bcs     t56f

        lsr     r0, 1
        bcc     t56f

        b       t57

t56f:
        Failed 56

t57:
        ; Special case lsr
        mov     r0, 1

        lsr     r0, 32
        bne     t57f
        bcs     t57f

        mov     r0, 1
        lsl     r0, 31

        lsr     r0, 32
        bne     t57f
        bcc     t57f

        b       t58

t57f:
        Failed 57

t58:
        ; Thumb 1: asr rd, rs, offset8
        mov     r0, 128

        asr     r0, r0, 6
        asr     r0, r0, 1
        cmp     r0, 1
        bne     t58f

        mov     r0, 1
        lsl     r0, 31
        mov     r1, 0
        mvn     r1, r1

        asr     r0, r0, 31
        cmp     r0, r1
        bne     t58f

        b       t59

t58f:
        Failed 58

t59:
        ; Thumb 4: asr rd, rs
        mov     r0, 128
        mov     r1, 6

        asr     r0, r1

        mov     r1, 1

        asr     r0, r1
        cmp     r0, 1
        bne     t59f

        mov     r0, 1
        lsl     r0, 31
        mov     r1, 31
        mov     r2, 0
        mvn     r2, r2

        asr     r0, r1
        cmp     r0, r2
        bne     t59f

        b       t60

t59f:
        Failed 59

t60:
        ; Carry flag asr
        mov     r0, 2

        asr     r0, 1
        bcs     t60f

        asr     r0, 1
        bcc     t60f

        b       t61

t60f:
        Failed 60

t61:
        ; Special case asr
        mov     r0, 1

        asr     r0, 32
        bne     t61f
        bcs     t61f

        mov     r0, 1
        lsl     r0, 31

        asr     r0, 32
        bcc     t61f

        mov     r1, 0
        mvn     r1, r1
        cmp     r0, r1
        bne     t61f

        b       t62

t61f:
        Failed 61

t62:
        ; Thumb 4: ror rd, rs
        mov     r0, 0xF0
        mov     r1, 4

        ror     r0, r1
        cmp     r0, 0xF
        bne     t62f

        imm32   r2, 0xF0000000

        ror     r0, r1
        cmp     r0, r2
        bne     t62f

        b       t63

t62f:
        Failed 62

t63:
        ; Carry flag ror
        mov     r0, 2
        mov     r1, 1

        ror     r0, r1
        bcs     t63f

        ror     r0, r1
        bcc     t63f

        b       t64

t63f:
        Failed 63

t64:
        ; Shifts by zero (carry clear)
        mov     r0, 1
        lsl     r0, 31
        mov     r1, 0
        cmn     r1, r1

        lsl     r0, r1
        bpl     t64f
        bcs     t64f

        lsr     r0, r1
        bpl     t64f
        bcs     t64f

        asr     r0, r1
        bpl     t64f
        bcs     t64f

        ror     r0, r1
        bpl     t64f
        bcs     t64f

        b       t65

t64f:
        Failed 64

t65:
        ; Shifts by zero (carry clear)
        mov     r0, 1
        lsl     r0, 31
        mov     r1, 0
        cmp     r0, r0

        lsl     r0, r1
        bpl     t65f
        bcc     t65f

        lsr     r0, r1
        bpl     t65f
        bcc     t65f

        asr     r0, r1
        bpl     t65f
        bcc     t65f

        ror     r0, r1
        bpl     t65f
        bcc     t65f

        b       shifts_passed

t65f:
        Failed 65

shifts_passed:
