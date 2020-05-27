sram:
        ; Tests for SRAM
        b       t100

.fake:
        ; Fake SRAM save type
        ; Should work on most emulators
        dw      'SRAM'

t100:
        ; SRAM mirror 1
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1, 0x10]
        add     r1, 0x8000
        ldrb    r0, [r1, 0x10]
        bne     f100

        b       t101

f100:
        m_exit  100

t101:
        ; SRAM mirror 2
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1, 0x20]
        add     r1, 0x01000000
        ldrb    r0, [r1, 0x20]
        bne     f101

        b       t102

f101:
        m_exit  101

t102:
        ; SRAM store half
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1, 0x30]
        ldrh    r0, [r1, 0x30]
        m_half  r1, 0x0101
        cmp     r1, r0
        bne     f102

        b       t103

f102:
        m_exit  102

t103:
        ; SRAM store word
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1, 0x40]
        ldr     r0, [r1, 0x40]
        m_word  r1, 0x01010101
        cmp     r1, r0
        bne     f103

        b       t104

f103:
        m_exit  103

t104:
        ; SRAM load half
        m_half  r0, 0xAABB
        mov     r1, MEM_SRAM
        str     r0, [r1, 0x50]
        ldrb    r2, [r1, 0x50]
        cmp     r2, 0xBB
        bne     f104

        str     r0, [r1, 0x51]
        ldrb    r2, [r1, 0x51]
        cmp     r2, 0xAA
        bne     f104

        b       t105

f104:
        m_exit  104

t105:
        ; SRAM load word
        m_word  r0, 0xAABBCCDD
        mov     r1, MEM_SRAM
        str     r0, [r1, 0x60]
        ldrb    r2, [r1, 0x60]
        cmp     r2, 0xDD
        bne     f105

        str     r0, [r1, 0x61]
        ldrb    r2, [r1, 0x61]
        cmp     r2, 0xCC
        bne     f105

        str     r0, [r1, 0x62]
        ldrb    r2, [r1, 0x62]
        cmp     r2, 0xBB
        bne     f105

        str     r0, [r1, 0x63]
        ldrb    r2, [r1, 0x63]
        cmp     r2, 0xAA
        bne     f105

        b       sram_passed

f105:
        m_exit  105

sram_passed:
