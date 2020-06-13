format binary as 'gba'

include '../lib/constants.inc'
include '../lib/macros.inc'

macro m_exit test {
        mov     r12, test
        b       eval
}

header:
        include '../lib/header.asm'

main:
        m_test_init

        ; Reset test register
        mov     r12, 0

t001:
        ; No save type returns 0xFF
        mov     r0, MEM_SRAM
        ldrb    r1, [r0]
        cmp     r1, 0xFF
        bne     f001

        b       t002

f001:
        m_exit  1

t002:
        add     r0, 0x01000000
        ldrb    r1, [r0]
        cmp     r1, 0xFF
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
