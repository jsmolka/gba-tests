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

        ; Tests start at 1
        include 'conditions.asm'
        ; Tests start at 50
        include 'branches.asm'
        ; Tests start at 100
        include 'flags.asm'
        ; Tests start at 150
        include 'shifts.asm'
        ; Tests start at 200
        include 'data_processing.asm'
        ; Tests start at 250
        include 'psr_transfer.asm'
        ; Tests start at 300
        include 'multiply.asm'
        ; Tests start at 350
        include 'single_transfer.asm'
        ; Tests start at 400
        include 'halfword_transfer.asm'
        ; Tests start at 450
        include 'data_swap.asm'
        ; Tests start at 500
        include 'block_transfer.asm'

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
