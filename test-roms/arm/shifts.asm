shifts:
        ; Tests for shift operations

t150:
        ; Logical shift left
        mov     r0, 1
        lsl     r0, 6
        cmp     r0, 64
        bne     t150f

        b       t151

t150f:
        failed  150

t151:
        ; Logical shift left carry
        mov     r0, 0
        lsls    r0, 1
        bcs     t151f

        mov     r0, 2
        lsls    r0, 31
        bcc     t151f

        b       t152

t151f:
        failed  151

t152:
        ; Logical shift left by 32
        mov     r0, 1
        mov     r1, 32

        lsls    r0, r1
        bcc     t152f
        bne     t152f

        b       t153

t152f:
        failed  152

t153:
        ; Logical shift left by greater 32
        mov     r0, 1
        mov     r1, 33

        lsls    r0, r1
        bne     t153f
        bcs     t153f

        b       t154

t153f:
        failed  153

t154:
        ; Logical shift right
        mov     r0, 64
        lsr     r0, 6
        cmp     r0, 1
        bne     t154f

        b       t155

t154f:
        failed  154

t155:
        ; Logical shift right carry
        mov     r0, 2
        lsrs    r0, 1
        bcs     t155f

        mov     r0, 1
        lsrs    r0, 1
        bcc     t155f

        b       t156

t155f:
        failed  155

t156:
        ; Logical shift right special
        mov     r0, 1
        lsrs    r0, 32
        bne     t156f
        bcs     t156f

        mov     r0, 1 shl 31
        lsrs    r0, 32
        bne     t156f
        bcc     t156f

        b       t157

t156f:
        failed  156

t157:
        ; Logical shift right by greater 32
        mov     r0, 1 shl 31
        mov     r1, 33

        lsrs    r0, r1
        bne     t157f
        bcs     t157f

        b       t158

t157f:
        failed  157

t158:
        ; Arithmetic shift right
        mov     r0, 64
        asr     r0, 6
        cmp     r0, 1
        bne     t158f

        mov     r0, 1 shl 31
        asr     r0, 31
        mvn     r1, 0
        cmp     r1, r0
        bne     t158f

        b       t159

t158f:
        failed  158

t159:
        ; Arithmetic shift right carry
        mov     r0, 2
        asrs    r0, 1
        bcs     t159f

        mov     r0, 1
        asrs    r0, 1
        bcc     t159f

        b       t160

t159f:
        failed  159

t160:
        ; Arithmetic shift right special
        mov     r0, 1
        asrs    r0, 32
        bne     t160f
        bcs     t160f

        mov     r0, 1 shl 31
        asrs    r0, 32
        bcc     t160f

        mvn     r1, 0
        cmp     r1, r0
        bne     t160f

        b       t161

t160f:
        failed  160

t161:
        ; Rotate right
        mov     r0, 2
        mov     r1, 1
        ror     r0, 1
        ror     r0, r1
        cmp     r0, 1 shl 31
        bne     t161f

        b       t162

t161f:
        failed  161

t162:
        ; Rotate right carry
        mov     r0, 2
        rors    r0, 1
        bcs     t162f

        mov     r0, 1
        rors    r0, 1
        bcc     t162f

        b       t163

t162f:
        failed  162

t163:
        ; Rotate right special
        msr     cpsr_f, C
        mov     r0, 1
        rrxs    r0
        bcc     t163f
        bpl     t163f

        msr     cpsr_f, 0
        mov     r0, 1
        rrxs    r0
        bcc     t163f
        bne     t163f

        b       t164

t163f:
        failed  163

t164:
        ; Rotate right by 32
        mov     r0, 1 shl 31
        mov     r1, 32

        rors    r0, r1
        bcc     t164f

        cmp     r0, 1 shl 31
        bne     t164f

        b       t165

t164f:
        failed  164

t165:
        ; Rotate right by greater 32
        mov     r0, 2
        mov     r1, 33

        ror     r0, r1
        cmp     r0, 1
        bne     t165f

        b       t166

t165f:
        failed  165

t166:
        ; Shifts by 0
        msr     cpsr_f, C
        mov     r0, 1
        mov     r1, 0

        lsls    r0, r1
        lsrs    r0, r1
        asrs    r0, r1
        rors    r0, r1
        bcc     t166f

        cmp     r0, 1
        bne     t166f

        b       t167

t166f:
        failed  166

t167:
        ; Shift saved in lowest byte
        mov     r0, 1
        imm16   r1, 0xFF03

        lsl     r0, r1
        cmp     r0, 8
        bne     t167f

        b       t168

t167f:
        failed  167

t168:
        ; Update carry in data processing
        movs    r0, 0xF000000F
        bcc     t168f

        movs    r0, 0x0FF00000
        bcs     t168f

        b       shifts_passed

t168f:
        failed  168

shifts_passed:
