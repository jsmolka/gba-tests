memory:
        ; Tests for memory operations

        ; Setup initial values
        imm32   r6, 0x02000000
        imm32   r5, 0xFFFFFFFF
        imm32   r4, 0x0F0F0F0F
        mov     r3, 8

t200:
        ; Thumb 6: ldr rd, [pc, word8]
        ldr     r0, [pc, 4]
        cmp     r0, r5
        bne     t200f

        b       t201

align 4
        db      255,255,255,255

t200f:
        Failed 200

t201:
        ; Thumb 7: ldr / str rd, [rb, ro]
        str     r5, [r6, r3]
        ldr     r0, [r6, r3]
        cmp     r0, r5
        bne     t201f

        b       t202

t201f:
        Failed 201

t202:
        ; Thumb 7: ldrb / strb rd, [rb, ro]
        lsr     r1, r4, 24

        strb    r4, [r6, r3]
        ldrb    r0, [r6, r3]
        cmp     r0, r1
        bne     t202f

        b       t203

t202f:
        Failed 202

t203:
        ; Thumb 8: ldrh / strh rd, [rb, ro]
        lsr     r1, r5, 16

        strh    r5, [r6, r3]
        ldrh    r0, [r6, r3]
        cmp     r0, r1
        bne     t203f

        b       t204

t203f:
        Failed 203

t204:
        ; Thumb 8: ldrsb rd, [rb, ro]
        lsr     r1, r4, 24

        str     r4, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r1
        bne     t204f

        str     r5, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r5
        bne     t204f

        b       t205

t204f:
        Failed 204

t205:
        ; Thumb 8: ldrsh rd, [rb, ro]
        lsr     r1, r4, 16

        str     r4, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r1
        bne     t205f

        str     r5, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r5
        bne     t205f

        b       t206

t205f:
        Failed 205

t206:
        ; Thumb 9: ldr / str rd, [rb, offset5]
        str     r4, [r6, 8]
        ldr     r0, [r6, 8]
        cmp     r0, r4
        bne     t206f

        b       t207

t206f:
        Failed 206

t207:
        ; Thumb 9: ldrb / strb rd, [rb, offset5]
        lsr     r1, r5, 24

        strb    r5, [r6, 8]
        ldrb    r0, [r6, 8]
        cmp     r0, r1
        bne     t207f

        b       t208

t207f:
        Failed 207

t208:
        ; Thumb 10: ldrh / strh rd, [rb, offset5]
        lsr     r1, r4, 16

        strh    r4, [r6, 8]
        ldrh    r0, [r6, 8]
        cmp     r0, r1
        bne     t208f

        b       t209

t208f:
        Failed 208

t209:
        ; Thumb 11: ldr / str rd, [sp, word8]
        str     r5, [sp, 4]
        push    {r0}
        ldr     r0, [sp, 8]
        cmp     r0, r5
        bne     t209f

        b       t210

t209f:
        Failed 209

t210:
        ; Thumb 14: push / pop {rlist}
        mov     r0, 1
        mov     r1, 2

        push    {r0, r1}
        pop     {r2, r3}
        cmp     r0, r2
        bne     t210f

        cmp     r1, r3
        bne     t210f

        b       t211

t210f:
        Failed 210

t211:
        ; Thumb 15: ldmia / stmia rd!, {rlist}
        mov     r0, 2
        mov     r1, 4
        mov     r3, r6

        stmia   r3!, {r0, r1}
        sub     r3, 8
        cmp     r3, r6
        bne     t211f

        ldmia   r3!, {r2, r4}
        sub     r3, 8
        cmp     r3, r6
        bne     t211f

        cmp     r0, r2
        bne     t211f

        cmp     r1, r4
        bne     t211f

        b       passed

t211f:
        Failed 211
