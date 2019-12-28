gba_header:
        ; Branch to 0x080000C0 (4 bytes)
        dw      0xEA00002E

        ; Nintendo logo (156 bytes)
        times 156 db 0x00

        db      'eggvance',0,0,0,0 ; Game title (12 bytes)
        db      '1337'             ; Game code (4 bytes)
        db      'JS'               ; Make code (2 bytes)
        db      0x96               ; Fixed (1 byte)
        db      0x00               ; Unit code (1 byte)
        db      0x80               ; Device type (1 byte)
        db      0,0,0,0,0,0,0      ; Unused (7 bytes)
        db      0x00               ; Game version (1 byte)
        db      0x26               ; Complement (1 byte)
        db      0,0                ; Reserved (2 bytes)
