branches:
        ; Tests for branch operations

t50:
        ; ARM 1: bx{cond} rn
        mov     r12, 50
        adr     r0, t51 + 1
        bx      r0

code16
align 2
t51:
        mov     r0, 51
        mov     r12, r0
        adr     r0, t52
        bx      r0

code32
align 4
t52:
        mov     r12, 52
        adr     r0, t53
        bx      r0

t53:
        ; ARM 2: b{l}{cond} imm24 << 2
        mov     r12, 53
        b       t54

t55:
        mov     r12, 55
        b       t56

t54:
        mov     r12, 54
        b       t55

t57:
        mov     r12, 57
        mov     pc, lr

t56:
        mov     r12, 56
        bl      t57

branches_end:
        mov     r12, 0
