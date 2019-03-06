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

lsl_1:
        ; Thumb 1: lsl rd, rs, offset5
        mov     r0, 1
        lsl     r1, r0, 3
        lsl     r0, r1, 3
        cmp     r0, 64
        beq     lsl_2
        b       lsl_failed

lsl_2:
        ; Thumb 4: lsl rd, rs
        mov     r0, 1
        mov     r1, 3
        lsl     r0, r1
        lsl     r0, r1
        cmp     r0, 64
        beq     lsl_3
        b       lsl_failed

lsl_3:
        ; Special case LSL #0
        mov     r0, 1
        mov     r1, 0
        cmp     r0, r0
        lsl     r0, r1
        bcs     lsl_4
        b       lsl_failed

lsl_4:
        ; Carry flag
        mov     r0, 2
        lsl     r0, 31
        bcs     lsr_1
        b       lsl_failed

lsl_failed:
        mov     r7, 1
        bl      infinite

lsr_1:
        ; Thumb 1: lsr rd, rs, offset5
        mov     r0, 64
        lsr     r1, r0, 3
        lsr     r0, r1, 3
        cmp     r0, 1
        beq     lsr_2
        b       lsr_failed

lsr_2:
        ; Thumb 4: lsr rd, rs
        mov     r0, 64
        mov     r1, 3
        lsr     r0, r1
        lsr     r0, r1
        cmp     r0, 1
        beq     lsr_3
        b       lsr_failed

lsr_3:
        ; Special case LSR #32
        mov     r0, 1
        lsl     r0, 31
        lsr     r0, 32
        bne     lsr_failed
        bcc     lsr_failed
        b       lsr_4

lsr_4:
        ; Carry flag
        mov     r0, 8
        lsr     r0, 4
        bcs     asr_1
        b       lsr_failed

lsr_failed:
        mov     r7, 2
        bl      infinite

asr_1:
        ; Thumb 1: asr rd, rs, offset5
        mov     r0, 64
        asr     r1, r0, 3
        asr     r0, r1, 3
        cmp     r0, 1
        beq     asr_2
        b       asr_failed

asr_2:
        ; Thumb 4: asr rd, rs
        mov     r0, 64
        mov     r1, 3
        asr     r0, r1
        asr     r0, r1
        cmp     r0, 1
        beq     asr_3
        b       asr_failed

asr_3:
        ; Special case ASR #32
        imm32t  r1, 0xFFFFFFFF
        mov     r0, 1
        lsl     r0, 31
        asr     r0, 32
        cmp     r0, r1
        bne     asr_failed
        bcc     asr_failed
        b       asr_4

asr_4:
        ; Carry flag
        mov     r0, 8
        asr     r0, 4
        bcs     ror_1
        b       asr_failed

asr_failed:
        mov     r7, 3
        bl      infinite

ror_1:
        ; Thumb 4: ror rd, rs
        mov     r0, 0xFF
        mov     r1, 4
        imm32t  r2, 0xF000000F
        ror     r0, r1
        cmp     r0, r2
        beq     ror_2
        b       ror_failed

ror_2:
        ; Special case ROR #0
        mov     r0, 1
        mov     r1, 0
        cmp     r0, r0
        ror     r0, r1
        cmp     r0, 1
        bne     ror_failed
        bcc     ror_failed
        b       ror_3

ror_3:
        ; Carry flag
        mov     r0, 8
        asr     r0, 4
        bcs     passed
        b       ror_failed

ror_failed:
        mov     r7, 4
        bl      infinite

passed:
        TestPassed

infinite:
        b       infinite