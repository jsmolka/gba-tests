shifts:
        ; Tests for shift operations

t150:
        ; ARM 3: mov rd, rs, lsl imm5 / rm
        mov     r0, 1
        mov     r1, 3

        mov     r0, r0, lsl 3
        mov     r0, r0, lsl r1
        cmp     r0, 64
        bne     t150f

        b       t151

t150f:
        failed  150

t151:
        ; Carry flag lsl
        mov     r0, 0
        movs    r0, r0, lsl 1
        bcs     t151f

        mvn     r0, 0
        movs    r0, r0, lsl 1
        bcc     t151f

        b       t152

t151f:
        failed  151

t152:
        ; Special case lsl
        mov     r0, 0

        msr     CPSR_flg, 0
        movs    r0, r0, lsl r0
        bcs     t152f

        msr     CPSR_flg, C
        movs    r0, r0, lsl r0
        bcc     t152f

        b       t153

t152f:
        failed  152

t153:
        ; ARM 3: mov rd, rs, lsr imm5 / rm
        mov     r0, 64
        mov     r1, 3

        mov     r0, r0, lsr 3
        mov     r0, r0, lsr r1
        cmp     r0, 1
        bne     t153f

        b       t154

t153f:
        failed  153

t154:
        ; Carry flag lsr
        mov     r0, 0
        movs    r0, r0, lsr 1
        bcs     t154f

        mov     r0, 1
        movs    r0, r0, lsr 1
        bcc     t154f

        b       t155

t154f:
        failed  154

t155:
        ; Special case lsr
        mov     r0, 0
        movs    r0, r0, lsr 32
        bne     t155f
        bcs     t155f

        mov     r0, 0x80000000
        movs    r0, r0, lsr 32
        bne     t155f
        bcc     t155f

        b       t156

t155f:
        failed  155

t156:
        ; ARM 3: mov rd, rs, asr imm5 / rm
        mov     r0, 64
        mov     r1, 3

        mov     r0, r0, asr 3
        mov     r0, r0, asr r1
        cmp     r0, 1
        bne     t156f

        mov     r0, 0x80000000
        mvn     r1, 0

        mov     r0, r0, asr 31
        cmp     r0, r1
        bne     t156f

        b       t157

t156f:
        failed  156

t157:
        ; Carry flag asr
        mov     r0, 0
        movs    r0, r0, asr 1
        bcs     t157f

        mov     r0, 1
        movs    r0, r0, asr 1
        bcc     t157f

        b       t158

t157f:
        failed  157

t158:
        ; Special case asr
        mov     r0, 0
        movs    r0, r0, asr 32
        bne     t158f
        bcs     t158f

        mov     r0, 0x80000000
        mvn     r1, 0
        movs    r0, r0, asr 32
        bcc     t158f
        cmp     r0, r1
        bne     t158f

        b       t159

t158f:
        failed  158

t159:
        ; ARM 3: mov rd, rs, ror imm5 / rm
        mov     r0, 2
        mov     r1, 1
        mov     r2, 0x80000000

        mov     r0, r0, ror 1
        mov     r0, r0, ror r1
        cmp     r0, r2
        bne     t159f

        b       t160

t159f:
        failed  159

t160:
        ; ARM 3: mov rd, imm8, ror imm4 << 1
        mov     r0, 1
        mov     r0, r0, lsl 31
        cmp     r0, 0x80000000
        bne     t160f

        mov     r0, r0, lsr 1
        cmp     r0, 0x40000000
        bne     t160f

        b       t161

t160f:
        failed  160

t161:
        ; Carry flag ror
        mov     r0, 0
        movs    r0, r0, ror 1
        bcs     t161f

        mov     r0, 1
        movs    r0, r0, ror 1
        bcc     t161f

        b       t162

t161f:
        failed  161

t162:
        ; Special case ror

        ; Todo: which mnemonic should be used?
        b       shifts_end

t162f:
        failed  162


shifts_end: