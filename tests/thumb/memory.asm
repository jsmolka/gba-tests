memory:
        ; Tests for memory operations
        mem     equ r6
        mov     mem, 2
        lsl     mem, 24

t200:
        ; THUMB 6: ldr rd, [pc, imm8 << 2]
        mov     r0, 0
        mvn     r0, r0
        ldr     r1, [pc, 8]
        cmp     r1, r0
        bne     f200

        add     mem, 32
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
        str     r0, [mem, r1]
        ldr     r2, [mem, r1]
        cmp     r2, r0
        bne     f201

        add     mem, 32
        b       t202

f201:
        failed  201

t202:
        ; THUMB 7: strb rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4
        strb    r0, [mem, r1]
        ldr     r2, [mem, r1]
        cmp     r2, 0xFF
        bne     f202

        add     mem, 32
        b       t203

f202:
        failed  202

t203:
        ; THUMB 7: ldrb rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        mov     r1, 4
        str     r0, [mem, r1]
        ldrb    r2, [mem, r1]
        cmp     r2, 0xFF
        bne     f203

        add     mem, 32
        b       t204

f203:
        failed  203

t204:
        ; THUMB 7: Misaligned load (rotated)
        mov     r0, 0
        mov     r1, 0xFF
        str     r1, [mem, r0]
        mov     r0, 1
        mov     r3, 8
        ror     r1, r3
        ldr     r2, [mem, r0]
        cmp     r2, r1
        bne     f204

        add     mem, 32
        b       t205

f204:
        failed  204

t205:
        ; THUMB 8: strh rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        mov     r2, 4
        strh    r0, [mem, r2]
        ldr     r3, [mem, r2]
        cmp     r3, r1
        bne     f205

        add     mem, 32
        b       t206

f205:
        failed  205

t206:
        ; THUMB 8: ldrh rd, [rb, ro]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        mov     r2, 4
        str     r0, [mem, r2]
        ldrh    r3, [mem, r2]
        cmp     r3, r1
        bne     f206

        add     mem, 32
        b       t207

f206:
        failed  206

t207:
        ; THUMB 8: ldrsb rd, [rb, ro]
        mov     r0, 0x7F
        mov     r1, 4
        str     r0, [mem, r1]
        ldrsb   r2, [mem, r1]
        cmp     r2, r0
        bne     f207

        add     mem, 32
        b       t208

f207:
        failed  207

t208:
        mov     r0, 0xFF
        mov     r1, 0
        mvn     r1, r1
        mov     r2, 4
        str     r0, [mem, r2]
        ldrsb   r3, [mem, r2]
        cmp     r3, r1
        bne     f208

        add     mem, 32
        b       t209

f208:
        failed  208

t209:
        ; THUMB 8: ldrsh rd, [rb, ro]
        mov     r0, 0xFF
        lsl     r0, 4
        mov     r1, 4
        str     r0, [mem, r1]
        ldrsh   r2, [mem, r1]
        cmp     r2, r0
        bne     f209

        add     mem, 32
        b       t210

f209:
        failed  209

t210:
        mov     r0, 0xFF
        lsl     r0, 8
        mov     r1, 4
        str     r0, [mem, r1]
        ldrsh   r2, [mem, r1]
        mov     r3, 1
        lsl     r3, 31
        asr     r3, 23
        cmp     r3, r2
        bne     f210

        add     mem, 32
        b       t211

f210:
        failed  210

t211:
        ; THUMB 8: Misaligned load half (rotated)
        mov     r0, 0
        mov     r1, 0xFF
        strh    r1, [mem, r0]
        add     r0, 1
        mov     r2, 8
        ror     r1, r2
        ldrh    r2, [mem, r0]
        cmp     r2, r1
        bne     f211

        add     mem, 32
        b       t212

f211:
        failed  211

t212:
        ; THUMB 8: Misaligned load half signed (signed byte)
        mov     r0, 0
        mov     r1, 0xFF
        lsl     r1, 8
        strh    r1, [mem, r0]
        mvn     r1, r0
        add     r0, 1
        ldrsh   r2, [mem, r0]
        cmp     r2, r1
        bne     f212

        add     mem, 32
        b       t213

f212:
        failed  212

t213:
        ; THUMB 9: <ldr|str> rd, [rb, imm5 << 2]
        mov     r0, 0
        mvn     r0, r0
        str     r0, [mem, 4]
        ldr     r1, [mem, 4]
        cmp     r1, r0
        bne     f213

        add     mem, 32
        b       t214

f213:
        failed  213

t214:
        ; THUMB 9: strb rd, [rb, imm5]
        mov     r0, 0
        mvn     r0, r0
        strb    r0, [mem, 4]
        ldr     r1, [mem, 4]
        cmp     r1, 0xFF
        bne     f214

        add     mem, 32
        b       t215

f214:
        failed  214

t215:
        ; THUMB 9: ldrb rd, [rb, imm5]
        mov     r0, 0
        mvn     r0, r0
        str     r0, [mem, 4]
        ldrb    r1, [mem, 4]
        cmp     r1, 0xFF
        bne     f215

        add     mem, 32
        b       t216

f215:
        failed  215

t216:
        ; THUMB 9: Misaligned load (rotated)
        mov     r0, 0xFF
        str     r0, [mem]
        mov     r1, 8
        ror     r0, r1
        mov     r3, mem
        add     r3, 1
        ldr     r1, [r3]
        cmp     r1, r0
        bne     f216

        add     mem, 32
        b       t217

f216:
        failed  216

t217:
        ; THUMB 10: strh rd, [rb, imm5 << 1]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        strh    r0, [mem, 4]
        ldr     r2, [mem, 4]
        cmp     r2, r1
        bne     f217

        add     mem, 32
        b       t218

f217:
        failed  217

t218:
        ; THUMB 10: ldrh rd, [rb, imm5 << 1]
        mov     r0, 0
        mvn     r0, r0
        lsr     r1, r0, 16
        str     r0, [mem, 4]
        ldrh    r2, [mem, 4]
        cmp     r2, r1
        bne     f218

        add     mem, 32
        b       t219

f218:
        failed  218

t219:
        ; THUMB 10: Misaligned load half (rotated)
        mov     r0, 0xFF
        strh    r0, [mem]
        mov     r1, 8
        ror     r0, r1
        mov     r2, mem
        add     r2, 1
        ldrh    r1, [r2]
        cmp     r1, r0
        bne     f219

        add     mem, 32
        b       t220

f219:
        failed  219

t220:
        ; THUMB 11: <ldr|str> rd, [sp, imm8 << 2]
        mov     r0, 0
        mvn     r0, r0
        str     r0, [sp, 4]
        ldr     r1, [sp, 4]
        cmp     r1, r0
        bne     f220

        add     mem, 32
        b       t221

f220:
        failed  220

t221:
        ; THUMB 11: Misaligned load (rotated)
        mov     r0, 0xFF
        str     r0, [sp, 4]
        mov     r2, 8
        ror     r0, r2
        mov     r1, sp
        add     r1, 1
        mov     sp, r1
        ldr     r2, [sp, 4]
        sub     r1, 1
        mov     sp, r1
        cmp     r2, r0
        bne     f221

        add     mem, 32
        b       t222

f221:
        failed  221

t222:
        ; THUMB 14: <push|pop> {rlist}
        mov     r0, 32
        mov     r1, 64
        push    {r0, r1}
        pop     {r2, r3}
        cmp     r0, r2
        bne     f222
        cmp     r1, r3
        bne     f222

        add     mem, 32
        b       t223

f222:
        failed  222

t223:
        ; THUMB 14: Store LR / load PC
        adr     r0, t224
        mov     r0, r0
        mov     lr, r0
        push    {r1, lr}
        pop     {r1, pc}

f223:
        failed  223

align 4
t224:
        ; THUMB 14: PC alignment
        adr     r0, t225
        add     r0, 1
        mov     lr, r0
        push    {r1, lr}
        pop     {r1, pc}

f224:
        failed  224

t225:
        ; THUMB 14: Push / pop do not align base
        mov     r0, sp
        mov     r1, sp
        add     r1, 1
        mov     sp, r1
        push    {r2, r3}
        pop     {r2, r3}
        mov     r2, sp
        mov     sp, r0
        sub     r2, 1
        cmp     r2, r0
        bne     f225

        add     mem, 32
        b       t226

f225:
        failed  225

t226:
        ; THUMB 15: <ldmia|stmia> rd!, {rlist}
        mov     r0, 1
        mov     r1, 2
        mov     r3, mem
        stmia   r3!, {r0, r1}
        sub     r3, 8
        cmp     r3, mem
        bne     f226
        ldmia   r3!, {r2, r4}
        sub     r3, 8
        cmp     r3, mem
        bne     f226
        cmp     r0, r2
        bne     f226
        cmp     r1, r4
        bne     f226

        add     mem, 32
        b       t227

f226:
        failed  226

t227:
        ; THUMB 15: Load empty rlist
        adr     r0, t228
        mov     r0, r0
        str     r0, [mem]
        mov     r0, mem
        dh      0xC800  ; ldm r0!, {}

f227:
        failed  227

t228:
        sub     r0, 0x40
        cmp     r0, mem
        bne     f228

        add     mem, 32
        b       t229

f228:
        failed  228

t229:
        ; THUMB 15: Store empty rlist
        mov     r0, mem
        dh      0xC000  ; stm r0!, {}
        mov     r1, pc
        ldr     r2, [mem]
        cmp     r2, r1
        bne     f229

        sub     r0, 0x40
        cmp     r0, mem
        bne     f229

        add     mem, 32
        b       t230

f229:
        failed  229

t230:
        ; THUMB 15: Base in rlist
        mov     r1, mem
        dh      0xC10F  ; stm r1!, {r0-r3}
        sub     r1, 0x10
        ldm     r1!, {r2-r5}
        cmp     r1, r3
        bne     f230

        add     mem, 32
        b       t231

f230:
        failed  230

t231:
        ; THUMB 15: Base in rlist
        mov     r2, mem
        dh      0xC20F  ; stm r2!, {r0-r3}
        sub     r1, 0x10
        ldm     r1!, {r3-r6}
        cmp     r1, r4
        bne     f231

        add     mem, 32
        b       t232

f231:
        failed  231

t232:
        ; THUMB 15: Load / store do not align base
        mov     r0, mem
        add     r0, 1
        stm     r0!, {r1, r2}
        sub     r0, 8
        ldm     r0!, {r1, r2}
        sub     r0, 9
        cmp     r0, mem
        bne     f232

        add     mem, 32
        b       memory_passed

f232:
        failed  232

memory_passed:
        restore mem
