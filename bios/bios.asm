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

t001:
        ; BIOS read returns 0x0DC+8 after startup
        mov     r0, 0
        m_word  r1, 0xE129F000
        ldr     r2, [r0]
        cmp     r2, r1
        bne     f001
        b       t002

f001:
        m_exit  1

t002:
        ; BIOS read returns 0x188+8 after SWI
        mov     r0, 0
        m_word  r2, 0xE3A02004
        swi     0x80000  ; sqrt(r0)
        ldr     r3, [r0]
        cmp     r3, r2
        bne     f002
        b       t003

f002:
        m_exit  2

t003:
        ; BIOS read returns 0x134+8 during IRQ
        adr     r0, .isr
        m_word  r1, 0x03007FFC
        str     r0, [r1]

        ; Enable interrupts
        mov     r0, STAT_VBLANK_IRQ
        mov     r1, MEM_IO
        mov     r2, REG_DISPSTAT
        strh    r0, [r1, r2]
        mov     r0, IRQ_VBLANK
        mov     r2, REG_IE
        strh    r0, [r1, r2]
        mov     r0, 1
        mov     r2, REG_IME
        strh    r0, [r1, r2]

        ; Wait for vblank
        m_vsync

        ; Disable interrupts
        mov     r0, 0
        mov     r1, MEM_IO
        mov     r2, REG_IME
        strh    r0, [r1, r2]

        ; Evaluate result
        m_word  r0, 0xE25EF004
        mov     r1, MEM_IWRAM
        ldr     r2, [r1]
        cmp     r2, r0
        bne     f003
        b       t004

.isr:
        mov     r0, 0
        ldr     r1, [r0]
        mov     r0, MEM_IWRAM
        str     r1, [r0]

        ; Acknowledge interrupt and return
        mov     r0, IRQ_VBLANK
        mov     r1, MEM_IO
        m_half  r2, REG_IF
        strh    r0, [r1, r2]
        mov     pc, lr

f003:
        m_exit  3

t004:
        ; BIOS read returns 0x13C+8 after IRQ
        mov     r0, 0
        m_word  r1, 0xE55EC002
        ldr     r2, [r0]
        cmp     r2, r1
        bne     f004
        b       eval

f004:
        m_exit  4

eval:
        m_vsync
        m_test_eval r12

idle:
        b       idle

include '../lib/text.asm'
