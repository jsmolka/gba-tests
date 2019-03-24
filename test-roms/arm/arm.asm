format binary as 'gba'

include '../lib/arm.inc'

macro Failed test {
        mov     r12, test
        b       loop
}

main:
        b       main_arm
        include '../lib/header.asm'

main_arm:
        ; Setup red color
        mov     r0, 0x1F
        mov     r1, 0x5000000
        strh    r0, [r1]

        ; Setup DISPCNT
        mov     r0, 1
        lsl     r0, 8
        mov     r1, 0x4000000
        strh    r0, [r1]

        ; Setup BG0CNT
        mov     r0, 0
        add     r1, 8
        strh    r0, [r1]

        ; Reset test register
        mov     r12, 0

        ; Tests start at 1
        include 'arm1.asm'
        ; Tests start at 50
        include 'arm2.asm'
        ; Tests start at 100
        include 'arm3.asm'
        ; Tests start at 150
        include 'arm4.asm'
        ; Tests start at 150
        include 'arm5.asm'
        ; Tests start at 250
        include 'arm6.asm'
        ; Tests start at 300
        include 'arm7.asm'

passed:
        ; Setup green color
        mov     r0, 0x1F
        lsl     r0, 5
        mov     r1, 0x5000000
        strh    r0, [r1]

loop:
        b       loop