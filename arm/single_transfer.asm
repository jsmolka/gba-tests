single_transfer:
        ; Tests for the single data transfer instruction
        mem     equ r11
        mov     mem, IWRAM

t350:
        ; ARM 7: Load / store word
        mvn     r0, 0
        str     r0, [mem]
        ldr     r1, [mem]
        cmp     r1, r0
        bne     f350

        add     mem, 32
        b       t351

f350:
        failed  350

t351:
        ; ARM 7: Store byte
        mvn     r0, 0
        strb    r0, [mem]
        ldr     r1, [mem]
        cmp     r1, 0xFF
        bne     f351

        add     mem, 32
        b       t352

f351:
        failed  351

t352:
        ; ARM 7: Load byte
        mvn     r0, 0
        str     r0, [mem]
        ldrb    r1, [mem]
        cmp     r1, 0xFF
        bne     f352

        add     mem, 32
        b       t353

f352:
        failed  352

t353:
        ; ARM 7: Indexing, writeback and offset types
        mov     r0, 32
        mov     r1, 1
        mov     r2, mem
        str     r0, [r2], 4
        ldr     r3, [r2, -r1, lsl 2]!
        cmp     r3, r0
        bne     f353
        cmp     r2, mem
        bne     f353

        add     mem, 32
        b       t354

f353:
        failed  353

t354:
        ; ARM 7: Misaligned store
        mov     r0, 32
        str     r0, [mem, 3]
        ldr     r1, [mem]
        cmp     r1, r0
        bne     f354

        add     mem, 32
        b       t355

f354:
        failed  354

t355:
        ; ARM 7: Misaligned load (rotated)
        mov     r0, 32
        str     r0, [mem]
        ldr     r1, [mem, 3]
        cmp     r1, r0, ror 24
        bne     f355

        add     mem, 32
        b       t356

f355:
        failed  355

t356:
        ; ARM 7: Store PC + 4
        str     pc, [mem]
        mov     r0, pc
        ldr     r1, [mem]
        cmp     r1, r0
        bne     f356

        add     mem, 32
        b       t357

f356:
        failed  356

t357:
        ; ARM 7: Load into PC
        adr     r0, t358
        str     r0, [mem]
        ldr     pc, [mem], 32

f357:
        failed  357

t358:
        ; ARM 7: Store writeback same register
        mov     r0, mem
        dw      0xE5A00004  ; str r0, [r0, 4]!
        add     r1, mem, 4
        cmp     r1, r0
        bne     f358

        ldr     r1, [r0]
        cmp     r1, mem
        bne     f358

        add     mem, 32
        b       t359

f358:
        failed  358

t359:
        ; ARM 7: Store writeback same register
        mov     r0, mem
        dw      0xE4800004  ; str r0, [r0], 4
        sub     r0, 4
        cmp     r0, mem
        bne     f359

        ldr     r1, [r0]
        cmp     r1, mem
        bne     f359

        add     mem, 32
        b       t360

f359:
        failed  359

t360:
        ; ARM 7: Load writeback same register
        mov     r0, mem
        mov     r1, 32
        str     r1, [r0], -4
        dw      0xE5B00004  ; ldr r0, [r0, 4]!
        cmp     r0, 32
        bne     f360

        add     mem, 32
        b       t361

f360:
        failed  360

t361:
        ; ARM 7: Load writeback same register
        mov     r0, mem
        mov     r1, 32
        str     r1, [r0]
        dw      0xE4900004  ; ldr r0, [r0], 4
        cmp     r0, 32
        bne     f361

        add     mem, 32
        b       t362

f361:
        failed  361

t362:
        ; ARM 7: Special shifts as offset
        mov     r0, 0
        mov     r1, 0
        msr     cpsr_f, FLAG_C
        ldr     r2, [r1, r0, rrx]!
        cmp     r1, 1 shl 31
        bne     f362
        bcc     f362

        add     mem, 32
        b       t363

f362:
        failed  362

t363:
        ; ARM 7: Load current instruction
        ldr     r0, [pc, -8]
        immw    r1, 0xE51F0008
        bne     f363

        add     mem, 32
        b       single_transfer_passed

f363:
        failed  363

single_transfer_passed:
        restore mem