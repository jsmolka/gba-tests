shifts:
        ; Tests for shift operations

t150:
        ; Logical shift left
        mov     r0, 1
        lsl     r0, 6
        cmp     r0, 64
        bne     f150

        b       t151

f150:
        failed  150

t151:
        ; Logical shift left carry
        mov     r0, 1
        lsls    r0, 31
        bcs     f151

        mov     r0, 2
        lsls    r0, 31
        bcc     f151

        b       t152

f151:
        failed  151

t152:
        ; Logical shift left by 32
        mov     r0, 1
        mov     r1, 32
        lsls    r0, r1
        bne     f152
        bcc     f152

        b       t153

f152:
        failed  152

t153:
        ; Logical shift left by greater 32
        mov     r0, 1
        mov     r1, 33
        lsls    r0, r1
        bne     f153
        bcs     f153

        b       t154

f153:
        failed  153

t154:
        ; Logical shift right
        mov     r0, 64
        lsr     r0, 6
        cmp     r0, 1
        bne     f154

        b       t155

f154:
        failed  154

t155:
        ; Logical shift right carry
        mov     r0, 2
        lsrs    r0, 1
        bcs     f155

        mov     r0, 1
        lsrs    r0, 1
        bcc     f155

        b       t156

f155:
        failed  155

t156:
        ; Logical shift right special
        mov     r0, 1
        lsrs    r0, 32
        bne     f156
        bcs     f156

        mov     r0, 1 shl 31
        lsrs    r0, 32
        bne     f156
        bcc     f156

        b       t157

f156:
        failed  156

t157:
        ; Logical shift right by greater 32
        mov     r0, 1 shl 31
        mov     r1, 33
        lsrs    r0, r1
        bne     f157
        bcs     f157

        b       t158

f157:
        failed  157

t158:
        ; Arithmetic shift right
        mov     r0, 64
        asr     r0, 6
        cmp     r0, 1
        bne     f158

        mov     r0, 1 shl 31
        asr     r0, 31
        mvn     r1, 0
        cmp     r1, r0
        bne     f158

        b       t159

f158:
        failed  158

t159:
        ; Arithmetic shift right carry
        mov     r0, 2
        asrs    r0, 1
        bcs     f159

        mov     r0, 1
        asrs    r0, 1
        bcc     f159

        b       t160

f159:
        failed  159

t160:
        ; Arithmetic shift right special
        mov     r0, 1
        asrs    r0, 32
        bne     f160
        bcs     f160

        mov     r0, 1 shl 31
        asrs    r0, 32
        bcc     f160
        mvn     r1, 0
        cmp     r1, r0
        bne     f160

        b       t161

f160:
        failed  160

t161:
        ; Rotate right
        mov     r0, 1
        ror     r0, 1
        cmp     r0, 1 shl 31
        bne     f161

        b       t162

f161:
        failed  161

t162:
        ; Rotate right carry
        mov     r0, 2
        rors    r0, 1
        bcs     f162

        mov     r0, 1
        rors    r0, 1
        bcc     f162

        b       t163

f162:
        failed  162

t163:
        ; Rotate right special
        msr     cpsr_f, FLAG_C
        mov     r0, 1
        rrxs    r0
        bcc     f163
        bpl     f163

        msr     cpsr_f, 0
        mov     r0, 1
        rrxs    r0
        bcc     f163
        bne     f163

        b       t164

f163:
        failed  163

t164:
        ; Rotate right by 32
        mov     r0, 1 shl 31
        mov     r1, 32
        rors    r0, r1
        bcc     f164
        cmp     r0, 1 shl 31
        bne     f164

        b       t165

f164:
        failed  164

t165:
        ; Rotate right by greater 32
        mov     r0, 2
        mov     r1, 33
        ror     r0, r1
        cmp     r0, 1
        bne     f165

        b       t166

f165:
        failed  165

t166:
        ; Shift by 0 register value
        msr     cpsr_f, FLAG_C
        mov     r0, 1
        mov     r1, 0
        lsls    r0, r1
        lsrs    r0, r1
        asrs    r0, r1
        rors    r0, r1
        bcc     f166
        cmp     r0, 1
        bne     f166

        b       t167

f166:
        failed  166

t167:
        ; Shift saved in lowest byte
        mov     r0, 1
        mov     r1, 0xF10
        lsl     r0, r1
        cmp     r0, 1 shl 16
        bne     f167

        b       shifts_passed

f167:
        failed  167

shifts_passed:
