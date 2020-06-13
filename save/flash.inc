include '../lib/macros.inc'

macro m_flash_prep {
local .data
local .main

        b       .main

.data:
        dw      0x0E005555
        dw      0x0E002AAA

.main:
        stmfd   sp!, \{r0-r2\}
        adr     r0, .data
        ldr     r1, [r0]
        ldr     r2, [r0, 4]
        mov     r0, 0xAA
        strb    r0, [r1]
        mov     r0, 0x55
        strb    r0, [r2]
        ldmfd   sp!, \{r0-r2\}
}

macro m_flash cmd {
local .data
local .main

        b       .main

.data:
        dw      0x0E005555

.main:
        m_flash_prep

        stmfd   sp!, \{r0-r1\}
        adr     r0, .data
        ldr     r1, [r0]
        mov     r0, cmd
        strb    r0, [r1]
        ldmfd   sp!, \{r0-r1\}
}
