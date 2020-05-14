include 'constants.inc'

text_init:
        stmfd   sp!, {r0-r1, lr}
        mov     r0, 4                   ; Background mode 4
        orr     r0, 1 shl 10            ; Background 2
        mov     r1, IO
        strh    r0, [r1, DISPCNT]
        ldmfd   sp!, {r0-r1, pc}

text_color:
        ; r0:   color
        ; r1:   index
        stmfd   sp!, {r0-r2, lr}
        mov     r2, 2
        mul     r2, r1                  ; Calculate offset
        add     r2, PALETTE             ; Calculate address
        strh    r0, [r2]
        ldmfd   sp!, {r0-r2, pc}

text_glyph_data:
        ; r0:   data, modified
        ; r1:   pointer, modified
        stmfd   sp!, {r2-r4, lr}
        mov     r2, 0                   ; Loop to 32
.loop:
        and     r3, r0, 1               ; Bit for lower byte
        lsr     r0, 1                   ; Advance in data
        mov     r4, r3
        ror     r4, 8                   ; Rotate lower byte
        and     r3, r0, 1               ; Bit for higher byte
        lsr     r0, 1                   ; Advance in data
        orr     r4, r3
        ror     r4, 24                  ; Get correct byte order
        strh    r4, [r1]
        add     r1, 2
        add     r2, 2
        tst     r2, 7                   ; Check for glyph line end
        addeq   r1, 232                 ; Move to next line
        cmp     r2, 32
        bne     .loop
        ldmfd   sp!, {r2-r4, pc}

text_glyph:
        ; r0:   x
        ; r1:   y
        ; r2:   glyph data 1
        ; r3:   glyph data 2
        stmfd   sp!, {r0-r4, lr}
        mov     r4, 240
        mul     r4, r1
        add     r4, r0                  ; Calculate offset
        add     r4, VRAM                ; Calculate address
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
        stmfd   sp!, {r1-r5, lr}
        sub     r2, 32                  ; Calculate glyph offset
        mov     r3, 8
        mul     r2, r3
        adr     r3, glyphs
        ldr     r4, [r3, r2]            ; Load glyph data 1
        add     r2, 4
        ldr     r5, [r3, r2]            ; Load glyph data 2
        mov     r2, r4                  ; Setup function call
        mov     r3, r5                  ; Setup function call
        bl      text_glyph              ; Render glyph
        add     r0, 8
        ldmfd   sp!, {r1-r5, pc}

include 'glyphs.asm'
