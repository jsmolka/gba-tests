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
