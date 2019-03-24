branches:
        ; Tests for branches

t150:
        ; Thumb 18: b label
        mov     r7, 150
        b       t150a

t150b:
        mov     r7, 0
        b       t151

t150a:
        b       t150b

t151:
        ; Thumb 19: bl label
        mov     r7, 151
        bl      t151a

t151b:
        mov     r7, 0
        b       t152

t151a:
        bl      t151b

t152:
        ; Thumb 16: b<cond> label
        mov     r7, 152
        bne     t152a

t152b:
        mov     r7, 0
        b       t152eq

t152a:
        bne     t152b

t152eq:
        mov     r0, 0
        beq     t152ne
        b       t152f

t152ne:
        mov     r0, 1
        bne     t152cs
        b       t152f

t152cs:
        cmp     r0, r0
        bcs     t152cc
        b       t152f

t152cc:
        cmn     r0, r0
        bcc     t152mi
        b       t152f

t152mi:
        mvn     r0, r0
        bmi     t152pl
        b       t152f

t152pl:
        mov     r0, 0
        bpl     t152vs
        b       t152f

t152vs:
        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        bvs     t152vc
        b       t152f

t152vc:
        cmp     r0, r0
        bvc     t153
        b       t152f

t152f:
        Failed 152

t153:
        ; Thumb 5: bx label
        mov     r7, 153
        adr     r0, t153a
        bx      r0

code32
align 4
t153a:
        adr     r0, t153b + 1
        bx      r0

code16
align 2
t153b:
        adr     r0, t153c
        mov     r0, r0
        add     r0, 1
        bx      r0

t153c:
        mov     r7, 0
        ; Branch to memory.asm
        b       memory
