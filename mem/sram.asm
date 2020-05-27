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
        strb    r0, [r1]
        add     r1, 0x8000
        ldrb    r0, [r1]
        bne     f100

        b       t101

f100:
        m_exit  100

t101:
        ; SRAM mirror 2
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        add     r1, 0x01000000
        ldrb    r0, [r1]
        bne     f101

        b       t102

f101:
        m_exit  101

t102:
        ; SRAM load half
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        ldrh    r0, [r1]
        m_half  r1, 0x0101
        cmp     r1, r0
        bne     f102

        b       t103

f102:
        m_exit  102

t103:
        ; SRAM load word
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        ldr     r0, [r1]
        m_word  r1, 0x01010101
        cmp     r1, r0
        bne     f103

        b       t104

f103:
        m_exit  103

t104:
        ; SRAM store half
        m_half  r0, 0xAABB
        mov     r1, MEM_SRAM
        strh    r0, [r1]
        ldrb    r2, [r1]
        cmp     r2, 0xBB
        bne     f104

        strh    r0, [r1, 1]
        ldrb    r2, [r1, 1]
        cmp     r2, 0xAA
        bne     f104

        b       t105

f104:
        m_exit  104

t105:
        ; SRAM store word
        m_word  r0, 0xAABBCCDD
        mov     r1, MEM_SRAM
        str     r0, [r1]
        ldrb    r2, [r1]
        cmp     r2, 0xDD
        bne     f105

        str     r0, [r1, 1]
        ldrb    r2, [r1, 1]
        cmp     r2, 0xCC
        bne     f105

        str     r0, [r1, 2]
        ldrb    r2, [r1, 2]
        cmp     r2, 0xBB
        bne     f105

        str     r0, [r1, 3]
        ldrb    r2, [r1, 3]
        cmp     r2, 0xAA
        bne     f105

        b       sram_passed

f105:
        m_exit  105

sram_passed:
