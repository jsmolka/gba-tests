vstrb:
        ; Tests for video memory byte stores

t050:
        ; Ignored OAM byte stores
        mov     r0, 1
        mov     r1, MEM_OAM
        strb    r0, [r1, 0x10]
        ldr     r0, [r1, 0x10]
        cmp     r0, 1
        beq     f050

        b       t051

f050:
        m_exit  50

t051:
        ; Ignored VRAM byte stores in bitmap modes
        mov     r0, MEM_IO
        add     r0, REG_DISPCNT
        ldrh    r1, [r0]

        orr     r2, r1, 3
        strh    r2, [r0]
        mov     r3, 2
        mov     r4, MEM_VRAM
        add     r4, 0x14000
        strb    r3, [r4, 0x10]
        ldr     r3, [r4, 0x10]
        cmp     r3, 2
        beq     f051

        strh    r1, [r0]
        b       t052

f051:
        strh    r1, [r0]
        m_exit  51

t052:
        ; Ignored VRAM byte stores in non-bitmap modes
        mov     r0, MEM_IO
        add     r0, REG_DISPCNT
        ldrh    r1, [r0]

        bic     r2, r1, 3
        strh    r2, [r0]
        mov     r3, 2
        mov     r4, MEM_VRAM
        add     r4, 0x10000
        strb    r3, [r4, 0x10]
        ldr     r3, [r4, 0x10]
        cmp     r3, 2
        beq     f052

        strh    r1, [r0]
        b       t053

f052:
        strh    r1, [r0]
        m_exit  52

t053:
        ; VRAM byte store as halfword
        mov     r0, 2
        mov     r1, MEM_VRAM
        strb    r0, [r1, 0x10]
        ldrh    r0, [r1, 0x10]
        m_half  r1, 0x0202
        cmp     r1, r0
        bne     f053

        b       t054

f053:
        m_exit  53

t054:
        ; Palette byte store as halfword
        mov     r0, 1
        mov     r1, MEM_PALETTE
        strb    r0, [r1, 0x20]
        ldrh    r0, [r1, 0x20]
        m_half  r1, 0x0101
        cmp     r1, r0
        bne     f054

        b       vstrb_passed

f054:
        m_exit  54

vstrb_passed:
