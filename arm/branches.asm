branches:
        ; Tests for branch operations

t050:
        ; ARM 1: Branch with exchange
        mov     r12, 50
        adr     r0, t051 + 1
        bx      r0

code16
align 2
t051:
        ; THUMB 5: Branch with exchange
        mov     r0, 51
        mov     r12, r0
        adr     r0, t052
        bx      r0

code32
align 4
t052:
        ; ARM 1: Branch without exchange
        mov     r12, 52
        adr     r0, t053
        bx      r0

t053:
        ; ARM 1: Branch alignment
        mov     r12, 53
        adr     r0, t054
        add     r0, 2
        bx      r0

t054:
        ; ARM 2: Branch forward
        mov     r12, 54
        b       t055

t056:
        ; ARM 2: Branch forward
        mov     r12, 56
        b       t057

t055:
        ; ARM 2: Branch backward
        mov     r12, 55
        b       t056

t058:
        ; ARM 2: Test link
        mov     r12, 58
        mov     pc, lr

t057:
        ; ARM 2: Branch with link
        mov     r12, 57
        bl      t058

branches_passed:
        mov     r12, 0
