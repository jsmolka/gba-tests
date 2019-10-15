block_transfer:
        ; Tests for the block transfer instruction
        mem     equ r11
        mov     mem, IWRAM
        add     mem, 0x4500

t500:
        ; ARM 10: Fully ascending
        mov     r0, 32
        mov     r1, 64
        stmfa   r11!, {r0, r1}
        ldmfa   r11!, {r2, r3}
        cmp     r0, r2
        bne     f500
        cmp     r1, r3
        bne     f500

        add     mem, 32
        b       t501

f500:
        failed  500

t501:
        ; ARM 10: Empty ascending
        mov     r0, 32
        mov     r1, 64
        stmea   r11!, {r0, r1}
        ldmea   r11!, {r2, r3}
        cmp     r0, r2
        bne     f501
        cmp     r1, r3
        bne     f501

        add     mem, 32
        b       t502

f501:
        failed  501

t502:
        ; ARM 10: Fully descending
        mov     r0, 32
        mov     r1, 64
        stmfd   r11!, {r0, r1}
        ldmfd   r11!, {r2, r3}
        cmp     r0, r2
        bne     f502
        cmp     r1, r3
        bne     f502

        add     mem, 32
        b       t503

f502:
        failed  502

t503:
        ; ARM 10: Empty descending
        mov     r0, 32
        mov     r1, 64
        stmed   r11!, {r0, r1}
        ldmed   r11!, {r2, r3}
        cmp     r0, r2
        bne     f503
        cmp     r1, r3
        bne     f503

        add     mem, 32
        b       t504

f503:
        failed  503

t504:
        ; ARM 10: Location fully ascending
        mov     r0, 32
        stmfa   mem, {r0, r1}
        ldr     r1, [mem, 4]
        cmp     r1, r0
        bne     f504

        add     mem, 32
        b       t505

f504:
        failed  504

t505:
        ; ARM 10: Location empty ascending
        mov     r0, 32
        stmea   mem, {r0, r1}
        ldr     r1, [mem]
        cmp     r1, r0
        bne     f505

        add     mem, 32
        b       t506

f505:
        failed  505

t506:
        ; ARM 10: Location fully descending
        mov     r0, 32
        stmfd   mem, {r0, r1}
        ldr     r1, [mem, -8]
        cmp     r1, r0
        bne     f506

        add     mem, 32
        b       t507

f506:
        failed  506

t507:
        ; ARM 10: Location empty descending
        mov     r0, 32
        stmed   mem, {r0, r1}
        ldr     r1, [mem, -4]
        cmp     r1, r0
        bne     f507

        add     mem, 32
        b       t508

f507:
        failed  507

t508:
        ; ARM 10: Memory alignment
        mov     r0, 32
        mov     r1, 64
        add     r2, mem, 3
        sub     r3, mem, 5
        stmfd   r2!, {r0, r1}
        ldmfd   r3, {r4, r5}
        cmp     r0, r4
        bne     f508
        cmp     r1, r5
        bne     f508
        cmp     r2, r3
        bne     f508

        add     mem, 32
        b       t509

f508:
        failed  508

t509:
        ; ARM 10: Load PC
        adr     r1, t510
        stmfd   r11!, {r0, r1}
        ldmfd   r11!, {r0, pc}

f509:
        failed  509

t510:
        ; ARM 10: Store user registers
        mov     r0, mem
        mov     r8, 32
        msr     cpsr, MODE_FIQ
        mov     r8, 64
        stmfd   r0, {r8, r9}^
        sub     r0, 8
        msr     cpsr, MODE_SYS
        ldmfd   r0, {r1, r2}
        cmp     r1, 32
        bne     f510

        add     mem, 32
        b       t511

f510:
        failed  510

t511:
        ; ARM 10: Load user registers
        mov     r0, mem
        mov     r1, 0xA
        stmfd   r0!, {r1, r2}
        msr     cpsr, MODE_FIQ
        mov     r8, 0xB
        ldmfd   r0, {r8, r9}^
        cmp     r8, 0xB
        bne     f511
        msr     cpsr, MODE_SYS
        cmp     r8, 0xA
        bne     f511

        add     mem, 32
        b       t512

f511:
        failed  511

t512:
        ; ARM 10: Writeback with rb in rlist
        mov     r0, 32
        stmfd   r11!, {r0, r1}
        mov     r0, mem
        dw      0xE8B00003  ; ldmfd r0!, {r0, r1}
        cmp     r0, 32
        bne     f512

        add     mem, 32
        b       t513

f512:
        failed  512

t513:
        ; ARM 10: Writeback with rb first in rlist
        mov     r0, mem
        stmfd   r0!, {r0, r1}
        ldmfd   r0!, {r1, r2}
        cmp     r1, mem
        bne     f513

        add     mem, 32
        b       t514

f513:
        failed  513

t514:
        ; ARM 10: Load empty rlist
        adr     r0, t515
        str     r0, [mem]
        mov     r0, mem
        dw      0xE8B00000  ; ldmia r0!, {}

f514:
        failed  514

t515:
        sub     r0, 0x40
        cmp     r0, mem
        bne     f515

        add     mem, 32
        b       t516

f515:
        failed  515

t516:
        ; ARM 10: Store empty rlist
        mov     r0, mem
        dw      0xE8A00000  ; stmia r0!, {}
        mov     r1, pc
        ldr     r2, [mem]
        cmp     r2, r1
        bne     f516

        sub     r0, 0x40
        cmp     r0, mem
        bne     f516

        add     mem, 32
        b       t517

f516:
        failed  516

t517:
        ; ARM 10: Store PC + 4
        stmfd   r11!, {r0, pc}
        mov     r0, pc
        ldmfd   r11!, {r1, r2}
        cmp     r0, r2
        bne     f517

        add     mem, 32
        b       t518

f517:
        failed  517

t518:
        ; ARM 10: Store unmodified address if first
        mov     r0, mem
        stmfd   r0!, {r0, r1}
        ldmfd   r0!, {r2, r3}
        cmp     r2, mem
        bne     f518

        add     mem, 32
        b       t519

f518:
        failed  518

t519:
        ; ARM 10: Store modified address if later
        mov     r1, mem
        dw      0xE9210003  ; stmfd r1!, {r0, r1}
        ldm     r1, {r0, r2}
        cmp     r1, r2
        bne     f519

        add     mem, 32
        b       block_transfer_passed

f519:
        failed  519

block_transfer_passed:
        restore mem
