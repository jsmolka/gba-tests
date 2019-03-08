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
        ; Todo
        ; Offsets with odd numbers behave oddly

        TestInit

        ; Setup initial values
        imm32t  r6, 0x02000000
        imm32t  r5, 0xFFFFFFFF
        imm32t  r4, 0x0F0F0F0F
        mov     r3, 8

mem_1:
        ; Thumb 7: ldr / str rd, [rb, ro]
        str     r5, [r6, r3]
        ldr     r0, [r6, r3]
        cmp     r0, r5
        beq     mem_2
        TestFailed 1

mem_2:
        ; Thumb 7: ldrb / strb rd, [rb, ro]
        lsr     r1, r4, 24
        strb    r4, [r6, r3]
        ldrb    r0, [r6, r3]
        cmp     r0, r1
        beq     mem_3
        TestFailed 2

mem_3:
        ; Thumb 8: ldrh / strh rd, [rb, ro]
        lsr     r1, r5, 16
        strh    r5, [r6, r3]
        ldrh    r0, [r6, r3]
        cmp     r0, r1
        beq     mem_4
        TestFailed 3

mem_4:
        ; Thumb 8: ldrsb rd, [rb, ro]
        lsr     r1, r4, 24
        str     r4, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r1
        beq     mem_5
        TestFailed 4

mem_5:
        str     r5, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r5
        beq     passed
        TestFailed 5

mem_6:
        ; Thumb 8: ldrsh rd, [rb, ro]
        lsr     r1, r4, 16
        str     r4, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r1
        beq     mem_7
        TestFailed 6

mem_7:
        str     r5, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r5
        beq     mem_8
        TestFailed 7

mem_8:
        ; Thumb 9: ldr / str rd, [rb, offset5]
        str     r4, [r6, 8]
        ldr     r0, [r6, 8]
        cmp     r0, r4
        beq     mem_9
        TestFailed 8

mem_9:
        ; Thumb 9: ldrb / strb rd, [rb, offset5]
        lsr     r1, r5, 24
        strb    r5, [r6, 8]
        ldrb    r0, [r6, 8]
        cmp     r0, r1
        beq     mem_10
        TestFailed 9

mem_10:
        ; Thumb 10: ldrh / strh rd, [rb, offset 5]
        lsr     r1, r4, 16
        strh    r4, [r6, 8]
        ldrh    r0, [r6, 8]
        cmp     r0, r1
        beq     passed
        TestFailed 10

passed:
        TestPassed
        TestLoop
