shifts:
        ; Tests for shift operations

t50:
        ; THUMB 1: lsl rd, rs, imm5
        mov     r0, 1
        lsl     r0, 6
        cmp     r0, 64
        bne     t50f

        b       t51

t50f:
        failed  50

t51:
        ; THUMB 4: lsl rd, rs
        mov     r0, 1
        mov     r1, 6
        lsl     r0, r1
        cmp     r0, 64
        bne     t51f

        b       t52

t51f:
        failed  51

t52:
        ; Logical shift left carry
        mov     r0, 0
        lsl     r0, 1
        bcs     t52f

        mov     r0, 1
        lsl     r0, 31
        lsl     r0, 1
        bcc     t52f

        b       t53

t52f:
        failed  52

t53:
        ; Logical shift left special
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
        failed  53

t54:
        ; THUMB 1: lsr rd, rs, imm5
        mov     r0, 64
        lsr     r0, 6
        cmp     r0, 1
        bne     t54f

        b       t55

t54f:
        failed  54

t55:
        ; THUMB 4: lsr rd, rs
        mov     r0, 64
        mov     r1, 6
        lsr     r0, r1
        cmp     r0, 1
        bne     t55f

        b       t56

t55f:
        failed  55

t56:
        ; Logical shift right carry
        mov     r0, 2
        lsr     r0, 1
        bcs     t56f

        mov     r0, 1
        lsr     r0, 1
        bcc     t56f

        b       t57

t56f:
        failed  56

t57:
        ; Logical shift right special
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
        failed  57

t58:
        ; THUMB 1: asr rd, rs, imm5
        mov     r0, 64
        asr     r0, 6
        cmp     r0, 1
        bne     t58f

        mov     r0, 1
        lsl     r0, 31
        asr     r0, 31
        mov     r1, 0
        mvn     r1, r1
        cmp     r0, r1
        bne     t58f

        b       t59

t58f:
        failed  58

t59:
        ; THUMB 4: asr rd, rs
        mov     r0, 64
        mov     r1, 6
        asr     r0, r1
        cmp     r0, 1
        bne     t59f

        mov     r0, 1
        lsl     r0, 31
        mov     r1, 31
        asr     r0, r1
        mov     r1, 0
        mvn     r1, r1
        cmp     r0, r1
        bne     t59f

        b       t60

t59f:
        failed  60

t60:
        ; Arithmetic shift right carry
        mov     r0, 2
        asr     r0, 1
        bcs     t60f

        mov     r0, 1
        asr     r0, 1
        bcc     t60f

        b       t61

t60f:
        failed  60

t61:
        ; Arithmetic shift right special
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
        failed  61

t62:
        ; THUMB 4: ror rd, rs
        mov     r0, 2
        mov     r1, 1
        ror     r0, r1
        cmp     r0, 1
        bne     t62f

        mov     r0, 1
        mov     r1, 1
        ror     r0, r1
        lsl     r1, 31
        cmp     r0, r1
        bne     t62f

        b       t63

t62f:
        failed  62

t63:
        ; Rotate right carry
        mov     r0, 1

        mov     r1, 2
        ror     r1, r0
        bcs     t63f

        mov     r1, 1
        ror     r1, r0
        bcc     t63f

        b       t64

t63f:
        failed  63

t64:
        ; THUMB 4: Shifts by zero (carry clear)
        mov     r0, 1
        mov     r1, 0
        cmn     r0, r0

        lsl     r0, r1
        lsr     r0, r1
        asr     r0, r1
        ror     r0, r1
        bcs     t64f

        cmp     r0, 1
        bne     t64f

        b       t65

t64f:
        failed  64

t65:
        ; THUMB 4: Shifts by zero (carry set)
        mov     r0, 1
        mov     r1, 0
        cmp     r0, r0

        lsl     r0, r1
        lsr     r0, r1
        asr     r0, r1
        ror     r0, r1
        bcc     t65f

        cmp     r0, 1
        bne     t65f

        b       shifts_passed

t65f:
        failed  65

shifts_passed:
