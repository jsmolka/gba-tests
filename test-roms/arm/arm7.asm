arm7:
        ; Tests for Arm 7 instruction
        mov     r12, 0x05000000

t150:
        ; ldr / str
        imm32   r0, 0xFFFFFFFF

        str     r0, [r12]
        ldr     r1, [r12]

        cmp     r0, r1
        bne     t150f

        b       t151

t150f:
        Failed 150

t151:
        ; ldrb / strb
        imm32   r0, 0xEEEEEEEE

        strb    r0, [r12]
        ldrb    r1, [r12]

        cmp     r1, 0xEE
        bne     t151f

        b       t152

t151f:
        Failed 151

t152:
        ; offset
        imm32   r0, 0xDDDDDDDD
        mov     r1, 1

        str     r0, [r12, 8]
        ldr     r1, [r12, r1, lsl 3]

        cmp     r0, r1
        bne     t152f

        b       t153

t152f:
        Failed 152

t153:
        ; pre-indexed, writeback
        imm32   r0, 0xCCCCCCCC

        str     r0, [r12, 8]!
        ldr     r1, [r12]

        cmp     r0, r1
        bne     t153f

        b       t154

t153f:
        Failed 153

t154:
        ; pre-indexed, writeback
        imm32   r0, 0xBBBBBBBB

        str     r0, [r12, -8]!
        ldr     r1, [r12]

        cmp     r0, r1
        bne     t154f

        b       t155

t154f:
        Failed 154

t155:
        ; post-indexed, (writeback)
        imm32   r0, 0xAAAAAAAA

        str     r0, [r12], -8
        ldr     r1, [r12, 8]!

        cmp     r0, r1
        bne     t155f

        b       arm8

t155f:
        Failed 155
