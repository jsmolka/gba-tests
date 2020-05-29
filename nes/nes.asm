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

t001:
        ; Test two stage pipeline
        adr     r0, .pipe1
        adr     r1, .pipe2
        mov     r2, 0
        str     r2, [r0]
        str     r2, [r1]

.pipe1:
        cmp     r2, 0
.pipe2:
        beq     eval

f001:
        m_exit  1

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'

main_end:
