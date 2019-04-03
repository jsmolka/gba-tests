multiply:
        ; Tests for the multiply instructions

t300:
        ; ARM 5: mul{cond}{s} rd, rm, rs
        mov     r0, 4
        mov     r1, 8

        mul     r0, r1, r0
        cmp     r0, 32
        bne     t300f

        b       t301

t300f:
        failed  300

t301:
        mov     r0, -4
        mov     r1, -8

        mul     r0, r1, r0
        cmp     r0, 32
        bne     t301f

        b       t302

t301f:
        failed  301

t302:
        mov     r0, 4
        mov     r1, -8

        mul     r0, r1, r0
        cmp     r0, -32
        bne     t302f

        b       t303

t302f:
        failed  302

t303:
        ; ARM 5: mla{cond}{s} rd, rm, rs, rn
        mov     r0, 4
        mov     r1, 8
        mov     r2, 8

        mla     r0, r1, r0, r2
        cmp     r0, 40
        bne     t303f

        b       t304

t303f:
        failed  303

t304:
        mov     r0, 4
        mov     r1, 8
        mov     r2, -8

        mla     r0, r1, r0, r2
        cmp     r0, 24
        bne     t304f

        b       t305

t304f:
        failed  304

t305:
        ; ARM 6: umull{cond}{s} rdlo, rdhi, rm, rs
        mov     r0, 4
        mov     r1, 8

        umull   r2, r3, r0, r1
        cmp     r2, 32
        bne     t305f
        cmp     r3, 0
        bne     t305f

        b       t306

t305f:
        failed  305

t306:
        mov     r0, -1
        mov     r1, -1

        umull   r2, r3, r0, r1
        cmp     r2, 1
        bne     t306f
        cmp     r3, -2
        bne     t306f

        b       t307

t306f:
        failed  306

t307:
        mov     r0, 2
        mov     r1, -1

        umull   r2, r3, r0, r1
        cmp     r2, -2
        bne     t307f
        cmp     r3, 1
        bne     t307f

        b       t308

t307f:
        failed  307

t308:
        ; ARM 6: umlal{cond}{s} rdlo, rdhi, rm, rs
        mov     r0, 4
        mov     r1, 8
        mov     r2, 8
        mov     r3, 4

        umlal   r2, r3, r0, r1
        cmp     r2, 40
        bne     t308f
        cmp     r3, 4
        bne     t308f

        b       t309

t308f:
        failed  308

t309:
        mov     r0, -1
        mov     r1, -1
        mov     r2, -2
        mov     r3, 1

        umlal   r2, r3, r0, r1
        cmp     r2, -1
        bne     t309f
        cmp     r3, -1
        bne     t309f


        b       t310

t309f:
        failed  309

t310:
        ; ARM 6: smull{cond}{s} rdlo, rdhi, rm, rs
        mov     r0, 4
        mov     r1, 8

        smull   r2, r3, r0, r1
        cmp     r2, 32
        bne     t310f
        cmp     r3, 0
        bne     t310f

        b       t311

t310f:
        failed  310

t311:
        mov     r0, -4
        mov     r1, -8

        smull   r2, r3, r0, r1
        cmp     r2, 32
        bne     t311f
        cmp     r3, 0
        bne     t311f

        b       t312

t311f:
        failed  311

t312:
        mov     r0, 4
        mov     r1, -8

        smull   r2, r3, r0, r1
        cmp     r2, -32
        bne     t312f
        cmp     r3, -1
        bne     t312f

        b       t313

t312f:
        failed  312

t313:
        ; ARM 6: smlal{cond}{s} rdlo, rdhi, rm, rs
        mov     r0, 4
        mov     r1, 8
        mov     r2, 8
        mov     r3, 4

        smlal   r2, r3, r0, r1
        cmp     r2, 40
        bne     t313f
        cmp     r3, 4
        bne     t313f

        b       t314

t313f:
        failed  313

t314:
        mov     r0, 4
        mov     r1, -8
        mov     r2, 32
        mov     r3, 0

        smlal   r2, r3, r0, r1
        cmp     r2, 0
        bne     t314f
        cmp     r3, 0
        bne     t314f

        b       t315

t314f:
        failed  314

t315:
        ; Negative flag
        mov     r0, 2
        mov     r1, -1

        umulls  r2, r3, r0, r1
        bmi     t315f

        smulls  r2, r3, r0, r1
        bpl     t315f

        b       multiply_passed

t315f:
        failed  315

multiply_passed:
