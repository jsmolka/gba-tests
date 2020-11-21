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
        ; Tests start at 100
        include 'rom_reads.asm'

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'

align 4
rom_end:
        ; Reading this byte as a word or halfword will segfault if the emulator
        ; just checks if the address is smaller than the size and then casts it
        db      0xFF
