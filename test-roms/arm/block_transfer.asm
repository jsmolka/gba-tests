block_transfer:
        ; Tests for ARM 10
        ; Todo: test for modes

t400:
        ; ARM 10: Load / store multiple fully ascending
        mov     r0, 1
        mov     r1, 2

        stmfa   sp!, {r0, r1}
        ldmfa   sp!, {r2, r3}

        cmp     r0, r2
        bne     t400f
        cmp     r1, r3
        bne     t400f

        b       t401

t400f:
        failed  400

t401:
        ; ARM 10: Load / store multiple empty ascending
        mov     r0, 3
        mov     r1, 4

        stmea   sp!, {r0, r1}
        ldmea   sp!, {r2, r3}

        cmp     r0, r2
        bne     t401f
        cmp     r1, r3
        bne     t401f

        b       t402

t401f:
        failed  401

t402:
        ; ARM 10: Load / store multiple fully descending
        mov     r0, 5
        mov     r1, 6

        stmfd   sp!, {r0, r1}
        ldmfd   sp!, {r2, r3}

        cmp     r0, r2
        bne     t402f
        cmp     r1, r3
        bne     t402f

        b       t403

t402f:
        failed  402

t403:
        ; ARM 10: Load / store multiple empty descending
        mov     r0, 7
        mov     r1, 8


        stmed   sp!, {r0, r1}
        ldmed   sp!, {r2, r3}

        cmp     r0, r2
        bne     t403f
        cmp     r1, r3
        bne     t403f

        b       t404

t403f:
        failed  403

t404:
        ; ARM 10: Location fully ascending
        mov     r0, 9

        stmfa   sp, {r0, r1}

        ldr     r1, [sp, 4]
        cmp     r1, r0
        bne     t404f

        b       t405

t404f:
        failed  404

t405:
        ; ARM 10: Location empty ascending
        mov     r0, 10

        stmea   sp, {r0, r1}

        ldr     r1, [sp]
        cmp     r1, r0
        bne     t405f

        b       t406

t405f:
        failed  405

t406:
        ; ARM 10: Location fully descending
        mov     r0, 11

        stmfd   sp, {r0, r1}

        ldr     r1, [sp, -8]
        cmp     r1, r0
        bne     t406f

        b       t407

t406f:
        failed  406

t407:
        ; ARM 10: Location empty descending
        mov     r0, 12

        stmed   sp, {r0, r1}

        ldr     r1, [sp, -4]
        cmp     r1, r0
        bne     t407f

        b       t408

t407f:
        failed  407

t408:
        ; ARM 10: Store multiple with base register
        mov     r0, sp

        stmfd   r0!, {r0, r1}
        ldmfd   r0!, {r2, r3}

        cmp     r2, sp
        bne     t408f

        b       t409

t408f:
        failed  408

t409:
        ; ARM 10: Memory alignment
        mov     r0, 13
        mov     r1, 14
        add     r2, sp, 3
        sub     r3, sp, 5

        stmfd   r2!, {r0, r1}
        ldmfd   r3, {r4, r5}

        cmp     r0, r4
        bne     t409f
        cmp     r1, r5
        bne     t409f
        cmp     r2, r3
        bne     t409f

        b       t410

t409f:
        failed  409

t410:
        ; ARM 10: Load PC
        mov     r0, 15
        adr     r1, block_transfer_passed

        push    {r0, r1}
        pop     {r0, pc}

t410f:
        failed  410

block_transfer_passed:
