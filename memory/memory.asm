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

        ; Tests start at 1
        include 'mirrors.asm'
        ; Tests start at 50
        include 'video_strb.asm'

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
