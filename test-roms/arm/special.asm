special:
        ; Tests for special cases FASMARM cannot compile

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
