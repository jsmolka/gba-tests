format binary as 'gba'

include '../lib/macros.inc'

macro failed test {
        mov     r7, test
        bl      main_thumb_end
}

header:
        include '../lib/header.asm'

main:
        m_test_init
        adr     r0, main_thumb + 1
        bx      r0

code16
main_thumb:
        ; Reset test register
        mov     r7, 0

        ; Tests start at 1
        include 'logical.asm'
        ; Tests start at 50
        include 'shifts.asm'
        ; Tests start at 100
        include 'arithmetic.asm'
        ; Tests start at 150
        include 'branches.asm'
        ; Tests start at 200
        include 'memory.asm'

main_thumb_end:
        adr     r0, finished
        bx      r0

code32
finished:
        m_test_eval r7

idle:
        b       idle

include '../lib/text.asm'
