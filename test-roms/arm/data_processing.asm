data_processing:
        ; Tests for the data processing instruction
        ; Todo: writing to PC with S bit set

t200:
        ; ARM 3: mov{cond}{s} rd, <op2>
        mov     r0, 0
        cmp     r0, 0
        bne     t200f

        mov     r0, 255
        cmp     r0, 255
        bne     t200f

        b       t201

t200f:
        failed  200

t201:
        ; ARM 3: mvn{cond}{s} rd, <op2>
        mov     r1, 0
        sub     r1, 1

        mvn     r0, 0
        cmp     r0, r1
        bne     t201f

        sub     r1, 0xFF

        mvn     r0, r1
        cmp     r0, 0xFF
        bne     t201f

        b       t202

t201f:
        failed  201

t202:
        ; ARM 3: and{cond}{s} rd, rn, <op2>
        mov     r0, 0xF0
        mov     r1, 0x0F

        and     r0, r0
        cmp     r0, r0
        bne     t202f

        ands    r0, r1
        bne     t202f

        b       t203

t202f:
        failed  202

t203:
        ; ARM 3: eor{cond}{s} rd, rn, <op2>
        mov     r0, 0xF0
        mov     r1, 0x0F

        eor     r2, r0, r1
        cmp     r2, 0xFF
        bne     t203f

        eors    r0, r0
        bne     t203f

        b       t204

t203f:
        failed  203

t204:
        ; ARM 3: orr{cond}{s} rd, rn, <op2>
        mov     r0, 0xF0
        mov     r1, 0x0F

        orr     r2, r0, r1
        cmp     r2, 0xFF
        bne     t204f

        orr     r0, r0
        cmp     r0, 0xF0
        bne     t204f

        b       t205

t204f:
        failed  204

t205:
        ; ARM 3: bic{cond}{s} rd, rn, <op2>
        mov     r0, 0xFF
        mov     r1, 0x0F

        bic     r0, r1
        cmp     r0, 0xF0
        bne     t205f

        bics    r0, r0
        bne     t205f

        b       t206

t205f:
        failed  205

t206:
        ; ARM 3: add{cond}{s} rd, rn, <op2>
        mov     r0, 0
        mov     r1, 8

        add     r0, r1
        cmp     r0, 8
        bne     t206f

        add     r0, r1
        cmp     r0, 16
        bne     t206f

        b       t207

t206f:
        failed  206

t207:
        ; ARM 3: adc{cond}{s} rd, rn, <op2>
        mov     r0, 0

        msr     CPSR_flg, 0
        adc     r0, 8
        cmp     r0, 8
        bne     t207f

        msr     CPSR_flg, C
        adc     r0, 8
        cmp     r0, 17
        bne     t207f

        b       t208

t207f:
        failed  207

t208:
        ; ARM 3: sub{cond}{s} rd, rn, <op2>
        mov     r0, 16

        sub     r0, r0, 8
        cmp     r0, 8
        bne     t208f

        sub     r0, r0, 8
        cmp     r0, 0
        bne     t208f

        b       t209

t208f:
        failed  208

t209:
        ; ARM 3: rsb{cond}{s} rd, rn, <op2>
        mov     r0, 0
        mov     r1, 8

        rsb     r0, r1, 16
        cmp     r0, 8
        bne     t209f

        rsb     r0, r1, r0
        cmp     r0, 0
        bne     t209f

        b       t210

t209f:
        failed  209

t210:
        ; ARM 3: sbc{cond}{s} rd, rn, <op2>
        mov     r0, 17
        mov     r1, 8

        msr     CPSR_flg, 0
        sbc     r0, r0, 8
        cmp     r0, 8
        bne     t210f

        msr     CPSR_flg, C
        sbc     r0, r0, r1
        cmp     r0, 0
        bne     t210f

        b       t211

t210f:
        failed  210

t211:
        ; ARM 3: rsc{cond}{s} rd, rn, <op2>
        mov     r1, 8

        msr     CPSR_flg, 0
        rsc     r0, r1, 17
        cmp     r0, 8
        bne     t211f

        msr     CPSR_flg, C
        rsc     r0, r1, r0
        cmp     r0, 0
        bne     t211f

        b       t212

t211f:
        failed  211

t212:
        ; ARM 3: cmp{cond} rn, <op2>
        mov     r0, 0

        cmp     r0, r0
        bne     t212f
        bmi     t212f
        bcc     t212f
        bvs     t212f

        mov     r1, 1

        cmp     r0, r1
        beq     t212f
        bpl     t212f
        bcs     t212f

        mov     r0, 1 shl 31

        cmp     r0, r1
        bvc     t212f

        b       t213

t212f:
        failed  212

t213:
        ; ARM 3: cmn{cond} rn, <op2>
        mov     r0, 0

        cmn     r0, r0
        bne     t213f
        bmi     t213f
        bcs     t213f
        bvs     t213f

        mov     r1, 1 shl 31

        cmn     r0, r1
        beq     t213f
        bpl     t213f

        cmn     r1, r1
        bcc     t213f
        bvc     t213f

        b       t214

t213f:
        failed  213

t214:
        ; ARM 3: tst{cond} rn, <op2>
        mov     r0, 0

        tst     r0, r0
        bne     t214f
        bmi     t214f

        mov     r0, 1 shl 31

        tst     r0, r0
        beq     t214f
        bpl     t214f

        b       t215

t214f:
        failed  214

t215:
        ; ARM 3: teq{cond} rd, <op2>
        mov     r0, 0

        teq     r0, r0
        bne     t215f
        bmi     t215f

        mov     r1, 1 shl 31

        teq     r0, r1
        beq     t215f
        bpl     t215f

        b       t216

t215f:
        failed  215

t216:
        ; PC as operand
        mov     r0, pc
        mov     r1, pc

        sub     r1, r0
        cmp     r1, 4
        bne     t216f

        b       t217

t216f:
        failed  216

t217:
        ; Writing to PC
        adr     r0, data_processing_passed
        mov     pc, r0

t217f:
        failed  217

data_processing_passed:
