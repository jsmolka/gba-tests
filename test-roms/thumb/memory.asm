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

        imm32t  r6, 0x02000000

mem_1:
        ; Thumb 7: ldr / str rd, [rb, ro]
        imm32t  r0, 0xFFFFFFFF
        str     r0, [r6]
        ldr     r1, [r6]
        cmp     r0, r1
        beq     mem_2
        mov     r7, 1
        bl      infinite

mem_2:
        imm32t  r0, 0xEEEEEEEE
        mov     r1, 3
        str     r0, [r6, r1]
        ldr     r1, [r6, r1]
        cmp     r0, r1
        beq     mem_3
        mov     r7, 2
        bl      infinite

mem_3:
        ; Thumb 7: ldrb / strb rd, [rb, ro]
        imm32t  r0, 0xDDDDDDDD
        mov     r2, 0xDD
        strb    r0, [r6]
        ldrb    r1, [r6]
        cmp     r1, r2
        beq     mem_4
        mov     r7, 3
        bl      infinite

mem_4:
        imm32t  r0, 0xCCCCCCCC
        imm32t  r2, 0xCC
        mov     r1, 3
        strb    r0, [r6, r1]
        ldrb    r1, [r6, r1]
        cmp     r1, r2
        beq     mem_5
        mov     r7, 4
        bl      infinite

mem_5:
        ; Thumb 8: ldrh / strh rd, [rb, ro]
        imm32t  r0, 0xBBBBBBBB
        imm32t  r2, 0xBBBB
        strh    r0, [r6]
        ldrh    r1, [r6]
        cmp     r1, r2
        beq     passed;mem_6
        mov     r7, 5
        bl      infinite

;mem_6:
;        imm32t  r0, 0xAAAAAAAA
;        imm32t  r2, 0xAAAA
;        mov     r1, 3
;        strh    r0, [r6, r1]
;        ldrh    r3, [r6, r1]
;        cmp     r3, r2
;        beq     passed
;        mov     r7, 6
;        bl      infinite

passed:
        TestPassed

infinite:
        b       infinite
