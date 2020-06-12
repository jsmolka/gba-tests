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

        mov     r11, MEM_SRAM
        b       t001

flash:
        ; Fake flash save type
        dw      'FLAS'
        dw      'H1M_'
        dw      'V   '

t001:
        ; Uninitialized flash
        ldrb    r0, [r11]
        cmp     r0, 0xFF
        bne     f001

        b       eval

f001:
        m_exit  1

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
