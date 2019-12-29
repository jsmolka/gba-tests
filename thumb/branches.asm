branches:
        ; Tests for branches

t150:
        ; THUMB 18: b label
        mov     r7, 150
        b       t151

t152:
        mov     r7, 152
        b       t153

t151:
        mov     r7, 151
        b       t152

t153:
        ; THUMB 19: bl label
        mov     r7, 153
        bl      t154

t155:
        mov     r7, 155
        mov     pc, lr

t154:
        mov     r7, 154
        bl      t155

t156:
        ; THUMB 16: b<cond> label
        mov     r7, 156
        bne     t157

t158:
        mov     r7, 158
        b       t159

t157:
        mov     r7, 157
        bne     t158

t159:
        mov     r0, 0
        beq     t160

f159:
        failed  159

t160:
        mov     r0, 1
        bne     t161

f160:
        failed  160

t161:
        mov     r0, 0
        cmp     r0, r0
        bcs     t162

f161:
        failed  161

t162:
        mov     r0, 0
        cmn     r0, r0
        bcc     t163

f162:
        failed  162

t163:
        mov     r0, 0
        mvn     r0, r0
        bmi     t164

f163:
        failed  163

t164:
        mov     r0, 0
        bpl     t165

f164:
        failed  164

t165:
        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        bvs     t166

f165:
        failed  165

t166:
        mov     r0, 1
        lsl     r0, 31
        sub     r0, 1
        cmp     r0, r0
        bvc     t167

f166:
        failed  166

t167:
        ; THUMB 5: bx label
        mov     r7, 167
        adr     r0, t168
        bx      r0

code32
align 4
t168:
        mov     r7, 168
        adr     r0, t169 + 1
        bx      r0

code16
align 2
t169:
        mov     r7, 169
        adr     r0, t170
        add     r0, 1
        bx      r0

t170:
        ; THUMB 5: Branch exchange alignment
        mov     r7, 170
        adr     r0, t171
        add     r0, 2
        bx      r0

code32
align 4
t171:
        mov     r7, 171
        adr     r0, branches_passed + 1
        bx      r0

code16
align 2
branches_passed:
        mov     r7, 0
