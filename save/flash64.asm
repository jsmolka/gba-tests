format binary as 'gba'

include 'flash.inc'
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
        b       flash_common

flash:
        ; Fake flash save type
        dw      'FLAS'
        dw      'H_V '

        dw      'FLAS'
        dw      'H512'
        dw      '_V  '

        include 'flash.asm'

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
