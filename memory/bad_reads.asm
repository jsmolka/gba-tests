bad_reads:
        ; Tests for out of bounds rom reads
        ; Calculate virtual ROM size (next power of two)
        rom_size = rom_end + 1
        rom_size = rom_size - 1
        rom_size = rom_size or rom_size shr 1
        rom_size = rom_size or rom_size shr 2
        rom_size = rom_size or rom_size shr 4
        rom_size = rom_size or rom_size shr 8
        rom_size = rom_size or rom_size shr 16
        rom_size = rom_size + 1

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

        b       t153

f152:
        m_exit  152

t153:
        ; Bytes inside virtual rom size are zero
        m_word  r0, (0x8000000 + rom_end + 4)
        m_word  r1, (0x8000000 + rom_size)
.loop:
        ldr     r2, [r0]
        cmp     r2, 0
        bne     f153
        add     r0, 1
        cmp     r0, r1
        bne     .loop

        b       bad_reads_passed

f153:
        m_exit  153

bad_reads_passed:
