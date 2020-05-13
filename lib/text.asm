include 'memory.inc'

text_init:
        stmfd   sp!, {r0-r1, lr}        ; Store registers
        mov     r0, 0
        orr     r0, 4                   ; Background mode 4
        orr     r0, 1 shl 10            ; Background 2
        mov     r1, IO
        strh    r0, [r1, DISPCNT]
        ldmfd   sp!, {r0-r1, lr}        ; Restore registers
        mov     pc, lr                  ; Return

text_color:
        ; r0:   color
        ; r1:   index
        stmfd   sp!, {r0-r2, lr}        ; Store registers
        mov     r2, 2
        mul     r2, r1                  ; Calculate offset
        add     r2, PALETTE             ; Calculate address
        strh    r0, [r2]
        ldmfd   sp!, {r0-r2, lr}        ; Restore registers
        mov     pc, lr                  ; Return

_text_glyph:
        ; r0:   data, changed
        ; r1:   pointer, changed
        stmfd   sp!, {r2-r4, lr}        ; Store register
        mov     r2, 0                   ; Loop variable to 32
.loop:
        and     r3, r0, 1               ; Bit for lower byte
        lsr     r0, 1                   ; Next bit
        mov     r4, r3
        ror     r4, 8                   ; Rotate lower byte
        and     r3, r0, 1               ; Bit for higher byte
        lsr     r0, 1                   ; Next bit
        orr     r4, r3
        ror     r4, 24                  ; Get correct byte order
        strh    r4, [r1]                ; Store in VRAM
        add     r1, 2                   ; Increase pointer
        add     r2, 2                   ; Increase loop variable
        tst     r2, 7                   ; Check if line needs increase
        addeq   r1, 232                 ; Move to next line
        cmp     r2, 32
        bne     .loop
        ldmfd   sp!, {r2-r4, lr}        ; Restore registers
        mov     pc, lr                  ; Return

text_glyph:
        ; r0:   x
        ; r1:   y
        ; r2:   glyph data 1
        ; r3:   glyph data 2
        stmfd    sp!, {r0-r4, lr}       ; Store registers
        mov      r4, 240
        mul      r4, r1
        add      r4, r0                 ; Calculate offset
        add      r4, VRAM               ; Calculate address
        mov      r0, r2                 ; Setup function call
        mov      r1, r4                 ; Setup function call
        bl       _text_glyph            ; Draw glyph part
        mov      r0, r3                 ; Setup function call
        bl       _text_glyph            ; Draw glyph part
        ldmfd    sp!, {r0-r4, lr}       ; Restore registers
        mov      pc, lr                 ; Return

text_char:
        ; r0:    x, changed
        ; r1:    y
        ; r2:    char
        stmfd    sp!, {r1-r5, lr}       ; Store registers
        sub      r2, 32                 ; Get glyph offset
        mov      r3, 8
        mul      r2, r3
        adr      r3, glyphs             ; Get glyph base address
        ldr      r4, [r3, r2]           ; Load glyph data 1
        add      r2, 4
        ldr      r5, [r3, r2]           ; Load glyph data 2
        mov      r2, r4                 ; Setup function call
        mov      r3, r5                 ; Setup function call
        bl       text_glyph             ; Draw glyph
        add      r0, 8                  ; Increase x
        ldmfd    sp!, {r1-r5, lr}       ; Restore registers
        mov      pc, lr

include 'glyphs.asm'
