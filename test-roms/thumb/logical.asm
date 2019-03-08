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

and_1:
        ; Thumb 4: and rd, rs
        mov     r0, 0xFF
        mov     r1, 0xF
        and     r0, r1
        cmp     r0, 0xF
        beq     eor_1
        TestFailed 1

eor_1:
        ; Thumb 4: eor rd, rs
        mov     r0, 0xF0
        mov     r1, 0xF
        eor     r0, r1
        cmp     r0, 0xFF
        beq     orr_1
        TestFailed 2

orr_1:
        ; Thumb 4: orr rd, rs
        mov     r0, 0xF0
        mov     r1, 0xFF
        orr     r0, r1
        cmp     r0, 0xFF
        beq     bic_1
        TestFailed 3

bic_1:
        ; Thumb 4: bic rd, rs
        mov     r0, 0xFF
        mov     r1, 0xF
        bic     r0, r1
        cmp     r0, 0xF0
        beq     mvn_1
        TestFailed 4

mvn_1:
        ; Thumb 4: mvn rd, rs
        imm32t  r0, 0xFF00FF00
        mvn     r1, r0
        lsr     r0, 8
        cmp     r0, r1
        beq     passed
        TestFailed 5

passed:
        TestPassed
        TestLoop