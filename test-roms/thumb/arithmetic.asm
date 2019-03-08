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

add_1:
        ; Thumb 2: add rd, rs, rn / offset3
        mov     r0, 8
        add     r1, r0, r0
        add     r0, r1, 4
        cmp     r0, 20
        beq     add_2
        TestFailed 1

add_2:
        ; Thumb 3: add rd, offset8
        mov     r0, 8
        add     r0, 8
        cmp     r0, 16
        beq     add_3
        TestFailed 2

add_3:
        ; Carry flag
        imm32t  r0, 0xFFFFFFFE
        add     r0, 1
        bcs     add_3_failed
        add     r0, 1
        bcc     add_3_failed
        b       add_4

add_3_failed:
        TestFailed 3

add_4:
        ; Overflow flag
        imm32t  r0, 0x7FFFFFFE
        add     r0, 1
        bvs     add_4_failed
        add     r0, 1
        bvc     add_4_failed
        b       add_5

add_4_failed:
        TestFailed 4

add_5:
        ; Thumb 5: add rd / hd, rs / hs
        mov     r0, 5
        mov     r1, 5
        mov     r8, r1
        add     r0, r8
        add     r8, r0
        mov     r1, 15
        cmp     r8, r1
        beq     adc_1
        TestFailed 5

adc_1:
        ; Thumb 4: adc rd, rs
        mov     r0, 8
        mov     r1, 8
        cmp     r0, r0
        adc     r0, r1
        cmp     r0, 17
        beq     adc_2
        TestFailed 6

adc_2:
        mov     r0, 8
        mov     r1, 8
        cmn     r0, r0
        adc     r0, r1
        cmp     r0, 16
        beq     sub_1
        TestFailed 7

sub_1:
        ; Thumb 2: add rd, rs, rn / offset3
        mov     r0, 8
        mov     r1, 4
        sub     r2, r0, r1
        sub     r0, r2, 4
        cmp     r0, 0
        beq     sbc_1
        TestFailed 8

sbc_1:
        ; Thumb 4: sbc rd, rs
        mov     r0, 4
        mov     r1, 2
        cmp     r0, r0
        sbc     r0, r1
        cmp     r0, 2
        beq     sbc_2
        TestFailed 9

sbc_2:
        mov     r0, 4
        mov     r1, 2
        cmn     r0, r0
        sbc     r0, r1
        cmp     r0, 1
        beq     mul_1
        TestFailed 10

mul_1:
        ; Thumb 4: mul rd, rs
        mov     r0, 4
        mov     r1, 5
        mul     r0, r1
        cmp     r0, 20
        beq     mul_2
        TestFailed 11

mul_2:
        imm32t  r0, 0xFFFFFFFE
        mov     r1, 2
        mul     r0, r1
        imm32t  r1, 0xFFFFFFFC
        bcs     mul_2_failed
        cmp     r0, r1
        bne     mul_2_failed
        b       passed

mul_2_failed:
        TestFailed 12

passed:
        TestPassed
        TestLoop
