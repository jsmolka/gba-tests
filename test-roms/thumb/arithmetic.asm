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
        b       add_failed

add_2:
        ; Thumb 3: add rd, offset8
        mov     r0, 8
        add     r0, 8
        cmp     r0, 16
        beq     add_3
        b       add_failed

add_3:
        ; Carry flag
        imm32t  r0, 0xFFFFFFFE
        add     r0, 1
        bcs     add_failed
        add     r0, 1
        bcc     add_failed
        b       add_4

add_4:
        ; Overflow flag
        imm32t  r0, 0x7FFFFFFE
        add     r0, 1
        bvs     add_failed
        add     r0, 1
        bvc     add_failed
        b       add_5

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
        b       add_failed

add_failed:
        mov     r7, 1
        bl      infinite

adc_1:
        ; Thumb 4: adc rd, rs
        mov     r0, 8
        mov     r1, 8
        cmp     r0, r0
        adc     r0, r1
        cmp     r0, 17
        beq     adc_2
        b       adc_failed

adc_2:
        mov     r0, 8
        mov     r1, 8
        cmn     r0, r0
        adc     r0, r1
        cmp     r0, 16
        beq     sub_1
        b       adc_failed

adc_failed:
        mov     r7, 2
        bl      infinite

sub_1:
        ; Thumb 2: add rd, rs, rn / offset3
        mov     r0, 8
        mov     r1, 4
        sub     r2, r0, r1
        sub     r0, r2, 4
        cmp     r0, 0
        beq     sbc_1
        b       sub_failed

sub_failed:
        mov     r7, 3
        bl      infinite


sbc_1:
        ; Thumb 4: sbc rd, rs
        mov     r0, 4
        mov     r1, 2
        cmp     r0, r0
        sbc     r0, r1
        cmp     r0, 2
        beq     sbc_2
        b       sbc_failed

sbc_2:
        mov     r0, 4
        mov     r1, 2
        cmn     r0, r0
        sbc     r0, r1
        cmp     r0, 1
        beq     mul_1
        b       sbc_failed

sbc_failed:
        mov     r7, 4
        bl      infinite

mul_1:
        ; Thumb 4: mul rd, rs
        mov     r0, 4
        mov     r1, 5
        mul     r0, r1
        cmp     r0, 20
        beq     mul_2
        b       mul_failed

mul_2:
        imm32t  r0, 0xFFFFFFFE
        mov     r1, 2
        mul     r0, r1
        imm32t  r1, 0xFFFFFFFC
        bcs     mul_failed
        cmp     r0, r1
        bne     mul_failed
        b       passed

mul_failed:
        mov     r7, 5
        bl      infinite

passed:
        TestPassed

infinite:
        b       infinite