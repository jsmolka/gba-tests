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
        ; ARM 10: Store PC + 4
        stmfd   r11!, {r0, pc}
        mov     r0, pc
        ldmfd   r11!, {r1, r2}
        cmp     r0, r2
        bne     f510

        add     mem, 32
        b       t511

f510:
        failed  510

t511:
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
        bne     f511

        add     mem, 32
        b       t512

f511:
        failed  511

t512:
        ; ARM 10: Load user registers
        mov     r0, mem
        mov     r1, 0xA
        stmfd   r0!, {r1, r2}
        msr     cpsr, MODE_FIQ
        mov     r8, 0xB
        ldmfd   r0, {r8, r9}^
        cmp     r8, 0xB
        bne     f512
        msr     cpsr, MODE_SYS
        cmp     r8, 0xA
        bne     f512

        add     mem, 32
        b       t513

f512:
        failed  512

t513:
        ; ARM 10: Load empty rlist
        adr     r0, t514
        str     r0, [mem]
        mov     r0, mem
        dw      0xE8B00000  ; ldmia r0!, {}

f513:
        failed  513

t514:
        sub     r0, 0x40
        cmp     r0, mem
        bne     f514

        add     mem, 32
        b       t515

f514:
        failed  514

t515:
        ; ARM 10: Store empty rlist
        mov     r0, mem
        dw      0xE8A00000  ; stmia r0!, {}
        mov     r1, pc
        ldr     r2, [mem]
        cmp     r2, r1
        bne     f515

        sub     r0, 0x40
        cmp     r0, mem
        bne     f515

        add     mem, 32
        b       t516

f515:
        failed  515

t516:
        ; ARM 10: Load writeback base first in rlist
        mov     r0, 0xA
        mov     r1, mem
        stmfd   r1!, {r0, r2}
        dw      0xE8B10006  ; ldmfa r1!, {r1, r2}
        cmp     r1, 0xA
        bne     f516

        add     mem, 32
        b       t517

f516:
        failed  516

t517:
        ; ARM 10: Load writeback base last in rlist
        mov     r2, 0xA
        mov     r1, mem
        stmfd   r1!, {r0, r2}
        dw      0xE8B10003  ; ldmfa r1!, {r0, r1}
        cmp     r1, 0xA
        bne     f517

        add     mem, 32
        b       t518

f517:
        failed  517

t518:
        ; ARM 10: STMFD base first in rlist
        mov     r0, mem
        stmfd   r0!, {r0, r1}
        ldmfd   r0!, {r1, r2}
        cmp     r1, mem
        bne     f518

        add     mem, 32
        b       t519

f518:
        failed  518

t519:
        ; ARM 10: STMED base first in rlist
        mov     r0, mem
        stmed   r0!, {r0, r1}
        ldmed   r0!, {r1, r2}
        cmp     r1, mem
        bne     f519

        add     mem, 32
        b       t520

f519:
        failed  519

t520:
        ; ARM 10: STMFA base first in rlist
        mov     r0, mem
        stmfa   r0!, {r0, r1}
        ldmfa   r0!, {r1, r2}
        cmp     r1, mem
        bne     f520

        add     mem, 32
        b       t521

f520:
        failed  520

t521:
        ; ARM 10: STMEA base first in rlist
        mov     r0, mem
        stmea   r0!, {r0, r1}
        ldmea   r0!, {r1, r2}
        cmp     r1, mem
        bne     f521

        add     mem, 32
        b       t522

f521:
        failed  521

t522:
        ; ARM 10: STMFD base in rlist
        mov     r1, mem
        dw      0xE921000F  ; stmfd r1!, {r0-r3}
        ldmfd   r1!, {r4-r7}
        sub     r0, mem, 16
        cmp     r0, r5
        bne     f522

        add     mem, 32
        b       t523

f522:
        failed  522

t523:
        ; ARM 10: STMFD base in rlist
        mov     r2, mem
        dw      0xE922000F  ; stmfd r2!, {r0-r3}
        ldmfd   r2!, {r4-r7}
        sub     r0, mem, 16
        cmp     r0, r6
        bne     f523

        add     mem, 32
        b       t524

f523:
        failed  523

t524:
        ; ARM 10: STMED base in rlist
        mov     r1, mem
        dw      0xE821000F  ; stmed r1!, {r0-r3}
        ldmed   r1!, {r4-r7}
        sub     r0, mem, 16
        cmp     r0, r5
        bne     f524

        add     mem, 32
        b       t525

f524:
        failed  524

t525:
        ; ARM 10: STMED base in rlist
        mov     r2, mem
        dw      0xE822000F  ; stmed r2!, {r0-r3}
        ldmed   r2!, {r4-r7}
        sub     r0, mem, 16
        cmp     r0, r6
        bne     f525

        add     mem, 32
        b       t526

f525:
        failed  525

t526:
        ; ARM 10: STMFA base in rlist
        mov     r1, mem
        dw      0xE9A1000F  ; stmfa r1!, {r0-r3}
        ldmfa   r1!, {r4-r7}
        add     r0, mem, 16
        cmp     r0, r5
        bne     f526

        add     mem, 32
        b       t527

f526:
        failed  526

t527:
        ; ARM 10: STMFA base in rlist
        mov     r2, mem
        dw      0xE9A2000F  ; stmfa r2!, {r0-r3}
        ldmfa   r2!, {r4-r7}
        add     r0, mem, 16
        cmp     r0, r6
        bne     f527

        add     mem, 32
        b       t528

f527:
        failed  527

t528:
        ; ARM 10: STMEA base in rlist
        mov     r1, mem
        dw      0xE8A1000F  ; stmea r1!, {r0-r3}
        ldmea   r1!, {r4-r7}
        add     r0, mem, 16
        cmp     r0, r5
        bne     f528

        add     mem, 32
        b       t529

f528:
        failed  528

t529:
        ; ARM 10: STMEA base in rlist
        mov     r2, mem
        dw      0xE8A2000F  ; stmea r2!, {r0-r3}
        ldmea   r2!, {r4-r7}
        add     r0, mem, 16
        cmp     r0, r6
        bne     f529

        add     mem, 32
        b       block_transfer_passed

f529:
        failed  529

block_transfer_passed:
        restore mem
