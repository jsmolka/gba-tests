data_processing:
        ; Tests for the data processing instruction

t200:
        ; ARM 3: mov{cond}{s} rd, <op2>
        mov     r0, 32
        cmp     r0, 32
        bne     t200f

        b       t201

t200f:
        failed  200

t201:
        ; ARM 3: mvn{cond}{s} rd, <op2>
        mvn     r0, 0
        adds    r0, 1
        bne     t201f

        b       t202

t201f:
        failed  201

t202:
        ; ARM 3: and{cond}{s} rd, rn, <op2>
        mov     r0, 0xFF
        and     r0, 0xF
        cmp     r0, 0xF
        bne     t202f

        b       t203

t202f:
        failed  202

t203:
        ; ARM 3: eor{cond}{s} rd, rn, <op2>
        mov     r0, 0xF0
        eor     r0, 0xFF
        cmp     r0, 0xF
        bne     t203f

        b       t204

t203f:
        failed  203

t204:
        ; ARM 3: orr{cond}{s} rd, rn, <op2>
        mov     r0, 0xF0
        orr     r0, 0xF
        cmp     r0, 0xFF
        bne     t204f

        b       t205

t204f:
        failed  204

t205:
        ; ARM 3: bic{cond}{s} rd, rn, <op2>
        mov     r0, 0xFF
        bic     r0, 0xF
        cmp     r0, 0xF0
        bne     t205f

        b       t206

t205f:
        failed  205

t206:
        ; ARM 3: add{cond}{s} rd, rn, <op2>
        mov     r0, 32
        add     r0, 32
        cmp     r0, 64
        bne     t206f

        b       t207

t206f:
        failed  206

t207:
        ; ARM 3: adc{cond}{s} rd, rn, <op2>
        msr     cpsr_f, 0
        movs    r0, 32
        adc     r0, 32
        cmp     r0, 64
        bne     t207f

        msr     cpsr_f, C
        mov     r0, 32
        adc     r0, 32
        cmp     r0, 65
        bne     t207f

        b       t208

t207f:
        failed  207

t208:
        ; ARM 3: sub{cond}{s} rd, rn, <op2>
        mov     r0, 64
        sub     r0, 32
        cmp     r0, 32
        bne     t208f

        b       t209

t208f:
        failed  208

t209:
        ; ARM 3: rsb{cond}{s} rd, rn, <op2>
        mov     r0, 32
        rsb     r0, 64
        cmp     r0, 32
        bne     t209f

        b       t210

t209f:
        failed  209

t210:
        ; ARM 3: sbc{cond}{s} rd, rn, <op2>
        msr     cpsr_f, 0
        mov     r0, 64
        sbc     r0, 32
        cmp     r0, 31
        bne     t210f

        msr     cpsr_f, C
        mov     r0, 64
        sbc     r0, 32
        cmp     r0, 32
        bne     t210f

        b       t211

t210f:
        failed  210

t211:
        ; ARM 3: rsc{cond}{s} rd, rn, <op2>
        msr     cpsr_f, 0
        mov     r0, 32
        rsc     r0, 64
        cmp     r0, 31
        bne     t211f

        msr     cpsr_f, C
        mov     r0, 32
        rsc     r0, 64
        cmp     r0, 32
        bne     t211f

        b       t212

t211f:
        failed  211

t212:
        ; ARM 3: cmp{cond} rn, <op2>
        mov     r0, 32
        cmp     r0, r0
        bne     t212f

        b       t213

t212f:
        failed  212

t213:
        ; ARM 3: cmn{cond} rn, <op2>
        mov     r0, 1 shl 31
        cmn     r0, r0
        bne     t213f

        b       t214

t213f:
        failed  213

t214:
        ; ARM 3: tst{cond} rn, <op2>
        mov     r0, 0xF0
        mov     r1, 0x0F
        tst     r1, r0
        bne     t214f

        b       t215

t214f:
        failed  214

t215:
        ; ARM 3: teq{cond} rd, <op2>
        mov     r0, 0xFF
        teq     r0, r0
        bne     t215f

        b       t216

t215f:
        failed  215

t216:
        ; ARM 3: Operand types
        mov     r0, 0xFF00
        mov     r1, 0xFF
        mov     r1, r1, lsl 8
        cmp     r1, r0
        bne     t216f

        b       t217

t216f:
        failed  216

t217:
        ; ARM 3: PC as operand
        add     r0, pc, 4
        cmp     r0, pc
        bne     t217f

        b       t218

t217f:
        failed  217

t218:
        ; ARM 3: Write to PC
        adr     r0, t219
        mov     pc, r0

t218f:
        failed  218

t219:
        ; ARM 3: Write to PC aligment and flushing
        add     pc, 6
        b       t219f
        b       t219f

        sub     pc, 2
        b       t220
        b       t219f

t219f:
        failed  219

t220:
        ; ARM 3: Write to PC with S bit set
        mov     r8, 0xA
        mov     r9, 0xB
        msr     cpsr, MODE_FIQ
        mov     r8, 0xC
        mov     r9, 0xD
        msr     spsr, MODE_USR

        subs    pc, 4
        cmp     r8, 0xA
        bne     t220f
        cmp     r9, 0xB
        bne     t220f

        b       data_processing_passed

t220f:
        failed  220

data_processing_passed:
