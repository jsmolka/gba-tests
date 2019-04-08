conditions:
        ; Tests for conditions

t1:
        ; EQ - Z set
        msr     cpsr_f, Z
        beq     t2
        failed  1

t2:
        ; NE - Z clear
        msr     cpsr_f, 0
        bne     t3
        failed  2

t3:
        ; CS - C set
        msr     cpsr_f, C
        bcs     t4
        failed  3

t4:
        ; CC - C clear
        msr     cpsr_f, 0
        bcc     t5
        failed  4

t5:
        ; MI - N set
        msr     cpsr_f, N
        bmi     t6
        failed  5

t6:
        ; PL - N clear
        msr     cpsr_f, 0
        bpl     t7
        failed  6

t7:
        ; VS - V set
        msr     cpsr_f, V
        bvs     t8
        failed  7

t8:
        ; VC - V clear
        msr     cpsr_f, 0
        bvc     t9
        failed  8

t9:
        ; HI - C set and Z clear
        msr     cpsr_f, C
        bhi     t10
        failed  9

t10:
        ; LS - C clear and Z set
        msr     cpsr_f, Z
        bls     t11
        failed  10

t11:
        ; GE - N equals V
        msr     cpsr_f, 0
        bge     t12
        failed  11

t12:
        msr     cpsr_f, N or V
        bge     t13
        failed  12

t13:
        ; LT - N not equals to V
        msr     cpsr_f, N
        blt     t14
        failed  13

t14:
        msr     cpsr_f, V
        blt     t15
        failed  14

t15:
        ; GT - Z clear and (N equals Z)
        msr     cpsr_f, 0
        bgt     t16
        failed  15

t16:
        msr     cpsr_f, N or V
        bgt     t17
        failed  16

t17:
        ; LE - Z set or (N not equal to V)
        msr     cpsr_f, Z
        ble     t18
        failed  17

t18:
        msr     cpsr_f, N
        ble     t19
        failed  18

t19:
        msr     cpsr_f, V
        ble     t20
        failed  19

t20:
        ; AL - always
        bal     conditions_passed
        failed  20

conditions_passed:
