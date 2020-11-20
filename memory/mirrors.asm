mirrors:
        ; Tests for memory mirrors

t001:
        ; EWRAM mirror
        mov     r0, 1
        mov     r1, MEM_EWRAM
        str     r0, [r1]
        add     r1, 0x40000
        ldr     r0, [r1]
        cmp     r0, 1
        bne     f001

        b       t002

f001:
        m_exit  1

t002:
        ; IWRAM mirror
        mov     r0, 1
        mov     r1, MEM_IWRAM
        str     r0, [r1]
        add     r1, 0x8000
        ldr     r0, [r1]
        cmp     r0, 1
        bne     f002

        b       t003

f002:
        m_exit  2

t003:
        ; Palette mirror
        mov     r0, 1
        mov     r1, MEM_PALETTE
        str     r0, [r1, 0x10]
        add     r1, 0x400
        ldr     r0, [r1, 0x10]
        cmp     r0, 1
        bne     f003

        b       t004

f003:
        m_exit  3

t004:
        ; VRAM mirror
        mov     r0, 2
        mov     r1, MEM_VRAM
        str     r0, [r1]
        add     r1, 0x20000
        ldr     r0, [r1]
        cmp     r0, 2
        bne     f004

        b       t005

f004:
        m_exit  4

t005:
        ; OAM mirror
        mov     r0, 1
        mov     r1, MEM_OAM
        str     r0, [r1]
        add     r1, 0x400
        ldr     r0, [r1]
        cmp     r0, 1
        bne     f005

        b       t006

f005:
        m_exit  5

t006:
        ; GamePak mirror 1
        adr     r1, .data
        add     r1, 0x02000000
        ldr     r0, [r1]
        cmp     r0, 1
        bne     f006

        b       t007

.data:
        dw      1

f006:
        m_exit  6

t007:
        ; GamePak mirror 2
        adr     r1, .data
        add     r1, 0x04000000
        ldr     r0, [r1]
        cmp     r0, 1
        bne     f007

        b       mirrors_passed

.data:
        dw      1

f007:
        m_exit  7

mirrors_passed:
