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
        ; Test code execution in VRAM
        m_word  r0, (MEM_GAMEPAK0 + main_begin)
        m_word  r1, (MEM_GAMEPAK0 + main_end)
        m_word  r2, (MEM_VRAM + 0x14000)
.loop:
        ldr     r3, [r0], 4
        str     r3, [r2], 4
        cmp     r0, r1
        bne     .loop

        m_word  r2, (MEM_VRAM + 0x14000)
        bx      r2

main_begin:
        m_test_init

        ; Reset test register
        mov     r12, 0

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'

main_end:
