rom_reads:
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

t100:
        ; Read ROM end byte
        m_word  r0, (0x8000000 + rom_end)
        ldrb    r1, [r0]
        cmp     r1, 0xFF
        bne     f100

        b       t101

f100:
        m_exit  100

t101:
        ; Read ROM end byte as half
        m_word  r0, (0x8000000 + rom_end)
        ldrh    r1, [r0]
        cmp     r1, 0xFF
        bne     f101

        b       t102

f101:
        m_exit  101

t102:
        ; Read ROM end byte as word
        m_word  r0, (0x8000000 + rom_end)
        ldr     r1, [r0]
        cmp     r1, 0xFF
        bne     f102

        b       t103

f102:
        m_exit  102

t103:
        ; Bytes inside virtual rom size are zero
        m_word  r0, (0x8000000 + rom_end + 4)
        m_word  r1, (0x8000000 + rom_size)
.loop:
        ldr     r2, [r0]
        cmp     r2, 0
        bne     f103
        add     r0, 1
        cmp     r0, r1
        bne     .loop

        b       rom_reads_passed

f103:
        m_exit  103

rom_reads_passed:
