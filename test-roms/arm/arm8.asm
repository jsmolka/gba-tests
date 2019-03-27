arm8:
        ; Tests for Arm 8 instruction
        mov     r12, 0x05000000

t200:
        imm32   r0, 0xFFFFFFFF

        strh    r0, [r12]
        ldrh    r1, [r12]

        lsr     r0, r0, 16
        cmp     r0, r1
        bne     t200f

        b       t201

t200f:
        Failed 200

t201:
        imm32   r0, 0x0000F1F1

        str     r0, [r12]
        ldrsh   r1, [r12]

        imm32   r0, 0xFFFFF1F1
        cmp     r0, r1
        bne     t201f

        ldrsb   r1, [r12]

        imm32   r0, 0xFFFFFFF1
        cmp     r0, r1
        bne     t201f

        b       passed

t201f:
        Failed 201
