conditions:
        ; Tests for ARM conditions

t1:
        ; EQ - Z set
        msr     CPSR_flg, Z
        beq     t2
        failed  1

t2:
        ; NE - Z clear
        msr     CPSR_flg, 0
        bne     t3
        failed  2

t3:
        ; CS - C set
        msr     CPSR_flg, C
        bcs     t4
        failed  3

t4:
        ; CC - C clear
        msr     CPSR_flg, 0
        bcc     t5
        failed  4

t5:
        ; MI - N set
        msr     CPSR_flg, N
        bmi     t6
        failed  5

t6:
        ; PL - N clear
        msr     CPSR_flg, 0
        bpl     t7
        failed  6

t7:
        ; VS - V set
        msr     CPSR_flg, V
        bvs     t8
        failed  7

t8:
        ; VC - V clear
        msr     CPSR_flg, 0
        bvc     t9
        failed  8

t9:
        ; HI - C set and Z clear
        msr     CPSR_flg, C
        bhi     t10
        failed  9

t10:
        ; LS - C clear and Z set
        msr     CPSR_flg, Z
        bls     t11
        failed  10

t11:
        ; GE - N equals V
        msr     CPSR_flg, 0
        bge     t12
        failed  11

t12:
        msr     CPSR_flg, N or V
        bge     t13
        failed  12

t13:
        ; LT - N not equals to V
        msr     CPSR_flg, N
        blt     t14
        failed  13

t14:
        msr     CPSR_flg, V
        blt     t15
        failed  14

t15:
        ; GT - Z clear and (N equals Z)
        msr     CPSR_flg, 0
        bgt     t16
        failed  15

t16:
        msr     CPSR_flg, N or V
        bgt     t17
        failed  16

t17:
        ; LE - Z set or (N not equal to V)
        msr     CPSR_flg, Z
        ble     t18
        failed  17

t18:
        msr     CPSR_flg, N
        ble     t19
        failed  18

t19:
        msr     CPSR_flg, V
        ble     t20
        failed  19

t20:
        ; AL - always
        bal     passed
        failed  20
