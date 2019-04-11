single_transfer:
        ; Tests for single data transfer operations
        ; Todo: Test store PC + 4 with real GBA
        mov     r11, WRAM

t350:
        ; ARM 7: Load / store word
        mvn     r0, 0
        str     r0, [r11]
        ldr     r1, [r11]
        cmp     r1, r0
        bne     t350f

        add     r11, 32
        b       t351

t350f:
        failed  350

t351:
        ; ARM 7: Store byte
        mvn     r0, 0
        strb    r0, [r11]
        ldr     r1, [r11]
        cmp     r1, 0xFF
        bne     t351f

        add     r11, 32
        b       t352

t351f:
        failed  351

t352:
        ; ARM 7: Load byte
        mvn     r0, 0
        str     r0, [r11]
        ldrb    r1, [r11]
        cmp     r1, 0xFF
        bne     t352f

        add     r11, 32
        b       t353

t352f:
        failed  352

t353:
        ; ARM 7: Indexing, writeback and offset types
        mov     r0, 32
        mov     r1, 1
        mov     r2, r11
        str     r0, [r2], 4
        ldr     r3, [r2, -r1, lsl 2]!
        cmp     r3, r0
        bne     t353f
        cmp     r2, r11
        bne     t353f

        add     r11, 32
        b       t354

t353f:
        failed  353

t354:
        ; ARM 7: Aligned store
        mov     r0, 32
        str     r0, [r11, 3]
        ldr     r1, [r11]
        cmp     r1, r0
        bne     t354f

        add     r11, 32
        b       t355

t354f:
        failed  354

t355:
        ; ARM 7: Misaligned load
        mov     r0, 32
        str     r0, [r11]
        ldr     r1, [r11, 3]
        cmp     r1, r0, ror 24
        bne     t355f

        add     r11, 32
        b       t356

t355f:
        failed  355

t356:
        ; ARM 7: Store PC + 4
        ; add     r0, pc, 4
        ; str     pc, [r11]
        ; ldr     r1, [r11]
        ; cmp     r1, r0
        ; bne     t356f
        ;
        ; add     r11, 32
        b       t357

t356f:
        failed  356

t357:
        ; ARM 8: Store halfword
        mvn     r0, 0
        strh    r0, [r11]
        lsr     r0, 16
        ldr     r1, [r11]
        cmp     r1, r0
        bne     t357f

        add     r11, 32
        b       t358

t357f:
        failed  357

t358:
        ; ARM 8: Load halfword
        mvn     r0, 0
        str     r0, [r11]
        lsr     r0, 16
        ldrh    r1, [r11]
        cmp     r1, r0
        bne     t358f

        add     r11, 32
        b       t359

t358f:
        failed  358

t359:
        ; ARM 8: Load unsigned halfword
        mov     r0, 0x7F00
        strh    r0, [r11]
        ldrsh   r1, [r11]
        cmp     r1, r0
        bne     t359f

        add     r11, 32
        b       t360

t359f:
        failed  359

t360:
        ; ARM 8: Load signed halfword
        mov     r0, 0xFF00
        strh    r0, [r11]
        mvn     r0, 0xFF
        ldrsh   r1, [r11]
        cmp     r1, r0
        bne     t360f

        add     r11, 32
        b       t361

t360f:
        failed  360

t361:
        ; ARM 8: Load unsigned byte
        mov     r0, 0x7F
        strb    r0, [r11]
        ldrsb   r1, [r11]
        cmp     r1, r0
        bne     t361f

        add     r11, 32
        b       t362

t361f:
        failed  361

t362:
        ; ARM 8: Load signed byte
        mov     r0, 0xFF
        strb    r0, [r11]
        mvn     r0, 0
        ldrsb   r1, [r11]
        cmp     r1, r0
        bne     t362f

        add     r11, 32
        b       t363

t362f:
        failed  362

t363:
        ; ARM 8: Indexing, writeback and offset types
        mov     r0, 32
        mov     r1, 4
        mov     r2, r11
        strh    r0, [r2], 4
        ldrh    r3, [r2, -r1]!
        cmp     r3, r0
        bne     t363f
        cmp     r2, r11
        bne     t363f

        add     r11, 32
        b       t364

t363f:
        failed  363

t364:
        ; ARM 8: Aligned store halfword
        mov     r0, 32
        strh    r0, [r11, 1]
        ldrh    r1, [r11]
        cmp     r1, r0
        bne     t364f

        add     r11, 32
        b       t365

t364f:
        failed  364

t365:
        ; ARM 8: Misaligned load halfword
        mov     r0, 32
        strh    r0, [r11]
        ldrh    r1, [r11, 1]
        cmp     r1, r0, ror 8
        bne     t365f

        add     r11, 32
        b       t366

t365f:
        failed  365

t366:
        ; ARM 8: Misaligned load signed halfword
        mov     r0, 0xFF00
        strh    r0, [r11]
        mvn     r0, 0
        ldrsh   r1, [r11, 1]
        cmp     r1, r0
        bne     t366f

        add     r11, 32
        b       t367

t366f:
        failed  366

t367:
        ; ARM 10: Swap word
        mvn     r0, 0
        str     r0, [r11]
        swp     r1, r0, [r11]
        cmp     r1, r0
        bne     t367f
        ldr     r1, [r11]
        cmp     r1, r0
        bne     t367f

        add     r11, 32
        b       t368

t367f:
        failed  367

t368:
        ; ARM 10: Swap byte
        mvn     r0, 0
        str     r0, [r11]
        swpb    r1, r0, [r11]
        cmp     r1, 0xFF
        bne     t368f
        ldr     r1, [r11]
        cmp     r1, r0
        bne     t368f

        add     r11, 32
        b       t369

t368f:
        failed  368

t369:
        ; ARM 10: Misaligned swap
        mov     r0, 32
        mov     r1, 64
        str     r1, [r11]
        add     r2, r11, 1
        swp     r3, r0, [r2]
        cmp     r3, r1, ror 8
        bne     t369f
        ldr     r3, [r11]
        cmp     r3, r0
        bne     t369f

        add     r11, 32
        b       t370

t369f:
        failed  369

t370:
        ; ARM 10: Swap same operands
        mov     r0, 32
        str     r0, [r11]
        mov     r0, 64
        swp     r0, r0, [r11]
        cmp     r0, 32
        bne     t370f
        ldr     r0, [r11]
        cmp     r0, 64
        bne     t370f

        b       single_transfer_passed

t370f:
        failed  370

single_transfer_passed:
