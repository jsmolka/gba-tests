logical:
        ; Tests for logical operations

t001:
        ; Zero flag
        mov     r0, 0
        bne     f001

        mov     r0, 1
        beq     f001

        b       t002

f001:
        m_exit  1

t002:
        ; Negative flag
        mov     r0, 1
        lsl     r0, 31
        mov     r0, r0
        bpl     f002

        mov     r0, 0
        bmi     f002

        b       t003

f002:
        m_exit  2

t003:
        ; THUMB 3: mov rd, imm8
        mov     r0, 32
        cmp     r0, 32
        bne     f003

        b       t004

f003:
        m_exit  3

t004:
        ; THUMB 2: mov rd, rs
        mov     r0, 32
        mov     r1, r0
        cmp     r1, r0
        bne     f004

        b       t005

f004:
        m_exit  4

t005:
        ; THUMB 5: mov rd, rs (high registers)
        mov     r0, 32
        mov     r8, r0
        mov     r9, r8
        mov     r0, r9
        cmp     r0, 32
        bne     f005

        b       t006

f005:
        m_exit  5

t006:
        ; THUMB 4: mvn rd, rs
        mov     r0, 0
        mvn     r0, r0
        add     r0, 1
        bne     f006

        b       t007

f006:
        m_exit  6

t007:
        ; THUMB 4: and rd, rs
        mov     r0, 0xFF
        mov     r1, 0x0F
        and     r0, r1
        cmp     r0, r1
        bne     f007

        b       t008

f007:
        m_exit  7

t008:
        ; THUMB 4: tst rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F
        tst     r0, r1
        bne     f008

        b       t009

f008:
        m_exit  8

t009:
        ; THUMB 4: bic rd, rs
        mov     r0, 0xFF
        mov     r1, 0xF0
        bic     r0, r1
        cmp     r0, 0x0F
        bne     f009

        b       t010

f009:
        m_exit  9

t010:
        ; THUMB 4: orr rd, rs
        mov     r0, 0xF0
        mov     r1, 0x0F
        orr     r0, r1
        cmp     r0, 0xFF
        bne     f010

        b       t011

f010:
        m_exit  10

t011:
        ; THUMB 4: eor rd, rs
        mov     r0, 0xFF
        mov     r1, 0x0F
        eor     r0, r1
        cmp     r0, 0xF0
        bne     f011

        b       t012

f011:
        m_exit  11

t012:
        ; THUMB 5: Write to PC
        adr     r0, t013
        mov     pc, r0

f012:
        m_exit  12

align 4
t013:
        ; THUMB 5: PC alignment
        adr     r0, logical_passed
        add     r0, 1
        mov     pc, r0

f013:
        m_exit  13

align 4
logical_passed:
