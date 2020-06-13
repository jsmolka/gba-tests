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
        dw      'H1M_'
        dw      'V   '

        include 'flash.asm'

t012:
        ; Bank switching
        mov     r0, 1
        m_flash 0xA0
        strb    r0, [r11]

        ; Switch bank
        mov     r0, 1
        mov     r1, MEM_SRAM
        m_flash 0xB0
        strb    r0, [r1]

        ; Compare value
        ldrb    r0, [r11]
        cmp     r0, 1
        beq     f012

        ; Write error value
        mov     r0, 2
        m_flash 0xA0
        strb    r0, [r11]

        ; Switch bank back
        mov     r0, 0
        mov     r1, MEM_SRAM
        m_flash 0xB0
        strb    r0, [r1]

        ; Read old value
        ldrb    r0, [r11]
        cmp     r0, 1
        bne     f012

        b       eval

f012:
        m_exit  12

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
