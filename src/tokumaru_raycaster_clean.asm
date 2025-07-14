;-------------------------------------------------------------------------------
; tokumaru_raycaster_01.nes disasembled by DISASM6 v1.5
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Registers
;-------------------------------------------------------------------------------
PPUCTRL              = $2000
PPUMASK              = $2001
PPUSTATUS            = $2002
OAMADDR              = $2003
OAMDATA              = $2004
PPUSCROLL            = $2005
PPUADDR              = $2006
PPUDATA              = $2007
SQ1_VOL              = $4000
SQ1_SWEEP            = $4001
SQ1_LO               = $4002
SQ1_HI               = $4003
SQ2_VOL              = $4004
SQ2_SWEEP            = $4005
SQ2_LO               = $4006
SQ2_HI               = $4007
TRI_LINEAR           = $4008
TRI_LO               = $400A
TRI_HI               = $400B
NOISE_VOL            = $400C
NOISE_LO             = $400E
NOISE_HI             = $400F
DMC_FREQ             = $4010
DMC_RAW              = $4011
DMC_START            = $4012
DMC_LEN              = $4013
OAM_DMA              = $4014
SND_CHN              = $4015
JOY1                 = $4016
JOY2                 = $4017

;-------------------------------------------------------------------------------
; iNES Header
;-------------------------------------------------------------------------------
            .db "NES", $1A     ; Header
            .db 1              ; 1 x 16k PRG banks
            .db 0              ; 0 x 8k CHR banks
            .db %00100001      ; Mirroring: Vertical
                               ; SRAM: Not used
                               ; 512k Trainer: Not used
                               ; 4 Screen VRAM: Not used
                               ; Mapper: 2
            .db %00000000      ; RomType: NES
            .hex 00 00 00 00   ; iNES Tail
            .hex 00 00 00 00

;-------------------------------------------------------------------------------
; Program Origin
;-------------------------------------------------------------------------------
            .org $c000         ; Set program counter

;-------------------------------------------------------------------------------
; ROM Start
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; reset vector
;-------------------------------------------------------------------------------
reset:      sei                ; $c000: 78
            cld                ; $c001: d8
            ldx #$00           ; $c002: a2 00
            stx PPUCTRL        ; $c004: 8e 00 20
            stx PPUMASK        ; $c007: 8e 01 20
            dex                ; $c00a: ca
            txs                ; $c00b: 9a
            lda #$40           ; $c00c: a9 40
            sta JOY2           ; $c00e: 8d 17 40
            lda #$00           ; $c011: a9 00
            sta DMC_FREQ       ; $c013: 8d 10 40
            bit PPUSTATUS      ; $c016: 2c 02 20
__c019:     bit PPUSTATUS      ; $c019: 2c 02 20
            bpl __c019         ; $c01c: 10 fb
__c01e:     bit PPUSTATUS      ; $c01e: 2c 02 20
            bpl __c01e         ; $c021: 10 fb
            jsr __c046         ; $c023: 20 46 c0
            jsr __c047         ; $c026: 20 47 c0
            jmp __c25b         ; $c029: 4c 5b c2

;-------------------------------------------------------------------------------
; nmi vector
;-------------------------------------------------------------------------------
nmi:        bit $10            ; $c02c: 24 10
            bmi __c037         ; $c02e: 30 07
            bit $12            ; $c030: 24 12
            bpl __c03a         ; $c032: 10 06
            jmp ($0011)        ; $c034: 6c 11 00

;-------------------------------------------------------------------------------
__c037:     inc $10            ; $c037: e6 10
            rti                ; $c039: 40

;-------------------------------------------------------------------------------
__c03a:     pha                ; $c03a: 48
            txa                ; $c03b: 8a
            pha                ; $c03c: 48
            tya                ; $c03d: 98
            pha                ; $c03e: 48
            pla                ; $c03f: 68
            tay                ; $c040: a8
            pla                ; $c041: 68
            tax                ; $c042: aa
            pla                ; $c043: 68
            rti                ; $c044: 40

;-------------------------------------------------------------------------------
; irq/brk vector
;-------------------------------------------------------------------------------
irq:        rti                ; $c045: 40

;-------------------------------------------------------------------------------
__c046:     rts                ; $c046: 60

;-------------------------------------------------------------------------------
__c047:     lda #$00           ; $c047: a9 00
            sta $10            ; $c049: 85 10
            sta $12            ; $c04b: 85 12
            ldx #$00           ; $c04d: a2 00
            stx $18            ; $c04f: 86 18
            stx $17            ; $c051: 86 17
            lda __cde6,x       ; $c053: bd e6 cd
            and #$0f           ; $c056: 29 0f
            sta $19            ; $c058: 85 19
            lda __cde6,x       ; $c05a: bd e6 cd
            and #$f0           ; $c05d: 29 f0
            sta $1a            ; $c05f: 85 1a
            lda #$a8           ; $c061: a9 a8
            sta PPUCTRL        ; $c063: 8d 00 20
            lda #$06           ; $c066: a9 06
            sta PPUMASK        ; $c068: 8d 01 20
            rts                ; $c06b: 60

;-------------------------------------------------------------------------------
            dec $10            ; $c06c: c6 10
__c06e:     bit $10            ; $c06e: 24 10
            bmi __c06e         ; $c070: 30 fc
            rts                ; $c072: 60

;-------------------------------------------------------------------------------
__c073:     lda $17            ; $c073: a5 17
            cmp $18            ; $c075: c5 18
            beq __c0a8         ; $c077: f0 2f
            dec $18            ; $c079: c6 18
            lda $18            ; $c07b: a5 18
            and #$07           ; $c07d: 29 07
            bne __c0a7         ; $c07f: d0 26
            lda $18            ; $c081: a5 18
            bcs __c087         ; $c083: b0 02
            adc #$11           ; $c085: 69 11
__c087:     sbc #$08           ; $c087: e9 08
            sta $18            ; $c089: 85 18
            lda $17            ; $c08b: a5 17
            and #$07           ; $c08d: 29 07
            ora $18            ; $c08f: 05 18
            sta $18            ; $c091: 85 18
            lsr                ; $c093: 4a
            lsr                ; $c094: 4a
            lsr                ; $c095: 4a
            tax                ; $c096: aa
            lda __cde6,x       ; $c097: bd e6 cd
            and #$0f           ; $c09a: 29 0f
            sta $19            ; $c09c: 85 19
            lda __cde6,x       ; $c09e: bd e6 cd
            and #$f0           ; $c0a1: 29 f0
            sta $1a            ; $c0a3: 85 1a
            clc                ; $c0a5: 18
            rts                ; $c0a6: 60

;-------------------------------------------------------------------------------
__c0a7:     sec                ; $c0a7: 38
__c0a8:     rts                ; $c0a8: 60

;-------------------------------------------------------------------------------
__c0a9:     lda #$a8           ; $c0a9: a9 a8
            sta PPUCTRL        ; $c0ab: 8d 00 20
            lda #$04           ; $c0ae: a9 04
            sta PPUADDR        ; $c0b0: 8d 06 20
            lda #$00           ; $c0b3: a9 00
            sta PPUADDR        ; $c0b5: 8d 06 20
            lda #$40           ; $c0b8: a9 40
__c0ba:     sta $23            ; $c0ba: 85 23
            ldx #$04           ; $c0bc: a2 04
            ldy #$00           ; $c0be: a0 00
            sty $27            ; $c0c0: 84 27
            beq __c0c6         ; $c0c2: f0 02
__c0c4:     dex                ; $c0c4: ca
            iny                ; $c0c5: c8
__c0c6:     asl                ; $c0c6: 0a
            bcs __c0c4         ; $c0c7: b0 fb
            stx $25            ; $c0c9: 86 25
            sty $26            ; $c0cb: 84 26
            asl                ; $c0cd: 0a
            php                ; $c0ce: 08
            asl                ; $c0cf: 0a
            sta $28            ; $c0d0: 85 28
            lda #$ff           ; $c0d2: a9 ff
            adc #$00           ; $c0d4: 69 00
            eor #$ff           ; $c0d6: 49 ff
            sta $24            ; $c0d8: 85 24
            asl $28            ; $c0da: 06 28
            rol $27            ; $c0dc: 26 27
            ldy #$07           ; $c0de: a0 07
            plp                ; $c0e0: 28
            bcc __c126         ; $c0e1: 90 43
__c0e3:     asl $28            ; $c0e3: 06 28
            lda $27            ; $c0e5: a5 27
            rol                ; $c0e7: 2a
            tax                ; $c0e8: aa
            lda $24            ; $c0e9: a5 24
            and __ce31,x       ; $c0eb: 3d 31 ce
            sta PPUDATA        ; $c0ee: 8d 07 20
            lda __ce31,x       ; $c0f1: bd 31 ce
            sta $001b,y        ; $c0f4: 99 1b 00
            dey                ; $c0f7: 88
            lda $24            ; $c0f8: a5 24
            and __ce35,x       ; $c0fa: 3d 35 ce
            sta PPUDATA        ; $c0fd: 8d 07 20
            lda __ce35,x       ; $c100: bd 35 ce
            sta $001b,y        ; $c103: 99 1b 00
            dey                ; $c106: 88
            dec $25            ; $c107: c6 25
            bne __c0e3         ; $c109: d0 d8
__c10b:     dec $26            ; $c10b: c6 26
            bmi __c16d         ; $c10d: 30 5e
            lda $02            ; $c10f: a5 02
            sta PPUDATA        ; $c111: 8d 07 20
            lda #$00           ; $c114: a9 00
            sta $001b,y        ; $c116: 99 1b 00
            dey                ; $c119: 88
            sta $001b,y        ; $c11a: 99 1b 00
            lda $03            ; $c11d: a5 03
            sta PPUDATA        ; $c11f: 8d 07 20
            dey                ; $c122: 88
            jmp __c10b         ; $c123: 4c 0b c1

;-------------------------------------------------------------------------------
__c126:     lda $23            ; $c126: a5 23
            sta $28            ; $c128: 85 28
__c12a:     dec $26            ; $c12a: c6 26
            bmi __c145         ; $c12c: 30 17
            lda $00            ; $c12e: a5 00
            sta PPUDATA        ; $c130: 8d 07 20
            lda #$00           ; $c133: a9 00
            sta $001b,y        ; $c135: 99 1b 00
            dey                ; $c138: 88
            sta $001b,y        ; $c139: 99 1b 00
            lda $01            ; $c13c: a5 01
            sta PPUDATA        ; $c13e: 8d 07 20
            dey                ; $c141: 88
            jmp __c12a         ; $c142: 4c 2a c1

;-------------------------------------------------------------------------------
__c145:     lsr $28            ; $c145: 46 28
            lda $27            ; $c147: a5 27
            rol                ; $c149: 2a
            tax                ; $c14a: aa
            lda $24            ; $c14b: a5 24
            and __ce31,x       ; $c14d: 3d 31 ce
            sta PPUDATA        ; $c150: 8d 07 20
            lda __ce31,x       ; $c153: bd 31 ce
            sta $001b,y        ; $c156: 99 1b 00
            dey                ; $c159: 88
            lda $24            ; $c15a: a5 24
            and __ce35,x       ; $c15c: 3d 35 ce
            sta PPUDATA        ; $c15f: 8d 07 20
            lda __ce35,x       ; $c162: bd 35 ce
            sta $001b,y        ; $c165: 99 1b 00
            dey                ; $c168: 88
            dec $25            ; $c169: c6 25
            bne __c145         ; $c16b: d0 d8
__c16d:     ldy #$07           ; $c16d: a0 07
__c16f:     lda $001b,y        ; $c16f: b9 1b 00
            sta PPUDATA        ; $c172: 8d 07 20
            dey                ; $c175: 88
            bpl __c16f         ; $c176: 10 f7
            clc                ; $c178: 18
            lda $23            ; $c179: a5 23
            adc #$01           ; $c17b: 69 01
            cmp #$f0           ; $c17d: c9 f0
            beq __c184         ; $c17f: f0 03
            jmp __c0ba         ; $c181: 4c ba c0

;-------------------------------------------------------------------------------
__c184:     lda $00            ; $c184: a5 00
            ldx $01            ; $c186: a6 01
            ldy #$04           ; $c188: a0 04
__c18a:     sta PPUDATA        ; $c18a: 8d 07 20
            stx PPUDATA        ; $c18d: 8e 07 20
            dey                ; $c190: 88
            bne __c18a         ; $c191: d0 f7
            ldx #$08           ; $c193: a2 08
__c195:     sty PPUDATA        ; $c195: 8c 07 20
            dex                ; $c198: ca
            bne __c195         ; $c199: d0 fa
            lda $02            ; $c19b: a5 02
            ldx $03            ; $c19d: a6 03
            ldy #$04           ; $c19f: a0 04
__c1a1:     sta PPUDATA        ; $c1a1: 8d 07 20
            stx PPUDATA        ; $c1a4: 8e 07 20
            dey                ; $c1a7: 88
            bne __c1a1         ; $c1a8: d0 f7
            ldx #$08           ; $c1aa: a2 08
__c1ac:     sty PPUDATA        ; $c1ac: 8c 07 20
            dex                ; $c1af: ca
            bne __c1ac         ; $c1b0: d0 fa
            lda #$03           ; $c1b2: a9 03
            sta $26            ; $c1b4: 85 26
            lda #$01           ; $c1b6: a9 01
            sta $25            ; $c1b8: 85 25
__c1ba:     ldy $26            ; $c1ba: a4 26
            lda $00            ; $c1bc: a5 00
            ldx $01            ; $c1be: a6 01
__c1c0:     sta PPUDATA        ; $c1c0: 8d 07 20
            stx PPUDATA        ; $c1c3: 8e 07 20
            dey                ; $c1c6: 88
            bne __c1c0         ; $c1c7: d0 f7
            ldy $25            ; $c1c9: a4 25
            lda #$00           ; $c1cb: a9 00
__c1cd:     sta PPUDATA        ; $c1cd: 8d 07 20
            sta PPUDATA        ; $c1d0: 8d 07 20
            dey                ; $c1d3: 88
            bne __c1cd         ; $c1d4: d0 f7
            ldx #$08           ; $c1d6: a2 08
__c1d8:     sty PPUDATA        ; $c1d8: 8c 07 20
            dex                ; $c1db: ca
            bne __c1d8         ; $c1dc: d0 fa
            inc $25            ; $c1de: e6 25
            dec $26            ; $c1e0: c6 26
            bne __c1ba         ; $c1e2: d0 d6
            lda #$03           ; $c1e4: a9 03
            sta $26            ; $c1e6: 85 26
            lda #$01           ; $c1e8: a9 01
            sta $25            ; $c1ea: 85 25
__c1ec:     ldy $25            ; $c1ec: a4 25
            lda #$00           ; $c1ee: a9 00
__c1f0:     sta PPUDATA        ; $c1f0: 8d 07 20
            sta PPUDATA        ; $c1f3: 8d 07 20
            dey                ; $c1f6: 88
            bne __c1f0         ; $c1f7: d0 f7
            ldy $26            ; $c1f9: a4 26
            lda $02            ; $c1fb: a5 02
            ldx $03            ; $c1fd: a6 03
__c1ff:     sta PPUDATA        ; $c1ff: 8d 07 20
            stx PPUDATA        ; $c202: 8e 07 20
            dey                ; $c205: 88
            bne __c1ff         ; $c206: d0 f7
            ldx #$08           ; $c208: a2 08
__c20a:     sty PPUDATA        ; $c20a: 8c 07 20
            dex                ; $c20d: ca
            bne __c20a         ; $c20e: d0 fa
            inc $25            ; $c210: e6 25
            dec $26            ; $c212: c6 26
            bne __c1ec         ; $c214: d0 d6
            rts                ; $c216: 60

;-------------------------------------------------------------------------------
__c217:     lda #$00           ; $c217: a9 00
            sta $13            ; $c219: 85 13
            sta $14            ; $c21b: 85 14
            sta $15            ; $c21d: 85 15
            sta $16            ; $c21f: 85 16
            rts                ; $c221: 60

;-------------------------------------------------------------------------------
__c222:     lda $13            ; $c222: a5 13
            eor #$ff           ; $c224: 49 ff
            sta $15            ; $c226: 85 15
            lda $14            ; $c228: a5 14
            eor #$ff           ; $c22a: 49 ff
            sta $16            ; $c22c: 85 16
            lda #$01           ; $c22e: a9 01
            sta JOY1           ; $c230: 8d 16 40
            lsr                ; $c233: 4a
            sta JOY1           ; $c234: 8d 16 40
            ldx #$07           ; $c237: a2 07
__c239:     lda JOY1           ; $c239: ad 16 40
            and #$03           ; $c23c: 29 03
            cmp #$01           ; $c23e: c9 01
            rol $13            ; $c240: 26 13
            lda JOY2           ; $c242: ad 17 40
            and #$03           ; $c245: 29 03
            cmp #$01           ; $c247: c9 01
            rol $14            ; $c249: 26 14
            dex                ; $c24b: ca
            bpl __c239         ; $c24c: 10 eb
            lda $13            ; $c24e: a5 13
            and $15            ; $c250: 25 15
            sta $15            ; $c252: 85 15
            lda $14            ; $c254: a5 14
            and $16            ; $c256: 25 16
            sta $16            ; $c258: 85 16
            rts                ; $c25a: 60

;-------------------------------------------------------------------------------
__c25b:     jsr __c217         ; $c25b: 20 17 c2
            ldx #$00           ; $c25e: a2 00
            stx PPUADDR        ; $c260: 8e 06 20
            stx PPUADDR        ; $c263: 8e 06 20
            ldy #$30           ; $c266: a0 30
            txa                ; $c268: 8a
__c269:     sta PPUDATA        ; $c269: 8d 07 20
            dex                ; $c26c: ca
            bne __c269         ; $c26d: d0 fa
            dey                ; $c26f: 88
            bne __c269         ; $c270: d0 f7
            lda #$ff           ; $c272: a9 ff
            sta $00            ; $c274: 85 00
            lda #$ff           ; $c276: a9 ff
            sta $01            ; $c278: 85 01
            lda #$33           ; $c27a: a9 33
            sta $02            ; $c27c: 85 02
            lda #$cc           ; $c27e: a9 cc
            sta $03            ; $c280: 85 03
            jsr __c0a9         ; $c282: 20 a9 c0
            lda #$10           ; $c285: a9 10
            sta $1c            ; $c287: 85 1c
            lda #$f9           ; $c289: a9 f9
            sta $0300          ; $c28b: 8d 00 03
            lda #$c9           ; $c28e: a9 c9
            sta $0380          ; $c290: 8d 80 03
            ldy #$10           ; $c293: a0 10
            ldx #$00           ; $c295: a2 00
__c297:     clc                ; $c297: 18
            tya                ; $c298: 98
            adc $0300,x        ; $c299: 7d 00 03
            sta $0301,x        ; $c29c: 9d 01 03
            lda $0380,x        ; $c29f: bd 80 03
            adc #$00           ; $c2a2: 69 00
            sta $0381,x        ; $c2a4: 9d 81 03
            inx                ; $c2a7: e8
            cpx #$7f           ; $c2a8: e0 7f
            bne __c297         ; $c2aa: d0 eb
            lda #$20           ; $c2ac: a9 20
            sta $1d            ; $c2ae: 85 1d
            sta $1f            ; $c2b0: 85 1f
            lda #$06           ; $c2b2: a9 06
            sta $1e            ; $c2b4: 85 1e
            sta $20            ; $c2b6: 85 20
            lda #$00           ; $c2b8: a9 00
            sta $21            ; $c2ba: 85 21
            lda #$a8           ; $c2bc: a9 a8
            sta $1b            ; $c2be: 85 1b
            lda #$00           ; $c2c0: a9 00
            sta $2e            ; $c2c2: 85 2e
            sta $2d            ; $c2c4: 85 2d
            lda #$35           ; $c2c6: a9 35
            sta $11            ; $c2c8: 85 11
            lda #$cb           ; $c2ca: a9 cb
            sta $12            ; $c2cc: 85 12
__c2ce:     jsr __c222         ; $c2ce: 20 22 c2
            lda $13            ; $c2d1: a5 13
            and #$02           ; $c2d3: 29 02
            beq __c2e3         ; $c2d5: f0 0c
            ldx $21            ; $c2d7: a6 21
            dex                ; $c2d9: ca
            dex                ; $c2da: ca
            cpx #$fe           ; $c2db: e0 fe
            bne __c2e1         ; $c2dd: d0 02
            ldx #$a6           ; $c2df: a2 a6
__c2e1:     stx $21            ; $c2e1: 86 21
__c2e3:     lda $13            ; $c2e3: a5 13
            and #$01           ; $c2e5: 29 01
            beq __c2f5         ; $c2e7: f0 0c
            ldx $21            ; $c2e9: a6 21
            inx                ; $c2eb: e8
            inx                ; $c2ec: e8
            cpx #$a8           ; $c2ed: e0 a8
            bne __c2f3         ; $c2ef: d0 02
            ldx #$00           ; $c2f1: a2 00
__c2f3:     stx $21            ; $c2f3: 86 21
__c2f5:     lda $13            ; $c2f5: a5 13
            and #$0c           ; $c2f7: 29 0c
            bne __c2fe         ; $c2f9: d0 03
            jmp __c444         ; $c2fb: 4c 44 c4

;-------------------------------------------------------------------------------
__c2fe:     ldx $21            ; $c2fe: a6 21
            lda __d650,x       ; $c300: bd 50 d6
            sta $00            ; $c303: 85 00
            lda __d6f8,x       ; $c305: bd f8 d6
            cmp #$80           ; $c308: c9 80
            ror                ; $c30a: 6a
            ror $00            ; $c30b: 66 00
            cmp #$80           ; $c30d: c9 80
            ror                ; $c30f: 6a
            ror $00            ; $c310: 66 00
            sta $01            ; $c312: 85 01
            lda $13            ; $c314: a5 13
            and #$08           ; $c316: 29 08
            bne __c32b         ; $c318: d0 11
            clc                ; $c31a: 18
            lda $00            ; $c31b: a5 00
            eor #$ff           ; $c31d: 49 ff
            adc #$01           ; $c31f: 69 01
            sta $00            ; $c321: 85 00
            lda $01            ; $c323: a5 01
            eor #$ff           ; $c325: 49 ff
            adc #$00           ; $c327: 69 00
            sta $01            ; $c329: 85 01
__c32b:     clc                ; $c32b: 18
            lda $1f            ; $c32c: a5 1f
            adc $00            ; $c32e: 65 00
            sta $1f            ; $c330: 85 1f
            lda $20            ; $c332: a5 20
            adc $01            ; $c334: 65 01
            sta $20            ; $c336: 85 20
            lda #$80           ; $c338: a9 80
            ldy #$00           ; $c33a: a0 00
            bit $01            ; $c33c: 24 01
            bpl __c344         ; $c33e: 10 04
            lda #$80           ; $c340: a9 80
            ldy #$ff           ; $c342: a0 ff
__c344:     clc                ; $c344: 18
            adc $1f            ; $c345: 65 1f
            tya                ; $c347: 98
            adc $20            ; $c348: 65 20
            lsr                ; $c34a: 4a
            sta $03            ; $c34b: 85 03
            tay                ; $c34d: a8
            lda $0300,y        ; $c34e: b9 00 03
            sta $57            ; $c351: 85 57
            lda $0380,y        ; $c353: b9 80 03
            sta $58            ; $c356: 85 58
            sec                ; $c358: 38
            lda $1d            ; $c359: a5 1d
            sbc #$80           ; $c35b: e9 80
            lda $1e            ; $c35d: a5 1e
            sbc #$00           ; $c35f: e9 00
            lsr                ; $c361: 4a
            tay                ; $c362: a8
            lda ($57),y        ; $c363: b1 57
            bmi __c376         ; $c365: 30 0f
            clc                ; $c367: 18
            lda $1d            ; $c368: a5 1d
            adc #$80           ; $c36a: 69 80
            lda $1e            ; $c36c: a5 1e
            adc #$00           ; $c36e: 69 00
            lsr                ; $c370: 4a
            tay                ; $c371: a8
            lda ($57),y        ; $c372: b1 57
            bpl __c396         ; $c374: 10 20
__c376:     bit $01            ; $c376: 24 01
            bpl __c389         ; $c378: 10 0f
            lda #$81           ; $c37a: a9 81
            sta $1f            ; $c37c: 85 1f
            clc                ; $c37e: 18
            lda $03            ; $c37f: a5 03
            adc #$01           ; $c381: 69 01
            asl                ; $c383: 0a
            sta $20            ; $c384: 85 20
            jmp __c396         ; $c386: 4c 96 c3

;-------------------------------------------------------------------------------
__c389:     lda #$7f           ; $c389: a9 7f
            sta $1f            ; $c38b: 85 1f
            sec                ; $c38d: 38
            lda $03            ; $c38e: a5 03
            sbc #$01           ; $c390: e9 01
            sec                ; $c392: 38
            rol                ; $c393: 2a
            sta $20            ; $c394: 85 20
__c396:     clc                ; $c396: 18
            txa                ; $c397: 8a
            adc #$2a           ; $c398: 69 2a
            cmp #$a8           ; $c39a: c9 a8
            bcc __c3a0         ; $c39c: 90 02
            sbc #$a8           ; $c39e: e9 a8
__c3a0:     tax                ; $c3a0: aa
            lda __d650,x       ; $c3a1: bd 50 d6
            sta $00            ; $c3a4: 85 00
            lda __d6f8,x       ; $c3a6: bd f8 d6
            cmp #$80           ; $c3a9: c9 80
            ror                ; $c3ab: 6a
            ror $00            ; $c3ac: 66 00
            cmp #$80           ; $c3ae: c9 80
            ror                ; $c3b0: 6a
            ror $00            ; $c3b1: 66 00
            sta $01            ; $c3b3: 85 01
            lda $13            ; $c3b5: a5 13
            and #$08           ; $c3b7: 29 08
            bne __c3cc         ; $c3b9: d0 11
            clc                ; $c3bb: 18
            lda $00            ; $c3bc: a5 00
            eor #$ff           ; $c3be: 49 ff
            adc #$01           ; $c3c0: 69 01
            sta $00            ; $c3c2: 85 00
            lda $01            ; $c3c4: a5 01
            eor #$ff           ; $c3c6: 49 ff
            adc #$00           ; $c3c8: 69 00
            sta $01            ; $c3ca: 85 01
__c3cc:     clc                ; $c3cc: 18
            lda $1d            ; $c3cd: a5 1d
            adc $00            ; $c3cf: 65 00
            sta $1d            ; $c3d1: 85 1d
            lda $1e            ; $c3d3: a5 1e
            adc $01            ; $c3d5: 65 01
            sta $1e            ; $c3d7: 85 1e
            lda #$80           ; $c3d9: a9 80
            ldy #$00           ; $c3db: a0 00
            bit $01            ; $c3dd: 24 01
            bpl __c3e5         ; $c3df: 10 04
            lda #$80           ; $c3e1: a9 80
            ldy #$ff           ; $c3e3: a0 ff
__c3e5:     clc                ; $c3e5: 18
            adc $1d            ; $c3e6: 65 1d
            tya                ; $c3e8: 98
            adc $1e            ; $c3e9: 65 1e
            lsr                ; $c3eb: 4a
            sta $03            ; $c3ec: 85 03
            sec                ; $c3ee: 38
            lda $1f            ; $c3ef: a5 1f
            sbc #$80           ; $c3f1: e9 80
            lda $20            ; $c3f3: a5 20
            sbc #$00           ; $c3f5: e9 00
            lsr                ; $c3f7: 4a
            tay                ; $c3f8: a8
            lda $0300,y        ; $c3f9: b9 00 03
            sta $57            ; $c3fc: 85 57
            lda $0380,y        ; $c3fe: b9 80 03
            sta $58            ; $c401: 85 58
            ldy $03            ; $c403: a4 03
            lda ($57),y        ; $c405: b1 57
            bmi __c424         ; $c407: 30 1b
            clc                ; $c409: 18
            lda $1f            ; $c40a: a5 1f
            adc #$80           ; $c40c: 69 80
            lda $20            ; $c40e: a5 20
            adc #$00           ; $c410: 69 00
            lsr                ; $c412: 4a
            tay                ; $c413: a8
            lda $0300,y        ; $c414: b9 00 03
            sta $57            ; $c417: 85 57
            lda $0380,y        ; $c419: b9 80 03
            sta $58            ; $c41c: 85 58
            ldy $03            ; $c41e: a4 03
            lda ($57),y        ; $c420: b1 57
            bpl __c444         ; $c422: 10 20
__c424:     bit $01            ; $c424: 24 01
            bpl __c437         ; $c426: 10 0f
            lda #$81           ; $c428: a9 81
            sta $1d            ; $c42a: 85 1d
            clc                ; $c42c: 18
            lda $03            ; $c42d: a5 03
            adc #$01           ; $c42f: 69 01
            asl                ; $c431: 0a
            sta $1e            ; $c432: 85 1e
            jmp __c444         ; $c434: 4c 44 c4

;-------------------------------------------------------------------------------
__c437:     lda #$7f           ; $c437: a9 7f
            sta $1d            ; $c439: 85 1d
            sec                ; $c43b: 38
            lda $03            ; $c43c: a5 03
            sbc #$01           ; $c43e: e9 01
            sec                ; $c440: 38
            rol                ; $c441: 2a
            sta $1e            ; $c442: 85 1e
__c444:     sec                ; $c444: 38
            lda $21            ; $c445: a5 21
            sbc #$0e           ; $c447: e9 0e
            bcs __c44d         ; $c449: b0 02
            adc #$a8           ; $c44b: 69 a8
__c44d:     sta $2a            ; $c44d: 85 2a
            adc #$29           ; $c44f: 69 29
            cmp #$a8           ; $c451: c9 a8
            bcc __c457         ; $c453: 90 02
            sbc #$a8           ; $c455: e9 a8
__c457:     sta $29            ; $c457: 85 29
__c459:     lda $2d            ; $c459: a5 2d
            bmi __c459         ; $c45b: 30 fc
            lda #$8f           ; $c45d: a9 8f
            sta $22            ; $c45f: 85 22
            sta $23            ; $c461: 85 23
            sta $24            ; $c463: 85 24
            lda #$00           ; $c465: a9 00
            sta $27            ; $c467: 85 27
            lda $1b            ; $c469: a5 1b
            and #$03           ; $c46b: 29 03
            asl                ; $c46d: 0a
            asl                ; $c46e: 0a
            ora #$20           ; $c46f: 09 20
            sta $28            ; $c471: 85 28
            lda #$00           ; $c473: a9 00
            sta $2b            ; $c475: 85 2b
            sta $2c            ; $c477: 85 2c
            ldx #$00           ; $c479: a2 00
__c47b:     lda __d3cd,x       ; $c47b: bd cd d3
            sta $38            ; $c47e: 85 38
            lda __d3e9,x       ; $c480: bd e9 d3
            sta $39            ; $c483: 85 39
            ldy $29            ; $c485: a4 29
            lda __ce39,y       ; $c487: b9 39 ce
            sta $3a            ; $c48a: 85 3a
            asl                ; $c48c: 0a
            tay                ; $c48d: a8
            lda ($38),y        ; $c48e: b1 38
            sta $3c            ; $c490: 85 3c
            lda __d379,y       ; $c492: b9 79 d3
            sta $40            ; $c495: 85 40
            iny                ; $c497: c8
            lda ($38),y        ; $c498: b1 38
            sta $3d            ; $c49a: 85 3d
            lda __d379,y       ; $c49c: b9 79 d3
            sta $41            ; $c49f: 85 41
            ldy $2a            ; $c4a1: a4 2a
            lda __ce39,y       ; $c4a3: b9 39 ce
            sta $3b            ; $c4a6: 85 3b
            asl                ; $c4a8: 0a
            tay                ; $c4a9: a8
            lda ($38),y        ; $c4aa: b1 38
            sta $3e            ; $c4ac: 85 3e
            lda __d379,y       ; $c4ae: b9 79 d3
            sta $42            ; $c4b1: 85 42
            iny                ; $c4b3: c8
            lda ($38),y        ; $c4b4: b1 38
            sta $3f            ; $c4b6: 85 3f
            lda __d379,y       ; $c4b8: b9 79 d3
            sta $43            ; $c4bb: 85 43
            lda $1e            ; $c4bd: a5 1e
            lsr                ; $c4bf: 4a
            lda $1d            ; $c4c0: a5 1d
            ror                ; $c4c2: 6a
            lsr                ; $c4c3: 4a
            bit $3a            ; $c4c4: 24 3a
            bpl __c4d0         ; $c4c6: 10 08
            eor #$80           ; $c4c8: 49 80
            ldy #$ff           ; $c4ca: a0 ff
            sty $44            ; $c4cc: 84 44
            bne __c4d7         ; $c4ce: d0 07
__c4d0:     eor #$ff           ; $c4d0: 49 ff
            ldy #$01           ; $c4d2: a0 01
            sty $44            ; $c4d4: 84 44
            dey                ; $c4d6: 88
__c4d7:     sty $46            ; $c4d7: 84 46
            sta $4b            ; $c4d9: 85 4b
            sta $48            ; $c4db: 85 48
            lda #$00           ; $c4dd: a9 00
            sta $4d            ; $c4df: 85 4d
            lsr $48            ; $c4e1: 46 48
            bcc __c4f0         ; $c4e3: 90 0b
__c4e5:     tay                ; $c4e5: a8
            clc                ; $c4e6: 18
            lda $4d            ; $c4e7: a5 4d
            adc $3c            ; $c4e9: 65 3c
            sta $4d            ; $c4eb: 85 4d
            tya                ; $c4ed: 98
            adc $3d            ; $c4ee: 65 3d
__c4f0:     ror                ; $c4f0: 6a
            ror $4d            ; $c4f1: 66 4d
            lsr $48            ; $c4f3: 46 48
            beq __c4fb         ; $c4f5: f0 04
            bcs __c4e5         ; $c4f7: b0 ec
            bcc __c4f0         ; $c4f9: 90 f5
__c4fb:     sta $4e            ; $c4fb: 85 4e
            lda $20            ; $c4fd: a5 20
            lsr                ; $c4ff: 4a
            lda $1f            ; $c500: a5 1f
            ror                ; $c502: 6a
            lsr                ; $c503: 4a
            bit $3b            ; $c504: 24 3b
            bpl __c512         ; $c506: 10 0a
            eor #$80           ; $c508: 49 80
            ldy #$fe           ; $c50a: a0 fe
            sty $45            ; $c50c: 84 45
            ldy #$00           ; $c50e: a0 00
            beq __c519         ; $c510: f0 07
__c512:     eor #$ff           ; $c512: 49 ff
            ldy #$00           ; $c514: a0 00
            sty $45            ; $c516: 84 45
            dey                ; $c518: 88
__c519:     sty $47            ; $c519: 84 47
            sta $4c            ; $c51b: 85 4c
            sta $48            ; $c51d: 85 48
            lda #$00           ; $c51f: a9 00
            sta $4f            ; $c521: 85 4f
            lsr $48            ; $c523: 46 48
            bcc __c532         ; $c525: 90 0b
__c527:     tay                ; $c527: a8
            clc                ; $c528: 18
            lda $4f            ; $c529: a5 4f
            adc $3e            ; $c52b: 65 3e
            sta $4f            ; $c52d: 85 4f
            tya                ; $c52f: 98
            adc $3f            ; $c530: 65 3f
__c532:     ror                ; $c532: 6a
            ror $4f            ; $c533: 66 4f
            lsr $48            ; $c535: 46 48
            beq __c53d         ; $c537: f0 04
            bcs __c527         ; $c539: b0 ec
            bcc __c532         ; $c53b: 90 f5
__c53d:     sta $50            ; $c53d: 85 50
            lda $1e            ; $c53f: a5 1e
            lsr                ; $c541: 4a
            sta $55            ; $c542: 85 55
            lda $20            ; $c544: a5 20
            lsr                ; $c546: 4a
            sta $56            ; $c547: 85 56
            tay                ; $c549: a8
            lda $0300,y        ; $c54a: b9 00 03
            sta $57            ; $c54d: 85 57
            lda $0380,y        ; $c54f: b9 80 03
            sta $58            ; $c552: 85 58
            lda #$00           ; $c554: a9 00
            sta $49            ; $c556: 85 49
            sta $4a            ; $c558: 85 4a
__c55a:     lda $4d            ; $c55a: a5 4d
            cmp $4f            ; $c55c: c5 4f
            lda $4e            ; $c55e: a5 4e
            sbc $50            ; $c560: e5 50
            bcs __c581         ; $c562: b0 1d
            lda $55            ; $c564: a5 55
            adc $44            ; $c566: 65 44
            sta $55            ; $c568: 85 55
            tay                ; $c56a: a8
            lda ($57),y        ; $c56b: b1 57
            bmi __c5ad         ; $c56d: 30 3e
            inc $49            ; $c56f: e6 49
            clc                ; $c571: 18
            lda $4d            ; $c572: a5 4d
            adc $3c            ; $c574: 65 3c
            sta $4d            ; $c576: 85 4d
            lda $4e            ; $c578: a5 4e
            adc $3d            ; $c57a: 65 3d
            sta $4e            ; $c57c: 85 4e
            jmp __c55a         ; $c57e: 4c 5a c5

;-------------------------------------------------------------------------------
__c581:     lda $56            ; $c581: a5 56
            adc $45            ; $c583: 65 45
            sta $56            ; $c585: 85 56
            tay                ; $c587: a8
            lda $0300,y        ; $c588: b9 00 03
            sta $57            ; $c58b: 85 57
            lda $0380,y        ; $c58d: b9 80 03
            sta $58            ; $c590: 85 58
            ldy $55            ; $c592: a4 55
            lda ($57),y        ; $c594: b1 57
            bmi __c5aa         ; $c596: 30 12
            inc $4a            ; $c598: e6 4a
            clc                ; $c59a: 18
            lda $4f            ; $c59b: a5 4f
            adc $3e            ; $c59d: 65 3e
            sta $4f            ; $c59f: 85 4f
            lda $50            ; $c5a1: a5 50
            adc $3f            ; $c5a3: 65 3f
            sta $50            ; $c5a5: 85 50
            jmp __c55a         ; $c5a7: 4c 5a c5

;-------------------------------------------------------------------------------
__c5aa:     .hex 4c 2d         ; $c5aa: 4c 2d     Suspected data
__c5ac:     .hex c6            ; $c5ac: c6        Suspected data
__c5ad:     cmp #$ff           ; $c5ad: c9 ff
            bne __c5b3         ; $c5af: d0 02
            lda #$00           ; $c5b1: a9 00
__c5b3:     sta $0138,x        ; $c5b3: 9d 38 01
            lda $4d            ; $c5b6: a5 4d
            sta $0100,x        ; $c5b8: 9d 00 01
            lda $4e            ; $c5bb: a5 4e
            sta $011c,x        ; $c5bd: 9d 1c 01
            lda #$00           ; $c5c0: a9 00
            sta $51            ; $c5c2: 85 51
            lsr $4b            ; $c5c4: 46 4b
            bcc __c5d3         ; $c5c6: 90 0b
__c5c8:     tay                ; $c5c8: a8
            clc                ; $c5c9: 18
            lda $51            ; $c5ca: a5 51
            adc $40            ; $c5cc: 65 40
            sta $51            ; $c5ce: 85 51
            tya                ; $c5d0: 98
            adc $41            ; $c5d1: 65 41
__c5d3:     ror                ; $c5d3: 6a
            ror $51            ; $c5d4: 66 51
            lsr $4b            ; $c5d6: 46 4b
            beq __c5de         ; $c5d8: f0 04
            bcs __c5c8         ; $c5da: b0 ec
            bcc __c5d3         ; $c5dc: 90 f5
__c5de:     sta $52            ; $c5de: 85 52
            ldy $49            ; $c5e0: a4 49
            beq __c5f4         ; $c5e2: f0 10
__c5e4:     clc                ; $c5e4: 18
            lda $51            ; $c5e5: a5 51
            adc $40            ; $c5e7: 65 40
            sta $51            ; $c5e9: 85 51
            lda $52            ; $c5eb: a5 52
            adc $41            ; $c5ed: 65 41
            sta $52            ; $c5ef: 85 52
            dey                ; $c5f1: 88
            bne __c5e4         ; $c5f2: d0 f0
__c5f4:     bit $3b            ; $c5f4: 24 3b
            bmi __c606         ; $c5f6: 30 0e
            clc                ; $c5f8: 18
            lda $1f            ; $c5f9: a5 1f
            adc $51            ; $c5fb: 65 51
            sta $51            ; $c5fd: 85 51
            lda $20            ; $c5ff: a5 20
            adc $52            ; $c601: 65 52
            jmp __c611         ; $c603: 4c 11 c6

;-------------------------------------------------------------------------------
__c606:     sec                ; $c606: 38
            lda $1f            ; $c607: a5 1f
            sbc $51            ; $c609: e5 51
            sta $51            ; $c60b: 85 51
            lda $20            ; $c60d: a5 20
            sbc $52            ; $c60f: e5 52
__c611:     lsr                ; $c611: 4a
            ror $51            ; $c612: 66 51
            cmp $56            ; $c614: c5 56
            beq __c61f         ; $c616: f0 07
            lda $51            ; $c618: a5 51
            eor #$ff           ; $c61a: 49 ff
            jmp __c621         ; $c61c: 4c 21 c6

;-------------------------------------------------------------------------------
__c61f:     lda $51            ; $c61f: a5 51
__c621:     eor $46            ; $c621: 45 46
            lsr                ; $c623: 4a
            lsr                ; $c624: 4a
            lsr                ; $c625: 4a
            lsr                ; $c626: 4a
            lsr                ; $c627: 4a
            sta $0154,x        ; $c628: 9d 54 01
            bpl __c5ac         ; $c62b: 10 7f
            cmp #$ff           ; $c62d: c9 ff
            bne __c633         ; $c62f: d0 02
            lda #$00           ; $c631: a9 00
__c633:     sta $0138,x        ; $c633: 9d 38 01
            lda $4f            ; $c636: a5 4f
            sta $0100,x        ; $c638: 9d 00 01
            lda $50            ; $c63b: a5 50
            sta $011c,x        ; $c63d: 9d 1c 01
            lda #$00           ; $c640: a9 00
            sta $53            ; $c642: 85 53
            lsr $4c            ; $c644: 46 4c
            bcc __c653         ; $c646: 90 0b
__c648:     tay                ; $c648: a8
            clc                ; $c649: 18
            lda $53            ; $c64a: a5 53
            adc $42            ; $c64c: 65 42
            sta $53            ; $c64e: 85 53
            tya                ; $c650: 98
            adc $43            ; $c651: 65 43
__c653:     ror                ; $c653: 6a
            ror $53            ; $c654: 66 53
            lsr $4c            ; $c656: 46 4c
            beq __c65e         ; $c658: f0 04
            bcs __c648         ; $c65a: b0 ec
            bcc __c653         ; $c65c: 90 f5
__c65e:     sta $54            ; $c65e: 85 54
            ldy $4a            ; $c660: a4 4a
            beq __c674         ; $c662: f0 10
__c664:     clc                ; $c664: 18
            lda $53            ; $c665: a5 53
            adc $42            ; $c667: 65 42
            sta $53            ; $c669: 85 53
            lda $54            ; $c66b: a5 54
            adc $43            ; $c66d: 65 43
            sta $54            ; $c66f: 85 54
            dey                ; $c671: 88
            bne __c664         ; $c672: d0 f0
__c674:     bit $3a            ; $c674: 24 3a
            bmi __c686         ; $c676: 30 0e
            clc                ; $c678: 18
            lda $1d            ; $c679: a5 1d
            adc $53            ; $c67b: 65 53
            sta $53            ; $c67d: 85 53
            lda $1e            ; $c67f: a5 1e
            adc $54            ; $c681: 65 54
            jmp __c691         ; $c683: 4c 91 c6

;-------------------------------------------------------------------------------
__c686:     sec                ; $c686: 38
            lda $1d            ; $c687: a5 1d
            sbc $53            ; $c689: e5 53
            sta $53            ; $c68b: 85 53
            lda $1e            ; $c68d: a5 1e
            sbc $54            ; $c68f: e5 54
__c691:     lsr                ; $c691: 4a
            ror $53            ; $c692: 66 53
            cmp $55            ; $c694: c5 55
            beq __c69f         ; $c696: f0 07
            lda $53            ; $c698: a5 53
            eor #$ff           ; $c69a: 49 ff
            jmp __c6a1         ; $c69c: 4c a1 c6

;-------------------------------------------------------------------------------
__c69f:     lda $53            ; $c69f: a5 53
__c6a1:     eor $47            ; $c6a1: 45 47
            lsr                ; $c6a3: 4a
            lsr                ; $c6a4: 4a
            lsr                ; $c6a5: 4a
            lsr                ; $c6a6: 4a
            sec                ; $c6a7: 38
            ror                ; $c6a8: 6a
            sta $0154,x        ; $c6a9: 9d 54 01
            inx                ; $c6ac: e8
            txa                ; $c6ad: 8a
            and #$03           ; $c6ae: 29 03
            beq __c6cb         ; $c6b0: f0 19
__c6b2:     ldy $29            ; $c6b2: a4 29
            iny                ; $c6b4: c8
            cpy #$a8           ; $c6b5: c0 a8
            bne __c6bb         ; $c6b7: d0 02
            ldy #$00           ; $c6b9: a0 00
__c6bb:     sty $29            ; $c6bb: 84 29
            ldy $2a            ; $c6bd: a4 2a
            iny                ; $c6bf: c8
            cpy #$a8           ; $c6c0: c0 a8
            bne __c6c6         ; $c6c2: d0 02
            ldy #$00           ; $c6c4: a0 00
__c6c6:     sty $2a            ; $c6c6: 84 2a
            jmp __c47b         ; $c6c8: 4c 7b c4

;-------------------------------------------------------------------------------
__c6cb:     sec                ; $c6cb: 38
            txa                ; $c6cc: 8a
            sbc #$04           ; $c6cd: e9 04
            tax                ; $c6cf: aa
            lda #$04           ; $c6d0: a9 04
__c6d2:     cmp $2e            ; $c6d2: c5 2e
            beq __c6d2         ; $c6d4: f0 fc
            lda #$ff           ; $c6d6: a9 ff
            sta $30            ; $c6d8: 85 30
__c6da:     ldy $0138,x        ; $c6da: bc 38 01
            bne __c6e2         ; $c6dd: d0 03
            tya                ; $c6df: 98
            beq __c6e5         ; $c6e0: f0 03
__c6e2:     jsr __cdbe         ; $c6e2: 20 be cd
__c6e5:     asl                ; $c6e5: 0a
            asl                ; $c6e6: 0a
            sta $25            ; $c6e7: 85 25
            ldy $0139,x        ; $c6e9: bc 39 01
            bne __c6f1         ; $c6ec: d0 03
            tya                ; $c6ee: 98
            beq __c6f4         ; $c6ef: f0 03
__c6f1:     jsr __cdbe         ; $c6f1: 20 be cd
__c6f4:     ora $25            ; $c6f4: 05 25
            tay                ; $c6f6: a8
            lda __d605,y       ; $c6f7: b9 05 d6
            sta $25            ; $c6fa: 85 25
            bit $30            ; $c6fc: 24 30
            bpl __c704         ; $c6fe: 10 04
            and #$33           ; $c700: 29 33
            sta $30            ; $c702: 85 30
__c704:     lda #$fc           ; $c704: a9 fc
            asl $25            ; $c706: 06 25
            rol                ; $c708: 2a
            asl $0154,x        ; $c709: 1e 54 01
            rol                ; $c70c: 2a
            sta $59            ; $c70d: 85 59
            ldy #$00           ; $c70f: a0 00
            sty $5c            ; $c711: 84 5c
            dey                ; $c713: 88
            sty $5d            ; $c714: 84 5d
            clc                ; $c716: 18
            lda $5c            ; $c717: a5 5c
            adc $5d            ; $c719: 65 5d
            ror                ; $c71b: 6a
            tay                ; $c71c: a8
            lda $0100,x        ; $c71d: bd 00 01
            cmp __d405,y       ; $c720: d9 05 d4
            lda $011c,x        ; $c723: bd 1c 01
            sbc __d505,y       ; $c726: f9 05 d5
            bcc __c730         ; $c729: 90 05
            sty $5d            ; $c72b: 84 5d
            clc                ; $c72d: 18
            bcc __c733         ; $c72e: 90 03
__c730:     iny                ; $c730: c8
            sty $5c            ; $c731: 84 5c
__c733:     lda $5c            ; $c733: a5 5c
            adc $5d            ; $c735: 65 5d
            ror                ; $c737: 6a
            tay                ; $c738: a8
            lda $0100,x        ; $c739: bd 00 01
            cmp __d405,y       ; $c73c: d9 05 d4
            lda $011c,x        ; $c73f: bd 1c 01
            sbc __d505,y       ; $c742: f9 05 d5
            bcc __c74c         ; $c745: 90 05
            sty $5d            ; $c747: 84 5d
            clc                ; $c749: 18
            bcc __c74f         ; $c74a: 90 03
__c74c:     iny                ; $c74c: c8
            sty $5c            ; $c74d: 84 5c
__c74f:     lda $5c            ; $c74f: a5 5c
            adc $5d            ; $c751: 65 5d
            ror                ; $c753: 6a
            tay                ; $c754: a8
            lda $0100,x        ; $c755: bd 00 01
            cmp __d405,y       ; $c758: d9 05 d4
            lda $011c,x        ; $c75b: bd 1c 01
            sbc __d505,y       ; $c75e: f9 05 d5
            bcc __c768         ; $c761: 90 05
            sty $5d            ; $c763: 84 5d
            clc                ; $c765: 18
            bcc __c76b         ; $c766: 90 03
__c768:     iny                ; $c768: c8
            sty $5c            ; $c769: 84 5c
__c76b:     lda $5c            ; $c76b: a5 5c
            adc $5d            ; $c76d: 65 5d
            ror                ; $c76f: 6a
            tay                ; $c770: a8
            lda $0100,x        ; $c771: bd 00 01
            cmp __d405,y       ; $c774: d9 05 d4
            lda $011c,x        ; $c777: bd 1c 01
            sbc __d505,y       ; $c77a: f9 05 d5
            bcc __c784         ; $c77d: 90 05
            sty $5d            ; $c77f: 84 5d
            clc                ; $c781: 18
            bcc __c787         ; $c782: 90 03
__c784:     iny                ; $c784: c8
            sty $5c            ; $c785: 84 5c
__c787:     lda $5c            ; $c787: a5 5c
            adc $5d            ; $c789: 65 5d
            ror                ; $c78b: 6a
            tay                ; $c78c: a8
            lda $0100,x        ; $c78d: bd 00 01
            cmp __d405,y       ; $c790: d9 05 d4
            lda $011c,x        ; $c793: bd 1c 01
            sbc __d505,y       ; $c796: f9 05 d5
            bcc __c7a0         ; $c799: 90 05
            sty $5d            ; $c79b: 84 5d
            clc                ; $c79d: 18
            bcc __c7a3         ; $c79e: 90 03
__c7a0:     iny                ; $c7a0: c8
            sty $5c            ; $c7a1: 84 5c
__c7a3:     lda $5c            ; $c7a3: a5 5c
            adc $5d            ; $c7a5: 65 5d
            ror                ; $c7a7: 6a
            tay                ; $c7a8: a8
            lda $0100,x        ; $c7a9: bd 00 01
            cmp __d405,y       ; $c7ac: d9 05 d4
            lda $011c,x        ; $c7af: bd 1c 01
            sbc __d505,y       ; $c7b2: f9 05 d5
            bcc __c7bc         ; $c7b5: 90 05
            sty $5d            ; $c7b7: 84 5d
            clc                ; $c7b9: 18
            bcc __c7bf         ; $c7ba: 90 03
__c7bc:     iny                ; $c7bc: c8
            sty $5c            ; $c7bd: 84 5c
__c7bf:     lda $5c            ; $c7bf: a5 5c
            adc $5d            ; $c7c1: 65 5d
            ror                ; $c7c3: 6a
            tay                ; $c7c4: a8
            lda $0100,x        ; $c7c5: bd 00 01
            cmp __d405,y       ; $c7c8: d9 05 d4
            lda $011c,x        ; $c7cb: bd 1c 01
            sbc __d505,y       ; $c7ce: f9 05 d5
            bcc __c7d8         ; $c7d1: 90 05
            sty $5d            ; $c7d3: 84 5d
            clc                ; $c7d5: 18
            bcc __c7db         ; $c7d6: 90 03
__c7d8:     iny                ; $c7d8: c8
            sty $5c            ; $c7d9: 84 5c
__c7db:     lda $5c            ; $c7db: a5 5c
            adc $5d            ; $c7dd: 65 5d
            ror                ; $c7df: 6a
            tay                ; $c7e0: a8
            lda $0100,x        ; $c7e1: bd 00 01
            cmp __d405,y       ; $c7e4: d9 05 d4
            lda $011c,x        ; $c7e7: bd 1c 01
            sbc __d505,y       ; $c7ea: f9 05 d5
            bcc __c7f4         ; $c7ed: 90 05
            sty $5d            ; $c7ef: 84 5d
            clc                ; $c7f1: 18
            bcc __c7f7         ; $c7f2: 90 03
__c7f4:     iny                ; $c7f4: c8
            sty $5c            ; $c7f5: 84 5c
__c7f7:     ldy $0138,x        ; $c7f7: bc 38 01
            lda __ca7d,y       ; $c7fa: b9 7d ca
            sta $38            ; $c7fd: 85 38
            lda __ca81,y       ; $c7ff: b9 81 ca
            sta $39            ; $c802: 85 39
            ldy $0154,x        ; $c804: bc 54 01
            lda ($38),y        ; $c807: b1 38
            sta $5b            ; $c809: 85 5b
            iny                ; $c80b: c8
            lda ($38),y        ; $c80c: b1 38
            sta $5a            ; $c80e: 85 5a
            lda $5c            ; $c810: a5 5c
            cmp #$ff           ; $c812: c9 ff
            bne __c890         ; $c814: d0 7a
            ldy $0100,x        ; $c816: bc 00 01
            cpy __d504         ; $c819: cc 04 d5
            bcs __c890         ; $c81c: b0 72
            stx $26            ; $c81e: 86 26
            ldx $2b            ; $c820: a6 2b
            lda $59            ; $c822: a5 59
            ora #$04           ; $c824: 09 04
            sta $0400,x        ; $c826: 9d 00 04
            sta $0480,x        ; $c829: 9d 80 04
            ldy $5a            ; $c82c: a4 5a
            cpy #$80           ; $c82e: c0 80
            rol $0400,x        ; $c830: 3e 00 04
            cpy #$80           ; $c833: c0 80
            rol $0400,x        ; $c835: 3e 00 04
            cpy #$80           ; $c838: c0 80
            rol $0400,x        ; $c83a: 3e 00 04
            cpy #$80           ; $c83d: c0 80
            rol $0400,x        ; $c83f: 3e 00 04
            ldy $5b            ; $c842: a4 5b
            cpy #$80           ; $c844: c0 80
            rol $0480,x        ; $c846: 3e 80 04
            cpy #$80           ; $c849: c0 80
            rol $0480,x        ; $c84b: 3e 80 04
            cpy #$80           ; $c84e: c0 80
            rol $0480,x        ; $c850: 3e 80 04
            cpy #$80           ; $c853: c0 80
            rol $0480,x        ; $c855: 3e 80 04
            lda $0400,x        ; $c858: bd 00 04
            sta $0401,x        ; $c85b: 9d 01 04
            sta $0402,x        ; $c85e: 9d 02 04
            sta $0403,x        ; $c861: 9d 03 04
            sta $0404,x        ; $c864: 9d 04 04
            sta $0405,x        ; $c867: 9d 05 04
            sta $0406,x        ; $c86a: 9d 06 04
            sta $0407,x        ; $c86d: 9d 07 04
            lda $0480,x        ; $c870: bd 80 04
            sta $0481,x        ; $c873: 9d 81 04
            sta $0482,x        ; $c876: 9d 82 04
            sta $0483,x        ; $c879: 9d 83 04
            sta $0484,x        ; $c87c: 9d 84 04
            sta $0485,x        ; $c87f: 9d 85 04
            sta $0486,x        ; $c882: 9d 86 04
            sta $0487,x        ; $c885: 9d 87 04
            clc                ; $c888: 18
            txa                ; $c889: 8a
            adc #$08           ; $c88a: 69 08
            tax                ; $c88c: aa
            jmp __c9c8         ; $c88d: 4c c8 c9

;-------------------------------------------------------------------------------
__c890:     stx $26            ; $c890: 86 26
            ldx $2b            ; $c892: a6 2b
            cmp #$21           ; $c894: c9 21
            bcc __c89a         ; $c896: 90 02
            lda #$20           ; $c898: a9 20
__c89a:     sta $5d            ; $c89a: 85 5d
            lsr                ; $c89c: 4a
            lsr                ; $c89d: 4a
            sta $5e            ; $c89e: 85 5e
            eor #$ff           ; $c8a0: 49 ff
            sec                ; $c8a2: 38
            adc #$08           ; $c8a3: 69 08
            sta $5f            ; $c8a5: 85 5f
            lda $5d            ; $c8a7: a5 5d
            and #$03           ; $c8a9: 29 03
            sta $60            ; $c8ab: 85 60
            ldy $26            ; $c8ad: a4 26
            lda $0138,y        ; $c8af: b9 38 01
            bne __c8ca         ; $c8b2: d0 16
            ldy $5e            ; $c8b4: a4 5e
            bne __c8bb         ; $c8b6: d0 03
            jmp __c963         ; $c8b8: 4c 63 c9

;-------------------------------------------------------------------------------
__c8bb:     lda #$00           ; $c8bb: a9 00
__c8bd:     sta $0400,x        ; $c8bd: 9d 00 04
            sta $0480,x        ; $c8c0: 9d 80 04
            inx                ; $c8c3: e8
            dey                ; $c8c4: 88
            bne __c8bd         ; $c8c5: d0 f6
            jmp __c963         ; $c8c7: 4c 63 c9

;-------------------------------------------------------------------------------
__c8ca:     lda $5c            ; $c8ca: a5 5c
            eor #$ff           ; $c8cc: 49 ff
            sta $61            ; $c8ce: 85 61
            ldy $5e            ; $c8d0: a4 5e
            bne __c8d7         ; $c8d2: d0 03
            jmp __c963         ; $c8d4: 4c 63 c9

;-------------------------------------------------------------------------------
__c8d7:     lda $59            ; $c8d7: a5 59
            sta $0400,x        ; $c8d9: 9d 00 04
            ora #$04           ; $c8dc: 09 04
            sta $0480,x        ; $c8de: 9d 80 04
            sec                ; $c8e1: 38
            lda $61            ; $c8e2: a5 61
            adc #$07           ; $c8e4: 69 07
            bcc __c8f1         ; $c8e6: 90 09
__c8e8:     asl $5a            ; $c8e8: 06 5a
            asl $5b            ; $c8ea: 06 5b
            sec                ; $c8ec: 38
            sbc $5c            ; $c8ed: e5 5c
            bcs __c8e8         ; $c8ef: b0 f7
__c8f1:     ldy $5a            ; $c8f1: a4 5a
            cpy #$80           ; $c8f3: c0 80
            rol $0400,x        ; $c8f5: 3e 00 04
            ldy $5b            ; $c8f8: a4 5b
            cpy #$80           ; $c8fa: c0 80
            rol $0480,x        ; $c8fc: 3e 80 04
            adc #$07           ; $c8ff: 69 07
            bcc __c90c         ; $c901: 90 09
__c903:     asl $5a            ; $c903: 06 5a
            asl $5b            ; $c905: 06 5b
            sec                ; $c907: 38
            sbc $5c            ; $c908: e5 5c
            bcs __c903         ; $c90a: b0 f7
__c90c:     ldy $5a            ; $c90c: a4 5a
            cpy #$80           ; $c90e: c0 80
            rol $0400,x        ; $c910: 3e 00 04
            ldy $5b            ; $c913: a4 5b
            cpy #$80           ; $c915: c0 80
            rol $0480,x        ; $c917: 3e 80 04
            adc #$07           ; $c91a: 69 07
            bcc __c927         ; $c91c: 90 09
__c91e:     asl $5a            ; $c91e: 06 5a
            asl $5b            ; $c920: 06 5b
            sec                ; $c922: 38
            sbc $5c            ; $c923: e5 5c
            bcs __c91e         ; $c925: b0 f7
__c927:     ldy $5a            ; $c927: a4 5a
            cpy #$80           ; $c929: c0 80
            rol $0400,x        ; $c92b: 3e 00 04
            ldy $5b            ; $c92e: a4 5b
            cpy #$80           ; $c930: c0 80
            rol $0480,x        ; $c932: 3e 80 04
            adc #$07           ; $c935: 69 07
            bcc __c942         ; $c937: 90 09
__c939:     asl $5a            ; $c939: 06 5a
            asl $5b            ; $c93b: 06 5b
            sec                ; $c93d: 38
            sbc $5c            ; $c93e: e5 5c
            bcs __c939         ; $c940: b0 f7
__c942:     ldy $5a            ; $c942: a4 5a
            cpy #$80           ; $c944: c0 80
            rol $0400,x        ; $c946: 3e 00 04
            ldy $5b            ; $c949: a4 5b
            cpy #$80           ; $c94b: c0 80
            rol $0480,x        ; $c94d: 3e 80 04
            sta $61            ; $c950: 85 61
            ldy $0400,x        ; $c952: bc 00 04
            lda __d610,y       ; $c955: b9 10 d6
            sta $0400,x        ; $c958: 9d 00 04
            inx                ; $c95b: e8
            dec $5e            ; $c95c: c6 5e
            beq __c963         ; $c95e: f0 03
            jmp __c8d7         ; $c960: 4c d7 c8

;-------------------------------------------------------------------------------
__c963:     ldy $26            ; $c963: a4 26
            lda $0138,y        ; $c965: b9 38 01
            bne __c983         ; $c968: d0 19
            ldy $60            ; $c96a: a4 60
            bne __c971         ; $c96c: d0 03
            jmp __c9b6         ; $c96e: 4c b6 c9

;-------------------------------------------------------------------------------
__c971:     dec $5f            ; $c971: c6 5f
            clc                ; $c973: 18
            tya                ; $c974: 98
            adc #$f1           ; $c975: 69 f1
            sta $0400,x        ; $c977: 9d 00 04
            adc #$03           ; $c97a: 69 03
            sta $0480,x        ; $c97c: 9d 80 04
            inx                ; $c97f: e8
            jmp __c9b6         ; $c980: 4c b6 c9

;-------------------------------------------------------------------------------
__c983:     ldy $60            ; $c983: a4 60
            beq __c9b6         ; $c985: f0 2f
            dec $5f            ; $c987: c6 5f
            lda $59            ; $c989: a5 59
            sta $0400,x        ; $c98b: 9d 00 04
            ora #$04           ; $c98e: 09 04
            sta $0480,x        ; $c990: 9d 80 04
            sec                ; $c993: 38
            lda $61            ; $c994: a5 61
__c996:     adc #$07           ; $c996: 69 07
            bcc __c9a3         ; $c998: 90 09
__c99a:     asl $5a            ; $c99a: 06 5a
            asl $5b            ; $c99c: 06 5b
            sec                ; $c99e: 38
            sbc $5c            ; $c99f: e5 5c
            bcs __c99a         ; $c9a1: b0 f7
__c9a3:     ldy $5a            ; $c9a3: a4 5a
            cpy #$80           ; $c9a5: c0 80
            rol $0400,x        ; $c9a7: 3e 00 04
            ldy $5b            ; $c9aa: a4 5b
            cpy #$80           ; $c9ac: c0 80
            rol $0480,x        ; $c9ae: 3e 80 04
            dec $60            ; $c9b1: c6 60
            bne __c996         ; $c9b3: d0 e1
            inx                ; $c9b5: e8
__c9b6:     ldy $5f            ; $c9b6: a4 5f
            beq __c9c8         ; $c9b8: f0 0e
__c9ba:     lda #$f0           ; $c9ba: a9 f0
            sta $0400,x        ; $c9bc: 9d 00 04
            lda #$f1           ; $c9bf: a9 f1
            sta $0480,x        ; $c9c1: 9d 80 04
            inx                ; $c9c4: e8
            dey                ; $c9c5: 88
            bne __c9ba         ; $c9c6: d0 f2
__c9c8:     stx $2b            ; $c9c8: 86 2b
            ldx $26            ; $c9ca: a6 26
            inx                ; $c9cc: e8
            txa                ; $c9cd: 8a
            lsr                ; $c9ce: 4a
            bcc __c9d4         ; $c9cf: 90 03
            jmp __c704         ; $c9d1: 4c 04 c7

;-------------------------------------------------------------------------------
__c9d4:     lsr                ; $c9d4: 4a
            bcc __c9da         ; $c9d5: 90 03
            jmp __c6da         ; $c9d7: 4c da c6

;-------------------------------------------------------------------------------
__c9da:     tay                ; $c9da: a8
            lda $25            ; $c9db: a5 25
            ora $30            ; $c9dd: 05 30
            sta $0030,y        ; $c9df: 99 30 00
            inc $2e            ; $c9e2: e6 2e
            cpx #$1c           ; $c9e4: e0 1c
            beq __c9f1         ; $c9e6: f0 09
            lda $2b            ; $c9e8: a5 2b
            and #$7f           ; $c9ea: 29 7f
            sta $2b            ; $c9ec: 85 2b
            jmp __c6b2         ; $c9ee: 4c b2 c6

;-------------------------------------------------------------------------------
__c9f1:     jsr __c073         ; $c9f1: 20 73 c0
            dec $2d            ; $c9f4: c6 2d
            jmp __c2ce         ; $c9f6: 4c ce c2

;-------------------------------------------------------------------------------
            .hex 80 80         ; $c9f9: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $c9fb: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $c9fd: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $c9ff: 80 80     Invalid Opcode - NOP #$80
__ca01:     .hex 80 80         ; $ca01: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $ca03: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $ca05: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $ca07: 80 80     Invalid Opcode - NOP #$80
__ca09:     .hex 80 00         ; $ca09: 80 00     Invalid Opcode - NOP #$00
            brk                ; $ca0b: 00
            brk                ; $ca0c: 00
            brk                ; $ca0d: 00
            brk                ; $ca0e: 00
            brk                ; $ca0f: 00
            sta ($00,x)        ; $ca10: 81 00
            brk                ; $ca12: 00
            brk                ; $ca13: 00
            brk                ; $ca14: 00
            brk                ; $ca15: 00
            brk                ; $ca16: 00
            brk                ; $ca17: 00
            .hex 80 80         ; $ca18: 80 80     Invalid Opcode - NOP #$80
            brk                ; $ca1a: 00
            brk                ; $ca1b: 00
            brk                ; $ca1c: 00
            brk                ; $ca1d: 00
            brk                ; $ca1e: 00
            brk                ; $ca1f: 00
            brk                ; $ca20: 00
            brk                ; $ca21: 00
            brk                ; $ca22: 00
            brk                ; $ca23: 00
            brk                ; $ca24: 00
            brk                ; $ca25: 00
            brk                ; $ca26: 00
            brk                ; $ca27: 00
            .hex 80 80         ; $ca28: 80 80     Invalid Opcode - NOP #$80
            brk                ; $ca2a: 00
            brk                ; $ca2b: 00
            brk                ; $ca2c: 00
            brk                ; $ca2d: 00
            brk                ; $ca2e: 00
            brk                ; $ca2f: 00
            .hex 82 00         ; $ca30: 82 00     Invalid Opcode - NOP #$00
            brk                ; $ca32: 00
            brk                ; $ca33: 00
            brk                ; $ca34: 00
            brk                ; $ca35: 00
            brk                ; $ca36: 00
            brk                ; $ca37: 00
            .hex 80 80         ; $ca38: 80 80     Invalid Opcode - NOP #$80
            brk                ; $ca3a: 00
            brk                ; $ca3b: 00
            brk                ; $ca3c: 00
            brk                ; $ca3d: 00
            brk                ; $ca3e: 00
            brk                ; $ca3f: 00
            brk                ; $ca40: 00
            brk                ; $ca41: 00
            brk                ; $ca42: 00
            brk                ; $ca43: 00
            brk                ; $ca44: 00
            brk                ; $ca45: 00
            brk                ; $ca46: 00
            brk                ; $ca47: 00
            .hex 80 80         ; $ca48: 80 80     Invalid Opcode - NOP #$80
            brk                ; $ca4a: 00
            brk                ; $ca4b: 00
            brk                ; $ca4c: 00
            brk                ; $ca4d: 00
            brk                ; $ca4e: 00
            brk                ; $ca4f: 00
            sta ($00,x)        ; $ca50: 81 00
            brk                ; $ca52: 00
            brk                ; $ca53: 00
            brk                ; $ca54: 00
            brk                ; $ca55: 00
            brk                ; $ca56: 00
            brk                ; $ca57: 00
            .hex 80 80         ; $ca58: 80 80     Invalid Opcode - NOP #$80
            brk                ; $ca5a: 00
            brk                ; $ca5b: 00
            brk                ; $ca5c: 00
            brk                ; $ca5d: 00
            brk                ; $ca5e: 00
            brk                ; $ca5f: 00
            sta ($00,x)        ; $ca60: 81 00
            brk                ; $ca62: 00
            brk                ; $ca63: 00
            brk                ; $ca64: 00
            brk                ; $ca65: 00
            brk                ; $ca66: 00
            brk                ; $ca67: 00
            .hex 80 80         ; $ca68: 80 80     Invalid Opcode - NOP #$80
            brk                ; $ca6a: 00
            brk                ; $ca6b: 00
            brk                ; $ca6c: 00
            brk                ; $ca6d: 00
            brk                ; $ca6e: 00
            sta ($81,x)        ; $ca6f: 81 81
            brk                ; $ca71: 00
            brk                ; $ca72: 00
            brk                ; $ca73: 00
            brk                ; $ca74: 00
            brk                ; $ca75: 00
            brk                ; $ca76: 00
            brk                ; $ca77: 00
            .hex 80            ; $ca78: 80        Suspected data
__ca79:     .hex 80 00         ; $ca79: 80 00     Invalid Opcode - NOP #$00
            brk                ; $ca7b: 00
            brk                ; $ca7c: 00
__ca7d:     brk                ; $ca7d: 00
            brk                ; $ca7e: 00
            brk                ; $ca7f: 00
            brk                ; $ca80: 00
__ca81:     brk                ; $ca81: 00
            brk                ; $ca82: 00
            brk                ; $ca83: 00
            brk                ; $ca84: 00
            brk                ; $ca85: 00
            brk                ; $ca86: 00
            brk                ; $ca87: 00
            .hex 80 80         ; $ca88: 80 80     Invalid Opcode - NOP #$80
            .hex 82 00         ; $ca8a: 82 00     Invalid Opcode - NOP #$00
            brk                ; $ca8c: 00
            brk                ; $ca8d: 00
            brk                ; $ca8e: 00
            brk                ; $ca8f: 00
            .hex 80 80         ; $ca90: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $ca92: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $ca94: 80 80     Invalid Opcode - NOP #$80
            brk                ; $ca96: 00
            .hex 82 80         ; $ca97: 82 80     Invalid Opcode - NOP #$80
            .hex 80 00         ; $ca99: 80 00     Invalid Opcode - NOP #$00
            brk                ; $ca9b: 00
            brk                ; $ca9c: 00
            brk                ; $ca9d: 00
            .hex 82 00         ; $ca9e: 82 00     Invalid Opcode - NOP #$00
            .hex 80 83         ; $caa0: 80 83     Invalid Opcode - NOP #$83
            brk                ; $caa2: 00
            brk                ; $caa3: 00
            brk                ; $caa4: 00
            brk                ; $caa5: 00
            brk                ; $caa6: 00
            brk                ; $caa7: 00
            .hex 80 80         ; $caa8: 80 80     Invalid Opcode - NOP #$80
            brk                ; $caaa: 00
            brk                ; $caab: 00
            brk                ; $caac: 00
            brk                ; $caad: 00
            brk                ; $caae: 00
            brk                ; $caaf: 00
            .hex 80 00         ; $cab0: 80 00     Invalid Opcode - NOP #$00
            brk                ; $cab2: 00
            brk                ; $cab3: 00
            brk                ; $cab4: 00
            brk                ; $cab5: 00
            brk                ; $cab6: 00
            brk                ; $cab7: 00
            .hex 80 80         ; $cab8: 80 80     Invalid Opcode - NOP #$80
            brk                ; $caba: 00
            brk                ; $cabb: 00
            brk                ; $cabc: 00
            brk                ; $cabd: 00
            brk                ; $cabe: 00
            brk                ; $cabf: 00
            .hex 80 00         ; $cac0: 80 00     Invalid Opcode - NOP #$00
            brk                ; $cac2: 00
            brk                ; $cac3: 00
            brk                ; $cac4: 00
            brk                ; $cac5: 00
            brk                ; $cac6: 00
            brk                ; $cac7: 00
            .hex 80 80         ; $cac8: 80 80     Invalid Opcode - NOP #$80
            brk                ; $caca: 00
            brk                ; $cacb: 00
            brk                ; $cacc: 00
            brk                ; $cacd: 00
            brk                ; $cace: 00
            brk                ; $cacf: 00
            .hex 80 00         ; $cad0: 80 00     Invalid Opcode - NOP #$00
            brk                ; $cad2: 00
            brk                ; $cad3: 00
            brk                ; $cad4: 00
            brk                ; $cad5: 00
            brk                ; $cad6: 00
            brk                ; $cad7: 00
            .hex 80 80         ; $cad8: 80 80     Invalid Opcode - NOP #$80
            brk                ; $cada: 00
            .hex 80 00         ; $cadb: 80 00     Invalid Opcode - NOP #$00
            .hex 80 00         ; $cadd: 80 00     Invalid Opcode - NOP #$00
            brk                ; $cadf: 00
            .hex 80 83         ; $cae0: 80 83     Invalid Opcode - NOP #$83
            brk                ; $cae2: 00
            brk                ; $cae3: 00
            brk                ; $cae4: 00
            brk                ; $cae5: 00
            brk                ; $cae6: 00
            brk                ; $cae7: 00
            .hex 80 80         ; $cae8: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $caea: 80 80     Invalid Opcode - NOP #$80
            .hex ff 80 80      ; $caec: ff 80 80  Invalid Opcode - ISC $8080,x
            .hex 80 80         ; $caef: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $caf1: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $caf3: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $caf5: 80 80     Invalid Opcode - NOP #$80
            .hex 80 80         ; $caf7: 80 80     Invalid Opcode - NOP #$80
            .hex 12            ; $caf9: 12        Invalid Opcode - KIL
            asl $27,x          ; $cafa: 16 27
            and #$05           ; $cafc: 29 05
            ora $25,x          ; $cafe: 15 25
            ora $cb            ; $cb00: 05 cb
            .hex cb cb         ; $cb02: cb cb     Invalid Opcode - AXS #$cb
            .hex cb ff         ; $cb04: cb ff     Invalid Opcode - AXS #$ff
            .hex ff 11 09      ; $cb06: ff 11 09  Invalid Opcode - ISC $0911,x
            sbc ($f9),y        ; $cb09: f1 f9
            sta ($09),y        ; $cb0b: 91 09
            .hex 9f 09 fd      ; $cb0d: 9f 09 fd  Invalid Opcode - AHX __fd09,y
            .hex ff 15 09      ; $cb10: ff 15 09  Invalid Opcode - ISC $0915,x
            ora $09,x          ; $cb13: 15 09
            .hex 3f 3f 21      ; $cb15: 3f 3f 21  Invalid Opcode - RLA $213f,x
            and ($21,x)        ; $cb18: 21 21
            and ($e1,x)        ; $cb1a: 21 e1
            sbc ($e1,x)        ; $cb1c: e1 e1
            sbc ($21,x)        ; $cb1e: e1 21
            and ($21,x)        ; $cb20: 21 21
            and ($3f,x)        ; $cb22: 21 3f
            .hex 3f ff ff      ; $cb24: 3f ff ff  Invalid Opcode - RLA $ffff,x
            ora $65            ; $cb27: 05 65
            sbc $6585,x        ; $cb29: fd 85 65
            ora $651d,x        ; $cb2c: 1d 1d 65
            sta $fd            ; $cb2f: 85 fd
            adc $05            ; $cb31: 65 05
            .hex ff ff 48      ; $cb33: ff ff 48  Invalid Opcode - ISC $48ff,x
            txa                ; $cb36: 8a
            pha                ; $cb37: 48
            tya                ; $cb38: 98
            pha                ; $cb39: 48
            lda $2e            ; $cb3a: a5 2e
            beq __cb41         ; $cb3c: f0 03
            jmp __cbe2         ; $cb3e: 4c e2 cb

;-------------------------------------------------------------------------------
__cb41:     bit $2d            ; $cb41: 24 2d
            bmi __cb48         ; $cb43: 30 03
            jmp __cbdf         ; $cb45: 4c df cb

;-------------------------------------------------------------------------------
__cb48:     inc $2d            ; $cb48: e6 2d
            lda $1b            ; $cb4a: a5 1b
            eor #$03           ; $cb4c: 49 03
            sta $1b            ; $cb4e: 85 1b
            lda $28            ; $cb50: a5 28
            ora #$03           ; $cb52: 09 03
            sta PPUADDR        ; $cb54: 8d 06 20
            lda #$c0           ; $cb57: a9 c0
            sta PPUADDR        ; $cb59: 8d 06 20
            lda #$a8           ; $cb5c: a9 a8
            sta PPUCTRL        ; $cb5e: 8d 00 20
            ldx #$04           ; $cb61: a2 04
__cb63:     lda $31            ; $cb63: a5 31
            sta PPUDATA        ; $cb65: 8d 07 20
            lda $32            ; $cb68: a5 32
            sta PPUDATA        ; $cb6a: 8d 07 20
            lda $33            ; $cb6d: a5 33
            sta PPUDATA        ; $cb6f: 8d 07 20
            lda $34            ; $cb72: a5 34
            sta PPUDATA        ; $cb74: 8d 07 20
            lda $35            ; $cb77: a5 35
            sta PPUDATA        ; $cb79: 8d 07 20
            lda $36            ; $cb7c: a5 36
            sta PPUDATA        ; $cb7e: 8d 07 20
            lda $37            ; $cb81: a5 37
            sta PPUDATA        ; $cb83: 8d 07 20
            lda #$00           ; $cb86: a9 00
            sta PPUDATA        ; $cb88: 8d 07 20
            dex                ; $cb8b: ca
            bne __cb63         ; $cb8c: d0 d5
            ldx #$0f           ; $cb8e: a2 0f
            ldy $1c            ; $cb90: a4 1c
            lda #$3f           ; $cb92: a9 3f
            sta PPUADDR        ; $cb94: 8d 06 20
            lda #$00           ; $cb97: a9 00
            sta PPUADDR        ; $cb99: 8d 06 20
            lda #$27           ; $cb9c: a9 27
            stx PPUDATA        ; $cb9e: 8e 07 20
            sta PPUDATA        ; $cba1: 8d 07 20
            sta PPUDATA        ; $cba4: 8d 07 20
            sta PPUDATA        ; $cba7: 8d 07 20
            stx PPUDATA        ; $cbaa: 8e 07 20
            sty PPUDATA        ; $cbad: 8c 07 20
            lda $22            ; $cbb0: a5 22
            sta PPUDATA        ; $cbb2: 8d 07 20
            lda $24            ; $cbb5: a5 24
            sta PPUDATA        ; $cbb7: 8d 07 20
            stx PPUDATA        ; $cbba: 8e 07 20
            sty PPUDATA        ; $cbbd: 8c 07 20
            lda $23            ; $cbc0: a5 23
            sta PPUDATA        ; $cbc2: 8d 07 20
            lda $22            ; $cbc5: a5 22
            sta PPUDATA        ; $cbc7: 8d 07 20
            stx PPUDATA        ; $cbca: 8e 07 20
__cbcd:     sty PPUDATA        ; $cbcd: 8c 07 20
            lda $24            ; $cbd0: a5 24
            sta PPUDATA        ; $cbd2: 8d 07 20
            lda $23            ; $cbd5: a5 23
            sta PPUDATA        ; $cbd7: 8d 07 20
            lda #$0e           ; $cbda: a9 0e
            sta PPUMASK        ; $cbdc: 8d 01 20
__cbdf:     jmp __cda9         ; $cbdf: 4c a9 cd

;-------------------------------------------------------------------------------
__cbe2:     lda #$ac           ; $cbe2: a9 ac
            sta PPUCTRL        ; $cbe4: 8d 00 20
            lda #$03           ; $cbe7: a9 03
            sta $2f            ; $cbe9: 85 2f
            ldx $2c            ; $cbeb: a6 2c
            ldy $27            ; $cbed: a4 27
__cbef:     lda $28            ; $cbef: a5 28
            sta PPUADDR        ; $cbf1: 8d 06 20
            sty PPUADDR        ; $cbf4: 8c 06 20
            iny                ; $cbf7: c8
            lda $0407,x        ; $cbf8: bd 07 04
            sta PPUDATA        ; $cbfb: 8d 07 20
            lda $0406,x        ; $cbfe: bd 06 04
            sta PPUDATA        ; $cc01: 8d 07 20
            lda $0405,x        ; $cc04: bd 05 04
            sta PPUDATA        ; $cc07: 8d 07 20
            lda $0404,x        ; $cc0a: bd 04 04
            sta PPUDATA        ; $cc0d: 8d 07 20
            lda $0403,x        ; $cc10: bd 03 04
            sta PPUDATA        ; $cc13: 8d 07 20
            lda $0402,x        ; $cc16: bd 02 04
            sta PPUDATA        ; $cc19: 8d 07 20
            lda $0401,x        ; $cc1c: bd 01 04
            sta PPUDATA        ; $cc1f: 8d 07 20
            lda $0400,x        ; $cc22: bd 00 04
            sta PPUDATA        ; $cc25: 8d 07 20
            lda $0480,x        ; $cc28: bd 80 04
            sta PPUDATA        ; $cc2b: 8d 07 20
            lda $0481,x        ; $cc2e: bd 81 04
            sta PPUDATA        ; $cc31: 8d 07 20
            lda $0482,x        ; $cc34: bd 82 04
            sta PPUDATA        ; $cc37: 8d 07 20
            lda $0483,x        ; $cc3a: bd 83 04
            sta PPUDATA        ; $cc3d: 8d 07 20
            lda $0484,x        ; $cc40: bd 84 04
            sta PPUDATA        ; $cc43: 8d 07 20
            lda $0485,x        ; $cc46: bd 85 04
            sta PPUDATA        ; $cc49: 8d 07 20
            lda $0486,x        ; $cc4c: bd 86 04
            sta PPUDATA        ; $cc4f: 8d 07 20
            lda $0487,x        ; $cc52: bd 87 04
            sta PPUDATA        ; $cc55: 8d 07 20
            lda $28            ; $cc58: a5 28
            sta PPUADDR        ; $cc5a: 8d 06 20
            sty PPUADDR        ; $cc5d: 8c 06 20
            iny                ; $cc60: c8
            lda $040f,x        ; $cc61: bd 0f 04
            sta PPUDATA        ; $cc64: 8d 07 20
            lda $040e,x        ; $cc67: bd 0e 04
            sta PPUDATA        ; $cc6a: 8d 07 20
            lda $040d,x        ; $cc6d: bd 0d 04
            sta PPUDATA        ; $cc70: 8d 07 20
            lda $040c,x        ; $cc73: bd 0c 04
            sta PPUDATA        ; $cc76: 8d 07 20
            lda $040b,x        ; $cc79: bd 0b 04
            sta PPUDATA        ; $cc7c: 8d 07 20
            lda $040a,x        ; $cc7f: bd 0a 04
            sta PPUDATA        ; $cc82: 8d 07 20
            lda $0409,x        ; $cc85: bd 09 04
            sta PPUDATA        ; $cc88: 8d 07 20
            lda $0408,x        ; $cc8b: bd 08 04
            sta PPUDATA        ; $cc8e: 8d 07 20
            lda $0488,x        ; $cc91: bd 88 04
            sta PPUDATA        ; $cc94: 8d 07 20
            lda $0489,x        ; $cc97: bd 89 04
            sta PPUDATA        ; $cc9a: 8d 07 20
            lda $048a,x        ; $cc9d: bd 8a 04
            sta PPUDATA        ; $cca0: 8d 07 20
            lda $048b,x        ; $cca3: bd 8b 04
            sta PPUDATA        ; $cca6: 8d 07 20
            lda $048c,x        ; $cca9: bd 8c 04
            sta PPUDATA        ; $ccac: 8d 07 20
            lda $048d,x        ; $ccaf: bd 8d 04
            sta PPUDATA        ; $ccb2: 8d 07 20
            lda $048e,x        ; $ccb5: bd 8e 04
            sta PPUDATA        ; $ccb8: 8d 07 20
            lda $048f,x        ; $ccbb: bd 8f 04
            sta PPUDATA        ; $ccbe: 8d 07 20
            lda $28            ; $ccc1: a5 28
            sta PPUADDR        ; $ccc3: 8d 06 20
            sty PPUADDR        ; $ccc6: 8c 06 20
            iny                ; $ccc9: c8
            lda $0417,x        ; $ccca: bd 17 04
            sta PPUDATA        ; $cccd: 8d 07 20
            lda $0416,x        ; $ccd0: bd 16 04
            sta PPUDATA        ; $ccd3: 8d 07 20
            lda $0415,x        ; $ccd6: bd 15 04
            sta PPUDATA        ; $ccd9: 8d 07 20
            lda $0414,x        ; $ccdc: bd 14 04
            sta PPUDATA        ; $ccdf: 8d 07 20
            lda $0413,x        ; $cce2: bd 13 04
            sta PPUDATA        ; $cce5: 8d 07 20
            lda $0412,x        ; $cce8: bd 12 04
            sta PPUDATA        ; $cceb: 8d 07 20
            lda $0411,x        ; $ccee: bd 11 04
            sta PPUDATA        ; $ccf1: 8d 07 20
            lda $0410,x        ; $ccf4: bd 10 04
            sta PPUDATA        ; $ccf7: 8d 07 20
            lda $0490,x        ; $ccfa: bd 90 04
            sta PPUDATA        ; $ccfd: 8d 07 20
            lda $0491,x        ; $cd00: bd 91 04
            sta PPUDATA        ; $cd03: 8d 07 20
            lda $0492,x        ; $cd06: bd 92 04
            sta PPUDATA        ; $cd09: 8d 07 20
            lda $0493,x        ; $cd0c: bd 93 04
            sta PPUDATA        ; $cd0f: 8d 07 20
            lda $0494,x        ; $cd12: bd 94 04
            sta PPUDATA        ; $cd15: 8d 07 20
            lda $0495,x        ; $cd18: bd 95 04
            sta PPUDATA        ; $cd1b: 8d 07 20
            lda $0496,x        ; $cd1e: bd 96 04
            sta PPUDATA        ; $cd21: 8d 07 20
            lda $0497,x        ; $cd24: bd 97 04
            sta PPUDATA        ; $cd27: 8d 07 20
            lda $28            ; $cd2a: a5 28
            sta PPUADDR        ; $cd2c: 8d 06 20
            sty PPUADDR        ; $cd2f: 8c 06 20
            iny                ; $cd32: c8
            lda $041f,x        ; $cd33: bd 1f 04
            sta PPUDATA        ; $cd36: 8d 07 20
            lda $041e,x        ; $cd39: bd 1e 04
            sta PPUDATA        ; $cd3c: 8d 07 20
            lda $041d,x        ; $cd3f: bd 1d 04
            sta PPUDATA        ; $cd42: 8d 07 20
            lda $041c,x        ; $cd45: bd 1c 04
            sta PPUDATA        ; $cd48: 8d 07 20
            lda $041b,x        ; $cd4b: bd 1b 04
            sta PPUDATA        ; $cd4e: 8d 07 20
            lda $041a,x        ; $cd51: bd 1a 04
            sta PPUDATA        ; $cd54: 8d 07 20
            lda $0419,x        ; $cd57: bd 19 04
            sta PPUDATA        ; $cd5a: 8d 07 20
            lda $0418,x        ; $cd5d: bd 18 04
            sta PPUDATA        ; $cd60: 8d 07 20
            lda $0498,x        ; $cd63: bd 98 04
            sta PPUDATA        ; $cd66: 8d 07 20
            lda $0499,x        ; $cd69: bd 99 04
            sta PPUDATA        ; $cd6c: 8d 07 20
            lda $049a,x        ; $cd6f: bd 9a 04
            sta PPUDATA        ; $cd72: 8d 07 20
            lda $049b,x        ; $cd75: bd 9b 04
            sta PPUDATA        ; $cd78: 8d 07 20
            lda $049c,x        ; $cd7b: bd 9c 04
            sta PPUDATA        ; $cd7e: 8d 07 20
            lda $049d,x        ; $cd81: bd 9d 04
            sta PPUDATA        ; $cd84: 8d 07 20
            lda $049e,x        ; $cd87: bd 9e 04
            sta PPUDATA        ; $cd8a: 8d 07 20
            lda $049f,x        ; $cd8d: bd 9f 04
            sta PPUDATA        ; $cd90: 8d 07 20
            clc                ; $cd93: 18
            txa                ; $cd94: 8a
            adc #$20           ; $cd95: 69 20
            and #$7f           ; $cd97: 29 7f
            tax                ; $cd99: aa
            dec $2e            ; $cd9a: c6 2e
            beq __cda5         ; $cd9c: f0 07
            dec $2f            ; $cd9e: c6 2f
            beq __cda5         ; $cda0: f0 03
            jmp __cbef         ; $cda2: 4c ef cb

;-------------------------------------------------------------------------------
__cda5:     sty $27            ; $cda5: 84 27
            stx $2c            ; $cda7: 86 2c
__cda9:     lda $1b            ; $cda9: a5 1b
            sta PPUCTRL        ; $cdab: 8d 00 20
            lda #$f0           ; $cdae: a9 f0
            sta PPUSCROLL      ; $cdb0: 8d 05 20
            lda #$d0           ; $cdb3: a9 d0
            sta PPUSCROLL      ; $cdb5: 8d 05 20
            pla                ; $cdb8: 68
            tay                ; $cdb9: a8
            pla                ; $cdba: 68
            tax                ; $cdbb: aa
            pla                ; $cdbc: 68
            rti                ; $cdbd: 40

;-------------------------------------------------------------------------------
__cdbe:     lda __ca79,y       ; $cdbe: b9 79 ca
            bit $22            ; $cdc1: 24 22
            bmi __cdd7         ; $cdc3: 30 12
            cmp $22            ; $cdc5: c5 22
            beq __cdd9         ; $cdc7: f0 10
            bit $23            ; $cdc9: 24 23
            bmi __cddc         ; $cdcb: 30 0f
            cmp $23            ; $cdcd: c5 23
            beq __cdde         ; $cdcf: f0 0d
            bit $24            ; $cdd1: 24 24
            bmi __cde1         ; $cdd3: 30 0c
            bpl __cde3         ; $cdd5: 10 0c
__cdd7:     sta $22            ; $cdd7: 85 22
__cdd9:     lda #$00           ; $cdd9: a9 00
            rts                ; $cddb: 60

;-------------------------------------------------------------------------------
__cddc:     sta $23            ; $cddc: 85 23
__cdde:     lda #$01           ; $cdde: a9 01
            rts                ; $cde0: 60

;-------------------------------------------------------------------------------
__cde1:     sta $24            ; $cde1: 85 24
__cde3:     lda #$02           ; $cde3: a9 02
            rts                ; $cde5: 60

;-------------------------------------------------------------------------------
__cde6:     ldy #$b0           ; $cde6: a0 b0
            lda ($c1),y        ; $cde8: b1 c1
            .hex c2 d2         ; $cdea: c2 d2     Invalid Opcode - NOP #$d2
            .hex d3 e3         ; $cdec: d3 e3     Invalid Opcode - DCP ($e3),y
            cpx $f4            ; $cdee: e4 f4
            sbc $f6,x          ; $cdf0: f5 f6
            asl $07            ; $cdf2: 06 07
            .hex 17 18         ; $cdf4: 17 18     Invalid Opcode - SLO $18,x
            plp                ; $cdf6: 28
            and #$39           ; $cdf7: 29 39
            .hex 3a            ; $cdf9: 3a        Invalid Opcode - NOP
            lsr                ; $cdfa: 4a
            .hex 02            ; $cdfb: 02        Invalid Opcode - KIL
            ora ($02,x)        ; $cdfc: 01 02
            ora ($02,x)        ; $cdfe: 01 02
            ora ($02,x)        ; $ce00: 01 02
            ora ($02,x)        ; $ce02: 01 02
            ora ($02,x)        ; $ce04: 01 02
            ora ($03,x)        ; $ce06: 01 03
            .hex 0c 04 0b      ; $ce08: 0c 04 0b  Invalid Opcode - NOP $0b04
            ora $0a            ; $ce0b: 05 0a
            asl $09            ; $ce0d: 06 09
            .hex 07 08         ; $ce0f: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce11: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce13: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce15: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce17: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce19: 07 08     Invalid Opcode - SLO $08
            .hex 02            ; $ce1b: 02        Invalid Opcode - KIL
            ora ($02,x)        ; $ce1c: 01 02
            ora ($02,x)        ; $ce1e: 01 02
            ora ($02,x)        ; $ce20: 01 02
            ora ($02,x)        ; $ce22: 01 02
            ora ($00,x)        ; $ce24: 01 00
            brk                ; $ce26: 00
            .hex 07 08         ; $ce27: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce29: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce2b: 07 08     Invalid Opcode - SLO $08
            .hex 07 08         ; $ce2d: 07 08     Invalid Opcode - SLO $08
            .hex 07            ; $ce2f: 07        Suspected data
__ce30:     php                ; $ce30: 08
__ce31:     .hex ff aa ff      ; $ce31: ff aa ff  Invalid Opcode - ISC __ffaa,x
            dey                ; $ce34: 88
__ce35:     .hex ff aa aa      ; $ce35: ff aa aa  Invalid Opcode - ISC $aaaa,x
            .hex 22            ; $ce38: 22        Invalid Opcode - KIL
__ce39:     brk                ; $ce39: 00
            ora ($02,x)        ; $ce3a: 01 02
            .hex 03 04         ; $ce3c: 03 04     Invalid Opcode - SLO ($04,x)
            ora $06            ; $ce3e: 05 06
            .hex 07 08         ; $ce40: 07 08     Invalid Opcode - SLO $08
            ora #$0a           ; $ce42: 09 0a
            .hex 0b 0c         ; $ce44: 0b 0c     Invalid Opcode - ANC #$0c
            ora $0f0e          ; $ce46: 0d 0e 0f
            bpl __ce5c         ; $ce49: 10 11
            .hex 12            ; $ce4b: 12        Invalid Opcode - KIL
            .hex 13 14         ; $ce4c: 13 14     Invalid Opcode - SLO ($14),y
            ora $16,x          ; $ce4e: 15 16
            .hex 17 18         ; $ce50: 17 18     Invalid Opcode - SLO $18,x
            ora $1b1a,y        ; $ce52: 19 1a 1b
            .hex 1c 1d 1e      ; $ce55: 1c 1d 1e  Invalid Opcode - NOP $1e1d,x
            .hex 1f 20 21      ; $ce58: 1f 20 21  Invalid Opcode - SLO $2120,x
            .hex 22            ; $ce5b: 22        Invalid Opcode - KIL
__ce5c:     .hex 23 24         ; $ce5c: 23 24     Invalid Opcode - RLA ($24,x)
            and $26            ; $ce5e: 25 26
            .hex 27 28         ; $ce60: 27 28     Invalid Opcode - RLA $28
            and #$29           ; $ce62: 29 29
            plp                ; $ce64: 28
            .hex 27 26         ; $ce65: 27 26     Invalid Opcode - RLA $26
            and $24            ; $ce67: 25 24
            .hex 23 22         ; $ce69: 23 22     Invalid Opcode - RLA ($22,x)
            and ($20,x)        ; $ce6b: 21 20
            .hex 1f 1e 1d      ; $ce6d: 1f 1e 1d  Invalid Opcode - SLO $1d1e,x
            .hex 1c 1b 1a      ; $ce70: 1c 1b 1a  Invalid Opcode - NOP $1a1b,x
            ora $1718,y        ; $ce73: 19 18 17
            asl $15,x          ; $ce76: 16 15
            .hex 14 13         ; $ce78: 14 13     Invalid Opcode - NOP $13,x
            .hex 12            ; $ce7a: 12        Invalid Opcode - KIL
            ora ($10),y        ; $ce7b: 11 10
            .hex 0f 0e 0d      ; $ce7d: 0f 0e 0d  Invalid Opcode - SLO $0d0e
            .hex 0c 0b 0a      ; $ce80: 0c 0b 0a  Invalid Opcode - NOP $0a0b
            ora #$08           ; $ce83: 09 08
            .hex 07 06         ; $ce85: 07 06     Invalid Opcode - SLO $06
            ora $04            ; $ce87: 05 04
            .hex 03 02         ; $ce89: 03 02     Invalid Opcode - SLO ($02,x)
            ora ($00,x)        ; $ce8b: 01 00
            .hex 80 81         ; $ce8d: 80 81     Invalid Opcode - NOP #$81
            .hex 82 83         ; $ce8f: 82 83     Invalid Opcode - NOP #$83
            sty $85            ; $ce91: 84 85
            stx $87            ; $ce93: 86 87
            dey                ; $ce95: 88
            .hex 89 8a         ; $ce96: 89 8a     Invalid Opcode - NOP #$8a
            .hex 8b 8c         ; $ce98: 8b 8c     Invalid Opcode - XAA #$8c
            sta $8f8e          ; $ce9a: 8d 8e 8f
            bcc __ce30         ; $ce9d: 90 91
            .hex 92            ; $ce9f: 92        Invalid Opcode - KIL
            .hex 93 94         ; $cea0: 93 94     Invalid Opcode - AHX ($94),y
            sta $96,x          ; $cea2: 95 96
            .hex 97 98         ; $cea4: 97 98     Invalid Opcode - SAX $98,y
            sta $9b9a,y        ; $cea6: 99 9a 9b
            .hex 9c 9d 9e      ; $cea9: 9c 9d 9e  Invalid Opcode - SHY $9e9d,x
            .hex 9f a0 a1      ; $ceac: 9f a0 a1  Invalid Opcode - AHX $a1a0,y
            ldx #$a3           ; $ceaf: a2 a3
            ldy $a5            ; $ceb1: a4 a5
            ldx $a7            ; $ceb3: a6 a7
            tay                ; $ceb5: a8
            lda #$a9           ; $ceb6: a9 a9
            tay                ; $ceb8: a8
            .hex a7 a6         ; $ceb9: a7 a6     Invalid Opcode - LAX $a6
            lda $a4            ; $cebb: a5 a4
            .hex a3 a2         ; $cebd: a3 a2     Invalid Opcode - LAX ($a2,x)
            lda ($a0,x)        ; $cebf: a1 a0
            .hex 9f 9e 9d      ; $cec1: 9f 9e 9d  Invalid Opcode - AHX $9d9e,y
            .hex 9c 9b 9a      ; $cec4: 9c 9b 9a  Invalid Opcode - SHY $9a9b,x
            sta $9798,y        ; $cec7: 99 98 97
            stx $95,y          ; $ceca: 96 95
            sty $93,x          ; $cecc: 94 93
            .hex 92            ; $cece: 92        Invalid Opcode - KIL
            sta ($90),y        ; $cecf: 91 90
            .hex 8f 8e 8d      ; $ced1: 8f 8e 8d  Invalid Opcode - SAX $8d8e
__ced4:     sty $8a8b          ; $ced4: 8c 8b 8a
            .hex 89 88         ; $ced7: 89 88     Invalid Opcode - NOP #$88
            .hex 87 86         ; $ced9: 87 86     Invalid Opcode - SAX $86
            sta $84            ; $cedb: 85 84
            .hex 83 82         ; $cedd: 83 82     Invalid Opcode - SAX ($82,x)
            sta ($80,x)        ; $cedf: 81 80
            sbc ($6a),y        ; $cee1: f1 6a
            tax                ; $cee3: aa
            .hex 23 6b         ; $cee4: 23 6b     Invalid Opcode - RLA ($6b,x)
            ora $52,x          ; $cee6: 15 52
            .hex 0f f0 0b      ; $cee8: 0f f0 0b  Invalid Opcode - SLO $0bf0
            dex                ; $ceeb: ca
            ora #$4f           ; $ceec: 09 4f
            php                ; $ceee: 08
            and $6607,y        ; $ceef: 39 07 66
            asl $c0            ; $cef2: 06 c0
            ora $3a            ; $cef4: 05 3a
            ora $cc            ; $cef6: 05 cc
            .hex 04 70         ; $cef8: 04 70     Invalid Opcode - NOP $70
            .hex 04 22         ; $cefa: 04 22     Invalid Opcode - NOP $22
            .hex 04 e0         ; $cefc: 04 e0     Invalid Opcode - NOP $e0
            .hex 03 a7         ; $cefe: 03 a7     Invalid Opcode - SLO ($a7,x)
            .hex 03 75         ; $cf00: 03 75     Invalid Opcode - SLO ($75,x)
            .hex 03 49         ; $cf02: 03 49     Invalid Opcode - SLO ($49,x)
            .hex 03 22         ; $cf04: 03 22     Invalid Opcode - SLO ($22,x)
            .hex 03 00         ; $cf06: 03 00     Invalid Opcode - SLO ($00,x)
            .hex 03 e2         ; $cf08: 03 e2     Invalid Opcode - SLO ($e2,x)
            .hex 02            ; $cf0a: 02        Invalid Opcode - KIL
            .hex c7 02         ; $cf0b: c7 02     Invalid Opcode - DCP $02
            .hex af 02 99      ; $cf0d: af 02 99  Invalid Opcode - LAX $9902
            .hex 02            ; $cf10: 02        Invalid Opcode - KIL
            sta $02            ; $cf11: 85 02
            .hex 74 02         ; $cf13: 74 02     Invalid Opcode - NOP $02,x
            .hex 64 02         ; $cf15: 64 02     Invalid Opcode - NOP $02
            lsr $02,x          ; $cf17: 56 02
            eor #$02           ; $cf19: 49 02
            and $3302,x        ; $cf1b: 3d 02 33
            .hex 02            ; $cf1e: 02        Invalid Opcode - KIL
            rol                ; $cf1f: 2a
            .hex 02            ; $cf20: 02        Invalid Opcode - KIL
            .hex 22            ; $cf21: 22        Invalid Opcode - KIL
            .hex 02            ; $cf22: 02        Invalid Opcode - KIL
            .hex 1b 02 15      ; $cf23: 1b 02 15  Invalid Opcode - SLO $1502,y
            .hex 02            ; $cf26: 02        Invalid Opcode - KIL
            .hex 0f 02 0b      ; $cf27: 0f 02 0b  Invalid Opcode - SLO $0b02
            .hex 02            ; $cf2a: 02        Invalid Opcode - KIL
            .hex 07 02         ; $cf2b: 07 02     Invalid Opcode - SLO $02
            .hex 04 02         ; $cf2d: 04 02     Invalid Opcode - NOP $02
            .hex 02            ; $cf2f: 02        Invalid Opcode - KIL
            .hex 02            ; $cf30: 02        Invalid Opcode - KIL
            ora ($02,x)        ; $cf31: 01 02
            brk                ; $cf33: 00
            .hex 02            ; $cf34: 02        Invalid Opcode - KIL
            dex                ; $cf35: ca
            ror                ; $cf36: 6a
            sta $6323,x        ; $cf37: 9d 23 63
            ora $4c,x          ; $cf3a: 15 4c
            .hex 0f ec 0b      ; $cf3c: 0f ec 0b  Invalid Opcode - SLO $0bec
            .hex c7 09         ; $cf3f: c7 09     Invalid Opcode - DCP $09
            jmp $3708          ; $cf41: 4c 08 37

;-------------------------------------------------------------------------------
            .hex 07 63         ; $cf44: 07 63     Invalid Opcode - SLO $63
            asl $bd            ; $cf46: 06 bd
            ora $38            ; $cf48: 05 38
            ora $ca            ; $cf4a: 05 ca
            .hex 04 6e         ; $cf4c: 04 6e     Invalid Opcode - NOP $6e
            .hex 04 21         ; $cf4e: 04 21     Invalid Opcode - NOP $21
            .hex 04 de         ; $cf50: 04 de     Invalid Opcode - NOP $de
            .hex 03 a5         ; $cf52: 03 a5     Invalid Opcode - SLO ($a5,x)
            .hex 03 73         ; $cf54: 03 73     Invalid Opcode - SLO ($73,x)
            .hex 03 48         ; $cf56: 03 48     Invalid Opcode - SLO ($48,x)
            .hex 03 21         ; $cf58: 03 21     Invalid Opcode - SLO ($21,x)
            .hex 03 ff         ; $cf5a: 03 ff     Invalid Opcode - SLO ($ff,x)
            .hex 02            ; $cf5c: 02        Invalid Opcode - KIL
            sbc ($02,x)        ; $cf5d: e1 02
            dec $02            ; $cf5f: c6 02
            ldx $9802          ; $cf61: ae 02 98
            .hex 02            ; $cf64: 02        Invalid Opcode - KIL
            sty $02            ; $cf65: 84 02
            .hex 73 02         ; $cf67: 73 02     Invalid Opcode - RRA ($02),y
            .hex 63 02         ; $cf69: 63 02     Invalid Opcode - RRA ($02,x)
            eor $02,x          ; $cf6b: 55 02
            pha                ; $cf6d: 48
            .hex 02            ; $cf6e: 02        Invalid Opcode - KIL
            and $3202,x        ; $cf6f: 3d 02 32
            .hex 02            ; $cf72: 02        Invalid Opcode - KIL
            and #$02           ; $cf73: 29 02
            and ($02,x)        ; $cf75: 21 02
            .hex 1a            ; $cf77: 1a        Invalid Opcode - NOP
            .hex 02            ; $cf78: 02        Invalid Opcode - KIL
            .hex 14 02         ; $cf79: 14 02     Invalid Opcode - NOP $02,x
            .hex 0f 02 0a      ; $cf7b: 0f 02 0a  Invalid Opcode - SLO $0a02
            .hex 02            ; $cf7e: 02        Invalid Opcode - KIL
            .hex 07 02         ; $cf7f: 07 02     Invalid Opcode - SLO $02
            .hex 04 02         ; $cf81: 04 02     Invalid Opcode - NOP $02
            ora ($02,x)        ; $cf83: 01 02
            brk                ; $cf85: 00
            .hex 02            ; $cf86: 02        Invalid Opcode - KIL
            .hex ff 01 7e      ; $cf87: ff 01 7e  Invalid Opcode - ISC $7e01,x
            ror                ; $cf8a: 6a
            .hex 83 23         ; $cf8b: 83 23     Invalid Opcode - SAX ($23,x)
            .hex 54 15         ; $cf8d: 54 15     Invalid Opcode - NOP $15,x
            eor ($0f,x)        ; $cf8f: 41 0f
            .hex e3 0b         ; $cf91: e3 0b     Invalid Opcode - ISC ($0b,x)
            cpy #$09           ; $cf93: c0 09
            lsr $08            ; $cf95: 46 08
            and ($07),y        ; $cf97: 31 07
            .hex 5f 06 b9      ; $cf99: 5f 06 b9  Invalid Opcode - SRE $b906,x
            ora $34            ; $cf9c: 05 34
            ora $c7            ; $cf9e: 05 c7
            .hex 04 6b         ; $cfa0: 04 6b     Invalid Opcode - NOP $6b
            .hex 04 1e         ; $cfa2: 04 1e     Invalid Opcode - NOP $1e
            .hex 04 dc         ; $cfa4: 04 dc     Invalid Opcode - NOP $dc
            .hex 03 a3         ; $cfa6: 03 a3     Invalid Opcode - SLO ($a3,x)
            .hex 03 71         ; $cfa8: 03 71     Invalid Opcode - SLO ($71,x)
            .hex 03 45         ; $cfaa: 03 45     Invalid Opcode - SLO ($45,x)
            .hex 03 1f         ; $cfac: 03 1f     Invalid Opcode - SLO ($1f,x)
            .hex 03 fd         ; $cfae: 03 fd     Invalid Opcode - SLO ($fd,x)
            .hex 02            ; $cfb0: 02        Invalid Opcode - KIL
            .hex df 02 c4      ; $cfb1: df 02 c4  Invalid Opcode - DCP __c402,x
            .hex 02            ; $cfb4: 02        Invalid Opcode - KIL
            ldy $9602          ; $cfb5: ac 02 96
            .hex 02            ; $cfb8: 02        Invalid Opcode - KIL
            .hex 83 02         ; $cfb9: 83 02     Invalid Opcode - SAX ($02,x)
            adc ($02),y        ; $cfbb: 71 02
            adc ($02,x)        ; $cfbd: 61 02
            .hex 53 02         ; $cfbf: 53 02     Invalid Opcode - SRE ($02),y
            lsr $02            ; $cfc1: 46 02
            .hex 3b 02 31      ; $cfc3: 3b 02 31  Invalid Opcode - RLA $3102,y
            .hex 02            ; $cfc6: 02        Invalid Opcode - KIL
            plp                ; $cfc7: 28
            .hex 02            ; $cfc8: 02        Invalid Opcode - KIL
            jsr $1902          ; $cfc9: 20 02 19
            .hex 02            ; $cfcc: 02        Invalid Opcode - KIL
            .hex 12            ; $cfcd: 12        Invalid Opcode - KIL
__cfce:     .hex 02            ; $cfce: 02        Invalid Opcode - KIL
            ora $0902          ; $cfcf: 0d 02 09
            .hex 02            ; $cfd2: 02        Invalid Opcode - KIL
            ora $02            ; $cfd3: 05 02
            .hex 02            ; $cfd5: 02        Invalid Opcode - KIL
            .hex 02            ; $cfd6: 02        Invalid Opcode - KIL
            brk                ; $cfd7: 00
            .hex 02            ; $cfd8: 02        Invalid Opcode - KIL
            .hex ff 01 fe      ; $cfd9: ff 01 fe  Invalid Opcode - ISC __fe01,x
            ora ($0b,x)        ; $cfdc: 01 0b
            ror                ; $cfde: 6a
            eor $3d23,x        ; $cfdf: 5d 23 3d
            ora $31,x          ; $cfe2: 15 31
            .hex 0f d6 0b      ; $cfe4: 0f d6 0b  Invalid Opcode - SLO $0bd6
            lda $09,x          ; $cfe7: b5 09
            and $2a08,x        ; $cfe9: 3d 08 2a
            .hex 07 58         ; $cfec: 07 58     Invalid Opcode - SLO $58
            asl $b3            ; $cfee: 06 b3
            ora $2e            ; $cff0: 05 2e
            ora $c1            ; $cff2: 05 c1
            .hex 04 66         ; $cff4: 04 66     Invalid Opcode - NOP $66
            .hex 04 19         ; $cff6: 04 19     Invalid Opcode - NOP $19
            .hex 04 d8         ; $cff8: 04 d8     Invalid Opcode - NOP $d8
            .hex 03 9f         ; $cffa: 03 9f     Invalid Opcode - SLO ($9f,x)
            .hex 03 6d         ; $cffc: 03 6d     Invalid Opcode - SLO ($6d,x)
            .hex 03 42         ; $cffe: 03 42     Invalid Opcode - SLO ($42,x)
            .hex 03 1c         ; $d000: 03 1c     Invalid Opcode - SLO ($1c,x)
            .hex 03 fa         ; $d002: 03 fa     Invalid Opcode - SLO ($fa,x)
            .hex 02            ; $d004: 02        Invalid Opcode - KIL
            .hex dc 02 c1      ; $d005: dc 02 c1  Invalid Opcode - NOP __c102,x
            .hex 02            ; $d008: 02        Invalid Opcode - KIL
            lda #$02           ; $d009: a9 02
            .hex 93 02         ; $d00b: 93 02     Invalid Opcode - AHX ($02),y
            .hex 80 02         ; $d00d: 80 02     Invalid Opcode - NOP #$02
            ror $5f02          ; $d00f: 6e 02 5f
            .hex 02            ; $d012: 02        Invalid Opcode - KIL
            eor ($02),y        ; $d013: 51 02
            .hex 44 02         ; $d015: 44 02     Invalid Opcode - NOP $02
            and $2e02,y        ; $d017: 39 02 2e
            .hex 02            ; $d01a: 02        Invalid Opcode - KIL
            and $02            ; $d01b: 25 02
            ora $1602,x        ; $d01d: 1d 02 16
            .hex 02            ; $d020: 02        Invalid Opcode - KIL
            bpl __d025         ; $d021: 10 02
            .hex 0b 02         ; $d023: 0b 02     Invalid Opcode - ANC #$02
__d025:     .hex 07 02         ; $d025: 07 02     Invalid Opcode - SLO $02
            .hex 03 02         ; $d027: 03 02     Invalid Opcode - SLO ($02,x)
            brk                ; $d029: 00
            .hex 02            ; $d02a: 02        Invalid Opcode - KIL
            inc __fc01,x       ; $d02b: fe 01 fc
            ora ($fc,x)        ; $d02e: 01 fc
            ora ($72,x)        ; $d030: 01 72
            adc #$2a           ; $d032: 69 2a
            .hex 23 1e         ; $d034: 23 1e     Invalid Opcode - RLA ($1e,x)
            ora $1b,x          ; $d036: 15 1b
            .hex 0f c5 0b      ; $d038: 0f c5 0b  Invalid Opcode - SLO $0bc5
            .hex a7 09         ; $d03b: a7 09     Invalid Opcode - LAX $09
            and ($08),y        ; $d03d: 31 08
            .hex 1f 07 4f      ; $d03f: 1f 07 4f  Invalid Opcode - SLO $4f07,x
            asl $ab            ; $d042: 06 ab
            ora $27            ; $d044: 05 27
            ora $bb            ; $d046: 05 bb
            .hex 04 60         ; $d048: 04 60     Invalid Opcode - NOP $60
            .hex 04 14         ; $d04a: 04 14     Invalid Opcode - NOP $14
            .hex 04 d2         ; $d04c: 04 d2     Invalid Opcode - NOP $d2
            .hex 03 99         ; $d04e: 03 99     Invalid Opcode - SLO ($99,x)
            .hex 03 68         ; $d050: 03 68     Invalid Opcode - SLO ($68,x)
            .hex 03 3d         ; $d052: 03 3d     Invalid Opcode - SLO ($3d,x)
            .hex 03 17         ; $d054: 03 17     Invalid Opcode - SLO ($17,x)
            .hex 03 f6         ; $d056: 03 f6     Invalid Opcode - SLO ($f6,x)
            .hex 02            ; $d058: 02        Invalid Opcode - KIL
            cld                ; $d059: d8
            .hex 02            ; $d05a: 02        Invalid Opcode - KIL
            lda $a502,x        ; $d05b: bd 02 a5
            .hex 02            ; $d05e: 02        Invalid Opcode - KIL
            bcc __d063         ; $d05f: 90 02
            .hex 7c 02         ; $d061: 7c 02     Suspected data
__d063:     .hex 6b 02         ; $d063: 6b 02     Invalid Opcode - ARR #$02
            .hex 5b 02 4d      ; $d065: 5b 02 4d  Invalid Opcode - SRE $4d02,y
            .hex 02            ; $d068: 02        Invalid Opcode - KIL
            eor ($02,x)        ; $d069: 41 02
            and $02,x          ; $d06b: 35 02
            .hex 2b 02         ; $d06d: 2b 02     Invalid Opcode - ANC #$02
            .hex 22            ; $d06f: 22        Invalid Opcode - KIL
            .hex 02            ; $d070: 02        Invalid Opcode - KIL
            .hex 1a            ; $d071: 1a        Invalid Opcode - NOP
            .hex 02            ; $d072: 02        Invalid Opcode - KIL
            .hex 13 02         ; $d073: 13 02     Invalid Opcode - SLO ($02),y
            ora $0802          ; $d075: 0d 02 08
            .hex 02            ; $d078: 02        Invalid Opcode - KIL
            .hex 04 02         ; $d079: 04 02     Invalid Opcode - NOP $02
            brk                ; $d07b: 00
            .hex 02            ; $d07c: 02        Invalid Opcode - KIL
            sbc __fb01,x       ; $d07d: fd 01 fb
            ora ($fa,x)        ; $d080: 01 fa
            ora ($f9,x)        ; $d082: 01 f9
            ora ($b4,x)        ; $d084: 01 b4
            pla                ; $d086: 68
            .hex eb 22         ; $d087: eb 22     Invalid Opcode - SBC #$22
            sed                ; $d089: f8
            .hex 14 00         ; $d08a: 14 00     Invalid Opcode - NOP $00,x
            .hex 0f b0 0b      ; $d08c: 0f b0 0b  Invalid Opcode - SLO $0bb0
            stx $09,y          ; $d08f: 96 09
            .hex 22            ; $d091: 22        Invalid Opcode - KIL
            php                ; $d092: 08
            .hex 12            ; $d093: 12        Invalid Opcode - KIL
            .hex 07 43         ; $d094: 07 43     Invalid Opcode - SLO $43
            asl $a1            ; $d096: 06 a1
            ora $1e            ; $d098: 05 1e
            ora $b2            ; $d09a: 05 b2
            .hex 04 58         ; $d09c: 04 58     Invalid Opcode - NOP $58
            .hex 04 0c         ; $d09e: 04 0c     Invalid Opcode - NOP $0c
            .hex 04 cb         ; $d0a0: 04 cb     Invalid Opcode - NOP $cb
            .hex 03 93         ; $d0a2: 03 93     Invalid Opcode - SLO ($93,x)
            .hex 03 62         ; $d0a4: 03 62     Invalid Opcode - SLO ($62,x)
            .hex 03 37         ; $d0a6: 03 37     Invalid Opcode - SLO ($37,x)
            .hex 03 12         ; $d0a8: 03 12     Invalid Opcode - SLO ($12,x)
            .hex 03 f0         ; $d0aa: 03 f0     Invalid Opcode - SLO ($f0,x)
            .hex 02            ; $d0ac: 02        Invalid Opcode - KIL
            .hex d2            ; $d0ad: d2        Invalid Opcode - KIL
            .hex 02            ; $d0ae: 02        Invalid Opcode - KIL
            clv                ; $d0af: b8
            .hex 02            ; $d0b0: 02        Invalid Opcode - KIL
            ldy #$02           ; $d0b1: a0 02
            .hex 8b 02         ; $d0b3: 8b 02     Invalid Opcode - XAA #$02
            sei                ; $d0b5: 78
            .hex 02            ; $d0b6: 02        Invalid Opcode - KIL
            .hex 67 02         ; $d0b7: 67 02     Invalid Opcode - RRA $02
            .hex 57 02         ; $d0b9: 57 02     Invalid Opcode - SRE $02,x
            eor #$02           ; $d0bb: 49 02
            and $3102,x        ; $d0bd: 3d 02 31
            .hex 02            ; $d0c0: 02        Invalid Opcode - KIL
            .hex 27 02         ; $d0c1: 27 02     Invalid Opcode - RLA $02
            .hex 1f 02 17      ; $d0c3: 1f 02 17  Invalid Opcode - SLO $1702,x
            .hex 02            ; $d0c6: 02        Invalid Opcode - KIL
            bpl __d0cb         ; $d0c7: 10 02
            asl                ; $d0c9: 0a
            .hex 02            ; $d0ca: 02        Invalid Opcode - KIL
__d0cb:     .hex 04 02         ; $d0cb: 04 02     Invalid Opcode - NOP $02
            brk                ; $d0cd: 00
            .hex 02            ; $d0ce: 02        Invalid Opcode - KIL
            .hex fc 01 fa      ; $d0cf: fc 01 fa  Invalid Opcode - NOP __fa01,x
            ora ($f7,x)        ; $d0d2: 01 f7
            ora ($f6,x)        ; $d0d4: 01 f6
            ora ($f5,x)        ; $d0d6: 01 f5
            ora ($d0,x)        ; $d0d8: 01 d0
            .hex 67 9f         ; $d0da: 67 9f     Invalid Opcode - RRA $9f
            .hex 22            ; $d0dc: 22        Invalid Opcode - KIL
            .hex cb 14         ; $d0dd: cb 14     Invalid Opcode - AXS #$14
            .hex df 0e 97      ; $d0df: df 0e 97  Invalid Opcode - DCP $970e,x
            .hex 0b 81         ; $d0e2: 0b 81     Invalid Opcode - ANC #$81
            ora #$10           ; $d0e4: 09 10
            php                ; $d0e6: 08
            .hex 03 07         ; $d0e7: 03 07     Invalid Opcode - SLO ($07,x)
            rol $06,x          ; $d0e9: 36 06
            sta $05,x          ; $d0eb: 95 05
            .hex 13 05         ; $d0ed: 13 05     Invalid Opcode - SLO ($05),y
            tay                ; $d0ef: a8
            .hex 04 4f         ; $d0f0: 04 4f     Invalid Opcode - NOP $4f
            .hex 04 03         ; $d0f2: 04 03     Invalid Opcode - NOP $03
            .hex 04 c3         ; $d0f4: 04 c3     Invalid Opcode - NOP $c3
            .hex 03 8b         ; $d0f6: 03 8b     Invalid Opcode - SLO ($8b,x)
            .hex 03 5b         ; $d0f8: 03 5b     Invalid Opcode - SLO ($5b,x)
            .hex 03 30         ; $d0fa: 03 30     Invalid Opcode - SLO ($30,x)
            .hex 03 0b         ; $d0fc: 03 0b     Invalid Opcode - SLO ($0b,x)
            .hex 03 ea         ; $d0fe: 03 ea     Invalid Opcode - SLO ($ea,x)
            .hex 02            ; $d100: 02        Invalid Opcode - KIL
            cpy $b202          ; $d101: cc 02 b2
            .hex 02            ; $d104: 02        Invalid Opcode - KIL
            txs                ; $d105: 9a
            .hex 02            ; $d106: 02        Invalid Opcode - KIL
            sta $02            ; $d107: 85 02
            .hex 72            ; $d109: 72        Invalid Opcode - KIL
            .hex 02            ; $d10a: 02        Invalid Opcode - KIL
            adc ($02,x)        ; $d10b: 61 02
            .hex 52            ; $d10d: 52        Invalid Opcode - KIL
            .hex 02            ; $d10e: 02        Invalid Opcode - KIL
            .hex 44 02         ; $d10f: 44 02     Invalid Opcode - NOP $02
            sec                ; $d111: 38
            .hex 02            ; $d112: 02        Invalid Opcode - KIL
            and $2302          ; $d113: 2d 02 23
            .hex 02            ; $d116: 02        Invalid Opcode - KIL
            .hex 1a            ; $d117: 1a        Invalid Opcode - NOP
            .hex 02            ; $d118: 02        Invalid Opcode - KIL
            .hex 12            ; $d119: 12        Invalid Opcode - KIL
            .hex 02            ; $d11a: 02        Invalid Opcode - KIL
            .hex 0b 02         ; $d11b: 0b 02     Invalid Opcode - ANC #$02
            ora $02            ; $d11d: 05 02
            brk                ; $d11f: 00
            .hex 02            ; $d120: 02        Invalid Opcode - KIL
            .hex fc 01 f8      ; $d121: fc 01 f8  Invalid Opcode - NOP __f801,x
            ora ($f5,x)        ; $d124: 01 f5
            ora ($f3,x)        ; $d126: 01 f3
            ora ($f2,x)        ; $d128: 01 f2
            ora ($f1,x)        ; $d12a: 01 f1
            ora ($c7,x)        ; $d12c: 01 c7
            ror $46            ; $d12e: 66 46
            .hex 22            ; $d130: 22        Invalid Opcode - KIL
            stx $14,y          ; $d131: 96 14
            lda $790e,y        ; $d133: b9 0e 79
            .hex 0b 69         ; $d136: 0b 69     Invalid Opcode - ANC #$69
            ora #$fc           ; $d138: 09 fc
            .hex 07 f1         ; $d13a: 07 f1     Invalid Opcode - SLO $f1
            asl $26            ; $d13c: 06 26
            asl $86            ; $d13e: 06 86
            ora $06            ; $d140: 05 06
            ora $9c            ; $d142: 05 9c
            .hex 04 44         ; $d144: 04 44     Invalid Opcode - NOP $44
            .hex 04 f9         ; $d146: 04 f9     Invalid Opcode - NOP $f9
            .hex 03 b9         ; $d148: 03 b9     Invalid Opcode - SLO ($b9,x)
            .hex 03 82         ; $d14a: 03 82     Invalid Opcode - SLO ($82,x)
            .hex 03 52         ; $d14c: 03 52     Invalid Opcode - SLO ($52,x)
            .hex 03 28         ; $d14e: 03 28     Invalid Opcode - SLO ($28,x)
            .hex 03 03         ; $d150: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 03 e2         ; $d152: 03 e2     Invalid Opcode - SLO ($e2,x)
            .hex 02            ; $d154: 02        Invalid Opcode - KIL
            cmp $02            ; $d155: c5 02
            .hex ab 02         ; $d157: ab 02     Invalid Opcode - LAX #$02
            sty $02,x          ; $d159: 94 02
            .hex 7f 02 6c      ; $d15b: 7f 02 6c  Invalid Opcode - RRA $6c02,x
            .hex 02            ; $d15e: 02        Invalid Opcode - KIL
            .hex 5b 02 4c      ; $d15f: 5b 02 4c  Invalid Opcode - SRE $4c02,y
            .hex 02            ; $d162: 02        Invalid Opcode - KIL
            rol $3202,x        ; $d163: 3e 02 32
            .hex 02            ; $d166: 02        Invalid Opcode - KIL
            .hex 27 02         ; $d167: 27 02     Invalid Opcode - RLA $02
            ora $1502,x        ; $d169: 1d 02 15
            .hex 02            ; $d16c: 02        Invalid Opcode - KIL
            ora $0602          ; $d16d: 0d 02 06
            .hex 02            ; $d170: 02        Invalid Opcode - KIL
            brk                ; $d171: 00
            .hex 02            ; $d172: 02        Invalid Opcode - KIL
            .hex fb 01 f7      ; $d173: fb 01 f7  Invalid Opcode - ISC __f701,y
            ora ($f3,x)        ; $d176: 01 f3
            ora ($f0,x)        ; $d178: 01 f0
            ora ($ee,x)        ; $d17a: 01 ee
            ora ($ed,x)        ; $d17c: 01 ed
            ora ($ec,x)        ; $d17e: 01 ec
            ora ($99,x)        ; $d180: 01 99
            adc $e2            ; $d182: 65 e2
            and ($59,x)        ; $d184: 21 59
            .hex 14 8e         ; $d186: 14 8e     Invalid Opcode - NOP $8e,x
            asl $0b57          ; $d188: 0e 57 0b
            eor __e409         ; $d18b: 4d 09 e4
            .hex 07 dd         ; $d18e: 07 dd     Invalid Opcode - SLO $dd
            asl $14            ; $d190: 06 14
            asl $76            ; $d192: 06 76
            ora $f7            ; $d194: 05 f7
            .hex 04 8e         ; $d196: 04 8e     Invalid Opcode - NOP $8e
            .hex 04 37         ; $d198: 04 37     Invalid Opcode - NOP $37
            .hex 04 ed         ; $d19a: 04 ed     Invalid Opcode - NOP $ed
            .hex 03 ae         ; $d19c: 03 ae     Invalid Opcode - SLO ($ae,x)
            .hex 03 78         ; $d19e: 03 78     Invalid Opcode - SLO ($78,x)
            .hex 03 48         ; $d1a0: 03 48     Invalid Opcode - SLO ($48,x)
            .hex 03 1f         ; $d1a2: 03 1f     Invalid Opcode - SLO ($1f,x)
            .hex 03 fa         ; $d1a4: 03 fa     Invalid Opcode - SLO ($fa,x)
            .hex 02            ; $d1a6: 02        Invalid Opcode - KIL
            .hex da            ; $d1a7: da        Invalid Opcode - NOP
            .hex 02            ; $d1a8: 02        Invalid Opcode - KIL
            lda $a302,x        ; $d1a9: bd 02 a3
            .hex 02            ; $d1ac: 02        Invalid Opcode - KIL
            sty $7802          ; $d1ad: 8c 02 78
            .hex 02            ; $d1b0: 02        Invalid Opcode - KIL
            adc $02            ; $d1b1: 65 02
            .hex 54 02         ; $d1b3: 54 02     Invalid Opcode - NOP $02,x
            eor $02            ; $d1b5: 45 02
            sec                ; $d1b7: 38
            .hex 02            ; $d1b8: 02        Invalid Opcode - KIL
            bit $2102          ; $d1b9: 2c 02 21
            .hex 02            ; $d1bc: 02        Invalid Opcode - KIL
            .hex 17 02         ; $d1bd: 17 02     Invalid Opcode - SLO $02,x
            asl $0702          ; $d1bf: 0e 02 07
            .hex 02            ; $d1c2: 02        Invalid Opcode - KIL
            brk                ; $d1c3: 00
            .hex 02            ; $d1c4: 02        Invalid Opcode - KIL
            .hex fa            ; $d1c5: fa        Invalid Opcode - NOP
            ora ($f5,x)        ; $d1c6: 01 f5
            ora ($f1,x)        ; $d1c8: 01 f1
            ora ($ed,x)        ; $d1ca: 01 ed
            ora ($eb,x)        ; $d1cc: 01 eb
            ora ($e8,x)        ; $d1ce: 01 e8
            ora ($e7,x)        ; $d1d0: 01 e7
            ora ($e6,x)        ; $d1d2: 01 e6
            ora ($47,x)        ; $d1d4: 01 47
            .hex 64 71         ; $d1d6: 64 71     Invalid Opcode - NOP $71
            and ($15,x)        ; $d1d8: 21 15
            .hex 14 5e         ; $d1da: 14 5e     Invalid Opcode - NOP $5e,x
            asl $0b32          ; $d1dc: 0e 32 0b
            rol __ca09         ; $d1df: 2e 09 ca
            .hex 07 c6         ; $d1e2: 07 c6     Invalid Opcode - SLO $c6
            asl $00            ; $d1e4: 06 00
            asl $64            ; $d1e6: 06 64
            ora $e6            ; $d1e8: 05 e6
            .hex 04 7f         ; $d1ea: 04 7f     Invalid Opcode - NOP $7f
            .hex 04 29         ; $d1ec: 04 29     Invalid Opcode - NOP $29
            .hex 04 e0         ; $d1ee: 04 e0     Invalid Opcode - NOP $e0
            .hex 03 a2         ; $d1f0: 03 a2     Invalid Opcode - SLO ($a2,x)
            .hex 03 6c         ; $d1f2: 03 6c     Invalid Opcode - SLO ($6c,x)
            .hex 03 3e         ; $d1f4: 03 3e     Invalid Opcode - SLO ($3e,x)
            .hex 03 15         ; $d1f6: 03 15     Invalid Opcode - SLO ($15,x)
            .hex 03 f0         ; $d1f8: 03 f0     Invalid Opcode - SLO ($f0,x)
            .hex 02            ; $d1fa: 02        Invalid Opcode - KIL
            bne __d1ff         ; $d1fb: d0 02
            ldy $02,x          ; $d1fd: b4 02
__d1ff:     .hex 9b            ; $d1ff: 9b        Invalid Opcode - TAS
            .hex 02            ; $d200: 02        Invalid Opcode - KIL
            sty $02            ; $d201: 84 02
            .hex 6f 02 5d      ; $d203: 6f 02 5d  Invalid Opcode - RRA $5d02
            .hex 02            ; $d206: 02        Invalid Opcode - KIL
            eor $3e02          ; $d207: 4d 02 3e
            .hex 02            ; $d20a: 02        Invalid Opcode - KIL
            bmi __d20f         ; $d20b: 30 02
            bit $02            ; $d20d: 24 02
__d20f:     .hex 1a            ; $d20f: 1a        Invalid Opcode - NOP
            .hex 02            ; $d210: 02        Invalid Opcode - KIL
            bpl __d215         ; $d211: 10 02
            php                ; $d213: 08
            .hex 02            ; $d214: 02        Invalid Opcode - KIL
__d215:     brk                ; $d215: 00
            .hex 02            ; $d216: 02        Invalid Opcode - KIL
            sbc __f401,y       ; $d217: f9 01 f4
            ora ($ef,x)        ; $d21a: 01 ef
            ora ($ea,x)        ; $d21c: 01 ea
            ora ($e7,x)        ; $d21e: 01 e7
            ora ($e4,x)        ; $d220: 01 e4
            ora ($e2,x)        ; $d222: 01 e2
            ora ($e1,x)        ; $d224: 01 e1
            ora ($e0,x)        ; $d226: 01 e0
            ora ($d1,x)        ; $d228: 01 d1
            .hex 62            ; $d22a: 62        Invalid Opcode - KIL
            .hex f4 20         ; $d22b: f4 20     Invalid Opcode - NOP $20,x
            dex                ; $d22d: ca
            .hex 13 28         ; $d22e: 13 28     Invalid Opcode - SLO ($28),y
            asl $0b08          ; $d230: 0e 08 0b
            .hex 0c 09 ad      ; $d233: 0c 09 ad  Invalid Opcode - NOP $ad09
            .hex 07 ad         ; $d236: 07 ad     Invalid Opcode - SLO $ad
            asl $e9            ; $d238: 06 e9
            ora $50            ; $d23a: 05 50
            ora $d4            ; $d23c: 05 d4
            .hex 04 6e         ; $d23e: 04 6e     Invalid Opcode - NOP $6e
            .hex 04 1a         ; $d240: 04 1a     Invalid Opcode - NOP $1a
            .hex 04 d2         ; $d242: 04 d2     Invalid Opcode - NOP $d2
            .hex 03 95         ; $d244: 03 95     Invalid Opcode - SLO ($95,x)
            .hex 03 60         ; $d246: 03 60     Invalid Opcode - SLO ($60,x)
            .hex 03 31         ; $d248: 03 31     Invalid Opcode - SLO ($31,x)
            .hex 03 09         ; $d24a: 03 09     Invalid Opcode - SLO ($09,x)
            .hex 03 e5         ; $d24c: 03 e5     Invalid Opcode - SLO ($e5,x)
            .hex 02            ; $d24e: 02        Invalid Opcode - KIL
            dec $02            ; $d24f: c6 02
            tax                ; $d251: aa
            .hex 02            ; $d252: 02        Invalid Opcode - KIL
            sta ($02),y        ; $d253: 91 02
            .hex 7a            ; $d255: 7a        Invalid Opcode - NOP
            .hex 02            ; $d256: 02        Invalid Opcode - KIL
            ror $02            ; $d257: 66 02
            .hex 54 02         ; $d259: 54 02     Invalid Opcode - NOP $02,x
            .hex 44 02         ; $d25b: 44 02     Invalid Opcode - NOP $02
            and $02,x          ; $d25d: 35 02
            plp                ; $d25f: 28
            .hex 02            ; $d260: 02        Invalid Opcode - KIL
            .hex 1c 02 12      ; $d261: 1c 02 12  Invalid Opcode - NOP $1202,x
            .hex 02            ; $d264: 02        Invalid Opcode - KIL
            php                ; $d265: 08
            .hex 02            ; $d266: 02        Invalid Opcode - KIL
            brk                ; $d267: 00
            .hex 02            ; $d268: 02        Invalid Opcode - KIL
            sbc __f201,y       ; $d269: f9 01 f2
            ora ($ec,x)        ; $d26c: 01 ec
            ora ($e7,x)        ; $d26e: 01 e7
            ora ($e3,x)        ; $d270: 01 e3
            ora ($e0,x)        ; $d272: 01 e0
            ora ($dd,x)        ; $d274: 01 dd
            ora ($db,x)        ; $d276: 01 db
            ora ($da,x)        ; $d278: 01 da
            ora ($d9,x)        ; $d27a: 01 d9
            ora ($38,x)        ; $d27c: 01 38
            adc ($6c,x)        ; $d27e: 61 6c
            jsr $1378          ; $d280: 20 78 13
            sbc __da0d         ; $d283: ed 0d da
            asl                ; $d286: 0a
            inc $08            ; $d287: e6 08
            sta $9107          ; $d289: 8d 07 91
            asl $d1            ; $d28c: 06 d1
            ora $3a            ; $d28e: 05 3a
            ora $c0            ; $d290: 05 c0
            .hex 04 5c         ; $d292: 04 5c     Invalid Opcode - NOP $5c
            .hex 04 09         ; $d294: 04 09     Invalid Opcode - NOP $09
            .hex 04 c2         ; $d296: 04 c2     Invalid Opcode - NOP $c2
            .hex 03 86         ; $d298: 03 86     Invalid Opcode - SLO ($86,x)
            .hex 03 52         ; $d29a: 03 52     Invalid Opcode - SLO ($52,x)
            .hex 03 24         ; $d29c: 03 24     Invalid Opcode - SLO ($24,x)
            .hex 03 fc         ; $d29e: 03 fc     Invalid Opcode - SLO ($fc,x)
            .hex 02            ; $d2a0: 02        Invalid Opcode - KIL
            cmp $ba02,y        ; $d2a1: d9 02 ba
            .hex 02            ; $d2a4: 02        Invalid Opcode - KIL
            .hex 9f 02 86      ; $d2a5: 9f 02 86  Invalid Opcode - AHX $8602,y
            .hex 02            ; $d2a8: 02        Invalid Opcode - KIL
            bvs __d2ad         ; $d2a9: 70 02
            .hex 5c 02         ; $d2ab: 5c 02     Suspected data
__d2ad:     .hex 4b 02         ; $d2ad: 4b 02     Invalid Opcode - ALR #$02
            .hex 3b 02 2c      ; $d2af: 3b 02 2c  Invalid Opcode - RLA $2c02,y
            .hex 02            ; $d2b2: 02        Invalid Opcode - KIL
            .hex 1f 02 14      ; $d2b3: 1f 02 14  Invalid Opcode - SLO $1402,x
            .hex 02            ; $d2b6: 02        Invalid Opcode - KIL
            ora #$02           ; $d2b7: 09 02
            brk                ; $d2b9: 00
            .hex 02            ; $d2ba: 02        Invalid Opcode - KIL
            sed                ; $d2bb: f8
            ora ($f0,x)        ; $d2bc: 01 f0
            ora ($ea,x)        ; $d2be: 01 ea
            ora ($e4,x)        ; $d2c0: 01 e4
            ora ($df,x)        ; $d2c2: 01 df
            ora ($db,x)        ; $d2c4: 01 db
            ora ($d8,x)        ; $d2c6: 01 d8
            ora ($d5,x)        ; $d2c8: 01 d5
            ora ($d3,x)        ; $d2ca: 01 d3
            ora ($d2,x)        ; $d2cc: 01 d2
            ora ($d1,x)        ; $d2ce: 01 d1
            ora ($7b,x)        ; $d2d0: 01 7b
            .hex 5f d8 1f      ; $d2d2: 5f d8 1f  Invalid Opcode - SRE $1fd8,x
            .hex 1f 13 ae      ; $d2d5: 1f 13 ae  Invalid Opcode - SLO $ae13,x
            ora $0aa9          ; $d2d8: 0d a9 0a
            ldx $6b08,y        ; $d2db: be 08 6b
            .hex 07 73         ; $d2de: 07 73     Invalid Opcode - SLO $73
            asl $b6            ; $d2e0: 06 b6
            ora $22            ; $d2e2: 05 22
            ora $aa            ; $d2e4: 05 aa
            .hex 04 48         ; $d2e6: 04 48     Invalid Opcode - NOP $48
            .hex 04 f6         ; $d2e8: 04 f6     Invalid Opcode - NOP $f6
            .hex 03 b1         ; $d2ea: 03 b1     Invalid Opcode - SLO ($b1,x)
            .hex 03 76         ; $d2ec: 03 76     Invalid Opcode - SLO ($76,x)
            .hex 03 42         ; $d2ee: 03 42     Invalid Opcode - SLO ($42,x)
            .hex 03 16         ; $d2f0: 03 16     Invalid Opcode - SLO ($16,x)
            .hex 03 ef         ; $d2f2: 03 ef     Invalid Opcode - SLO ($ef,x)
            .hex 02            ; $d2f4: 02        Invalid Opcode - KIL
            cpy $ae02          ; $d2f5: cc 02 ae
            .hex 02            ; $d2f8: 02        Invalid Opcode - KIL
            .hex 93 02         ; $d2f9: 93 02     Invalid Opcode - AHX ($02),y
            .hex 7b 02 65      ; $d2fb: 7b 02 65  Invalid Opcode - RRA $6502,y
            .hex 02            ; $d2fe: 02        Invalid Opcode - KIL
            .hex 52            ; $d2ff: 52        Invalid Opcode - KIL
            .hex 02            ; $d300: 02        Invalid Opcode - KIL
            rti                ; $d301: 40

;-------------------------------------------------------------------------------
            .hex 02            ; $d302: 02        Invalid Opcode - KIL
            bmi __d307         ; $d303: 30 02
            .hex 22            ; $d305: 22        Invalid Opcode - KIL
            .hex 02            ; $d306: 02        Invalid Opcode - KIL
__d307:     asl $02,x          ; $d307: 16 02
            asl                ; $d309: 0a
            .hex 02            ; $d30a: 02        Invalid Opcode - KIL
            brk                ; $d30b: 00
            .hex 02            ; $d30c: 02        Invalid Opcode - KIL
            .hex f7 01         ; $d30d: f7 01     Invalid Opcode - ISC $01,x
            .hex ef 01 e8      ; $d30f: ef 01 e8  Invalid Opcode - ISC __e801
            ora ($e1,x)        ; $d312: 01 e1
            ora ($dc,x)        ; $d314: 01 dc
            ora ($d7,x)        ; $d316: 01 d7
            ora ($d3,x)        ; $d318: 01 d3
            ora ($d0,x)        ; $d31a: 01 d0
            ora ($cd,x)        ; $d31c: 01 cd
            ora ($cb,x)        ; $d31e: 01 cb
            ora ($ca,x)        ; $d320: 01 ca
            ora ($c9,x)        ; $d322: 01 c9
            ora ($9d,x)        ; $d324: 01 9d
            eor $1f38,x        ; $d326: 5d 38 1f
            cpy #$12           ; $d329: c0 12
            adc #$0d           ; $d32b: 69 0d
            .hex 73 0a         ; $d32d: 73 0a     Invalid Opcode - RRA ($0a),y
            .hex 92            ; $d32f: 92        Invalid Opcode - KIL
            php                ; $d330: 08
            lsr $07            ; $d331: 46 07
            .hex 53 06         ; $d333: 53 06     Invalid Opcode - SRE ($06),y
            txs                ; $d335: 9a
            ora $08            ; $d336: 05 08
            ora $93            ; $d338: 05 93
            .hex 04 33         ; $d33a: 04 33     Invalid Opcode - NOP $33
            .hex 04 e2         ; $d33c: 04 e2     Invalid Opcode - NOP $e2
            .hex 03 9e         ; $d33e: 03 9e     Invalid Opcode - SLO ($9e,x)
            .hex 03 64         ; $d340: 03 64     Invalid Opcode - SLO ($64,x)
            .hex 03 32         ; $d342: 03 32     Invalid Opcode - SLO ($32,x)
            .hex 03 06         ; $d344: 03 06     Invalid Opcode - SLO ($06,x)
            .hex 03 e0         ; $d346: 03 e0     Invalid Opcode - SLO ($e0,x)
            .hex 02            ; $d348: 02        Invalid Opcode - KIL
            ldx $a002,y        ; $d349: be 02 a0
            .hex 02            ; $d34c: 02        Invalid Opcode - KIL
            stx $02            ; $d34d: 86 02
            ror $5902          ; $d34f: 6e 02 59
            .hex 02            ; $d352: 02        Invalid Opcode - KIL
            lsr $02            ; $d353: 46 02
            and $02,x          ; $d355: 35 02
            and $02            ; $d357: 25 02
            clc                ; $d359: 18
            .hex 02            ; $d35a: 02        Invalid Opcode - KIL
            .hex 0b 02         ; $d35b: 0b 02     Invalid Opcode - ANC #$02
            brk                ; $d35d: 00
            .hex 02            ; $d35e: 02        Invalid Opcode - KIL
            inc $01,x          ; $d35f: f6 01
            sbc __e501         ; $d361: ed 01 e5
            ora ($de,x)        ; $d364: 01 de
            ora ($d8,x)        ; $d366: 01 d8
            ora ($d2,x)        ; $d368: 01 d2
            ora ($ce,x)        ; $d36a: 01 ce
            ora ($ca,x)        ; $d36c: 01 ca
            ora ($c7,x)        ; $d36e: 01 c7
            ora ($c4,x)        ; $d370: 01 c4
            ora ($c2,x)        ; $d372: 01 c2
            ora ($c1,x)        ; $d374: 01 c1
            ora ($c0,x)        ; $d376: 01 c0
            .hex 01            ; $d378: 01        Suspected data
__d379:     sbc ($6a),y        ; $d379: f1 6a
            sta $5423,x        ; $d37b: 9d 23 54
            ora $31,x          ; $d37e: 15 31
            .hex 0f c5 0b      ; $d380: 0f c5 0b  Invalid Opcode - SLO $0bc5
            stx $09,y          ; $d383: 96 09
            bpl __d38f         ; $d385: 10 08
            sbc ($06),y        ; $d387: f1 06
            .hex 14 06         ; $d389: 14 06     Invalid Opcode - NOP $06,x
            .hex 64 05         ; $d38b: 64 05     Invalid Opcode - NOP $05
            .hex d4 04         ; $d38d: d4 04     Invalid Opcode - NOP $04,x
__d38f:     .hex 5c 04 f6      ; $d38f: 5c 04 f6  Invalid Opcode - NOP __f604,x
            .hex 03 9e         ; $d392: 03 9e     Invalid Opcode - SLO ($9e,x)
            .hex 03 52         ; $d394: 03 52     Invalid Opcode - SLO ($52,x)
            .hex 03 0e         ; $d396: 03 0e     Invalid Opcode - SLO ($0e,x)
            .hex 03 d2         ; $d398: 03 d2     Invalid Opcode - SLO ($d2,x)
            .hex 02            ; $d39a: 02        Invalid Opcode - KIL
            .hex 9b            ; $d39b: 9b        Invalid Opcode - TAS
            .hex 02            ; $d39c: 02        Invalid Opcode - KIL
            ror                ; $d39d: 6a
            .hex 02            ; $d39e: 02        Invalid Opcode - KIL
            and $1402,x        ; $d39f: 3d 02 14
            .hex 02            ; $d3a2: 02        Invalid Opcode - KIL
            sbc __ca01         ; $d3a3: ed 01 ca
            ora ($a8,x)        ; $d3a6: 01 a8
            ora ($89,x)        ; $d3a8: 01 89
            ora ($6b,x)        ; $d3aa: 01 6b
            ora ($4f,x)        ; $d3ac: 01 4f
            ora ($35,x)        ; $d3ae: 01 35
            ora ($1b,x)        ; $d3b0: 01 1b
            ora ($02,x)        ; $d3b2: 01 02
            ora ($eb,x)        ; $d3b4: 01 eb
            brk                ; $d3b6: 00
            .hex d4 00         ; $d3b7: d4 00     Invalid Opcode - NOP $00,x
            ldx $a800,y        ; $d3b9: be 00 a8
            brk                ; $d3bc: 00
            sty $00,x          ; $d3bd: 94 00
            .hex 7f 00 6b      ; $d3bf: 7f 00 6b  Invalid Opcode - RRA $6b00,x
            brk                ; $d3c2: 00
__d3c3:     .hex 57 00         ; $d3c3: 57 00     Invalid Opcode - SRE $00,x
            .hex 43 00         ; $d3c5: 43 00     Invalid Opcode - SRE ($00,x)
            bmi __d3c9         ; $d3c7: 30 00
__d3c9:     ora $0a00,x        ; $d3c9: 1d 00 0a
            brk                ; $d3cc: 00
__d3cd:     .hex 25            ; $d3cd: 25        Suspected data
__d3ce:     cmp ($7d),y        ; $d3ce: d1 7d
            and #$d5           ; $d3d0: 29 d5
            sta ($2d,x)        ; $d3d2: 81 2d
            cmp $3185,y        ; $d3d4: d9 85 31
            cmp $3589,x        ; $d3d7: dd 89 35
            sbc ($e1,x)        ; $d3da: e1 e1
            and $89,x          ; $d3dc: 35 89
            cmp $8531,x        ; $d3de: dd 31 85
            cmp $812d,y        ; $d3e1: d9 2d 81
            cmp $29,x          ; $d3e4: d5 29
            adc $25d1,x        ; $d3e6: 7d d1 25
__d3e9:     .hex d3 d2         ; $d3e9: d3 d2     Invalid Opcode - DCP ($d2),y
            .hex d2            ; $d3eb: d2        Invalid Opcode - KIL
            .hex d2            ; $d3ec: d2        Invalid Opcode - KIL
            cmp ($d1),y        ; $d3ed: d1 d1
            cmp ($d0),y        ; $d3ef: d1 d0
            bne __d3c3         ; $d3f1: d0 d0
            .hex cf cf cf      ; $d3f3: cf cf cf  Invalid Opcode - DCP __cfcf
            dec __cfce         ; $d3f6: ce ce cf
            .hex cf cf d0      ; $d3f9: cf cf d0  Invalid Opcode - DCP __d0cf
            bne __d3ce         ; $d3fc: d0 d0
            cmp ($d1),y        ; $d3fe: d1 d1
            cmp ($d2),y        ; $d400: d1 d2
            .hex d2            ; $d402: d2        Invalid Opcode - KIL
            .hex d2            ; $d403: d2        Invalid Opcode - KIL
            .hex d3            ; $d404: d3        Suspected data
__d405:     ora ($01,x)        ; $d405: 01 01
            .hex 34 dc         ; $d407: 34 dc     Invalid Opcode - NOP $dc,x
            ora ($a3,x)        ; $d409: 01 a3
            .hex 9e 67 b5      ; $d40b: 9e 67 b5  Invalid Opcode - SHX $b567,y
            .hex 5f 4a 65      ; $d40e: 5f 4a 65  Invalid Opcode - SRE $654a,x
            ldy $01            ; $d411: a4 01
            .hex 73 f8         ; $d413: 73 f8     Invalid Opcode - RRA ($f8),y
            sty __d72c         ; $d415: 8c 2c d7
            txa                ; $d418: 8a
            eor $06            ; $d419: 45 06
            cmp $6999          ; $d41b: cd 99 69
            and __ee14,x       ; $d41e: 3d 14 ee
            .hex cb aa         ; $d421: cb aa     Invalid Opcode - AXS #$aa
            .hex 8b 6e         ; $d423: 8b 6e     Invalid Opcode - XAA #$6e
            .hex 53 3a         ; $d425: 53 3a     Invalid Opcode - SRE ($3a),y
            .hex 22            ; $d427: 22        Invalid Opcode - KIL
            .hex 0b f6         ; $d428: 0b f6     Invalid Opcode - ANC #$f6
            .hex e2 cf         ; $d42a: e2 cf     Invalid Opcode - NOP #$cf
            ldy $9bab,x        ; $d42c: bc ab 9b
            .hex 8b 7c         ; $d42f: 8b 7c     Invalid Opcode - XAA #$7c
            ror $5360          ; $d431: 6e 60 53
            .hex 47 3b         ; $d434: 47 3b     Invalid Opcode - SRE $3b
            .hex 2f 24 19      ; $d436: 2f 24 19  Invalid Opcode - RLA $1924
            .hex 0f 05 fc      ; $d439: 0f 05 fc  Invalid Opcode - SLO __fc05
            .hex f3 ea         ; $d43c: f3 ea     Invalid Opcode - ISC ($ea),y
            sbc ($d9,x)        ; $d43e: e1 d9
            cmp ($c9),y        ; $d440: d1 c9
            .hex c2 bb         ; $d442: c2 bb     Invalid Opcode - NOP #$bb
            ldy $ad,x          ; $d444: b4 ad
            .hex a7 a0         ; $d446: a7 a0     Invalid Opcode - LAX $a0
            txs                ; $d448: 9a
            sty $8e,x          ; $d449: 94 8e
            .hex 89 83         ; $d44b: 89 83     Invalid Opcode - NOP #$83
            ror $7479,x        ; $d44d: 7e 79 74
            .hex 6f 6a 65      ; $d450: 6f 6a 65  Invalid Opcode - RRA $656a
            adc ($5c,x)        ; $d453: 61 5c
            cli                ; $d455: 58
            .hex 54 50         ; $d456: 54 50     Invalid Opcode - NOP $50,x
            jmp $4448          ; $d458: 4c 48 44

;-------------------------------------------------------------------------------
            rti                ; $d45b: 40

;-------------------------------------------------------------------------------
            .hex 3c 39 35      ; $d45c: 3c 39 35  Invalid Opcode - NOP $3539,x
            .hex 32            ; $d45f: 32        Invalid Opcode - KIL
            .hex 2f 2b 28      ; $d460: 2f 2b 28  Invalid Opcode - RLA $282b
            and $22            ; $d463: 25 22
            .hex 1f 1c 19      ; $d465: 1f 1c 19  Invalid Opcode - SLO $191c,x
__d468:     asl $14,x          ; $d468: 16 14
            ora ($0e),y        ; $d46a: 11 0e
            .hex 0c 09 07      ; $d46c: 0c 09 07  Invalid Opcode - NOP $0709
            .hex 04 02         ; $d46f: 04 02     Invalid Opcode - NOP $02
            .hex ff fd fb      ; $d471: ff fd fb  Invalid Opcode - ISC __fbfd,x
            sed                ; $d474: f8
            inc $f4,x          ; $d475: f6 f4
            .hex f2            ; $d477: f2        Invalid Opcode - KIL
            beq __d468         ; $d478: f0 ee
            cpx __e8ea         ; $d47a: ec ea e8
            inc $e4            ; $d47d: e6 e4
            .hex e2 e0         ; $d47f: e2 e0     Invalid Opcode - NOP #$e0
            .hex df dd db      ; $d481: df dd db  Invalid Opcode - DCP __dbdd,x
            cmp __d6d8,y       ; $d484: d9 d8 d6
            .hex d4 d3         ; $d487: d4 d3     Invalid Opcode - NOP $d3,x
            cmp ($d0),y        ; $d489: d1 d0
            dec __cbcd         ; $d48b: ce cd cb
            dex                ; $d48e: ca
            iny                ; $d48f: c8
            .hex c7 c5         ; $d490: c7 c5     Invalid Opcode - DCP $c5
            cpy $c3            ; $d492: c4 c3
            cmp ($c0,x)        ; $d494: c1 c0
            .hex bf bd bc      ; $d496: bf bd bc  Invalid Opcode - LAX $bcbd,y
            .hex bb b9 b8      ; $d499: bb b9 b8  Invalid Opcode - LAS $b8b9,y
            .hex b7 b6         ; $d49c: b7 b6     Invalid Opcode - LAX $b6,y
            lda $b3,x          ; $d49e: b5 b3
            .hex b2            ; $d4a0: b2        Invalid Opcode - KIL
            lda ($b0),y        ; $d4a1: b1 b0
            .hex af ae ad      ; $d4a3: af ae ad  Invalid Opcode - LAX $adae
            ldy $aaab          ; $d4a6: ac ab aa
            lda #$a8           ; $d4a9: a9 a8
            .hex a7 a6         ; $d4ab: a7 a6     Invalid Opcode - LAX $a6
            lda $a4            ; $d4ad: a5 a4
            .hex a3 a2         ; $d4af: a3 a2     Invalid Opcode - LAX ($a2,x)
            lda ($a0,x)        ; $d4b1: a1 a0
            .hex 9f 9e 9d      ; $d4b3: 9f 9e 9d  Invalid Opcode - AHX $9d9e,y
            .hex 9c 9b 9b      ; $d4b6: 9c 9b 9b  Invalid Opcode - SHY $9b9b,x
            txs                ; $d4b9: 9a
            sta $9798,y        ; $d4ba: 99 98 97
            stx $96,y          ; $d4bd: 96 96
            sta $94,x          ; $d4bf: 95 94
            .hex 93 92         ; $d4c1: 93 92     Invalid Opcode - AHX ($92),y
            .hex 92            ; $d4c3: 92        Invalid Opcode - KIL
            sta ($90),y        ; $d4c4: 91 90
            .hex 8f 8f 8e      ; $d4c6: 8f 8f 8e  Invalid Opcode - SAX $8e8f
            sta $8c8c          ; $d4c9: 8d 8c 8c
            .hex 8b 8a         ; $d4cc: 8b 8a     Invalid Opcode - XAA #$8a
            txa                ; $d4ce: 8a
            .hex 89 88         ; $d4cf: 89 88     Invalid Opcode - NOP #$88
            dey                ; $d4d1: 88
            .hex 87 86         ; $d4d2: 87 86     Invalid Opcode - SAX $86
            stx $85            ; $d4d4: 86 85
            sty $84            ; $d4d6: 84 84
            .hex 83 83         ; $d4d8: 83 83     Invalid Opcode - SAX ($83,x)
            .hex 82 81         ; $d4da: 82 81     Invalid Opcode - NOP #$81
            sta ($80,x)        ; $d4dc: 81 80
            .hex 80 7f         ; $d4de: 80 7f     Invalid Opcode - NOP #$7f
            ror $7d7e,x        ; $d4e0: 7e 7e 7d
            adc $7c7c,x        ; $d4e3: 7d 7c 7c
            .hex 7b 7b 7a      ; $d4e6: 7b 7b 7a  Invalid Opcode - RRA $7a7b,y
            adc $7879,y        ; $d4e9: 79 79 78
            sei                ; $d4ec: 78
            .hex 77 77         ; $d4ed: 77 77     Invalid Opcode - RRA $77,x
            ror $76,x          ; $d4ef: 76 76
            adc $75,x          ; $d4f1: 75 75
            .hex 74 74         ; $d4f3: 74 74     Invalid Opcode - NOP $74,x
            .hex 73 73         ; $d4f5: 73 73     Invalid Opcode - RRA ($73),y
            .hex 73 72         ; $d4f7: 73 72     Invalid Opcode - RRA ($72),y
            .hex 72            ; $d4f9: 72        Invalid Opcode - KIL
            adc ($71),y        ; $d4fa: 71 71
            bvs __d56e         ; $d4fc: 70 70
            .hex 6f 6f 6e      ; $d4fe: 6f 6f 6e  Invalid Opcode - RRA $6e6f
            ror $6d6e          ; $d501: 6e 6e 6d
__d504:     .hex 6d            ; $d504: 6d        Suspected data
__d505:     cld                ; $d505: d8
            pha                ; $d506: 48
            .hex 2b 1e         ; $d507: 2b 1e     Invalid Opcode - ANC #$1e
            clc                ; $d509: 18
            .hex 13 10         ; $d50a: 13 10     Invalid Opcode - SLO ($10),y
            asl $0b0c          ; $d50c: 0e 0c 0b
            asl                ; $d50f: 0a
            ora #$08           ; $d510: 09 08
            php                ; $d512: 08
            .hex 07 06         ; $d513: 07 06     Invalid Opcode - SLO $06
            asl $06            ; $d515: 06 06
            ora $05            ; $d517: 05 05
            ora $05            ; $d519: 05 05
            .hex 04 04         ; $d51b: 04 04     Invalid Opcode - NOP $04
            .hex 04 04         ; $d51d: 04 04     Invalid Opcode - NOP $04
            .hex 04 03         ; $d51f: 04 03     Invalid Opcode - NOP $03
            .hex 03 03         ; $d521: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 03 03         ; $d523: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 03 03         ; $d525: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 03 03         ; $d527: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 02            ; $d529: 02        Invalid Opcode - KIL
            .hex 02            ; $d52a: 02        Invalid Opcode - KIL
            .hex 02            ; $d52b: 02        Invalid Opcode - KIL
            .hex 02            ; $d52c: 02        Invalid Opcode - KIL
            .hex 02            ; $d52d: 02        Invalid Opcode - KIL
            .hex 02            ; $d52e: 02        Invalid Opcode - KIL
            .hex 02            ; $d52f: 02        Invalid Opcode - KIL
            .hex 02            ; $d530: 02        Invalid Opcode - KIL
            .hex 02            ; $d531: 02        Invalid Opcode - KIL
            .hex 02            ; $d532: 02        Invalid Opcode - KIL
            .hex 02            ; $d533: 02        Invalid Opcode - KIL
            .hex 02            ; $d534: 02        Invalid Opcode - KIL
            .hex 02            ; $d535: 02        Invalid Opcode - KIL
            .hex 02            ; $d536: 02        Invalid Opcode - KIL
            .hex 02            ; $d537: 02        Invalid Opcode - KIL
            .hex 02            ; $d538: 02        Invalid Opcode - KIL
            .hex 02            ; $d539: 02        Invalid Opcode - KIL
            .hex 02            ; $d53a: 02        Invalid Opcode - KIL
            ora ($01,x)        ; $d53b: 01 01
            ora ($01,x)        ; $d53d: 01 01
            ora ($01,x)        ; $d53f: 01 01
            ora ($01,x)        ; $d541: 01 01
            ora ($01,x)        ; $d543: 01 01
            ora ($01,x)        ; $d545: 01 01
            ora ($01,x)        ; $d547: 01 01
            ora ($01,x)        ; $d549: 01 01
            ora ($01,x)        ; $d54b: 01 01
            ora ($01,x)        ; $d54d: 01 01
            ora ($01,x)        ; $d54f: 01 01
            ora ($01,x)        ; $d551: 01 01
            ora ($01,x)        ; $d553: 01 01
            ora ($01,x)        ; $d555: 01 01
            ora ($01,x)        ; $d557: 01 01
            ora ($01,x)        ; $d559: 01 01
            ora ($01,x)        ; $d55b: 01 01
            ora ($01,x)        ; $d55d: 01 01
            ora ($01,x)        ; $d55f: 01 01
            ora ($01,x)        ; $d561: 01 01
            ora ($01,x)        ; $d563: 01 01
            ora ($01,x)        ; $d565: 01 01
            ora ($01,x)        ; $d567: 01 01
            ora ($01,x)        ; $d569: 01 01
            ora ($01,x)        ; $d56b: 01 01
            .hex 01            ; $d56d: 01        Suspected data
__d56e:     ora ($01,x)        ; $d56e: 01 01
            ora ($00,x)        ; $d570: 01 00
            brk                ; $d572: 00
            brk                ; $d573: 00
            brk                ; $d574: 00
            brk                ; $d575: 00
            brk                ; $d576: 00
            brk                ; $d577: 00
            brk                ; $d578: 00
            brk                ; $d579: 00
            brk                ; $d57a: 00
            brk                ; $d57b: 00
            brk                ; $d57c: 00
            brk                ; $d57d: 00
            brk                ; $d57e: 00
            brk                ; $d57f: 00
            brk                ; $d580: 00
            brk                ; $d581: 00
            brk                ; $d582: 00
            brk                ; $d583: 00
            brk                ; $d584: 00
            brk                ; $d585: 00
            brk                ; $d586: 00
            brk                ; $d587: 00
            brk                ; $d588: 00
            brk                ; $d589: 00
            brk                ; $d58a: 00
            brk                ; $d58b: 00
            brk                ; $d58c: 00
            brk                ; $d58d: 00
            brk                ; $d58e: 00
            brk                ; $d58f: 00
            brk                ; $d590: 00
            brk                ; $d591: 00
            brk                ; $d592: 00
            brk                ; $d593: 00
            brk                ; $d594: 00
            brk                ; $d595: 00
            brk                ; $d596: 00
            brk                ; $d597: 00
            brk                ; $d598: 00
            brk                ; $d599: 00
            brk                ; $d59a: 00
            brk                ; $d59b: 00
            brk                ; $d59c: 00
            brk                ; $d59d: 00
            brk                ; $d59e: 00
            brk                ; $d59f: 00
            brk                ; $d5a0: 00
            brk                ; $d5a1: 00
            brk                ; $d5a2: 00
            brk                ; $d5a3: 00
            brk                ; $d5a4: 00
            brk                ; $d5a5: 00
            brk                ; $d5a6: 00
            brk                ; $d5a7: 00
            brk                ; $d5a8: 00
            brk                ; $d5a9: 00
            brk                ; $d5aa: 00
            brk                ; $d5ab: 00
            brk                ; $d5ac: 00
            brk                ; $d5ad: 00
            brk                ; $d5ae: 00
            brk                ; $d5af: 00
            brk                ; $d5b0: 00
            brk                ; $d5b1: 00
            brk                ; $d5b2: 00
            brk                ; $d5b3: 00
            brk                ; $d5b4: 00
            brk                ; $d5b5: 00
            brk                ; $d5b6: 00
            brk                ; $d5b7: 00
            brk                ; $d5b8: 00
            brk                ; $d5b9: 00
            brk                ; $d5ba: 00
            brk                ; $d5bb: 00
            brk                ; $d5bc: 00
            brk                ; $d5bd: 00
            brk                ; $d5be: 00
            brk                ; $d5bf: 00
            brk                ; $d5c0: 00
            brk                ; $d5c1: 00
            brk                ; $d5c2: 00
            brk                ; $d5c3: 00
            brk                ; $d5c4: 00
            brk                ; $d5c5: 00
            brk                ; $d5c6: 00
            brk                ; $d5c7: 00
            brk                ; $d5c8: 00
            brk                ; $d5c9: 00
            brk                ; $d5ca: 00
            brk                ; $d5cb: 00
            brk                ; $d5cc: 00
            brk                ; $d5cd: 00
            brk                ; $d5ce: 00
            brk                ; $d5cf: 00
            brk                ; $d5d0: 00
            brk                ; $d5d1: 00
            brk                ; $d5d2: 00
            brk                ; $d5d3: 00
            brk                ; $d5d4: 00
            brk                ; $d5d5: 00
            brk                ; $d5d6: 00
            brk                ; $d5d7: 00
            brk                ; $d5d8: 00
            brk                ; $d5d9: 00
            brk                ; $d5da: 00
            brk                ; $d5db: 00
            brk                ; $d5dc: 00
            brk                ; $d5dd: 00
            brk                ; $d5de: 00
            brk                ; $d5df: 00
            brk                ; $d5e0: 00
            brk                ; $d5e1: 00
            brk                ; $d5e2: 00
            brk                ; $d5e3: 00
            brk                ; $d5e4: 00
            brk                ; $d5e5: 00
            brk                ; $d5e6: 00
            brk                ; $d5e7: 00
            brk                ; $d5e8: 00
            brk                ; $d5e9: 00
            brk                ; $d5ea: 00
            brk                ; $d5eb: 00
            brk                ; $d5ec: 00
            brk                ; $d5ed: 00
            brk                ; $d5ee: 00
            brk                ; $d5ef: 00
            brk                ; $d5f0: 00
            brk                ; $d5f1: 00
            brk                ; $d5f2: 00
            brk                ; $d5f3: 00
            brk                ; $d5f4: 00
            brk                ; $d5f5: 00
            brk                ; $d5f6: 00
            brk                ; $d5f7: 00
            brk                ; $d5f8: 00
            brk                ; $d5f9: 00
__d5fa:     brk                ; $d5fa: 00
            brk                ; $d5fb: 00
            brk                ; $d5fc: 00
            brk                ; $d5fd: 00
            brk                ; $d5fe: 00
            brk                ; $d5ff: 00
            brk                ; $d600: 00
            brk                ; $d601: 00
            brk                ; $d602: 00
            brk                ; $d603: 00
            brk                ; $d604: 00
__d605:     ora ($a2),y        ; $d605: 11 a2
            eor ($ff),y        ; $d607: 51 ff
            .hex 62            ; $d609: 62        Invalid Opcode - KIL
            .hex 22            ; $d60a: 22        Invalid Opcode - KIL
            .hex b3 ff         ; $d60b: b3 ff     Invalid Opcode - LAX ($ff),y
            sta ($73),y        ; $d60d: 91 73
            .hex 33            ; $d60f: 33        Suspected data
__d610:     rti                ; $d610: 40

;-------------------------------------------------------------------------------
            pha                ; $d611: 48
            .hex 44 4c         ; $d612: 44 4c     Invalid Opcode - NOP $4c
            .hex 42            ; $d614: 42        Invalid Opcode - KIL
            lsr                ; $d615: 4a
            lsr $4e            ; $d616: 46 4e
            eor ($49,x)        ; $d618: 41 49
            eor $4d            ; $d61a: 45 4d
            .hex 43 4b         ; $d61c: 43 4b     Invalid Opcode - SRE ($4b,x)
__d61e:     .hex 47 4f         ; $d61e: 47 4f     Invalid Opcode - SRE $4f
            bvc __d67a         ; $d620: 50 58
            .hex 54 5c         ; $d622: 54 5c     Invalid Opcode - NOP $5c,x
            .hex 52            ; $d624: 52        Invalid Opcode - KIL
            .hex 5a            ; $d625: 5a        Invalid Opcode - NOP
            lsr $5e,x          ; $d626: 56 5e
            eor ($59),y        ; $d628: 51 59
            eor $5d,x          ; $d62a: 55 5d
            .hex 53 5b         ; $d62c: 53 5b     Invalid Opcode - SRE ($5b),y
            .hex 57 5f         ; $d62e: 57 5f     Invalid Opcode - SRE $5f,x
            rts                ; $d630: 60

;-------------------------------------------------------------------------------
            pla                ; $d631: 68
            .hex 64 6c         ; $d632: 64 6c     Invalid Opcode - NOP $6c
            .hex 62            ; $d634: 62        Invalid Opcode - KIL
            ror                ; $d635: 6a
            ror $6e            ; $d636: 66 6e
            adc ($69,x)        ; $d638: 61 69
            adc $6d            ; $d63a: 65 6d
            .hex 63 6b         ; $d63c: 63 6b     Invalid Opcode - RRA ($6b,x)
            .hex 67 6f         ; $d63e: 67 6f     Invalid Opcode - RRA $6f
            bvs __d6ba         ; $d640: 70 78
            .hex 74 7c         ; $d642: 74 7c     Invalid Opcode - NOP $7c,x
            .hex 72            ; $d644: 72        Invalid Opcode - KIL
            .hex 7a            ; $d645: 7a        Invalid Opcode - NOP
            ror $7e,x          ; $d646: 76 7e
            adc ($79),y        ; $d648: 71 79
            adc $7d,x          ; $d64a: 75 7d
            .hex 73 7b         ; $d64c: 73 7b     Invalid Opcode - RRA ($7b),y
            .hex 77 7f         ; $d64e: 77 7f     Invalid Opcode - RRA $7f,x
__d650:     brk                ; $d650: 00
            asl                ; $d651: 0a
            .hex 13 1d         ; $d652: 13 1d     Invalid Opcode - SLO ($1d),y
            rol $30            ; $d654: 26 30
            and $4b42,y        ; $d656: 39 42 4b
            eor $5e,x          ; $d659: 55 5e
            ror $6f            ; $d65b: 66 6f
            sei                ; $d65d: 78
            .hex 80 88         ; $d65e: 80 88     Invalid Opcode - NOP #$88
            bcc __d5fa         ; $d660: 90 98
            ldy #$a7           ; $d662: a0 a7
            ldx $bcb5          ; $d664: ae b5 bc
            .hex c2 c8         ; $d667: c2 c8     Invalid Opcode - NOP #$c8
            dec __d9d4         ; $d669: ce d4 d9
            dec __e7e2,x       ; $d66c: de e2 e7
            .hex eb ee         ; $d66f: eb ee     Invalid Opcode - SBC #$ee
            .hex f2            ; $d671: f2        Invalid Opcode - KIL
__d672:     sbc $f7,x          ; $d672: f5 f7
            .hex fa            ; $d674: fa        Invalid Opcode - NOP
            .hex fc fd fe      ; $d675: fc fd fe  Invalid Opcode - NOP __fefd,x
            .hex ff 00         ; $d678: ff 00     Suspected data
__d67a:     brk                ; $d67a: 00
            brk                ; $d67b: 00
            .hex ff fe fd      ; $d67c: ff fe fd  Invalid Opcode - ISC __fdfe,x
            .hex fc fa f7      ; $d67f: fc fa f7  Invalid Opcode - NOP __f7fa,x
            sbc $f2,x          ; $d682: f5 f2
            inc __e7eb         ; $d684: ee eb e7
            .hex e2 de         ; $d687: e2 de     Invalid Opcode - NOP #$de
            cmp __ced4,y       ; $d689: d9 d4 ce
            iny                ; $d68c: c8
            .hex c2 bc         ; $d68d: c2 bc     Invalid Opcode - NOP #$bc
            lda $ae,x          ; $d68f: b5 ae
            .hex a7 a0         ; $d691: a7 a0     Invalid Opcode - LAX $a0
            tya                ; $d693: 98
            bcc __d61e         ; $d694: 90 88
            .hex 80 78         ; $d696: 80 78     Invalid Opcode - NOP #$78
            .hex 6f 66 5e      ; $d698: 6f 66 5e  Invalid Opcode - RRA $5e66
            eor $4b,x          ; $d69b: 55 4b
            .hex 42            ; $d69d: 42        Invalid Opcode - KIL
            and $2630,y        ; $d69e: 39 30 26
            ora $0a13,x        ; $d6a1: 1d 13 0a
            brk                ; $d6a4: 00
            inc $ed,x          ; $d6a5: f6 ed
            .hex e3 da         ; $d6a7: e3 da     Invalid Opcode - ISC ($da,x)
            bne __d672         ; $d6a9: d0 c7
            ldx $abb5,y        ; $d6ab: be b5 ab
            ldx #$9a           ; $d6ae: a2 9a
            sta ($88),y        ; $d6b0: 91 88
            .hex 80 78         ; $d6b2: 80 78     Invalid Opcode - NOP #$78
            bvs __d71e         ; $d6b4: 70 68
            rts                ; $d6b6: 60

;-------------------------------------------------------------------------------
            eor $4b52,y        ; $d6b7: 59 52 4b
__d6ba:     .hex 44 3e         ; $d6ba: 44 3e     Invalid Opcode - NOP $3e
            sec                ; $d6bc: 38
            .hex 32            ; $d6bd: 32        Invalid Opcode - KIL
            bit $2227          ; $d6be: 2c 27 22
            asl $1519,x        ; $d6c1: 1e 19 15
            .hex 12            ; $d6c4: 12        Invalid Opcode - KIL
            asl $090b          ; $d6c5: 0e 0b 09
            asl $04            ; $d6c8: 06 04
            .hex 03 02         ; $d6ca: 03 02     Invalid Opcode - SLO ($02,x)
            ora ($00,x)        ; $d6cc: 01 00
            brk                ; $d6ce: 00
            brk                ; $d6cf: 00
            ora ($02,x)        ; $d6d0: 01 02
            .hex 03 04         ; $d6d2: 03 04     Invalid Opcode - SLO ($04,x)
            asl $09            ; $d6d4: 06 09
            .hex 0b 0e         ; $d6d6: 0b 0e     Invalid Opcode - ANC #$0e
__d6d8:     .hex 12            ; $d6d8: 12        Invalid Opcode - KIL
            ora $19,x          ; $d6d9: 15 19
            asl $2722,x        ; $d6db: 1e 22 27
            bit $3832          ; $d6de: 2c 32 38
            rol $4b44,x        ; $d6e1: 3e 44 4b
            .hex 52            ; $d6e4: 52        Invalid Opcode - KIL
            eor $6860,y        ; $d6e5: 59 60 68
            bvs __d762         ; $d6e8: 70 78
            .hex 80 88         ; $d6ea: 80 88     Invalid Opcode - NOP #$88
            sta ($9a),y        ; $d6ec: 91 9a
            ldx #$ab           ; $d6ee: a2 ab
            lda $be,x          ; $d6f0: b5 be
            .hex c7 d0         ; $d6f2: c7 d0     Invalid Opcode - DCP $d0
            .hex da            ; $d6f4: da        Invalid Opcode - NOP
            .hex e3 ed         ; $d6f5: e3 ed     Invalid Opcode - ISC ($ed,x)
            .hex f6            ; $d6f7: f6        Suspected data
__d6f8:     brk                ; $d6f8: 00
            brk                ; $d6f9: 00
            brk                ; $d6fa: 00
            brk                ; $d6fb: 00
            brk                ; $d6fc: 00
            brk                ; $d6fd: 00
            brk                ; $d6fe: 00
            brk                ; $d6ff: 00
            brk                ; $d700: 00
            brk                ; $d701: 00
            brk                ; $d702: 00
            brk                ; $d703: 00
            brk                ; $d704: 00
            brk                ; $d705: 00
            brk                ; $d706: 00
            brk                ; $d707: 00
            brk                ; $d708: 00
            brk                ; $d709: 00
            brk                ; $d70a: 00
            brk                ; $d70b: 00
            brk                ; $d70c: 00
            brk                ; $d70d: 00
            brk                ; $d70e: 00
            brk                ; $d70f: 00
            brk                ; $d710: 00
            brk                ; $d711: 00
            brk                ; $d712: 00
            brk                ; $d713: 00
            brk                ; $d714: 00
            brk                ; $d715: 00
            brk                ; $d716: 00
            brk                ; $d717: 00
            brk                ; $d718: 00
            brk                ; $d719: 00
            brk                ; $d71a: 00
            brk                ; $d71b: 00
            brk                ; $d71c: 00
            brk                ; $d71d: 00
__d71e:     brk                ; $d71e: 00
            brk                ; $d71f: 00
            brk                ; $d720: 00
            ora ($01,x)        ; $d721: 01 01
            ora ($00,x)        ; $d723: 01 00
            brk                ; $d725: 00
            brk                ; $d726: 00
            brk                ; $d727: 00
            brk                ; $d728: 00
            brk                ; $d729: 00
            brk                ; $d72a: 00
            brk                ; $d72b: 00
__d72c:     brk                ; $d72c: 00
            brk                ; $d72d: 00
            brk                ; $d72e: 00
            brk                ; $d72f: 00
            brk                ; $d730: 00
            brk                ; $d731: 00
            brk                ; $d732: 00
            brk                ; $d733: 00
            brk                ; $d734: 00
            brk                ; $d735: 00
            brk                ; $d736: 00
            brk                ; $d737: 00
            brk                ; $d738: 00
            brk                ; $d739: 00
            brk                ; $d73a: 00
            brk                ; $d73b: 00
            brk                ; $d73c: 00
            brk                ; $d73d: 00
            brk                ; $d73e: 00
            brk                ; $d73f: 00
            brk                ; $d740: 00
            brk                ; $d741: 00
            brk                ; $d742: 00
            brk                ; $d743: 00
            brk                ; $d744: 00
            brk                ; $d745: 00
            brk                ; $d746: 00
            brk                ; $d747: 00
            brk                ; $d748: 00
            brk                ; $d749: 00
            brk                ; $d74a: 00
            brk                ; $d74b: 00
            brk                ; $d74c: 00
            .hex ff ff ff      ; $d74d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d750: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d753: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d756: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d759: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d75c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d75f: ff ff ff  Invalid Opcode - ISC $ffff,x
__d762:     .hex ff ff ff      ; $d762: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d765: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d768: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d76b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d76e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d771: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d774: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d777: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d77a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d77d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d780: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d783: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d786: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d789: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d78c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d78f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d792: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d795: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d798: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $d79b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff 00      ; $d79e: ff ff 00  Bad Addr Mode - ISC $00ff,x
            brk                ; $d7a1: 00
            brk                ; $d7a2: 00
            brk                ; $d7a3: 00
            brk                ; $d7a4: 00
            brk                ; $d7a5: 00
            brk                ; $d7a6: 00
            brk                ; $d7a7: 00
            brk                ; $d7a8: 00
            brk                ; $d7a9: 00
            brk                ; $d7aa: 00
            brk                ; $d7ab: 00
            brk                ; $d7ac: 00
            brk                ; $d7ad: 00
            brk                ; $d7ae: 00
            brk                ; $d7af: 00
            brk                ; $d7b0: 00
            brk                ; $d7b1: 00
            brk                ; $d7b2: 00
            brk                ; $d7b3: 00
            brk                ; $d7b4: 00
            brk                ; $d7b5: 00
            brk                ; $d7b6: 00
            brk                ; $d7b7: 00
            brk                ; $d7b8: 00
            brk                ; $d7b9: 00
            brk                ; $d7ba: 00
            brk                ; $d7bb: 00
            brk                ; $d7bc: 00
            brk                ; $d7bd: 00
            brk                ; $d7be: 00
            brk                ; $d7bf: 00
            brk                ; $d7c0: 00
            brk                ; $d7c1: 00
            brk                ; $d7c2: 00
            brk                ; $d7c3: 00
            brk                ; $d7c4: 00
            brk                ; $d7c5: 00
            brk                ; $d7c6: 00
            brk                ; $d7c7: 00
            brk                ; $d7c8: 00
            brk                ; $d7c9: 00
            brk                ; $d7ca: 00
            brk                ; $d7cb: 00
            brk                ; $d7cc: 00
            brk                ; $d7cd: 00
            brk                ; $d7ce: 00
            brk                ; $d7cf: 00
            brk                ; $d7d0: 00
            brk                ; $d7d1: 00
            brk                ; $d7d2: 00
            brk                ; $d7d3: 00
            brk                ; $d7d4: 00
            brk                ; $d7d5: 00
            brk                ; $d7d6: 00
            brk                ; $d7d7: 00
            brk                ; $d7d8: 00
            brk                ; $d7d9: 00
            brk                ; $d7da: 00
            brk                ; $d7db: 00
            brk                ; $d7dc: 00
            brk                ; $d7dd: 00
            brk                ; $d7de: 00
            brk                ; $d7df: 00
            brk                ; $d7e0: 00
            brk                ; $d7e1: 00
            brk                ; $d7e2: 00
            brk                ; $d7e3: 00
            brk                ; $d7e4: 00
            brk                ; $d7e5: 00
            brk                ; $d7e6: 00
            brk                ; $d7e7: 00
            brk                ; $d7e8: 00
            brk                ; $d7e9: 00
            brk                ; $d7ea: 00
            brk                ; $d7eb: 00
            brk                ; $d7ec: 00
            brk                ; $d7ed: 00
            brk                ; $d7ee: 00
            brk                ; $d7ef: 00
            brk                ; $d7f0: 00
            brk                ; $d7f1: 00
            brk                ; $d7f2: 00
            brk                ; $d7f3: 00
            brk                ; $d7f4: 00
            brk                ; $d7f5: 00
            brk                ; $d7f6: 00
            brk                ; $d7f7: 00
            brk                ; $d7f8: 00
            brk                ; $d7f9: 00
            brk                ; $d7fa: 00
            brk                ; $d7fb: 00
            brk                ; $d7fc: 00
            brk                ; $d7fd: 00
            brk                ; $d7fe: 00
            brk                ; $d7ff: 00
            brk                ; $d800: 00
            brk                ; $d801: 00
            brk                ; $d802: 00
            brk                ; $d803: 00
            brk                ; $d804: 00
            brk                ; $d805: 00
            brk                ; $d806: 00
            brk                ; $d807: 00
            brk                ; $d808: 00
            brk                ; $d809: 00
            brk                ; $d80a: 00
            brk                ; $d80b: 00
            brk                ; $d80c: 00
            brk                ; $d80d: 00
            brk                ; $d80e: 00
            brk                ; $d80f: 00
            brk                ; $d810: 00
            brk                ; $d811: 00
            brk                ; $d812: 00
            brk                ; $d813: 00
            brk                ; $d814: 00
            brk                ; $d815: 00
            brk                ; $d816: 00
            brk                ; $d817: 00
            brk                ; $d818: 00
            brk                ; $d819: 00
            brk                ; $d81a: 00
            brk                ; $d81b: 00
            brk                ; $d81c: 00
            brk                ; $d81d: 00
            brk                ; $d81e: 00
            brk                ; $d81f: 00
            brk                ; $d820: 00
            brk                ; $d821: 00
            brk                ; $d822: 00
            brk                ; $d823: 00
            brk                ; $d824: 00
            brk                ; $d825: 00
            brk                ; $d826: 00
            brk                ; $d827: 00
            brk                ; $d828: 00
            brk                ; $d829: 00
            brk                ; $d82a: 00
            brk                ; $d82b: 00
            brk                ; $d82c: 00
            brk                ; $d82d: 00
            brk                ; $d82e: 00
            brk                ; $d82f: 00
            brk                ; $d830: 00
            brk                ; $d831: 00
            brk                ; $d832: 00
            brk                ; $d833: 00
            brk                ; $d834: 00
            brk                ; $d835: 00
            brk                ; $d836: 00
            brk                ; $d837: 00
            brk                ; $d838: 00
            brk                ; $d839: 00
            brk                ; $d83a: 00
            brk                ; $d83b: 00
            brk                ; $d83c: 00
            brk                ; $d83d: 00
            brk                ; $d83e: 00
            brk                ; $d83f: 00
            brk                ; $d840: 00
            brk                ; $d841: 00
            brk                ; $d842: 00
            brk                ; $d843: 00
            brk                ; $d844: 00
            brk                ; $d845: 00
            brk                ; $d846: 00
            brk                ; $d847: 00
            brk                ; $d848: 00
            brk                ; $d849: 00
            brk                ; $d84a: 00
            brk                ; $d84b: 00
            brk                ; $d84c: 00
            brk                ; $d84d: 00
            brk                ; $d84e: 00
            brk                ; $d84f: 00
            brk                ; $d850: 00
            brk                ; $d851: 00
            brk                ; $d852: 00
            brk                ; $d853: 00
            brk                ; $d854: 00
            brk                ; $d855: 00
            brk                ; $d856: 00
            brk                ; $d857: 00
            brk                ; $d858: 00
            brk                ; $d859: 00
            brk                ; $d85a: 00
            brk                ; $d85b: 00
            brk                ; $d85c: 00
            brk                ; $d85d: 00
            brk                ; $d85e: 00
            brk                ; $d85f: 00
            brk                ; $d860: 00
            brk                ; $d861: 00
            brk                ; $d862: 00
            brk                ; $d863: 00
            brk                ; $d864: 00
            brk                ; $d865: 00
            brk                ; $d866: 00
            brk                ; $d867: 00
            brk                ; $d868: 00
            brk                ; $d869: 00
            brk                ; $d86a: 00
            brk                ; $d86b: 00
            brk                ; $d86c: 00
            brk                ; $d86d: 00
            brk                ; $d86e: 00
            brk                ; $d86f: 00
            brk                ; $d870: 00
            brk                ; $d871: 00
            brk                ; $d872: 00
            brk                ; $d873: 00
            brk                ; $d874: 00
            brk                ; $d875: 00
            brk                ; $d876: 00
            brk                ; $d877: 00
            brk                ; $d878: 00
            brk                ; $d879: 00
            brk                ; $d87a: 00
            brk                ; $d87b: 00
            brk                ; $d87c: 00
            brk                ; $d87d: 00
            brk                ; $d87e: 00
            brk                ; $d87f: 00
            brk                ; $d880: 00
            brk                ; $d881: 00
            brk                ; $d882: 00
            brk                ; $d883: 00
            brk                ; $d884: 00
            brk                ; $d885: 00
            brk                ; $d886: 00
            brk                ; $d887: 00
            brk                ; $d888: 00
            brk                ; $d889: 00
            brk                ; $d88a: 00
            brk                ; $d88b: 00
            brk                ; $d88c: 00
            brk                ; $d88d: 00
            brk                ; $d88e: 00
            brk                ; $d88f: 00
            brk                ; $d890: 00
            brk                ; $d891: 00
            brk                ; $d892: 00
            brk                ; $d893: 00
            brk                ; $d894: 00
            brk                ; $d895: 00
            brk                ; $d896: 00
            brk                ; $d897: 00
            brk                ; $d898: 00
            brk                ; $d899: 00
            brk                ; $d89a: 00
            brk                ; $d89b: 00
            brk                ; $d89c: 00
            brk                ; $d89d: 00
            brk                ; $d89e: 00
            brk                ; $d89f: 00
            brk                ; $d8a0: 00
            brk                ; $d8a1: 00
            brk                ; $d8a2: 00
            brk                ; $d8a3: 00
            brk                ; $d8a4: 00
            brk                ; $d8a5: 00
            brk                ; $d8a6: 00
            brk                ; $d8a7: 00
            brk                ; $d8a8: 00
            brk                ; $d8a9: 00
            brk                ; $d8aa: 00
            brk                ; $d8ab: 00
            brk                ; $d8ac: 00
            brk                ; $d8ad: 00
            brk                ; $d8ae: 00
            brk                ; $d8af: 00
            brk                ; $d8b0: 00
            brk                ; $d8b1: 00
            brk                ; $d8b2: 00
            brk                ; $d8b3: 00
            brk                ; $d8b4: 00
            brk                ; $d8b5: 00
            brk                ; $d8b6: 00
            brk                ; $d8b7: 00
            brk                ; $d8b8: 00
            brk                ; $d8b9: 00
            brk                ; $d8ba: 00
            brk                ; $d8bb: 00
            brk                ; $d8bc: 00
            brk                ; $d8bd: 00
            brk                ; $d8be: 00
            brk                ; $d8bf: 00
            brk                ; $d8c0: 00
            brk                ; $d8c1: 00
            brk                ; $d8c2: 00
            brk                ; $d8c3: 00
            brk                ; $d8c4: 00
            brk                ; $d8c5: 00
            brk                ; $d8c6: 00
            brk                ; $d8c7: 00
            brk                ; $d8c8: 00
            brk                ; $d8c9: 00
            brk                ; $d8ca: 00
            brk                ; $d8cb: 00
            brk                ; $d8cc: 00
            brk                ; $d8cd: 00
            brk                ; $d8ce: 00
            brk                ; $d8cf: 00
            brk                ; $d8d0: 00
            brk                ; $d8d1: 00
            brk                ; $d8d2: 00
            brk                ; $d8d3: 00
            brk                ; $d8d4: 00
            brk                ; $d8d5: 00
            brk                ; $d8d6: 00
            brk                ; $d8d7: 00
            brk                ; $d8d8: 00
            brk                ; $d8d9: 00
            brk                ; $d8da: 00
            brk                ; $d8db: 00
            brk                ; $d8dc: 00
            brk                ; $d8dd: 00
            brk                ; $d8de: 00
            brk                ; $d8df: 00
            brk                ; $d8e0: 00
            brk                ; $d8e1: 00
            brk                ; $d8e2: 00
            brk                ; $d8e3: 00
            brk                ; $d8e4: 00
            brk                ; $d8e5: 00
            brk                ; $d8e6: 00
            brk                ; $d8e7: 00
            brk                ; $d8e8: 00
            brk                ; $d8e9: 00
            brk                ; $d8ea: 00
            brk                ; $d8eb: 00
            brk                ; $d8ec: 00
            brk                ; $d8ed: 00
            brk                ; $d8ee: 00
            brk                ; $d8ef: 00
            brk                ; $d8f0: 00
            brk                ; $d8f1: 00
            brk                ; $d8f2: 00
            brk                ; $d8f3: 00
            brk                ; $d8f4: 00
            brk                ; $d8f5: 00
            brk                ; $d8f6: 00
            brk                ; $d8f7: 00
            brk                ; $d8f8: 00
            brk                ; $d8f9: 00
            brk                ; $d8fa: 00
            brk                ; $d8fb: 00
            brk                ; $d8fc: 00
            brk                ; $d8fd: 00
            brk                ; $d8fe: 00
            brk                ; $d8ff: 00
            brk                ; $d900: 00
            brk                ; $d901: 00
            brk                ; $d902: 00
            brk                ; $d903: 00
            brk                ; $d904: 00
            brk                ; $d905: 00
            brk                ; $d906: 00
            brk                ; $d907: 00
            brk                ; $d908: 00
            brk                ; $d909: 00
            brk                ; $d90a: 00
            brk                ; $d90b: 00
            brk                ; $d90c: 00
            brk                ; $d90d: 00
            brk                ; $d90e: 00
            brk                ; $d90f: 00
            brk                ; $d910: 00
            brk                ; $d911: 00
            brk                ; $d912: 00
            brk                ; $d913: 00
            brk                ; $d914: 00
            brk                ; $d915: 00
            brk                ; $d916: 00
            brk                ; $d917: 00
            brk                ; $d918: 00
            brk                ; $d919: 00
            brk                ; $d91a: 00
            brk                ; $d91b: 00
            brk                ; $d91c: 00
            brk                ; $d91d: 00
            brk                ; $d91e: 00
            brk                ; $d91f: 00
            brk                ; $d920: 00
            brk                ; $d921: 00
            brk                ; $d922: 00
            brk                ; $d923: 00
            brk                ; $d924: 00
            brk                ; $d925: 00
            brk                ; $d926: 00
            brk                ; $d927: 00
            brk                ; $d928: 00
            brk                ; $d929: 00
            brk                ; $d92a: 00
            brk                ; $d92b: 00
            brk                ; $d92c: 00
            brk                ; $d92d: 00
            brk                ; $d92e: 00
            brk                ; $d92f: 00
            brk                ; $d930: 00
            brk                ; $d931: 00
            brk                ; $d932: 00
            brk                ; $d933: 00
            brk                ; $d934: 00
            brk                ; $d935: 00
            brk                ; $d936: 00
            brk                ; $d937: 00
            brk                ; $d938: 00
            brk                ; $d939: 00
            brk                ; $d93a: 00
            brk                ; $d93b: 00
            brk                ; $d93c: 00
            brk                ; $d93d: 00
            brk                ; $d93e: 00
            brk                ; $d93f: 00
            brk                ; $d940: 00
            brk                ; $d941: 00
            brk                ; $d942: 00
            brk                ; $d943: 00
            brk                ; $d944: 00
            brk                ; $d945: 00
            brk                ; $d946: 00
            brk                ; $d947: 00
            brk                ; $d948: 00
            brk                ; $d949: 00
            brk                ; $d94a: 00
            brk                ; $d94b: 00
            brk                ; $d94c: 00
            brk                ; $d94d: 00
            brk                ; $d94e: 00
            brk                ; $d94f: 00
            brk                ; $d950: 00
            brk                ; $d951: 00
            brk                ; $d952: 00
            brk                ; $d953: 00
            brk                ; $d954: 00
            brk                ; $d955: 00
            brk                ; $d956: 00
            brk                ; $d957: 00
            brk                ; $d958: 00
            brk                ; $d959: 00
            brk                ; $d95a: 00
            brk                ; $d95b: 00
            brk                ; $d95c: 00
            brk                ; $d95d: 00
            brk                ; $d95e: 00
            brk                ; $d95f: 00
            brk                ; $d960: 00
            brk                ; $d961: 00
            brk                ; $d962: 00
            brk                ; $d963: 00
            brk                ; $d964: 00
            brk                ; $d965: 00
            brk                ; $d966: 00
            brk                ; $d967: 00
            brk                ; $d968: 00
            brk                ; $d969: 00
            brk                ; $d96a: 00
            brk                ; $d96b: 00
            brk                ; $d96c: 00
            brk                ; $d96d: 00
            brk                ; $d96e: 00
            brk                ; $d96f: 00
            brk                ; $d970: 00
            brk                ; $d971: 00
            brk                ; $d972: 00
            brk                ; $d973: 00
            brk                ; $d974: 00
            brk                ; $d975: 00
            brk                ; $d976: 00
            brk                ; $d977: 00
            brk                ; $d978: 00
            brk                ; $d979: 00
            brk                ; $d97a: 00
            brk                ; $d97b: 00
            brk                ; $d97c: 00
            brk                ; $d97d: 00
            brk                ; $d97e: 00
            brk                ; $d97f: 00
            brk                ; $d980: 00
            brk                ; $d981: 00
            brk                ; $d982: 00
            brk                ; $d983: 00
            brk                ; $d984: 00
            brk                ; $d985: 00
            brk                ; $d986: 00
            brk                ; $d987: 00
            brk                ; $d988: 00
            brk                ; $d989: 00
            brk                ; $d98a: 00
            brk                ; $d98b: 00
            brk                ; $d98c: 00
            brk                ; $d98d: 00
            brk                ; $d98e: 00
            brk                ; $d98f: 00
            brk                ; $d990: 00
            brk                ; $d991: 00
            brk                ; $d992: 00
            brk                ; $d993: 00
            brk                ; $d994: 00
            brk                ; $d995: 00
            brk                ; $d996: 00
            brk                ; $d997: 00
            brk                ; $d998: 00
            brk                ; $d999: 00
            brk                ; $d99a: 00
            brk                ; $d99b: 00
            brk                ; $d99c: 00
            brk                ; $d99d: 00
            brk                ; $d99e: 00
            brk                ; $d99f: 00
            brk                ; $d9a0: 00
            brk                ; $d9a1: 00
            brk                ; $d9a2: 00
            brk                ; $d9a3: 00
            brk                ; $d9a4: 00
            brk                ; $d9a5: 00
            brk                ; $d9a6: 00
            brk                ; $d9a7: 00
            brk                ; $d9a8: 00
            brk                ; $d9a9: 00
            brk                ; $d9aa: 00
            brk                ; $d9ab: 00
            brk                ; $d9ac: 00
            brk                ; $d9ad: 00
            brk                ; $d9ae: 00
            brk                ; $d9af: 00
            brk                ; $d9b0: 00
            brk                ; $d9b1: 00
            brk                ; $d9b2: 00
            brk                ; $d9b3: 00
            brk                ; $d9b4: 00
            brk                ; $d9b5: 00
            brk                ; $d9b6: 00
            brk                ; $d9b7: 00
            brk                ; $d9b8: 00
            brk                ; $d9b9: 00
            brk                ; $d9ba: 00
            brk                ; $d9bb: 00
            brk                ; $d9bc: 00
            brk                ; $d9bd: 00
            brk                ; $d9be: 00
            brk                ; $d9bf: 00
            brk                ; $d9c0: 00
            brk                ; $d9c1: 00
            brk                ; $d9c2: 00
            brk                ; $d9c3: 00
            brk                ; $d9c4: 00
            brk                ; $d9c5: 00
            brk                ; $d9c6: 00
            brk                ; $d9c7: 00
            brk                ; $d9c8: 00
            brk                ; $d9c9: 00
            brk                ; $d9ca: 00
            brk                ; $d9cb: 00
            brk                ; $d9cc: 00
            brk                ; $d9cd: 00
            brk                ; $d9ce: 00
            brk                ; $d9cf: 00
            brk                ; $d9d0: 00
            brk                ; $d9d1: 00
            brk                ; $d9d2: 00
            brk                ; $d9d3: 00
__d9d4:     brk                ; $d9d4: 00
            brk                ; $d9d5: 00
            brk                ; $d9d6: 00
            brk                ; $d9d7: 00
            brk                ; $d9d8: 00
            brk                ; $d9d9: 00
            brk                ; $d9da: 00
            brk                ; $d9db: 00
            brk                ; $d9dc: 00
            brk                ; $d9dd: 00
            brk                ; $d9de: 00
            brk                ; $d9df: 00
            brk                ; $d9e0: 00
            brk                ; $d9e1: 00
            brk                ; $d9e2: 00
            brk                ; $d9e3: 00
            brk                ; $d9e4: 00
            brk                ; $d9e5: 00
            brk                ; $d9e6: 00
            brk                ; $d9e7: 00
            brk                ; $d9e8: 00
            brk                ; $d9e9: 00
            brk                ; $d9ea: 00
            brk                ; $d9eb: 00
            brk                ; $d9ec: 00
            brk                ; $d9ed: 00
            brk                ; $d9ee: 00
            brk                ; $d9ef: 00
            brk                ; $d9f0: 00
            brk                ; $d9f1: 00
            brk                ; $d9f2: 00
            brk                ; $d9f3: 00
            brk                ; $d9f4: 00
            brk                ; $d9f5: 00
            brk                ; $d9f6: 00
            brk                ; $d9f7: 00
            brk                ; $d9f8: 00
            brk                ; $d9f9: 00
            brk                ; $d9fa: 00
            brk                ; $d9fb: 00
            brk                ; $d9fc: 00
            brk                ; $d9fd: 00
            brk                ; $d9fe: 00
            brk                ; $d9ff: 00
            brk                ; $da00: 00
            brk                ; $da01: 00
            brk                ; $da02: 00
            brk                ; $da03: 00
            brk                ; $da04: 00
            brk                ; $da05: 00
            brk                ; $da06: 00
            brk                ; $da07: 00
            brk                ; $da08: 00
            brk                ; $da09: 00
            brk                ; $da0a: 00
            brk                ; $da0b: 00
            brk                ; $da0c: 00
__da0d:     brk                ; $da0d: 00
            brk                ; $da0e: 00
            brk                ; $da0f: 00
            brk                ; $da10: 00
            brk                ; $da11: 00
            brk                ; $da12: 00
            brk                ; $da13: 00
            brk                ; $da14: 00
            brk                ; $da15: 00
            brk                ; $da16: 00
            brk                ; $da17: 00
            brk                ; $da18: 00
            brk                ; $da19: 00
            brk                ; $da1a: 00
            brk                ; $da1b: 00
            brk                ; $da1c: 00
            brk                ; $da1d: 00
            brk                ; $da1e: 00
            brk                ; $da1f: 00
            brk                ; $da20: 00
            brk                ; $da21: 00
            brk                ; $da22: 00
            brk                ; $da23: 00
            brk                ; $da24: 00
            brk                ; $da25: 00
            brk                ; $da26: 00
            brk                ; $da27: 00
            brk                ; $da28: 00
            brk                ; $da29: 00
            brk                ; $da2a: 00
            brk                ; $da2b: 00
            brk                ; $da2c: 00
            brk                ; $da2d: 00
            brk                ; $da2e: 00
            brk                ; $da2f: 00
            brk                ; $da30: 00
            brk                ; $da31: 00
            brk                ; $da32: 00
            brk                ; $da33: 00
            brk                ; $da34: 00
            brk                ; $da35: 00
            brk                ; $da36: 00
            brk                ; $da37: 00
            brk                ; $da38: 00
            brk                ; $da39: 00
            brk                ; $da3a: 00
            brk                ; $da3b: 00
            brk                ; $da3c: 00
            brk                ; $da3d: 00
            brk                ; $da3e: 00
            brk                ; $da3f: 00
            brk                ; $da40: 00
            brk                ; $da41: 00
            brk                ; $da42: 00
            brk                ; $da43: 00
            brk                ; $da44: 00
            brk                ; $da45: 00
            brk                ; $da46: 00
            brk                ; $da47: 00
            brk                ; $da48: 00
            brk                ; $da49: 00
            brk                ; $da4a: 00
            brk                ; $da4b: 00
            brk                ; $da4c: 00
            brk                ; $da4d: 00
            brk                ; $da4e: 00
            brk                ; $da4f: 00
            brk                ; $da50: 00
            brk                ; $da51: 00
            brk                ; $da52: 00
            brk                ; $da53: 00
            brk                ; $da54: 00
            brk                ; $da55: 00
            brk                ; $da56: 00
            brk                ; $da57: 00
            brk                ; $da58: 00
            brk                ; $da59: 00
            brk                ; $da5a: 00
            brk                ; $da5b: 00
            brk                ; $da5c: 00
            brk                ; $da5d: 00
            brk                ; $da5e: 00
            brk                ; $da5f: 00
            brk                ; $da60: 00
            brk                ; $da61: 00
            brk                ; $da62: 00
            brk                ; $da63: 00
            brk                ; $da64: 00
            brk                ; $da65: 00
            brk                ; $da66: 00
            brk                ; $da67: 00
            brk                ; $da68: 00
            brk                ; $da69: 00
            brk                ; $da6a: 00
            brk                ; $da6b: 00
            brk                ; $da6c: 00
            brk                ; $da6d: 00
            brk                ; $da6e: 00
            brk                ; $da6f: 00
            brk                ; $da70: 00
            brk                ; $da71: 00
            brk                ; $da72: 00
            brk                ; $da73: 00
            brk                ; $da74: 00
            brk                ; $da75: 00
            brk                ; $da76: 00
            brk                ; $da77: 00
            brk                ; $da78: 00
            brk                ; $da79: 00
            brk                ; $da7a: 00
            brk                ; $da7b: 00
            brk                ; $da7c: 00
            brk                ; $da7d: 00
            brk                ; $da7e: 00
            brk                ; $da7f: 00
            brk                ; $da80: 00
            brk                ; $da81: 00
            brk                ; $da82: 00
            brk                ; $da83: 00
            brk                ; $da84: 00
            brk                ; $da85: 00
            brk                ; $da86: 00
            brk                ; $da87: 00
            brk                ; $da88: 00
            brk                ; $da89: 00
            brk                ; $da8a: 00
            brk                ; $da8b: 00
            brk                ; $da8c: 00
            brk                ; $da8d: 00
            brk                ; $da8e: 00
            brk                ; $da8f: 00
            brk                ; $da90: 00
            brk                ; $da91: 00
            brk                ; $da92: 00
            brk                ; $da93: 00
            brk                ; $da94: 00
            brk                ; $da95: 00
            brk                ; $da96: 00
            brk                ; $da97: 00
            brk                ; $da98: 00
            brk                ; $da99: 00
            brk                ; $da9a: 00
            brk                ; $da9b: 00
            brk                ; $da9c: 00
            brk                ; $da9d: 00
            brk                ; $da9e: 00
            brk                ; $da9f: 00
            brk                ; $daa0: 00
            brk                ; $daa1: 00
            brk                ; $daa2: 00
            brk                ; $daa3: 00
            brk                ; $daa4: 00
            brk                ; $daa5: 00
            brk                ; $daa6: 00
            brk                ; $daa7: 00
            brk                ; $daa8: 00
            brk                ; $daa9: 00
            brk                ; $daaa: 00
            brk                ; $daab: 00
            brk                ; $daac: 00
            brk                ; $daad: 00
            brk                ; $daae: 00
            brk                ; $daaf: 00
            brk                ; $dab0: 00
            brk                ; $dab1: 00
            brk                ; $dab2: 00
            brk                ; $dab3: 00
            brk                ; $dab4: 00
            brk                ; $dab5: 00
            brk                ; $dab6: 00
            brk                ; $dab7: 00
            brk                ; $dab8: 00
            brk                ; $dab9: 00
            brk                ; $daba: 00
            brk                ; $dabb: 00
            brk                ; $dabc: 00
            brk                ; $dabd: 00
            brk                ; $dabe: 00
            brk                ; $dabf: 00
            brk                ; $dac0: 00
            brk                ; $dac1: 00
            brk                ; $dac2: 00
            brk                ; $dac3: 00
            brk                ; $dac4: 00
            brk                ; $dac5: 00
            brk                ; $dac6: 00
            brk                ; $dac7: 00
            brk                ; $dac8: 00
            brk                ; $dac9: 00
            brk                ; $daca: 00
            brk                ; $dacb: 00
            brk                ; $dacc: 00
            brk                ; $dacd: 00
            brk                ; $dace: 00
            brk                ; $dacf: 00
            brk                ; $dad0: 00
            brk                ; $dad1: 00
            brk                ; $dad2: 00
            brk                ; $dad3: 00
            brk                ; $dad4: 00
            brk                ; $dad5: 00
            brk                ; $dad6: 00
            brk                ; $dad7: 00
            brk                ; $dad8: 00
            brk                ; $dad9: 00
            brk                ; $dada: 00
            brk                ; $dadb: 00
            brk                ; $dadc: 00
            brk                ; $dadd: 00
            brk                ; $dade: 00
            brk                ; $dadf: 00
            brk                ; $dae0: 00
            brk                ; $dae1: 00
            brk                ; $dae2: 00
            brk                ; $dae3: 00
            brk                ; $dae4: 00
            brk                ; $dae5: 00
            brk                ; $dae6: 00
            brk                ; $dae7: 00
            brk                ; $dae8: 00
            brk                ; $dae9: 00
            brk                ; $daea: 00
            brk                ; $daeb: 00
            brk                ; $daec: 00
            brk                ; $daed: 00
            brk                ; $daee: 00
            brk                ; $daef: 00
            brk                ; $daf0: 00
            brk                ; $daf1: 00
            brk                ; $daf2: 00
            brk                ; $daf3: 00
            brk                ; $daf4: 00
            brk                ; $daf5: 00
            brk                ; $daf6: 00
            brk                ; $daf7: 00
            brk                ; $daf8: 00
            brk                ; $daf9: 00
            brk                ; $dafa: 00
            brk                ; $dafb: 00
            brk                ; $dafc: 00
            brk                ; $dafd: 00
            brk                ; $dafe: 00
            brk                ; $daff: 00
            brk                ; $db00: 00
            brk                ; $db01: 00
            brk                ; $db02: 00
            brk                ; $db03: 00
            brk                ; $db04: 00
            brk                ; $db05: 00
            brk                ; $db06: 00
            brk                ; $db07: 00
            brk                ; $db08: 00
            brk                ; $db09: 00
            brk                ; $db0a: 00
            brk                ; $db0b: 00
            brk                ; $db0c: 00
            brk                ; $db0d: 00
            brk                ; $db0e: 00
            brk                ; $db0f: 00
            brk                ; $db10: 00
            brk                ; $db11: 00
            brk                ; $db12: 00
            brk                ; $db13: 00
            brk                ; $db14: 00
            brk                ; $db15: 00
            brk                ; $db16: 00
            brk                ; $db17: 00
            brk                ; $db18: 00
            brk                ; $db19: 00
            brk                ; $db1a: 00
            brk                ; $db1b: 00
            brk                ; $db1c: 00
            brk                ; $db1d: 00
            brk                ; $db1e: 00
            brk                ; $db1f: 00
            brk                ; $db20: 00
            brk                ; $db21: 00
            brk                ; $db22: 00
            brk                ; $db23: 00
            brk                ; $db24: 00
            brk                ; $db25: 00
            brk                ; $db26: 00
            brk                ; $db27: 00
            brk                ; $db28: 00
            brk                ; $db29: 00
            brk                ; $db2a: 00
            brk                ; $db2b: 00
            brk                ; $db2c: 00
            brk                ; $db2d: 00
            brk                ; $db2e: 00
            brk                ; $db2f: 00
            brk                ; $db30: 00
            brk                ; $db31: 00
            brk                ; $db32: 00
            brk                ; $db33: 00
            brk                ; $db34: 00
            brk                ; $db35: 00
            brk                ; $db36: 00
            brk                ; $db37: 00
            brk                ; $db38: 00
            brk                ; $db39: 00
            brk                ; $db3a: 00
            brk                ; $db3b: 00
            brk                ; $db3c: 00
            brk                ; $db3d: 00
            brk                ; $db3e: 00
            brk                ; $db3f: 00
            brk                ; $db40: 00
            brk                ; $db41: 00
            brk                ; $db42: 00
            brk                ; $db43: 00
            brk                ; $db44: 00
            brk                ; $db45: 00
            brk                ; $db46: 00
            brk                ; $db47: 00
            brk                ; $db48: 00
            brk                ; $db49: 00
            brk                ; $db4a: 00
            brk                ; $db4b: 00
            brk                ; $db4c: 00
            brk                ; $db4d: 00
            brk                ; $db4e: 00
            brk                ; $db4f: 00
            brk                ; $db50: 00
            brk                ; $db51: 00
            brk                ; $db52: 00
            brk                ; $db53: 00
            brk                ; $db54: 00
            brk                ; $db55: 00
            brk                ; $db56: 00
            brk                ; $db57: 00
            brk                ; $db58: 00
            brk                ; $db59: 00
            brk                ; $db5a: 00
            brk                ; $db5b: 00
            brk                ; $db5c: 00
            brk                ; $db5d: 00
            brk                ; $db5e: 00
            brk                ; $db5f: 00
            brk                ; $db60: 00
            brk                ; $db61: 00
            brk                ; $db62: 00
            brk                ; $db63: 00
            brk                ; $db64: 00
            brk                ; $db65: 00
            brk                ; $db66: 00
            brk                ; $db67: 00
            brk                ; $db68: 00
            brk                ; $db69: 00
            brk                ; $db6a: 00
            brk                ; $db6b: 00
            brk                ; $db6c: 00
            brk                ; $db6d: 00
            brk                ; $db6e: 00
            brk                ; $db6f: 00
            brk                ; $db70: 00
            brk                ; $db71: 00
            brk                ; $db72: 00
            brk                ; $db73: 00
            brk                ; $db74: 00
            brk                ; $db75: 00
            brk                ; $db76: 00
            brk                ; $db77: 00
            brk                ; $db78: 00
            brk                ; $db79: 00
            brk                ; $db7a: 00
            brk                ; $db7b: 00
            brk                ; $db7c: 00
            brk                ; $db7d: 00
            brk                ; $db7e: 00
            brk                ; $db7f: 00
            brk                ; $db80: 00
            brk                ; $db81: 00
            brk                ; $db82: 00
            brk                ; $db83: 00
            brk                ; $db84: 00
            brk                ; $db85: 00
            brk                ; $db86: 00
            brk                ; $db87: 00
            brk                ; $db88: 00
            brk                ; $db89: 00
            brk                ; $db8a: 00
            brk                ; $db8b: 00
            brk                ; $db8c: 00
            brk                ; $db8d: 00
            brk                ; $db8e: 00
            brk                ; $db8f: 00
            brk                ; $db90: 00
            brk                ; $db91: 00
            brk                ; $db92: 00
            brk                ; $db93: 00
            brk                ; $db94: 00
            brk                ; $db95: 00
            brk                ; $db96: 00
            brk                ; $db97: 00
            brk                ; $db98: 00
            brk                ; $db99: 00
            brk                ; $db9a: 00
            brk                ; $db9b: 00
            brk                ; $db9c: 00
            brk                ; $db9d: 00
            brk                ; $db9e: 00
            brk                ; $db9f: 00
            brk                ; $dba0: 00
            brk                ; $dba1: 00
            brk                ; $dba2: 00
            brk                ; $dba3: 00
            brk                ; $dba4: 00
            brk                ; $dba5: 00
            brk                ; $dba6: 00
            brk                ; $dba7: 00
            brk                ; $dba8: 00
            brk                ; $dba9: 00
            brk                ; $dbaa: 00
            brk                ; $dbab: 00
            brk                ; $dbac: 00
            brk                ; $dbad: 00
            brk                ; $dbae: 00
            brk                ; $dbaf: 00
            brk                ; $dbb0: 00
            brk                ; $dbb1: 00
            brk                ; $dbb2: 00
            brk                ; $dbb3: 00
            brk                ; $dbb4: 00
            brk                ; $dbb5: 00
            brk                ; $dbb6: 00
            brk                ; $dbb7: 00
            brk                ; $dbb8: 00
            brk                ; $dbb9: 00
            brk                ; $dbba: 00
            brk                ; $dbbb: 00
            brk                ; $dbbc: 00
            brk                ; $dbbd: 00
            brk                ; $dbbe: 00
            brk                ; $dbbf: 00
            brk                ; $dbc0: 00
            brk                ; $dbc1: 00
            brk                ; $dbc2: 00
            brk                ; $dbc3: 00
            brk                ; $dbc4: 00
            brk                ; $dbc5: 00
            brk                ; $dbc6: 00
            brk                ; $dbc7: 00
            brk                ; $dbc8: 00
            brk                ; $dbc9: 00
            brk                ; $dbca: 00
            brk                ; $dbcb: 00
            brk                ; $dbcc: 00
            brk                ; $dbcd: 00
            brk                ; $dbce: 00
            brk                ; $dbcf: 00
            brk                ; $dbd0: 00
            brk                ; $dbd1: 00
            brk                ; $dbd2: 00
            brk                ; $dbd3: 00
            brk                ; $dbd4: 00
            brk                ; $dbd5: 00
            brk                ; $dbd6: 00
            brk                ; $dbd7: 00
            brk                ; $dbd8: 00
            brk                ; $dbd9: 00
            brk                ; $dbda: 00
            brk                ; $dbdb: 00
            brk                ; $dbdc: 00
            brk                ; $dbdd: 00
            brk                ; $dbde: 00
            brk                ; $dbdf: 00
            brk                ; $dbe0: 00
            brk                ; $dbe1: 00
            brk                ; $dbe2: 00
            brk                ; $dbe3: 00
            brk                ; $dbe4: 00
            brk                ; $dbe5: 00
            brk                ; $dbe6: 00
            brk                ; $dbe7: 00
            brk                ; $dbe8: 00
            brk                ; $dbe9: 00
            brk                ; $dbea: 00
            brk                ; $dbeb: 00
            brk                ; $dbec: 00
            brk                ; $dbed: 00
            brk                ; $dbee: 00
            brk                ; $dbef: 00
            brk                ; $dbf0: 00
            brk                ; $dbf1: 00
            brk                ; $dbf2: 00
            brk                ; $dbf3: 00
            brk                ; $dbf4: 00
            brk                ; $dbf5: 00
            brk                ; $dbf6: 00
            brk                ; $dbf7: 00
            brk                ; $dbf8: 00
            brk                ; $dbf9: 00
            brk                ; $dbfa: 00
            brk                ; $dbfb: 00
            brk                ; $dbfc: 00
            brk                ; $dbfd: 00
            brk                ; $dbfe: 00
            brk                ; $dbff: 00
            brk                ; $dc00: 00
            brk                ; $dc01: 00
            brk                ; $dc02: 00
            brk                ; $dc03: 00
            brk                ; $dc04: 00
            brk                ; $dc05: 00
            brk                ; $dc06: 00
            brk                ; $dc07: 00
            brk                ; $dc08: 00
            brk                ; $dc09: 00
            brk                ; $dc0a: 00
            brk                ; $dc0b: 00
            brk                ; $dc0c: 00
            brk                ; $dc0d: 00
            brk                ; $dc0e: 00
            brk                ; $dc0f: 00
            brk                ; $dc10: 00
            brk                ; $dc11: 00
            brk                ; $dc12: 00
            brk                ; $dc13: 00
            brk                ; $dc14: 00
            brk                ; $dc15: 00
            brk                ; $dc16: 00
            brk                ; $dc17: 00
            brk                ; $dc18: 00
            brk                ; $dc19: 00
            brk                ; $dc1a: 00
            brk                ; $dc1b: 00
            brk                ; $dc1c: 00
            brk                ; $dc1d: 00
            brk                ; $dc1e: 00
            brk                ; $dc1f: 00
            brk                ; $dc20: 00
            brk                ; $dc21: 00
            brk                ; $dc22: 00
            brk                ; $dc23: 00
            brk                ; $dc24: 00
            brk                ; $dc25: 00
            brk                ; $dc26: 00
            brk                ; $dc27: 00
            brk                ; $dc28: 00
            brk                ; $dc29: 00
            brk                ; $dc2a: 00
            brk                ; $dc2b: 00
            brk                ; $dc2c: 00
            brk                ; $dc2d: 00
            brk                ; $dc2e: 00
            brk                ; $dc2f: 00
            brk                ; $dc30: 00
            brk                ; $dc31: 00
            brk                ; $dc32: 00
            brk                ; $dc33: 00
            brk                ; $dc34: 00
            brk                ; $dc35: 00
            brk                ; $dc36: 00
            brk                ; $dc37: 00
            brk                ; $dc38: 00
            brk                ; $dc39: 00
            brk                ; $dc3a: 00
            brk                ; $dc3b: 00
            brk                ; $dc3c: 00
            brk                ; $dc3d: 00
            brk                ; $dc3e: 00
            brk                ; $dc3f: 00
            brk                ; $dc40: 00
            brk                ; $dc41: 00
            brk                ; $dc42: 00
            brk                ; $dc43: 00
            brk                ; $dc44: 00
            brk                ; $dc45: 00
            brk                ; $dc46: 00
            brk                ; $dc47: 00
            brk                ; $dc48: 00
            brk                ; $dc49: 00
            brk                ; $dc4a: 00
            brk                ; $dc4b: 00
            brk                ; $dc4c: 00
            brk                ; $dc4d: 00
            brk                ; $dc4e: 00
            brk                ; $dc4f: 00
            brk                ; $dc50: 00
            brk                ; $dc51: 00
            brk                ; $dc52: 00
            brk                ; $dc53: 00
            brk                ; $dc54: 00
            brk                ; $dc55: 00
            brk                ; $dc56: 00
            brk                ; $dc57: 00
            brk                ; $dc58: 00
            brk                ; $dc59: 00
            brk                ; $dc5a: 00
            brk                ; $dc5b: 00
            brk                ; $dc5c: 00
            brk                ; $dc5d: 00
            brk                ; $dc5e: 00
            brk                ; $dc5f: 00
            brk                ; $dc60: 00
            brk                ; $dc61: 00
            brk                ; $dc62: 00
            brk                ; $dc63: 00
            brk                ; $dc64: 00
            brk                ; $dc65: 00
            brk                ; $dc66: 00
            brk                ; $dc67: 00
            brk                ; $dc68: 00
            brk                ; $dc69: 00
            brk                ; $dc6a: 00
            brk                ; $dc6b: 00
            brk                ; $dc6c: 00
            brk                ; $dc6d: 00
            brk                ; $dc6e: 00
            brk                ; $dc6f: 00
            brk                ; $dc70: 00
            brk                ; $dc71: 00
            brk                ; $dc72: 00
            brk                ; $dc73: 00
            brk                ; $dc74: 00
            brk                ; $dc75: 00
            brk                ; $dc76: 00
            brk                ; $dc77: 00
            brk                ; $dc78: 00
            brk                ; $dc79: 00
            brk                ; $dc7a: 00
            brk                ; $dc7b: 00
            brk                ; $dc7c: 00
            brk                ; $dc7d: 00
            brk                ; $dc7e: 00
            brk                ; $dc7f: 00
            brk                ; $dc80: 00
            brk                ; $dc81: 00
            brk                ; $dc82: 00
            brk                ; $dc83: 00
            brk                ; $dc84: 00
            brk                ; $dc85: 00
            brk                ; $dc86: 00
            brk                ; $dc87: 00
            brk                ; $dc88: 00
            brk                ; $dc89: 00
            brk                ; $dc8a: 00
            brk                ; $dc8b: 00
            brk                ; $dc8c: 00
            brk                ; $dc8d: 00
            brk                ; $dc8e: 00
            brk                ; $dc8f: 00
            brk                ; $dc90: 00
            brk                ; $dc91: 00
            brk                ; $dc92: 00
            brk                ; $dc93: 00
            brk                ; $dc94: 00
            brk                ; $dc95: 00
            brk                ; $dc96: 00
            brk                ; $dc97: 00
            brk                ; $dc98: 00
            brk                ; $dc99: 00
            brk                ; $dc9a: 00
            brk                ; $dc9b: 00
            brk                ; $dc9c: 00
            brk                ; $dc9d: 00
            brk                ; $dc9e: 00
            brk                ; $dc9f: 00
            brk                ; $dca0: 00
            brk                ; $dca1: 00
            brk                ; $dca2: 00
            brk                ; $dca3: 00
            brk                ; $dca4: 00
            brk                ; $dca5: 00
            brk                ; $dca6: 00
            brk                ; $dca7: 00
            brk                ; $dca8: 00
            brk                ; $dca9: 00
            brk                ; $dcaa: 00
            brk                ; $dcab: 00
            brk                ; $dcac: 00
            brk                ; $dcad: 00
            brk                ; $dcae: 00
            brk                ; $dcaf: 00
            brk                ; $dcb0: 00
            brk                ; $dcb1: 00
            brk                ; $dcb2: 00
            brk                ; $dcb3: 00
            brk                ; $dcb4: 00
            brk                ; $dcb5: 00
            brk                ; $dcb6: 00
            brk                ; $dcb7: 00
            brk                ; $dcb8: 00
            brk                ; $dcb9: 00
            brk                ; $dcba: 00
            brk                ; $dcbb: 00
            brk                ; $dcbc: 00
            brk                ; $dcbd: 00
            brk                ; $dcbe: 00
            brk                ; $dcbf: 00
            brk                ; $dcc0: 00
            brk                ; $dcc1: 00
            brk                ; $dcc2: 00
            brk                ; $dcc3: 00
            brk                ; $dcc4: 00
            brk                ; $dcc5: 00
            brk                ; $dcc6: 00
            brk                ; $dcc7: 00
            brk                ; $dcc8: 00
            brk                ; $dcc9: 00
            brk                ; $dcca: 00
            brk                ; $dccb: 00
            brk                ; $dccc: 00
            brk                ; $dccd: 00
            brk                ; $dcce: 00
            brk                ; $dccf: 00
            brk                ; $dcd0: 00
            brk                ; $dcd1: 00
            brk                ; $dcd2: 00
            brk                ; $dcd3: 00
            brk                ; $dcd4: 00
            brk                ; $dcd5: 00
            brk                ; $dcd6: 00
            brk                ; $dcd7: 00
            brk                ; $dcd8: 00
            brk                ; $dcd9: 00
            brk                ; $dcda: 00
            brk                ; $dcdb: 00
            brk                ; $dcdc: 00
            brk                ; $dcdd: 00
            brk                ; $dcde: 00
            brk                ; $dcdf: 00
            brk                ; $dce0: 00
            brk                ; $dce1: 00
            brk                ; $dce2: 00
            brk                ; $dce3: 00
            brk                ; $dce4: 00
            brk                ; $dce5: 00
            brk                ; $dce6: 00
            brk                ; $dce7: 00
            brk                ; $dce8: 00
            brk                ; $dce9: 00
            brk                ; $dcea: 00
            brk                ; $dceb: 00
            brk                ; $dcec: 00
            brk                ; $dced: 00
            brk                ; $dcee: 00
            brk                ; $dcef: 00
            brk                ; $dcf0: 00
            brk                ; $dcf1: 00
            brk                ; $dcf2: 00
            brk                ; $dcf3: 00
            brk                ; $dcf4: 00
            brk                ; $dcf5: 00
            brk                ; $dcf6: 00
            brk                ; $dcf7: 00
            brk                ; $dcf8: 00
            brk                ; $dcf9: 00
            brk                ; $dcfa: 00
            brk                ; $dcfb: 00
            brk                ; $dcfc: 00
            brk                ; $dcfd: 00
            brk                ; $dcfe: 00
            brk                ; $dcff: 00
            brk                ; $dd00: 00
            brk                ; $dd01: 00
            brk                ; $dd02: 00
            brk                ; $dd03: 00
            brk                ; $dd04: 00
            brk                ; $dd05: 00
            brk                ; $dd06: 00
            brk                ; $dd07: 00
            brk                ; $dd08: 00
            brk                ; $dd09: 00
            brk                ; $dd0a: 00
            brk                ; $dd0b: 00
            brk                ; $dd0c: 00
            brk                ; $dd0d: 00
            brk                ; $dd0e: 00
            brk                ; $dd0f: 00
            brk                ; $dd10: 00
            brk                ; $dd11: 00
            brk                ; $dd12: 00
            brk                ; $dd13: 00
            brk                ; $dd14: 00
            brk                ; $dd15: 00
            brk                ; $dd16: 00
            brk                ; $dd17: 00
            brk                ; $dd18: 00
            brk                ; $dd19: 00
            brk                ; $dd1a: 00
            brk                ; $dd1b: 00
            brk                ; $dd1c: 00
            brk                ; $dd1d: 00
            brk                ; $dd1e: 00
            brk                ; $dd1f: 00
            brk                ; $dd20: 00
            brk                ; $dd21: 00
            brk                ; $dd22: 00
            brk                ; $dd23: 00
            brk                ; $dd24: 00
            brk                ; $dd25: 00
            brk                ; $dd26: 00
            brk                ; $dd27: 00
            brk                ; $dd28: 00
            brk                ; $dd29: 00
            brk                ; $dd2a: 00
            brk                ; $dd2b: 00
            brk                ; $dd2c: 00
            brk                ; $dd2d: 00
            brk                ; $dd2e: 00
            brk                ; $dd2f: 00
            brk                ; $dd30: 00
            brk                ; $dd31: 00
            brk                ; $dd32: 00
            brk                ; $dd33: 00
            brk                ; $dd34: 00
            brk                ; $dd35: 00
            brk                ; $dd36: 00
            brk                ; $dd37: 00
            brk                ; $dd38: 00
            brk                ; $dd39: 00
            brk                ; $dd3a: 00
            brk                ; $dd3b: 00
            brk                ; $dd3c: 00
            brk                ; $dd3d: 00
            brk                ; $dd3e: 00
            brk                ; $dd3f: 00
            brk                ; $dd40: 00
            brk                ; $dd41: 00
            brk                ; $dd42: 00
            brk                ; $dd43: 00
            brk                ; $dd44: 00
            brk                ; $dd45: 00
            brk                ; $dd46: 00
            brk                ; $dd47: 00
            brk                ; $dd48: 00
            brk                ; $dd49: 00
            brk                ; $dd4a: 00
            brk                ; $dd4b: 00
            brk                ; $dd4c: 00
            brk                ; $dd4d: 00
            brk                ; $dd4e: 00
            brk                ; $dd4f: 00
            brk                ; $dd50: 00
            brk                ; $dd51: 00
            brk                ; $dd52: 00
            brk                ; $dd53: 00
            brk                ; $dd54: 00
            brk                ; $dd55: 00
            brk                ; $dd56: 00
            brk                ; $dd57: 00
            brk                ; $dd58: 00
            brk                ; $dd59: 00
            brk                ; $dd5a: 00
            brk                ; $dd5b: 00
            brk                ; $dd5c: 00
            brk                ; $dd5d: 00
            brk                ; $dd5e: 00
            brk                ; $dd5f: 00
            brk                ; $dd60: 00
            brk                ; $dd61: 00
            brk                ; $dd62: 00
            brk                ; $dd63: 00
            brk                ; $dd64: 00
            brk                ; $dd65: 00
            brk                ; $dd66: 00
            brk                ; $dd67: 00
            brk                ; $dd68: 00
            brk                ; $dd69: 00
            brk                ; $dd6a: 00
            brk                ; $dd6b: 00
            brk                ; $dd6c: 00
            brk                ; $dd6d: 00
            brk                ; $dd6e: 00
            brk                ; $dd6f: 00
            brk                ; $dd70: 00
            brk                ; $dd71: 00
            brk                ; $dd72: 00
            brk                ; $dd73: 00
            brk                ; $dd74: 00
            brk                ; $dd75: 00
            brk                ; $dd76: 00
            brk                ; $dd77: 00
            brk                ; $dd78: 00
            brk                ; $dd79: 00
            brk                ; $dd7a: 00
            brk                ; $dd7b: 00
            brk                ; $dd7c: 00
            brk                ; $dd7d: 00
            brk                ; $dd7e: 00
            brk                ; $dd7f: 00
            brk                ; $dd80: 00
            brk                ; $dd81: 00
            brk                ; $dd82: 00
            brk                ; $dd83: 00
            brk                ; $dd84: 00
            brk                ; $dd85: 00
            brk                ; $dd86: 00
            brk                ; $dd87: 00
            brk                ; $dd88: 00
            brk                ; $dd89: 00
            brk                ; $dd8a: 00
            brk                ; $dd8b: 00
            brk                ; $dd8c: 00
            brk                ; $dd8d: 00
            brk                ; $dd8e: 00
            brk                ; $dd8f: 00
            brk                ; $dd90: 00
            brk                ; $dd91: 00
            brk                ; $dd92: 00
            brk                ; $dd93: 00
            brk                ; $dd94: 00
            brk                ; $dd95: 00
            brk                ; $dd96: 00
            brk                ; $dd97: 00
            brk                ; $dd98: 00
            brk                ; $dd99: 00
            brk                ; $dd9a: 00
            brk                ; $dd9b: 00
            brk                ; $dd9c: 00
            brk                ; $dd9d: 00
            brk                ; $dd9e: 00
            brk                ; $dd9f: 00
            brk                ; $dda0: 00
            brk                ; $dda1: 00
            brk                ; $dda2: 00
            brk                ; $dda3: 00
            brk                ; $dda4: 00
            brk                ; $dda5: 00
            brk                ; $dda6: 00
            brk                ; $dda7: 00
            brk                ; $dda8: 00
            brk                ; $dda9: 00
            brk                ; $ddaa: 00
            brk                ; $ddab: 00
            brk                ; $ddac: 00
            brk                ; $ddad: 00
            brk                ; $ddae: 00
            brk                ; $ddaf: 00
            brk                ; $ddb0: 00
            brk                ; $ddb1: 00
            brk                ; $ddb2: 00
            brk                ; $ddb3: 00
            brk                ; $ddb4: 00
            brk                ; $ddb5: 00
            brk                ; $ddb6: 00
            brk                ; $ddb7: 00
            brk                ; $ddb8: 00
            brk                ; $ddb9: 00
            brk                ; $ddba: 00
            brk                ; $ddbb: 00
            brk                ; $ddbc: 00
            brk                ; $ddbd: 00
            brk                ; $ddbe: 00
            brk                ; $ddbf: 00
            brk                ; $ddc0: 00
            brk                ; $ddc1: 00
            brk                ; $ddc2: 00
            brk                ; $ddc3: 00
            brk                ; $ddc4: 00
            brk                ; $ddc5: 00
            brk                ; $ddc6: 00
            brk                ; $ddc7: 00
            brk                ; $ddc8: 00
            brk                ; $ddc9: 00
            brk                ; $ddca: 00
            brk                ; $ddcb: 00
            brk                ; $ddcc: 00
            brk                ; $ddcd: 00
            brk                ; $ddce: 00
            brk                ; $ddcf: 00
            brk                ; $ddd0: 00
            brk                ; $ddd1: 00
            brk                ; $ddd2: 00
            brk                ; $ddd3: 00
            brk                ; $ddd4: 00
            brk                ; $ddd5: 00
            brk                ; $ddd6: 00
            brk                ; $ddd7: 00
            brk                ; $ddd8: 00
            brk                ; $ddd9: 00
            brk                ; $ddda: 00
            brk                ; $dddb: 00
            brk                ; $dddc: 00
            brk                ; $dddd: 00
            brk                ; $ddde: 00
            brk                ; $dddf: 00
            brk                ; $dde0: 00
            brk                ; $dde1: 00
            brk                ; $dde2: 00
            brk                ; $dde3: 00
            brk                ; $dde4: 00
            brk                ; $dde5: 00
            brk                ; $dde6: 00
            brk                ; $dde7: 00
            brk                ; $dde8: 00
            brk                ; $dde9: 00
            brk                ; $ddea: 00
            brk                ; $ddeb: 00
            brk                ; $ddec: 00
            brk                ; $dded: 00
            brk                ; $ddee: 00
            brk                ; $ddef: 00
            brk                ; $ddf0: 00
            brk                ; $ddf1: 00
            brk                ; $ddf2: 00
            brk                ; $ddf3: 00
            brk                ; $ddf4: 00
            brk                ; $ddf5: 00
            brk                ; $ddf6: 00
            brk                ; $ddf7: 00
            brk                ; $ddf8: 00
            brk                ; $ddf9: 00
            brk                ; $ddfa: 00
            brk                ; $ddfb: 00
            brk                ; $ddfc: 00
            brk                ; $ddfd: 00
            brk                ; $ddfe: 00
            brk                ; $ddff: 00
            brk                ; $de00: 00
            brk                ; $de01: 00
            brk                ; $de02: 00
            brk                ; $de03: 00
            brk                ; $de04: 00
            brk                ; $de05: 00
            brk                ; $de06: 00
            brk                ; $de07: 00
            brk                ; $de08: 00
            brk                ; $de09: 00
            brk                ; $de0a: 00
            brk                ; $de0b: 00
            brk                ; $de0c: 00
            brk                ; $de0d: 00
            brk                ; $de0e: 00
            brk                ; $de0f: 00
            brk                ; $de10: 00
            brk                ; $de11: 00
            brk                ; $de12: 00
            brk                ; $de13: 00
            brk                ; $de14: 00
            brk                ; $de15: 00
            brk                ; $de16: 00
            brk                ; $de17: 00
            brk                ; $de18: 00
            brk                ; $de19: 00
            brk                ; $de1a: 00
            brk                ; $de1b: 00
            brk                ; $de1c: 00
            brk                ; $de1d: 00
            brk                ; $de1e: 00
            brk                ; $de1f: 00
            brk                ; $de20: 00
            brk                ; $de21: 00
            brk                ; $de22: 00
            brk                ; $de23: 00
            brk                ; $de24: 00
            brk                ; $de25: 00
            brk                ; $de26: 00
            brk                ; $de27: 00
            brk                ; $de28: 00
            brk                ; $de29: 00
            brk                ; $de2a: 00
            brk                ; $de2b: 00
            brk                ; $de2c: 00
            brk                ; $de2d: 00
            brk                ; $de2e: 00
            brk                ; $de2f: 00
            brk                ; $de30: 00
            brk                ; $de31: 00
            brk                ; $de32: 00
            brk                ; $de33: 00
            brk                ; $de34: 00
            brk                ; $de35: 00
            brk                ; $de36: 00
            brk                ; $de37: 00
            brk                ; $de38: 00
            brk                ; $de39: 00
            brk                ; $de3a: 00
            brk                ; $de3b: 00
            brk                ; $de3c: 00
            brk                ; $de3d: 00
            brk                ; $de3e: 00
            brk                ; $de3f: 00
            brk                ; $de40: 00
            brk                ; $de41: 00
            brk                ; $de42: 00
            brk                ; $de43: 00
            brk                ; $de44: 00
            brk                ; $de45: 00
            brk                ; $de46: 00
            brk                ; $de47: 00
            brk                ; $de48: 00
            brk                ; $de49: 00
            brk                ; $de4a: 00
            brk                ; $de4b: 00
            brk                ; $de4c: 00
            brk                ; $de4d: 00
            brk                ; $de4e: 00
            brk                ; $de4f: 00
            brk                ; $de50: 00
            brk                ; $de51: 00
            brk                ; $de52: 00
            brk                ; $de53: 00
            brk                ; $de54: 00
            brk                ; $de55: 00
            brk                ; $de56: 00
            brk                ; $de57: 00
            brk                ; $de58: 00
            brk                ; $de59: 00
            brk                ; $de5a: 00
            brk                ; $de5b: 00
            brk                ; $de5c: 00
            brk                ; $de5d: 00
            brk                ; $de5e: 00
            brk                ; $de5f: 00
            brk                ; $de60: 00
            brk                ; $de61: 00
            brk                ; $de62: 00
            brk                ; $de63: 00
            brk                ; $de64: 00
            brk                ; $de65: 00
            brk                ; $de66: 00
            brk                ; $de67: 00
            brk                ; $de68: 00
            brk                ; $de69: 00
            brk                ; $de6a: 00
            brk                ; $de6b: 00
            brk                ; $de6c: 00
            brk                ; $de6d: 00
            brk                ; $de6e: 00
            brk                ; $de6f: 00
            brk                ; $de70: 00
            brk                ; $de71: 00
            brk                ; $de72: 00
            brk                ; $de73: 00
            brk                ; $de74: 00
            brk                ; $de75: 00
            brk                ; $de76: 00
            brk                ; $de77: 00
            brk                ; $de78: 00
            brk                ; $de79: 00
            brk                ; $de7a: 00
            brk                ; $de7b: 00
            brk                ; $de7c: 00
            brk                ; $de7d: 00
            brk                ; $de7e: 00
            brk                ; $de7f: 00
            brk                ; $de80: 00
            brk                ; $de81: 00
            brk                ; $de82: 00
            brk                ; $de83: 00
            brk                ; $de84: 00
            brk                ; $de85: 00
            brk                ; $de86: 00
            brk                ; $de87: 00
            brk                ; $de88: 00
            brk                ; $de89: 00
            brk                ; $de8a: 00
            brk                ; $de8b: 00
            brk                ; $de8c: 00
            brk                ; $de8d: 00
            brk                ; $de8e: 00
            brk                ; $de8f: 00
            brk                ; $de90: 00
            brk                ; $de91: 00
            brk                ; $de92: 00
            brk                ; $de93: 00
            brk                ; $de94: 00
            brk                ; $de95: 00
            brk                ; $de96: 00
            brk                ; $de97: 00
            brk                ; $de98: 00
            brk                ; $de99: 00
            brk                ; $de9a: 00
            brk                ; $de9b: 00
            brk                ; $de9c: 00
            brk                ; $de9d: 00
            brk                ; $de9e: 00
            brk                ; $de9f: 00
            brk                ; $dea0: 00
            brk                ; $dea1: 00
            brk                ; $dea2: 00
            brk                ; $dea3: 00
            brk                ; $dea4: 00
            brk                ; $dea5: 00
            brk                ; $dea6: 00
            brk                ; $dea7: 00
            brk                ; $dea8: 00
            brk                ; $dea9: 00
            brk                ; $deaa: 00
            brk                ; $deab: 00
            brk                ; $deac: 00
            brk                ; $dead: 00
            brk                ; $deae: 00
            brk                ; $deaf: 00
            brk                ; $deb0: 00
            brk                ; $deb1: 00
            brk                ; $deb2: 00
            brk                ; $deb3: 00
            brk                ; $deb4: 00
            brk                ; $deb5: 00
            brk                ; $deb6: 00
            brk                ; $deb7: 00
            brk                ; $deb8: 00
            brk                ; $deb9: 00
            brk                ; $deba: 00
            brk                ; $debb: 00
            brk                ; $debc: 00
            brk                ; $debd: 00
            brk                ; $debe: 00
            brk                ; $debf: 00
            brk                ; $dec0: 00
            brk                ; $dec1: 00
            brk                ; $dec2: 00
            brk                ; $dec3: 00
            brk                ; $dec4: 00
            brk                ; $dec5: 00
            brk                ; $dec6: 00
            brk                ; $dec7: 00
            brk                ; $dec8: 00
            brk                ; $dec9: 00
            brk                ; $deca: 00
            brk                ; $decb: 00
            brk                ; $decc: 00
            brk                ; $decd: 00
            brk                ; $dece: 00
            brk                ; $decf: 00
            brk                ; $ded0: 00
            brk                ; $ded1: 00
            brk                ; $ded2: 00
            brk                ; $ded3: 00
            brk                ; $ded4: 00
            brk                ; $ded5: 00
            brk                ; $ded6: 00
            brk                ; $ded7: 00
            brk                ; $ded8: 00
            brk                ; $ded9: 00
            brk                ; $deda: 00
            brk                ; $dedb: 00
            brk                ; $dedc: 00
            brk                ; $dedd: 00
            brk                ; $dede: 00
            brk                ; $dedf: 00
            brk                ; $dee0: 00
            brk                ; $dee1: 00
            brk                ; $dee2: 00
            brk                ; $dee3: 00
            brk                ; $dee4: 00
            brk                ; $dee5: 00
            brk                ; $dee6: 00
            brk                ; $dee7: 00
            brk                ; $dee8: 00
            brk                ; $dee9: 00
            brk                ; $deea: 00
            brk                ; $deeb: 00
            brk                ; $deec: 00
            brk                ; $deed: 00
            brk                ; $deee: 00
            brk                ; $deef: 00
            brk                ; $def0: 00
            brk                ; $def1: 00
            brk                ; $def2: 00
            brk                ; $def3: 00
            brk                ; $def4: 00
            brk                ; $def5: 00
            brk                ; $def6: 00
            brk                ; $def7: 00
            brk                ; $def8: 00
            brk                ; $def9: 00
            brk                ; $defa: 00
            brk                ; $defb: 00
            brk                ; $defc: 00
            brk                ; $defd: 00
            brk                ; $defe: 00
            brk                ; $deff: 00
            brk                ; $df00: 00
            brk                ; $df01: 00
            brk                ; $df02: 00
            brk                ; $df03: 00
            brk                ; $df04: 00
            brk                ; $df05: 00
            brk                ; $df06: 00
            brk                ; $df07: 00
            brk                ; $df08: 00
            brk                ; $df09: 00
            brk                ; $df0a: 00
            brk                ; $df0b: 00
            brk                ; $df0c: 00
            brk                ; $df0d: 00
            brk                ; $df0e: 00
            brk                ; $df0f: 00
            brk                ; $df10: 00
            brk                ; $df11: 00
            brk                ; $df12: 00
            brk                ; $df13: 00
            brk                ; $df14: 00
            brk                ; $df15: 00
            brk                ; $df16: 00
            brk                ; $df17: 00
            brk                ; $df18: 00
            brk                ; $df19: 00
            brk                ; $df1a: 00
            brk                ; $df1b: 00
            brk                ; $df1c: 00
            brk                ; $df1d: 00
            brk                ; $df1e: 00
            brk                ; $df1f: 00
            brk                ; $df20: 00
            brk                ; $df21: 00
            brk                ; $df22: 00
            brk                ; $df23: 00
            brk                ; $df24: 00
            brk                ; $df25: 00
            brk                ; $df26: 00
            brk                ; $df27: 00
            brk                ; $df28: 00
            brk                ; $df29: 00
            brk                ; $df2a: 00
            brk                ; $df2b: 00
            brk                ; $df2c: 00
            brk                ; $df2d: 00
            brk                ; $df2e: 00
            brk                ; $df2f: 00
            brk                ; $df30: 00
            brk                ; $df31: 00
            brk                ; $df32: 00
            brk                ; $df33: 00
            brk                ; $df34: 00
            brk                ; $df35: 00
            brk                ; $df36: 00
            brk                ; $df37: 00
            brk                ; $df38: 00
            brk                ; $df39: 00
            brk                ; $df3a: 00
            brk                ; $df3b: 00
            brk                ; $df3c: 00
            brk                ; $df3d: 00
            brk                ; $df3e: 00
            brk                ; $df3f: 00
            brk                ; $df40: 00
            brk                ; $df41: 00
            brk                ; $df42: 00
            brk                ; $df43: 00
            brk                ; $df44: 00
            brk                ; $df45: 00
            brk                ; $df46: 00
            brk                ; $df47: 00
            brk                ; $df48: 00
            brk                ; $df49: 00
            brk                ; $df4a: 00
            brk                ; $df4b: 00
            brk                ; $df4c: 00
            brk                ; $df4d: 00
            brk                ; $df4e: 00
            brk                ; $df4f: 00
            brk                ; $df50: 00
            brk                ; $df51: 00
            brk                ; $df52: 00
            brk                ; $df53: 00
            brk                ; $df54: 00
            brk                ; $df55: 00
            brk                ; $df56: 00
            brk                ; $df57: 00
            brk                ; $df58: 00
            brk                ; $df59: 00
            brk                ; $df5a: 00
            brk                ; $df5b: 00
            brk                ; $df5c: 00
            brk                ; $df5d: 00
            brk                ; $df5e: 00
            brk                ; $df5f: 00
            brk                ; $df60: 00
            brk                ; $df61: 00
            brk                ; $df62: 00
            brk                ; $df63: 00
            brk                ; $df64: 00
            brk                ; $df65: 00
            brk                ; $df66: 00
            brk                ; $df67: 00
            brk                ; $df68: 00
            brk                ; $df69: 00
            brk                ; $df6a: 00
            brk                ; $df6b: 00
            brk                ; $df6c: 00
            brk                ; $df6d: 00
            brk                ; $df6e: 00
            brk                ; $df6f: 00
            brk                ; $df70: 00
            brk                ; $df71: 00
            brk                ; $df72: 00
            brk                ; $df73: 00
            brk                ; $df74: 00
            brk                ; $df75: 00
            brk                ; $df76: 00
            brk                ; $df77: 00
            brk                ; $df78: 00
            brk                ; $df79: 00
            brk                ; $df7a: 00
            brk                ; $df7b: 00
            brk                ; $df7c: 00
            brk                ; $df7d: 00
            brk                ; $df7e: 00
            brk                ; $df7f: 00
            brk                ; $df80: 00
            brk                ; $df81: 00
            brk                ; $df82: 00
            brk                ; $df83: 00
            brk                ; $df84: 00
            brk                ; $df85: 00
            brk                ; $df86: 00
            brk                ; $df87: 00
            brk                ; $df88: 00
            brk                ; $df89: 00
            brk                ; $df8a: 00
            brk                ; $df8b: 00
            brk                ; $df8c: 00
            brk                ; $df8d: 00
            brk                ; $df8e: 00
            brk                ; $df8f: 00
            brk                ; $df90: 00
            brk                ; $df91: 00
            brk                ; $df92: 00
            brk                ; $df93: 00
            brk                ; $df94: 00
            brk                ; $df95: 00
            brk                ; $df96: 00
            brk                ; $df97: 00
            brk                ; $df98: 00
            brk                ; $df99: 00
            brk                ; $df9a: 00
            brk                ; $df9b: 00
            brk                ; $df9c: 00
            brk                ; $df9d: 00
            brk                ; $df9e: 00
            brk                ; $df9f: 00
            brk                ; $dfa0: 00
            brk                ; $dfa1: 00
            brk                ; $dfa2: 00
            brk                ; $dfa3: 00
            brk                ; $dfa4: 00
            brk                ; $dfa5: 00
            brk                ; $dfa6: 00
            brk                ; $dfa7: 00
            brk                ; $dfa8: 00
            brk                ; $dfa9: 00
            brk                ; $dfaa: 00
            brk                ; $dfab: 00
            brk                ; $dfac: 00
            brk                ; $dfad: 00
            brk                ; $dfae: 00
            brk                ; $dfaf: 00
            brk                ; $dfb0: 00
            brk                ; $dfb1: 00
            brk                ; $dfb2: 00
            brk                ; $dfb3: 00
            brk                ; $dfb4: 00
            brk                ; $dfb5: 00
            brk                ; $dfb6: 00
            brk                ; $dfb7: 00
            brk                ; $dfb8: 00
            brk                ; $dfb9: 00
            brk                ; $dfba: 00
            brk                ; $dfbb: 00
            brk                ; $dfbc: 00
            brk                ; $dfbd: 00
            brk                ; $dfbe: 00
            brk                ; $dfbf: 00
            brk                ; $dfc0: 00
            brk                ; $dfc1: 00
            brk                ; $dfc2: 00
            brk                ; $dfc3: 00
            brk                ; $dfc4: 00
            brk                ; $dfc5: 00
            brk                ; $dfc6: 00
            brk                ; $dfc7: 00
            brk                ; $dfc8: 00
            brk                ; $dfc9: 00
            brk                ; $dfca: 00
            brk                ; $dfcb: 00
            brk                ; $dfcc: 00
            brk                ; $dfcd: 00
            brk                ; $dfce: 00
            brk                ; $dfcf: 00
            brk                ; $dfd0: 00
            brk                ; $dfd1: 00
            brk                ; $dfd2: 00
            brk                ; $dfd3: 00
            brk                ; $dfd4: 00
            brk                ; $dfd5: 00
            brk                ; $dfd6: 00
            brk                ; $dfd7: 00
            brk                ; $dfd8: 00
            brk                ; $dfd9: 00
            brk                ; $dfda: 00
            brk                ; $dfdb: 00
            brk                ; $dfdc: 00
            brk                ; $dfdd: 00
            brk                ; $dfde: 00
            brk                ; $dfdf: 00
            brk                ; $dfe0: 00
            brk                ; $dfe1: 00
            brk                ; $dfe2: 00
            brk                ; $dfe3: 00
            brk                ; $dfe4: 00
            brk                ; $dfe5: 00
            brk                ; $dfe6: 00
            brk                ; $dfe7: 00
            brk                ; $dfe8: 00
            brk                ; $dfe9: 00
            brk                ; $dfea: 00
            brk                ; $dfeb: 00
            brk                ; $dfec: 00
            brk                ; $dfed: 00
            brk                ; $dfee: 00
            brk                ; $dfef: 00
            brk                ; $dff0: 00
            brk                ; $dff1: 00
            brk                ; $dff2: 00
            brk                ; $dff3: 00
            brk                ; $dff4: 00
            brk                ; $dff5: 00
            brk                ; $dff6: 00
            brk                ; $dff7: 00
            brk                ; $dff8: 00
            brk                ; $dff9: 00
            brk                ; $dffa: 00
            brk                ; $dffb: 00
            brk                ; $dffc: 00
            brk                ; $dffd: 00
            brk                ; $dffe: 00
            brk                ; $dfff: 00
            brk                ; $e000: 00
            brk                ; $e001: 00
            brk                ; $e002: 00
            brk                ; $e003: 00
            brk                ; $e004: 00
            brk                ; $e005: 00
            brk                ; $e006: 00
            brk                ; $e007: 00
            brk                ; $e008: 00
            brk                ; $e009: 00
            brk                ; $e00a: 00
            brk                ; $e00b: 00
            brk                ; $e00c: 00
            brk                ; $e00d: 00
            brk                ; $e00e: 00
            brk                ; $e00f: 00
            brk                ; $e010: 00
            brk                ; $e011: 00
            brk                ; $e012: 00
            brk                ; $e013: 00
            brk                ; $e014: 00
            brk                ; $e015: 00
            brk                ; $e016: 00
            brk                ; $e017: 00
            brk                ; $e018: 00
            brk                ; $e019: 00
            brk                ; $e01a: 00
            brk                ; $e01b: 00
            brk                ; $e01c: 00
            brk                ; $e01d: 00
            brk                ; $e01e: 00
            brk                ; $e01f: 00
            brk                ; $e020: 00
            brk                ; $e021: 00
            brk                ; $e022: 00
            brk                ; $e023: 00
            brk                ; $e024: 00
            brk                ; $e025: 00
            brk                ; $e026: 00
            brk                ; $e027: 00
            brk                ; $e028: 00
            brk                ; $e029: 00
            brk                ; $e02a: 00
            brk                ; $e02b: 00
            brk                ; $e02c: 00
            brk                ; $e02d: 00
            brk                ; $e02e: 00
            brk                ; $e02f: 00
            brk                ; $e030: 00
            brk                ; $e031: 00
            brk                ; $e032: 00
            brk                ; $e033: 00
            brk                ; $e034: 00
            brk                ; $e035: 00
            brk                ; $e036: 00
            brk                ; $e037: 00
            brk                ; $e038: 00
            brk                ; $e039: 00
            brk                ; $e03a: 00
            brk                ; $e03b: 00
            brk                ; $e03c: 00
            brk                ; $e03d: 00
            brk                ; $e03e: 00
            brk                ; $e03f: 00
            brk                ; $e040: 00
            brk                ; $e041: 00
            brk                ; $e042: 00
            brk                ; $e043: 00
            brk                ; $e044: 00
            brk                ; $e045: 00
            brk                ; $e046: 00
            brk                ; $e047: 00
            brk                ; $e048: 00
            brk                ; $e049: 00
            brk                ; $e04a: 00
            brk                ; $e04b: 00
            brk                ; $e04c: 00
            brk                ; $e04d: 00
            brk                ; $e04e: 00
            brk                ; $e04f: 00
            brk                ; $e050: 00
            brk                ; $e051: 00
            brk                ; $e052: 00
            brk                ; $e053: 00
            brk                ; $e054: 00
            brk                ; $e055: 00
            brk                ; $e056: 00
            brk                ; $e057: 00
            brk                ; $e058: 00
            brk                ; $e059: 00
            brk                ; $e05a: 00
            brk                ; $e05b: 00
            brk                ; $e05c: 00
            brk                ; $e05d: 00
            brk                ; $e05e: 00
            brk                ; $e05f: 00
            brk                ; $e060: 00
            brk                ; $e061: 00
            brk                ; $e062: 00
            brk                ; $e063: 00
            brk                ; $e064: 00
            brk                ; $e065: 00
            brk                ; $e066: 00
            brk                ; $e067: 00
            brk                ; $e068: 00
            brk                ; $e069: 00
            brk                ; $e06a: 00
            brk                ; $e06b: 00
            brk                ; $e06c: 00
            brk                ; $e06d: 00
            brk                ; $e06e: 00
            brk                ; $e06f: 00
            brk                ; $e070: 00
            brk                ; $e071: 00
            brk                ; $e072: 00
            brk                ; $e073: 00
            brk                ; $e074: 00
            brk                ; $e075: 00
            brk                ; $e076: 00
            brk                ; $e077: 00
            brk                ; $e078: 00
            brk                ; $e079: 00
            brk                ; $e07a: 00
            brk                ; $e07b: 00
            brk                ; $e07c: 00
            brk                ; $e07d: 00
            brk                ; $e07e: 00
            brk                ; $e07f: 00
            brk                ; $e080: 00
            brk                ; $e081: 00
            brk                ; $e082: 00
            brk                ; $e083: 00
            brk                ; $e084: 00
            brk                ; $e085: 00
            brk                ; $e086: 00
            brk                ; $e087: 00
            brk                ; $e088: 00
            brk                ; $e089: 00
            brk                ; $e08a: 00
            brk                ; $e08b: 00
            brk                ; $e08c: 00
            brk                ; $e08d: 00
            brk                ; $e08e: 00
            brk                ; $e08f: 00
            brk                ; $e090: 00
            brk                ; $e091: 00
            brk                ; $e092: 00
            brk                ; $e093: 00
            brk                ; $e094: 00
            brk                ; $e095: 00
            brk                ; $e096: 00
            brk                ; $e097: 00
            brk                ; $e098: 00
            brk                ; $e099: 00
            brk                ; $e09a: 00
            brk                ; $e09b: 00
            brk                ; $e09c: 00
            brk                ; $e09d: 00
            brk                ; $e09e: 00
            brk                ; $e09f: 00
            brk                ; $e0a0: 00
            brk                ; $e0a1: 00
            brk                ; $e0a2: 00
            brk                ; $e0a3: 00
            brk                ; $e0a4: 00
            brk                ; $e0a5: 00
            brk                ; $e0a6: 00
            brk                ; $e0a7: 00
            brk                ; $e0a8: 00
            brk                ; $e0a9: 00
            brk                ; $e0aa: 00
            brk                ; $e0ab: 00
            brk                ; $e0ac: 00
            brk                ; $e0ad: 00
            brk                ; $e0ae: 00
            brk                ; $e0af: 00
            brk                ; $e0b0: 00
            brk                ; $e0b1: 00
            brk                ; $e0b2: 00
            brk                ; $e0b3: 00
            brk                ; $e0b4: 00
            brk                ; $e0b5: 00
            brk                ; $e0b6: 00
            brk                ; $e0b7: 00
            brk                ; $e0b8: 00
            brk                ; $e0b9: 00
            brk                ; $e0ba: 00
            brk                ; $e0bb: 00
            brk                ; $e0bc: 00
            brk                ; $e0bd: 00
            brk                ; $e0be: 00
            brk                ; $e0bf: 00
            brk                ; $e0c0: 00
            brk                ; $e0c1: 00
            brk                ; $e0c2: 00
            brk                ; $e0c3: 00
            brk                ; $e0c4: 00
            brk                ; $e0c5: 00
            brk                ; $e0c6: 00
            brk                ; $e0c7: 00
            brk                ; $e0c8: 00
            brk                ; $e0c9: 00
            brk                ; $e0ca: 00
            brk                ; $e0cb: 00
            brk                ; $e0cc: 00
            brk                ; $e0cd: 00
            brk                ; $e0ce: 00
            brk                ; $e0cf: 00
            brk                ; $e0d0: 00
            brk                ; $e0d1: 00
            brk                ; $e0d2: 00
            brk                ; $e0d3: 00
            brk                ; $e0d4: 00
            brk                ; $e0d5: 00
            brk                ; $e0d6: 00
            brk                ; $e0d7: 00
            brk                ; $e0d8: 00
            brk                ; $e0d9: 00
            brk                ; $e0da: 00
            brk                ; $e0db: 00
            brk                ; $e0dc: 00
            brk                ; $e0dd: 00
            brk                ; $e0de: 00
            brk                ; $e0df: 00
            brk                ; $e0e0: 00
            brk                ; $e0e1: 00
            brk                ; $e0e2: 00
            brk                ; $e0e3: 00
            brk                ; $e0e4: 00
            brk                ; $e0e5: 00
            brk                ; $e0e6: 00
            brk                ; $e0e7: 00
            brk                ; $e0e8: 00
            brk                ; $e0e9: 00
            brk                ; $e0ea: 00
            brk                ; $e0eb: 00
            brk                ; $e0ec: 00
            brk                ; $e0ed: 00
            brk                ; $e0ee: 00
            brk                ; $e0ef: 00
            brk                ; $e0f0: 00
            brk                ; $e0f1: 00
            brk                ; $e0f2: 00
            brk                ; $e0f3: 00
            brk                ; $e0f4: 00
            brk                ; $e0f5: 00
            brk                ; $e0f6: 00
            brk                ; $e0f7: 00
            brk                ; $e0f8: 00
            brk                ; $e0f9: 00
            brk                ; $e0fa: 00
            brk                ; $e0fb: 00
            brk                ; $e0fc: 00
            brk                ; $e0fd: 00
            brk                ; $e0fe: 00
            brk                ; $e0ff: 00
            brk                ; $e100: 00
            brk                ; $e101: 00
            brk                ; $e102: 00
            brk                ; $e103: 00
            brk                ; $e104: 00
            brk                ; $e105: 00
            brk                ; $e106: 00
            brk                ; $e107: 00
            brk                ; $e108: 00
            brk                ; $e109: 00
            brk                ; $e10a: 00
            brk                ; $e10b: 00
            brk                ; $e10c: 00
            brk                ; $e10d: 00
            brk                ; $e10e: 00
            brk                ; $e10f: 00
            brk                ; $e110: 00
            brk                ; $e111: 00
            brk                ; $e112: 00
            brk                ; $e113: 00
            brk                ; $e114: 00
            brk                ; $e115: 00
            brk                ; $e116: 00
            brk                ; $e117: 00
            brk                ; $e118: 00
            brk                ; $e119: 00
            brk                ; $e11a: 00
            brk                ; $e11b: 00
            brk                ; $e11c: 00
            brk                ; $e11d: 00
            brk                ; $e11e: 00
            brk                ; $e11f: 00
            brk                ; $e120: 00
            brk                ; $e121: 00
            brk                ; $e122: 00
            brk                ; $e123: 00
            brk                ; $e124: 00
            brk                ; $e125: 00
            brk                ; $e126: 00
            brk                ; $e127: 00
            brk                ; $e128: 00
            brk                ; $e129: 00
            brk                ; $e12a: 00
            brk                ; $e12b: 00
            brk                ; $e12c: 00
            brk                ; $e12d: 00
            brk                ; $e12e: 00
            brk                ; $e12f: 00
            brk                ; $e130: 00
            brk                ; $e131: 00
            brk                ; $e132: 00
            brk                ; $e133: 00
            brk                ; $e134: 00
            brk                ; $e135: 00
            brk                ; $e136: 00
            brk                ; $e137: 00
            brk                ; $e138: 00
            brk                ; $e139: 00
            brk                ; $e13a: 00
            brk                ; $e13b: 00
            brk                ; $e13c: 00
            brk                ; $e13d: 00
            brk                ; $e13e: 00
            brk                ; $e13f: 00
            brk                ; $e140: 00
            brk                ; $e141: 00
            brk                ; $e142: 00
            brk                ; $e143: 00
            brk                ; $e144: 00
            brk                ; $e145: 00
            brk                ; $e146: 00
            brk                ; $e147: 00
            brk                ; $e148: 00
            brk                ; $e149: 00
            brk                ; $e14a: 00
            brk                ; $e14b: 00
            brk                ; $e14c: 00
            brk                ; $e14d: 00
            brk                ; $e14e: 00
            brk                ; $e14f: 00
            brk                ; $e150: 00
            brk                ; $e151: 00
            brk                ; $e152: 00
            brk                ; $e153: 00
            brk                ; $e154: 00
            brk                ; $e155: 00
            brk                ; $e156: 00
            brk                ; $e157: 00
            brk                ; $e158: 00
            brk                ; $e159: 00
            brk                ; $e15a: 00
            brk                ; $e15b: 00
            brk                ; $e15c: 00
            brk                ; $e15d: 00
            brk                ; $e15e: 00
            brk                ; $e15f: 00
            brk                ; $e160: 00
            brk                ; $e161: 00
            brk                ; $e162: 00
            brk                ; $e163: 00
            brk                ; $e164: 00
            brk                ; $e165: 00
            brk                ; $e166: 00
            brk                ; $e167: 00
            brk                ; $e168: 00
            brk                ; $e169: 00
            brk                ; $e16a: 00
            brk                ; $e16b: 00
            brk                ; $e16c: 00
            brk                ; $e16d: 00
            brk                ; $e16e: 00
            brk                ; $e16f: 00
            brk                ; $e170: 00
            brk                ; $e171: 00
            brk                ; $e172: 00
            brk                ; $e173: 00
            brk                ; $e174: 00
            brk                ; $e175: 00
            brk                ; $e176: 00
            brk                ; $e177: 00
            brk                ; $e178: 00
            brk                ; $e179: 00
            brk                ; $e17a: 00
            brk                ; $e17b: 00
            brk                ; $e17c: 00
            brk                ; $e17d: 00
            brk                ; $e17e: 00
            brk                ; $e17f: 00
            brk                ; $e180: 00
            brk                ; $e181: 00
            brk                ; $e182: 00
            brk                ; $e183: 00
            brk                ; $e184: 00
            brk                ; $e185: 00
            brk                ; $e186: 00
            brk                ; $e187: 00
            brk                ; $e188: 00
            brk                ; $e189: 00
            brk                ; $e18a: 00
            brk                ; $e18b: 00
            brk                ; $e18c: 00
            brk                ; $e18d: 00
            brk                ; $e18e: 00
            brk                ; $e18f: 00
            brk                ; $e190: 00
            brk                ; $e191: 00
            brk                ; $e192: 00
            brk                ; $e193: 00
            brk                ; $e194: 00
            brk                ; $e195: 00
            brk                ; $e196: 00
            brk                ; $e197: 00
            brk                ; $e198: 00
            brk                ; $e199: 00
            brk                ; $e19a: 00
            brk                ; $e19b: 00
            brk                ; $e19c: 00
            brk                ; $e19d: 00
            brk                ; $e19e: 00
            brk                ; $e19f: 00
            brk                ; $e1a0: 00
            brk                ; $e1a1: 00
            brk                ; $e1a2: 00
            brk                ; $e1a3: 00
            brk                ; $e1a4: 00
            brk                ; $e1a5: 00
            brk                ; $e1a6: 00
            brk                ; $e1a7: 00
            brk                ; $e1a8: 00
            brk                ; $e1a9: 00
            brk                ; $e1aa: 00
            brk                ; $e1ab: 00
            brk                ; $e1ac: 00
            brk                ; $e1ad: 00
            brk                ; $e1ae: 00
            brk                ; $e1af: 00
            brk                ; $e1b0: 00
            brk                ; $e1b1: 00
            brk                ; $e1b2: 00
            brk                ; $e1b3: 00
            brk                ; $e1b4: 00
            brk                ; $e1b5: 00
            brk                ; $e1b6: 00
            brk                ; $e1b7: 00
            brk                ; $e1b8: 00
            brk                ; $e1b9: 00
            brk                ; $e1ba: 00
            brk                ; $e1bb: 00
            brk                ; $e1bc: 00
            brk                ; $e1bd: 00
            brk                ; $e1be: 00
            brk                ; $e1bf: 00
            brk                ; $e1c0: 00
            brk                ; $e1c1: 00
            brk                ; $e1c2: 00
            brk                ; $e1c3: 00
            brk                ; $e1c4: 00
            brk                ; $e1c5: 00
            brk                ; $e1c6: 00
            brk                ; $e1c7: 00
            brk                ; $e1c8: 00
            brk                ; $e1c9: 00
            brk                ; $e1ca: 00
            brk                ; $e1cb: 00
            brk                ; $e1cc: 00
            brk                ; $e1cd: 00
            brk                ; $e1ce: 00
            brk                ; $e1cf: 00
            brk                ; $e1d0: 00
            brk                ; $e1d1: 00
            brk                ; $e1d2: 00
            brk                ; $e1d3: 00
            brk                ; $e1d4: 00
            brk                ; $e1d5: 00
            brk                ; $e1d6: 00
            brk                ; $e1d7: 00
            brk                ; $e1d8: 00
            brk                ; $e1d9: 00
            brk                ; $e1da: 00
            brk                ; $e1db: 00
            brk                ; $e1dc: 00
            brk                ; $e1dd: 00
            brk                ; $e1de: 00
            brk                ; $e1df: 00
            brk                ; $e1e0: 00
            brk                ; $e1e1: 00
            brk                ; $e1e2: 00
            brk                ; $e1e3: 00
            brk                ; $e1e4: 00
            brk                ; $e1e5: 00
            brk                ; $e1e6: 00
            brk                ; $e1e7: 00
            brk                ; $e1e8: 00
            brk                ; $e1e9: 00
            brk                ; $e1ea: 00
            brk                ; $e1eb: 00
            brk                ; $e1ec: 00
            brk                ; $e1ed: 00
            brk                ; $e1ee: 00
            brk                ; $e1ef: 00
            brk                ; $e1f0: 00
            brk                ; $e1f1: 00
            brk                ; $e1f2: 00
            brk                ; $e1f3: 00
            brk                ; $e1f4: 00
            brk                ; $e1f5: 00
            brk                ; $e1f6: 00
            brk                ; $e1f7: 00
            brk                ; $e1f8: 00
            brk                ; $e1f9: 00
            brk                ; $e1fa: 00
            brk                ; $e1fb: 00
            brk                ; $e1fc: 00
            brk                ; $e1fd: 00
            brk                ; $e1fe: 00
            brk                ; $e1ff: 00
            brk                ; $e200: 00
            brk                ; $e201: 00
            brk                ; $e202: 00
            brk                ; $e203: 00
            brk                ; $e204: 00
            brk                ; $e205: 00
            brk                ; $e206: 00
            brk                ; $e207: 00
            brk                ; $e208: 00
            brk                ; $e209: 00
            brk                ; $e20a: 00
            brk                ; $e20b: 00
            brk                ; $e20c: 00
            brk                ; $e20d: 00
            brk                ; $e20e: 00
            brk                ; $e20f: 00
            brk                ; $e210: 00
            brk                ; $e211: 00
            brk                ; $e212: 00
            brk                ; $e213: 00
            brk                ; $e214: 00
            brk                ; $e215: 00
            brk                ; $e216: 00
            brk                ; $e217: 00
            brk                ; $e218: 00
            brk                ; $e219: 00
            brk                ; $e21a: 00
            brk                ; $e21b: 00
            brk                ; $e21c: 00
            brk                ; $e21d: 00
            brk                ; $e21e: 00
            brk                ; $e21f: 00
            brk                ; $e220: 00
            brk                ; $e221: 00
            brk                ; $e222: 00
            brk                ; $e223: 00
            brk                ; $e224: 00
            brk                ; $e225: 00
            brk                ; $e226: 00
            brk                ; $e227: 00
            brk                ; $e228: 00
            brk                ; $e229: 00
            brk                ; $e22a: 00
            brk                ; $e22b: 00
            brk                ; $e22c: 00
            brk                ; $e22d: 00
            brk                ; $e22e: 00
            brk                ; $e22f: 00
            brk                ; $e230: 00
            brk                ; $e231: 00
            brk                ; $e232: 00
            brk                ; $e233: 00
            brk                ; $e234: 00
            brk                ; $e235: 00
            brk                ; $e236: 00
            brk                ; $e237: 00
            brk                ; $e238: 00
            brk                ; $e239: 00
            brk                ; $e23a: 00
            brk                ; $e23b: 00
            brk                ; $e23c: 00
            brk                ; $e23d: 00
            brk                ; $e23e: 00
            brk                ; $e23f: 00
            brk                ; $e240: 00
            brk                ; $e241: 00
            brk                ; $e242: 00
            brk                ; $e243: 00
            brk                ; $e244: 00
            brk                ; $e245: 00
            brk                ; $e246: 00
            brk                ; $e247: 00
            brk                ; $e248: 00
            brk                ; $e249: 00
            brk                ; $e24a: 00
            brk                ; $e24b: 00
            brk                ; $e24c: 00
            brk                ; $e24d: 00
            brk                ; $e24e: 00
            brk                ; $e24f: 00
            brk                ; $e250: 00
            brk                ; $e251: 00
            brk                ; $e252: 00
            brk                ; $e253: 00
            brk                ; $e254: 00
            brk                ; $e255: 00
            brk                ; $e256: 00
            brk                ; $e257: 00
            brk                ; $e258: 00
            brk                ; $e259: 00
            brk                ; $e25a: 00
            brk                ; $e25b: 00
            brk                ; $e25c: 00
            brk                ; $e25d: 00
            brk                ; $e25e: 00
            brk                ; $e25f: 00
            brk                ; $e260: 00
            brk                ; $e261: 00
            brk                ; $e262: 00
            brk                ; $e263: 00
            brk                ; $e264: 00
            brk                ; $e265: 00
            brk                ; $e266: 00
            brk                ; $e267: 00
            brk                ; $e268: 00
            brk                ; $e269: 00
            brk                ; $e26a: 00
            brk                ; $e26b: 00
            brk                ; $e26c: 00
            brk                ; $e26d: 00
            brk                ; $e26e: 00
            brk                ; $e26f: 00
            brk                ; $e270: 00
            brk                ; $e271: 00
            brk                ; $e272: 00
            brk                ; $e273: 00
            brk                ; $e274: 00
            brk                ; $e275: 00
            brk                ; $e276: 00
            brk                ; $e277: 00
            brk                ; $e278: 00
            brk                ; $e279: 00
            brk                ; $e27a: 00
            brk                ; $e27b: 00
            brk                ; $e27c: 00
            brk                ; $e27d: 00
            brk                ; $e27e: 00
            brk                ; $e27f: 00
            brk                ; $e280: 00
            brk                ; $e281: 00
            brk                ; $e282: 00
            brk                ; $e283: 00
            brk                ; $e284: 00
            brk                ; $e285: 00
            brk                ; $e286: 00
            brk                ; $e287: 00
            brk                ; $e288: 00
            brk                ; $e289: 00
            brk                ; $e28a: 00
            brk                ; $e28b: 00
            brk                ; $e28c: 00
            brk                ; $e28d: 00
            brk                ; $e28e: 00
            brk                ; $e28f: 00
            brk                ; $e290: 00
            brk                ; $e291: 00
            brk                ; $e292: 00
            brk                ; $e293: 00
            brk                ; $e294: 00
            brk                ; $e295: 00
            brk                ; $e296: 00
            brk                ; $e297: 00
            brk                ; $e298: 00
            brk                ; $e299: 00
            brk                ; $e29a: 00
            brk                ; $e29b: 00
            brk                ; $e29c: 00
            brk                ; $e29d: 00
            brk                ; $e29e: 00
            brk                ; $e29f: 00
            brk                ; $e2a0: 00
            brk                ; $e2a1: 00
            brk                ; $e2a2: 00
            brk                ; $e2a3: 00
            brk                ; $e2a4: 00
            brk                ; $e2a5: 00
            brk                ; $e2a6: 00
            brk                ; $e2a7: 00
            brk                ; $e2a8: 00
            brk                ; $e2a9: 00
            brk                ; $e2aa: 00
            brk                ; $e2ab: 00
            brk                ; $e2ac: 00
            brk                ; $e2ad: 00
            brk                ; $e2ae: 00
            brk                ; $e2af: 00
            brk                ; $e2b0: 00
            brk                ; $e2b1: 00
            brk                ; $e2b2: 00
            brk                ; $e2b3: 00
            brk                ; $e2b4: 00
            brk                ; $e2b5: 00
            brk                ; $e2b6: 00
            brk                ; $e2b7: 00
            brk                ; $e2b8: 00
            brk                ; $e2b9: 00
            brk                ; $e2ba: 00
            brk                ; $e2bb: 00
            brk                ; $e2bc: 00
            brk                ; $e2bd: 00
            brk                ; $e2be: 00
            brk                ; $e2bf: 00
            brk                ; $e2c0: 00
            brk                ; $e2c1: 00
            brk                ; $e2c2: 00
            brk                ; $e2c3: 00
            brk                ; $e2c4: 00
            brk                ; $e2c5: 00
            brk                ; $e2c6: 00
            brk                ; $e2c7: 00
            brk                ; $e2c8: 00
            brk                ; $e2c9: 00
            brk                ; $e2ca: 00
            brk                ; $e2cb: 00
            brk                ; $e2cc: 00
            brk                ; $e2cd: 00
            brk                ; $e2ce: 00
            brk                ; $e2cf: 00
            brk                ; $e2d0: 00
            brk                ; $e2d1: 00
            brk                ; $e2d2: 00
            brk                ; $e2d3: 00
            brk                ; $e2d4: 00
            brk                ; $e2d5: 00
            brk                ; $e2d6: 00
            brk                ; $e2d7: 00
            brk                ; $e2d8: 00
            brk                ; $e2d9: 00
            brk                ; $e2da: 00
            brk                ; $e2db: 00
            brk                ; $e2dc: 00
            brk                ; $e2dd: 00
            brk                ; $e2de: 00
            brk                ; $e2df: 00
            brk                ; $e2e0: 00
            brk                ; $e2e1: 00
            brk                ; $e2e2: 00
            brk                ; $e2e3: 00
            brk                ; $e2e4: 00
            brk                ; $e2e5: 00
            brk                ; $e2e6: 00
            brk                ; $e2e7: 00
            brk                ; $e2e8: 00
            brk                ; $e2e9: 00
            brk                ; $e2ea: 00
            brk                ; $e2eb: 00
            brk                ; $e2ec: 00
            brk                ; $e2ed: 00
            brk                ; $e2ee: 00
            brk                ; $e2ef: 00
            brk                ; $e2f0: 00
            brk                ; $e2f1: 00
            brk                ; $e2f2: 00
            brk                ; $e2f3: 00
            brk                ; $e2f4: 00
            brk                ; $e2f5: 00
            brk                ; $e2f6: 00
            brk                ; $e2f7: 00
            brk                ; $e2f8: 00
            brk                ; $e2f9: 00
            brk                ; $e2fa: 00
            brk                ; $e2fb: 00
            brk                ; $e2fc: 00
            brk                ; $e2fd: 00
            brk                ; $e2fe: 00
            brk                ; $e2ff: 00
            brk                ; $e300: 00
            brk                ; $e301: 00
            brk                ; $e302: 00
            brk                ; $e303: 00
            brk                ; $e304: 00
            brk                ; $e305: 00
            brk                ; $e306: 00
            brk                ; $e307: 00
            brk                ; $e308: 00
            brk                ; $e309: 00
            brk                ; $e30a: 00
            brk                ; $e30b: 00
            brk                ; $e30c: 00
            brk                ; $e30d: 00
            brk                ; $e30e: 00
            brk                ; $e30f: 00
            brk                ; $e310: 00
            brk                ; $e311: 00
            brk                ; $e312: 00
            brk                ; $e313: 00
            brk                ; $e314: 00
            brk                ; $e315: 00
            brk                ; $e316: 00
            brk                ; $e317: 00
            brk                ; $e318: 00
            brk                ; $e319: 00
            brk                ; $e31a: 00
            brk                ; $e31b: 00
            brk                ; $e31c: 00
            brk                ; $e31d: 00
            brk                ; $e31e: 00
            brk                ; $e31f: 00
            brk                ; $e320: 00
            brk                ; $e321: 00
            brk                ; $e322: 00
            brk                ; $e323: 00
            brk                ; $e324: 00
            brk                ; $e325: 00
            brk                ; $e326: 00
            brk                ; $e327: 00
            brk                ; $e328: 00
            brk                ; $e329: 00
            brk                ; $e32a: 00
            brk                ; $e32b: 00
            brk                ; $e32c: 00
            brk                ; $e32d: 00
            brk                ; $e32e: 00
            brk                ; $e32f: 00
            brk                ; $e330: 00
            brk                ; $e331: 00
            brk                ; $e332: 00
            brk                ; $e333: 00
            brk                ; $e334: 00
            brk                ; $e335: 00
            brk                ; $e336: 00
            brk                ; $e337: 00
            brk                ; $e338: 00
            brk                ; $e339: 00
            brk                ; $e33a: 00
            brk                ; $e33b: 00
            brk                ; $e33c: 00
            brk                ; $e33d: 00
            brk                ; $e33e: 00
            brk                ; $e33f: 00
            brk                ; $e340: 00
            brk                ; $e341: 00
            brk                ; $e342: 00
            brk                ; $e343: 00
            brk                ; $e344: 00
            brk                ; $e345: 00
            brk                ; $e346: 00
            brk                ; $e347: 00
            brk                ; $e348: 00
            brk                ; $e349: 00
            brk                ; $e34a: 00
            brk                ; $e34b: 00
            brk                ; $e34c: 00
            brk                ; $e34d: 00
            brk                ; $e34e: 00
            brk                ; $e34f: 00
            brk                ; $e350: 00
            brk                ; $e351: 00
            brk                ; $e352: 00
            brk                ; $e353: 00
            brk                ; $e354: 00
            brk                ; $e355: 00
            brk                ; $e356: 00
            brk                ; $e357: 00
            brk                ; $e358: 00
            brk                ; $e359: 00
            brk                ; $e35a: 00
            brk                ; $e35b: 00
            brk                ; $e35c: 00
            brk                ; $e35d: 00
            brk                ; $e35e: 00
            brk                ; $e35f: 00
            brk                ; $e360: 00
            brk                ; $e361: 00
            brk                ; $e362: 00
            brk                ; $e363: 00
            brk                ; $e364: 00
            brk                ; $e365: 00
            brk                ; $e366: 00
            brk                ; $e367: 00
            brk                ; $e368: 00
            brk                ; $e369: 00
            brk                ; $e36a: 00
            brk                ; $e36b: 00
            brk                ; $e36c: 00
            brk                ; $e36d: 00
            brk                ; $e36e: 00
            brk                ; $e36f: 00
            brk                ; $e370: 00
            brk                ; $e371: 00
            brk                ; $e372: 00
            brk                ; $e373: 00
            brk                ; $e374: 00
            brk                ; $e375: 00
            brk                ; $e376: 00
            brk                ; $e377: 00
            brk                ; $e378: 00
            brk                ; $e379: 00
            brk                ; $e37a: 00
            brk                ; $e37b: 00
            brk                ; $e37c: 00
            brk                ; $e37d: 00
            brk                ; $e37e: 00
            brk                ; $e37f: 00
            brk                ; $e380: 00
            brk                ; $e381: 00
            brk                ; $e382: 00
            brk                ; $e383: 00
            brk                ; $e384: 00
            brk                ; $e385: 00
            brk                ; $e386: 00
            brk                ; $e387: 00
            brk                ; $e388: 00
            brk                ; $e389: 00
            brk                ; $e38a: 00
            brk                ; $e38b: 00
            brk                ; $e38c: 00
            brk                ; $e38d: 00
            brk                ; $e38e: 00
            brk                ; $e38f: 00
            brk                ; $e390: 00
            brk                ; $e391: 00
            brk                ; $e392: 00
            brk                ; $e393: 00
            brk                ; $e394: 00
            brk                ; $e395: 00
            brk                ; $e396: 00
            brk                ; $e397: 00
            brk                ; $e398: 00
            brk                ; $e399: 00
            brk                ; $e39a: 00
            brk                ; $e39b: 00
            brk                ; $e39c: 00
            brk                ; $e39d: 00
            brk                ; $e39e: 00
            brk                ; $e39f: 00
            brk                ; $e3a0: 00
            brk                ; $e3a1: 00
            brk                ; $e3a2: 00
            brk                ; $e3a3: 00
            brk                ; $e3a4: 00
            brk                ; $e3a5: 00
            brk                ; $e3a6: 00
            brk                ; $e3a7: 00
            brk                ; $e3a8: 00
            brk                ; $e3a9: 00
            brk                ; $e3aa: 00
            brk                ; $e3ab: 00
            brk                ; $e3ac: 00
            brk                ; $e3ad: 00
            brk                ; $e3ae: 00
            brk                ; $e3af: 00
            brk                ; $e3b0: 00
            brk                ; $e3b1: 00
            brk                ; $e3b2: 00
            brk                ; $e3b3: 00
            brk                ; $e3b4: 00
            brk                ; $e3b5: 00
            brk                ; $e3b6: 00
            brk                ; $e3b7: 00
            brk                ; $e3b8: 00
            brk                ; $e3b9: 00
            brk                ; $e3ba: 00
            brk                ; $e3bb: 00
            brk                ; $e3bc: 00
            brk                ; $e3bd: 00
            brk                ; $e3be: 00
            brk                ; $e3bf: 00
            brk                ; $e3c0: 00
            brk                ; $e3c1: 00
            brk                ; $e3c2: 00
            brk                ; $e3c3: 00
            brk                ; $e3c4: 00
            brk                ; $e3c5: 00
            brk                ; $e3c6: 00
            brk                ; $e3c7: 00
            brk                ; $e3c8: 00
            brk                ; $e3c9: 00
            brk                ; $e3ca: 00
            brk                ; $e3cb: 00
            brk                ; $e3cc: 00
            brk                ; $e3cd: 00
            brk                ; $e3ce: 00
            brk                ; $e3cf: 00
            brk                ; $e3d0: 00
            brk                ; $e3d1: 00
            brk                ; $e3d2: 00
            brk                ; $e3d3: 00
            brk                ; $e3d4: 00
            brk                ; $e3d5: 00
            brk                ; $e3d6: 00
            brk                ; $e3d7: 00
            brk                ; $e3d8: 00
            brk                ; $e3d9: 00
            brk                ; $e3da: 00
            brk                ; $e3db: 00
            brk                ; $e3dc: 00
            brk                ; $e3dd: 00
            brk                ; $e3de: 00
            brk                ; $e3df: 00
            brk                ; $e3e0: 00
            brk                ; $e3e1: 00
            brk                ; $e3e2: 00
            brk                ; $e3e3: 00
            brk                ; $e3e4: 00
            brk                ; $e3e5: 00
            brk                ; $e3e6: 00
            brk                ; $e3e7: 00
            brk                ; $e3e8: 00
            brk                ; $e3e9: 00
            brk                ; $e3ea: 00
            brk                ; $e3eb: 00
            brk                ; $e3ec: 00
            brk                ; $e3ed: 00
            brk                ; $e3ee: 00
            brk                ; $e3ef: 00
            brk                ; $e3f0: 00
            brk                ; $e3f1: 00
            brk                ; $e3f2: 00
            brk                ; $e3f3: 00
            brk                ; $e3f4: 00
            brk                ; $e3f5: 00
            brk                ; $e3f6: 00
            brk                ; $e3f7: 00
            brk                ; $e3f8: 00
            brk                ; $e3f9: 00
            brk                ; $e3fa: 00
            brk                ; $e3fb: 00
            brk                ; $e3fc: 00
            brk                ; $e3fd: 00
            brk                ; $e3fe: 00
            brk                ; $e3ff: 00
            brk                ; $e400: 00
            brk                ; $e401: 00
            brk                ; $e402: 00
            brk                ; $e403: 00
            brk                ; $e404: 00
            brk                ; $e405: 00
            brk                ; $e406: 00
            brk                ; $e407: 00
            brk                ; $e408: 00
__e409:     brk                ; $e409: 00
            brk                ; $e40a: 00
            brk                ; $e40b: 00
            brk                ; $e40c: 00
            brk                ; $e40d: 00
            brk                ; $e40e: 00
            brk                ; $e40f: 00
            brk                ; $e410: 00
            brk                ; $e411: 00
            brk                ; $e412: 00
            brk                ; $e413: 00
            brk                ; $e414: 00
            brk                ; $e415: 00
            brk                ; $e416: 00
            brk                ; $e417: 00
            brk                ; $e418: 00
            brk                ; $e419: 00
            brk                ; $e41a: 00
            brk                ; $e41b: 00
            brk                ; $e41c: 00
            brk                ; $e41d: 00
            brk                ; $e41e: 00
            brk                ; $e41f: 00
            brk                ; $e420: 00
            brk                ; $e421: 00
            brk                ; $e422: 00
            brk                ; $e423: 00
            brk                ; $e424: 00
            brk                ; $e425: 00
            brk                ; $e426: 00
            brk                ; $e427: 00
            brk                ; $e428: 00
            brk                ; $e429: 00
            brk                ; $e42a: 00
            brk                ; $e42b: 00
            brk                ; $e42c: 00
            brk                ; $e42d: 00
            brk                ; $e42e: 00
            brk                ; $e42f: 00
            brk                ; $e430: 00
            brk                ; $e431: 00
            brk                ; $e432: 00
            brk                ; $e433: 00
            brk                ; $e434: 00
            brk                ; $e435: 00
            brk                ; $e436: 00
            brk                ; $e437: 00
            brk                ; $e438: 00
            brk                ; $e439: 00
            brk                ; $e43a: 00
            brk                ; $e43b: 00
            brk                ; $e43c: 00
            brk                ; $e43d: 00
            brk                ; $e43e: 00
            brk                ; $e43f: 00
            brk                ; $e440: 00
            brk                ; $e441: 00
            brk                ; $e442: 00
            brk                ; $e443: 00
            brk                ; $e444: 00
            brk                ; $e445: 00
            brk                ; $e446: 00
            brk                ; $e447: 00
            brk                ; $e448: 00
            brk                ; $e449: 00
            brk                ; $e44a: 00
            brk                ; $e44b: 00
            brk                ; $e44c: 00
            brk                ; $e44d: 00
            brk                ; $e44e: 00
            brk                ; $e44f: 00
            brk                ; $e450: 00
            brk                ; $e451: 00
            brk                ; $e452: 00
            brk                ; $e453: 00
            brk                ; $e454: 00
            brk                ; $e455: 00
            brk                ; $e456: 00
            brk                ; $e457: 00
            brk                ; $e458: 00
            brk                ; $e459: 00
            brk                ; $e45a: 00
            brk                ; $e45b: 00
            brk                ; $e45c: 00
            brk                ; $e45d: 00
            brk                ; $e45e: 00
            brk                ; $e45f: 00
            brk                ; $e460: 00
            brk                ; $e461: 00
            brk                ; $e462: 00
            brk                ; $e463: 00
            brk                ; $e464: 00
            brk                ; $e465: 00
            brk                ; $e466: 00
            brk                ; $e467: 00
            brk                ; $e468: 00
            brk                ; $e469: 00
            brk                ; $e46a: 00
            brk                ; $e46b: 00
            brk                ; $e46c: 00
            brk                ; $e46d: 00
            brk                ; $e46e: 00
            brk                ; $e46f: 00
            brk                ; $e470: 00
            brk                ; $e471: 00
            brk                ; $e472: 00
            brk                ; $e473: 00
            brk                ; $e474: 00
            brk                ; $e475: 00
            brk                ; $e476: 00
            brk                ; $e477: 00
            brk                ; $e478: 00
            brk                ; $e479: 00
            brk                ; $e47a: 00
            brk                ; $e47b: 00
            brk                ; $e47c: 00
            brk                ; $e47d: 00
            brk                ; $e47e: 00
            brk                ; $e47f: 00
            brk                ; $e480: 00
            brk                ; $e481: 00
            brk                ; $e482: 00
            brk                ; $e483: 00
            brk                ; $e484: 00
            brk                ; $e485: 00
            brk                ; $e486: 00
            brk                ; $e487: 00
            brk                ; $e488: 00
            brk                ; $e489: 00
            brk                ; $e48a: 00
            brk                ; $e48b: 00
            brk                ; $e48c: 00
            brk                ; $e48d: 00
            brk                ; $e48e: 00
            brk                ; $e48f: 00
            brk                ; $e490: 00
            brk                ; $e491: 00
            brk                ; $e492: 00
            brk                ; $e493: 00
            brk                ; $e494: 00
            brk                ; $e495: 00
            brk                ; $e496: 00
            brk                ; $e497: 00
            brk                ; $e498: 00
            brk                ; $e499: 00
            brk                ; $e49a: 00
            brk                ; $e49b: 00
            brk                ; $e49c: 00
            brk                ; $e49d: 00
            brk                ; $e49e: 00
            brk                ; $e49f: 00
            brk                ; $e4a0: 00
            brk                ; $e4a1: 00
            brk                ; $e4a2: 00
            brk                ; $e4a3: 00
            brk                ; $e4a4: 00
            brk                ; $e4a5: 00
            brk                ; $e4a6: 00
            brk                ; $e4a7: 00
            brk                ; $e4a8: 00
            brk                ; $e4a9: 00
            brk                ; $e4aa: 00
            brk                ; $e4ab: 00
            brk                ; $e4ac: 00
            brk                ; $e4ad: 00
            brk                ; $e4ae: 00
            brk                ; $e4af: 00
            brk                ; $e4b0: 00
            brk                ; $e4b1: 00
            brk                ; $e4b2: 00
            brk                ; $e4b3: 00
            brk                ; $e4b4: 00
            brk                ; $e4b5: 00
            brk                ; $e4b6: 00
            brk                ; $e4b7: 00
            brk                ; $e4b8: 00
            brk                ; $e4b9: 00
            brk                ; $e4ba: 00
            brk                ; $e4bb: 00
            brk                ; $e4bc: 00
            brk                ; $e4bd: 00
            brk                ; $e4be: 00
            brk                ; $e4bf: 00
            brk                ; $e4c0: 00
            brk                ; $e4c1: 00
            brk                ; $e4c2: 00
            brk                ; $e4c3: 00
            brk                ; $e4c4: 00
            brk                ; $e4c5: 00
            brk                ; $e4c6: 00
            brk                ; $e4c7: 00
            brk                ; $e4c8: 00
            brk                ; $e4c9: 00
            brk                ; $e4ca: 00
            brk                ; $e4cb: 00
            brk                ; $e4cc: 00
            brk                ; $e4cd: 00
            brk                ; $e4ce: 00
            brk                ; $e4cf: 00
            brk                ; $e4d0: 00
            brk                ; $e4d1: 00
            brk                ; $e4d2: 00
            brk                ; $e4d3: 00
            brk                ; $e4d4: 00
            brk                ; $e4d5: 00
            brk                ; $e4d6: 00
            brk                ; $e4d7: 00
            brk                ; $e4d8: 00
            brk                ; $e4d9: 00
            brk                ; $e4da: 00
            brk                ; $e4db: 00
            brk                ; $e4dc: 00
            brk                ; $e4dd: 00
            brk                ; $e4de: 00
            brk                ; $e4df: 00
            brk                ; $e4e0: 00
            brk                ; $e4e1: 00
            brk                ; $e4e2: 00
            brk                ; $e4e3: 00
            brk                ; $e4e4: 00
            brk                ; $e4e5: 00
            brk                ; $e4e6: 00
            brk                ; $e4e7: 00
            brk                ; $e4e8: 00
            brk                ; $e4e9: 00
            brk                ; $e4ea: 00
            brk                ; $e4eb: 00
            brk                ; $e4ec: 00
            brk                ; $e4ed: 00
            brk                ; $e4ee: 00
            brk                ; $e4ef: 00
            brk                ; $e4f0: 00
            brk                ; $e4f1: 00
            brk                ; $e4f2: 00
            brk                ; $e4f3: 00
            brk                ; $e4f4: 00
            brk                ; $e4f5: 00
            brk                ; $e4f6: 00
            brk                ; $e4f7: 00
            brk                ; $e4f8: 00
            brk                ; $e4f9: 00
            brk                ; $e4fa: 00
            brk                ; $e4fb: 00
            brk                ; $e4fc: 00
            brk                ; $e4fd: 00
            brk                ; $e4fe: 00
            brk                ; $e4ff: 00
            brk                ; $e500: 00
__e501:     brk                ; $e501: 00
            brk                ; $e502: 00
            brk                ; $e503: 00
            brk                ; $e504: 00
            brk                ; $e505: 00
            brk                ; $e506: 00
            brk                ; $e507: 00
            brk                ; $e508: 00
            brk                ; $e509: 00
            brk                ; $e50a: 00
            brk                ; $e50b: 00
            brk                ; $e50c: 00
            brk                ; $e50d: 00
            brk                ; $e50e: 00
            brk                ; $e50f: 00
            brk                ; $e510: 00
            brk                ; $e511: 00
            brk                ; $e512: 00
            brk                ; $e513: 00
            brk                ; $e514: 00
            brk                ; $e515: 00
            brk                ; $e516: 00
            brk                ; $e517: 00
            brk                ; $e518: 00
            brk                ; $e519: 00
            brk                ; $e51a: 00
            brk                ; $e51b: 00
            brk                ; $e51c: 00
            brk                ; $e51d: 00
            brk                ; $e51e: 00
            brk                ; $e51f: 00
            brk                ; $e520: 00
            brk                ; $e521: 00
            brk                ; $e522: 00
            brk                ; $e523: 00
            brk                ; $e524: 00
            brk                ; $e525: 00
            brk                ; $e526: 00
            brk                ; $e527: 00
            brk                ; $e528: 00
            brk                ; $e529: 00
            brk                ; $e52a: 00
            brk                ; $e52b: 00
            brk                ; $e52c: 00
            brk                ; $e52d: 00
            brk                ; $e52e: 00
            brk                ; $e52f: 00
            brk                ; $e530: 00
            brk                ; $e531: 00
            brk                ; $e532: 00
            brk                ; $e533: 00
            brk                ; $e534: 00
            brk                ; $e535: 00
            brk                ; $e536: 00
            brk                ; $e537: 00
            brk                ; $e538: 00
            brk                ; $e539: 00
            brk                ; $e53a: 00
            brk                ; $e53b: 00
            brk                ; $e53c: 00
            brk                ; $e53d: 00
            brk                ; $e53e: 00
            brk                ; $e53f: 00
            brk                ; $e540: 00
            brk                ; $e541: 00
            brk                ; $e542: 00
            brk                ; $e543: 00
            brk                ; $e544: 00
            brk                ; $e545: 00
            brk                ; $e546: 00
            brk                ; $e547: 00
            brk                ; $e548: 00
            brk                ; $e549: 00
            brk                ; $e54a: 00
            brk                ; $e54b: 00
            brk                ; $e54c: 00
            brk                ; $e54d: 00
            brk                ; $e54e: 00
            brk                ; $e54f: 00
            brk                ; $e550: 00
            brk                ; $e551: 00
            brk                ; $e552: 00
            brk                ; $e553: 00
            brk                ; $e554: 00
            brk                ; $e555: 00
            brk                ; $e556: 00
            brk                ; $e557: 00
            brk                ; $e558: 00
            brk                ; $e559: 00
            brk                ; $e55a: 00
            brk                ; $e55b: 00
            brk                ; $e55c: 00
            brk                ; $e55d: 00
            brk                ; $e55e: 00
            brk                ; $e55f: 00
            brk                ; $e560: 00
            brk                ; $e561: 00
            brk                ; $e562: 00
            brk                ; $e563: 00
            brk                ; $e564: 00
            brk                ; $e565: 00
            brk                ; $e566: 00
            brk                ; $e567: 00
            brk                ; $e568: 00
            brk                ; $e569: 00
            brk                ; $e56a: 00
            brk                ; $e56b: 00
            brk                ; $e56c: 00
            brk                ; $e56d: 00
            brk                ; $e56e: 00
            brk                ; $e56f: 00
            brk                ; $e570: 00
            brk                ; $e571: 00
            brk                ; $e572: 00
            brk                ; $e573: 00
            brk                ; $e574: 00
            brk                ; $e575: 00
            brk                ; $e576: 00
            brk                ; $e577: 00
            brk                ; $e578: 00
            brk                ; $e579: 00
            brk                ; $e57a: 00
            brk                ; $e57b: 00
            brk                ; $e57c: 00
            brk                ; $e57d: 00
            brk                ; $e57e: 00
            brk                ; $e57f: 00
            brk                ; $e580: 00
            brk                ; $e581: 00
            brk                ; $e582: 00
            brk                ; $e583: 00
            brk                ; $e584: 00
            brk                ; $e585: 00
            brk                ; $e586: 00
            brk                ; $e587: 00
            brk                ; $e588: 00
            brk                ; $e589: 00
            brk                ; $e58a: 00
            brk                ; $e58b: 00
            brk                ; $e58c: 00
            brk                ; $e58d: 00
            brk                ; $e58e: 00
            brk                ; $e58f: 00
            brk                ; $e590: 00
            brk                ; $e591: 00
            brk                ; $e592: 00
            brk                ; $e593: 00
            brk                ; $e594: 00
            brk                ; $e595: 00
            brk                ; $e596: 00
            brk                ; $e597: 00
            brk                ; $e598: 00
            brk                ; $e599: 00
            brk                ; $e59a: 00
            brk                ; $e59b: 00
            brk                ; $e59c: 00
            brk                ; $e59d: 00
            brk                ; $e59e: 00
            brk                ; $e59f: 00
            brk                ; $e5a0: 00
            brk                ; $e5a1: 00
            brk                ; $e5a2: 00
            brk                ; $e5a3: 00
            brk                ; $e5a4: 00
            brk                ; $e5a5: 00
            brk                ; $e5a6: 00
            brk                ; $e5a7: 00
            brk                ; $e5a8: 00
            brk                ; $e5a9: 00
            brk                ; $e5aa: 00
            brk                ; $e5ab: 00
            brk                ; $e5ac: 00
            brk                ; $e5ad: 00
            brk                ; $e5ae: 00
            brk                ; $e5af: 00
            brk                ; $e5b0: 00
            brk                ; $e5b1: 00
            brk                ; $e5b2: 00
            brk                ; $e5b3: 00
            brk                ; $e5b4: 00
            brk                ; $e5b5: 00
            brk                ; $e5b6: 00
            brk                ; $e5b7: 00
            brk                ; $e5b8: 00
            brk                ; $e5b9: 00
            brk                ; $e5ba: 00
            brk                ; $e5bb: 00
            brk                ; $e5bc: 00
            brk                ; $e5bd: 00
            brk                ; $e5be: 00
            brk                ; $e5bf: 00
            brk                ; $e5c0: 00
            brk                ; $e5c1: 00
            brk                ; $e5c2: 00
            brk                ; $e5c3: 00
            brk                ; $e5c4: 00
            brk                ; $e5c5: 00
            brk                ; $e5c6: 00
            brk                ; $e5c7: 00
            brk                ; $e5c8: 00
            brk                ; $e5c9: 00
            brk                ; $e5ca: 00
            brk                ; $e5cb: 00
            brk                ; $e5cc: 00
            brk                ; $e5cd: 00
            brk                ; $e5ce: 00
            brk                ; $e5cf: 00
            brk                ; $e5d0: 00
            brk                ; $e5d1: 00
            brk                ; $e5d2: 00
            brk                ; $e5d3: 00
            brk                ; $e5d4: 00
            brk                ; $e5d5: 00
            brk                ; $e5d6: 00
            brk                ; $e5d7: 00
            brk                ; $e5d8: 00
            brk                ; $e5d9: 00
            brk                ; $e5da: 00
            brk                ; $e5db: 00
            brk                ; $e5dc: 00
            brk                ; $e5dd: 00
            brk                ; $e5de: 00
            brk                ; $e5df: 00
            brk                ; $e5e0: 00
            brk                ; $e5e1: 00
            brk                ; $e5e2: 00
            brk                ; $e5e3: 00
            brk                ; $e5e4: 00
            brk                ; $e5e5: 00
            brk                ; $e5e6: 00
            brk                ; $e5e7: 00
            brk                ; $e5e8: 00
            brk                ; $e5e9: 00
            brk                ; $e5ea: 00
            brk                ; $e5eb: 00
            brk                ; $e5ec: 00
            brk                ; $e5ed: 00
            brk                ; $e5ee: 00
            brk                ; $e5ef: 00
            brk                ; $e5f0: 00
            brk                ; $e5f1: 00
            brk                ; $e5f2: 00
            brk                ; $e5f3: 00
            brk                ; $e5f4: 00
            brk                ; $e5f5: 00
            brk                ; $e5f6: 00
            brk                ; $e5f7: 00
            brk                ; $e5f8: 00
            brk                ; $e5f9: 00
            brk                ; $e5fa: 00
            brk                ; $e5fb: 00
            brk                ; $e5fc: 00
            brk                ; $e5fd: 00
            brk                ; $e5fe: 00
            brk                ; $e5ff: 00
            brk                ; $e600: 00
            brk                ; $e601: 00
            brk                ; $e602: 00
            brk                ; $e603: 00
            brk                ; $e604: 00
            brk                ; $e605: 00
            brk                ; $e606: 00
            brk                ; $e607: 00
            brk                ; $e608: 00
            brk                ; $e609: 00
            brk                ; $e60a: 00
            brk                ; $e60b: 00
            brk                ; $e60c: 00
            brk                ; $e60d: 00
            brk                ; $e60e: 00
            brk                ; $e60f: 00
            brk                ; $e610: 00
            brk                ; $e611: 00
            brk                ; $e612: 00
            brk                ; $e613: 00
            brk                ; $e614: 00
            brk                ; $e615: 00
            brk                ; $e616: 00
            brk                ; $e617: 00
            brk                ; $e618: 00
            brk                ; $e619: 00
            brk                ; $e61a: 00
            brk                ; $e61b: 00
            brk                ; $e61c: 00
            brk                ; $e61d: 00
            brk                ; $e61e: 00
            brk                ; $e61f: 00
            brk                ; $e620: 00
            brk                ; $e621: 00
            brk                ; $e622: 00
            brk                ; $e623: 00
            brk                ; $e624: 00
            brk                ; $e625: 00
            brk                ; $e626: 00
            brk                ; $e627: 00
            brk                ; $e628: 00
            brk                ; $e629: 00
            brk                ; $e62a: 00
            brk                ; $e62b: 00
            brk                ; $e62c: 00
            brk                ; $e62d: 00
            brk                ; $e62e: 00
            brk                ; $e62f: 00
            brk                ; $e630: 00
            brk                ; $e631: 00
            brk                ; $e632: 00
            brk                ; $e633: 00
            brk                ; $e634: 00
            brk                ; $e635: 00
            brk                ; $e636: 00
            brk                ; $e637: 00
            brk                ; $e638: 00
            brk                ; $e639: 00
            brk                ; $e63a: 00
            brk                ; $e63b: 00
            brk                ; $e63c: 00
            brk                ; $e63d: 00
            brk                ; $e63e: 00
            brk                ; $e63f: 00
            brk                ; $e640: 00
            brk                ; $e641: 00
            brk                ; $e642: 00
            brk                ; $e643: 00
            brk                ; $e644: 00
            brk                ; $e645: 00
            brk                ; $e646: 00
            brk                ; $e647: 00
            brk                ; $e648: 00
            brk                ; $e649: 00
            brk                ; $e64a: 00
            brk                ; $e64b: 00
            brk                ; $e64c: 00
            brk                ; $e64d: 00
            brk                ; $e64e: 00
            brk                ; $e64f: 00
            brk                ; $e650: 00
            brk                ; $e651: 00
            brk                ; $e652: 00
            brk                ; $e653: 00
            brk                ; $e654: 00
            brk                ; $e655: 00
            brk                ; $e656: 00
            brk                ; $e657: 00
            brk                ; $e658: 00
            brk                ; $e659: 00
            brk                ; $e65a: 00
            brk                ; $e65b: 00
            brk                ; $e65c: 00
            brk                ; $e65d: 00
            brk                ; $e65e: 00
            brk                ; $e65f: 00
            brk                ; $e660: 00
            brk                ; $e661: 00
            brk                ; $e662: 00
            brk                ; $e663: 00
            brk                ; $e664: 00
            brk                ; $e665: 00
            brk                ; $e666: 00
            brk                ; $e667: 00
            brk                ; $e668: 00
            brk                ; $e669: 00
            brk                ; $e66a: 00
            brk                ; $e66b: 00
            brk                ; $e66c: 00
            brk                ; $e66d: 00
            brk                ; $e66e: 00
            brk                ; $e66f: 00
            brk                ; $e670: 00
            brk                ; $e671: 00
            brk                ; $e672: 00
            brk                ; $e673: 00
            brk                ; $e674: 00
            brk                ; $e675: 00
            brk                ; $e676: 00
            brk                ; $e677: 00
            brk                ; $e678: 00
            brk                ; $e679: 00
            brk                ; $e67a: 00
            brk                ; $e67b: 00
            brk                ; $e67c: 00
            brk                ; $e67d: 00
            brk                ; $e67e: 00
            brk                ; $e67f: 00
            brk                ; $e680: 00
            brk                ; $e681: 00
            brk                ; $e682: 00
            brk                ; $e683: 00
            brk                ; $e684: 00
            brk                ; $e685: 00
            brk                ; $e686: 00
            brk                ; $e687: 00
            brk                ; $e688: 00
            brk                ; $e689: 00
            brk                ; $e68a: 00
            brk                ; $e68b: 00
            brk                ; $e68c: 00
            brk                ; $e68d: 00
            brk                ; $e68e: 00
            brk                ; $e68f: 00
            brk                ; $e690: 00
            brk                ; $e691: 00
            brk                ; $e692: 00
            brk                ; $e693: 00
            brk                ; $e694: 00
            brk                ; $e695: 00
            brk                ; $e696: 00
            brk                ; $e697: 00
            brk                ; $e698: 00
            brk                ; $e699: 00
            brk                ; $e69a: 00
            brk                ; $e69b: 00
            brk                ; $e69c: 00
            brk                ; $e69d: 00
            brk                ; $e69e: 00
            brk                ; $e69f: 00
            brk                ; $e6a0: 00
            brk                ; $e6a1: 00
            brk                ; $e6a2: 00
            brk                ; $e6a3: 00
            brk                ; $e6a4: 00
            brk                ; $e6a5: 00
            brk                ; $e6a6: 00
            brk                ; $e6a7: 00
            brk                ; $e6a8: 00
            brk                ; $e6a9: 00
            brk                ; $e6aa: 00
            brk                ; $e6ab: 00
            brk                ; $e6ac: 00
            brk                ; $e6ad: 00
            brk                ; $e6ae: 00
            brk                ; $e6af: 00
            brk                ; $e6b0: 00
            brk                ; $e6b1: 00
            brk                ; $e6b2: 00
            brk                ; $e6b3: 00
            brk                ; $e6b4: 00
            brk                ; $e6b5: 00
            brk                ; $e6b6: 00
            brk                ; $e6b7: 00
            brk                ; $e6b8: 00
            brk                ; $e6b9: 00
            brk                ; $e6ba: 00
            brk                ; $e6bb: 00
            brk                ; $e6bc: 00
            brk                ; $e6bd: 00
            brk                ; $e6be: 00
            brk                ; $e6bf: 00
            brk                ; $e6c0: 00
            brk                ; $e6c1: 00
            brk                ; $e6c2: 00
            brk                ; $e6c3: 00
            brk                ; $e6c4: 00
            brk                ; $e6c5: 00
            brk                ; $e6c6: 00
            brk                ; $e6c7: 00
            brk                ; $e6c8: 00
            brk                ; $e6c9: 00
            brk                ; $e6ca: 00
            brk                ; $e6cb: 00
            brk                ; $e6cc: 00
            brk                ; $e6cd: 00
            brk                ; $e6ce: 00
            brk                ; $e6cf: 00
            brk                ; $e6d0: 00
            brk                ; $e6d1: 00
            brk                ; $e6d2: 00
            brk                ; $e6d3: 00
            brk                ; $e6d4: 00
            brk                ; $e6d5: 00
            brk                ; $e6d6: 00
            brk                ; $e6d7: 00
            brk                ; $e6d8: 00
            brk                ; $e6d9: 00
            brk                ; $e6da: 00
            brk                ; $e6db: 00
            brk                ; $e6dc: 00
            brk                ; $e6dd: 00
            brk                ; $e6de: 00
            brk                ; $e6df: 00
            brk                ; $e6e0: 00
            brk                ; $e6e1: 00
            brk                ; $e6e2: 00
            brk                ; $e6e3: 00
            brk                ; $e6e4: 00
            brk                ; $e6e5: 00
            brk                ; $e6e6: 00
            brk                ; $e6e7: 00
            brk                ; $e6e8: 00
            brk                ; $e6e9: 00
            brk                ; $e6ea: 00
            brk                ; $e6eb: 00
            brk                ; $e6ec: 00
            brk                ; $e6ed: 00
            brk                ; $e6ee: 00
            brk                ; $e6ef: 00
            brk                ; $e6f0: 00
            brk                ; $e6f1: 00
            brk                ; $e6f2: 00
            brk                ; $e6f3: 00
            brk                ; $e6f4: 00
            brk                ; $e6f5: 00
            brk                ; $e6f6: 00
            brk                ; $e6f7: 00
            brk                ; $e6f8: 00
            brk                ; $e6f9: 00
            brk                ; $e6fa: 00
            brk                ; $e6fb: 00
            brk                ; $e6fc: 00
            brk                ; $e6fd: 00
            brk                ; $e6fe: 00
            brk                ; $e6ff: 00
            brk                ; $e700: 00
            brk                ; $e701: 00
            brk                ; $e702: 00
            brk                ; $e703: 00
            brk                ; $e704: 00
            brk                ; $e705: 00
            brk                ; $e706: 00
            brk                ; $e707: 00
            brk                ; $e708: 00
            brk                ; $e709: 00
            brk                ; $e70a: 00
            brk                ; $e70b: 00
            brk                ; $e70c: 00
            brk                ; $e70d: 00
            brk                ; $e70e: 00
            brk                ; $e70f: 00
            brk                ; $e710: 00
            brk                ; $e711: 00
            brk                ; $e712: 00
            brk                ; $e713: 00
            brk                ; $e714: 00
            brk                ; $e715: 00
            brk                ; $e716: 00
            brk                ; $e717: 00
            brk                ; $e718: 00
            brk                ; $e719: 00
            brk                ; $e71a: 00
            brk                ; $e71b: 00
            brk                ; $e71c: 00
            brk                ; $e71d: 00
            brk                ; $e71e: 00
            brk                ; $e71f: 00
            brk                ; $e720: 00
            brk                ; $e721: 00
            brk                ; $e722: 00
            brk                ; $e723: 00
            brk                ; $e724: 00
            brk                ; $e725: 00
            brk                ; $e726: 00
            brk                ; $e727: 00
            brk                ; $e728: 00
            brk                ; $e729: 00
            brk                ; $e72a: 00
            brk                ; $e72b: 00
            brk                ; $e72c: 00
            brk                ; $e72d: 00
            brk                ; $e72e: 00
            brk                ; $e72f: 00
            brk                ; $e730: 00
            brk                ; $e731: 00
            brk                ; $e732: 00
            brk                ; $e733: 00
            brk                ; $e734: 00
            brk                ; $e735: 00
            brk                ; $e736: 00
            brk                ; $e737: 00
            brk                ; $e738: 00
            brk                ; $e739: 00
            brk                ; $e73a: 00
            brk                ; $e73b: 00
            brk                ; $e73c: 00
            brk                ; $e73d: 00
            brk                ; $e73e: 00
            brk                ; $e73f: 00
            brk                ; $e740: 00
            brk                ; $e741: 00
            brk                ; $e742: 00
            brk                ; $e743: 00
            brk                ; $e744: 00
            brk                ; $e745: 00
            brk                ; $e746: 00
            brk                ; $e747: 00
            brk                ; $e748: 00
            brk                ; $e749: 00
            brk                ; $e74a: 00
            brk                ; $e74b: 00
            brk                ; $e74c: 00
            brk                ; $e74d: 00
            brk                ; $e74e: 00
            brk                ; $e74f: 00
            brk                ; $e750: 00
            brk                ; $e751: 00
            brk                ; $e752: 00
            brk                ; $e753: 00
            brk                ; $e754: 00
            brk                ; $e755: 00
            brk                ; $e756: 00
            brk                ; $e757: 00
            brk                ; $e758: 00
            brk                ; $e759: 00
            brk                ; $e75a: 00
            brk                ; $e75b: 00
            brk                ; $e75c: 00
            brk                ; $e75d: 00
            brk                ; $e75e: 00
            brk                ; $e75f: 00
            brk                ; $e760: 00
            brk                ; $e761: 00
            brk                ; $e762: 00
            brk                ; $e763: 00
            brk                ; $e764: 00
            brk                ; $e765: 00
            brk                ; $e766: 00
            brk                ; $e767: 00
            brk                ; $e768: 00
            brk                ; $e769: 00
            brk                ; $e76a: 00
            brk                ; $e76b: 00
            brk                ; $e76c: 00
            brk                ; $e76d: 00
            brk                ; $e76e: 00
            brk                ; $e76f: 00
            brk                ; $e770: 00
            brk                ; $e771: 00
            brk                ; $e772: 00
            brk                ; $e773: 00
            brk                ; $e774: 00
            brk                ; $e775: 00
            brk                ; $e776: 00
            brk                ; $e777: 00
            brk                ; $e778: 00
            brk                ; $e779: 00
            brk                ; $e77a: 00
            brk                ; $e77b: 00
            brk                ; $e77c: 00
            brk                ; $e77d: 00
            brk                ; $e77e: 00
            brk                ; $e77f: 00
            brk                ; $e780: 00
            brk                ; $e781: 00
            brk                ; $e782: 00
            brk                ; $e783: 00
            brk                ; $e784: 00
            brk                ; $e785: 00
            brk                ; $e786: 00
            brk                ; $e787: 00
            brk                ; $e788: 00
            brk                ; $e789: 00
            brk                ; $e78a: 00
            brk                ; $e78b: 00
            brk                ; $e78c: 00
            brk                ; $e78d: 00
            brk                ; $e78e: 00
            brk                ; $e78f: 00
            brk                ; $e790: 00
            brk                ; $e791: 00
            brk                ; $e792: 00
            brk                ; $e793: 00
            brk                ; $e794: 00
            brk                ; $e795: 00
            brk                ; $e796: 00
            brk                ; $e797: 00
            brk                ; $e798: 00
            brk                ; $e799: 00
            brk                ; $e79a: 00
            brk                ; $e79b: 00
            brk                ; $e79c: 00
            brk                ; $e79d: 00
            brk                ; $e79e: 00
            brk                ; $e79f: 00
            brk                ; $e7a0: 00
            brk                ; $e7a1: 00
            brk                ; $e7a2: 00
            brk                ; $e7a3: 00
            brk                ; $e7a4: 00
            brk                ; $e7a5: 00
            brk                ; $e7a6: 00
            brk                ; $e7a7: 00
            brk                ; $e7a8: 00
            brk                ; $e7a9: 00
            brk                ; $e7aa: 00
            brk                ; $e7ab: 00
            brk                ; $e7ac: 00
            brk                ; $e7ad: 00
            brk                ; $e7ae: 00
            brk                ; $e7af: 00
            brk                ; $e7b0: 00
            brk                ; $e7b1: 00
            brk                ; $e7b2: 00
            brk                ; $e7b3: 00
            brk                ; $e7b4: 00
            brk                ; $e7b5: 00
            brk                ; $e7b6: 00
            brk                ; $e7b7: 00
            brk                ; $e7b8: 00
            brk                ; $e7b9: 00
            brk                ; $e7ba: 00
            brk                ; $e7bb: 00
            brk                ; $e7bc: 00
            brk                ; $e7bd: 00
            brk                ; $e7be: 00
            brk                ; $e7bf: 00
            brk                ; $e7c0: 00
            brk                ; $e7c1: 00
            brk                ; $e7c2: 00
            brk                ; $e7c3: 00
            brk                ; $e7c4: 00
            brk                ; $e7c5: 00
            brk                ; $e7c6: 00
            brk                ; $e7c7: 00
            brk                ; $e7c8: 00
            brk                ; $e7c9: 00
            brk                ; $e7ca: 00
            brk                ; $e7cb: 00
            brk                ; $e7cc: 00
            brk                ; $e7cd: 00
            brk                ; $e7ce: 00
            brk                ; $e7cf: 00
            brk                ; $e7d0: 00
            brk                ; $e7d1: 00
            brk                ; $e7d2: 00
            brk                ; $e7d3: 00
            brk                ; $e7d4: 00
            brk                ; $e7d5: 00
            brk                ; $e7d6: 00
            brk                ; $e7d7: 00
            brk                ; $e7d8: 00
            brk                ; $e7d9: 00
            brk                ; $e7da: 00
            brk                ; $e7db: 00
            brk                ; $e7dc: 00
            brk                ; $e7dd: 00
            brk                ; $e7de: 00
            brk                ; $e7df: 00
            brk                ; $e7e0: 00
            brk                ; $e7e1: 00
__e7e2:     brk                ; $e7e2: 00
            brk                ; $e7e3: 00
            brk                ; $e7e4: 00
            brk                ; $e7e5: 00
            brk                ; $e7e6: 00
            brk                ; $e7e7: 00
            brk                ; $e7e8: 00
            brk                ; $e7e9: 00
            brk                ; $e7ea: 00
__e7eb:     brk                ; $e7eb: 00
            brk                ; $e7ec: 00
            brk                ; $e7ed: 00
            brk                ; $e7ee: 00
            brk                ; $e7ef: 00
            brk                ; $e7f0: 00
            brk                ; $e7f1: 00
            brk                ; $e7f2: 00
            brk                ; $e7f3: 00
            brk                ; $e7f4: 00
            brk                ; $e7f5: 00
            brk                ; $e7f6: 00
            brk                ; $e7f7: 00
            brk                ; $e7f8: 00
            brk                ; $e7f9: 00
            brk                ; $e7fa: 00
            brk                ; $e7fb: 00
            brk                ; $e7fc: 00
            brk                ; $e7fd: 00
            brk                ; $e7fe: 00
            brk                ; $e7ff: 00
            brk                ; $e800: 00
            brk                ; $e801: 00
            brk                ; $e802: 00
            brk                ; $e803: 00
            brk                ; $e804: 00
            brk                ; $e805: 00
            brk                ; $e806: 00
            brk                ; $e807: 00
            brk                ; $e808: 00
            brk                ; $e809: 00
            brk                ; $e80a: 00
            brk                ; $e80b: 00
            brk                ; $e80c: 00
            brk                ; $e80d: 00
            brk                ; $e80e: 00
            brk                ; $e80f: 00
            brk                ; $e810: 00
            brk                ; $e811: 00
            brk                ; $e812: 00
            brk                ; $e813: 00
            brk                ; $e814: 00
            brk                ; $e815: 00
            brk                ; $e816: 00
            brk                ; $e817: 00
            brk                ; $e818: 00
            brk                ; $e819: 00
            brk                ; $e81a: 00
            brk                ; $e81b: 00
            brk                ; $e81c: 00
            brk                ; $e81d: 00
            brk                ; $e81e: 00
            brk                ; $e81f: 00
            brk                ; $e820: 00
            brk                ; $e821: 00
            brk                ; $e822: 00
            brk                ; $e823: 00
            brk                ; $e824: 00
            brk                ; $e825: 00
            brk                ; $e826: 00
            brk                ; $e827: 00
            brk                ; $e828: 00
            brk                ; $e829: 00
            brk                ; $e82a: 00
            brk                ; $e82b: 00
            brk                ; $e82c: 00
            brk                ; $e82d: 00
            brk                ; $e82e: 00
            brk                ; $e82f: 00
            brk                ; $e830: 00
            brk                ; $e831: 00
            brk                ; $e832: 00
            brk                ; $e833: 00
            brk                ; $e834: 00
            brk                ; $e835: 00
            brk                ; $e836: 00
            brk                ; $e837: 00
            brk                ; $e838: 00
            brk                ; $e839: 00
            brk                ; $e83a: 00
            brk                ; $e83b: 00
            brk                ; $e83c: 00
            brk                ; $e83d: 00
            brk                ; $e83e: 00
            brk                ; $e83f: 00
            brk                ; $e840: 00
            brk                ; $e841: 00
            brk                ; $e842: 00
            brk                ; $e843: 00
            brk                ; $e844: 00
            brk                ; $e845: 00
            brk                ; $e846: 00
            brk                ; $e847: 00
            brk                ; $e848: 00
            brk                ; $e849: 00
            brk                ; $e84a: 00
            brk                ; $e84b: 00
            brk                ; $e84c: 00
            brk                ; $e84d: 00
            brk                ; $e84e: 00
            brk                ; $e84f: 00
            brk                ; $e850: 00
            brk                ; $e851: 00
            brk                ; $e852: 00
            brk                ; $e853: 00
            brk                ; $e854: 00
            brk                ; $e855: 00
            brk                ; $e856: 00
            brk                ; $e857: 00
            brk                ; $e858: 00
            brk                ; $e859: 00
            brk                ; $e85a: 00
            brk                ; $e85b: 00
            brk                ; $e85c: 00
            brk                ; $e85d: 00
            brk                ; $e85e: 00
            brk                ; $e85f: 00
            brk                ; $e860: 00
            brk                ; $e861: 00
            brk                ; $e862: 00
            brk                ; $e863: 00
            brk                ; $e864: 00
            brk                ; $e865: 00
            brk                ; $e866: 00
            brk                ; $e867: 00
            brk                ; $e868: 00
            brk                ; $e869: 00
            brk                ; $e86a: 00
            brk                ; $e86b: 00
            brk                ; $e86c: 00
            brk                ; $e86d: 00
            brk                ; $e86e: 00
            brk                ; $e86f: 00
            brk                ; $e870: 00
            brk                ; $e871: 00
            brk                ; $e872: 00
            brk                ; $e873: 00
            brk                ; $e874: 00
            brk                ; $e875: 00
            brk                ; $e876: 00
            brk                ; $e877: 00
            brk                ; $e878: 00
            brk                ; $e879: 00
            brk                ; $e87a: 00
            brk                ; $e87b: 00
            brk                ; $e87c: 00
            brk                ; $e87d: 00
            brk                ; $e87e: 00
            brk                ; $e87f: 00
            brk                ; $e880: 00
            brk                ; $e881: 00
            brk                ; $e882: 00
            brk                ; $e883: 00
            brk                ; $e884: 00
            brk                ; $e885: 00
            brk                ; $e886: 00
            brk                ; $e887: 00
            brk                ; $e888: 00
            brk                ; $e889: 00
            brk                ; $e88a: 00
            brk                ; $e88b: 00
            brk                ; $e88c: 00
            brk                ; $e88d: 00
            brk                ; $e88e: 00
            brk                ; $e88f: 00
            brk                ; $e890: 00
            brk                ; $e891: 00
            brk                ; $e892: 00
            brk                ; $e893: 00
            brk                ; $e894: 00
            brk                ; $e895: 00
            brk                ; $e896: 00
            brk                ; $e897: 00
            brk                ; $e898: 00
            brk                ; $e899: 00
            brk                ; $e89a: 00
            brk                ; $e89b: 00
            brk                ; $e89c: 00
            brk                ; $e89d: 00
            brk                ; $e89e: 00
            brk                ; $e89f: 00
            brk                ; $e8a0: 00
            brk                ; $e8a1: 00
            brk                ; $e8a2: 00
            brk                ; $e8a3: 00
            brk                ; $e8a4: 00
            brk                ; $e8a5: 00
            brk                ; $e8a6: 00
            brk                ; $e8a7: 00
            brk                ; $e8a8: 00
            brk                ; $e8a9: 00
            brk                ; $e8aa: 00
            brk                ; $e8ab: 00
            brk                ; $e8ac: 00
            brk                ; $e8ad: 00
            brk                ; $e8ae: 00
            brk                ; $e8af: 00
            brk                ; $e8b0: 00
            brk                ; $e8b1: 00
            brk                ; $e8b2: 00
            brk                ; $e8b3: 00
            brk                ; $e8b4: 00
            brk                ; $e8b5: 00
            brk                ; $e8b6: 00
            brk                ; $e8b7: 00
            brk                ; $e8b8: 00
            brk                ; $e8b9: 00
            brk                ; $e8ba: 00
            brk                ; $e8bb: 00
            brk                ; $e8bc: 00
            brk                ; $e8bd: 00
            brk                ; $e8be: 00
            brk                ; $e8bf: 00
            brk                ; $e8c0: 00
            brk                ; $e8c1: 00
            brk                ; $e8c2: 00
            brk                ; $e8c3: 00
            brk                ; $e8c4: 00
            brk                ; $e8c5: 00
            brk                ; $e8c6: 00
            brk                ; $e8c7: 00
            brk                ; $e8c8: 00
            brk                ; $e8c9: 00
            brk                ; $e8ca: 00
            brk                ; $e8cb: 00
            brk                ; $e8cc: 00
            brk                ; $e8cd: 00
            brk                ; $e8ce: 00
            brk                ; $e8cf: 00
            brk                ; $e8d0: 00
            brk                ; $e8d1: 00
            brk                ; $e8d2: 00
            brk                ; $e8d3: 00
            brk                ; $e8d4: 00
            brk                ; $e8d5: 00
            brk                ; $e8d6: 00
            brk                ; $e8d7: 00
            brk                ; $e8d8: 00
            brk                ; $e8d9: 00
            brk                ; $e8da: 00
            brk                ; $e8db: 00
            brk                ; $e8dc: 00
            brk                ; $e8dd: 00
            brk                ; $e8de: 00
            brk                ; $e8df: 00
            brk                ; $e8e0: 00
            brk                ; $e8e1: 00
            brk                ; $e8e2: 00
            brk                ; $e8e3: 00
            brk                ; $e8e4: 00
            brk                ; $e8e5: 00
            brk                ; $e8e6: 00
            brk                ; $e8e7: 00
            brk                ; $e8e8: 00
            brk                ; $e8e9: 00
__e8ea:     brk                ; $e8ea: 00
            brk                ; $e8eb: 00
            brk                ; $e8ec: 00
            brk                ; $e8ed: 00
            brk                ; $e8ee: 00
            brk                ; $e8ef: 00
            brk                ; $e8f0: 00
            brk                ; $e8f1: 00
            brk                ; $e8f2: 00
            brk                ; $e8f3: 00
            brk                ; $e8f4: 00
            brk                ; $e8f5: 00
            brk                ; $e8f6: 00
            brk                ; $e8f7: 00
            brk                ; $e8f8: 00
            brk                ; $e8f9: 00
            brk                ; $e8fa: 00
            brk                ; $e8fb: 00
            brk                ; $e8fc: 00
            brk                ; $e8fd: 00
            brk                ; $e8fe: 00
            brk                ; $e8ff: 00
            brk                ; $e900: 00
            brk                ; $e901: 00
            brk                ; $e902: 00
            brk                ; $e903: 00
            brk                ; $e904: 00
            brk                ; $e905: 00
            brk                ; $e906: 00
            brk                ; $e907: 00
            brk                ; $e908: 00
            brk                ; $e909: 00
            brk                ; $e90a: 00
            brk                ; $e90b: 00
            brk                ; $e90c: 00
            brk                ; $e90d: 00
            brk                ; $e90e: 00
            brk                ; $e90f: 00
            brk                ; $e910: 00
            brk                ; $e911: 00
            brk                ; $e912: 00
            brk                ; $e913: 00
            brk                ; $e914: 00
            brk                ; $e915: 00
            brk                ; $e916: 00
            brk                ; $e917: 00
            brk                ; $e918: 00
            brk                ; $e919: 00
            brk                ; $e91a: 00
            brk                ; $e91b: 00
            brk                ; $e91c: 00
            brk                ; $e91d: 00
            brk                ; $e91e: 00
            brk                ; $e91f: 00
            brk                ; $e920: 00
            brk                ; $e921: 00
            brk                ; $e922: 00
            brk                ; $e923: 00
            brk                ; $e924: 00
            brk                ; $e925: 00
            brk                ; $e926: 00
            brk                ; $e927: 00
            brk                ; $e928: 00
            brk                ; $e929: 00
            brk                ; $e92a: 00
            brk                ; $e92b: 00
            brk                ; $e92c: 00
            brk                ; $e92d: 00
            brk                ; $e92e: 00
            brk                ; $e92f: 00
            brk                ; $e930: 00
            brk                ; $e931: 00
            brk                ; $e932: 00
            brk                ; $e933: 00
            brk                ; $e934: 00
            brk                ; $e935: 00
            brk                ; $e936: 00
            brk                ; $e937: 00
            brk                ; $e938: 00
            brk                ; $e939: 00
            brk                ; $e93a: 00
            brk                ; $e93b: 00
            brk                ; $e93c: 00
            brk                ; $e93d: 00
            brk                ; $e93e: 00
            brk                ; $e93f: 00
            brk                ; $e940: 00
            brk                ; $e941: 00
            brk                ; $e942: 00
            brk                ; $e943: 00
            brk                ; $e944: 00
            brk                ; $e945: 00
            brk                ; $e946: 00
            brk                ; $e947: 00
            brk                ; $e948: 00
            brk                ; $e949: 00
            brk                ; $e94a: 00
            brk                ; $e94b: 00
            brk                ; $e94c: 00
            brk                ; $e94d: 00
            brk                ; $e94e: 00
            brk                ; $e94f: 00
            brk                ; $e950: 00
            brk                ; $e951: 00
            brk                ; $e952: 00
            brk                ; $e953: 00
            brk                ; $e954: 00
            brk                ; $e955: 00
            brk                ; $e956: 00
            brk                ; $e957: 00
            brk                ; $e958: 00
            brk                ; $e959: 00
            brk                ; $e95a: 00
            brk                ; $e95b: 00
            brk                ; $e95c: 00
            brk                ; $e95d: 00
            brk                ; $e95e: 00
            brk                ; $e95f: 00
            brk                ; $e960: 00
            brk                ; $e961: 00
            brk                ; $e962: 00
            brk                ; $e963: 00
            brk                ; $e964: 00
            brk                ; $e965: 00
            brk                ; $e966: 00
            brk                ; $e967: 00
            brk                ; $e968: 00
            brk                ; $e969: 00
            brk                ; $e96a: 00
            brk                ; $e96b: 00
            brk                ; $e96c: 00
            brk                ; $e96d: 00
            brk                ; $e96e: 00
            brk                ; $e96f: 00
            brk                ; $e970: 00
            brk                ; $e971: 00
            brk                ; $e972: 00
            brk                ; $e973: 00
            brk                ; $e974: 00
            brk                ; $e975: 00
            brk                ; $e976: 00
            brk                ; $e977: 00
            brk                ; $e978: 00
            brk                ; $e979: 00
            brk                ; $e97a: 00
            brk                ; $e97b: 00
            brk                ; $e97c: 00
            brk                ; $e97d: 00
            brk                ; $e97e: 00
            brk                ; $e97f: 00
            brk                ; $e980: 00
            brk                ; $e981: 00
            brk                ; $e982: 00
            brk                ; $e983: 00
            brk                ; $e984: 00
            brk                ; $e985: 00
            brk                ; $e986: 00
            brk                ; $e987: 00
            brk                ; $e988: 00
            brk                ; $e989: 00
            brk                ; $e98a: 00
            brk                ; $e98b: 00
            brk                ; $e98c: 00
            brk                ; $e98d: 00
            brk                ; $e98e: 00
            brk                ; $e98f: 00
            brk                ; $e990: 00
            brk                ; $e991: 00
            brk                ; $e992: 00
            brk                ; $e993: 00
            brk                ; $e994: 00
            brk                ; $e995: 00
            brk                ; $e996: 00
            brk                ; $e997: 00
            brk                ; $e998: 00
            brk                ; $e999: 00
            brk                ; $e99a: 00
            brk                ; $e99b: 00
            brk                ; $e99c: 00
            brk                ; $e99d: 00
            brk                ; $e99e: 00
            brk                ; $e99f: 00
            brk                ; $e9a0: 00
            brk                ; $e9a1: 00
            brk                ; $e9a2: 00
            brk                ; $e9a3: 00
            brk                ; $e9a4: 00
            brk                ; $e9a5: 00
            brk                ; $e9a6: 00
            brk                ; $e9a7: 00
            brk                ; $e9a8: 00
            brk                ; $e9a9: 00
            brk                ; $e9aa: 00
            brk                ; $e9ab: 00
            brk                ; $e9ac: 00
            brk                ; $e9ad: 00
            brk                ; $e9ae: 00
            brk                ; $e9af: 00
            brk                ; $e9b0: 00
            brk                ; $e9b1: 00
            brk                ; $e9b2: 00
            brk                ; $e9b3: 00
            brk                ; $e9b4: 00
            brk                ; $e9b5: 00
            brk                ; $e9b6: 00
            brk                ; $e9b7: 00
            brk                ; $e9b8: 00
            brk                ; $e9b9: 00
            brk                ; $e9ba: 00
            brk                ; $e9bb: 00
            brk                ; $e9bc: 00
            brk                ; $e9bd: 00
            brk                ; $e9be: 00
            brk                ; $e9bf: 00
            brk                ; $e9c0: 00
            brk                ; $e9c1: 00
            brk                ; $e9c2: 00
            brk                ; $e9c3: 00
            brk                ; $e9c4: 00
            brk                ; $e9c5: 00
            brk                ; $e9c6: 00
            brk                ; $e9c7: 00
            brk                ; $e9c8: 00
            brk                ; $e9c9: 00
            brk                ; $e9ca: 00
            brk                ; $e9cb: 00
            brk                ; $e9cc: 00
            brk                ; $e9cd: 00
            brk                ; $e9ce: 00
            brk                ; $e9cf: 00
            brk                ; $e9d0: 00
            brk                ; $e9d1: 00
            brk                ; $e9d2: 00
            brk                ; $e9d3: 00
            brk                ; $e9d4: 00
            brk                ; $e9d5: 00
            brk                ; $e9d6: 00
            brk                ; $e9d7: 00
            brk                ; $e9d8: 00
            brk                ; $e9d9: 00
            brk                ; $e9da: 00
            brk                ; $e9db: 00
            brk                ; $e9dc: 00
            brk                ; $e9dd: 00
            brk                ; $e9de: 00
            brk                ; $e9df: 00
            brk                ; $e9e0: 00
            brk                ; $e9e1: 00
            brk                ; $e9e2: 00
            brk                ; $e9e3: 00
            brk                ; $e9e4: 00
            brk                ; $e9e5: 00
            brk                ; $e9e6: 00
            brk                ; $e9e7: 00
            brk                ; $e9e8: 00
            brk                ; $e9e9: 00
            brk                ; $e9ea: 00
            brk                ; $e9eb: 00
            brk                ; $e9ec: 00
            brk                ; $e9ed: 00
            brk                ; $e9ee: 00
            brk                ; $e9ef: 00
            brk                ; $e9f0: 00
            brk                ; $e9f1: 00
            brk                ; $e9f2: 00
            brk                ; $e9f3: 00
            brk                ; $e9f4: 00
            brk                ; $e9f5: 00
            brk                ; $e9f6: 00
            brk                ; $e9f7: 00
            brk                ; $e9f8: 00
            brk                ; $e9f9: 00
            brk                ; $e9fa: 00
            brk                ; $e9fb: 00
            brk                ; $e9fc: 00
            brk                ; $e9fd: 00
            brk                ; $e9fe: 00
            brk                ; $e9ff: 00
            brk                ; $ea00: 00
            brk                ; $ea01: 00
            brk                ; $ea02: 00
            brk                ; $ea03: 00
            brk                ; $ea04: 00
            brk                ; $ea05: 00
            brk                ; $ea06: 00
            brk                ; $ea07: 00
            brk                ; $ea08: 00
            brk                ; $ea09: 00
            brk                ; $ea0a: 00
            brk                ; $ea0b: 00
            brk                ; $ea0c: 00
            brk                ; $ea0d: 00
            brk                ; $ea0e: 00
            brk                ; $ea0f: 00
            brk                ; $ea10: 00
            brk                ; $ea11: 00
            brk                ; $ea12: 00
            brk                ; $ea13: 00
            brk                ; $ea14: 00
            brk                ; $ea15: 00
            brk                ; $ea16: 00
            brk                ; $ea17: 00
            brk                ; $ea18: 00
            brk                ; $ea19: 00
            brk                ; $ea1a: 00
            brk                ; $ea1b: 00
            brk                ; $ea1c: 00
            brk                ; $ea1d: 00
            brk                ; $ea1e: 00
            brk                ; $ea1f: 00
            brk                ; $ea20: 00
            brk                ; $ea21: 00
            brk                ; $ea22: 00
            brk                ; $ea23: 00
            brk                ; $ea24: 00
            brk                ; $ea25: 00
            brk                ; $ea26: 00
            brk                ; $ea27: 00
            brk                ; $ea28: 00
            brk                ; $ea29: 00
            brk                ; $ea2a: 00
            brk                ; $ea2b: 00
            brk                ; $ea2c: 00
            brk                ; $ea2d: 00
            brk                ; $ea2e: 00
            brk                ; $ea2f: 00
            brk                ; $ea30: 00
            brk                ; $ea31: 00
            brk                ; $ea32: 00
            brk                ; $ea33: 00
            brk                ; $ea34: 00
            brk                ; $ea35: 00
            brk                ; $ea36: 00
            brk                ; $ea37: 00
            brk                ; $ea38: 00
            brk                ; $ea39: 00
            brk                ; $ea3a: 00
            brk                ; $ea3b: 00
            brk                ; $ea3c: 00
            brk                ; $ea3d: 00
            brk                ; $ea3e: 00
            brk                ; $ea3f: 00
            brk                ; $ea40: 00
            brk                ; $ea41: 00
            brk                ; $ea42: 00
            brk                ; $ea43: 00
            brk                ; $ea44: 00
            brk                ; $ea45: 00
            brk                ; $ea46: 00
            brk                ; $ea47: 00
            brk                ; $ea48: 00
            brk                ; $ea49: 00
            brk                ; $ea4a: 00
            brk                ; $ea4b: 00
            brk                ; $ea4c: 00
            brk                ; $ea4d: 00
            brk                ; $ea4e: 00
            brk                ; $ea4f: 00
            brk                ; $ea50: 00
            brk                ; $ea51: 00
            brk                ; $ea52: 00
            brk                ; $ea53: 00
            brk                ; $ea54: 00
            brk                ; $ea55: 00
            brk                ; $ea56: 00
            brk                ; $ea57: 00
            brk                ; $ea58: 00
            brk                ; $ea59: 00
            brk                ; $ea5a: 00
            brk                ; $ea5b: 00
            brk                ; $ea5c: 00
            brk                ; $ea5d: 00
            brk                ; $ea5e: 00
            brk                ; $ea5f: 00
            brk                ; $ea60: 00
            brk                ; $ea61: 00
            brk                ; $ea62: 00
            brk                ; $ea63: 00
            brk                ; $ea64: 00
            brk                ; $ea65: 00
            brk                ; $ea66: 00
            brk                ; $ea67: 00
            brk                ; $ea68: 00
            brk                ; $ea69: 00
            brk                ; $ea6a: 00
            brk                ; $ea6b: 00
            brk                ; $ea6c: 00
            brk                ; $ea6d: 00
            brk                ; $ea6e: 00
            brk                ; $ea6f: 00
            brk                ; $ea70: 00
            brk                ; $ea71: 00
            brk                ; $ea72: 00
            brk                ; $ea73: 00
            brk                ; $ea74: 00
            brk                ; $ea75: 00
            brk                ; $ea76: 00
            brk                ; $ea77: 00
            brk                ; $ea78: 00
            brk                ; $ea79: 00
            brk                ; $ea7a: 00
            brk                ; $ea7b: 00
            brk                ; $ea7c: 00
            brk                ; $ea7d: 00
            brk                ; $ea7e: 00
            brk                ; $ea7f: 00
            brk                ; $ea80: 00
            brk                ; $ea81: 00
            brk                ; $ea82: 00
            brk                ; $ea83: 00
            brk                ; $ea84: 00
            brk                ; $ea85: 00
            brk                ; $ea86: 00
            brk                ; $ea87: 00
            brk                ; $ea88: 00
            brk                ; $ea89: 00
            brk                ; $ea8a: 00
            brk                ; $ea8b: 00
            brk                ; $ea8c: 00
            brk                ; $ea8d: 00
            brk                ; $ea8e: 00
            brk                ; $ea8f: 00
            brk                ; $ea90: 00
            brk                ; $ea91: 00
            brk                ; $ea92: 00
            brk                ; $ea93: 00
            brk                ; $ea94: 00
            brk                ; $ea95: 00
            brk                ; $ea96: 00
            brk                ; $ea97: 00
            brk                ; $ea98: 00
            brk                ; $ea99: 00
            brk                ; $ea9a: 00
            brk                ; $ea9b: 00
            brk                ; $ea9c: 00
            brk                ; $ea9d: 00
            brk                ; $ea9e: 00
            brk                ; $ea9f: 00
            brk                ; $eaa0: 00
            brk                ; $eaa1: 00
            brk                ; $eaa2: 00
            brk                ; $eaa3: 00
            brk                ; $eaa4: 00
            brk                ; $eaa5: 00
            brk                ; $eaa6: 00
            brk                ; $eaa7: 00
            brk                ; $eaa8: 00
            brk                ; $eaa9: 00
            brk                ; $eaaa: 00
            brk                ; $eaab: 00
            brk                ; $eaac: 00
            brk                ; $eaad: 00
            brk                ; $eaae: 00
            brk                ; $eaaf: 00
            brk                ; $eab0: 00
            brk                ; $eab1: 00
            brk                ; $eab2: 00
            brk                ; $eab3: 00
            brk                ; $eab4: 00
            brk                ; $eab5: 00
            brk                ; $eab6: 00
            brk                ; $eab7: 00
            brk                ; $eab8: 00
            brk                ; $eab9: 00
            brk                ; $eaba: 00
            brk                ; $eabb: 00
            brk                ; $eabc: 00
            brk                ; $eabd: 00
            brk                ; $eabe: 00
            brk                ; $eabf: 00
            brk                ; $eac0: 00
            brk                ; $eac1: 00
            brk                ; $eac2: 00
            brk                ; $eac3: 00
            brk                ; $eac4: 00
            brk                ; $eac5: 00
            brk                ; $eac6: 00
            brk                ; $eac7: 00
            brk                ; $eac8: 00
            brk                ; $eac9: 00
            brk                ; $eaca: 00
            brk                ; $eacb: 00
            brk                ; $eacc: 00
            brk                ; $eacd: 00
            brk                ; $eace: 00
            brk                ; $eacf: 00
            brk                ; $ead0: 00
            brk                ; $ead1: 00
            brk                ; $ead2: 00
            brk                ; $ead3: 00
            brk                ; $ead4: 00
            brk                ; $ead5: 00
            brk                ; $ead6: 00
            brk                ; $ead7: 00
            brk                ; $ead8: 00
            brk                ; $ead9: 00
            brk                ; $eada: 00
            brk                ; $eadb: 00
            brk                ; $eadc: 00
            brk                ; $eadd: 00
            brk                ; $eade: 00
            brk                ; $eadf: 00
            brk                ; $eae0: 00
            brk                ; $eae1: 00
            brk                ; $eae2: 00
            brk                ; $eae3: 00
            brk                ; $eae4: 00
            brk                ; $eae5: 00
            brk                ; $eae6: 00
            brk                ; $eae7: 00
            brk                ; $eae8: 00
            brk                ; $eae9: 00
            brk                ; $eaea: 00
            brk                ; $eaeb: 00
            brk                ; $eaec: 00
            brk                ; $eaed: 00
            brk                ; $eaee: 00
            brk                ; $eaef: 00
            brk                ; $eaf0: 00
            brk                ; $eaf1: 00
            brk                ; $eaf2: 00
            brk                ; $eaf3: 00
            brk                ; $eaf4: 00
            brk                ; $eaf5: 00
            brk                ; $eaf6: 00
            brk                ; $eaf7: 00
            brk                ; $eaf8: 00
            brk                ; $eaf9: 00
            brk                ; $eafa: 00
            brk                ; $eafb: 00
            brk                ; $eafc: 00
            brk                ; $eafd: 00
            brk                ; $eafe: 00
            brk                ; $eaff: 00
            brk                ; $eb00: 00
            brk                ; $eb01: 00
            brk                ; $eb02: 00
            brk                ; $eb03: 00
            brk                ; $eb04: 00
            brk                ; $eb05: 00
            brk                ; $eb06: 00
            brk                ; $eb07: 00
            brk                ; $eb08: 00
            brk                ; $eb09: 00
            brk                ; $eb0a: 00
            brk                ; $eb0b: 00
            brk                ; $eb0c: 00
            brk                ; $eb0d: 00
            brk                ; $eb0e: 00
            brk                ; $eb0f: 00
            brk                ; $eb10: 00
            brk                ; $eb11: 00
            brk                ; $eb12: 00
            brk                ; $eb13: 00
            brk                ; $eb14: 00
            brk                ; $eb15: 00
            brk                ; $eb16: 00
            brk                ; $eb17: 00
            brk                ; $eb18: 00
            brk                ; $eb19: 00
            brk                ; $eb1a: 00
            brk                ; $eb1b: 00
            brk                ; $eb1c: 00
            brk                ; $eb1d: 00
            brk                ; $eb1e: 00
            brk                ; $eb1f: 00
            brk                ; $eb20: 00
            brk                ; $eb21: 00
            brk                ; $eb22: 00
            brk                ; $eb23: 00
            brk                ; $eb24: 00
            brk                ; $eb25: 00
            brk                ; $eb26: 00
            brk                ; $eb27: 00
            brk                ; $eb28: 00
            brk                ; $eb29: 00
            brk                ; $eb2a: 00
            brk                ; $eb2b: 00
            brk                ; $eb2c: 00
            brk                ; $eb2d: 00
            brk                ; $eb2e: 00
            brk                ; $eb2f: 00
            brk                ; $eb30: 00
            brk                ; $eb31: 00
            brk                ; $eb32: 00
            brk                ; $eb33: 00
            brk                ; $eb34: 00
            brk                ; $eb35: 00
            brk                ; $eb36: 00
            brk                ; $eb37: 00
            brk                ; $eb38: 00
            brk                ; $eb39: 00
            brk                ; $eb3a: 00
            brk                ; $eb3b: 00
            brk                ; $eb3c: 00
            brk                ; $eb3d: 00
            brk                ; $eb3e: 00
            brk                ; $eb3f: 00
            brk                ; $eb40: 00
            brk                ; $eb41: 00
            brk                ; $eb42: 00
            brk                ; $eb43: 00
            brk                ; $eb44: 00
            brk                ; $eb45: 00
            brk                ; $eb46: 00
            brk                ; $eb47: 00
            brk                ; $eb48: 00
            brk                ; $eb49: 00
            brk                ; $eb4a: 00
            brk                ; $eb4b: 00
            brk                ; $eb4c: 00
            brk                ; $eb4d: 00
            brk                ; $eb4e: 00
            brk                ; $eb4f: 00
            brk                ; $eb50: 00
            brk                ; $eb51: 00
            brk                ; $eb52: 00
            brk                ; $eb53: 00
            brk                ; $eb54: 00
            brk                ; $eb55: 00
            brk                ; $eb56: 00
            brk                ; $eb57: 00
            brk                ; $eb58: 00
            brk                ; $eb59: 00
            brk                ; $eb5a: 00
            brk                ; $eb5b: 00
            brk                ; $eb5c: 00
            brk                ; $eb5d: 00
            brk                ; $eb5e: 00
            brk                ; $eb5f: 00
            brk                ; $eb60: 00
            brk                ; $eb61: 00
            brk                ; $eb62: 00
            brk                ; $eb63: 00
            brk                ; $eb64: 00
            brk                ; $eb65: 00
            brk                ; $eb66: 00
            brk                ; $eb67: 00
            brk                ; $eb68: 00
            brk                ; $eb69: 00
            brk                ; $eb6a: 00
            brk                ; $eb6b: 00
            brk                ; $eb6c: 00
            brk                ; $eb6d: 00
            brk                ; $eb6e: 00
            brk                ; $eb6f: 00
            brk                ; $eb70: 00
            brk                ; $eb71: 00
            brk                ; $eb72: 00
            brk                ; $eb73: 00
            brk                ; $eb74: 00
            brk                ; $eb75: 00
            brk                ; $eb76: 00
            brk                ; $eb77: 00
            brk                ; $eb78: 00
            brk                ; $eb79: 00
            brk                ; $eb7a: 00
            brk                ; $eb7b: 00
            brk                ; $eb7c: 00
            brk                ; $eb7d: 00
            brk                ; $eb7e: 00
            brk                ; $eb7f: 00
            brk                ; $eb80: 00
            brk                ; $eb81: 00
            brk                ; $eb82: 00
            brk                ; $eb83: 00
            brk                ; $eb84: 00
            brk                ; $eb85: 00
            brk                ; $eb86: 00
            brk                ; $eb87: 00
            brk                ; $eb88: 00
            brk                ; $eb89: 00
            brk                ; $eb8a: 00
            brk                ; $eb8b: 00
            brk                ; $eb8c: 00
            brk                ; $eb8d: 00
            brk                ; $eb8e: 00
            brk                ; $eb8f: 00
            brk                ; $eb90: 00
            brk                ; $eb91: 00
            brk                ; $eb92: 00
            brk                ; $eb93: 00
            brk                ; $eb94: 00
            brk                ; $eb95: 00
            brk                ; $eb96: 00
            brk                ; $eb97: 00
            brk                ; $eb98: 00
            brk                ; $eb99: 00
            brk                ; $eb9a: 00
            brk                ; $eb9b: 00
            brk                ; $eb9c: 00
            brk                ; $eb9d: 00
            brk                ; $eb9e: 00
            brk                ; $eb9f: 00
            brk                ; $eba0: 00
            brk                ; $eba1: 00
            brk                ; $eba2: 00
            brk                ; $eba3: 00
            brk                ; $eba4: 00
            brk                ; $eba5: 00
            brk                ; $eba6: 00
            brk                ; $eba7: 00
            brk                ; $eba8: 00
            brk                ; $eba9: 00
            brk                ; $ebaa: 00
            brk                ; $ebab: 00
            brk                ; $ebac: 00
            brk                ; $ebad: 00
            brk                ; $ebae: 00
            brk                ; $ebaf: 00
            brk                ; $ebb0: 00
            brk                ; $ebb1: 00
            brk                ; $ebb2: 00
            brk                ; $ebb3: 00
            brk                ; $ebb4: 00
            brk                ; $ebb5: 00
            brk                ; $ebb6: 00
            brk                ; $ebb7: 00
            brk                ; $ebb8: 00
            brk                ; $ebb9: 00
            brk                ; $ebba: 00
            brk                ; $ebbb: 00
            brk                ; $ebbc: 00
            brk                ; $ebbd: 00
            brk                ; $ebbe: 00
            brk                ; $ebbf: 00
            brk                ; $ebc0: 00
            brk                ; $ebc1: 00
            brk                ; $ebc2: 00
            brk                ; $ebc3: 00
            brk                ; $ebc4: 00
            brk                ; $ebc5: 00
            brk                ; $ebc6: 00
            brk                ; $ebc7: 00
            brk                ; $ebc8: 00
            brk                ; $ebc9: 00
            brk                ; $ebca: 00
            brk                ; $ebcb: 00
            brk                ; $ebcc: 00
            brk                ; $ebcd: 00
            brk                ; $ebce: 00
            brk                ; $ebcf: 00
            brk                ; $ebd0: 00
            brk                ; $ebd1: 00
            brk                ; $ebd2: 00
            brk                ; $ebd3: 00
            brk                ; $ebd4: 00
            brk                ; $ebd5: 00
            brk                ; $ebd6: 00
            brk                ; $ebd7: 00
            brk                ; $ebd8: 00
            brk                ; $ebd9: 00
            brk                ; $ebda: 00
            brk                ; $ebdb: 00
            brk                ; $ebdc: 00
            brk                ; $ebdd: 00
            brk                ; $ebde: 00
            brk                ; $ebdf: 00
            brk                ; $ebe0: 00
            brk                ; $ebe1: 00
            brk                ; $ebe2: 00
            brk                ; $ebe3: 00
            brk                ; $ebe4: 00
            brk                ; $ebe5: 00
            brk                ; $ebe6: 00
            brk                ; $ebe7: 00
            brk                ; $ebe8: 00
            brk                ; $ebe9: 00
            brk                ; $ebea: 00
            brk                ; $ebeb: 00
            brk                ; $ebec: 00
            brk                ; $ebed: 00
            brk                ; $ebee: 00
            brk                ; $ebef: 00
            brk                ; $ebf0: 00
            brk                ; $ebf1: 00
            brk                ; $ebf2: 00
            brk                ; $ebf3: 00
            brk                ; $ebf4: 00
            brk                ; $ebf5: 00
            brk                ; $ebf6: 00
            brk                ; $ebf7: 00
            brk                ; $ebf8: 00
            brk                ; $ebf9: 00
            brk                ; $ebfa: 00
            brk                ; $ebfb: 00
            brk                ; $ebfc: 00
            brk                ; $ebfd: 00
            brk                ; $ebfe: 00
            brk                ; $ebff: 00
            brk                ; $ec00: 00
            brk                ; $ec01: 00
            brk                ; $ec02: 00
            brk                ; $ec03: 00
            brk                ; $ec04: 00
            brk                ; $ec05: 00
            brk                ; $ec06: 00
            brk                ; $ec07: 00
            brk                ; $ec08: 00
            brk                ; $ec09: 00
            brk                ; $ec0a: 00
            brk                ; $ec0b: 00
            brk                ; $ec0c: 00
            brk                ; $ec0d: 00
            brk                ; $ec0e: 00
            brk                ; $ec0f: 00
            brk                ; $ec10: 00
            brk                ; $ec11: 00
            brk                ; $ec12: 00
            brk                ; $ec13: 00
            brk                ; $ec14: 00
            brk                ; $ec15: 00
            brk                ; $ec16: 00
            brk                ; $ec17: 00
            brk                ; $ec18: 00
            brk                ; $ec19: 00
            brk                ; $ec1a: 00
            brk                ; $ec1b: 00
            brk                ; $ec1c: 00
            brk                ; $ec1d: 00
            brk                ; $ec1e: 00
            brk                ; $ec1f: 00
            brk                ; $ec20: 00
            brk                ; $ec21: 00
            brk                ; $ec22: 00
            brk                ; $ec23: 00
            brk                ; $ec24: 00
            brk                ; $ec25: 00
            brk                ; $ec26: 00
            brk                ; $ec27: 00
            brk                ; $ec28: 00
            brk                ; $ec29: 00
            brk                ; $ec2a: 00
            brk                ; $ec2b: 00
            brk                ; $ec2c: 00
            brk                ; $ec2d: 00
            brk                ; $ec2e: 00
            brk                ; $ec2f: 00
            brk                ; $ec30: 00
            brk                ; $ec31: 00
            brk                ; $ec32: 00
            brk                ; $ec33: 00
            brk                ; $ec34: 00
            brk                ; $ec35: 00
            brk                ; $ec36: 00
            brk                ; $ec37: 00
            brk                ; $ec38: 00
            brk                ; $ec39: 00
            brk                ; $ec3a: 00
            brk                ; $ec3b: 00
            brk                ; $ec3c: 00
            brk                ; $ec3d: 00
            brk                ; $ec3e: 00
            brk                ; $ec3f: 00
            brk                ; $ec40: 00
            brk                ; $ec41: 00
            brk                ; $ec42: 00
            brk                ; $ec43: 00
            brk                ; $ec44: 00
            brk                ; $ec45: 00
            brk                ; $ec46: 00
            brk                ; $ec47: 00
            brk                ; $ec48: 00
            brk                ; $ec49: 00
            brk                ; $ec4a: 00
            brk                ; $ec4b: 00
            brk                ; $ec4c: 00
            brk                ; $ec4d: 00
            brk                ; $ec4e: 00
            brk                ; $ec4f: 00
            brk                ; $ec50: 00
            brk                ; $ec51: 00
            brk                ; $ec52: 00
            brk                ; $ec53: 00
            brk                ; $ec54: 00
            brk                ; $ec55: 00
            brk                ; $ec56: 00
            brk                ; $ec57: 00
            brk                ; $ec58: 00
            brk                ; $ec59: 00
            brk                ; $ec5a: 00
            brk                ; $ec5b: 00
            brk                ; $ec5c: 00
            brk                ; $ec5d: 00
            brk                ; $ec5e: 00
            brk                ; $ec5f: 00
            brk                ; $ec60: 00
            brk                ; $ec61: 00
            brk                ; $ec62: 00
            brk                ; $ec63: 00
            brk                ; $ec64: 00
            brk                ; $ec65: 00
            brk                ; $ec66: 00
            brk                ; $ec67: 00
            brk                ; $ec68: 00
            brk                ; $ec69: 00
            brk                ; $ec6a: 00
            brk                ; $ec6b: 00
            brk                ; $ec6c: 00
            brk                ; $ec6d: 00
            brk                ; $ec6e: 00
            brk                ; $ec6f: 00
            brk                ; $ec70: 00
            brk                ; $ec71: 00
            brk                ; $ec72: 00
            brk                ; $ec73: 00
            brk                ; $ec74: 00
            brk                ; $ec75: 00
            brk                ; $ec76: 00
            brk                ; $ec77: 00
            brk                ; $ec78: 00
            brk                ; $ec79: 00
            brk                ; $ec7a: 00
            brk                ; $ec7b: 00
            brk                ; $ec7c: 00
            brk                ; $ec7d: 00
            brk                ; $ec7e: 00
            brk                ; $ec7f: 00
            brk                ; $ec80: 00
            brk                ; $ec81: 00
            brk                ; $ec82: 00
            brk                ; $ec83: 00
            brk                ; $ec84: 00
            brk                ; $ec85: 00
            brk                ; $ec86: 00
            brk                ; $ec87: 00
            brk                ; $ec88: 00
            brk                ; $ec89: 00
            brk                ; $ec8a: 00
            brk                ; $ec8b: 00
            brk                ; $ec8c: 00
            brk                ; $ec8d: 00
            brk                ; $ec8e: 00
            brk                ; $ec8f: 00
            brk                ; $ec90: 00
            brk                ; $ec91: 00
            brk                ; $ec92: 00
            brk                ; $ec93: 00
            brk                ; $ec94: 00
            brk                ; $ec95: 00
            brk                ; $ec96: 00
            brk                ; $ec97: 00
            brk                ; $ec98: 00
            brk                ; $ec99: 00
            brk                ; $ec9a: 00
            brk                ; $ec9b: 00
            brk                ; $ec9c: 00
            brk                ; $ec9d: 00
            brk                ; $ec9e: 00
            brk                ; $ec9f: 00
            brk                ; $eca0: 00
            brk                ; $eca1: 00
            brk                ; $eca2: 00
            brk                ; $eca3: 00
            brk                ; $eca4: 00
            brk                ; $eca5: 00
            brk                ; $eca6: 00
            brk                ; $eca7: 00
            brk                ; $eca8: 00
            brk                ; $eca9: 00
            brk                ; $ecaa: 00
            brk                ; $ecab: 00
            brk                ; $ecac: 00
            brk                ; $ecad: 00
            brk                ; $ecae: 00
            brk                ; $ecaf: 00
            brk                ; $ecb0: 00
            brk                ; $ecb1: 00
            brk                ; $ecb2: 00
            brk                ; $ecb3: 00
            brk                ; $ecb4: 00
            brk                ; $ecb5: 00
            brk                ; $ecb6: 00
            brk                ; $ecb7: 00
            brk                ; $ecb8: 00
            brk                ; $ecb9: 00
            brk                ; $ecba: 00
            brk                ; $ecbb: 00
            brk                ; $ecbc: 00
            brk                ; $ecbd: 00
            brk                ; $ecbe: 00
            brk                ; $ecbf: 00
            brk                ; $ecc0: 00
            brk                ; $ecc1: 00
            brk                ; $ecc2: 00
            brk                ; $ecc3: 00
            brk                ; $ecc4: 00
            brk                ; $ecc5: 00
            brk                ; $ecc6: 00
            brk                ; $ecc7: 00
            brk                ; $ecc8: 00
            brk                ; $ecc9: 00
            brk                ; $ecca: 00
            brk                ; $eccb: 00
            brk                ; $eccc: 00
            brk                ; $eccd: 00
            brk                ; $ecce: 00
            brk                ; $eccf: 00
            brk                ; $ecd0: 00
            brk                ; $ecd1: 00
            brk                ; $ecd2: 00
            brk                ; $ecd3: 00
            brk                ; $ecd4: 00
            brk                ; $ecd5: 00
            brk                ; $ecd6: 00
            brk                ; $ecd7: 00
            brk                ; $ecd8: 00
            brk                ; $ecd9: 00
            brk                ; $ecda: 00
            brk                ; $ecdb: 00
            brk                ; $ecdc: 00
            brk                ; $ecdd: 00
            brk                ; $ecde: 00
            brk                ; $ecdf: 00
            brk                ; $ece0: 00
            brk                ; $ece1: 00
            brk                ; $ece2: 00
            brk                ; $ece3: 00
            brk                ; $ece4: 00
            brk                ; $ece5: 00
            brk                ; $ece6: 00
            brk                ; $ece7: 00
            brk                ; $ece8: 00
            brk                ; $ece9: 00
            brk                ; $ecea: 00
            brk                ; $eceb: 00
            brk                ; $ecec: 00
            brk                ; $eced: 00
            brk                ; $ecee: 00
            brk                ; $ecef: 00
            brk                ; $ecf0: 00
            brk                ; $ecf1: 00
            brk                ; $ecf2: 00
            brk                ; $ecf3: 00
            brk                ; $ecf4: 00
            brk                ; $ecf5: 00
            brk                ; $ecf6: 00
            brk                ; $ecf7: 00
            brk                ; $ecf8: 00
            brk                ; $ecf9: 00
            brk                ; $ecfa: 00
            brk                ; $ecfb: 00
            brk                ; $ecfc: 00
            brk                ; $ecfd: 00
            brk                ; $ecfe: 00
            brk                ; $ecff: 00
            brk                ; $ed00: 00
            brk                ; $ed01: 00
            brk                ; $ed02: 00
            brk                ; $ed03: 00
            brk                ; $ed04: 00
            brk                ; $ed05: 00
            brk                ; $ed06: 00
            brk                ; $ed07: 00
            brk                ; $ed08: 00
            brk                ; $ed09: 00
            brk                ; $ed0a: 00
            brk                ; $ed0b: 00
            brk                ; $ed0c: 00
            brk                ; $ed0d: 00
            brk                ; $ed0e: 00
            brk                ; $ed0f: 00
            brk                ; $ed10: 00
            brk                ; $ed11: 00
            brk                ; $ed12: 00
            brk                ; $ed13: 00
            brk                ; $ed14: 00
            brk                ; $ed15: 00
            brk                ; $ed16: 00
            brk                ; $ed17: 00
            brk                ; $ed18: 00
            brk                ; $ed19: 00
            brk                ; $ed1a: 00
            brk                ; $ed1b: 00
            brk                ; $ed1c: 00
            brk                ; $ed1d: 00
            brk                ; $ed1e: 00
            brk                ; $ed1f: 00
            brk                ; $ed20: 00
            brk                ; $ed21: 00
            brk                ; $ed22: 00
            brk                ; $ed23: 00
            brk                ; $ed24: 00
            brk                ; $ed25: 00
            brk                ; $ed26: 00
            brk                ; $ed27: 00
            brk                ; $ed28: 00
            brk                ; $ed29: 00
            brk                ; $ed2a: 00
            brk                ; $ed2b: 00
            brk                ; $ed2c: 00
            brk                ; $ed2d: 00
            brk                ; $ed2e: 00
            brk                ; $ed2f: 00
            brk                ; $ed30: 00
            brk                ; $ed31: 00
            brk                ; $ed32: 00
            brk                ; $ed33: 00
            brk                ; $ed34: 00
            brk                ; $ed35: 00
            brk                ; $ed36: 00
            brk                ; $ed37: 00
            brk                ; $ed38: 00
            brk                ; $ed39: 00
            brk                ; $ed3a: 00
            brk                ; $ed3b: 00
            brk                ; $ed3c: 00
            brk                ; $ed3d: 00
            brk                ; $ed3e: 00
            brk                ; $ed3f: 00
            brk                ; $ed40: 00
            brk                ; $ed41: 00
            brk                ; $ed42: 00
            brk                ; $ed43: 00
            brk                ; $ed44: 00
            brk                ; $ed45: 00
            brk                ; $ed46: 00
            brk                ; $ed47: 00
            brk                ; $ed48: 00
            brk                ; $ed49: 00
            brk                ; $ed4a: 00
            brk                ; $ed4b: 00
            brk                ; $ed4c: 00
            brk                ; $ed4d: 00
            brk                ; $ed4e: 00
            brk                ; $ed4f: 00
            brk                ; $ed50: 00
            brk                ; $ed51: 00
            brk                ; $ed52: 00
            brk                ; $ed53: 00
            brk                ; $ed54: 00
            brk                ; $ed55: 00
            brk                ; $ed56: 00
            brk                ; $ed57: 00
            brk                ; $ed58: 00
            brk                ; $ed59: 00
            brk                ; $ed5a: 00
            brk                ; $ed5b: 00
            brk                ; $ed5c: 00
            brk                ; $ed5d: 00
            brk                ; $ed5e: 00
            brk                ; $ed5f: 00
            brk                ; $ed60: 00
            brk                ; $ed61: 00
            brk                ; $ed62: 00
            brk                ; $ed63: 00
            brk                ; $ed64: 00
            brk                ; $ed65: 00
            brk                ; $ed66: 00
            brk                ; $ed67: 00
            brk                ; $ed68: 00
            brk                ; $ed69: 00
            brk                ; $ed6a: 00
            brk                ; $ed6b: 00
            brk                ; $ed6c: 00
            brk                ; $ed6d: 00
            brk                ; $ed6e: 00
            brk                ; $ed6f: 00
            brk                ; $ed70: 00
            brk                ; $ed71: 00
            brk                ; $ed72: 00
            brk                ; $ed73: 00
            brk                ; $ed74: 00
            brk                ; $ed75: 00
            brk                ; $ed76: 00
            brk                ; $ed77: 00
            brk                ; $ed78: 00
            brk                ; $ed79: 00
            brk                ; $ed7a: 00
            brk                ; $ed7b: 00
            brk                ; $ed7c: 00
            brk                ; $ed7d: 00
            brk                ; $ed7e: 00
            brk                ; $ed7f: 00
            brk                ; $ed80: 00
            brk                ; $ed81: 00
            brk                ; $ed82: 00
            brk                ; $ed83: 00
            brk                ; $ed84: 00
            brk                ; $ed85: 00
            brk                ; $ed86: 00
            brk                ; $ed87: 00
            brk                ; $ed88: 00
            brk                ; $ed89: 00
            brk                ; $ed8a: 00
            brk                ; $ed8b: 00
            brk                ; $ed8c: 00
            brk                ; $ed8d: 00
            brk                ; $ed8e: 00
            brk                ; $ed8f: 00
            brk                ; $ed90: 00
            brk                ; $ed91: 00
            brk                ; $ed92: 00
            brk                ; $ed93: 00
            brk                ; $ed94: 00
            brk                ; $ed95: 00
            brk                ; $ed96: 00
            brk                ; $ed97: 00
            brk                ; $ed98: 00
            brk                ; $ed99: 00
            brk                ; $ed9a: 00
            brk                ; $ed9b: 00
            brk                ; $ed9c: 00
            brk                ; $ed9d: 00
            brk                ; $ed9e: 00
            brk                ; $ed9f: 00
            brk                ; $eda0: 00
            brk                ; $eda1: 00
            brk                ; $eda2: 00
            brk                ; $eda3: 00
            brk                ; $eda4: 00
            brk                ; $eda5: 00
            brk                ; $eda6: 00
            brk                ; $eda7: 00
            brk                ; $eda8: 00
            brk                ; $eda9: 00
            brk                ; $edaa: 00
            brk                ; $edab: 00
            brk                ; $edac: 00
            brk                ; $edad: 00
            brk                ; $edae: 00
            brk                ; $edaf: 00
            brk                ; $edb0: 00
            brk                ; $edb1: 00
            brk                ; $edb2: 00
            brk                ; $edb3: 00
            brk                ; $edb4: 00
            brk                ; $edb5: 00
            brk                ; $edb6: 00
            brk                ; $edb7: 00
            brk                ; $edb8: 00
            brk                ; $edb9: 00
            brk                ; $edba: 00
            brk                ; $edbb: 00
            brk                ; $edbc: 00
            brk                ; $edbd: 00
            brk                ; $edbe: 00
            brk                ; $edbf: 00
            brk                ; $edc0: 00
            brk                ; $edc1: 00
            brk                ; $edc2: 00
            brk                ; $edc3: 00
            brk                ; $edc4: 00
            brk                ; $edc5: 00
            brk                ; $edc6: 00
            brk                ; $edc7: 00
            brk                ; $edc8: 00
            brk                ; $edc9: 00
            brk                ; $edca: 00
            brk                ; $edcb: 00
            brk                ; $edcc: 00
            brk                ; $edcd: 00
            brk                ; $edce: 00
            brk                ; $edcf: 00
            brk                ; $edd0: 00
            brk                ; $edd1: 00
            brk                ; $edd2: 00
            brk                ; $edd3: 00
            brk                ; $edd4: 00
            brk                ; $edd5: 00
            brk                ; $edd6: 00
            brk                ; $edd7: 00
            brk                ; $edd8: 00
            brk                ; $edd9: 00
            brk                ; $edda: 00
            brk                ; $eddb: 00
            brk                ; $eddc: 00
            brk                ; $eddd: 00
            brk                ; $edde: 00
            brk                ; $eddf: 00
            brk                ; $ede0: 00
            brk                ; $ede1: 00
            brk                ; $ede2: 00
            brk                ; $ede3: 00
            brk                ; $ede4: 00
            brk                ; $ede5: 00
            brk                ; $ede6: 00
            brk                ; $ede7: 00
            brk                ; $ede8: 00
            brk                ; $ede9: 00
            brk                ; $edea: 00
            brk                ; $edeb: 00
            brk                ; $edec: 00
            brk                ; $eded: 00
            brk                ; $edee: 00
            brk                ; $edef: 00
            brk                ; $edf0: 00
            brk                ; $edf1: 00
            brk                ; $edf2: 00
            brk                ; $edf3: 00
            brk                ; $edf4: 00
            brk                ; $edf5: 00
            brk                ; $edf6: 00
            brk                ; $edf7: 00
            brk                ; $edf8: 00
            brk                ; $edf9: 00
            brk                ; $edfa: 00
            brk                ; $edfb: 00
            brk                ; $edfc: 00
            brk                ; $edfd: 00
            brk                ; $edfe: 00
            brk                ; $edff: 00
            brk                ; $ee00: 00
            brk                ; $ee01: 00
            brk                ; $ee02: 00
            brk                ; $ee03: 00
            brk                ; $ee04: 00
            brk                ; $ee05: 00
            brk                ; $ee06: 00
            brk                ; $ee07: 00
            brk                ; $ee08: 00
            brk                ; $ee09: 00
            brk                ; $ee0a: 00
            brk                ; $ee0b: 00
            brk                ; $ee0c: 00
            brk                ; $ee0d: 00
            brk                ; $ee0e: 00
            brk                ; $ee0f: 00
            brk                ; $ee10: 00
            brk                ; $ee11: 00
            brk                ; $ee12: 00
            brk                ; $ee13: 00
__ee14:     brk                ; $ee14: 00
            brk                ; $ee15: 00
            brk                ; $ee16: 00
            brk                ; $ee17: 00
            brk                ; $ee18: 00
            brk                ; $ee19: 00
            brk                ; $ee1a: 00
            brk                ; $ee1b: 00
            brk                ; $ee1c: 00
            brk                ; $ee1d: 00
            brk                ; $ee1e: 00
            brk                ; $ee1f: 00
            brk                ; $ee20: 00
            brk                ; $ee21: 00
            brk                ; $ee22: 00
            brk                ; $ee23: 00
            brk                ; $ee24: 00
            brk                ; $ee25: 00
            brk                ; $ee26: 00
            brk                ; $ee27: 00
            brk                ; $ee28: 00
            brk                ; $ee29: 00
            brk                ; $ee2a: 00
            brk                ; $ee2b: 00
            brk                ; $ee2c: 00
            brk                ; $ee2d: 00
            brk                ; $ee2e: 00
            brk                ; $ee2f: 00
            brk                ; $ee30: 00
            brk                ; $ee31: 00
            brk                ; $ee32: 00
            brk                ; $ee33: 00
            brk                ; $ee34: 00
            brk                ; $ee35: 00
            brk                ; $ee36: 00
            brk                ; $ee37: 00
            brk                ; $ee38: 00
            brk                ; $ee39: 00
            brk                ; $ee3a: 00
            brk                ; $ee3b: 00
            brk                ; $ee3c: 00
            brk                ; $ee3d: 00
            brk                ; $ee3e: 00
            brk                ; $ee3f: 00
            brk                ; $ee40: 00
            brk                ; $ee41: 00
            brk                ; $ee42: 00
            brk                ; $ee43: 00
            brk                ; $ee44: 00
            brk                ; $ee45: 00
            brk                ; $ee46: 00
            brk                ; $ee47: 00
            brk                ; $ee48: 00
            brk                ; $ee49: 00
            brk                ; $ee4a: 00
            brk                ; $ee4b: 00
            brk                ; $ee4c: 00
            brk                ; $ee4d: 00
            brk                ; $ee4e: 00
            brk                ; $ee4f: 00
            brk                ; $ee50: 00
            brk                ; $ee51: 00
            brk                ; $ee52: 00
            brk                ; $ee53: 00
            brk                ; $ee54: 00
            brk                ; $ee55: 00
            brk                ; $ee56: 00
            brk                ; $ee57: 00
            brk                ; $ee58: 00
            brk                ; $ee59: 00
            brk                ; $ee5a: 00
            brk                ; $ee5b: 00
            brk                ; $ee5c: 00
            brk                ; $ee5d: 00
            brk                ; $ee5e: 00
            brk                ; $ee5f: 00
            brk                ; $ee60: 00
            brk                ; $ee61: 00
            brk                ; $ee62: 00
            brk                ; $ee63: 00
            brk                ; $ee64: 00
            brk                ; $ee65: 00
            brk                ; $ee66: 00
            brk                ; $ee67: 00
            brk                ; $ee68: 00
            brk                ; $ee69: 00
            brk                ; $ee6a: 00
            brk                ; $ee6b: 00
            brk                ; $ee6c: 00
            brk                ; $ee6d: 00
            brk                ; $ee6e: 00
            brk                ; $ee6f: 00
            brk                ; $ee70: 00
            brk                ; $ee71: 00
            brk                ; $ee72: 00
            brk                ; $ee73: 00
            brk                ; $ee74: 00
            brk                ; $ee75: 00
            brk                ; $ee76: 00
            brk                ; $ee77: 00
            brk                ; $ee78: 00
            brk                ; $ee79: 00
            brk                ; $ee7a: 00
            brk                ; $ee7b: 00
            brk                ; $ee7c: 00
            brk                ; $ee7d: 00
            brk                ; $ee7e: 00
            brk                ; $ee7f: 00
            brk                ; $ee80: 00
            brk                ; $ee81: 00
            brk                ; $ee82: 00
            brk                ; $ee83: 00
            brk                ; $ee84: 00
            brk                ; $ee85: 00
            brk                ; $ee86: 00
            brk                ; $ee87: 00
            brk                ; $ee88: 00
            brk                ; $ee89: 00
            brk                ; $ee8a: 00
            brk                ; $ee8b: 00
            brk                ; $ee8c: 00
            brk                ; $ee8d: 00
            brk                ; $ee8e: 00
            brk                ; $ee8f: 00
            brk                ; $ee90: 00
            brk                ; $ee91: 00
            brk                ; $ee92: 00
            brk                ; $ee93: 00
            brk                ; $ee94: 00
            brk                ; $ee95: 00
            brk                ; $ee96: 00
            brk                ; $ee97: 00
            brk                ; $ee98: 00
            brk                ; $ee99: 00
            brk                ; $ee9a: 00
            brk                ; $ee9b: 00
            brk                ; $ee9c: 00
            brk                ; $ee9d: 00
            brk                ; $ee9e: 00
            brk                ; $ee9f: 00
            brk                ; $eea0: 00
            brk                ; $eea1: 00
            brk                ; $eea2: 00
            brk                ; $eea3: 00
            brk                ; $eea4: 00
            brk                ; $eea5: 00
            brk                ; $eea6: 00
            brk                ; $eea7: 00
            brk                ; $eea8: 00
            brk                ; $eea9: 00
            brk                ; $eeaa: 00
            brk                ; $eeab: 00
            brk                ; $eeac: 00
            brk                ; $eead: 00
            brk                ; $eeae: 00
            brk                ; $eeaf: 00
            brk                ; $eeb0: 00
            brk                ; $eeb1: 00
            brk                ; $eeb2: 00
            brk                ; $eeb3: 00
            brk                ; $eeb4: 00
            brk                ; $eeb5: 00
            brk                ; $eeb6: 00
            brk                ; $eeb7: 00
            brk                ; $eeb8: 00
            brk                ; $eeb9: 00
            brk                ; $eeba: 00
            brk                ; $eebb: 00
            brk                ; $eebc: 00
            brk                ; $eebd: 00
            brk                ; $eebe: 00
            brk                ; $eebf: 00
            brk                ; $eec0: 00
            brk                ; $eec1: 00
            brk                ; $eec2: 00
            brk                ; $eec3: 00
            brk                ; $eec4: 00
            brk                ; $eec5: 00
            brk                ; $eec6: 00
            brk                ; $eec7: 00
            brk                ; $eec8: 00
            brk                ; $eec9: 00
            brk                ; $eeca: 00
            brk                ; $eecb: 00
            brk                ; $eecc: 00
            brk                ; $eecd: 00
            brk                ; $eece: 00
            brk                ; $eecf: 00
            brk                ; $eed0: 00
            brk                ; $eed1: 00
            brk                ; $eed2: 00
            brk                ; $eed3: 00
            brk                ; $eed4: 00
            brk                ; $eed5: 00
            brk                ; $eed6: 00
            brk                ; $eed7: 00
            brk                ; $eed8: 00
            brk                ; $eed9: 00
            brk                ; $eeda: 00
            brk                ; $eedb: 00
            brk                ; $eedc: 00
            brk                ; $eedd: 00
            brk                ; $eede: 00
            brk                ; $eedf: 00
            brk                ; $eee0: 00
            brk                ; $eee1: 00
            brk                ; $eee2: 00
            brk                ; $eee3: 00
            brk                ; $eee4: 00
            brk                ; $eee5: 00
            brk                ; $eee6: 00
            brk                ; $eee7: 00
            brk                ; $eee8: 00
            brk                ; $eee9: 00
            brk                ; $eeea: 00
            brk                ; $eeeb: 00
            brk                ; $eeec: 00
            brk                ; $eeed: 00
            brk                ; $eeee: 00
            brk                ; $eeef: 00
            brk                ; $eef0: 00
            brk                ; $eef1: 00
            brk                ; $eef2: 00
            brk                ; $eef3: 00
            brk                ; $eef4: 00
            brk                ; $eef5: 00
            brk                ; $eef6: 00
            brk                ; $eef7: 00
            brk                ; $eef8: 00
            brk                ; $eef9: 00
            brk                ; $eefa: 00
            brk                ; $eefb: 00
            brk                ; $eefc: 00
            brk                ; $eefd: 00
            brk                ; $eefe: 00
            brk                ; $eeff: 00
            brk                ; $ef00: 00
            brk                ; $ef01: 00
            brk                ; $ef02: 00
            brk                ; $ef03: 00
            brk                ; $ef04: 00
            brk                ; $ef05: 00
            brk                ; $ef06: 00
            brk                ; $ef07: 00
            brk                ; $ef08: 00
            brk                ; $ef09: 00
            brk                ; $ef0a: 00
            brk                ; $ef0b: 00
            brk                ; $ef0c: 00
            brk                ; $ef0d: 00
            brk                ; $ef0e: 00
            brk                ; $ef0f: 00
            brk                ; $ef10: 00
            brk                ; $ef11: 00
            brk                ; $ef12: 00
            brk                ; $ef13: 00
            brk                ; $ef14: 00
            brk                ; $ef15: 00
            brk                ; $ef16: 00
            brk                ; $ef17: 00
            brk                ; $ef18: 00
            brk                ; $ef19: 00
            brk                ; $ef1a: 00
            brk                ; $ef1b: 00
            brk                ; $ef1c: 00
            brk                ; $ef1d: 00
            brk                ; $ef1e: 00
            brk                ; $ef1f: 00
            brk                ; $ef20: 00
            brk                ; $ef21: 00
            brk                ; $ef22: 00
            brk                ; $ef23: 00
            brk                ; $ef24: 00
            brk                ; $ef25: 00
            brk                ; $ef26: 00
            brk                ; $ef27: 00
            brk                ; $ef28: 00
            brk                ; $ef29: 00
            brk                ; $ef2a: 00
            brk                ; $ef2b: 00
            brk                ; $ef2c: 00
            brk                ; $ef2d: 00
            brk                ; $ef2e: 00
            brk                ; $ef2f: 00
            brk                ; $ef30: 00
            brk                ; $ef31: 00
            brk                ; $ef32: 00
            brk                ; $ef33: 00
            brk                ; $ef34: 00
            brk                ; $ef35: 00
            brk                ; $ef36: 00
            brk                ; $ef37: 00
            brk                ; $ef38: 00
            brk                ; $ef39: 00
            brk                ; $ef3a: 00
            brk                ; $ef3b: 00
            brk                ; $ef3c: 00
            brk                ; $ef3d: 00
            brk                ; $ef3e: 00
            brk                ; $ef3f: 00
            brk                ; $ef40: 00
            brk                ; $ef41: 00
            brk                ; $ef42: 00
            brk                ; $ef43: 00
            brk                ; $ef44: 00
            brk                ; $ef45: 00
            brk                ; $ef46: 00
            brk                ; $ef47: 00
            brk                ; $ef48: 00
            brk                ; $ef49: 00
            brk                ; $ef4a: 00
            brk                ; $ef4b: 00
            brk                ; $ef4c: 00
            brk                ; $ef4d: 00
            brk                ; $ef4e: 00
            brk                ; $ef4f: 00
            brk                ; $ef50: 00
            brk                ; $ef51: 00
            brk                ; $ef52: 00
            brk                ; $ef53: 00
            brk                ; $ef54: 00
            brk                ; $ef55: 00
            brk                ; $ef56: 00
            brk                ; $ef57: 00
            brk                ; $ef58: 00
            brk                ; $ef59: 00
            brk                ; $ef5a: 00
            brk                ; $ef5b: 00
            brk                ; $ef5c: 00
            brk                ; $ef5d: 00
            brk                ; $ef5e: 00
            brk                ; $ef5f: 00
            brk                ; $ef60: 00
            brk                ; $ef61: 00
            brk                ; $ef62: 00
            brk                ; $ef63: 00
            brk                ; $ef64: 00
            brk                ; $ef65: 00
            brk                ; $ef66: 00
            brk                ; $ef67: 00
            brk                ; $ef68: 00
            brk                ; $ef69: 00
            brk                ; $ef6a: 00
            brk                ; $ef6b: 00
            brk                ; $ef6c: 00
            brk                ; $ef6d: 00
            brk                ; $ef6e: 00
            brk                ; $ef6f: 00
            brk                ; $ef70: 00
            brk                ; $ef71: 00
            brk                ; $ef72: 00
            brk                ; $ef73: 00
            brk                ; $ef74: 00
            brk                ; $ef75: 00
            brk                ; $ef76: 00
            brk                ; $ef77: 00
            brk                ; $ef78: 00
            brk                ; $ef79: 00
            brk                ; $ef7a: 00
            brk                ; $ef7b: 00
            brk                ; $ef7c: 00
            brk                ; $ef7d: 00
            brk                ; $ef7e: 00
            brk                ; $ef7f: 00
            brk                ; $ef80: 00
            brk                ; $ef81: 00
            brk                ; $ef82: 00
            brk                ; $ef83: 00
            brk                ; $ef84: 00
            brk                ; $ef85: 00
            brk                ; $ef86: 00
            brk                ; $ef87: 00
            brk                ; $ef88: 00
            brk                ; $ef89: 00
            brk                ; $ef8a: 00
            brk                ; $ef8b: 00
            brk                ; $ef8c: 00
            brk                ; $ef8d: 00
            brk                ; $ef8e: 00
            brk                ; $ef8f: 00
            brk                ; $ef90: 00
            brk                ; $ef91: 00
            brk                ; $ef92: 00
            brk                ; $ef93: 00
            brk                ; $ef94: 00
            brk                ; $ef95: 00
            brk                ; $ef96: 00
            brk                ; $ef97: 00
            brk                ; $ef98: 00
            brk                ; $ef99: 00
            brk                ; $ef9a: 00
            brk                ; $ef9b: 00
            brk                ; $ef9c: 00
            brk                ; $ef9d: 00
            brk                ; $ef9e: 00
            brk                ; $ef9f: 00
            brk                ; $efa0: 00
            brk                ; $efa1: 00
            brk                ; $efa2: 00
            brk                ; $efa3: 00
            brk                ; $efa4: 00
            brk                ; $efa5: 00
            brk                ; $efa6: 00
            brk                ; $efa7: 00
            brk                ; $efa8: 00
            brk                ; $efa9: 00
            brk                ; $efaa: 00
            brk                ; $efab: 00
            brk                ; $efac: 00
            brk                ; $efad: 00
            brk                ; $efae: 00
            brk                ; $efaf: 00
            brk                ; $efb0: 00
            brk                ; $efb1: 00
            brk                ; $efb2: 00
            brk                ; $efb3: 00
            brk                ; $efb4: 00
            brk                ; $efb5: 00
            brk                ; $efb6: 00
            brk                ; $efb7: 00
            brk                ; $efb8: 00
            brk                ; $efb9: 00
            brk                ; $efba: 00
            brk                ; $efbb: 00
            brk                ; $efbc: 00
            brk                ; $efbd: 00
            brk                ; $efbe: 00
            brk                ; $efbf: 00
            brk                ; $efc0: 00
            brk                ; $efc1: 00
            brk                ; $efc2: 00
            brk                ; $efc3: 00
            brk                ; $efc4: 00
            brk                ; $efc5: 00
            brk                ; $efc6: 00
            brk                ; $efc7: 00
            brk                ; $efc8: 00
            brk                ; $efc9: 00
            brk                ; $efca: 00
            brk                ; $efcb: 00
            brk                ; $efcc: 00
            brk                ; $efcd: 00
            brk                ; $efce: 00
            brk                ; $efcf: 00
            brk                ; $efd0: 00
            brk                ; $efd1: 00
            brk                ; $efd2: 00
            brk                ; $efd3: 00
            brk                ; $efd4: 00
            brk                ; $efd5: 00
            brk                ; $efd6: 00
            brk                ; $efd7: 00
            brk                ; $efd8: 00
            brk                ; $efd9: 00
            brk                ; $efda: 00
            brk                ; $efdb: 00
            brk                ; $efdc: 00
            brk                ; $efdd: 00
            brk                ; $efde: 00
            brk                ; $efdf: 00
            brk                ; $efe0: 00
            brk                ; $efe1: 00
            brk                ; $efe2: 00
            brk                ; $efe3: 00
            brk                ; $efe4: 00
            brk                ; $efe5: 00
            brk                ; $efe6: 00
            brk                ; $efe7: 00
            brk                ; $efe8: 00
            brk                ; $efe9: 00
            brk                ; $efea: 00
            brk                ; $efeb: 00
            brk                ; $efec: 00
            brk                ; $efed: 00
            brk                ; $efee: 00
            brk                ; $efef: 00
            brk                ; $eff0: 00
            brk                ; $eff1: 00
            brk                ; $eff2: 00
            brk                ; $eff3: 00
            brk                ; $eff4: 00
            brk                ; $eff5: 00
            brk                ; $eff6: 00
            brk                ; $eff7: 00
            brk                ; $eff8: 00
            brk                ; $eff9: 00
            brk                ; $effa: 00
            brk                ; $effb: 00
            brk                ; $effc: 00
            brk                ; $effd: 00
            brk                ; $effe: 00
            brk                ; $efff: 00
            brk                ; $f000: 00
            brk                ; $f001: 00
            brk                ; $f002: 00
            brk                ; $f003: 00
            brk                ; $f004: 00
            brk                ; $f005: 00
            brk                ; $f006: 00
            brk                ; $f007: 00
            brk                ; $f008: 00
            brk                ; $f009: 00
            brk                ; $f00a: 00
            brk                ; $f00b: 00
            brk                ; $f00c: 00
            brk                ; $f00d: 00
            brk                ; $f00e: 00
            brk                ; $f00f: 00
            brk                ; $f010: 00
            brk                ; $f011: 00
            brk                ; $f012: 00
            brk                ; $f013: 00
            brk                ; $f014: 00
            brk                ; $f015: 00
            brk                ; $f016: 00
            brk                ; $f017: 00
            brk                ; $f018: 00
            brk                ; $f019: 00
            brk                ; $f01a: 00
            brk                ; $f01b: 00
            brk                ; $f01c: 00
            brk                ; $f01d: 00
            brk                ; $f01e: 00
            brk                ; $f01f: 00
            brk                ; $f020: 00
            brk                ; $f021: 00
            brk                ; $f022: 00
            brk                ; $f023: 00
            brk                ; $f024: 00
            brk                ; $f025: 00
            brk                ; $f026: 00
            brk                ; $f027: 00
            brk                ; $f028: 00
            brk                ; $f029: 00
            brk                ; $f02a: 00
            brk                ; $f02b: 00
            brk                ; $f02c: 00
            brk                ; $f02d: 00
            brk                ; $f02e: 00
            brk                ; $f02f: 00
            brk                ; $f030: 00
            brk                ; $f031: 00
            brk                ; $f032: 00
            brk                ; $f033: 00
            brk                ; $f034: 00
            brk                ; $f035: 00
            brk                ; $f036: 00
            brk                ; $f037: 00
            brk                ; $f038: 00
            brk                ; $f039: 00
            brk                ; $f03a: 00
            brk                ; $f03b: 00
            brk                ; $f03c: 00
            brk                ; $f03d: 00
            brk                ; $f03e: 00
            brk                ; $f03f: 00
            brk                ; $f040: 00
            brk                ; $f041: 00
            brk                ; $f042: 00
            brk                ; $f043: 00
            brk                ; $f044: 00
            brk                ; $f045: 00
            brk                ; $f046: 00
            brk                ; $f047: 00
            brk                ; $f048: 00
            brk                ; $f049: 00
            brk                ; $f04a: 00
            brk                ; $f04b: 00
            brk                ; $f04c: 00
            brk                ; $f04d: 00
            brk                ; $f04e: 00
            brk                ; $f04f: 00
            brk                ; $f050: 00
            brk                ; $f051: 00
            brk                ; $f052: 00
            brk                ; $f053: 00
            brk                ; $f054: 00
            brk                ; $f055: 00
            brk                ; $f056: 00
            brk                ; $f057: 00
            brk                ; $f058: 00
            brk                ; $f059: 00
            brk                ; $f05a: 00
            brk                ; $f05b: 00
            brk                ; $f05c: 00
            brk                ; $f05d: 00
            brk                ; $f05e: 00
            brk                ; $f05f: 00
            brk                ; $f060: 00
            brk                ; $f061: 00
            brk                ; $f062: 00
            brk                ; $f063: 00
            brk                ; $f064: 00
            brk                ; $f065: 00
            brk                ; $f066: 00
            brk                ; $f067: 00
            brk                ; $f068: 00
            brk                ; $f069: 00
            brk                ; $f06a: 00
            brk                ; $f06b: 00
            brk                ; $f06c: 00
            brk                ; $f06d: 00
            brk                ; $f06e: 00
            brk                ; $f06f: 00
            brk                ; $f070: 00
            brk                ; $f071: 00
            brk                ; $f072: 00
            brk                ; $f073: 00
            brk                ; $f074: 00
            brk                ; $f075: 00
            brk                ; $f076: 00
            brk                ; $f077: 00
            brk                ; $f078: 00
            brk                ; $f079: 00
            brk                ; $f07a: 00
            brk                ; $f07b: 00
            brk                ; $f07c: 00
            brk                ; $f07d: 00
            brk                ; $f07e: 00
            brk                ; $f07f: 00
            brk                ; $f080: 00
            brk                ; $f081: 00
            brk                ; $f082: 00
            brk                ; $f083: 00
            brk                ; $f084: 00
            brk                ; $f085: 00
            brk                ; $f086: 00
            brk                ; $f087: 00
            brk                ; $f088: 00
            brk                ; $f089: 00
            brk                ; $f08a: 00
            brk                ; $f08b: 00
            brk                ; $f08c: 00
            brk                ; $f08d: 00
            brk                ; $f08e: 00
            brk                ; $f08f: 00
            brk                ; $f090: 00
            brk                ; $f091: 00
            brk                ; $f092: 00
            brk                ; $f093: 00
            brk                ; $f094: 00
            brk                ; $f095: 00
            brk                ; $f096: 00
            brk                ; $f097: 00
            brk                ; $f098: 00
            brk                ; $f099: 00
            brk                ; $f09a: 00
            brk                ; $f09b: 00
            brk                ; $f09c: 00
            brk                ; $f09d: 00
            brk                ; $f09e: 00
            brk                ; $f09f: 00
            brk                ; $f0a0: 00
            brk                ; $f0a1: 00
            brk                ; $f0a2: 00
            brk                ; $f0a3: 00
            brk                ; $f0a4: 00
            brk                ; $f0a5: 00
            brk                ; $f0a6: 00
            brk                ; $f0a7: 00
            brk                ; $f0a8: 00
            brk                ; $f0a9: 00
            brk                ; $f0aa: 00
            brk                ; $f0ab: 00
            brk                ; $f0ac: 00
            brk                ; $f0ad: 00
            brk                ; $f0ae: 00
            brk                ; $f0af: 00
            brk                ; $f0b0: 00
            brk                ; $f0b1: 00
            brk                ; $f0b2: 00
            brk                ; $f0b3: 00
            brk                ; $f0b4: 00
            brk                ; $f0b5: 00
            brk                ; $f0b6: 00
            brk                ; $f0b7: 00
            brk                ; $f0b8: 00
            brk                ; $f0b9: 00
            brk                ; $f0ba: 00
            brk                ; $f0bb: 00
            brk                ; $f0bc: 00
            brk                ; $f0bd: 00
            brk                ; $f0be: 00
            brk                ; $f0bf: 00
            brk                ; $f0c0: 00
            brk                ; $f0c1: 00
            brk                ; $f0c2: 00
            brk                ; $f0c3: 00
            brk                ; $f0c4: 00
            brk                ; $f0c5: 00
            brk                ; $f0c6: 00
            brk                ; $f0c7: 00
            brk                ; $f0c8: 00
            brk                ; $f0c9: 00
            brk                ; $f0ca: 00
            brk                ; $f0cb: 00
            brk                ; $f0cc: 00
            brk                ; $f0cd: 00
            brk                ; $f0ce: 00
            brk                ; $f0cf: 00
            brk                ; $f0d0: 00
            brk                ; $f0d1: 00
            brk                ; $f0d2: 00
            brk                ; $f0d3: 00
            brk                ; $f0d4: 00
            brk                ; $f0d5: 00
            brk                ; $f0d6: 00
            brk                ; $f0d7: 00
            brk                ; $f0d8: 00
            brk                ; $f0d9: 00
            brk                ; $f0da: 00
            brk                ; $f0db: 00
            brk                ; $f0dc: 00
            brk                ; $f0dd: 00
            brk                ; $f0de: 00
            brk                ; $f0df: 00
            brk                ; $f0e0: 00
            brk                ; $f0e1: 00
            brk                ; $f0e2: 00
            brk                ; $f0e3: 00
            brk                ; $f0e4: 00
            brk                ; $f0e5: 00
            brk                ; $f0e6: 00
            brk                ; $f0e7: 00
            brk                ; $f0e8: 00
            brk                ; $f0e9: 00
            brk                ; $f0ea: 00
            brk                ; $f0eb: 00
            brk                ; $f0ec: 00
            brk                ; $f0ed: 00
            brk                ; $f0ee: 00
            brk                ; $f0ef: 00
            brk                ; $f0f0: 00
            brk                ; $f0f1: 00
            brk                ; $f0f2: 00
            brk                ; $f0f3: 00
            brk                ; $f0f4: 00
            brk                ; $f0f5: 00
            brk                ; $f0f6: 00
            brk                ; $f0f7: 00
            brk                ; $f0f8: 00
            brk                ; $f0f9: 00
            brk                ; $f0fa: 00
            brk                ; $f0fb: 00
            brk                ; $f0fc: 00
            brk                ; $f0fd: 00
            brk                ; $f0fe: 00
            brk                ; $f0ff: 00
            brk                ; $f100: 00
            brk                ; $f101: 00
            brk                ; $f102: 00
            brk                ; $f103: 00
            brk                ; $f104: 00
            brk                ; $f105: 00
            brk                ; $f106: 00
            brk                ; $f107: 00
            brk                ; $f108: 00
            brk                ; $f109: 00
            brk                ; $f10a: 00
            brk                ; $f10b: 00
            brk                ; $f10c: 00
            brk                ; $f10d: 00
            brk                ; $f10e: 00
            brk                ; $f10f: 00
            brk                ; $f110: 00
            brk                ; $f111: 00
            brk                ; $f112: 00
            brk                ; $f113: 00
            brk                ; $f114: 00
            brk                ; $f115: 00
            brk                ; $f116: 00
            brk                ; $f117: 00
            brk                ; $f118: 00
            brk                ; $f119: 00
            brk                ; $f11a: 00
            brk                ; $f11b: 00
            brk                ; $f11c: 00
            brk                ; $f11d: 00
            brk                ; $f11e: 00
            brk                ; $f11f: 00
            brk                ; $f120: 00
            brk                ; $f121: 00
            brk                ; $f122: 00
            brk                ; $f123: 00
            brk                ; $f124: 00
            brk                ; $f125: 00
            brk                ; $f126: 00
            brk                ; $f127: 00
            brk                ; $f128: 00
            brk                ; $f129: 00
            brk                ; $f12a: 00
            brk                ; $f12b: 00
            brk                ; $f12c: 00
            brk                ; $f12d: 00
            brk                ; $f12e: 00
            brk                ; $f12f: 00
            brk                ; $f130: 00
            brk                ; $f131: 00
            brk                ; $f132: 00
            brk                ; $f133: 00
            brk                ; $f134: 00
            brk                ; $f135: 00
            brk                ; $f136: 00
            brk                ; $f137: 00
            brk                ; $f138: 00
            brk                ; $f139: 00
            brk                ; $f13a: 00
            brk                ; $f13b: 00
            brk                ; $f13c: 00
            brk                ; $f13d: 00
            brk                ; $f13e: 00
            brk                ; $f13f: 00
            brk                ; $f140: 00
            brk                ; $f141: 00
            brk                ; $f142: 00
            brk                ; $f143: 00
            brk                ; $f144: 00
            brk                ; $f145: 00
            brk                ; $f146: 00
            brk                ; $f147: 00
            brk                ; $f148: 00
            brk                ; $f149: 00
            brk                ; $f14a: 00
            brk                ; $f14b: 00
            brk                ; $f14c: 00
            brk                ; $f14d: 00
            brk                ; $f14e: 00
            brk                ; $f14f: 00
            brk                ; $f150: 00
            brk                ; $f151: 00
            brk                ; $f152: 00
            brk                ; $f153: 00
            brk                ; $f154: 00
            brk                ; $f155: 00
            brk                ; $f156: 00
            brk                ; $f157: 00
            brk                ; $f158: 00
            brk                ; $f159: 00
            brk                ; $f15a: 00
            brk                ; $f15b: 00
            brk                ; $f15c: 00
            brk                ; $f15d: 00
            brk                ; $f15e: 00
            brk                ; $f15f: 00
            brk                ; $f160: 00
            brk                ; $f161: 00
            brk                ; $f162: 00
            brk                ; $f163: 00
            brk                ; $f164: 00
            brk                ; $f165: 00
            brk                ; $f166: 00
            brk                ; $f167: 00
            brk                ; $f168: 00
            brk                ; $f169: 00
            brk                ; $f16a: 00
            brk                ; $f16b: 00
            brk                ; $f16c: 00
            brk                ; $f16d: 00
            brk                ; $f16e: 00
            brk                ; $f16f: 00
            brk                ; $f170: 00
            brk                ; $f171: 00
            brk                ; $f172: 00
            brk                ; $f173: 00
            brk                ; $f174: 00
            brk                ; $f175: 00
            brk                ; $f176: 00
            brk                ; $f177: 00
            brk                ; $f178: 00
            brk                ; $f179: 00
            brk                ; $f17a: 00
            brk                ; $f17b: 00
            brk                ; $f17c: 00
            brk                ; $f17d: 00
            brk                ; $f17e: 00
            brk                ; $f17f: 00
            brk                ; $f180: 00
            brk                ; $f181: 00
            brk                ; $f182: 00
            brk                ; $f183: 00
            brk                ; $f184: 00
            brk                ; $f185: 00
            brk                ; $f186: 00
            brk                ; $f187: 00
            brk                ; $f188: 00
            brk                ; $f189: 00
            brk                ; $f18a: 00
            brk                ; $f18b: 00
            brk                ; $f18c: 00
            brk                ; $f18d: 00
            brk                ; $f18e: 00
            brk                ; $f18f: 00
            brk                ; $f190: 00
            brk                ; $f191: 00
            brk                ; $f192: 00
            brk                ; $f193: 00
            brk                ; $f194: 00
            brk                ; $f195: 00
            brk                ; $f196: 00
            brk                ; $f197: 00
            brk                ; $f198: 00
            brk                ; $f199: 00
            brk                ; $f19a: 00
            brk                ; $f19b: 00
            brk                ; $f19c: 00
            brk                ; $f19d: 00
            brk                ; $f19e: 00
            brk                ; $f19f: 00
            brk                ; $f1a0: 00
            brk                ; $f1a1: 00
            brk                ; $f1a2: 00
            brk                ; $f1a3: 00
            brk                ; $f1a4: 00
            brk                ; $f1a5: 00
            brk                ; $f1a6: 00
            brk                ; $f1a7: 00
            brk                ; $f1a8: 00
            brk                ; $f1a9: 00
            brk                ; $f1aa: 00
            brk                ; $f1ab: 00
            brk                ; $f1ac: 00
            brk                ; $f1ad: 00
            brk                ; $f1ae: 00
            brk                ; $f1af: 00
            brk                ; $f1b0: 00
            brk                ; $f1b1: 00
            brk                ; $f1b2: 00
            brk                ; $f1b3: 00
            brk                ; $f1b4: 00
            brk                ; $f1b5: 00
            brk                ; $f1b6: 00
            brk                ; $f1b7: 00
            brk                ; $f1b8: 00
            brk                ; $f1b9: 00
            brk                ; $f1ba: 00
            brk                ; $f1bb: 00
            brk                ; $f1bc: 00
            brk                ; $f1bd: 00
            brk                ; $f1be: 00
            brk                ; $f1bf: 00
            brk                ; $f1c0: 00
            brk                ; $f1c1: 00
            brk                ; $f1c2: 00
            brk                ; $f1c3: 00
            brk                ; $f1c4: 00
            brk                ; $f1c5: 00
            brk                ; $f1c6: 00
            brk                ; $f1c7: 00
            brk                ; $f1c8: 00
            brk                ; $f1c9: 00
            brk                ; $f1ca: 00
            brk                ; $f1cb: 00
            brk                ; $f1cc: 00
            brk                ; $f1cd: 00
            brk                ; $f1ce: 00
            brk                ; $f1cf: 00
            brk                ; $f1d0: 00
            brk                ; $f1d1: 00
            brk                ; $f1d2: 00
            brk                ; $f1d3: 00
            brk                ; $f1d4: 00
            brk                ; $f1d5: 00
            brk                ; $f1d6: 00
            brk                ; $f1d7: 00
            brk                ; $f1d8: 00
            brk                ; $f1d9: 00
            brk                ; $f1da: 00
            brk                ; $f1db: 00
            brk                ; $f1dc: 00
            brk                ; $f1dd: 00
            brk                ; $f1de: 00
            brk                ; $f1df: 00
            brk                ; $f1e0: 00
            brk                ; $f1e1: 00
            brk                ; $f1e2: 00
            brk                ; $f1e3: 00
            brk                ; $f1e4: 00
            brk                ; $f1e5: 00
            brk                ; $f1e6: 00
            brk                ; $f1e7: 00
            brk                ; $f1e8: 00
            brk                ; $f1e9: 00
            brk                ; $f1ea: 00
            brk                ; $f1eb: 00
            brk                ; $f1ec: 00
            brk                ; $f1ed: 00
            brk                ; $f1ee: 00
            brk                ; $f1ef: 00
            brk                ; $f1f0: 00
            brk                ; $f1f1: 00
            brk                ; $f1f2: 00
            brk                ; $f1f3: 00
            brk                ; $f1f4: 00
            brk                ; $f1f5: 00
            brk                ; $f1f6: 00
            brk                ; $f1f7: 00
            brk                ; $f1f8: 00
            brk                ; $f1f9: 00
            brk                ; $f1fa: 00
            brk                ; $f1fb: 00
            brk                ; $f1fc: 00
            brk                ; $f1fd: 00
            brk                ; $f1fe: 00
            brk                ; $f1ff: 00
            brk                ; $f200: 00
__f201:     brk                ; $f201: 00
            brk                ; $f202: 00
            brk                ; $f203: 00
            brk                ; $f204: 00
            brk                ; $f205: 00
            brk                ; $f206: 00
            brk                ; $f207: 00
            brk                ; $f208: 00
            brk                ; $f209: 00
            brk                ; $f20a: 00
            brk                ; $f20b: 00
            brk                ; $f20c: 00
            brk                ; $f20d: 00
            brk                ; $f20e: 00
            brk                ; $f20f: 00
            brk                ; $f210: 00
            brk                ; $f211: 00
            brk                ; $f212: 00
            brk                ; $f213: 00
            brk                ; $f214: 00
            brk                ; $f215: 00
            brk                ; $f216: 00
            brk                ; $f217: 00
            brk                ; $f218: 00
            brk                ; $f219: 00
            brk                ; $f21a: 00
            brk                ; $f21b: 00
            brk                ; $f21c: 00
            brk                ; $f21d: 00
            brk                ; $f21e: 00
            brk                ; $f21f: 00
            brk                ; $f220: 00
            brk                ; $f221: 00
            brk                ; $f222: 00
            brk                ; $f223: 00
            brk                ; $f224: 00
            brk                ; $f225: 00
            brk                ; $f226: 00
            brk                ; $f227: 00
            brk                ; $f228: 00
            brk                ; $f229: 00
            brk                ; $f22a: 00
            brk                ; $f22b: 00
            brk                ; $f22c: 00
            brk                ; $f22d: 00
            brk                ; $f22e: 00
            brk                ; $f22f: 00
            brk                ; $f230: 00
            brk                ; $f231: 00
            brk                ; $f232: 00
            brk                ; $f233: 00
            brk                ; $f234: 00
            brk                ; $f235: 00
            brk                ; $f236: 00
            brk                ; $f237: 00
            brk                ; $f238: 00
            brk                ; $f239: 00
            brk                ; $f23a: 00
            brk                ; $f23b: 00
            brk                ; $f23c: 00
            brk                ; $f23d: 00
            brk                ; $f23e: 00
            brk                ; $f23f: 00
            brk                ; $f240: 00
            brk                ; $f241: 00
            brk                ; $f242: 00
            brk                ; $f243: 00
            brk                ; $f244: 00
            brk                ; $f245: 00
            brk                ; $f246: 00
            brk                ; $f247: 00
            brk                ; $f248: 00
            brk                ; $f249: 00
            brk                ; $f24a: 00
            brk                ; $f24b: 00
            brk                ; $f24c: 00
            brk                ; $f24d: 00
            brk                ; $f24e: 00
            brk                ; $f24f: 00
            brk                ; $f250: 00
            brk                ; $f251: 00
            brk                ; $f252: 00
            brk                ; $f253: 00
            brk                ; $f254: 00
            brk                ; $f255: 00
            brk                ; $f256: 00
            brk                ; $f257: 00
            brk                ; $f258: 00
            brk                ; $f259: 00
            brk                ; $f25a: 00
            brk                ; $f25b: 00
            brk                ; $f25c: 00
            brk                ; $f25d: 00
            brk                ; $f25e: 00
            brk                ; $f25f: 00
            brk                ; $f260: 00
            brk                ; $f261: 00
            brk                ; $f262: 00
            brk                ; $f263: 00
            brk                ; $f264: 00
            brk                ; $f265: 00
            brk                ; $f266: 00
            brk                ; $f267: 00
            brk                ; $f268: 00
            brk                ; $f269: 00
            brk                ; $f26a: 00
            brk                ; $f26b: 00
            brk                ; $f26c: 00
            brk                ; $f26d: 00
            brk                ; $f26e: 00
            brk                ; $f26f: 00
            brk                ; $f270: 00
            brk                ; $f271: 00
            brk                ; $f272: 00
            brk                ; $f273: 00
            brk                ; $f274: 00
            brk                ; $f275: 00
            brk                ; $f276: 00
            brk                ; $f277: 00
            brk                ; $f278: 00
            brk                ; $f279: 00
            brk                ; $f27a: 00
            brk                ; $f27b: 00
            brk                ; $f27c: 00
            brk                ; $f27d: 00
            brk                ; $f27e: 00
            brk                ; $f27f: 00
            brk                ; $f280: 00
            brk                ; $f281: 00
            brk                ; $f282: 00
            brk                ; $f283: 00
            brk                ; $f284: 00
            brk                ; $f285: 00
            brk                ; $f286: 00
            brk                ; $f287: 00
            brk                ; $f288: 00
            brk                ; $f289: 00
            brk                ; $f28a: 00
            brk                ; $f28b: 00
            brk                ; $f28c: 00
            brk                ; $f28d: 00
            brk                ; $f28e: 00
            brk                ; $f28f: 00
            brk                ; $f290: 00
            brk                ; $f291: 00
            brk                ; $f292: 00
            brk                ; $f293: 00
            brk                ; $f294: 00
            brk                ; $f295: 00
            brk                ; $f296: 00
            brk                ; $f297: 00
            brk                ; $f298: 00
            brk                ; $f299: 00
            brk                ; $f29a: 00
            brk                ; $f29b: 00
            brk                ; $f29c: 00
            brk                ; $f29d: 00
            brk                ; $f29e: 00
            brk                ; $f29f: 00
            brk                ; $f2a0: 00
            brk                ; $f2a1: 00
            brk                ; $f2a2: 00
            brk                ; $f2a3: 00
            brk                ; $f2a4: 00
            brk                ; $f2a5: 00
            brk                ; $f2a6: 00
            brk                ; $f2a7: 00
            brk                ; $f2a8: 00
            brk                ; $f2a9: 00
            brk                ; $f2aa: 00
            brk                ; $f2ab: 00
            brk                ; $f2ac: 00
            brk                ; $f2ad: 00
            brk                ; $f2ae: 00
            brk                ; $f2af: 00
            brk                ; $f2b0: 00
            brk                ; $f2b1: 00
            brk                ; $f2b2: 00
            brk                ; $f2b3: 00
            brk                ; $f2b4: 00
            brk                ; $f2b5: 00
            brk                ; $f2b6: 00
            brk                ; $f2b7: 00
            brk                ; $f2b8: 00
            brk                ; $f2b9: 00
            brk                ; $f2ba: 00
            brk                ; $f2bb: 00
            brk                ; $f2bc: 00
            brk                ; $f2bd: 00
            brk                ; $f2be: 00
            brk                ; $f2bf: 00
            brk                ; $f2c0: 00
            brk                ; $f2c1: 00
            brk                ; $f2c2: 00
            brk                ; $f2c3: 00
            brk                ; $f2c4: 00
            brk                ; $f2c5: 00
            brk                ; $f2c6: 00
            brk                ; $f2c7: 00
            brk                ; $f2c8: 00
            brk                ; $f2c9: 00
            brk                ; $f2ca: 00
            brk                ; $f2cb: 00
            brk                ; $f2cc: 00
            brk                ; $f2cd: 00
            brk                ; $f2ce: 00
            brk                ; $f2cf: 00
            brk                ; $f2d0: 00
            brk                ; $f2d1: 00
            brk                ; $f2d2: 00
            brk                ; $f2d3: 00
            brk                ; $f2d4: 00
            brk                ; $f2d5: 00
            brk                ; $f2d6: 00
            brk                ; $f2d7: 00
            brk                ; $f2d8: 00
            brk                ; $f2d9: 00
            brk                ; $f2da: 00
            brk                ; $f2db: 00
            brk                ; $f2dc: 00
            brk                ; $f2dd: 00
            brk                ; $f2de: 00
            brk                ; $f2df: 00
            brk                ; $f2e0: 00
            brk                ; $f2e1: 00
            brk                ; $f2e2: 00
            brk                ; $f2e3: 00
            brk                ; $f2e4: 00
            brk                ; $f2e5: 00
            brk                ; $f2e6: 00
            brk                ; $f2e7: 00
            brk                ; $f2e8: 00
            brk                ; $f2e9: 00
            brk                ; $f2ea: 00
            brk                ; $f2eb: 00
            brk                ; $f2ec: 00
            brk                ; $f2ed: 00
            brk                ; $f2ee: 00
            brk                ; $f2ef: 00
            brk                ; $f2f0: 00
            brk                ; $f2f1: 00
            brk                ; $f2f2: 00
            brk                ; $f2f3: 00
            brk                ; $f2f4: 00
            brk                ; $f2f5: 00
            brk                ; $f2f6: 00
            brk                ; $f2f7: 00
            brk                ; $f2f8: 00
            brk                ; $f2f9: 00
            brk                ; $f2fa: 00
            brk                ; $f2fb: 00
            brk                ; $f2fc: 00
            brk                ; $f2fd: 00
            brk                ; $f2fe: 00
            brk                ; $f2ff: 00
            brk                ; $f300: 00
            brk                ; $f301: 00
            brk                ; $f302: 00
            brk                ; $f303: 00
            brk                ; $f304: 00
            brk                ; $f305: 00
            brk                ; $f306: 00
            brk                ; $f307: 00
            brk                ; $f308: 00
            brk                ; $f309: 00
            brk                ; $f30a: 00
            brk                ; $f30b: 00
            brk                ; $f30c: 00
            brk                ; $f30d: 00
            brk                ; $f30e: 00
            brk                ; $f30f: 00
            brk                ; $f310: 00
            brk                ; $f311: 00
            brk                ; $f312: 00
            brk                ; $f313: 00
            brk                ; $f314: 00
            brk                ; $f315: 00
            brk                ; $f316: 00
            brk                ; $f317: 00
            brk                ; $f318: 00
            brk                ; $f319: 00
            brk                ; $f31a: 00
            brk                ; $f31b: 00
            brk                ; $f31c: 00
            brk                ; $f31d: 00
            brk                ; $f31e: 00
            brk                ; $f31f: 00
            brk                ; $f320: 00
            brk                ; $f321: 00
            brk                ; $f322: 00
            brk                ; $f323: 00
            brk                ; $f324: 00
            brk                ; $f325: 00
            brk                ; $f326: 00
            brk                ; $f327: 00
            brk                ; $f328: 00
            brk                ; $f329: 00
            brk                ; $f32a: 00
            brk                ; $f32b: 00
            brk                ; $f32c: 00
            brk                ; $f32d: 00
            brk                ; $f32e: 00
            brk                ; $f32f: 00
            brk                ; $f330: 00
            brk                ; $f331: 00
            brk                ; $f332: 00
            brk                ; $f333: 00
            brk                ; $f334: 00
            brk                ; $f335: 00
            brk                ; $f336: 00
            brk                ; $f337: 00
            brk                ; $f338: 00
            brk                ; $f339: 00
            brk                ; $f33a: 00
            brk                ; $f33b: 00
            brk                ; $f33c: 00
            brk                ; $f33d: 00
            brk                ; $f33e: 00
            brk                ; $f33f: 00
            brk                ; $f340: 00
            brk                ; $f341: 00
            brk                ; $f342: 00
            brk                ; $f343: 00
            brk                ; $f344: 00
            brk                ; $f345: 00
            brk                ; $f346: 00
            brk                ; $f347: 00
            brk                ; $f348: 00
            brk                ; $f349: 00
            brk                ; $f34a: 00
            brk                ; $f34b: 00
            brk                ; $f34c: 00
            brk                ; $f34d: 00
            brk                ; $f34e: 00
            brk                ; $f34f: 00
            brk                ; $f350: 00
            brk                ; $f351: 00
            brk                ; $f352: 00
            brk                ; $f353: 00
            brk                ; $f354: 00
            brk                ; $f355: 00
            brk                ; $f356: 00
            brk                ; $f357: 00
            brk                ; $f358: 00
            brk                ; $f359: 00
            brk                ; $f35a: 00
            brk                ; $f35b: 00
            brk                ; $f35c: 00
            brk                ; $f35d: 00
            brk                ; $f35e: 00
            brk                ; $f35f: 00
            brk                ; $f360: 00
            brk                ; $f361: 00
            brk                ; $f362: 00
            brk                ; $f363: 00
            brk                ; $f364: 00
            brk                ; $f365: 00
            brk                ; $f366: 00
            brk                ; $f367: 00
            brk                ; $f368: 00
            brk                ; $f369: 00
            brk                ; $f36a: 00
            brk                ; $f36b: 00
            brk                ; $f36c: 00
            brk                ; $f36d: 00
            brk                ; $f36e: 00
            brk                ; $f36f: 00
            brk                ; $f370: 00
            brk                ; $f371: 00
            brk                ; $f372: 00
            brk                ; $f373: 00
            brk                ; $f374: 00
            brk                ; $f375: 00
            brk                ; $f376: 00
            brk                ; $f377: 00
            brk                ; $f378: 00
            brk                ; $f379: 00
            brk                ; $f37a: 00
            brk                ; $f37b: 00
            brk                ; $f37c: 00
            brk                ; $f37d: 00
            brk                ; $f37e: 00
            brk                ; $f37f: 00
            brk                ; $f380: 00
            brk                ; $f381: 00
            brk                ; $f382: 00
            brk                ; $f383: 00
            brk                ; $f384: 00
            brk                ; $f385: 00
            brk                ; $f386: 00
            brk                ; $f387: 00
            brk                ; $f388: 00
            brk                ; $f389: 00
            brk                ; $f38a: 00
            brk                ; $f38b: 00
            brk                ; $f38c: 00
            brk                ; $f38d: 00
            brk                ; $f38e: 00
            brk                ; $f38f: 00
            brk                ; $f390: 00
            brk                ; $f391: 00
            brk                ; $f392: 00
            brk                ; $f393: 00
            brk                ; $f394: 00
            brk                ; $f395: 00
            brk                ; $f396: 00
            brk                ; $f397: 00
            brk                ; $f398: 00
            brk                ; $f399: 00
            brk                ; $f39a: 00
            brk                ; $f39b: 00
            brk                ; $f39c: 00
            brk                ; $f39d: 00
            brk                ; $f39e: 00
            brk                ; $f39f: 00
            brk                ; $f3a0: 00
            brk                ; $f3a1: 00
            brk                ; $f3a2: 00
            brk                ; $f3a3: 00
            brk                ; $f3a4: 00
            brk                ; $f3a5: 00
            brk                ; $f3a6: 00
            brk                ; $f3a7: 00
            brk                ; $f3a8: 00
            brk                ; $f3a9: 00
            brk                ; $f3aa: 00
            brk                ; $f3ab: 00
            brk                ; $f3ac: 00
            brk                ; $f3ad: 00
            brk                ; $f3ae: 00
            brk                ; $f3af: 00
            brk                ; $f3b0: 00
            brk                ; $f3b1: 00
            brk                ; $f3b2: 00
            brk                ; $f3b3: 00
            brk                ; $f3b4: 00
            brk                ; $f3b5: 00
            brk                ; $f3b6: 00
            brk                ; $f3b7: 00
            brk                ; $f3b8: 00
            brk                ; $f3b9: 00
            brk                ; $f3ba: 00
            brk                ; $f3bb: 00
            brk                ; $f3bc: 00
            brk                ; $f3bd: 00
            brk                ; $f3be: 00
            brk                ; $f3bf: 00
            brk                ; $f3c0: 00
            brk                ; $f3c1: 00
            brk                ; $f3c2: 00
            brk                ; $f3c3: 00
            brk                ; $f3c4: 00
            brk                ; $f3c5: 00
            brk                ; $f3c6: 00
            brk                ; $f3c7: 00
            brk                ; $f3c8: 00
            brk                ; $f3c9: 00
            brk                ; $f3ca: 00
            brk                ; $f3cb: 00
            brk                ; $f3cc: 00
            brk                ; $f3cd: 00
            brk                ; $f3ce: 00
            brk                ; $f3cf: 00
            brk                ; $f3d0: 00
            brk                ; $f3d1: 00
            brk                ; $f3d2: 00
            brk                ; $f3d3: 00
            brk                ; $f3d4: 00
            brk                ; $f3d5: 00
            brk                ; $f3d6: 00
            brk                ; $f3d7: 00
            brk                ; $f3d8: 00
            brk                ; $f3d9: 00
            brk                ; $f3da: 00
            brk                ; $f3db: 00
            brk                ; $f3dc: 00
            brk                ; $f3dd: 00
            brk                ; $f3de: 00
            brk                ; $f3df: 00
            brk                ; $f3e0: 00
            brk                ; $f3e1: 00
            brk                ; $f3e2: 00
            brk                ; $f3e3: 00
            brk                ; $f3e4: 00
            brk                ; $f3e5: 00
            brk                ; $f3e6: 00
            brk                ; $f3e7: 00
            brk                ; $f3e8: 00
            brk                ; $f3e9: 00
            brk                ; $f3ea: 00
            brk                ; $f3eb: 00
            brk                ; $f3ec: 00
            brk                ; $f3ed: 00
            brk                ; $f3ee: 00
            brk                ; $f3ef: 00
            brk                ; $f3f0: 00
            brk                ; $f3f1: 00
            brk                ; $f3f2: 00
            brk                ; $f3f3: 00
            brk                ; $f3f4: 00
            brk                ; $f3f5: 00
            brk                ; $f3f6: 00
            brk                ; $f3f7: 00
            brk                ; $f3f8: 00
            brk                ; $f3f9: 00
            brk                ; $f3fa: 00
            brk                ; $f3fb: 00
            brk                ; $f3fc: 00
            brk                ; $f3fd: 00
            brk                ; $f3fe: 00
            brk                ; $f3ff: 00
            brk                ; $f400: 00
__f401:     brk                ; $f401: 00
            brk                ; $f402: 00
            brk                ; $f403: 00
            brk                ; $f404: 00
            brk                ; $f405: 00
            brk                ; $f406: 00
            brk                ; $f407: 00
            brk                ; $f408: 00
            brk                ; $f409: 00
            brk                ; $f40a: 00
            brk                ; $f40b: 00
            brk                ; $f40c: 00
            brk                ; $f40d: 00
            brk                ; $f40e: 00
            brk                ; $f40f: 00
            brk                ; $f410: 00
            brk                ; $f411: 00
            brk                ; $f412: 00
            brk                ; $f413: 00
            brk                ; $f414: 00
            brk                ; $f415: 00
            brk                ; $f416: 00
            brk                ; $f417: 00
            brk                ; $f418: 00
            brk                ; $f419: 00
            brk                ; $f41a: 00
            brk                ; $f41b: 00
            brk                ; $f41c: 00
            brk                ; $f41d: 00
            brk                ; $f41e: 00
            brk                ; $f41f: 00
            brk                ; $f420: 00
            brk                ; $f421: 00
            brk                ; $f422: 00
            brk                ; $f423: 00
            brk                ; $f424: 00
            brk                ; $f425: 00
            brk                ; $f426: 00
            brk                ; $f427: 00
            brk                ; $f428: 00
            brk                ; $f429: 00
            brk                ; $f42a: 00
            brk                ; $f42b: 00
            brk                ; $f42c: 00
            brk                ; $f42d: 00
            brk                ; $f42e: 00
            brk                ; $f42f: 00
            brk                ; $f430: 00
            brk                ; $f431: 00
            brk                ; $f432: 00
            brk                ; $f433: 00
            brk                ; $f434: 00
            brk                ; $f435: 00
            brk                ; $f436: 00
            brk                ; $f437: 00
            brk                ; $f438: 00
            brk                ; $f439: 00
            brk                ; $f43a: 00
            brk                ; $f43b: 00
            brk                ; $f43c: 00
            brk                ; $f43d: 00
            brk                ; $f43e: 00
            brk                ; $f43f: 00
            brk                ; $f440: 00
            brk                ; $f441: 00
            brk                ; $f442: 00
            brk                ; $f443: 00
            brk                ; $f444: 00
            brk                ; $f445: 00
            brk                ; $f446: 00
            brk                ; $f447: 00
            brk                ; $f448: 00
            brk                ; $f449: 00
            brk                ; $f44a: 00
            brk                ; $f44b: 00
            brk                ; $f44c: 00
            brk                ; $f44d: 00
            brk                ; $f44e: 00
            brk                ; $f44f: 00
            brk                ; $f450: 00
            brk                ; $f451: 00
            brk                ; $f452: 00
            brk                ; $f453: 00
            brk                ; $f454: 00
            brk                ; $f455: 00
            brk                ; $f456: 00
            brk                ; $f457: 00
            brk                ; $f458: 00
            brk                ; $f459: 00
            brk                ; $f45a: 00
            brk                ; $f45b: 00
            brk                ; $f45c: 00
            brk                ; $f45d: 00
            brk                ; $f45e: 00
            brk                ; $f45f: 00
            brk                ; $f460: 00
            brk                ; $f461: 00
            brk                ; $f462: 00
            brk                ; $f463: 00
            brk                ; $f464: 00
            brk                ; $f465: 00
            brk                ; $f466: 00
            brk                ; $f467: 00
            brk                ; $f468: 00
            brk                ; $f469: 00
            brk                ; $f46a: 00
            brk                ; $f46b: 00
            brk                ; $f46c: 00
            brk                ; $f46d: 00
            brk                ; $f46e: 00
            brk                ; $f46f: 00
            brk                ; $f470: 00
            brk                ; $f471: 00
            brk                ; $f472: 00
            brk                ; $f473: 00
            brk                ; $f474: 00
            brk                ; $f475: 00
            brk                ; $f476: 00
            brk                ; $f477: 00
            brk                ; $f478: 00
            brk                ; $f479: 00
            brk                ; $f47a: 00
            brk                ; $f47b: 00
            brk                ; $f47c: 00
            brk                ; $f47d: 00
            brk                ; $f47e: 00
            brk                ; $f47f: 00
            brk                ; $f480: 00
            brk                ; $f481: 00
            brk                ; $f482: 00
            brk                ; $f483: 00
            brk                ; $f484: 00
            brk                ; $f485: 00
            brk                ; $f486: 00
            brk                ; $f487: 00
            brk                ; $f488: 00
            brk                ; $f489: 00
            brk                ; $f48a: 00
            brk                ; $f48b: 00
            brk                ; $f48c: 00
            brk                ; $f48d: 00
            brk                ; $f48e: 00
            brk                ; $f48f: 00
            brk                ; $f490: 00
            brk                ; $f491: 00
            brk                ; $f492: 00
            brk                ; $f493: 00
            brk                ; $f494: 00
            brk                ; $f495: 00
            brk                ; $f496: 00
            brk                ; $f497: 00
            brk                ; $f498: 00
            brk                ; $f499: 00
            brk                ; $f49a: 00
            brk                ; $f49b: 00
            brk                ; $f49c: 00
            brk                ; $f49d: 00
            brk                ; $f49e: 00
            brk                ; $f49f: 00
            brk                ; $f4a0: 00
            brk                ; $f4a1: 00
            brk                ; $f4a2: 00
            brk                ; $f4a3: 00
            brk                ; $f4a4: 00
            brk                ; $f4a5: 00
            brk                ; $f4a6: 00
            brk                ; $f4a7: 00
            brk                ; $f4a8: 00
            brk                ; $f4a9: 00
            brk                ; $f4aa: 00
            brk                ; $f4ab: 00
            brk                ; $f4ac: 00
            brk                ; $f4ad: 00
            brk                ; $f4ae: 00
            brk                ; $f4af: 00
            brk                ; $f4b0: 00
            brk                ; $f4b1: 00
            brk                ; $f4b2: 00
            brk                ; $f4b3: 00
            brk                ; $f4b4: 00
            brk                ; $f4b5: 00
            brk                ; $f4b6: 00
            brk                ; $f4b7: 00
            brk                ; $f4b8: 00
            brk                ; $f4b9: 00
            brk                ; $f4ba: 00
            brk                ; $f4bb: 00
            brk                ; $f4bc: 00
            brk                ; $f4bd: 00
            brk                ; $f4be: 00
            brk                ; $f4bf: 00
            brk                ; $f4c0: 00
            brk                ; $f4c1: 00
            brk                ; $f4c2: 00
            brk                ; $f4c3: 00
            brk                ; $f4c4: 00
            brk                ; $f4c5: 00
            brk                ; $f4c6: 00
            brk                ; $f4c7: 00
            brk                ; $f4c8: 00
            brk                ; $f4c9: 00
            brk                ; $f4ca: 00
            brk                ; $f4cb: 00
            brk                ; $f4cc: 00
            brk                ; $f4cd: 00
            brk                ; $f4ce: 00
            brk                ; $f4cf: 00
            brk                ; $f4d0: 00
            brk                ; $f4d1: 00
            brk                ; $f4d2: 00
            brk                ; $f4d3: 00
            brk                ; $f4d4: 00
            brk                ; $f4d5: 00
            brk                ; $f4d6: 00
            brk                ; $f4d7: 00
            brk                ; $f4d8: 00
            brk                ; $f4d9: 00
            brk                ; $f4da: 00
            brk                ; $f4db: 00
            brk                ; $f4dc: 00
            brk                ; $f4dd: 00
            brk                ; $f4de: 00
            brk                ; $f4df: 00
            brk                ; $f4e0: 00
            brk                ; $f4e1: 00
            brk                ; $f4e2: 00
            brk                ; $f4e3: 00
            brk                ; $f4e4: 00
            brk                ; $f4e5: 00
            brk                ; $f4e6: 00
            brk                ; $f4e7: 00
            brk                ; $f4e8: 00
            brk                ; $f4e9: 00
            brk                ; $f4ea: 00
            brk                ; $f4eb: 00
            brk                ; $f4ec: 00
            brk                ; $f4ed: 00
            brk                ; $f4ee: 00
            brk                ; $f4ef: 00
            brk                ; $f4f0: 00
            brk                ; $f4f1: 00
            brk                ; $f4f2: 00
            brk                ; $f4f3: 00
            brk                ; $f4f4: 00
            brk                ; $f4f5: 00
            brk                ; $f4f6: 00
            brk                ; $f4f7: 00
            brk                ; $f4f8: 00
            brk                ; $f4f9: 00
            brk                ; $f4fa: 00
            brk                ; $f4fb: 00
            brk                ; $f4fc: 00
            brk                ; $f4fd: 00
            brk                ; $f4fe: 00
            brk                ; $f4ff: 00
            brk                ; $f500: 00
            brk                ; $f501: 00
            brk                ; $f502: 00
            brk                ; $f503: 00
            brk                ; $f504: 00
            brk                ; $f505: 00
            brk                ; $f506: 00
            brk                ; $f507: 00
            brk                ; $f508: 00
            brk                ; $f509: 00
            brk                ; $f50a: 00
            brk                ; $f50b: 00
            brk                ; $f50c: 00
            brk                ; $f50d: 00
            brk                ; $f50e: 00
            brk                ; $f50f: 00
            brk                ; $f510: 00
            brk                ; $f511: 00
            brk                ; $f512: 00
            brk                ; $f513: 00
            brk                ; $f514: 00
            brk                ; $f515: 00
            brk                ; $f516: 00
            brk                ; $f517: 00
            brk                ; $f518: 00
            brk                ; $f519: 00
            brk                ; $f51a: 00
            brk                ; $f51b: 00
            brk                ; $f51c: 00
            brk                ; $f51d: 00
            brk                ; $f51e: 00
            brk                ; $f51f: 00
            brk                ; $f520: 00
            brk                ; $f521: 00
            brk                ; $f522: 00
            brk                ; $f523: 00
            brk                ; $f524: 00
            brk                ; $f525: 00
            brk                ; $f526: 00
            brk                ; $f527: 00
            brk                ; $f528: 00
            brk                ; $f529: 00
            brk                ; $f52a: 00
            brk                ; $f52b: 00
            brk                ; $f52c: 00
            brk                ; $f52d: 00
            brk                ; $f52e: 00
            brk                ; $f52f: 00
            brk                ; $f530: 00
            brk                ; $f531: 00
            brk                ; $f532: 00
            brk                ; $f533: 00
            brk                ; $f534: 00
            brk                ; $f535: 00
            brk                ; $f536: 00
            brk                ; $f537: 00
            brk                ; $f538: 00
            brk                ; $f539: 00
            brk                ; $f53a: 00
            brk                ; $f53b: 00
            brk                ; $f53c: 00
            brk                ; $f53d: 00
            brk                ; $f53e: 00
            brk                ; $f53f: 00
            brk                ; $f540: 00
            brk                ; $f541: 00
            brk                ; $f542: 00
            brk                ; $f543: 00
            brk                ; $f544: 00
            brk                ; $f545: 00
            brk                ; $f546: 00
            brk                ; $f547: 00
            brk                ; $f548: 00
            brk                ; $f549: 00
            brk                ; $f54a: 00
            brk                ; $f54b: 00
            brk                ; $f54c: 00
            brk                ; $f54d: 00
            brk                ; $f54e: 00
            brk                ; $f54f: 00
            brk                ; $f550: 00
            brk                ; $f551: 00
            brk                ; $f552: 00
            brk                ; $f553: 00
            brk                ; $f554: 00
            brk                ; $f555: 00
            brk                ; $f556: 00
            brk                ; $f557: 00
            brk                ; $f558: 00
            brk                ; $f559: 00
            brk                ; $f55a: 00
            brk                ; $f55b: 00
            brk                ; $f55c: 00
            brk                ; $f55d: 00
            brk                ; $f55e: 00
            brk                ; $f55f: 00
            brk                ; $f560: 00
            brk                ; $f561: 00
            brk                ; $f562: 00
            brk                ; $f563: 00
            brk                ; $f564: 00
            brk                ; $f565: 00
            brk                ; $f566: 00
            brk                ; $f567: 00
            brk                ; $f568: 00
            brk                ; $f569: 00
            brk                ; $f56a: 00
            brk                ; $f56b: 00
            brk                ; $f56c: 00
            brk                ; $f56d: 00
            brk                ; $f56e: 00
            brk                ; $f56f: 00
            brk                ; $f570: 00
            brk                ; $f571: 00
            brk                ; $f572: 00
            brk                ; $f573: 00
            brk                ; $f574: 00
            brk                ; $f575: 00
            brk                ; $f576: 00
            brk                ; $f577: 00
            brk                ; $f578: 00
            brk                ; $f579: 00
            brk                ; $f57a: 00
            brk                ; $f57b: 00
            brk                ; $f57c: 00
            brk                ; $f57d: 00
            brk                ; $f57e: 00
            brk                ; $f57f: 00
            brk                ; $f580: 00
            brk                ; $f581: 00
            brk                ; $f582: 00
            brk                ; $f583: 00
            brk                ; $f584: 00
            brk                ; $f585: 00
            brk                ; $f586: 00
            brk                ; $f587: 00
            brk                ; $f588: 00
            brk                ; $f589: 00
            brk                ; $f58a: 00
            brk                ; $f58b: 00
            brk                ; $f58c: 00
            brk                ; $f58d: 00
            brk                ; $f58e: 00
            brk                ; $f58f: 00
            brk                ; $f590: 00
            brk                ; $f591: 00
            brk                ; $f592: 00
            brk                ; $f593: 00
            brk                ; $f594: 00
            brk                ; $f595: 00
            brk                ; $f596: 00
            brk                ; $f597: 00
            brk                ; $f598: 00
            brk                ; $f599: 00
            brk                ; $f59a: 00
            brk                ; $f59b: 00
            brk                ; $f59c: 00
            brk                ; $f59d: 00
            brk                ; $f59e: 00
            brk                ; $f59f: 00
            brk                ; $f5a0: 00
            brk                ; $f5a1: 00
            brk                ; $f5a2: 00
            brk                ; $f5a3: 00
            brk                ; $f5a4: 00
            brk                ; $f5a5: 00
            brk                ; $f5a6: 00
            brk                ; $f5a7: 00
            brk                ; $f5a8: 00
            brk                ; $f5a9: 00
            brk                ; $f5aa: 00
            brk                ; $f5ab: 00
            brk                ; $f5ac: 00
            brk                ; $f5ad: 00
            brk                ; $f5ae: 00
            brk                ; $f5af: 00
            brk                ; $f5b0: 00
            brk                ; $f5b1: 00
            brk                ; $f5b2: 00
            brk                ; $f5b3: 00
            brk                ; $f5b4: 00
            brk                ; $f5b5: 00
            brk                ; $f5b6: 00
            brk                ; $f5b7: 00
            brk                ; $f5b8: 00
            brk                ; $f5b9: 00
            brk                ; $f5ba: 00
            brk                ; $f5bb: 00
            brk                ; $f5bc: 00
            brk                ; $f5bd: 00
            brk                ; $f5be: 00
            brk                ; $f5bf: 00
            brk                ; $f5c0: 00
            brk                ; $f5c1: 00
            brk                ; $f5c2: 00
            brk                ; $f5c3: 00
            brk                ; $f5c4: 00
            brk                ; $f5c5: 00
            brk                ; $f5c6: 00
            brk                ; $f5c7: 00
            brk                ; $f5c8: 00
            brk                ; $f5c9: 00
            brk                ; $f5ca: 00
            brk                ; $f5cb: 00
            brk                ; $f5cc: 00
            brk                ; $f5cd: 00
            brk                ; $f5ce: 00
            brk                ; $f5cf: 00
            brk                ; $f5d0: 00
            brk                ; $f5d1: 00
            brk                ; $f5d2: 00
            brk                ; $f5d3: 00
            brk                ; $f5d4: 00
            brk                ; $f5d5: 00
            brk                ; $f5d6: 00
            brk                ; $f5d7: 00
            brk                ; $f5d8: 00
            brk                ; $f5d9: 00
            brk                ; $f5da: 00
            brk                ; $f5db: 00
            brk                ; $f5dc: 00
            brk                ; $f5dd: 00
            brk                ; $f5de: 00
            brk                ; $f5df: 00
            brk                ; $f5e0: 00
            brk                ; $f5e1: 00
            brk                ; $f5e2: 00
            brk                ; $f5e3: 00
            brk                ; $f5e4: 00
            brk                ; $f5e5: 00
            brk                ; $f5e6: 00
            brk                ; $f5e7: 00
            brk                ; $f5e8: 00
            brk                ; $f5e9: 00
            brk                ; $f5ea: 00
            brk                ; $f5eb: 00
            brk                ; $f5ec: 00
            brk                ; $f5ed: 00
            brk                ; $f5ee: 00
            brk                ; $f5ef: 00
            brk                ; $f5f0: 00
            brk                ; $f5f1: 00
            brk                ; $f5f2: 00
            brk                ; $f5f3: 00
            brk                ; $f5f4: 00
            brk                ; $f5f5: 00
            brk                ; $f5f6: 00
            brk                ; $f5f7: 00
            brk                ; $f5f8: 00
            brk                ; $f5f9: 00
            brk                ; $f5fa: 00
            brk                ; $f5fb: 00
            brk                ; $f5fc: 00
            brk                ; $f5fd: 00
            brk                ; $f5fe: 00
            brk                ; $f5ff: 00
            brk                ; $f600: 00
            brk                ; $f601: 00
            brk                ; $f602: 00
            brk                ; $f603: 00
            brk                ; $f604: 00
            brk                ; $f605: 00
            brk                ; $f606: 00
            brk                ; $f607: 00
            brk                ; $f608: 00
            brk                ; $f609: 00
            brk                ; $f60a: 00
            brk                ; $f60b: 00
            brk                ; $f60c: 00
            brk                ; $f60d: 00
            brk                ; $f60e: 00
            brk                ; $f60f: 00
            brk                ; $f610: 00
            brk                ; $f611: 00
            brk                ; $f612: 00
            brk                ; $f613: 00
            brk                ; $f614: 00
            brk                ; $f615: 00
            brk                ; $f616: 00
            brk                ; $f617: 00
            brk                ; $f618: 00
            brk                ; $f619: 00
            brk                ; $f61a: 00
            brk                ; $f61b: 00
            brk                ; $f61c: 00
            brk                ; $f61d: 00
            brk                ; $f61e: 00
            brk                ; $f61f: 00
            brk                ; $f620: 00
            brk                ; $f621: 00
            brk                ; $f622: 00
            brk                ; $f623: 00
            brk                ; $f624: 00
            brk                ; $f625: 00
            brk                ; $f626: 00
            brk                ; $f627: 00
            brk                ; $f628: 00
            brk                ; $f629: 00
            brk                ; $f62a: 00
            brk                ; $f62b: 00
            brk                ; $f62c: 00
            brk                ; $f62d: 00
            brk                ; $f62e: 00
            brk                ; $f62f: 00
            brk                ; $f630: 00
            brk                ; $f631: 00
            brk                ; $f632: 00
            brk                ; $f633: 00
            brk                ; $f634: 00
            brk                ; $f635: 00
            brk                ; $f636: 00
            brk                ; $f637: 00
            brk                ; $f638: 00
            brk                ; $f639: 00
            brk                ; $f63a: 00
            brk                ; $f63b: 00
            brk                ; $f63c: 00
            brk                ; $f63d: 00
            brk                ; $f63e: 00
            brk                ; $f63f: 00
            brk                ; $f640: 00
            brk                ; $f641: 00
            brk                ; $f642: 00
            brk                ; $f643: 00
            brk                ; $f644: 00
            brk                ; $f645: 00
            brk                ; $f646: 00
            brk                ; $f647: 00
            brk                ; $f648: 00
            brk                ; $f649: 00
            brk                ; $f64a: 00
            brk                ; $f64b: 00
            brk                ; $f64c: 00
            brk                ; $f64d: 00
            brk                ; $f64e: 00
            brk                ; $f64f: 00
            brk                ; $f650: 00
            brk                ; $f651: 00
            brk                ; $f652: 00
            brk                ; $f653: 00
            brk                ; $f654: 00
            brk                ; $f655: 00
            brk                ; $f656: 00
            brk                ; $f657: 00
            brk                ; $f658: 00
            brk                ; $f659: 00
            brk                ; $f65a: 00
            brk                ; $f65b: 00
            brk                ; $f65c: 00
            brk                ; $f65d: 00
            brk                ; $f65e: 00
            brk                ; $f65f: 00
            brk                ; $f660: 00
            brk                ; $f661: 00
            brk                ; $f662: 00
            brk                ; $f663: 00
            brk                ; $f664: 00
            brk                ; $f665: 00
            brk                ; $f666: 00
            brk                ; $f667: 00
            brk                ; $f668: 00
            brk                ; $f669: 00
            brk                ; $f66a: 00
            brk                ; $f66b: 00
            brk                ; $f66c: 00
            brk                ; $f66d: 00
            brk                ; $f66e: 00
            brk                ; $f66f: 00
            brk                ; $f670: 00
            brk                ; $f671: 00
            brk                ; $f672: 00
            brk                ; $f673: 00
            brk                ; $f674: 00
            brk                ; $f675: 00
            brk                ; $f676: 00
            brk                ; $f677: 00
            brk                ; $f678: 00
            brk                ; $f679: 00
            brk                ; $f67a: 00
            brk                ; $f67b: 00
            brk                ; $f67c: 00
            brk                ; $f67d: 00
            brk                ; $f67e: 00
            brk                ; $f67f: 00
            brk                ; $f680: 00
            brk                ; $f681: 00
            brk                ; $f682: 00
            brk                ; $f683: 00
            brk                ; $f684: 00
            brk                ; $f685: 00
            brk                ; $f686: 00
            brk                ; $f687: 00
            brk                ; $f688: 00
            brk                ; $f689: 00
            brk                ; $f68a: 00
            brk                ; $f68b: 00
            brk                ; $f68c: 00
            brk                ; $f68d: 00
            brk                ; $f68e: 00
            brk                ; $f68f: 00
            brk                ; $f690: 00
            brk                ; $f691: 00
            brk                ; $f692: 00
            brk                ; $f693: 00
            brk                ; $f694: 00
            brk                ; $f695: 00
            brk                ; $f696: 00
            brk                ; $f697: 00
            brk                ; $f698: 00
            brk                ; $f699: 00
            brk                ; $f69a: 00
            brk                ; $f69b: 00
            brk                ; $f69c: 00
            brk                ; $f69d: 00
            brk                ; $f69e: 00
            brk                ; $f69f: 00
            brk                ; $f6a0: 00
            brk                ; $f6a1: 00
            brk                ; $f6a2: 00
            brk                ; $f6a3: 00
            brk                ; $f6a4: 00
            brk                ; $f6a5: 00
            brk                ; $f6a6: 00
            brk                ; $f6a7: 00
            brk                ; $f6a8: 00
            brk                ; $f6a9: 00
            brk                ; $f6aa: 00
            brk                ; $f6ab: 00
            brk                ; $f6ac: 00
            brk                ; $f6ad: 00
            brk                ; $f6ae: 00
            brk                ; $f6af: 00
            brk                ; $f6b0: 00
            brk                ; $f6b1: 00
            brk                ; $f6b2: 00
            brk                ; $f6b3: 00
            brk                ; $f6b4: 00
            brk                ; $f6b5: 00
            brk                ; $f6b6: 00
            brk                ; $f6b7: 00
            brk                ; $f6b8: 00
            brk                ; $f6b9: 00
            brk                ; $f6ba: 00
            brk                ; $f6bb: 00
            brk                ; $f6bc: 00
            brk                ; $f6bd: 00
            brk                ; $f6be: 00
            brk                ; $f6bf: 00
            brk                ; $f6c0: 00
            brk                ; $f6c1: 00
            brk                ; $f6c2: 00
            brk                ; $f6c3: 00
            brk                ; $f6c4: 00
            brk                ; $f6c5: 00
            brk                ; $f6c6: 00
            brk                ; $f6c7: 00
            brk                ; $f6c8: 00
            brk                ; $f6c9: 00
            brk                ; $f6ca: 00
            brk                ; $f6cb: 00
            brk                ; $f6cc: 00
            brk                ; $f6cd: 00
            brk                ; $f6ce: 00
            brk                ; $f6cf: 00
            brk                ; $f6d0: 00
            brk                ; $f6d1: 00
            brk                ; $f6d2: 00
            brk                ; $f6d3: 00
            brk                ; $f6d4: 00
            brk                ; $f6d5: 00
            brk                ; $f6d6: 00
            brk                ; $f6d7: 00
            brk                ; $f6d8: 00
            brk                ; $f6d9: 00
            brk                ; $f6da: 00
            brk                ; $f6db: 00
            brk                ; $f6dc: 00
            brk                ; $f6dd: 00
            brk                ; $f6de: 00
            brk                ; $f6df: 00
            brk                ; $f6e0: 00
            brk                ; $f6e1: 00
            brk                ; $f6e2: 00
            brk                ; $f6e3: 00
            brk                ; $f6e4: 00
            brk                ; $f6e5: 00
            brk                ; $f6e6: 00
            brk                ; $f6e7: 00
            brk                ; $f6e8: 00
            brk                ; $f6e9: 00
            brk                ; $f6ea: 00
            brk                ; $f6eb: 00
            brk                ; $f6ec: 00
            brk                ; $f6ed: 00
            brk                ; $f6ee: 00
            brk                ; $f6ef: 00
            brk                ; $f6f0: 00
            brk                ; $f6f1: 00
            brk                ; $f6f2: 00
            brk                ; $f6f3: 00
            brk                ; $f6f4: 00
            brk                ; $f6f5: 00
            brk                ; $f6f6: 00
            brk                ; $f6f7: 00
            brk                ; $f6f8: 00
            brk                ; $f6f9: 00
            brk                ; $f6fa: 00
            brk                ; $f6fb: 00
            brk                ; $f6fc: 00
            brk                ; $f6fd: 00
            brk                ; $f6fe: 00
            brk                ; $f6ff: 00
            brk                ; $f700: 00
            brk                ; $f701: 00
            brk                ; $f702: 00
            brk                ; $f703: 00
            brk                ; $f704: 00
            brk                ; $f705: 00
            brk                ; $f706: 00
            brk                ; $f707: 00
            brk                ; $f708: 00
            brk                ; $f709: 00
            brk                ; $f70a: 00
            brk                ; $f70b: 00
            brk                ; $f70c: 00
            brk                ; $f70d: 00
            brk                ; $f70e: 00
            brk                ; $f70f: 00
            brk                ; $f710: 00
            brk                ; $f711: 00
            brk                ; $f712: 00
            brk                ; $f713: 00
            brk                ; $f714: 00
            brk                ; $f715: 00
            brk                ; $f716: 00
            brk                ; $f717: 00
            brk                ; $f718: 00
            brk                ; $f719: 00
            brk                ; $f71a: 00
            brk                ; $f71b: 00
            brk                ; $f71c: 00
            brk                ; $f71d: 00
            brk                ; $f71e: 00
            brk                ; $f71f: 00
            brk                ; $f720: 00
            brk                ; $f721: 00
            brk                ; $f722: 00
            brk                ; $f723: 00
            brk                ; $f724: 00
            brk                ; $f725: 00
            brk                ; $f726: 00
            brk                ; $f727: 00
            brk                ; $f728: 00
            brk                ; $f729: 00
            brk                ; $f72a: 00
            brk                ; $f72b: 00
            brk                ; $f72c: 00
            brk                ; $f72d: 00
            brk                ; $f72e: 00
            brk                ; $f72f: 00
            brk                ; $f730: 00
            brk                ; $f731: 00
            brk                ; $f732: 00
            brk                ; $f733: 00
            brk                ; $f734: 00
            brk                ; $f735: 00
            brk                ; $f736: 00
            brk                ; $f737: 00
            brk                ; $f738: 00
            brk                ; $f739: 00
            brk                ; $f73a: 00
            brk                ; $f73b: 00
            brk                ; $f73c: 00
            brk                ; $f73d: 00
            brk                ; $f73e: 00
            brk                ; $f73f: 00
            brk                ; $f740: 00
            brk                ; $f741: 00
            brk                ; $f742: 00
            brk                ; $f743: 00
            brk                ; $f744: 00
            brk                ; $f745: 00
            brk                ; $f746: 00
            brk                ; $f747: 00
            brk                ; $f748: 00
            brk                ; $f749: 00
            brk                ; $f74a: 00
            brk                ; $f74b: 00
            brk                ; $f74c: 00
            brk                ; $f74d: 00
            brk                ; $f74e: 00
            brk                ; $f74f: 00
            brk                ; $f750: 00
            brk                ; $f751: 00
            brk                ; $f752: 00
            brk                ; $f753: 00
            brk                ; $f754: 00
            brk                ; $f755: 00
            brk                ; $f756: 00
            brk                ; $f757: 00
            brk                ; $f758: 00
            brk                ; $f759: 00
            brk                ; $f75a: 00
            brk                ; $f75b: 00
            brk                ; $f75c: 00
            brk                ; $f75d: 00
            brk                ; $f75e: 00
            brk                ; $f75f: 00
            brk                ; $f760: 00
            brk                ; $f761: 00
            brk                ; $f762: 00
            brk                ; $f763: 00
            brk                ; $f764: 00
            brk                ; $f765: 00
            brk                ; $f766: 00
            brk                ; $f767: 00
            brk                ; $f768: 00
            brk                ; $f769: 00
            brk                ; $f76a: 00
            brk                ; $f76b: 00
            brk                ; $f76c: 00
            brk                ; $f76d: 00
            brk                ; $f76e: 00
            brk                ; $f76f: 00
            brk                ; $f770: 00
            brk                ; $f771: 00
            brk                ; $f772: 00
            brk                ; $f773: 00
            brk                ; $f774: 00
            brk                ; $f775: 00
            brk                ; $f776: 00
            brk                ; $f777: 00
            brk                ; $f778: 00
            brk                ; $f779: 00
            brk                ; $f77a: 00
            brk                ; $f77b: 00
            brk                ; $f77c: 00
            brk                ; $f77d: 00
            brk                ; $f77e: 00
            brk                ; $f77f: 00
            brk                ; $f780: 00
            brk                ; $f781: 00
            brk                ; $f782: 00
            brk                ; $f783: 00
            brk                ; $f784: 00
            brk                ; $f785: 00
            brk                ; $f786: 00
            brk                ; $f787: 00
            brk                ; $f788: 00
            brk                ; $f789: 00
            brk                ; $f78a: 00
            brk                ; $f78b: 00
            brk                ; $f78c: 00
            brk                ; $f78d: 00
            brk                ; $f78e: 00
            brk                ; $f78f: 00
            brk                ; $f790: 00
            brk                ; $f791: 00
            brk                ; $f792: 00
            brk                ; $f793: 00
            brk                ; $f794: 00
            brk                ; $f795: 00
            brk                ; $f796: 00
            brk                ; $f797: 00
            brk                ; $f798: 00
            brk                ; $f799: 00
            brk                ; $f79a: 00
            brk                ; $f79b: 00
            brk                ; $f79c: 00
            brk                ; $f79d: 00
            brk                ; $f79e: 00
            brk                ; $f79f: 00
            brk                ; $f7a0: 00
            brk                ; $f7a1: 00
            brk                ; $f7a2: 00
            brk                ; $f7a3: 00
            brk                ; $f7a4: 00
            brk                ; $f7a5: 00
            brk                ; $f7a6: 00
            brk                ; $f7a7: 00
            brk                ; $f7a8: 00
            brk                ; $f7a9: 00
            brk                ; $f7aa: 00
            brk                ; $f7ab: 00
            brk                ; $f7ac: 00
            brk                ; $f7ad: 00
            brk                ; $f7ae: 00
            brk                ; $f7af: 00
            brk                ; $f7b0: 00
            brk                ; $f7b1: 00
            brk                ; $f7b2: 00
            brk                ; $f7b3: 00
            brk                ; $f7b4: 00
            brk                ; $f7b5: 00
            brk                ; $f7b6: 00
            brk                ; $f7b7: 00
            brk                ; $f7b8: 00
            brk                ; $f7b9: 00
            brk                ; $f7ba: 00
            brk                ; $f7bb: 00
            brk                ; $f7bc: 00
            brk                ; $f7bd: 00
            brk                ; $f7be: 00
            brk                ; $f7bf: 00
            brk                ; $f7c0: 00
            brk                ; $f7c1: 00
            brk                ; $f7c2: 00
            brk                ; $f7c3: 00
            brk                ; $f7c4: 00
            brk                ; $f7c5: 00
            brk                ; $f7c6: 00
            brk                ; $f7c7: 00
            brk                ; $f7c8: 00
            brk                ; $f7c9: 00
            brk                ; $f7ca: 00
            brk                ; $f7cb: 00
            brk                ; $f7cc: 00
            brk                ; $f7cd: 00
            brk                ; $f7ce: 00
            brk                ; $f7cf: 00
            brk                ; $f7d0: 00
            brk                ; $f7d1: 00
            brk                ; $f7d2: 00
            brk                ; $f7d3: 00
            brk                ; $f7d4: 00
            brk                ; $f7d5: 00
            brk                ; $f7d6: 00
            brk                ; $f7d7: 00
            brk                ; $f7d8: 00
            brk                ; $f7d9: 00
            brk                ; $f7da: 00
            brk                ; $f7db: 00
            brk                ; $f7dc: 00
            brk                ; $f7dd: 00
            brk                ; $f7de: 00
            brk                ; $f7df: 00
            brk                ; $f7e0: 00
            brk                ; $f7e1: 00
            brk                ; $f7e2: 00
            brk                ; $f7e3: 00
            brk                ; $f7e4: 00
            brk                ; $f7e5: 00
            brk                ; $f7e6: 00
            brk                ; $f7e7: 00
            brk                ; $f7e8: 00
            brk                ; $f7e9: 00
            brk                ; $f7ea: 00
            brk                ; $f7eb: 00
            brk                ; $f7ec: 00
            brk                ; $f7ed: 00
            brk                ; $f7ee: 00
            brk                ; $f7ef: 00
            brk                ; $f7f0: 00
            brk                ; $f7f1: 00
            brk                ; $f7f2: 00
            brk                ; $f7f3: 00
            brk                ; $f7f4: 00
            brk                ; $f7f5: 00
            brk                ; $f7f6: 00
            brk                ; $f7f7: 00
            brk                ; $f7f8: 00
            brk                ; $f7f9: 00
            brk                ; $f7fa: 00
            brk                ; $f7fb: 00
            brk                ; $f7fc: 00
            brk                ; $f7fd: 00
            brk                ; $f7fe: 00
            brk                ; $f7ff: 00
            brk                ; $f800: 00
            brk                ; $f801: 00
            brk                ; $f802: 00
            brk                ; $f803: 00
            brk                ; $f804: 00
            brk                ; $f805: 00
            brk                ; $f806: 00
            brk                ; $f807: 00
            brk                ; $f808: 00
            brk                ; $f809: 00
            brk                ; $f80a: 00
            brk                ; $f80b: 00
            brk                ; $f80c: 00
            brk                ; $f80d: 00
            brk                ; $f80e: 00
            brk                ; $f80f: 00
            brk                ; $f810: 00
            brk                ; $f811: 00
            brk                ; $f812: 00
            brk                ; $f813: 00
            brk                ; $f814: 00
            brk                ; $f815: 00
            brk                ; $f816: 00
            brk                ; $f817: 00
            brk                ; $f818: 00
            brk                ; $f819: 00
            brk                ; $f81a: 00
            brk                ; $f81b: 00
            brk                ; $f81c: 00
            brk                ; $f81d: 00
            brk                ; $f81e: 00
            brk                ; $f81f: 00
            brk                ; $f820: 00
            brk                ; $f821: 00
            brk                ; $f822: 00
            brk                ; $f823: 00
            brk                ; $f824: 00
            brk                ; $f825: 00
            brk                ; $f826: 00
            brk                ; $f827: 00
            brk                ; $f828: 00
            brk                ; $f829: 00
            brk                ; $f82a: 00
            brk                ; $f82b: 00
            brk                ; $f82c: 00
            brk                ; $f82d: 00
            brk                ; $f82e: 00
            brk                ; $f82f: 00
            brk                ; $f830: 00
            brk                ; $f831: 00
            brk                ; $f832: 00
            brk                ; $f833: 00
            brk                ; $f834: 00
            brk                ; $f835: 00
            brk                ; $f836: 00
            brk                ; $f837: 00
            brk                ; $f838: 00
            brk                ; $f839: 00
            brk                ; $f83a: 00
            brk                ; $f83b: 00
            brk                ; $f83c: 00
            brk                ; $f83d: 00
            brk                ; $f83e: 00
            brk                ; $f83f: 00
            brk                ; $f840: 00
            brk                ; $f841: 00
            brk                ; $f842: 00
            brk                ; $f843: 00
            brk                ; $f844: 00
            brk                ; $f845: 00
            brk                ; $f846: 00
            brk                ; $f847: 00
            brk                ; $f848: 00
            brk                ; $f849: 00
            brk                ; $f84a: 00
            brk                ; $f84b: 00
            brk                ; $f84c: 00
            brk                ; $f84d: 00
            brk                ; $f84e: 00
            brk                ; $f84f: 00
            brk                ; $f850: 00
            brk                ; $f851: 00
            brk                ; $f852: 00
            brk                ; $f853: 00
            brk                ; $f854: 00
            brk                ; $f855: 00
            brk                ; $f856: 00
            brk                ; $f857: 00
            brk                ; $f858: 00
            brk                ; $f859: 00
            brk                ; $f85a: 00
            brk                ; $f85b: 00
            brk                ; $f85c: 00
            brk                ; $f85d: 00
            brk                ; $f85e: 00
            brk                ; $f85f: 00
            brk                ; $f860: 00
            brk                ; $f861: 00
            brk                ; $f862: 00
            brk                ; $f863: 00
            brk                ; $f864: 00
            brk                ; $f865: 00
            brk                ; $f866: 00
            brk                ; $f867: 00
            brk                ; $f868: 00
            brk                ; $f869: 00
            brk                ; $f86a: 00
            brk                ; $f86b: 00
            brk                ; $f86c: 00
            brk                ; $f86d: 00
            brk                ; $f86e: 00
            brk                ; $f86f: 00
            brk                ; $f870: 00
            brk                ; $f871: 00
            brk                ; $f872: 00
            brk                ; $f873: 00
            brk                ; $f874: 00
            brk                ; $f875: 00
            brk                ; $f876: 00
            brk                ; $f877: 00
            brk                ; $f878: 00
            brk                ; $f879: 00
            brk                ; $f87a: 00
            brk                ; $f87b: 00
            brk                ; $f87c: 00
            brk                ; $f87d: 00
            brk                ; $f87e: 00
            brk                ; $f87f: 00
            brk                ; $f880: 00
            brk                ; $f881: 00
            brk                ; $f882: 00
            brk                ; $f883: 00
            brk                ; $f884: 00
            brk                ; $f885: 00
            brk                ; $f886: 00
            brk                ; $f887: 00
            brk                ; $f888: 00
            brk                ; $f889: 00
            brk                ; $f88a: 00
            brk                ; $f88b: 00
            brk                ; $f88c: 00
            brk                ; $f88d: 00
            brk                ; $f88e: 00
            brk                ; $f88f: 00
            brk                ; $f890: 00
            brk                ; $f891: 00
            brk                ; $f892: 00
            brk                ; $f893: 00
            brk                ; $f894: 00
            brk                ; $f895: 00
            brk                ; $f896: 00
            brk                ; $f897: 00
            brk                ; $f898: 00
            brk                ; $f899: 00
            brk                ; $f89a: 00
            brk                ; $f89b: 00
            brk                ; $f89c: 00
            brk                ; $f89d: 00
            brk                ; $f89e: 00
            brk                ; $f89f: 00
            brk                ; $f8a0: 00
            brk                ; $f8a1: 00
            brk                ; $f8a2: 00
            brk                ; $f8a3: 00
            brk                ; $f8a4: 00
            brk                ; $f8a5: 00
            brk                ; $f8a6: 00
            brk                ; $f8a7: 00
            brk                ; $f8a8: 00
            brk                ; $f8a9: 00
            brk                ; $f8aa: 00
            brk                ; $f8ab: 00
            brk                ; $f8ac: 00
            brk                ; $f8ad: 00
            brk                ; $f8ae: 00
            brk                ; $f8af: 00
            brk                ; $f8b0: 00
            brk                ; $f8b1: 00
            brk                ; $f8b2: 00
            brk                ; $f8b3: 00
            brk                ; $f8b4: 00
            brk                ; $f8b5: 00
            brk                ; $f8b6: 00
            brk                ; $f8b7: 00
            brk                ; $f8b8: 00
            brk                ; $f8b9: 00
            brk                ; $f8ba: 00
            brk                ; $f8bb: 00
            brk                ; $f8bc: 00
            brk                ; $f8bd: 00
            brk                ; $f8be: 00
            brk                ; $f8bf: 00
            brk                ; $f8c0: 00
            brk                ; $f8c1: 00
            brk                ; $f8c2: 00
            brk                ; $f8c3: 00
            brk                ; $f8c4: 00
            brk                ; $f8c5: 00
            brk                ; $f8c6: 00
            brk                ; $f8c7: 00
            brk                ; $f8c8: 00
            brk                ; $f8c9: 00
            brk                ; $f8ca: 00
            brk                ; $f8cb: 00
            brk                ; $f8cc: 00
            brk                ; $f8cd: 00
            brk                ; $f8ce: 00
            brk                ; $f8cf: 00
            brk                ; $f8d0: 00
            brk                ; $f8d1: 00
            brk                ; $f8d2: 00
            brk                ; $f8d3: 00
            brk                ; $f8d4: 00
            brk                ; $f8d5: 00
            brk                ; $f8d6: 00
            brk                ; $f8d7: 00
            brk                ; $f8d8: 00
            brk                ; $f8d9: 00
            brk                ; $f8da: 00
            brk                ; $f8db: 00
            brk                ; $f8dc: 00
            brk                ; $f8dd: 00
            brk                ; $f8de: 00
            brk                ; $f8df: 00
            brk                ; $f8e0: 00
            brk                ; $f8e1: 00
            brk                ; $f8e2: 00
            brk                ; $f8e3: 00
            brk                ; $f8e4: 00
            brk                ; $f8e5: 00
            brk                ; $f8e6: 00
            brk                ; $f8e7: 00
            brk                ; $f8e8: 00
            brk                ; $f8e9: 00
            brk                ; $f8ea: 00
            brk                ; $f8eb: 00
            brk                ; $f8ec: 00
            brk                ; $f8ed: 00
            brk                ; $f8ee: 00
            brk                ; $f8ef: 00
            brk                ; $f8f0: 00
            brk                ; $f8f1: 00
            brk                ; $f8f2: 00
            brk                ; $f8f3: 00
            brk                ; $f8f4: 00
            brk                ; $f8f5: 00
            brk                ; $f8f6: 00
            brk                ; $f8f7: 00
            brk                ; $f8f8: 00
            brk                ; $f8f9: 00
            brk                ; $f8fa: 00
            brk                ; $f8fb: 00
            brk                ; $f8fc: 00
            brk                ; $f8fd: 00
            brk                ; $f8fe: 00
            brk                ; $f8ff: 00
            brk                ; $f900: 00
            brk                ; $f901: 00
            brk                ; $f902: 00
            brk                ; $f903: 00
            brk                ; $f904: 00
            brk                ; $f905: 00
            brk                ; $f906: 00
            brk                ; $f907: 00
            brk                ; $f908: 00
            brk                ; $f909: 00
            brk                ; $f90a: 00
            brk                ; $f90b: 00
            brk                ; $f90c: 00
            brk                ; $f90d: 00
            brk                ; $f90e: 00
            brk                ; $f90f: 00
            brk                ; $f910: 00
            brk                ; $f911: 00
            brk                ; $f912: 00
            brk                ; $f913: 00
            brk                ; $f914: 00
            brk                ; $f915: 00
            brk                ; $f916: 00
            brk                ; $f917: 00
            brk                ; $f918: 00
            brk                ; $f919: 00
            brk                ; $f91a: 00
            brk                ; $f91b: 00
            brk                ; $f91c: 00
            brk                ; $f91d: 00
            brk                ; $f91e: 00
            brk                ; $f91f: 00
            brk                ; $f920: 00
            brk                ; $f921: 00
            brk                ; $f922: 00
            brk                ; $f923: 00
            brk                ; $f924: 00
            brk                ; $f925: 00
            brk                ; $f926: 00
            brk                ; $f927: 00
            brk                ; $f928: 00
            brk                ; $f929: 00
            brk                ; $f92a: 00
            brk                ; $f92b: 00
            brk                ; $f92c: 00
            brk                ; $f92d: 00
            brk                ; $f92e: 00
            brk                ; $f92f: 00
            brk                ; $f930: 00
            brk                ; $f931: 00
            brk                ; $f932: 00
            brk                ; $f933: 00
            brk                ; $f934: 00
            brk                ; $f935: 00
            brk                ; $f936: 00
            brk                ; $f937: 00
            brk                ; $f938: 00
            brk                ; $f939: 00
            brk                ; $f93a: 00
            brk                ; $f93b: 00
            brk                ; $f93c: 00
            brk                ; $f93d: 00
            brk                ; $f93e: 00
            brk                ; $f93f: 00
            brk                ; $f940: 00
            brk                ; $f941: 00
            brk                ; $f942: 00
            brk                ; $f943: 00
            brk                ; $f944: 00
            brk                ; $f945: 00
            brk                ; $f946: 00
            brk                ; $f947: 00
            brk                ; $f948: 00
            brk                ; $f949: 00
            brk                ; $f94a: 00
            brk                ; $f94b: 00
            brk                ; $f94c: 00
            brk                ; $f94d: 00
            brk                ; $f94e: 00
            brk                ; $f94f: 00
            brk                ; $f950: 00
            brk                ; $f951: 00
            brk                ; $f952: 00
            brk                ; $f953: 00
            brk                ; $f954: 00
            brk                ; $f955: 00
            brk                ; $f956: 00
            brk                ; $f957: 00
            brk                ; $f958: 00
            brk                ; $f959: 00
            brk                ; $f95a: 00
            brk                ; $f95b: 00
            brk                ; $f95c: 00
            brk                ; $f95d: 00
            brk                ; $f95e: 00
            brk                ; $f95f: 00
            brk                ; $f960: 00
            brk                ; $f961: 00
            brk                ; $f962: 00
            brk                ; $f963: 00
            brk                ; $f964: 00
            brk                ; $f965: 00
            brk                ; $f966: 00
            brk                ; $f967: 00
            brk                ; $f968: 00
            brk                ; $f969: 00
            brk                ; $f96a: 00
            brk                ; $f96b: 00
            brk                ; $f96c: 00
            brk                ; $f96d: 00
            brk                ; $f96e: 00
            brk                ; $f96f: 00
            brk                ; $f970: 00
            brk                ; $f971: 00
            brk                ; $f972: 00
            brk                ; $f973: 00
            brk                ; $f974: 00
            brk                ; $f975: 00
            brk                ; $f976: 00
            brk                ; $f977: 00
            brk                ; $f978: 00
            brk                ; $f979: 00
            brk                ; $f97a: 00
            brk                ; $f97b: 00
            brk                ; $f97c: 00
            brk                ; $f97d: 00
            brk                ; $f97e: 00
            brk                ; $f97f: 00
            brk                ; $f980: 00
            brk                ; $f981: 00
            brk                ; $f982: 00
            brk                ; $f983: 00
            brk                ; $f984: 00
            brk                ; $f985: 00
            brk                ; $f986: 00
            brk                ; $f987: 00
            brk                ; $f988: 00
            brk                ; $f989: 00
            brk                ; $f98a: 00
            brk                ; $f98b: 00
            brk                ; $f98c: 00
            brk                ; $f98d: 00
            brk                ; $f98e: 00
            brk                ; $f98f: 00
            brk                ; $f990: 00
            brk                ; $f991: 00
            brk                ; $f992: 00
            brk                ; $f993: 00
            brk                ; $f994: 00
            brk                ; $f995: 00
            brk                ; $f996: 00
            brk                ; $f997: 00
            brk                ; $f998: 00
            brk                ; $f999: 00
            brk                ; $f99a: 00
            brk                ; $f99b: 00
            brk                ; $f99c: 00
            brk                ; $f99d: 00
            brk                ; $f99e: 00
            brk                ; $f99f: 00
            brk                ; $f9a0: 00
            brk                ; $f9a1: 00
            brk                ; $f9a2: 00
            brk                ; $f9a3: 00
            brk                ; $f9a4: 00
            brk                ; $f9a5: 00
            brk                ; $f9a6: 00
            brk                ; $f9a7: 00
            brk                ; $f9a8: 00
            brk                ; $f9a9: 00
            brk                ; $f9aa: 00
            brk                ; $f9ab: 00
            brk                ; $f9ac: 00
            brk                ; $f9ad: 00
            brk                ; $f9ae: 00
            brk                ; $f9af: 00
            brk                ; $f9b0: 00
            brk                ; $f9b1: 00
            brk                ; $f9b2: 00
            brk                ; $f9b3: 00
            brk                ; $f9b4: 00
            brk                ; $f9b5: 00
            brk                ; $f9b6: 00
            brk                ; $f9b7: 00
            brk                ; $f9b8: 00
            brk                ; $f9b9: 00
            brk                ; $f9ba: 00
            brk                ; $f9bb: 00
            brk                ; $f9bc: 00
            brk                ; $f9bd: 00
            brk                ; $f9be: 00
            brk                ; $f9bf: 00
            brk                ; $f9c0: 00
            brk                ; $f9c1: 00
            brk                ; $f9c2: 00
            brk                ; $f9c3: 00
            brk                ; $f9c4: 00
            brk                ; $f9c5: 00
            brk                ; $f9c6: 00
            brk                ; $f9c7: 00
            brk                ; $f9c8: 00
            brk                ; $f9c9: 00
            brk                ; $f9ca: 00
            brk                ; $f9cb: 00
            brk                ; $f9cc: 00
            brk                ; $f9cd: 00
            brk                ; $f9ce: 00
            brk                ; $f9cf: 00
            brk                ; $f9d0: 00
            brk                ; $f9d1: 00
            brk                ; $f9d2: 00
            brk                ; $f9d3: 00
            brk                ; $f9d4: 00
            brk                ; $f9d5: 00
            brk                ; $f9d6: 00
            brk                ; $f9d7: 00
            brk                ; $f9d8: 00
            brk                ; $f9d9: 00
            brk                ; $f9da: 00
            brk                ; $f9db: 00
            brk                ; $f9dc: 00
            brk                ; $f9dd: 00
            brk                ; $f9de: 00
            brk                ; $f9df: 00
            brk                ; $f9e0: 00
            brk                ; $f9e1: 00
            brk                ; $f9e2: 00
            brk                ; $f9e3: 00
            brk                ; $f9e4: 00
            brk                ; $f9e5: 00
            brk                ; $f9e6: 00
            brk                ; $f9e7: 00
            brk                ; $f9e8: 00
            brk                ; $f9e9: 00
            brk                ; $f9ea: 00
            brk                ; $f9eb: 00
            brk                ; $f9ec: 00
            brk                ; $f9ed: 00
            brk                ; $f9ee: 00
            brk                ; $f9ef: 00
            brk                ; $f9f0: 00
            brk                ; $f9f1: 00
            brk                ; $f9f2: 00
            brk                ; $f9f3: 00
            brk                ; $f9f4: 00
            brk                ; $f9f5: 00
            brk                ; $f9f6: 00
            brk                ; $f9f7: 00
            brk                ; $f9f8: 00
            brk                ; $f9f9: 00
            brk                ; $f9fa: 00
            brk                ; $f9fb: 00
            brk                ; $f9fc: 00
            brk                ; $f9fd: 00
            brk                ; $f9fe: 00
            brk                ; $f9ff: 00
            brk                ; $fa00: 00
            brk                ; $fa01: 00
            brk                ; $fa02: 00
            brk                ; $fa03: 00
            brk                ; $fa04: 00
            brk                ; $fa05: 00
            brk                ; $fa06: 00
            brk                ; $fa07: 00
            brk                ; $fa08: 00
            brk                ; $fa09: 00
            brk                ; $fa0a: 00
            brk                ; $fa0b: 00
            brk                ; $fa0c: 00
            brk                ; $fa0d: 00
            brk                ; $fa0e: 00
            brk                ; $fa0f: 00
            brk                ; $fa10: 00
            brk                ; $fa11: 00
            brk                ; $fa12: 00
            brk                ; $fa13: 00
            brk                ; $fa14: 00
            brk                ; $fa15: 00
            brk                ; $fa16: 00
            brk                ; $fa17: 00
            brk                ; $fa18: 00
            brk                ; $fa19: 00
            brk                ; $fa1a: 00
            brk                ; $fa1b: 00
            brk                ; $fa1c: 00
            brk                ; $fa1d: 00
            brk                ; $fa1e: 00
            brk                ; $fa1f: 00
            brk                ; $fa20: 00
            brk                ; $fa21: 00
            brk                ; $fa22: 00
            brk                ; $fa23: 00
            brk                ; $fa24: 00
            brk                ; $fa25: 00
            brk                ; $fa26: 00
            brk                ; $fa27: 00
            brk                ; $fa28: 00
            brk                ; $fa29: 00
            brk                ; $fa2a: 00
            brk                ; $fa2b: 00
            brk                ; $fa2c: 00
            brk                ; $fa2d: 00
            brk                ; $fa2e: 00
            brk                ; $fa2f: 00
            brk                ; $fa30: 00
            brk                ; $fa31: 00
            brk                ; $fa32: 00
            brk                ; $fa33: 00
            brk                ; $fa34: 00
            brk                ; $fa35: 00
            brk                ; $fa36: 00
            brk                ; $fa37: 00
            brk                ; $fa38: 00
            brk                ; $fa39: 00
            brk                ; $fa3a: 00
            brk                ; $fa3b: 00
            brk                ; $fa3c: 00
            brk                ; $fa3d: 00
            brk                ; $fa3e: 00
            brk                ; $fa3f: 00
            brk                ; $fa40: 00
            brk                ; $fa41: 00
            brk                ; $fa42: 00
            brk                ; $fa43: 00
            brk                ; $fa44: 00
            brk                ; $fa45: 00
            brk                ; $fa46: 00
            brk                ; $fa47: 00
            brk                ; $fa48: 00
            brk                ; $fa49: 00
            brk                ; $fa4a: 00
            brk                ; $fa4b: 00
            brk                ; $fa4c: 00
            brk                ; $fa4d: 00
            brk                ; $fa4e: 00
            brk                ; $fa4f: 00
            brk                ; $fa50: 00
            brk                ; $fa51: 00
            brk                ; $fa52: 00
            brk                ; $fa53: 00
            brk                ; $fa54: 00
            brk                ; $fa55: 00
            brk                ; $fa56: 00
            brk                ; $fa57: 00
            brk                ; $fa58: 00
            brk                ; $fa59: 00
            brk                ; $fa5a: 00
            brk                ; $fa5b: 00
            brk                ; $fa5c: 00
            brk                ; $fa5d: 00
            brk                ; $fa5e: 00
            brk                ; $fa5f: 00
            brk                ; $fa60: 00
            brk                ; $fa61: 00
            brk                ; $fa62: 00
            brk                ; $fa63: 00
            brk                ; $fa64: 00
            brk                ; $fa65: 00
            brk                ; $fa66: 00
            brk                ; $fa67: 00
            brk                ; $fa68: 00
            brk                ; $fa69: 00
            brk                ; $fa6a: 00
            brk                ; $fa6b: 00
            brk                ; $fa6c: 00
            brk                ; $fa6d: 00
            brk                ; $fa6e: 00
            brk                ; $fa6f: 00
            brk                ; $fa70: 00
            brk                ; $fa71: 00
            brk                ; $fa72: 00
            brk                ; $fa73: 00
            brk                ; $fa74: 00
            brk                ; $fa75: 00
            brk                ; $fa76: 00
            brk                ; $fa77: 00
            brk                ; $fa78: 00
            brk                ; $fa79: 00
            brk                ; $fa7a: 00
            brk                ; $fa7b: 00
            brk                ; $fa7c: 00
            brk                ; $fa7d: 00
            brk                ; $fa7e: 00
            brk                ; $fa7f: 00
            brk                ; $fa80: 00
            brk                ; $fa81: 00
            brk                ; $fa82: 00
            brk                ; $fa83: 00
            brk                ; $fa84: 00
            brk                ; $fa85: 00
            brk                ; $fa86: 00
            brk                ; $fa87: 00
            brk                ; $fa88: 00
            brk                ; $fa89: 00
            brk                ; $fa8a: 00
            brk                ; $fa8b: 00
            brk                ; $fa8c: 00
            brk                ; $fa8d: 00
            brk                ; $fa8e: 00
            brk                ; $fa8f: 00
            brk                ; $fa90: 00
            brk                ; $fa91: 00
            brk                ; $fa92: 00
            brk                ; $fa93: 00
            brk                ; $fa94: 00
            brk                ; $fa95: 00
            brk                ; $fa96: 00
            brk                ; $fa97: 00
            brk                ; $fa98: 00
            brk                ; $fa99: 00
            brk                ; $fa9a: 00
            brk                ; $fa9b: 00
            brk                ; $fa9c: 00
            brk                ; $fa9d: 00
            brk                ; $fa9e: 00
            brk                ; $fa9f: 00
            brk                ; $faa0: 00
            brk                ; $faa1: 00
            brk                ; $faa2: 00
            brk                ; $faa3: 00
            brk                ; $faa4: 00
            brk                ; $faa5: 00
            brk                ; $faa6: 00
            brk                ; $faa7: 00
            brk                ; $faa8: 00
            brk                ; $faa9: 00
            brk                ; $faaa: 00
            brk                ; $faab: 00
            brk                ; $faac: 00
            brk                ; $faad: 00
            brk                ; $faae: 00
            brk                ; $faaf: 00
            brk                ; $fab0: 00
            brk                ; $fab1: 00
            brk                ; $fab2: 00
            brk                ; $fab3: 00
            brk                ; $fab4: 00
            brk                ; $fab5: 00
            brk                ; $fab6: 00
            brk                ; $fab7: 00
            brk                ; $fab8: 00
            brk                ; $fab9: 00
            brk                ; $faba: 00
            brk                ; $fabb: 00
            brk                ; $fabc: 00
            brk                ; $fabd: 00
            brk                ; $fabe: 00
            brk                ; $fabf: 00
            brk                ; $fac0: 00
            brk                ; $fac1: 00
            brk                ; $fac2: 00
            brk                ; $fac3: 00
            brk                ; $fac4: 00
            brk                ; $fac5: 00
            brk                ; $fac6: 00
            brk                ; $fac7: 00
            brk                ; $fac8: 00
            brk                ; $fac9: 00
            brk                ; $faca: 00
            brk                ; $facb: 00
            brk                ; $facc: 00
            brk                ; $facd: 00
            brk                ; $face: 00
            brk                ; $facf: 00
            brk                ; $fad0: 00
            brk                ; $fad1: 00
            brk                ; $fad2: 00
            brk                ; $fad3: 00
            brk                ; $fad4: 00
            brk                ; $fad5: 00
            brk                ; $fad6: 00
            brk                ; $fad7: 00
            brk                ; $fad8: 00
            brk                ; $fad9: 00
            brk                ; $fada: 00
            brk                ; $fadb: 00
            brk                ; $fadc: 00
            brk                ; $fadd: 00
            brk                ; $fade: 00
            brk                ; $fadf: 00
            brk                ; $fae0: 00
            brk                ; $fae1: 00
            brk                ; $fae2: 00
            brk                ; $fae3: 00
            brk                ; $fae4: 00
            brk                ; $fae5: 00
            brk                ; $fae6: 00
            brk                ; $fae7: 00
            brk                ; $fae8: 00
            brk                ; $fae9: 00
            brk                ; $faea: 00
            brk                ; $faeb: 00
            brk                ; $faec: 00
            brk                ; $faed: 00
            brk                ; $faee: 00
            brk                ; $faef: 00
            brk                ; $faf0: 00
            brk                ; $faf1: 00
            brk                ; $faf2: 00
            brk                ; $faf3: 00
            brk                ; $faf4: 00
            brk                ; $faf5: 00
            brk                ; $faf6: 00
            brk                ; $faf7: 00
            brk                ; $faf8: 00
            brk                ; $faf9: 00
            brk                ; $fafa: 00
            brk                ; $fafb: 00
            brk                ; $fafc: 00
            brk                ; $fafd: 00
            brk                ; $fafe: 00
            brk                ; $faff: 00
            brk                ; $fb00: 00
__fb01:     brk                ; $fb01: 00
            brk                ; $fb02: 00
            brk                ; $fb03: 00
            brk                ; $fb04: 00
            brk                ; $fb05: 00
            brk                ; $fb06: 00
            brk                ; $fb07: 00
            brk                ; $fb08: 00
            brk                ; $fb09: 00
            brk                ; $fb0a: 00
            brk                ; $fb0b: 00
            brk                ; $fb0c: 00
            brk                ; $fb0d: 00
            brk                ; $fb0e: 00
            brk                ; $fb0f: 00
            brk                ; $fb10: 00
            brk                ; $fb11: 00
            brk                ; $fb12: 00
            brk                ; $fb13: 00
            brk                ; $fb14: 00
            brk                ; $fb15: 00
            brk                ; $fb16: 00
            brk                ; $fb17: 00
            brk                ; $fb18: 00
            brk                ; $fb19: 00
            brk                ; $fb1a: 00
            brk                ; $fb1b: 00
            brk                ; $fb1c: 00
            brk                ; $fb1d: 00
            brk                ; $fb1e: 00
            brk                ; $fb1f: 00
            brk                ; $fb20: 00
            brk                ; $fb21: 00
            brk                ; $fb22: 00
            brk                ; $fb23: 00
            brk                ; $fb24: 00
            brk                ; $fb25: 00
            brk                ; $fb26: 00
            brk                ; $fb27: 00
            brk                ; $fb28: 00
            brk                ; $fb29: 00
            brk                ; $fb2a: 00
            brk                ; $fb2b: 00
            brk                ; $fb2c: 00
            brk                ; $fb2d: 00
            brk                ; $fb2e: 00
            brk                ; $fb2f: 00
            brk                ; $fb30: 00
            brk                ; $fb31: 00
            brk                ; $fb32: 00
            brk                ; $fb33: 00
            brk                ; $fb34: 00
            brk                ; $fb35: 00
            brk                ; $fb36: 00
            brk                ; $fb37: 00
            brk                ; $fb38: 00
            brk                ; $fb39: 00
            brk                ; $fb3a: 00
            brk                ; $fb3b: 00
            brk                ; $fb3c: 00
            brk                ; $fb3d: 00
            brk                ; $fb3e: 00
            brk                ; $fb3f: 00
            brk                ; $fb40: 00
            brk                ; $fb41: 00
            brk                ; $fb42: 00
            brk                ; $fb43: 00
            brk                ; $fb44: 00
            brk                ; $fb45: 00
            brk                ; $fb46: 00
            brk                ; $fb47: 00
            brk                ; $fb48: 00
            brk                ; $fb49: 00
            brk                ; $fb4a: 00
            brk                ; $fb4b: 00
            brk                ; $fb4c: 00
            brk                ; $fb4d: 00
            brk                ; $fb4e: 00
            brk                ; $fb4f: 00
            brk                ; $fb50: 00
            brk                ; $fb51: 00
            brk                ; $fb52: 00
            brk                ; $fb53: 00
            brk                ; $fb54: 00
            brk                ; $fb55: 00
            brk                ; $fb56: 00
            brk                ; $fb57: 00
            brk                ; $fb58: 00
            brk                ; $fb59: 00
            brk                ; $fb5a: 00
            brk                ; $fb5b: 00
            brk                ; $fb5c: 00
            brk                ; $fb5d: 00
            brk                ; $fb5e: 00
            brk                ; $fb5f: 00
            brk                ; $fb60: 00
            brk                ; $fb61: 00
            brk                ; $fb62: 00
            brk                ; $fb63: 00
            brk                ; $fb64: 00
            brk                ; $fb65: 00
            brk                ; $fb66: 00
            brk                ; $fb67: 00
            brk                ; $fb68: 00
            brk                ; $fb69: 00
            brk                ; $fb6a: 00
            brk                ; $fb6b: 00
            brk                ; $fb6c: 00
            brk                ; $fb6d: 00
            brk                ; $fb6e: 00
            brk                ; $fb6f: 00
            brk                ; $fb70: 00
            brk                ; $fb71: 00
            brk                ; $fb72: 00
            brk                ; $fb73: 00
            brk                ; $fb74: 00
            brk                ; $fb75: 00
            brk                ; $fb76: 00
            brk                ; $fb77: 00
            brk                ; $fb78: 00
            brk                ; $fb79: 00
            brk                ; $fb7a: 00
            brk                ; $fb7b: 00
            brk                ; $fb7c: 00
            brk                ; $fb7d: 00
            brk                ; $fb7e: 00
            brk                ; $fb7f: 00
            brk                ; $fb80: 00
            brk                ; $fb81: 00
            brk                ; $fb82: 00
            brk                ; $fb83: 00
            brk                ; $fb84: 00
            brk                ; $fb85: 00
            brk                ; $fb86: 00
            brk                ; $fb87: 00
            brk                ; $fb88: 00
            brk                ; $fb89: 00
            brk                ; $fb8a: 00
            brk                ; $fb8b: 00
            brk                ; $fb8c: 00
            brk                ; $fb8d: 00
            brk                ; $fb8e: 00
            brk                ; $fb8f: 00
            brk                ; $fb90: 00
            brk                ; $fb91: 00
            brk                ; $fb92: 00
            brk                ; $fb93: 00
            brk                ; $fb94: 00
            brk                ; $fb95: 00
            brk                ; $fb96: 00
            brk                ; $fb97: 00
            brk                ; $fb98: 00
            brk                ; $fb99: 00
            brk                ; $fb9a: 00
            brk                ; $fb9b: 00
            brk                ; $fb9c: 00
            brk                ; $fb9d: 00
            brk                ; $fb9e: 00
            brk                ; $fb9f: 00
            brk                ; $fba0: 00
            brk                ; $fba1: 00
            brk                ; $fba2: 00
            brk                ; $fba3: 00
            brk                ; $fba4: 00
            brk                ; $fba5: 00
            brk                ; $fba6: 00
            brk                ; $fba7: 00
            brk                ; $fba8: 00
            brk                ; $fba9: 00
            brk                ; $fbaa: 00
            brk                ; $fbab: 00
            brk                ; $fbac: 00
            brk                ; $fbad: 00
            brk                ; $fbae: 00
            brk                ; $fbaf: 00
            brk                ; $fbb0: 00
            brk                ; $fbb1: 00
            brk                ; $fbb2: 00
            brk                ; $fbb3: 00
            brk                ; $fbb4: 00
            brk                ; $fbb5: 00
            brk                ; $fbb6: 00
            brk                ; $fbb7: 00
            brk                ; $fbb8: 00
            brk                ; $fbb9: 00
            brk                ; $fbba: 00
            brk                ; $fbbb: 00
            brk                ; $fbbc: 00
            brk                ; $fbbd: 00
            brk                ; $fbbe: 00
            brk                ; $fbbf: 00
            brk                ; $fbc0: 00
            brk                ; $fbc1: 00
            brk                ; $fbc2: 00
            brk                ; $fbc3: 00
            brk                ; $fbc4: 00
            brk                ; $fbc5: 00
            brk                ; $fbc6: 00
            brk                ; $fbc7: 00
            brk                ; $fbc8: 00
            brk                ; $fbc9: 00
            brk                ; $fbca: 00
            brk                ; $fbcb: 00
            brk                ; $fbcc: 00
            brk                ; $fbcd: 00
            brk                ; $fbce: 00
            brk                ; $fbcf: 00
            brk                ; $fbd0: 00
            brk                ; $fbd1: 00
            brk                ; $fbd2: 00
            brk                ; $fbd3: 00
            brk                ; $fbd4: 00
            brk                ; $fbd5: 00
            brk                ; $fbd6: 00
            brk                ; $fbd7: 00
            brk                ; $fbd8: 00
            brk                ; $fbd9: 00
            brk                ; $fbda: 00
            brk                ; $fbdb: 00
            brk                ; $fbdc: 00
            brk                ; $fbdd: 00
            brk                ; $fbde: 00
            brk                ; $fbdf: 00
            brk                ; $fbe0: 00
            brk                ; $fbe1: 00
            brk                ; $fbe2: 00
            brk                ; $fbe3: 00
            brk                ; $fbe4: 00
            brk                ; $fbe5: 00
            brk                ; $fbe6: 00
            brk                ; $fbe7: 00
            brk                ; $fbe8: 00
            brk                ; $fbe9: 00
            brk                ; $fbea: 00
            brk                ; $fbeb: 00
            brk                ; $fbec: 00
            brk                ; $fbed: 00
            brk                ; $fbee: 00
            brk                ; $fbef: 00
            brk                ; $fbf0: 00
            brk                ; $fbf1: 00
            brk                ; $fbf2: 00
            brk                ; $fbf3: 00
            brk                ; $fbf4: 00
            brk                ; $fbf5: 00
            brk                ; $fbf6: 00
            brk                ; $fbf7: 00
            brk                ; $fbf8: 00
            brk                ; $fbf9: 00
            brk                ; $fbfa: 00
            brk                ; $fbfb: 00
            brk                ; $fbfc: 00
            brk                ; $fbfd: 00
            brk                ; $fbfe: 00
            brk                ; $fbff: 00
            brk                ; $fc00: 00
__fc01:     brk                ; $fc01: 00
            brk                ; $fc02: 00
            brk                ; $fc03: 00
            brk                ; $fc04: 00
            brk                ; $fc05: 00
            brk                ; $fc06: 00
            brk                ; $fc07: 00
            brk                ; $fc08: 00
            brk                ; $fc09: 00
            brk                ; $fc0a: 00
            brk                ; $fc0b: 00
            brk                ; $fc0c: 00
            brk                ; $fc0d: 00
            brk                ; $fc0e: 00
            brk                ; $fc0f: 00
            brk                ; $fc10: 00
            brk                ; $fc11: 00
            brk                ; $fc12: 00
            brk                ; $fc13: 00
            brk                ; $fc14: 00
            brk                ; $fc15: 00
            brk                ; $fc16: 00
            brk                ; $fc17: 00
            brk                ; $fc18: 00
            brk                ; $fc19: 00
            brk                ; $fc1a: 00
            brk                ; $fc1b: 00
            brk                ; $fc1c: 00
            brk                ; $fc1d: 00
            brk                ; $fc1e: 00
            brk                ; $fc1f: 00
            brk                ; $fc20: 00
            brk                ; $fc21: 00
            brk                ; $fc22: 00
            brk                ; $fc23: 00
            brk                ; $fc24: 00
            brk                ; $fc25: 00
            brk                ; $fc26: 00
            brk                ; $fc27: 00
            brk                ; $fc28: 00
            brk                ; $fc29: 00
            brk                ; $fc2a: 00
            brk                ; $fc2b: 00
            brk                ; $fc2c: 00
            brk                ; $fc2d: 00
            brk                ; $fc2e: 00
            brk                ; $fc2f: 00
            brk                ; $fc30: 00
            brk                ; $fc31: 00
            brk                ; $fc32: 00
            brk                ; $fc33: 00
            brk                ; $fc34: 00
            brk                ; $fc35: 00
            brk                ; $fc36: 00
            brk                ; $fc37: 00
            brk                ; $fc38: 00
            brk                ; $fc39: 00
            brk                ; $fc3a: 00
            brk                ; $fc3b: 00
            brk                ; $fc3c: 00
            brk                ; $fc3d: 00
            brk                ; $fc3e: 00
            brk                ; $fc3f: 00
            brk                ; $fc40: 00
            brk                ; $fc41: 00
            brk                ; $fc42: 00
            brk                ; $fc43: 00
            brk                ; $fc44: 00
            brk                ; $fc45: 00
            brk                ; $fc46: 00
            brk                ; $fc47: 00
            brk                ; $fc48: 00
            brk                ; $fc49: 00
            brk                ; $fc4a: 00
            brk                ; $fc4b: 00
            brk                ; $fc4c: 00
            brk                ; $fc4d: 00
            brk                ; $fc4e: 00
            brk                ; $fc4f: 00
            brk                ; $fc50: 00
            brk                ; $fc51: 00
            brk                ; $fc52: 00
            brk                ; $fc53: 00
            brk                ; $fc54: 00
            brk                ; $fc55: 00
            brk                ; $fc56: 00
            brk                ; $fc57: 00
            brk                ; $fc58: 00
            brk                ; $fc59: 00
            brk                ; $fc5a: 00
            brk                ; $fc5b: 00
            brk                ; $fc5c: 00
            brk                ; $fc5d: 00
            brk                ; $fc5e: 00
            brk                ; $fc5f: 00
            brk                ; $fc60: 00
            brk                ; $fc61: 00
            brk                ; $fc62: 00
            brk                ; $fc63: 00
            brk                ; $fc64: 00
            brk                ; $fc65: 00
            brk                ; $fc66: 00
            brk                ; $fc67: 00
            brk                ; $fc68: 00
            brk                ; $fc69: 00
            brk                ; $fc6a: 00
            brk                ; $fc6b: 00
            brk                ; $fc6c: 00
            brk                ; $fc6d: 00
            brk                ; $fc6e: 00
            brk                ; $fc6f: 00
            brk                ; $fc70: 00
            brk                ; $fc71: 00
            brk                ; $fc72: 00
            brk                ; $fc73: 00
            brk                ; $fc74: 00
            brk                ; $fc75: 00
            brk                ; $fc76: 00
            brk                ; $fc77: 00
            brk                ; $fc78: 00
            brk                ; $fc79: 00
            brk                ; $fc7a: 00
            brk                ; $fc7b: 00
            brk                ; $fc7c: 00
            brk                ; $fc7d: 00
            brk                ; $fc7e: 00
            brk                ; $fc7f: 00
            brk                ; $fc80: 00
            brk                ; $fc81: 00
            brk                ; $fc82: 00
            brk                ; $fc83: 00
            brk                ; $fc84: 00
            brk                ; $fc85: 00
            brk                ; $fc86: 00
            brk                ; $fc87: 00
            brk                ; $fc88: 00
            brk                ; $fc89: 00
            brk                ; $fc8a: 00
            brk                ; $fc8b: 00
            brk                ; $fc8c: 00
            brk                ; $fc8d: 00
            brk                ; $fc8e: 00
            brk                ; $fc8f: 00
            brk                ; $fc90: 00
            brk                ; $fc91: 00
            brk                ; $fc92: 00
            brk                ; $fc93: 00
            brk                ; $fc94: 00
            brk                ; $fc95: 00
            brk                ; $fc96: 00
            brk                ; $fc97: 00
            brk                ; $fc98: 00
            brk                ; $fc99: 00
            brk                ; $fc9a: 00
            brk                ; $fc9b: 00
            brk                ; $fc9c: 00
            brk                ; $fc9d: 00
            brk                ; $fc9e: 00
            brk                ; $fc9f: 00
            brk                ; $fca0: 00
            brk                ; $fca1: 00
            brk                ; $fca2: 00
            brk                ; $fca3: 00
            brk                ; $fca4: 00
            brk                ; $fca5: 00
            brk                ; $fca6: 00
            brk                ; $fca7: 00
            brk                ; $fca8: 00
            brk                ; $fca9: 00
            brk                ; $fcaa: 00
            brk                ; $fcab: 00
            brk                ; $fcac: 00
            brk                ; $fcad: 00
            brk                ; $fcae: 00
            brk                ; $fcaf: 00
            brk                ; $fcb0: 00
            brk                ; $fcb1: 00
            brk                ; $fcb2: 00
            brk                ; $fcb3: 00
            brk                ; $fcb4: 00
            brk                ; $fcb5: 00
            brk                ; $fcb6: 00
            brk                ; $fcb7: 00
            brk                ; $fcb8: 00
            brk                ; $fcb9: 00
            brk                ; $fcba: 00
            brk                ; $fcbb: 00
            brk                ; $fcbc: 00
            brk                ; $fcbd: 00
            brk                ; $fcbe: 00
            brk                ; $fcbf: 00
            brk                ; $fcc0: 00
            brk                ; $fcc1: 00
            brk                ; $fcc2: 00
            brk                ; $fcc3: 00
            brk                ; $fcc4: 00
            brk                ; $fcc5: 00
            brk                ; $fcc6: 00
            brk                ; $fcc7: 00
            brk                ; $fcc8: 00
            brk                ; $fcc9: 00
            brk                ; $fcca: 00
            brk                ; $fccb: 00
            brk                ; $fccc: 00
            brk                ; $fccd: 00
            brk                ; $fcce: 00
            brk                ; $fccf: 00
            brk                ; $fcd0: 00
            brk                ; $fcd1: 00
            brk                ; $fcd2: 00
            brk                ; $fcd3: 00
            brk                ; $fcd4: 00
            brk                ; $fcd5: 00
            brk                ; $fcd6: 00
            brk                ; $fcd7: 00
            brk                ; $fcd8: 00
            brk                ; $fcd9: 00
            brk                ; $fcda: 00
            brk                ; $fcdb: 00
            brk                ; $fcdc: 00
            brk                ; $fcdd: 00
            brk                ; $fcde: 00
            brk                ; $fcdf: 00
            brk                ; $fce0: 00
            brk                ; $fce1: 00
            brk                ; $fce2: 00
            brk                ; $fce3: 00
            brk                ; $fce4: 00
            brk                ; $fce5: 00
            brk                ; $fce6: 00
            brk                ; $fce7: 00
            brk                ; $fce8: 00
            brk                ; $fce9: 00
            brk                ; $fcea: 00
            brk                ; $fceb: 00
            brk                ; $fcec: 00
            brk                ; $fced: 00
            brk                ; $fcee: 00
            brk                ; $fcef: 00
            brk                ; $fcf0: 00
            brk                ; $fcf1: 00
            brk                ; $fcf2: 00
            brk                ; $fcf3: 00
            brk                ; $fcf4: 00
            brk                ; $fcf5: 00
            brk                ; $fcf6: 00
            brk                ; $fcf7: 00
            brk                ; $fcf8: 00
            brk                ; $fcf9: 00
            brk                ; $fcfa: 00
            brk                ; $fcfb: 00
            brk                ; $fcfc: 00
            brk                ; $fcfd: 00
            brk                ; $fcfe: 00
            brk                ; $fcff: 00
            brk                ; $fd00: 00
            brk                ; $fd01: 00
            brk                ; $fd02: 00
            brk                ; $fd03: 00
            brk                ; $fd04: 00
            brk                ; $fd05: 00
            brk                ; $fd06: 00
            brk                ; $fd07: 00
            brk                ; $fd08: 00
            brk                ; $fd09: 00
            brk                ; $fd0a: 00
            brk                ; $fd0b: 00
            brk                ; $fd0c: 00
            brk                ; $fd0d: 00
            brk                ; $fd0e: 00
            brk                ; $fd0f: 00
            brk                ; $fd10: 00
            brk                ; $fd11: 00
            brk                ; $fd12: 00
            brk                ; $fd13: 00
            brk                ; $fd14: 00
            brk                ; $fd15: 00
            brk                ; $fd16: 00
            brk                ; $fd17: 00
            brk                ; $fd18: 00
            brk                ; $fd19: 00
            brk                ; $fd1a: 00
            brk                ; $fd1b: 00
            brk                ; $fd1c: 00
            brk                ; $fd1d: 00
            brk                ; $fd1e: 00
            brk                ; $fd1f: 00
            brk                ; $fd20: 00
            brk                ; $fd21: 00
            brk                ; $fd22: 00
            brk                ; $fd23: 00
            brk                ; $fd24: 00
            brk                ; $fd25: 00
            brk                ; $fd26: 00
            brk                ; $fd27: 00
            brk                ; $fd28: 00
            brk                ; $fd29: 00
            brk                ; $fd2a: 00
            brk                ; $fd2b: 00
            brk                ; $fd2c: 00
            brk                ; $fd2d: 00
            brk                ; $fd2e: 00
            brk                ; $fd2f: 00
            brk                ; $fd30: 00
            brk                ; $fd31: 00
            brk                ; $fd32: 00
            brk                ; $fd33: 00
            brk                ; $fd34: 00
            brk                ; $fd35: 00
            brk                ; $fd36: 00
            brk                ; $fd37: 00
            brk                ; $fd38: 00
            brk                ; $fd39: 00
            brk                ; $fd3a: 00
            brk                ; $fd3b: 00
            brk                ; $fd3c: 00
            brk                ; $fd3d: 00
            brk                ; $fd3e: 00
            brk                ; $fd3f: 00
            brk                ; $fd40: 00
            brk                ; $fd41: 00
            brk                ; $fd42: 00
            brk                ; $fd43: 00
            brk                ; $fd44: 00
            brk                ; $fd45: 00
            brk                ; $fd46: 00
            brk                ; $fd47: 00
            brk                ; $fd48: 00
            brk                ; $fd49: 00
            brk                ; $fd4a: 00
            brk                ; $fd4b: 00
            brk                ; $fd4c: 00
            brk                ; $fd4d: 00
            brk                ; $fd4e: 00
            brk                ; $fd4f: 00
            brk                ; $fd50: 00
            brk                ; $fd51: 00
            brk                ; $fd52: 00
            brk                ; $fd53: 00
            brk                ; $fd54: 00
            brk                ; $fd55: 00
            brk                ; $fd56: 00
            brk                ; $fd57: 00
            brk                ; $fd58: 00
            brk                ; $fd59: 00
            brk                ; $fd5a: 00
            brk                ; $fd5b: 00
            brk                ; $fd5c: 00
            brk                ; $fd5d: 00
            brk                ; $fd5e: 00
            brk                ; $fd5f: 00
            brk                ; $fd60: 00
            brk                ; $fd61: 00
            brk                ; $fd62: 00
            brk                ; $fd63: 00
            brk                ; $fd64: 00
            brk                ; $fd65: 00
            brk                ; $fd66: 00
            brk                ; $fd67: 00
            brk                ; $fd68: 00
            brk                ; $fd69: 00
            brk                ; $fd6a: 00
            brk                ; $fd6b: 00
            brk                ; $fd6c: 00
            brk                ; $fd6d: 00
            brk                ; $fd6e: 00
            brk                ; $fd6f: 00
            brk                ; $fd70: 00
            brk                ; $fd71: 00
            brk                ; $fd72: 00
            brk                ; $fd73: 00
            brk                ; $fd74: 00
            brk                ; $fd75: 00
            brk                ; $fd76: 00
            brk                ; $fd77: 00
            brk                ; $fd78: 00
            brk                ; $fd79: 00
            brk                ; $fd7a: 00
            brk                ; $fd7b: 00
            brk                ; $fd7c: 00
            brk                ; $fd7d: 00
            brk                ; $fd7e: 00
            brk                ; $fd7f: 00
            brk                ; $fd80: 00
            brk                ; $fd81: 00
            brk                ; $fd82: 00
            brk                ; $fd83: 00
            brk                ; $fd84: 00
            brk                ; $fd85: 00
            brk                ; $fd86: 00
            brk                ; $fd87: 00
            brk                ; $fd88: 00
            brk                ; $fd89: 00
            brk                ; $fd8a: 00
            brk                ; $fd8b: 00
            brk                ; $fd8c: 00
            brk                ; $fd8d: 00
            brk                ; $fd8e: 00
            brk                ; $fd8f: 00
            brk                ; $fd90: 00
            brk                ; $fd91: 00
            brk                ; $fd92: 00
            brk                ; $fd93: 00
            brk                ; $fd94: 00
            brk                ; $fd95: 00
            brk                ; $fd96: 00
            brk                ; $fd97: 00
            brk                ; $fd98: 00
            brk                ; $fd99: 00
            brk                ; $fd9a: 00
            brk                ; $fd9b: 00
            brk                ; $fd9c: 00
            brk                ; $fd9d: 00
            brk                ; $fd9e: 00
            brk                ; $fd9f: 00
            brk                ; $fda0: 00
            brk                ; $fda1: 00
            brk                ; $fda2: 00
            brk                ; $fda3: 00
            brk                ; $fda4: 00
            brk                ; $fda5: 00
            brk                ; $fda6: 00
            brk                ; $fda7: 00
            brk                ; $fda8: 00
            brk                ; $fda9: 00
            brk                ; $fdaa: 00
            brk                ; $fdab: 00
            brk                ; $fdac: 00
            brk                ; $fdad: 00
            brk                ; $fdae: 00
            brk                ; $fdaf: 00
            brk                ; $fdb0: 00
            brk                ; $fdb1: 00
            brk                ; $fdb2: 00
            brk                ; $fdb3: 00
            brk                ; $fdb4: 00
            brk                ; $fdb5: 00
            brk                ; $fdb6: 00
            brk                ; $fdb7: 00
            brk                ; $fdb8: 00
            brk                ; $fdb9: 00
            brk                ; $fdba: 00
            brk                ; $fdbb: 00
            brk                ; $fdbc: 00
            brk                ; $fdbd: 00
            brk                ; $fdbe: 00
            brk                ; $fdbf: 00
            brk                ; $fdc0: 00
            brk                ; $fdc1: 00
            brk                ; $fdc2: 00
            brk                ; $fdc3: 00
            brk                ; $fdc4: 00
            brk                ; $fdc5: 00
            brk                ; $fdc6: 00
            brk                ; $fdc7: 00
            brk                ; $fdc8: 00
            brk                ; $fdc9: 00
            brk                ; $fdca: 00
            brk                ; $fdcb: 00
            brk                ; $fdcc: 00
            brk                ; $fdcd: 00
            brk                ; $fdce: 00
            brk                ; $fdcf: 00
            brk                ; $fdd0: 00
            brk                ; $fdd1: 00
            brk                ; $fdd2: 00
            brk                ; $fdd3: 00
            brk                ; $fdd4: 00
            brk                ; $fdd5: 00
            brk                ; $fdd6: 00
            brk                ; $fdd7: 00
            brk                ; $fdd8: 00
            brk                ; $fdd9: 00
            brk                ; $fdda: 00
            brk                ; $fddb: 00
            brk                ; $fddc: 00
            brk                ; $fddd: 00
            brk                ; $fdde: 00
            brk                ; $fddf: 00
            brk                ; $fde0: 00
            brk                ; $fde1: 00
            brk                ; $fde2: 00
            brk                ; $fde3: 00
            brk                ; $fde4: 00
            brk                ; $fde5: 00
            brk                ; $fde6: 00
            brk                ; $fde7: 00
            brk                ; $fde8: 00
            brk                ; $fde9: 00
            brk                ; $fdea: 00
            brk                ; $fdeb: 00
            brk                ; $fdec: 00
            brk                ; $fded: 00
            brk                ; $fdee: 00
            brk                ; $fdef: 00
            brk                ; $fdf0: 00
            brk                ; $fdf1: 00
            brk                ; $fdf2: 00
            brk                ; $fdf3: 00
            brk                ; $fdf4: 00
            brk                ; $fdf5: 00
            brk                ; $fdf6: 00
            brk                ; $fdf7: 00
            brk                ; $fdf8: 00
            brk                ; $fdf9: 00
            brk                ; $fdfa: 00
            brk                ; $fdfb: 00
            brk                ; $fdfc: 00
            brk                ; $fdfd: 00
            brk                ; $fdfe: 00
            brk                ; $fdff: 00
            brk                ; $fe00: 00
            brk                ; $fe01: 00
            brk                ; $fe02: 00
            brk                ; $fe03: 00
            brk                ; $fe04: 00
            brk                ; $fe05: 00
            brk                ; $fe06: 00
            brk                ; $fe07: 00
            brk                ; $fe08: 00
            brk                ; $fe09: 00
            brk                ; $fe0a: 00
            brk                ; $fe0b: 00
            brk                ; $fe0c: 00
            brk                ; $fe0d: 00
            brk                ; $fe0e: 00
            brk                ; $fe0f: 00
            brk                ; $fe10: 00
            brk                ; $fe11: 00
            brk                ; $fe12: 00
            brk                ; $fe13: 00
            brk                ; $fe14: 00
            brk                ; $fe15: 00
            brk                ; $fe16: 00
            brk                ; $fe17: 00
            brk                ; $fe18: 00
            brk                ; $fe19: 00
            brk                ; $fe1a: 00
            brk                ; $fe1b: 00
            brk                ; $fe1c: 00
            brk                ; $fe1d: 00
            brk                ; $fe1e: 00
            brk                ; $fe1f: 00
            brk                ; $fe20: 00
            brk                ; $fe21: 00
            brk                ; $fe22: 00
            brk                ; $fe23: 00
            brk                ; $fe24: 00
            brk                ; $fe25: 00
            brk                ; $fe26: 00
            brk                ; $fe27: 00
            brk                ; $fe28: 00
            brk                ; $fe29: 00
            brk                ; $fe2a: 00
            brk                ; $fe2b: 00
            brk                ; $fe2c: 00
            brk                ; $fe2d: 00
            brk                ; $fe2e: 00
            brk                ; $fe2f: 00
            brk                ; $fe30: 00
            brk                ; $fe31: 00
            brk                ; $fe32: 00
            brk                ; $fe33: 00
            brk                ; $fe34: 00
            brk                ; $fe35: 00
            brk                ; $fe36: 00
            brk                ; $fe37: 00
            brk                ; $fe38: 00
            brk                ; $fe39: 00
            brk                ; $fe3a: 00
            brk                ; $fe3b: 00
            brk                ; $fe3c: 00
            brk                ; $fe3d: 00
            brk                ; $fe3e: 00
            brk                ; $fe3f: 00
            brk                ; $fe40: 00
            brk                ; $fe41: 00
            brk                ; $fe42: 00
            brk                ; $fe43: 00
            brk                ; $fe44: 00
            brk                ; $fe45: 00
            brk                ; $fe46: 00
            brk                ; $fe47: 00
            brk                ; $fe48: 00
            brk                ; $fe49: 00
            brk                ; $fe4a: 00
            brk                ; $fe4b: 00
            brk                ; $fe4c: 00
            brk                ; $fe4d: 00
            brk                ; $fe4e: 00
            brk                ; $fe4f: 00
            brk                ; $fe50: 00
            brk                ; $fe51: 00
            brk                ; $fe52: 00
            brk                ; $fe53: 00
            brk                ; $fe54: 00
            brk                ; $fe55: 00
            brk                ; $fe56: 00
            brk                ; $fe57: 00
            brk                ; $fe58: 00
            brk                ; $fe59: 00
            brk                ; $fe5a: 00
            brk                ; $fe5b: 00
            brk                ; $fe5c: 00
            brk                ; $fe5d: 00
            brk                ; $fe5e: 00
            brk                ; $fe5f: 00
            brk                ; $fe60: 00
            brk                ; $fe61: 00
            brk                ; $fe62: 00
            brk                ; $fe63: 00
            brk                ; $fe64: 00
            brk                ; $fe65: 00
            brk                ; $fe66: 00
            brk                ; $fe67: 00
            brk                ; $fe68: 00
            brk                ; $fe69: 00
            brk                ; $fe6a: 00
            brk                ; $fe6b: 00
            brk                ; $fe6c: 00
            brk                ; $fe6d: 00
            brk                ; $fe6e: 00
            brk                ; $fe6f: 00
            brk                ; $fe70: 00
            brk                ; $fe71: 00
            brk                ; $fe72: 00
            brk                ; $fe73: 00
            brk                ; $fe74: 00
            brk                ; $fe75: 00
            brk                ; $fe76: 00
            brk                ; $fe77: 00
            brk                ; $fe78: 00
            brk                ; $fe79: 00
            brk                ; $fe7a: 00
            brk                ; $fe7b: 00
            brk                ; $fe7c: 00
            brk                ; $fe7d: 00
            brk                ; $fe7e: 00
            brk                ; $fe7f: 00
            brk                ; $fe80: 00
            brk                ; $fe81: 00
            brk                ; $fe82: 00
            brk                ; $fe83: 00
            brk                ; $fe84: 00
            brk                ; $fe85: 00
            brk                ; $fe86: 00
            brk                ; $fe87: 00
            brk                ; $fe88: 00
            brk                ; $fe89: 00
            brk                ; $fe8a: 00
            brk                ; $fe8b: 00
            brk                ; $fe8c: 00
            brk                ; $fe8d: 00
            brk                ; $fe8e: 00
            brk                ; $fe8f: 00
            brk                ; $fe90: 00
            brk                ; $fe91: 00
            brk                ; $fe92: 00
            brk                ; $fe93: 00
            brk                ; $fe94: 00
            brk                ; $fe95: 00
            brk                ; $fe96: 00
            brk                ; $fe97: 00
            brk                ; $fe98: 00
            brk                ; $fe99: 00
            brk                ; $fe9a: 00
            brk                ; $fe9b: 00
            brk                ; $fe9c: 00
            brk                ; $fe9d: 00
            brk                ; $fe9e: 00
            brk                ; $fe9f: 00
            brk                ; $fea0: 00
            brk                ; $fea1: 00
            brk                ; $fea2: 00
            brk                ; $fea3: 00
            brk                ; $fea4: 00
            brk                ; $fea5: 00
            brk                ; $fea6: 00
            brk                ; $fea7: 00
            brk                ; $fea8: 00
            brk                ; $fea9: 00
            brk                ; $feaa: 00
            brk                ; $feab: 00
            brk                ; $feac: 00
            brk                ; $fead: 00
            brk                ; $feae: 00
            brk                ; $feaf: 00
            brk                ; $feb0: 00
            brk                ; $feb1: 00
            brk                ; $feb2: 00
            brk                ; $feb3: 00
            brk                ; $feb4: 00
            brk                ; $feb5: 00
            brk                ; $feb6: 00
            brk                ; $feb7: 00
            brk                ; $feb8: 00
            brk                ; $feb9: 00
            brk                ; $feba: 00
            brk                ; $febb: 00
            brk                ; $febc: 00
            brk                ; $febd: 00
            brk                ; $febe: 00
            brk                ; $febf: 00
            brk                ; $fec0: 00
            brk                ; $fec1: 00
            brk                ; $fec2: 00
            brk                ; $fec3: 00
            brk                ; $fec4: 00
            brk                ; $fec5: 00
            brk                ; $fec6: 00
            brk                ; $fec7: 00
            brk                ; $fec8: 00
            brk                ; $fec9: 00
            brk                ; $feca: 00
            brk                ; $fecb: 00
            brk                ; $fecc: 00
            brk                ; $fecd: 00
            brk                ; $fece: 00
            brk                ; $fecf: 00
            brk                ; $fed0: 00
            brk                ; $fed1: 00
            brk                ; $fed2: 00
            brk                ; $fed3: 00
            brk                ; $fed4: 00
            brk                ; $fed5: 00
            brk                ; $fed6: 00
            brk                ; $fed7: 00
            brk                ; $fed8: 00
            brk                ; $fed9: 00
            brk                ; $feda: 00
            brk                ; $fedb: 00
            brk                ; $fedc: 00
            brk                ; $fedd: 00
            brk                ; $fede: 00
            brk                ; $fedf: 00
            brk                ; $fee0: 00
            brk                ; $fee1: 00
            brk                ; $fee2: 00
            brk                ; $fee3: 00
            brk                ; $fee4: 00
            brk                ; $fee5: 00
            brk                ; $fee6: 00
            brk                ; $fee7: 00
            brk                ; $fee8: 00
            brk                ; $fee9: 00
            brk                ; $feea: 00
            brk                ; $feeb: 00
            brk                ; $feec: 00
            brk                ; $feed: 00
            brk                ; $feee: 00
            brk                ; $feef: 00
            brk                ; $fef0: 00
            brk                ; $fef1: 00
            brk                ; $fef2: 00
            brk                ; $fef3: 00
            brk                ; $fef4: 00
            brk                ; $fef5: 00
            brk                ; $fef6: 00
            brk                ; $fef7: 00
            brk                ; $fef8: 00
            brk                ; $fef9: 00
            brk                ; $fefa: 00
            brk                ; $fefb: 00
            brk                ; $fefc: 00
            brk                ; $fefd: 00
            brk                ; $fefe: 00
            brk                ; $feff: 00
            brk                ; $ff00: 00
            brk                ; $ff01: 00
            brk                ; $ff02: 00
            brk                ; $ff03: 00
            brk                ; $ff04: 00
            brk                ; $ff05: 00
            brk                ; $ff06: 00
            brk                ; $ff07: 00
            brk                ; $ff08: 00
            brk                ; $ff09: 00
            brk                ; $ff0a: 00
            brk                ; $ff0b: 00
            brk                ; $ff0c: 00
            brk                ; $ff0d: 00
            brk                ; $ff0e: 00
            brk                ; $ff0f: 00
            brk                ; $ff10: 00
            brk                ; $ff11: 00
            brk                ; $ff12: 00
            brk                ; $ff13: 00
            brk                ; $ff14: 00
            brk                ; $ff15: 00
            brk                ; $ff16: 00
            brk                ; $ff17: 00
            brk                ; $ff18: 00
            brk                ; $ff19: 00
            brk                ; $ff1a: 00
            brk                ; $ff1b: 00
            brk                ; $ff1c: 00
            brk                ; $ff1d: 00
            brk                ; $ff1e: 00
            brk                ; $ff1f: 00
            brk                ; $ff20: 00
            brk                ; $ff21: 00
            brk                ; $ff22: 00
            brk                ; $ff23: 00
            brk                ; $ff24: 00
            brk                ; $ff25: 00
            brk                ; $ff26: 00
            brk                ; $ff27: 00
            brk                ; $ff28: 00
            brk                ; $ff29: 00
            brk                ; $ff2a: 00
            brk                ; $ff2b: 00
            brk                ; $ff2c: 00
            brk                ; $ff2d: 00
            brk                ; $ff2e: 00
            brk                ; $ff2f: 00
            brk                ; $ff30: 00
            brk                ; $ff31: 00
            brk                ; $ff32: 00
            brk                ; $ff33: 00
            brk                ; $ff34: 00
            brk                ; $ff35: 00
            brk                ; $ff36: 00
            brk                ; $ff37: 00
            brk                ; $ff38: 00
            brk                ; $ff39: 00
            brk                ; $ff3a: 00
            brk                ; $ff3b: 00
            brk                ; $ff3c: 00
            brk                ; $ff3d: 00
            brk                ; $ff3e: 00
            brk                ; $ff3f: 00
            brk                ; $ff40: 00
            brk                ; $ff41: 00
            brk                ; $ff42: 00
            brk                ; $ff43: 00
            brk                ; $ff44: 00
            brk                ; $ff45: 00
            brk                ; $ff46: 00
            brk                ; $ff47: 00
            brk                ; $ff48: 00
            brk                ; $ff49: 00
            brk                ; $ff4a: 00
            brk                ; $ff4b: 00
            brk                ; $ff4c: 00
            brk                ; $ff4d: 00
            brk                ; $ff4e: 00
            brk                ; $ff4f: 00
            brk                ; $ff50: 00
            brk                ; $ff51: 00
            brk                ; $ff52: 00
            brk                ; $ff53: 00
            brk                ; $ff54: 00
            brk                ; $ff55: 00
            brk                ; $ff56: 00
            brk                ; $ff57: 00
            brk                ; $ff58: 00
            brk                ; $ff59: 00
            brk                ; $ff5a: 00
            brk                ; $ff5b: 00
            brk                ; $ff5c: 00
            brk                ; $ff5d: 00
            brk                ; $ff5e: 00
            brk                ; $ff5f: 00
            brk                ; $ff60: 00
            brk                ; $ff61: 00
            brk                ; $ff62: 00
            brk                ; $ff63: 00
            brk                ; $ff64: 00
            brk                ; $ff65: 00
            brk                ; $ff66: 00
            brk                ; $ff67: 00
            brk                ; $ff68: 00
            brk                ; $ff69: 00
            brk                ; $ff6a: 00
            brk                ; $ff6b: 00
            brk                ; $ff6c: 00
            brk                ; $ff6d: 00
            brk                ; $ff6e: 00
            brk                ; $ff6f: 00
            brk                ; $ff70: 00
            brk                ; $ff71: 00
            brk                ; $ff72: 00
            brk                ; $ff73: 00
            brk                ; $ff74: 00
            brk                ; $ff75: 00
            brk                ; $ff76: 00
            brk                ; $ff77: 00
            brk                ; $ff78: 00
            brk                ; $ff79: 00
            brk                ; $ff7a: 00
            brk                ; $ff7b: 00
            brk                ; $ff7c: 00
            brk                ; $ff7d: 00
            brk                ; $ff7e: 00
            brk                ; $ff7f: 00
            brk                ; $ff80: 00
            brk                ; $ff81: 00
            brk                ; $ff82: 00
            brk                ; $ff83: 00
            brk                ; $ff84: 00
            brk                ; $ff85: 00
            brk                ; $ff86: 00
            brk                ; $ff87: 00
            brk                ; $ff88: 00
            brk                ; $ff89: 00
            brk                ; $ff8a: 00
            brk                ; $ff8b: 00
            brk                ; $ff8c: 00
            brk                ; $ff8d: 00
            brk                ; $ff8e: 00
            brk                ; $ff8f: 00
            brk                ; $ff90: 00
            brk                ; $ff91: 00
            brk                ; $ff92: 00
            brk                ; $ff93: 00
            brk                ; $ff94: 00
            brk                ; $ff95: 00
            brk                ; $ff96: 00
            brk                ; $ff97: 00
            brk                ; $ff98: 00
            brk                ; $ff99: 00
            brk                ; $ff9a: 00
            brk                ; $ff9b: 00
            brk                ; $ff9c: 00
            brk                ; $ff9d: 00
            brk                ; $ff9e: 00
            brk                ; $ff9f: 00
            brk                ; $ffa0: 00
            brk                ; $ffa1: 00
            brk                ; $ffa2: 00
            brk                ; $ffa3: 00
            brk                ; $ffa4: 00
            brk                ; $ffa5: 00
            brk                ; $ffa6: 00
            brk                ; $ffa7: 00
            brk                ; $ffa8: 00
            brk                ; $ffa9: 00
            brk                ; $ffaa: 00
            brk                ; $ffab: 00
            brk                ; $ffac: 00
            brk                ; $ffad: 00
            brk                ; $ffae: 00
            brk                ; $ffaf: 00
            brk                ; $ffb0: 00
            brk                ; $ffb1: 00
            brk                ; $ffb2: 00
            brk                ; $ffb3: 00
            brk                ; $ffb4: 00
            brk                ; $ffb5: 00
            brk                ; $ffb6: 00
            brk                ; $ffb7: 00
            brk                ; $ffb8: 00
            brk                ; $ffb9: 00
            brk                ; $ffba: 00
            brk                ; $ffbb: 00
            brk                ; $ffbc: 00
            brk                ; $ffbd: 00
            brk                ; $ffbe: 00
            brk                ; $ffbf: 00
            brk                ; $ffc0: 00
            brk                ; $ffc1: 00
            brk                ; $ffc2: 00
            brk                ; $ffc3: 00
            brk                ; $ffc4: 00
            brk                ; $ffc5: 00
            brk                ; $ffc6: 00
            brk                ; $ffc7: 00
            brk                ; $ffc8: 00
            brk                ; $ffc9: 00
            brk                ; $ffca: 00
            brk                ; $ffcb: 00
            brk                ; $ffcc: 00
            brk                ; $ffcd: 00
            brk                ; $ffce: 00
            brk                ; $ffcf: 00
            brk                ; $ffd0: 00
            brk                ; $ffd1: 00
            brk                ; $ffd2: 00
            brk                ; $ffd3: 00
            brk                ; $ffd4: 00
            brk                ; $ffd5: 00
            brk                ; $ffd6: 00
            brk                ; $ffd7: 00
            brk                ; $ffd8: 00
            brk                ; $ffd9: 00
            brk                ; $ffda: 00
            brk                ; $ffdb: 00
            brk                ; $ffdc: 00
            brk                ; $ffdd: 00
            brk                ; $ffde: 00
            brk                ; $ffdf: 00
            brk                ; $ffe0: 00
            brk                ; $ffe1: 00
            brk                ; $ffe2: 00
            brk                ; $ffe3: 00
            brk                ; $ffe4: 00
            brk                ; $ffe5: 00
            brk                ; $ffe6: 00
            brk                ; $ffe7: 00
            brk                ; $ffe8: 00
            brk                ; $ffe9: 00
            brk                ; $ffea: 00
            brk                ; $ffeb: 00
            brk                ; $ffec: 00
            brk                ; $ffed: 00
            brk                ; $ffee: 00
            brk                ; $ffef: 00
            brk                ; $fff0: 00
            brk                ; $fff1: 00
            brk                ; $fff2: 00
            brk                ; $fff3: 00
            brk                ; $fff4: 00
            brk                ; $fff5: 00
            brk                ; $fff6: 00
            brk                ; $fff7: 00
            brk                ; $fff8: 00
            brk                ; $fff9: 00

;-------------------------------------------------------------------------------
; Vector Table
;-------------------------------------------------------------------------------
vectors:    .dw nmi                        ; $fffa: 2c c0     Vector table
            .dw reset                      ; $fffc: 00 c0     Vector table
            .dw irq                        ; $fffe: 45 c0     Vector table

;-------------------------------------------------------------------------------
; CHR-ROM
;-------------------------------------------------------------------------------
            .incbin tokumaru_raycaster_01.chr ; Include CHR-ROM
