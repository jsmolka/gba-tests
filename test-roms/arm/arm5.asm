arm5:
        ; Tests for Arm 5 instruction

t50:
        ; Arm 5: mul{cond}{s} rd, rm, rs (rd != rm)
        mov     r0, 2
        mov     r1, 8
        mul     r0, r1, r0
        cmp     r0, 16
        bne     t50f

        b       t51

t50f:
        Failed 50

t51:
        mov     r0, 2
        mov     r1, 0xFF000000
        mul     r0, r1, r0
        cmp     r0, 0xFE000000
        bne     t51f

        b       t52

t51f:
        Failed 51

t52:
        ; Arm 5: mla{cond}{s} rd, rm, rs, rn (rd != rm)
        mov     r0, 2
        mov     r1, 8
        mov     r2, 2
        mla     r0, r1, r0, r2

        mov     r1, 18
        cmp     r0, r1
        bne     t52f

        b       t53

t52f:
        Failed 52

t53:
        mov     r0, 2
        mov     r1, 0xFF000000
        mov     r2, 2
        mla     r0, r1, r0, r2

        mov     r1, 0xFE000000
        add     r1, 2
        cmp     r0, r1
        bne     t53f

        ; Branch to arm6.asm
        b       arm6

t53f:
        Failed 53
