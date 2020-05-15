format binary as 'gba'

include '../lib/macros.inc'

header:
        include '../lib/header.asm'

main:
        m_text_init
        m_text_color 0xFFFF, 1
        m_vsync

        m_text_pos 72, 76
        m_text_char 'H'
        m_text_char 'e'
        m_text_char 'l'
        m_text_char 'l'
        m_text_char 'o'
        m_text_char ' '
        m_text_char 'w'
        m_text_char 'o'
        m_text_char 'r'
        m_text_char 'l'
        m_text_char 'd'
        m_text_char '!'

idle:
        b       idle

include '../lib/text.asm'
