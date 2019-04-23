special:
        ; Tests for special cases FASMARM cannot compile

t450:
        ; PC as shifted register
        mov     r0, 0
        dw      0xE1A0001F  ; mov r0, pc, lsl r0
        cmp     r0, pc
        bne     f450

        b       t451

f450:
        failed  450

t451:
        ; PC as operand 1 with shifted register
        mov     r0, 0
        dw      0xE08F0010  ; add r0, pc, r0, lsl r0
        cmp     r0, pc
        bne     f451

        b       t452

f451:
        failed  451

t452:
        ; STRB PC + 4
        dw      0xE54BF000  ; strb pc, [r11]
        mov     r0, pc
        and     r0, 0xFF
        ldrb    r1, [r11]
        cmp     r1, r0
        bne     f452

        b       special_passed

f452:
        failed  452

special_passed:
