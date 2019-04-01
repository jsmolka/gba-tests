shifts:
        ; Tests for shift operations

t150:
        ; Logical shift left
        mov     r0, 1
        mov     r1, 3

        lsl     r0, 3
        lsl     r0, r1
        cmp     r0, 64
        bne     t150f

        b       t151

t150f:
        failed  150

t151:
        ; Logical shift left carry
        mov     r0, 1 shl 30

        lsls    r0, 1
        bcs     t151f

        lsls    r0, 1
        bcc     t151f

        b       t152

t151f:
        failed  151

t152:
        ; Logical shift left special
        mov     r0, 0

        msr     CPSR_flg, 0
        lsls    r0, r0
        bcs     t152f

        msr     CPSR_flg, C
        lsls    r0, r0
        bcc     t152f

        b       t153

t152f:
        failed  152

t153:
        ; Logical shift right
        mov     r0, 64
        mov     r1, 3

        lsr     r0, 3
        lsr     r0, r1
        cmp     r0, 1
        bne     t153f

        b       t154

t153f:
        failed  153

t154:
        ; Logical shift right carry
        mov     r0, 2

        lsrs    r0, 1
        bcs     t154f

        lsrs    r0, 1
        bcc     t154f

        b       t155

t154f:
        failed  154

t155:
        ; Logical shift right special
        mov     r0, 1
        lsrs    r0, 32
        bne     t155f
        bcs     t155f

        mov     r0, 1 shl 31
        lsrs    r0, 32
        bne     t155f
        bcc     t155f

        b       t156

t155f:
        failed  155

t156:
        ; Arithmetic shift right
        mov     r0, 64
        mov     r1, 3

        asr     r0, 3
        asr     r0, r1
        cmp     r0, 1
        bne     t156f

        mov     r0, 1 shl 31
        mvn     r1, 0

        asr     r0, 31
        cmp     r0, r1
        bne     t156f

        b       t157

t156f:
        failed  156

t157:
        ; Arithmetic shift right carry
        mov     r0, 2

        asrs    r0, 1
        bcs     t157f

        asrs    r0, 1
        bcc     t157f

        b       t158

t157f:
        failed  157

t158:
        ; Arithmetic shift right special
        mov     r0, 1
        asrs    r0, 32
        bne     t158f
        bcs     t158f

        mov     r0, 1 shl 31
        asrs    r0, 32
        bcc     t158f

        mvn     r1, 0
        cmp     r0, r1
        bne     t158f

        b       t159

t158f:
        failed  158

t159:
        ; Rotate right (shifted register)
        mov     r0, 2
        mov     r1, 1

        ror     r0, 1
        ror     r0, r1
        cmp     r0, 1 shl 31
        bne     t159f

        b       t160

t159f:
        failed  159

t160:
        ; Rotate right (rotated immediate)
        mov     r0, 1

        lsl     r0, 31
        cmp     r0, 1 shl 31
        bne     t160f

        lsr     r0, 1
        cmp     r0, 1 shl 30
        bne     t160f

        b       t161

t160f:
        failed  160

t161:
        ; Rotate right carry
        mov     r0, 2

        rors    r0, 1
        bcs     t161f

        rors    r0, 1
        bcc     t161f

        b       t162

t161f:
        failed  161

t162:
        ; Rotate right special
        msr     CPSR_flg, C
        mov     r0, 0
        rrxs    r0
        bcs     t162f
        bpl     t162f

        msr     CPSR_flg, 0
        mov     r0, 1
        rrxs    r0
        bcc     t162f
        bne     t162f

        b       t163

t162f:
        failed  162

t163:
        ; Shifts by zero (carry clear)
        mov     r0, 1 shl 31
        mov     r1, 0
        msr     CPSR_flg, 0

        lsls    r0, r1
        bpl     t163f
        bcs     t163f

        lsrs    r0, r1
        bpl     t163f
        bcs     t163f

        asrs    r0, r1
        bpl     t163f
        bcs     t163f

        rors    r0, r1
        bpl     t163f
        bcs     t163f

        movs    r0, 1
        bcs     t163f

        b       shifts_passed

t163f:
        failed  163

t164:
        ; Shifts by zero (carry set)
        mov     r0, 1 shl 31
        mov     r1, 0
        msr     CPSR_flg, C

        lsls    r0, r1
        bpl     t164f
        bcc     t164f

        lsrs    r0, r1
        bpl     t164f
        bcc     t164f

        asrs    r0, r1
        bpl     t164f
        bcc     t164f

        rors    r0, r1
        bpl     t164f
        bcc     t164f

        movs    r0, 1
        bcc     t164f

        b       shifts_passed

t164f:
        failed  164

shifts_passed:
