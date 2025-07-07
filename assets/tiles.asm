; Tile 0
.byte $00,$66,$42,$00,$00,$42,$3C,$00
.byte $00,$66,$42,$00,$00,$42,$3C,$00

; Tile 1
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $00,$00,$00,$00,$00,$00,$00,$00

; Fill rest with empty tiles
.res  8160               ; Rest of CHR-ROM (8192 - 32 = 8160 bytes)
