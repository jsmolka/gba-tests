include '../lib/macros.inc'

macro m_flash cmd {
        stmfd   sp!, \{r0-r2\}
        m_word  r0, 0x0E005555
        m_word  r1, 0x0E002AAA
        mov     r2, 0xAA
        strb    r2, [r0]
        mov     r2, 0x55
        strb    r2, [r1]
        mov     r2, cmd
        strb    r2, [r0]
        ldmfd   sp!, \{r0-r2\}
}
