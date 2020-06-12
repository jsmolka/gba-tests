mirrors32:
        ; Tests for 32k memory mirrors

t100:
        ; VRAM 32k mirror
        mov     r0, 2
        mov     r1, MEM_VRAM
        add     r1, 0x10000
        str     r0, [r1]
        add     r1, 0x8000
        ldr     r0, [r1]
        cmp     r0, 2
        bne     f100

        b       t101

f100:
        m_exit  100

sram:
        ; Fake SRAM save type
        dw      'SRAM'
        dw      '_V  '

t101:
        ; SRAM 32k mirror
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        add     r1, 0x8000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f101

        b       mirrors32_passed

f101:
        m_exit  101

mirrors32_passed:
