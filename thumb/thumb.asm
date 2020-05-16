format binary as 'gba'

include '../lib/macros.inc'

macro m_exit test {
        mov     r7, test
        bl      tmain_end
}

header:
        include '../lib/header.asm'

main:
        m_test_init

        adr     r0, tmain + 1
        bx      r0

code16
align 2
tmain:
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

tmain_end:
        adr     r0, eval
        bx      r0

code32
align 4
eval:
        m_vsync
        m_test_eval r7

idle:
        b       idle

include '../lib/text.asm'
