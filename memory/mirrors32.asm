mirrors32:
        ; Tests for 32k memory mirrors

t150:
        ; VRAM 32k mirror
        mov     r0, 2
        mov     r1, MEM_VRAM
        add     r1, 0x10000
        str     r0, [r1]
        add     r1, 0x8000
        ldr     r0, [r1]
        cmp     r0, 2
        bne     f150

        b       t151

f150:
        m_exit  150

t151:
        ; SRAM 32k mirror
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        add     r1, 0x8000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f151

        b       mirrors32_passed

f151:
        m_exit  151

mirrors32_passed:
