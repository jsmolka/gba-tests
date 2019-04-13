format binary as 'gba'

macro failed test {
        mov     r7, test
        bl      loop
}

header:
        include '../lib/header.asm'

main:
        adr     r0, main_thumb + 1
        bx      r0

code16
align 2
main_thumb:
        ; Setup red color
        mov     r0, 0x1F
        mov     r1, 5
        lsl     r1, 24
        strh    r0, [r1]

        ; Setup DISPCNT
        mov     r0, 1
        lsl     r0, 8
        mov     r1, 4
        lsl     r1, 24
        strh    r0, [r1]

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

passed:
        ; Setup green color
        mov     r0, 0x1F
        lsl     r0, 5
        mov     r1, 5
        lsl     r1, 24
        strh    r0, [r1]

loop:
        b       loop
