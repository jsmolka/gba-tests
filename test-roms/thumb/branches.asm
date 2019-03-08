format binary as 'gba'

include '../lib/header.inc'
include '../lib/test.inc'

main:
        b       main_arm
        Header

main_arm:
        adr     r0, main_thumb + 1
        bx      r0

code16
align 2
main_thumb:
        TestInit

bc_1:
        ; Thumb 16: b[cond] label
        bne     bc_2

bc_3:
        bne     b_1

bc_2:
        bne     bc_3

b_1:
        ; Thumb 18: b label
        b       b_2

b_3:
        b       bl_1

b_2:
        b       b_3

bl_1:
        ; Thumb 19: bl label
        bl      bl_2

bl_3:
        bl      passed

bl_2:
        bl      bl_3

        ; Todo: BX

passed:
        TestPassed
        TestLoop
