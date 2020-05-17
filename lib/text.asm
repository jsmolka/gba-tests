include 'constants.inc'

code32
align 4
text_init:
        stmfd   sp!, {r0-r1, lr}
        mov     r0, 4                   ; Background mode 4
        orr     r0, 1 shl 10            ; Background 2
        mov     r1, MEM_IO
        strh    r0, [r1, REG_DISPCNT]
        ldmfd   sp!, {r0-r1, pc}

text_color:
        ; r0:   color
        ; r1:   index
        stmfd   sp!, {r0-r2, lr}
        lsl     r1, 1
        mov     r2, MEM_PALETTE
        strh    r0, [r2, r1]
        ldmfd   sp!, {r0-r2, pc}

text_glyph_data:
        ; r0:   data, modified
        ; r1:   pointer, modified
        stmfd   sp!, {r2-r4, lr}
        mov     r2, 0                   ; Loop counter
.loop:
        and     r3, r0, 1               ; First bit
        lsr     r0, 1                   ; Advance in data
        and     r4, r0, 1               ; Second bit
        lsr     r0, 1                   ; Advance in data
        orr     r3, r4, ror 24          ; Move second bit
        strh    r3, [r1], 2
        add     r2, 2
        tst     r2, 7                   ; Check for glyph line end
        addeq   r1, 232                 ; Move to next line
        cmp     r2, 32
        bne     .loop
        ldmfd   sp!, {r2-r4, pc}

text_glyph:
        ; r0:   x
        ; r1:   y
        ; r2:   glyph data upper
        ; r3:   glyph data lower
        stmfd   sp!, {r0-r4, lr}
        mov     r4, 240
        mla     r4, r4, r1, r0          ; Calculate offset
        add     r4, MEM_VRAM            ; Calculate address
        mov     r0, r2                  ; Setup function call
        mov     r1, r4                  ; Setup function call
        bl      text_glyph_data
        mov     r0, r3                  ; Setup function call
        bl      text_glyph_data
        ldmfd   sp!, {r0-r4, pc}

text_char:
        ; r0:   x, modified
        ; r1:   y
        ; r2:   char
        stmfd   sp!, {r1-r3, lr}
        sub     r2, 32                  ; Calculate glyph position
        lsl     r2, 3                   ; Calculate glyph offset
        adr     r3, glyphs
        add     r3, r2
        ldmia   r3, {r2, r3}            ; Load data, setup function call
        bl      text_glyph              ; Render glyph
        add     r0, 8
        ldmfd   sp!, {r1-r3, pc}

include 'glyphs.asm'
