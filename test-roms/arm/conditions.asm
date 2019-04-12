conditions:
        ; Tests for conditions

t001:
        ; EQ - Z set
        msr     cpsr_f, FLAG_Z
        beq     t002
        failed  1

t002:
        ; NE - Z clear
        msr     cpsr_f, 0
        bne     t003
        failed  2

t003:
        ; CS - C set
        msr     cpsr_f, FLAG_C
        bcs     t004
        failed  3

t004:
        ; CC - C clear
        msr     cpsr_f, 0
        bcc     t005
        failed  4

t005:
        ; MI - N set
        msr     cpsr_f, FLAG_N
        bmi     t006
        failed  5

t006:
        ; PL - N clear
        msr     cpsr_f, 0
        bpl     t007
        failed  6

t007:
        ; VS - V set
        msr     cpsr_f, FLAG_V
        bvs     t008
        failed  7

t008:
        ; VC - V clear
        msr     cpsr_f, 0
        bvc     t009
        failed  8

t009:
        ; HI - C set and Z clear
        msr     cpsr_f, FLAG_C
        bhi     t010
        failed  9

t010:
        ; LS - C clear and Z set
        msr     cpsr_f, FLAG_Z
        bls     t011
        failed  10

t011:
        ; GE - N equals V
        msr     cpsr_f, 0
        bge     t012
        failed  11

t012:
        msr     cpsr_f, FLAG_N or FLAG_V
        bge     t013
        failed  12

t013:
        ; LT - N not equals to V
        msr     cpsr_f, FLAG_N
        blt     t014
        failed  13

t014:
        msr     cpsr_f, FLAG_V
        blt     t015
        failed  14

t015:
        ; GT - Z clear and (N equals Z)
        msr     cpsr_f, 0
        bgt     t016
        failed  15

t016:
        msr     cpsr_f, FLAG_N or FLAG_V
        bgt     t017
        failed  16

t017:
        ; LE - Z set or (N not equal to V)
        msr     cpsr_f, FLAG_Z
        ble     t018
        failed  17

t018:
        msr     cpsr_f, FLAG_N
        ble     t019
        failed  18

t019:
        msr     cpsr_f, FLAG_V
        ble     t020
        failed  19

t020:
        ; AL - always
        bal     conditions_passed
        failed  20

conditions_passed:
