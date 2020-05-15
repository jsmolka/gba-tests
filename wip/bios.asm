format binary as 'gba'

include '../lib/constants.inc'
include '../lib/macros.inc'

macro m_exit test {
        m_half  r12, test
        b       eval
}

header:
        include '../lib/header.asm'

main:
        m_test_init

        ; Reset test register
        mov     r12, 0

t001:
        ; BIOS read returns 0x0DC+8 after startup
        mov     r0, 0
        m_word  r1, 0xE129F000
        ldr     r2, [r0]
        cmp     r2, r1
        bne     f001
        b       t002

f001:
        m_exit  1

t002:
        ; BIOS read returns 0x188+8 after swi
        mov     r0, 0
        m_word  r1, 0xE3A02004
        swi     0x80000  ; sqrt(r0)
        ldr     r2, [r0]
        cmp     r2, r1
        bne     f002
        b       eval

f002:
        m_exit  2

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
