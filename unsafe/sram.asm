sram:
        ; Tests for 32k SRAM mirrors
        b       t001

        ; Fake save type
        dw      'SRAM'
        dw      '_V  '

t001:
        ; 32k mirror
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        add     r1, 0x8000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f001

        b       sram_passed

f001:
        m_exit  1

sram_passed:
