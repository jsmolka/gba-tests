format binary as 'gba'

include '../lib/arm.inc'
include '../lib/constants.inc'

macro failed test {
        immh    r12, test
        b       loop
}

header:
        include '../lib/header.asm'

main:
        ; Setup DISPCNT
        mov     r0, 4
        orr     r0, 1 shl 10
        mov     r1, IO
        strh    r0, [r1, DISPCNT]

        ; Setup red color
        mov     r0, 0x1F
        mov     r1, PALETTE
        strh    r0, [r1]

        ; Reset test register
        mov     r12, 0

t001:
        ; BIOS read returns 0x0DC+8 after startup
        mov     r0, 0
        immw    r1, 0xE129F000
        ldr     r2, [r0]
        cmp     r2, r1
        bne     f001
        b       t002

f001:
        failed  1

t002:
        ; BIOS read returns 0x188+8 after swi
        mov     r0, 0
        immw    r1, 0xE3A02004
        swi     0x80000  ; sqrt(r0)
        ldr     r2, [r0]
        cmp     r2, r1
        bne     f002
        b       passed

f002:
        failed  2

passed:
        ; Setup green color
        mov     r0, 0x1F shl 5
        mov     r1, PALETTE
        strh    r0, [r1]

loop:
        b       loop
