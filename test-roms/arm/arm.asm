format binary as 'gba'

include '../lib/arm.inc'
include '../lib/memory.inc'

macro failed test {
        imm16   r12, test
        b       loop
}

; CPSR flag masks
N = 1 shl 31
Z = 1 shl 30
C = 1 shl 29
V = 1 shl 28

; CPSR modes
MODE_USR = 0x10
MODE_FIQ = 0x11
MODE_IRQ = 0x12
MODE_SVC = 0x13
MODE_ABT = 0x17
MODE_SYS = 0x1F

header:
        include '../lib/header.asm'

main:
        ; Setup red color
        mov     r0, 0x1F
        mov     r1, PALETTE
        strh    r0, [r1]

        ; Setup DISPCNT
        mov     r0, 1 shl 8
        mov     r1, DISPCNT
        strh    r0, [r1]

        ; Setup BG0CNT
        mov     r0, 0
        add     r1, 8
        strh    r0, [r1]

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
        ;include 'block_transfer.asm'

passed:
        ; Setup green color
        mov     r0, 0x1F shl 5
        mov     r1, PALETTE
        strh    r0, [r1]

loop:
        b       loop
