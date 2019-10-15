halfword_transfer:
        ; Tests for the halfword data transfer instruction
        mem     equ r11
        mov     mem, IWRAM
        add     mem, 0x1500

t400:
        ; ARM 8: Store halfword
        mvn     r0, 0
        strh    r0, [mem]
        lsr     r0, 16
        ldr     r1, [mem]
        cmp     r1, r0
        bne     f400

        add     mem, 32
        b       t401

f400:
        failed  400

t401:
        ; ARM 8: Load halfword
        mvn     r0, 0
        str     r0, [mem]
        lsr     r0, 16
        ldrh    r1, [mem]
        cmp     r1, r0
        bne     f401

        add     mem, 32
        b       t402

f401:
        failed  401

t402:
        ; ARM 8: Load unsigned halfword
        mov     r0, 0x7F00
        strh    r0, [mem]
        ldrsh   r1, [mem]
        cmp     r1, r0
        bne     f402

        add     mem, 32
        b       t403

f402:
        failed  402

t403:
        ; ARM 8: Load signed halfword
        mov     r0, 0xFF00
        strh    r0, [mem]
        mvn     r0, 0xFF
        ldrsh   r1, [mem]
        cmp     r1, r0
        bne     f403

        add     mem, 32
        b       t404

f403:
        failed  403

t404:
        ; ARM 8: Load unsigned byte
        mov     r0, 0x7F
        strb    r0, [mem]
        ldrsb   r1, [mem]
        cmp     r1, r0
        bne     f404

        add     mem, 32
        b       t405

f404:
        failed  404

t405:
        ; ARM 8: Load signed byte
        mov     r0, 0xFF
        strb    r0, [mem]
        mvn     r0, 0
        ldrsb   r1, [mem]
        cmp     r1, r0
        bne     f405

        add     mem, 32
        b       t406

f405:
        failed  405

t406:
        ; ARM 8: Indexing, writeback and offset types
        mov     r0, 32
        mov     r1, 4
        mov     r2, mem
        strh    r0, [r2], 4
        ldrh    r3, [r2, -r1]!
        cmp     r3, r0
        bne     f406
        cmp     r2, mem
        bne     f406

        add     mem, 32
        b       t407

f406:
        failed  406

t407:
        ; ARM 8: Aligned store halfword
        mov     r0, 32
        strh    r0, [mem, 1]
        ldrh    r1, [mem]
        cmp     r1, r0
        bne     f407

        add     mem, 32
        b       t408

f407:
        failed  407

t408:
        ; ARM 8: Misaligned load halfword (rotated)
        mov     r0, 32
        strh    r0, [mem]
        ldrh    r1, [mem, 1]
        cmp     r1, r0, ror 8
        bne     f408

        add     mem, 32
        b       t409

f408:
        failed  408

t409:
        ; ARM 8: Misaligned load signed halfword
        mov     r0, 0xFF00
        strh    r0, [mem]
        mvn     r0, 0
        ldrsh   r1, [mem, 1]
        cmp     r1, r0
        bne     f409

        add     mem, 32
        b       t410

f409:
        failed  409

t410:
        ; ARM 8: Store writeback same register
        mov     r0, mem
        dw      0xE1E000B4  ; strh r0, [r0, 4]!
        add     r1, mem, 4
        cmp     r1, r0
        bne     f410

        ldr     r1, [r0]
        mov     r2, mem
        bic     r2, 0xFF000000
        bic     r2, 0xFF0000
        cmp     r2, r1
        bne     f410

        add     mem, 32
        b       t411

f410:
        failed  410

t411:
        ; ARM 8: Store writeback same register
        mov     r0, mem
        dw      0xE0C000B4  ; strh r0, [r0], 4
        sub     r0, 4
        cmp     r0, mem
        bne     f411

        ldr     r1, [r0]
        mov     r2, mem
        bic     r2, 0xFF000000
        bic     r2, 0xFF0000
        cmp     r2, r1
        bne     f411

        add     mem, 32
        b       t412

f411:
        failed  411

t412:
        ; ARM 8: Load writeback same register
        mov     r0, mem
        mov     r1, 32
        str     r1, [r0], -4
        dw      0xE1F000B4  ; ldrh r0, [r0, 4]!
        cmp     r0, 32
        bne     f412

        add     mem, 32
        b       t413

f412:
        failed  412

t413:
        ; ARM 8: Load writeback same register
        mov     r0, mem
        mov     r1, 32
        strh    r1, [r0]
        dw      0xE0D000B4  ; ldrh r0, [r0], 4
        cmp     r0, 32
        bne     f413

        add     mem, 32
        b       halfword_transfer_passed

f413:
        failed  413

halfword_transfer_passed:
        restore mem
