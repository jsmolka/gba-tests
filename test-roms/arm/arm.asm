format binary as 'gba'

include '../lib/arm.inc'
include '../lib/memory.inc'

; CPSR flag masks
N = 1 shl 31
Z = 1 shl 30
C = 1 shl 29
V = 1 shl 28

; Instruction for failed tests
macro failed test {
        imm16   r12, test
        b       loop
}

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
        imm32   r1, BG0CNT
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

passed:
        ; Setup green color
        mov     r0, 0x1F shl 5
        mov     r1, PALETTE
        strh    r0, [r1]

loop:
        b       loop
