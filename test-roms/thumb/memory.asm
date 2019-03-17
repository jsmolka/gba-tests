test_memory:
        ; Tests for memory operations

        ; Setup initial values
        imm32   r6, 0x02000000
        imm32   r5, 0xFFFFFFFF
        imm32   r4, 0x0F0F0F0F
        mov     r3, 8

test_200:
        ; Thumb 6: ldr rd, [pc, word8]
        ldr     r0, [pc, 4]
        cmp     r0, r5
        bne     test_200f

        b       test_201

align 4
        db      255,255,255,255

test_200f:
        TestFailed 200

test_201:
        ; Thumb 7: ldr / str rd, [rb, ro]
        str     r5, [r6, r3]
        ldr     r0, [r6, r3]
        cmp     r0, r5
        bne     test_201f

        b       test_202

test_201f:
        TestFailed 201

test_202:
        ; Thumb 7: ldrb / strb rd, [rb, ro]
        lsr     r1, r4, 24

        strb    r4, [r6, r3]
        ldrb    r0, [r6, r3]
        cmp     r0, r1
        bne     test_202f

        b       test_203

test_202f:
        TestFailed 202

test_203:
        ; Thumb 8: ldrh / strh rd, [rb, ro]
        lsr     r1, r5, 16

        strh    r5, [r6, r3]
        ldrh    r0, [r6, r3]
        cmp     r0, r1
        bne     test_203f

        b       test_204

test_203f:
        TestFailed 203

test_204:
        ; Thumb 8: ldrsb rd, [rb, ro]
        lsr     r1, r4, 24

        str     r4, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r1
        bne     test_204f

        str     r5, [r6, r3]
        ldrsb   r0, [r6, r3]
        cmp     r0, r5
        bne     test_204f

        b       test_205

test_204f:
        TestFailed 204

test_205:
        ; Thumb 8: ldrsh rd, [rb, ro]
        lsr     r1, r4, 16

        str     r4, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r1
        bne     test_205f

        str     r5, [r6, r3]
        ldrsh   r0, [r6, r3]
        cmp     r0, r5
        bne     test_205f

        b       test_206

test_205f:
        TestFailed 205

test_206:
        ; Thumb 9: ldr / str rd, [rb, offset5]
        str     r4, [r6, 8]
        ldr     r0, [r6, 8]
        cmp     r0, r4
        bne     test_206f

        b       test_207

test_206f:
        TestFailed 206

test_207:
        ; Thumb 9: ldrb / strb rd, [rb, offset5]
        lsr     r1, r5, 24

        strb    r5, [r6, 8]
        ldrb    r0, [r6, 8]
        cmp     r0, r1
        bne     test_207f

        b       test_208

test_207f:
        TestFailed 207

test_208:
        ; Thumb 10: ldrh / strh rd, [rb, offset5]
        lsr     r1, r4, 16

        strh    r4, [r6, 8]
        ldrh    r0, [r6, 8]
        cmp     r0, r1
        bne     test_208f

        b       test_209

test_208f:
        TestFailed 208

test_209:
        ; Thumb 11: ldr / str rd, [sp, word8]
        str     r5, [sp, 4]
        push    {r0}
        ldr     r0, [sp, 8]
        cmp     r0, r5
        bne     test_209f

        b       test_210

test_209f:
        TestFailed 209

test_210:
        ; Thumb 14: push / pop {rlist}
        mov     r0, 1
        mov     r1, 2

        push    {r0, r1}
        pop     {r2, r3}
        cmp     r0, r2
        bne     test_210f

        cmp     r1, r3
        bne     test_210f

        b       test_211

test_210f:
        TestFailed 210

test_211:
        ; Thumb 15: ldmia / stmia rd!, {rlist}
        mov     r0, 2
        mov     r1, 4
        mov     r3, r6

        stmia   r3!, {r0, r1}
        sub     r3, 8
        cmp     r3, r6
        bne     test_211f

        ldmia   r3!, {r2, r4}
        sub     r3, 8
        cmp     r3, r6
        bne     test_211f

        cmp     r0, r2
        bne     test_211f

        cmp     r1, r4
        bne     test_211f

        b       test_passed

test_211f:
        TestFailed 211
