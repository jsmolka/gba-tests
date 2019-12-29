data_swap:
        ; Tests for the data swap instruction
        mem     equ r11
        mov     mem, IWRAM
        add     mem, 0x3000

t450:
        ; ARM 10: Swap word
        mvn     r0, 0
        str     r0, [mem]
        swp     r1, r0, [mem]
        cmp     r1, r0
        bne     f450
        ldr     r1, [mem]
        cmp     r1, r0
        bne     f450

        add     mem, 32
        b       t451

f450:
        failed  450

t451:
        ; ARM 10: Swap byte
        mvn     r0, 0
        str     r0, [mem]
        swpb    r1, r0, [mem]
        cmp     r1, 0xFF
        bne     f451
        ldr     r1, [mem]
        cmp     r1, r0
        bne     f451

        add     mem, 32
        b       t452

f451:
        failed  451

t452:
        ; ARM 10: Misaligned swap
        mov     r0, 32
        mov     r1, 64
        str     r1, [mem]
        add     r2, mem, 1
        swp     r3, r0, [r2]
        cmp     r3, r1, ror 8
        bne     f452
        ldr     r3, [mem]
        cmp     r3, r0
        bne     f452

        add     mem, 32
        b       t453

f452:
        failed  452

t453:
        ; ARM 10: Same source and destination
        mov     r0, 32
        str     r0, [mem]
        mov     r0, 64
        swp     r0, r0, [mem]
        cmp     r0, 32
        bne     f453
        ldr     r0, [mem]
        cmp     r0, 64
        bne     f453

        b       data_swap_passed

f453:
        failed  453

data_swap_passed:
        restore mem
