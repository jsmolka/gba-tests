include 'constants.inc'

macro m_half reg, value {
        mov     reg, value and 0xFF
        orr     reg, value and 0xFF00
}

macro m_word reg, value {
        mov     reg, value and 0xFF
        orr     reg, value and 0xFF00
        orr     reg, value and 0xFF0000
        orr     reg, value and 0xFF000000
}

macro m_vsync {
local .vblank_end
local .vblank_beg

        stmfd   sp!, \{r0-r1\}
        mov     r0, MEM_IO

.vblank_end:
        ldr     r1, [r0, REG_DISPSTAT]
        tst     r1, STAT_VBLANK_FLG
        bne     .vblank_end             ; Loop until not in vblank

.vblank_beg:
        ldr     r1, [r0, REG_DISPSTAT]
        tst     r1, STAT_VBLANK_FLG
        beq     .vblank_beg             ; Loop until in vblank
        ldmfd   sp!, \{r0-r1\}
}

macro m_text_init {
        bl      text_init
}

macro m_text_color color, index {
        m_half  r0, color
        mov     r1, index
        bl      text_color
}

macro m_text_pos x, y {
        mov     r0, x
        mov     r1, y
}

macro m_text_char char {
        mov     r2, char
        bl      text_char
}

macro m_test_init {
        m_text_init
        m_text_color 0xFFFF, 0
        m_text_color 0x0000, 1
        m_text_color 0xFFFF, 2
}

macro m_test_eval reg {
local .passed
local .failed
local .exit

        stmfd   sp!, \{r0-r12\}
        movs    r12, reg
        beq     .passed
        bne     .failed

.passed:
        m_text_pos 56, 76
        m_text_char 'A'
        m_text_char 'l'
        m_text_char 'l'
        m_text_char ' '
        m_text_char 't'
        m_text_char 'e'
        m_text_char 's'
        m_text_char 't'
        m_text_char 's'
        m_text_char ' '
        m_text_char 'p'
        m_text_char 'a'
        m_text_char 's'
        m_text_char 's'
        m_text_char 'e'
        m_text_char 'd'
        b       .exit

.failed:
        mov     r11, MEM_IWRAM
        mov     r0, r12
        mov     r1, 100
        swi     0x60000         ; Test div 100
        str     r0, [r11]       ; Div result
        mov     r0, r1          ; Mod result
        mov     r1, 10
        swi     0x60000         ; Previous mod div 10
        str     r0, [r11, 4]    ; Div result
        str     r1, [r11, 8]    ; Mod result
        m_text_pos 60, 76
        m_text_char 'F'
        m_text_char 'a'
        m_text_char 'i'
        m_text_char 'l'
        m_text_char 'e'
        m_text_char 'd'
        m_text_char ' '
        m_text_char 't'
        m_text_char 'e'
        m_text_char 's'
        m_text_char 't'
        m_text_char ' '
        ldr     r2, [r11]       ; Hundreds digit
        add     r2, 48
        bl      text_char
        ldr     r2, [r11, 4]    ; Tens digit
        add     r2, 48
        bl      text_char
        ldr     r2, [r11, 8]    ; Ones digit
        add     r2, 48
        bl      text_char

.exit:
        ldmfd   sp!, \{r0-r12\}
}
