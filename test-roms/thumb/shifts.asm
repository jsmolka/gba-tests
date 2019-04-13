shifts:
        ; Tests for shift operations

t050:
        ; THUMB 1: lsl rd, rs, imm5
        mov     r0, 1
        lsl     r0, 6
        cmp     r0, 64
        bne     f050

        b       t051

f050:
        failed  50

t051:
        ; THUMB 4: lsl rd, rs
        mov     r0, 1
        mov     r1, 6
        lsl     r0, r1
        cmp     r0, 64
        bne     f051

        b       t052

f051:
        failed  51

t052:
        ; Logical shift left carry
        mov     r0, 1
        lsl     r0, 31
        bcs     f052

        mov     r0, 2
        lsl     r0, 31
        bcc     f052

        b       t053

f052:
        failed  52

t053:
        ; THUMB 4: Logical shift left by 32
        mov     r0, 1
        mov     r1, 32
        lsl     r0, r1
        bcc     f053
        bne     f053

        b       t054

f053:
        failed  53

t054:
        ; THUMB 4: Logical shift left by greater 32
        mov     r0, 1
        mov     r1, 33
        lsl     r0, r1
        bne     f054
        bcs     f054

        b       t055

f054:
        failed  54

t055:
        ; THUMB 1: lsr rd, rs, imm5
        mov     r0, 64
        lsr     r0, 6
        cmp     r0, 1
        bne     f055

        b       t056

f055:
        failed  55

t056:
        ; THUMB 4: lsr rd, rs
        mov     r0, 64
        mov     r1, 6
        lsr     r0, r1
        cmp     r0, 1
        bne     f056

        b       t057

f056:
        failed  56

t057:
        ; Logical shift right carry
        mov     r0, 2
        lsr     r0, 1
        bcs     f057

        mov     r0, 1
        lsr     r0, 1
        bcc     f057

        b       t058

f057:
        failed  57

t058:
        ; THUMB 1: Logical shift right special
        mov     r0, 1
        lsr     r0, 32
        bne     f058
        bcs     f058

        mov     r0, 1
        lsl     r0, 31
        lsr     r0, 32
        bne     f058
        bcc     f058

        b       t059

f058:
        failed  58

t059:
        ; THUMB 4: Logical shift right by greater 32
        mov     r0, 1
        lsl     r0, 31
        mov     r1, 33
        lsr     r0, r1
        bne     f059
        bcs     f059

        b       t060

f059:
        failed  59

t060:
        ; THUMB 1: asr rd, rs, imm5
        mov     r0, 64
        asr     r0, 6
        cmp     r0, 1
        bne     f060

        mov     r0, 1
        lsl     r0, 31
        asr     r0, 31
        mov     r1, 0
        mvn     r1, r1
        cmp     r1, r0
        bne     f060

        b       t061

f060:
        failed  60

t061:
        ; THUMB 4: asr rd, rs
        mov     r0, 64
        mov     r1, 6
        asr     r0, r1
        cmp     r0, 1
        bne     f061

        mov     r0, 1
        lsl     r0, 31
        mov     r1, 31
        asr     r0, r1
        mov     r1, 0
        mvn     r1, r1
        cmp     r1, r0
        bne     f061

        b       t062

f061:
        failed  61

t062:
        ; Arithmetic shift right carry
        mov     r0, 2
        asr     r0, 1
        bcs     f062

        mov     r0, 1
        asr     r0, 1
        bcc     f062

        b       t063

f062:
        failed  62

t063:
        ; THUMB 1: Arithmetic shift right special
        mov     r0, 1
        asr     r0, 32
        bne     f063
        bcs     f063

        mov     r0, 1
        lsl     r0, 31
        asr     r0, 32
        bcc     f063
        mov     r1, 0
        mvn     r1, r1
        cmp     r1, r0
        bne     f063

        b       t064

f063:
        failed  63

t064:
        ; THUMB 4: ror rd, rs
        mov     r0, 1
        mov     r1, 1
        ror     r0, r1
        lsl     r1, 31
        cmp     r1, r0
        bne     f064

        b       t065

f064:
        failed  64

t065:
        ; Rotate right carry
        mov     r0, 2
        mov     r1, 1
        ror     r0, r1
        bcs     f065

        mov     r0, 1
        mov     r1, 1
        ror     r0, r1
        bcc     f065

        b       t066

f065:
        failed  65

t066:
        ; THUMB 4: Rotate right by 32
        mov     r0, 1
        lsl     r0, 31
        mov     r1, r0
        mov     r2, 32
        ror     r0, r2
        bcc     f066
        cmp     r0, r1
        bne     f066

        b       t067

f066:
        failed  66

t067:
        ; THUMB 4: Rotate right by greater 32
        mov     r0, 2
        mov     r1, 33
        ror     r0, r1
        cmp     r0, 1
        bne     f067

        b       t068

f067:
        failed  67

t068:
        ; THUMB 4: Shifts by 0
        mov     r0, 1
        mov     r1, 0
        cmp     r0, r0
        lsl     r0, r1
        lsr     r0, r1
        asr     r0, r1
        ror     r0, r1
        bcc     f068
        cmp     r0, 1
        bne     f068

        b       shifts_passed

f068:
        failed  68

shifts_passed:
