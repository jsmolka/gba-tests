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

sram:
        ; Fake SRAM save type
        dw      'SRAM'
        dw      '_V  '

t001:
        ; Uninitialized memory
        ldrb    r0, [r11]
        cmp     r0, 0xFF
        bne     f001

        add     r11, 32
        b       t002

f001:
        m_exit  1

t002:
        ; Mirror 1
        mov     r0, 1
        mov     r1, r11
        strb    r0, [r1]
        add     r1, 0x10000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f002

        add     r11, 32
        b       t003

f002:
        m_exit  2

t003:
        ; Mirror 2
        mov     r0, 1
        mov     r1, r11
        strb    r0, [r1]
        add     r1, 0x01000000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f003

        add     r11, 32
        b       t004

f003:
        m_exit  3

t004:
        ; Load half
        mov     r0, 1
        strb    r0, [r11]
        ldrh    r0, [r11]
        m_half  r1, 0x0101
        cmp     r1, r0
        bne     f004

        add     r11, 32
        b       t005

f004:
        m_exit  4

t005:
        ; Load word
        mov     r0, 1
        strb    r0, [r11]
        ldr     r0, [r11]
        m_word  r1, 0x01010101
        cmp     r1, r0
        bne     f005

        add     r11, 32
        b       t006

f005:
        m_exit  5

t006:
        ; Store half position
        m_half  r0, 0xAABB

        strh    r0, [r11]
        ldrb    r1, [r11]
        cmp     r1, 0xBB
        bne     f006

        strh    r0, [r11, 1]
        ldrb    r1, [r11, 1]
        cmp     r1, 0xAA
        bne     f006

        add     r11, 32
        b       t007

f006:
        m_exit  6

t007:
        ; Store half just byte
        m_half  r0, 0xAABB
        strh    r0, [r11]

        ldrb    r1, [r11]
        cmp     r1, 0xBB
        bne     f007

        ldrb    r1, [r11, 1]
        cmp     r1, 0xFF
        bne     f007

        add     r11, 32
        b       t008

f007:
        m_exit  7

t008:
        ; Store word position
        m_word  r0, 0xAABBCCDD

        str     r0, [r11]
        ldrb    r1, [r11]
        cmp     r1, 0xDD
        bne     f008

        str     r0, [r11, 1]
        ldrb    r1, [r11, 1]
        cmp     r1, 0xCC
        bne     f008

        str     r0, [r11, 2]
        ldrb    r1, [r11, 2]
        cmp     r1, 0xBB
        bne     f008

        str     r0, [r11, 3]
        ldrb    r1, [r11, 3]
        cmp     r1, 0xAA
        bne     f008

        add     r11, 32
        b       t009

f008:
        m_exit  8

t009:
        ; Store word just byte
        m_word  r0, 0xAABBCCDD
        str     r0, [r11]

        ldrb    r1, [r11]
        cmp     r1, 0xDD
        bne     f009

        ldrb    r1, [r11, 1]
        cmp     r1, 0xFF
        bne     f009

        ldrb    r1, [r11, 2]
        cmp     r1, 0xFF
        bne     f009

        ldrb    r1, [r11, 3]
        cmp     r1, 0xFF
        bne     f009

        b       eval

f009:
        m_exit  9

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
