multiply:
        ; Tests for multiply operations

t300:
        ; ARM 5: Multiply
        mov     r0, 4
        mov     r1, 8
        mul     r0, r1, r0
        cmp     r0, 32
        bne     f300

        b       t301

f300:
        m_exit  300

t301:
        mov     r0, -4
        mov     r1, -8
        mul     r0, r1, r0
        cmp     r0, 32
        bne     f301

        b       t302

f301:
        m_exit  301

t302:
        mov     r0, 4
        mov     r1, -8
        mul     r0, r1, r0
        cmp     r0, -32
        bne     f302

        b       t303

f302:
        m_exit  302

t303:
        ; ARM 5: Multiply accumulate
        mov     r0, 4
        mov     r1, 8
        mov     r2, 8
        mla     r0, r1, r0, r2
        cmp     r0, 40
        bne     t303f

        b       t304

t303f:
        m_exit  303

t304:
        mov     r0, 4
        mov     r1, 8
        mov     r2, -8
        mla     r0, r1, r0, r2
        cmp     r0, 24
        bne     f304

        b       t305

f304:
        m_exit  304

t305:
        ; ARM 6: Unsigned multiply long
        mov     r0, 4
        mov     r1, 8
        umull   r2, r3, r0, r1
        cmp     r2, 32
        bne     f305
        cmp     r3, 0
        bne     f305

        b       t306

f305:
        m_exit  305

t306:
        mov     r0, -1
        mov     r1, -1
        umull   r2, r3, r0, r1
        cmp     r2, 1
        bne     f306
        cmp     r3, -2
        bne     f306

        b       t307

f306:
        m_exit  306

t307:
        mov     r0, 2
        mov     r1, -1
        umull   r2, r3, r0, r1
        cmp     r2, -2
        bne     f307
        cmp     r3, 1
        bne     f307

        b       t308

f307:
        m_exit  307

t308:
        ; ARM 6: Unsigned multiply long accumulate
        mov     r0, 4
        mov     r1, 8
        mov     r2, 8
        mov     r3, 4
        umlal   r2, r3, r0, r1
        cmp     r2, 40
        bne     f308
        cmp     r3, 4
        bne     f308

        b       t309

f308:
        m_exit  308

t309:
        mov     r0, -1
        mov     r1, -1
        mov     r2, -2
        mov     r3, 1
        umlal   r2, r3, r0, r1
        cmp     r2, -1
        bne     f309
        cmp     r3, -1
        bne     f309


        b       t310

f309:
        m_exit  309

t310:
        ; ARM 6: Signed multiply long
        mov     r0, 4
        mov     r1, 8
        smull   r2, r3, r0, r1
        cmp     r2, 32
        bne     f310
        cmp     r3, 0
        bne     f310

        b       t311

f310:
        m_exit  310

t311:
        mov     r0, -4
        mov     r1, -8
        smull   r2, r3, r0, r1
        cmp     r2, 32
        bne     f311
        cmp     r3, 0
        bne     f311

        b       t312

f311:
        m_exit  311

t312:
        mov     r0, 4
        mov     r1, -8
        smull   r2, r3, r0, r1
        cmp     r2, -32
        bne     f312
        cmp     r3, -1
        bne     f312

        b       t313

f312:
        m_exit  312

t313:
        ; ARM 6: Signed multiply long accumulate
        mov     r0, 4
        mov     r1, 8
        mov     r2, 8
        mov     r3, 4
        smlal   r2, r3, r0, r1
        cmp     r2, 40
        bne     f313
        cmp     r3, 4
        bne     f313

        b       t314

f313:
        m_exit  313

t314:
        mov     r0, 4
        mov     r1, -8
        mov     r2, 32
        mov     r3, 0
        smlal   r2, r3, r0, r1
        cmp     r2, 0
        bne     f314
        cmp     r3, 0
        bne     f314

        b       t315

f314:
        m_exit  314

t315:
        ; ARM 6: Negative flag
        mov     r0, 2
        mov     r1, 1
        umulls  r2, r3, r0, r1
        bmi     f315

        mov     r0, 2
        mov     r1, -1
        smulls  r2, r3, r0, r1
        bpl     f315

        b       t316

f315:
        m_exit  315

t316:
        ; ARM 5: Not affecting carry and overflow
        msr     cpsr_f, 0
        mov     r0, 1
        mov     r1, 1
        mul     r0, r1, r0
        bcs     f316
        bvs     f316

        b       t317

f316:
        m_exit  316

t317:
        msr     cpsr_f, FLAG_C or FLAG_V
        mov     r0, 1
        mov     r1, 1
        mul     r0, r1, r0
        bcc     f317
        bvc     f317

        b       t318

f317:
        m_exit  317

t318:
        ; ARM 6: Not affecting carry and overflow
        msr     cpsr_f, 0
        mov     r0, 1
        mov     r1, 1
        umull   r2, r3, r0, r1
        bcs     f318
        bvs     f318

        b       t319

f318:
        m_exit  318

t319:
        msr     cpsr_f, FLAG_C or FLAG_V
        mov     r0, 1
        mov     r1, 1
        umull   r2, r3, r0, r1
        bcc     f319
        bvc     f319

        b       multiply_passed

f319:
        m_exit  319

multiply_passed:
