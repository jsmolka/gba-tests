rom_reads:
        ; Tests for bad ROM reads

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

        b       rom_reads_passed

f102:
        m_exit  102

rom_reads_passed:
