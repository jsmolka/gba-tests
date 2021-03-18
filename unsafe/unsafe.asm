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
        ; Next power of two
        rom_size = rom_end
        rom_size = rom_size - 1
        rom_size = rom_size or rom_size shr 1
        rom_size = rom_size or rom_size shr 2
        rom_size = rom_size or rom_size shr 4
        rom_size = rom_size or rom_size shr 8
        rom_size = rom_size or rom_size shr 16
        rom_size = rom_size + 1

        m_test_init

        ; Reset test register
        mov     r12, 0

        b       t001

        ; Fake save type
        dw      'SRAM'
        dw      '_V  '

t001:
        ; SRAM 32k mirror
        mov     r0, 1
        mov     r1, MEM_SRAM
        strb    r0, [r1]
        add     r1, 0x8000
        ldrb    r0, [r1]
        cmp     r0, 1
        bne     f001

        b       t002

f001:
        m_exit  1

t002:
        ; Unused ROM reads
        m_word  r0, (0x8000000 + rom_size)
        m_word  r1, (0x8000000 + rom_size + 0x1000)
.loop:
        bl      .calc
        ldrb    r3, [r0]
        cmp     r3, r2
        bne     f002
        add     r0, 1
        cmp     r0, r1
        bne     .loop

        b       eval

.calc:
        ; r0: bad address
        ; r2 return: expected byte
        mov     r2, r0
        lsr     r2, 1
        tst     r0, 1
        lsrne   r2, 8
        and     r2, 0xFF
        mov     pc, lr

f002:
        m_exit  2

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'

rom_end:
