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
        ; Todo: Offsets with odd numbers behaves weirdly

        TestInit

        ; Setup initial values
        imm32t  r6, 0x02000000
        imm32t  r5, 0xFFFFFFFF
        imm32t  r4, 0x0F0F0F0F
        mov     r3, 8

test_1:
        ; Thumb 6: ldr rd, [pc, word8]
        ldr     r0, [pc, 12]
        cmp     r0, r5
        beq     test_2
        TestFailed 1

align 4
        ; Word aligned data
        db      255,255,255,255

test_2:
        ; Thumb 7: ldr / str rd, [rb, ro]
        str     r5, [r6, r3]
        ldr     r0, [r6, r3]
        cmp     r0, r5
        beq     test_3
        TestFailed 2

test_3:
        ; Thumb 7: ldrb / strb rd, [rb, ro]
        lsr     r1, r4, 24
        strb    r4, [r6, r3]
        ldrb    r0, [r6, r3]
        cmp     r0, r1
        beq     test_4
        TestFailed 3

test_4:
        ; Thumb 8: ldrh / strh rd, [rb, ro]
        lsr     r1, r5, 16
        strh    r5, [r6, r3]
        ldrh    r0, [r6, r3]
        cmp     r0, r1
        beq     test_5
        TestFailed 4

test_5:
        ; Thumb 8: ldrsb rd, [rb, ro]
        ; Case without sign extension
        lsr     r1, r4, 24
        str     r4, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r1
        beq     test_6
        TestFailed 5

test_6:
        ; Case with sign extension
        str     r5, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r5
        beq     test_7
        TestFailed 6

test_7:
        ; Thumb 8: ldrsh rd, [rb, ro]
        ; Case without sign extension
        lsr     r1, r4, 16
        str     r4, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r1
        beq     test_8
        TestFailed 7

test_8:
        ; Case with sign extension
        str     r5, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r5
        beq     test_9
        TestFailed 8

test_9:
        ; Thumb 9: ldr / str rd, [rb, offset5]
        str     r4, [r6, 8]
        ldr     r0, [r6, 8]
        cmp     r0, r4
        beq     test_10
        TestFailed 9

test_10:
        ; Thumb 9: ldrb / strb rd, [rb, offset5]
        lsr     r1, r5, 24
        strb    r5, [r6, 8]
        ldrb    r0, [r6, 8]
        cmp     r0, r1
        beq     test_11
        TestFailed 10

test_11:
        ; Thumb 10: ldrh / strh rd, [rb, offset5]
        lsr     r1, r4, 16
        strh    r4, [r6, 8]
        ldrh    r0, [r6, 8]
        cmp     r0, r1
        beq     test_12
        TestFailed 11

test_12:
        ; Thumb 11: ldr / str rd, [sp, word8]
        str     r5, [sp, 8]
        ; Increment sp by pushing
        push    {r0}
        ldr     r0, [sp, 12]
        cmp     r0, r5
        beq     test_13
        TestFailed 12

test_13:
        ; Thumb 12: add rd, pc, word8
        mov     r0, r15
        add     r1, pc, 4
        add     r0, 4
        cmp     r0, r1
        beq     test_14
        TestFailed 13

test_14:
        ; Thumb 12: add rd, sp, word8
        mov     r0, r13
        add     r1, sp, 4
        add     r0, 4
        cmp     r0, r1
        beq     test_15
        TestFailed 14

test_15:
        ; Thumb 13: add sp, sword7
        mov     r0, r13
        add     sp, 4
        add     r0, 4
        cmp     r0, r13
        bne     test_15_failed
        add     sp, -8
        sub     r0, 8
        cmp     r0, r13
        bne     test_15_failed
        b       test_16

test_15_failed:
        TestFailed 15

test_16:
        ; Thumb 14: push / pop {rlist}
        mov     r0, 1
        mov     r1, 2
        push    {r0, r1}
        pop     {r2, r3}
        cmp     r0, r2
        bne     test_16_failed
        cmp     r1, r3
        bne     test_16_failed
        b       test_17

test_16_failed:
        TestFailed 16

test_17:
        ; Thumb 15: ldmia / stmia rb!, {rlist}
        mov     r0, 2
        mov     r1, 4
        mov     r3, r6
        stmia   r3!, {r0, r1}
        ; Decrement to original value
        sub     r3, 8
        cmp     r3, r6
        bne     test_17_failed
        ldmia   r3!, {r2, r4}
        ; Decrement to original value
        sub     r3, 8
        cmp     r3, r6
        bne     test_17_failed
        cmp     r0, r2
        bne     test_17_failed
        cmp     r1, r4
        bne     test_17_failed
        b       passed

test_17_failed:
        TestFailed 17

passed:
        TestPassed
        TestLoop