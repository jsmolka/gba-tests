memory:
        ; Tests for memory operations
        ; Todo: t200
        ; Todo: str(h) alignment
        ; Todo: ldr, ldrh, ldsh special cases
        ; Todo: t14, sp aligned?
        ; Todo: push, pop, ldm, stm force align?
        mov     r6, 2
        lsl     r6, 24

t200:
        ; THUMB 6: ldr rd, [pc, imm8 << 2]
        b       t201

t201:
        ; THUMB 7: <ldr|str> rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4

        str     r0, [r6, r1]
        ldr     r2, [r6, r1]
        cmp     r2, r0
        bne     t201f

        add     r6, 16
        b       t202

t201f:
        failed  201

t202:
        ; THUMB 7: <ldrb|strb> rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4

        strb    r0, [r6, r1]
        ldr     r2, [r6, r1]
        cmp     r2, 0xFF
        bne     t202f

        add     r6, 16
        b       t203

t202f:
        failed  202

t203:
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4

        str     r0, [r6, r1]
        ldrb    r2, [r6, r1]
        cmp     r2, 0xFF
        bne     t203f

        add     r6, 16
        b       t204

t203f:
        failed  203

t204:
        ; THUMB 8: <ldrh|strh> rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        mov     r2, 4

        strh    r0, [r6, r2]
        ldr     r3, [r6, r2]
        cmp     r3, r1
        bne     t204f

        add     r6, 16
        b       t205

t204f:
        failed  204

t205:
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        mov     r2, 4

        str     r0, [r6, r2]
        ldrh    r3, [r6, r2]
        cmp     r3, r1
        bne     t205f

        add     r6, 16
        b       t206

t205f:
        failed  205

t206:
        ; THUMB 8: ldrsb rd, [rb, ro]
        mov     r0, 0x0F
        mov     r1, 4

        str     r0, [r6, r1]
        ldrsb   r2, [r6, r1]
        cmp     r2, r0
        bne     t206f

        add     r6, 16
        b       t207

t206f:
        failed  206

t207:
        mov     r0, 0xFF
        mov     r1, 0
        mvn     r1, r1
        mov     r2, 4

        str     r0, [r6, r2]
        ldrsb   r3, [r6, r2]
        cmp     r3, r1
        bne     t207f

        add     r6, 16
        b       t208

t207f:
        failed  207

t208:
        ; THUMB 8: ldrsh rd, [rb, ro]
        mov     r0, 0xFF
        lsl     r0, 4
        mov     r1, 4

        str     r0, [r6, r1]
        ldrsh   r2, [r6, r1]
        cmp     r2, r0
        bne     t208f

        add     r6, 16
        b       t209

t208f:
        failed  208

t209:
        mov     r0, 0xFF
        lsl     r0, 8
        mov     r1, 4

        str     r0, [r6, r1]
        ldrsh   r2, [r6, r1]
        mov     r3, 1
        lsl     r3, 31
        asr     r3, 23
        cmp     r3, r2
        bne     t209f

        add     r6, 16
        b       t210

t209f:
        failed  209

t210:
        ; THUMB 9: <ldr|str> rd, [rb, imm5 << 2]
        mov     r0, 0
        mvn     r0, r0

        str     r0, [r6, 4]
        ldr     r1, [r6, 4]
        cmp     r1, r0
        bne     t210f

        add     r6, 16
        b       t211

t210f:
        failed  210

t211:
        ; THUMB 9: <ldrb|strb> rd, [rb, imm5]
        mov     r0, 0
        mvn     r0, r0

        strb    r0, [r6, 4]
        ldr     r1, [r6, 4]
        cmp     r1, 0xFF
        bne     t211f

        add     r6, 16
        b       t212

t211f:
        failed  211

t212:
        mov     r0, 0
        mvn     r0, r0

        str     r0, [r6, 4]
        ldrb    r1, [r6, 4]
        cmp     r1, 0xFF
        bne     t212f

        add     r6, 16
        b       t213

t212f:
        failed  212

t213:
        ; THUMB 10: <ldrh|strh> rd, [rb, imm5 << 1]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16

        strh    r0, [r6, 4]
        ldr     r2, [r6, 4]
        cmp     r2, r1
        bne     t213f

        add     r6, 16
        b       t214

t213f:
        failed  213

t214:
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16

        str     r0, [r6, 4]
        ldrh    r2, [r6, 4]
        cmp     r2, r1
        bne     t214f

        add     r6, 16
        b       t215

t214f:
        failed  214

t215:
        ; THUMB 11: <ldr|str> rd, [sp, imm8 << 2]
        mov     r0, 0
        mvn     r0, r0
        str     r0, [sp, 4]
        ldr     r1, [sp, 4]
        cmp     r1, r0
        bne     t215f

        add     r6, 16
        b       t216

t215f:
        failed  215

t216:
        ; THUMB 14: <push|pop> {rlist}
        mov     r0, 1
        mov     r1, 2

        push    {r0, r1}
        pop     {r2, r3}
        cmp     r0, r2
        bne     t216f
        cmp     r1, r3
        bne     t216f

        b       t217

t216f:
        failed  216

t217:
        ; THUMB 14: Store LR / load PC
        adr     r0, t218
        mov     lr, r0

        push    {r1, lr}
        pop     {r1, pc}

t217f:
        failed  217

t218:
        ; THUMB 14: Align PC
        adr     r0, t219
        add     r0, 1
        mov     lr, r0

        push    {r1, lr}
        pop     {r1, pc}

t218f:
        failed  218

t219:
        ; THUMB 15: <ldmia|stmia> rd!, {rlist}
        mov     r0, 1
        mov     r1, 2
        mov     r3, r6

        stmia   r3!, {r0, r1}
        sub     r3, 8
        cmp     r3, r6
        bne     t219f

        ldmia   r3!, {r2, r4}
        sub     r3, 8
        cmp     r3, r6
        bne     t219f

        cmp     r0, r2
        bne     t219f
        cmp     r1, r4
        bne     t219f

        b       memory_passed

t219f:
        failed  219

memory_passed:
