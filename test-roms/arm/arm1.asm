arm1:
        ; Tests for Arm 1 instruction

t1:
        ; Arm 1: bx label
        mov     r12, 1
        adr     r0, t1a + 1
        bx      r0

code16
align 2
t1a:
        adr     r0, t1b
        bx      r0

code32
align 4
t1b:
        adr     r0, t1c
        bx      r0

t1c:
        mov     r12, 0
        ; Branch to arm2.asm
        b       arm2
