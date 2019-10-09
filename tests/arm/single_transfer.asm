single_transfer:
        ; Tests for single data transfer operations
        mov     r11, IWRAM

t350:
        ; ARM 7: Load / store word
        mvn     r0, 0
        str     r0, [r11]
        ldr     r1, [r11]
        cmp     r1, r0
        bne     f350

        add     r11, 32
        b       t351

f350:
        failed  350

t351:
        ; ARM 7: Store byte
        mvn     r0, 0
        strb    r0, [r11]
        ldr     r1, [r11]
        cmp     r1, 0xFF
        bne     f351

        add     r11, 32
        b       t352

f351:
        failed  351

t352:
        ; ARM 7: Load byte
        mvn     r0, 0
        str     r0, [r11]
        ldrb    r1, [r11]
        cmp     r1, 0xFF
        bne     f352

        add     r11, 32
        b       t353

f352:
        failed  352

t353:
        ; ARM 7: Indexing, writeback and offset types
        mov     r0, 32
        mov     r1, 1
        mov     r2, r11
        str     r0, [r2], 4
        ldr     r3, [r2, -r1, lsl 2]!
        cmp     r3, r0
        bne     f353
        cmp     r2, r11
        bne     f353

        add     r11, 32
        b       t354

f353:
        failed  353

t354:
        ; ARM 7: Aligned store
        mov     r0, 32
        str     r0, [r11, 3]
        ldr     r1, [r11]
        cmp     r1, r0
        bne     f354

        add     r11, 32
        b       t355

f354:
        failed  354

t355:
        ; ARM 7: Misaligned load
        mov     r0, 32
        str     r0, [r11]
        ldr     r1, [r11, 3]
        cmp     r1, r0, ror 24
        bne     f355

        add     r11, 32
        b       t356

f355:
        failed  355

t356:
        ; ARM 7: Store PC + 4
        str     pc, [r11]
        mov     r0, pc
        ldr     r1, [r11]
        cmp     r1, r0
        bne     f356

        add     r11, 32
        b       t357

f356:
        failed  356

t357:
        ; ARM 7: Load into PC
        adr     r0, t358
        str     r0, [r11]
        ldr     pc, [r11]

f357:
        failed  357

t358:
        ; ARM 7: Same operands
        mov     r0, 32
        str     r0, [r11]
        mov     r0, r11
        sub     r0, 4
        dw      0xE5B00004  ; ldr r0, [r0, 4]!
        cmp     r0, 32
        bne     f358

        b       t359

f358:
        failed  358

t359:
        ; ARM 8: Store halfword
        mvn     r0, 0
        strh    r0, [r11]
        lsr     r0, 16
        ldr     r1, [r11]
        cmp     r1, r0
        bne     f359

        add     r11, 32
        b       t360

f359:
        failed  359

t360:
        ; ARM 8: Load halfword
        mvn     r0, 0
        str     r0, [r11]
        lsr     r0, 16
        ldrh    r1, [r11]
        cmp     r1, r0
        bne     f360

        add     r11, 32
        b       t361

f360:
        failed  360

t361:
        ; ARM 8: Load unsigned halfword
        mov     r0, 0x7F00
        strh    r0, [r11]
        ldrsh   r1, [r11]
        cmp     r1, r0
        bne     f361

        add     r11, 32
        b       t362

f361:
        failed  361

t362:
        ; ARM 8: Load signed halfword
        mov     r0, 0xFF00
        strh    r0, [r11]
        mvn     r0, 0xFF
        ldrsh   r1, [r11]
        cmp     r1, r0
        bne     f362

        add     r11, 32
        b       t363

f362:
        failed  362

t363:
        ; ARM 8: Load unsigned byte
        mov     r0, 0x7F
        strb    r0, [r11]
        ldrsb   r1, [r11]
        cmp     r1, r0
        bne     f363

        add     r11, 32
        b       t364

f363:
        failed  363

t364:
        ; ARM 8: Load signed byte
        mov     r0, 0xFF
        strb    r0, [r11]
        mvn     r0, 0
        ldrsb   r1, [r11]
        cmp     r1, r0
        bne     f364

        add     r11, 32
        b       t365

f364:
        failed  364

t365:
        ; ARM 8: Indexing, writeback and offset types
        mov     r0, 32
        mov     r1, 4
        mov     r2, r11
        strh    r0, [r2], 4
        ldrh    r3, [r2, -r1]!
        cmp     r3, r0
        bne     f365
        cmp     r2, r11
        bne     f365

        add     r11, 32
        b       t366

f365:
        failed  365

t366:
        ; ARM 8: Aligned store halfword
        mov     r0, 32
        strh    r0, [r11, 1]
        ldrh    r1, [r11]
        cmp     r1, r0
        bne     f366

        add     r11, 32
        b       t367

f366:
        failed  366

t367:
        ; ARM 8: Misaligned load halfword
        mov     r0, 32
        strh    r0, [r11]
        ldrh    r1, [r11, 1]
        cmp     r1, r0, ror 8
        bne     f367

        add     r11, 32
        b       t368

f367:
        failed  367

t368:
        ; ARM 8: Misaligned load signed halfword
        mov     r0, 0xFF00
        strh    r0, [r11]
        mvn     r0, 0
        ldrsh   r1, [r11, 1]
        cmp     r1, r0
        bne     f368

        add     r11, 32
        b       t369

f368:
        failed  368

t369:
        ; ARM 10: Swap word
        mvn     r0, 0
        str     r0, [r11]
        swp     r1, r0, [r11]
        cmp     r1, r0
        bne     f369
        ldr     r1, [r11]
        cmp     r1, r0
        bne     f369

        add     r11, 32
        b       t370

f369:
        failed  369

t370:
        ; ARM 10: Swap byte
        mvn     r0, 0
        str     r0, [r11]
        swpb    r1, r0, [r11]
        cmp     r1, 0xFF
        bne     f370
        ldr     r1, [r11]
        cmp     r1, r0
        bne     f370

        add     r11, 32
        b       t371

f370:
        failed  370

t371:
        ; ARM 10: Misaligned swap
        mov     r0, 32
        mov     r1, 64
        str     r1, [r11]
        add     r2, r11, 1
        swp     r3, r0, [r2]
        cmp     r3, r1, ror 8
        bne     f371
        ldr     r3, [r11]
        cmp     r3, r0
        bne     f371

        add     r11, 32
        b       t372

f371:
        failed  371

t372:
        ; ARM 10: Same operands
        mov     r0, 32
        str     r0, [r11]
        mov     r0, 64
        swp     r0, r0, [r11]
        cmp     r0, 32
        bne     f372
        ldr     r0, [r11]
        cmp     r0, 64
        bne     f372

        b       single_transfer_passed

f372:
        failed  372

single_transfer_passed:
