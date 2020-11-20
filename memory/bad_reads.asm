bad_reads:
        ; Tests for out of bounds rom reads

t150:
        ; Read ROM end byte
        m_word  r0, (0x8000000 + rom_end)
        ldrb    r1, [r0]
        cmp     r1, 0xFF
        bne     f150

        b       t151

f150:
        m_exit  150

t151:
        ; Read ROM end byte as half
        m_word  r0, (0x8000000 + rom_end)
        ldrh    r1, [r0]
        cmp     r1, 0xFF
        bne     f151

        b       t152

f151:
        m_exit  151

t152:
        ; Read ROM end byte as word
        m_word  r0, (0x8000000 + rom_end)
        ldr     r1, [r0]
        cmp     r1, 0xFF
        bne     f152

        b       bad_reads_passed

f152:
        m_exit  152

bad_reads_passed:
