test_branches:
        ; Tests for branches

test_150:
        ; Thumb 18: b label
        mov     r7, 150
        b       test_150a

test_150b:
        mov     r7, 0
        b       test_151

test_150a:
        b       test_150b

test_151:
        ; Thumb 19: bl label
        mov     r7, 151
        bl      test_151a

test_151b:
        mov     r7, 0
        b       test_152

test_151a:
        bl      test_151b

test_152:
        ; Thumb 16: b<cond> label
        mov     r7, 152
        bne     test_152a

test_152b:
        mov     r7, 0
        b       test_152eq

test_152a:
        bne     test_152b

test_152eq:
        mov     r0, 0
        beq     test_152ne
        b       test_152f

test_152ne:
        mov     r0, 1
        bne     test_152cs
        b       test_152f

test_152cs:
        cmp     r0, r0
        bcs     test_152cc
        b       test_152f

test_152cc:
        cmn     r0, r0
        bcc     test_152mi
        b       test_152f

test_152mi:
        mvn     r0, r0
        bmi     test_152pl
        b       test_152f

test_152pl:
        mov     r0, 0
        bpl     test_152vs
        b       test_152f

test_152vs:
        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        bvs     test_152vc
        b       test_152f

test_152vc:
        cmp     r0, r0
        bvc     test_153
        b       test_152f

test_152f:
        TestFailed 152

test_153:
        ; Thumb 5: bx label
        mov     r7, 153
        adr     r0, test_153a
        bx      r0

code32
align 4
test_153a:
        adr     r0, test_153b + 1
        bx      r0

code16
align 2
test_153b:
        adr     r0, test_153c
        mov     r0, r0
        add     r0, 1
        bx      r0

test_153c:
        mov     r7, 0
        ; Branch to memory.asm
        b       test_memory
