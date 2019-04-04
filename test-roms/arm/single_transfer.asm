single_transfer:
        ; Tests for ARM 7, 8 and 10

t350:
        ; ARM 7: Load / store word
        mvn     r0, 0

        str     r0, [sp]
        ldr     r1, [sp]
        cmp     r1, r0
        bne     t350f

        b       t351

t350f:
        failed  350

t351:
        ; ARM 7: Load / store byte
        mov     r0, 0
        str     r0, [sp]
        mvn     r0, 0

        strb    r0, [sp]
        ldr     r1, [sp]
        cmp     r1, 0xFF
        bne     t351f

        b       t352

t351f:
        failed  351

t352:
        mvn     r0, 0

        str     r0, [sp]
        ldrb    r1, [sp]
        cmp     r1, 0xFF
        bne     t352f

        b       t353

t352f:
        failed  352

t353:
        ; ARM 7: Register offset, indexing
        mov     r0, 0xEE
        mov     r1, sp
        mov     r2, 4

        str     r0, [sp, r2]!
        ldr     r3, [sp]
        cmp     r3, r0
        bne     t353f

        add     r1, r2
        cmp     r1, sp
        bne     t353f

        b       t354

t353f:
        failed  353

t354:
        mov     r0, 0xDD
        mov     r1, sp
        mov     r2, 4

        str     r0, [sp], r2
        ldr     r3, [sp]
        cmp     r3, r0
        beq     t354f

        add     r1, r2
        cmp     r1, sp
        bne     t354f

        b       t355

t354f:
        failed  354

t355:
        mov     r0, 0xCC
        mov     r1, sp
        mov     r2, 4

        str     r0, [sp], r2
        ldr     r3, [sp, -r2]!
        cmp     r3, r0
        bne     t355f

        cmp     r1, sp
        bne     t355f

        b       t356

t355f:
        failed  355

t356:
        ; ARM 7: Immediate / shifted register offset
        mov     r0, 0xBB
        mov     r1, sp

        str     r0, [sp], 4
        ldr     r2, [sp, -4]!
        cmp     r2, r0
        bne     t356f

        cmp     r1, sp
        bne     t356f

        b       t357

t356f:
        failed  356

t357:
        mov     r0, 0xAA
        mov     r1, sp
        mov     r2, 1

        str     r0, [sp], r2, lsl 2
        ldr     r3, [sp, -r2, lsl 2]!
        cmp     r3, r0
        bne     t357f

        cmp     r1, sp
        bne     t357f

        b       t358

t357f:
        failed  357

t358:
        ; ARM 7: Address alignment
        mov     r0, 0x99

        str     r0, [sp, 3]
        ldr     r1, [sp]
        cmp     r1, r0
        bne     t358f

        b       t359

t358f:
        failed  358

t359:
        mov     r0, 0x88
        mov     r1, sp

        str     r0, [sp, 3]!
        ldr     r2, [r1]
        cmp     r2, r0
        bne     t359f

        sub     sp, 3
        cmp     sp, r1
        bne     t359f

        b       t360

t359f:
        failed  359

t360:
        ; ARM 8: Load / store halfword
        mov     r0, 0
        str     r0, [sp]
        mvn     r0, 0
        mov     r1, r0, lsr 16

        strh    r0, [sp]
        ldr     r2, [sp]
        cmp     r2, r1
        bne     t360f

        b       t361

t360f:
        failed  360

t361:
        mvn     r0, 0
        mov     r1, r0, lsr 16

        str     r0, [sp]
        ldrh    r2, [sp]
        cmp     r2, r1
        bne     t361f

        b       t362

t361f:
        failed  361

t362:
        ; ARM 8: Load sign extended halfword
        imm16   r0, 0x7FFF

        str     r0, [sp]
        ldrsh   r1, [sp]
        cmp     r1, r0
        bne     t362f

        orr     r0, 0xF000
        mvn     r1, 0

        str     r0, [sp]
        ldrsh   r2, [sp]
        cmp     r2, r1
        bne     t362f

        b       t363

t362f:
        failed  362

t363:
        ; ARM 8: Load sign extended byte
        mov     r0, 0x7F

        str     r0, [sp]
        ldrsb   r1, [sp]
        cmp     r1, r0
        bne     t363f

        mov     r0, 0xFF
        mvn     r1, 0

        str     r0, [sp]
        ldrsb   r2, [sp]
        cmp     r2, r1
        bne     t363f

        b       t364

t363f:
        failed  363

t364:
        ; ARM 8: Register offset, indexing
        mov     r0, 0xEE
        mov     r1, sp
        mov     r2, 4

        strh    r0, [sp, r2]!
        ldrh    r3, [sp]
        cmp     r3, r0
        bne     t364f

        add     r1, r2
        cmp     r1, sp
        bne     t364f

        b       t365

t364f:
        failed  364

t365:
        mov     r0, 0xDD
        mov     r1, sp
        mov     r2, 4

        strh    r0, [sp], r2
        ldrh    r3, [sp]
        cmp     r3, r0
        beq     t365f

        add     r1, r2
        cmp     r1, sp
        bne     t365f

        b       t366

t365f:
        failed  365

t366:
        mov     r0, 0xCC
        mov     r1, sp
        mov     r2, 4

        strh    r0, [sp], r2
        ldrh    r3, [sp, -r2]!
        cmp     r3, r0
        bne     t366f

        cmp     r1, sp
        bne     t366f

        b       t367

t366f:
        failed  366

t367:
        ; ARM 8: Immediate / shifted register offset
        mov     r0, 0xBB
        mov     r1, sp

        strh    r0, [sp], 4
        ldrh    r2, [sp, -4]!
        cmp     r2, r0
        bne     t367f

        cmp     r1, sp
        bne     t367f

        b       t368

t367f:
        failed  367

t368:
        ; ARM 8: Address alignment
        mov     r0, 0x99

        strh    r0, [sp, 3]
        ldrh    r1, [sp, 2]
        cmp     r1, r0
        bne     t368f

        b       t369

t368f:
        failed  368

t369:
        mov     r0, 0x88
        mov     r1, sp

        strh    r0, [sp, 3]!
        ldrh    r2, [r1, 2]
        cmp     r2, r0
        bne     t369f

        sub     sp, 3
        cmp     sp, r1
        bne     t369f

        b       t370

t369f:
        failed  369

t370:
        ; ARM 10: Swap word
        mov     r0, 0
        mvn     r1, 0
        str     r1, [sp]

        swp     r2, r0, [sp]
        cmp     r2, r1
        bne     t370f

        ldr     r2, [sp]
        cmp     r2, r0
        bne     t370f

        b       t371

t370f:
        failed  370

t371:
        ; ARM 10: Swap byte
        mvn     r0, 0
        str     r0, [sp]
        mov     r0, 0x55
        strb    r0, [sp]
        mov     r0, 0x44

        swpb    r1, r0, [sp]
        cmp     r1, 0x55
        bne     t371f

        ldrb    r1, [sp]
        cmp     r1, r0
        bne     t371f

        b       t372

t371f:
        failed  371

t372:
        ; ARM 10: Memory alignment
        ; Todo: write proper test

        b       single_transfer_passed

t372f:
        failed  372

single_transfer_passed:
