sram:
        ; Tests for SRAM
        mem     equ r11
        mov     mem, MEM_SRAM
        b       t100

.fake:
        ; Fake SRAM save type
        ; Should work on most emulators
        dw      'SRAM'
        dw      '_V  '

t100:
        ; SRAM mirror 1
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        add     r1, 0x10000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f100

        add     mem, 32
        b       t101

f100:
        m_exit  100

t101:
        ; SRAM mirror 2
        mov     r0, 1
        mov     r1, mem
        strb    r0, [r1]
        add     r1, 0x01000000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f101

        add     mem, 32
        b       t102

f101:
        m_exit  101

t102:
        ; SRAM load half
        mov     r0, 1
        mov     r1, mem
        strb    r0, [r1]
        ldrh    r0, [r1]
        m_half  r1, 0x0101
        cmp     r1, r0
        bne     f102

        add     mem, 32
        b       t103

f102:
        m_exit  102

t103:
        ; SRAM load word
        mov     r0, 1
        mov     r1, r11
        strb    r0, [r1]
        ldr     r0, [r1]
        m_word  r1, 0x01010101
        cmp     r1, r0
        bne     f103

        add     mem, 32
        b       t104

f103:
        m_exit  103

t104:
        ; SRAM store half position
        m_half  r0, 0xAABB
        mov     r1, mem

        strh    r0, [r1]
        ldrb    r2, [r1]
        cmp     r2, 0xBB
        bne     f104

        strh    r0, [r1, 1]
        ldrb    r2, [r1, 1]
        cmp     r2, 0xAA
        bne     f104

        add     mem, 32
        b       t105

f104:
        m_exit  104

t105:
        ; SRAM store half just byte
        m_half  r0, 0xAABB
        mov     r1, mem
        strh    r0, [r1]

        ldrb    r2, [r1]
        cmp     r2, 0xBB
        bne     f105

        ldrb    r2, [r1, 1]
        cmp     r2, 0xFF
        bne     f105

        add     mem, 32
        b       t106

f105:
        m_exit  105

t106:
        ; SRAM store word position
        m_word  r0, 0xAABBCCDD
        mov     r1, mem

        str     r0, [r1]
        ldrb    r2, [r1]
        cmp     r2, 0xDD
        bne     f106

        str     r0, [r1, 1]
        ldrb    r2, [r1, 1]
        cmp     r2, 0xCC
        bne     f106

        str     r0, [r1, 2]
        ldrb    r2, [r1, 2]
        cmp     r2, 0xBB
        bne     f106

        str     r0, [r1, 3]
        ldrb    r2, [r1, 3]
        cmp     r2, 0xAA
        bne     f106

        add     mem, 32
        b       t107

f106:
        m_exit  106

t107:
        ; SRAM store word just byte
        m_word  r0, 0xAABBCCDD
        mov     r1, mem
        str     r0, [r1]

        ldrb    r2, [r1]
        cmp     r2, 0xDD
        bne     f107

        ldrb    r2, [r1, 1]
        cmp     r2, 0xFF
        bne     f107

        ldrb    r2, [r1, 2]
        cmp     r2, 0xFF
        bne     f107

        ldrb    r2, [r1, 3]
        cmp     r2, 0xFF
        bne     f107

        b       sram_passed

f107:
        m_exit  107

sram_passed:
        restore mem
