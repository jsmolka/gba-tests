format binary as 'gba'

include '../lib/arm.inc'
include '../lib/memory.inc'

macro failed test {
        immh    r12, test
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
        mov     r1, IO
        strh    r0, [r1, DISPCNT]

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
        include 'block_transfer.asm'

passed:
        ; Setup green color
        mov     r0, 0x1F shl 5
        mov     r1, PALETTE
        strh    r0, [r1]

loop:
        b       loop
