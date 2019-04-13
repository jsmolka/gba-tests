memory:
        ; Tests for memory operations
        ; Todo: Test SP pop alignment with real GBA
        mov     r6, 2
        lsl     r6, 24

t200:
        ; THUMB 6: ldr rd, [pc, imm8 << 2]
        mov     r0, 0
        mvn     r0, r0
        ldr     r1, [pc, 8]
        cmp     r1, r0
        bne     f200

        b       t201

align 4
        dw      0xFFFFFFFF

f200:
        failed  200

t201:
        ; THUMB 7: <ldr|str> rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4
        str     r0, [r6, r1]
        ldr     r2, [r6, r1]
        cmp     r2, r0
        bne     f201

        add     r6, 32
        b       t202

f201:
        failed  201

t202:
        ; THUMB 7: strb rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4
        strb    r0, [r6, r1]
        ldr     r2, [r6, r1]
        cmp     r2, 0xFF
        bne     f202

        add     r6, 32
        b       t203

f202:
        failed  202

t203:
        ; THUMB 7: ldrb rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4
        str     r0, [r6, r1]
        ldrb    r2, [r6, r1]
        cmp     r2, 0xFF
        bne     f203

        add     r6, 32
        b       t204

f203:
        failed  203

t204:
        ; THUMB 8: strh rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        mov     r2, 4
        strh    r0, [r6, r2]
        ldr     r3, [r6, r2]
        cmp     r3, r1
        bne     f204

        add     r6, 32
        b       t205

f204:
        failed  204

t205:
        ; THUMB 8: ldrh rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        mov     r2, 4
        str     r0, [r6, r2]
        ldrh    r3, [r6, r2]
        cmp     r3, r1
        bne     f205

        add     r6, 32
        b       t206

f205:
        failed  205

t206:
        ; THUMB 8: ldrsb rd, [rb, ro]
        mov     r0, 0x7F
        mov     r1, 4
        str     r0, [r6, r1]
        ldrsb   r2, [r6, r1]
        cmp     r2, r0
        bne     f206

        add     r6, 32
        b       t207

f206:
        failed  206

t207:
        mov     r0, 0xFF
        mov     r1, 0
        mvn     r1, r1
        mov     r2, 4
        str     r0, [r6, r2]
        ldrsb   r3, [r6, r2]
        cmp     r3, r1
        bne     f207

        add     r6, 32
        b       t208

f207:
        failed  207

t208:
        ; THUMB 8: ldrsh rd, [rb, ro]
        mov     r0, 0xFF
        lsl     r0, 4
        mov     r1, 4
        str     r0, [r6, r1]
        ldrsh   r2, [r6, r1]
        cmp     r2, r0
        bne     f208

        add     r6, 32
        b       t209

f208:
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
        bne     f209

        add     r6, 32
        b       t210

f209:
        failed  209

t210:
        ; THUMB 9: <ldr|str> rd, [rb, imm5 << 2]
        mov     r0, 0
        mvn     r0, r0
        str     r0, [r6, 4]
        ldr     r1, [r6, 4]
        cmp     r1, r0
        bne     f210

        add     r6, 32
        b       t211

f210:
        failed  210

t211:
        ; THUMB 9: strb rd, [rb, imm5]
        mov     r0, 0
        mvn     r0, r0
        strb    r0, [r6, 4]
        ldr     r1, [r6, 4]
        cmp     r1, 0xFF
        bne     f211

        add     r6, 32
        b       t212

f211:
        failed  211

t212:
        ; THUMB 9: ldrb rd, [rb, imm5]
        mov     r0, 0
        mvn     r0, r0
        str     r0, [r6, 4]
        ldrb    r1, [r6, 4]
        cmp     r1, 0xFF
        bne     f212

        add     r6, 32
        b       t213

f212:
        failed  212

t213:
        ; THUMB 10: strh rd, [rb, imm5 << 1]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        strh    r0, [r6, 4]
        ldr     r2, [r6, 4]
        cmp     r2, r1
        bne     f213

        add     r6, 32
        b       t214

f213:
        failed  213

t214:
        ; THUMB 10: ldrh rd, [rb, imm5 << 1]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        str     r0, [r6, 4]
        ldrh    r2, [r6, 4]
        cmp     r2, r1
        bne     f214

        add     r6, 32
        b       t215

f214:
        failed  214

t215:
        ; THUMB 11: <ldr|str> rd, [sp, imm8 << 2]
        mov     r0, 0
        mvn     r0, r0
        str     r0, [sp, 4]
        ldr     r1, [sp, 4]
        cmp     r1, r0
        bne     f215

        add     r6, 32
        b       t216

f215:
        failed  215

t216:
        ; THUMB 14: <push|pop> {rlist}
        mov     r0, 32
        mov     r1, 64
        push    {r0, r1}
        pop     {r2, r3}
        cmp     r0, r2
        bne     f216
        cmp     r1, r3
        bne     f216

        b       t217

f216:
        failed  216

t217:
        ; THUMB 14: Store LR / load PC
        adr     r0, t218
        mov     r0, r0
        mov     lr, r0
        push    {r1, lr}
        pop     {r1, pc}

t217f:
        failed  217

t218:
        ; THUMB 14: Alignment PC
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
        bne     f219
        ldmia   r3!, {r2, r4}
        sub     r3, 8
        cmp     r3, r6
        bne     f219
        cmp     r0, r2
        bne     f219
        cmp     r1, r4
        bne     f219

        add     r6, 32
        b       t220

f219:
        failed  219

t220:
        ; Store alignment
        mov     r0, 32
        mov     r1, 1
        str     r0, [r6, r1]
        ldr     r1, [r6]
        cmp     r1, r0
        bne     f220
        mov     r0, 64
        mov     r1, 3
        str     r0, [r6, r1]
        ldr     r1, [r6]
        cmp     r1, r0
        bne     f220

        add     r6, 32
        b       t221

f220:
        failed  220

t221:
        ; Store half alignment
        mov     r0, 32
        mov     r1, 1
        strh    r0, [r6, r1]
        ldrh    r1, [r6]
        cmp     r1, r0
        bne     f221
        mov     r0, 64
        mov     r1, 3
        strh    r0, [r6, r1]
        ldrh    r1, [r6, 2]
        cmp     r1, r0
        bne     f221

        add     r6, 32
        b       t222

f221:
        failed  221

t222:
        ; Misaligned load
        mov     r0, 32
        lsl     r0, 8
        mov     r1, 1
        str     r0, [r6]
        ldr     r1, [r6, r1]
        cmp     r1, 32
        bne     f222

        add     r6, 32
        b       t223

f222:
        failed  222

t223:
        ; Misaligned load half
        mov     r0, 32
        lsl     r0, 8
        mov     r1, 1
        str     r0, [r6]
        ldrh    r1, [r6, r1]
        cmp     r1, 32
        bne     f223

        add     r6, 32
        b       t224

f223:
        failed  223

t224:
        ; Misaligned load half sign extended
        mov     r0, 0xFF
        lsl     r0, 8
        add     r0, 0xEE
        mov     r1, 0
        mvn     r1, r1
        mov     r2, 1
        str     r0, [r6]
        ldrsh   r2, [r6, r2]
        cmp     r2, r1
        bne     f224

        add     r6, 32
        b       t225

f224:
        failed  224

t225:
        ; THUMB 14: Aligned pop
        mov     r0, 32
        mov     r1, 64
        push    {r0, r1}
        mov     r2, sp
        add     r2, 1
        mov     sp, r2
        pop     {r3, r4}
        cmp     r0, r3
        bne     f225
        cmp     r1, r4
        bne     f225

        sub     r2, 1
        mov     sp, r2
        b       t226

f225:
        failed  225

t226:
        ; THUMB 14: Aligned push
        mov     r0, 32
        mov     r1, 64
        mov     r2, sp
        add     r2, 1
        mov     sp, r2
        push    {r0, r1}
        sub     r2, 9
        mov     sp, r2
        pop     {r3, r4}
        cmp     r0, r3
        bne     f226
        cmp     r1, r4
        bne     f226

        b       t227

f226:
        failed  226

t227:
        ; THUMB 15: Aligned load / store multiple
        mov     r0, 32
        add     r1, r6, 4
        add     r2, r6, 1
        stmia   r2!, {r0}
        cmp     r2, r1
        bne     f227
        add     r2, r6, 1
        ldmia   r2!, {r3}
        cmp     r2, r1
        bne     f227
        cmp     r3, r0
        bne     f227

        b       memory_passed

f227:
        failed  227

memory_passed:
