block_transfer:
        ; Tests for the block transfer instruction
        mov     r11, IWRAM
        add     r11, 0x100000

t400:
        ; ARM 10: Block transfer fully ascending
        mov     r0, 32
        mov     r1, 64
        stmfa   r11!, {r0, r1}
        ldmfa   r11!, {r2, r3}
        cmp     r0, r2
        bne     f400
        cmp     r1, r3
        bne     f400

        add     r11, 32
        b       t401

f400:
        failed  400

t401:
        ; ARM 10: Block transfer empty ascending
        mov     r0, 32
        mov     r1, 64
        stmea   r11!, {r0, r1}
        ldmea   r11!, {r2, r3}
        cmp     r0, r2
        bne     f401
        cmp     r1, r3
        bne     f401

        add     r11, 32
        b       t402

f401:
        failed  401

t402:
        ; ARM 10: Block transfer fully descending
        mov     r0, 32
        mov     r1, 64
        stmfd   r11!, {r0, r1}
        ldmfd   r11!, {r2, r3}
        cmp     r0, r2
        bne     f402
        cmp     r1, r3
        bne     f402

        add     r11, 32
        b       t403

f402:
        failed  402

t403:
        ; ARM 10: Block transfer empty descending
        mov     r0, 32
        mov     r1, 64
        stmed   r11!, {r0, r1}
        ldmed   r11!, {r2, r3}
        cmp     r0, r2
        bne     f403
        cmp     r1, r3
        bne     f403

        add     r11, 32
        b       t404

f403:
        failed  403

t404:
        ; ARM 10: Location fully ascending
        mov     r0, 32
        stmfa   r11, {r0, r1}
        ldr     r1, [r11, 4]
        cmp     r1, r0
        bne     f404

        add     r11, 32
        b       t405

f404:
        failed  404

t405:
        ; ARM 10: Location empty ascending
        mov     r0, 32
        stmea   r11, {r0, r1}
        ldr     r1, [r11]
        cmp     r1, r0
        bne     f405

        add     r11, 32
        b       t406

f405:
        failed  405

t406:
        ; ARM 10: Location fully descending
        mov     r0, 32
        stmfd   r11, {r0, r1}
        ldr     r1, [r11, -8]
        cmp     r1, r0
        bne     f406

        add     r11, 32
        b       t407

f406:
        failed  406

t407:
        ; ARM 10: Location empty descending
        mov     r0, 32
        stmed   r11, {r0, r1}
        ldr     r1, [r11, -4]
        cmp     r1, r0
        bne     f407

        add     r11, 32
        b       t408

f407:
        failed  407

t408:
        ; ARM 10: Store multiple with base register
        mov     r0, r11
        stmfd   r0!, {r0, r1}
        ldmfd   r0!, {r2, r3}
        cmp     r2, r11
        bne     f408

        add     r11, 32
        b       t409

f408:
        failed  408

t409:
        ; ARM 10: Memory alignment
        mov     r0, 32
        mov     r1, 64
        add     r2, r11, 3
        sub     r3, r11, 5
        stmfd   r2!, {r0, r1}
        ldmfd   r3, {r4, r5}
        cmp     r0, r4
        bne     f409
        cmp     r1, r5
        bne     f409
        cmp     r2, r3
        bne     f409

        add     r11, 32
        b       t410

f409:
        failed  409

t410:
        ; ARM 10: Load PC
        mov     r0, 32
        adr     r1, t411

        stmfd   r11!, {r0, r1}
        ldmfd   r11!, {r0, pc}

f410:
        failed  410

t411:
        ; ARM 10: Store user registers
        mov     r0, r11
        mov     r8, 0xA
        mov     r9, 0xB
        msr     cpsr_c, MODE_FIQ
        mov     r8, 0xC
        mov     r9, 0xD
        stmfd   r0, {r8, r9}^
        sub     r0, 8
        msr     cpsr_c, MODE_SYS
        ldmfd   r0, {r1, r2}
        cmp     r1, 0xA
        bne     f411
        cmp     r2, 0xB
        bne     f411

        add     r11, 32
        b       t412

f411:
        failed  411

t412:
        ; ARM 10: Load user registers
        mov     r0, r11
        mov     r1, 0xA
        mov     r2, 0xB
        stmfd   r0!, {r1, r2}
        msr     cpsr_c, MODE_FIQ
        mov     r8, 0xC
        mov     r9, 0xD
        ldmfd   r0, {r8, r9}^
        cmp     r8, 0xC
        bne     f412
        cmp     r9, 0xD
        bne     f412
        msr     cpsr_c, MODE_USR
        cmp     r8, 0xA
        bne     f412
        cmp     r9, 0xB
        bne     f412

        b       block_transfer_passed

f412:
        failed  412

block_transfer_passed:
