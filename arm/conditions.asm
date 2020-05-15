conditions:
        ; Tests for conditions

t001:
        ; EQ - Z set
        msr     cpsr_f, FLAG_Z
        beq     t002
        m_exit  1

t002:
        ; NE - Z clear
        msr     cpsr_f, 0
        bne     t003
        m_exit  2

t003:
        ; CS - C set
        msr     cpsr_f, FLAG_C
        bcs     t004
        m_exit  3

t004:
        ; CC - C clear
        msr     cpsr_f, 0
        bcc     t005
        m_exit  4

t005:
        ; MI - N set
        msr     cpsr_f, FLAG_N
        bmi     t006
        m_exit  5

t006:
        ; PL - N clear
        msr     cpsr_f, 0
        bpl     t007
        m_exit  6

t007:
        ; VS - V set
        msr     cpsr_f, FLAG_V
        bvs     t008
        m_exit  7

t008:
        ; VC - V clear
        msr     cpsr_f, 0
        bvc     t009
        m_exit  8

t009:
        ; HI - C set and Z clear
        msr     cpsr_f, FLAG_C
        bhi     t010
        m_exit  9

t010:
        ; LS - C clear and Z set
        msr     cpsr_f, FLAG_Z
        bls     t011
        m_exit  10

t011:
        ; GE - N equals V
        msr     cpsr_f, 0
        bge     t012
        m_exit  11

t012:
        msr     cpsr_f, FLAG_N or FLAG_V
        bge     t013
        m_exit  12

t013:
        ; LT - N not equals to V
        msr     cpsr_f, FLAG_N
        blt     t014
        m_exit  13

t014:
        msr     cpsr_f, FLAG_V
        blt     t015
        m_exit  14

t015:
        ; GT - Z clear and (N equals V)
        msr     cpsr_f, 0
        bgt     t016
        m_exit  15

t016:
        msr     cpsr_f, FLAG_N or FLAG_V
        bgt     t017
        m_exit  16

t017:
        ; LE - Z set or (N not equal to V)
        msr     cpsr_f, FLAG_Z
        ble     t018
        m_exit  17

t018:
        msr     cpsr_f, FLAG_N
        ble     t019
        m_exit  18

t019:
        msr     cpsr_f, FLAG_V
        ble     t020
        m_exit  19

t020:
        ; AL - always
        bal     conditions_passed
        m_exit  20

conditions_passed:
