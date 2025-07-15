; PRG CRC32 checksum: 8b241428
; CHR CRC32 checksum: 00000000
; Overall CRC32 checksum: 8b241428
; Code base address: $c000
.include "nes.inc"
.include "macros.inc"
APU_DMC_FREQ = $4010
APU_FRAME = $4017
PPU_ADDR = $2006
PPU_CTRL = $2000
PPU_DATA = $2007

.setcpu "6502x"

.segment "VECTORS"

.addr NMI, Reset, IRQ

.segment "HEADER"
.byte 'N', 'E', 'S', $1a      ; "NES" followed by MS-DOS EOF marker
.byte $02                     ; 2 x 16KB PRG-ROM banks
.byte $01                     ; 1 x 8KB CHR-ROM bank
.byte $00, $00                ; Mapper 0, no special features


; Startup code runs first when the NES boots
; This segment is typically placed at the beginning of the ROM

; Zero page variables - these are the variables defined above
; They get placed in the zero page for faster access




.segment "ZEROPAGE"
_var_0000 = $0000
_var_0001 = $0001
_var_0002 = $0002
_var_0003 = $0003
nmi_flag = $0010
nmi_vector_lo = $0011
nmi_vector_hi = $0012
joypad1_state = $0013
joypad2_state = $0014
joypad1_mask = $0015
joypad2_mask = $0016
scroll_x = $0017
scroll_y = $0018
tile_id_lo = $0019
tile_id_hi = $001A
ppu_buffer = $001B
camera_x = $001D
camera_y = $001E
camera_x2 = $001F
camera_y2 = $0020
camera_angle = $0021
clip_plane_0 = $0022
clip_plane_1 = $0023
clip_plane_2 = $0024
temp_a = $0025
temp_b = $0026
temp_c = $0027
ppu_addr_temp = $0028
poly_index_a = $0029
poly_index_b = $002A
poly_draw_index = $002B
frame_counter = $002D
polygon_index = $002E
polygon_flags = $0030
vertex_ptr = $0038
vertex_ptr_hi = $0039
vertex_index_a = $003A
vertex_index_b = $003B
vertex_a_x = $003C
vertex_a_y = $003D
vertex_b_x = $003E
vertex_b_y = $003F
edge_a_dx = $0040
edge_a_dy = $0041
edge_b_dx = $0042
edge_b_dy = $0043
edge_a_sign = $0044
edge_b_sign = $0045
edge_a_mask = $0046
edge_b_mask = $0047
bresenham_a = $0048
bresenham_a_count = $0049
bresenham_b_count = $004A
bresenham_a_mask = $004B
bresenham_b_mask = $004C
bresenham_a_x = $004D
bresenham_a_y = $004E
bresenham_b_x = $004F
bresenham_b_y = $0050
temp_x = $0051
temp_y = $0052
temp_x2 = $0053
temp_y2 = $0054
scanline_a = $0055
scanline_b = $0056
column_ptr = $0057
column_ptr_hi = $0058
column_flags = $0059
column_a = $005A
column_b = $005B
column_index_a = $005C
column_index_b = $005D
column_count = $005E
column_skip = $005F
column_loop = $0060
column_temp = $0061
poly_x_buffer = $0100
poly_y_buffer = $011C
polygon_visible = $0138
polygon_type = $0139
screen_column = $0154
lookup_table_a = $0300
lookup_table_b = $0301
lookup_table_c = $0380
lookup_table_d = $0381
framebuffer_a = $0400
framebuffer_a_1 = $0401
framebuffer_a_2 = $0402
framebuffer_a_3 = $0403
framebuffer_a_4 = $0404
framebuffer_a_5 = $0405
framebuffer_a_6 = $0406
framebuffer_a_7 = $0407
framebuffer_b = $0480
framebuffer_b_1 = $0481
framebuffer_b_2 = $0482
framebuffer_b_3 = $0483
framebuffer_b_4 = $0484
framebuffer_b_5 = $0485
framebuffer_b_6 = $0486
framebuffer_b_7 = $0487



.segment "STARTUP"
; Startup code runs first when the NES boots
; This segment is typically placed at the beginning of the ROM


Reset:
  sei                            ; $C000  78
  cld                            ; $C001  D8
  ldx #$00                       ; $C002  A2 00
  stx PPU_CTRL                   ; $C004  8E 00 20
  stx PPU_MASK                   ; $C007  8E 01 20
  dex                            ; $C00A  CA
  txs                            ; $C00B  9A
  lda #$40                       ; $C00C  A9 40
  sta APU_FRAME                  ; $C00E  8D 17 40
  lda #$00                       ; $C011  A9 00
  sta APU_DMC_FREQ               ; $C013  8D 10 40
  bit PPU_STATUS                 ; $C016  2C 02 20

_label_c019:
  bit PPU_STATUS                 ; $C019  2C 02 20
  bpl _label_c019                ; $C01C  10 FB

_label_c01e:
  bit PPU_STATUS                 ; $C01E  2C 02 20
  bpl _label_c01e                ; $C021  10 FB
  jsr _func_c046                 ; $C023  20 46 C0
  jsr _func_c047                 ; $C026  20 47 C0
  jmp _label_c25b                ; $C029  4C 5B C2

.segment "CODE"
Reset2:
  sei                            ; $C000  78
  cld                            ; $C001  D8
  ldx #$00                       ; $C002  A2 00
  stx PPU_CTRL                   ; $C004  8E 00 20
  stx PPU_MASK                   ; $C007  8E 01 20
  dex                            ; $C00A  CA
  txs                            ; $C00B  9A
  lda #$40                       ; $C00C  A9 40
  sta APU_FRAME                  ; $C00E  8D 17 40
  lda #$00                       ; $C011  A9 00
  sta APU_DMC_FREQ               ; $C013  8D 10 40
  bit PPU_STATUS                 ; $C016  2C 02 20

_label_c0192:
  bit PPU_STATUS                 ; $C019  2C 02 20
  bpl _label_c0192                ; $C01C  10 FB

_label_c01e2:
  bit PPU_STATUS                 ; $C01E  2C 02 20
  bpl _label_c01e2                ; $C021  10 FB
  jsr _func_c046                 ; $C023  20 46 C0
  jsr _func_c047                 ; $C026  20 47 C0
  jmp _label_c25b                ; $C029  4C 5B C2

NMI:                             ; jump engine detected
  bit nmi_flag                  ; $C02C  24 10
  bmi _label_c037                ; $C02E  30 07
  bit nmi_vector_hi                  ; $C030  24 12
  bpl _label_c03a                ; $C032  10 06
  jmp (nmi_vector_lo)                ; $C034  6C 11 00

_label_c037:
  inc nmi_flag                  ; $C037  E6 10
  rti                            ; $C039  40

_label_c03a:
  pha                            ; $C03A  48
  txa                            ; $C03B  8A
  pha                            ; $C03C  48
  tya                            ; $C03D  98
  pha                            ; $C03E  48
  pla                            ; $C03F  68
  tay                            ; $C040  A8
  pla                            ; $C041  68
  tax                            ; $C042  AA
  pla                            ; $C043  68
  rti                            ; $C044  40

IRQ:
  rti                            ; $C045  40

_func_c046:
  rts                            ; $C046  60

_func_c047:
  lda #$00                       ; $C047  A9 00
  sta nmi_flag                  ; $C049  85 10
  sta nmi_vector_hi                  ; $C04B  85 12
  ldx #$00                       ; $C04D  A2 00
  stx scroll_y                  ; $C04F  86 18
  stx scroll_x                  ; $C051  86 17
  lda _data_cde6_indexed,X       ; $C053  BD E6 CD
  and #$0F                       ; $C056  29 0F
  sta tile_id_lo                  ; $C058  85 19
  lda _data_cde6_indexed,X       ; $C05A  BD E6 CD
  and #$F0                       ; $C05D  29 F0
  sta tile_id_hi                  ; $C05F  85 1A
  lda #$A8                       ; $C061  A9 A8
  sta PPU_CTRL                   ; $C063  8D 00 20
  lda #$06                       ; $C066  A9 06
  sta PPU_MASK                   ; $C068  8D 01 20
  rts                            ; $C06B  60

.byte $c6, $10, $24, $10, $30, $fc, $60 ; $C06C

_func_c073:
  lda  scroll_x                ; $C073  A5 17
  cmp  scroll_y                ; $C075  C5 18
  beq _label_c0a8                ; $C077  F0 2F
  dec  scroll_y                ; $C079  C6 18
  lda  scroll_y                ; $C07B  A5 18
  and #$07                       ; $C07D  29 07
  bne _label_c0a7                ; $C07F  D0 26
  lda  scroll_y                ; $C081  A5 18
  bcs _label_c087                ; $C083  B0 02
  adc #$11                       ; $C085  69 11

_label_c087:
  sbc #$08                       ; $C087  E9 08
  sta  scroll_y                ; $C089  85 18
  lda  scroll_x                ; $C08B  A5 17
  and #$07                       ; $C08D  29 07
  ora  scroll_y                ; $C08F  05 18
  sta  scroll_y                ; $C091  85 18
  lsr a                          ; $C093  4A
  lsr a                          ; $C094  4A
  lsr a                          ; $C095  4A
  tax                            ; $C096  AA
  lda  _data_cde6_indexed,X     ; $C097  BD E6 CD
  and #$0F                       ; $C09A  29 0F
  sta  tile_id_lo                ; $C09C  85 19
  lda  _data_cde6_indexed,X     ; $C09E  BD E6 CD
  and #$F0                       ; $C0A1  29 F0
  sta  tile_id_hi                ; $C0A3  85 1A
  clc                            ; $C0A5  18
  rts                            ; $C0A6  60

_label_c0a7:
  sec                            ; $C0A7  38

_label_c0a8:
  rts                            ; $C0A8  60

_func_c0a9:
  lda #$A8                       ; $C0A9  A9 A8
  sta PPU_CTRL                   ; $C0AB  8D 00 20
  lda #$04                       ; $C0AE  A9 04
  sta PPU_ADDR                   ; $C0B0  8D 06 20
  lda #$00                       ; $C0B3  A9 00
  sta PPU_ADDR                   ; $C0B5  8D 06 20
  lda #$40                       ; $C0B8  A9 40

_label_c0ba:
  sta  clip_plane_1                ; $C0BA  85 23
  ldx #$04                       ; $C0BC  A2 04
  ldy #$00                       ; $C0BE  A0 00
  sty  temp_c                ; $C0C0  84 27
  beq _label_c0c6                ; $C0C2  F0 02

_label_c0c4:
  dex                            ; $C0C4  CA
  iny                            ; $C0C5  C8

_label_c0c6:
  asl a                          ; $C0C6  0A
  bcs _label_c0c4                ; $C0C7  B0 FB
  stx  temp_a                ; $C0C9  86 25
  sty  temp_b                ; $C0CB  84 26
  asl a                          ; $C0CD  0A
  php                            ; $C0CE  08
  asl a                          ; $C0CF  0A
  sta  ppu_addr_temp                ; $C0D0  85 28
  lda #$FF                       ; $C0D2  A9 FF
  adc #$00                       ; $C0D4  69 00
  eor #$FF                       ; $C0D6  49 FF
  sta  clip_plane_2                ; $C0D8  85 24
  asl  ppu_addr_temp                ; $C0DA  06 28
  rol  temp_c                ; $C0DC  26 27
  ldy #$07                       ; $C0DE  A0 07
  plp                            ; $C0E0  28
  bcc _label_c126                ; $C0E1  90 43

_label_c0e3:
  asl  ppu_addr_temp                ; $C0E3  06 28
  lda  temp_c                ; $C0E5  A5 27
  rol a                          ; $C0E7  2A
  tax                            ; $C0E8  AA
  lda  clip_plane_2                ; $C0E9  A5 24
  and  _data_ce31_indexed,X     ; $C0EB  3D 31 CE
  sta PPU_DATA                   ; $C0EE  8D 07 20
  lda  _data_ce31_indexed,X     ; $C0F1  BD 31 CE
  sta  ppu_buffer,Y      ; $C0F4  99 1B 00
  dey                            ; $C0F7  88
  lda  clip_plane_2                ; $C0F8  A5 24
  and  _data_ce35_indexed,X     ; $C0FA  3D 35 CE
  sta PPU_DATA                   ; $C0FD  8D 07 20
  lda  _data_ce35_indexed,X     ; $C100  BD 35 CE
  sta  ppu_buffer,Y      ; $C103  99 1B 00
  dey                            ; $C106  88
  dec  temp_a                ; $C107  C6 25
  bne _label_c0e3                ; $C109  D0 D8

_label_c10b:
  dec  temp_b                ; $C10B  C6 26
  bmi _label_c16d                ; $C10D  30 5E
  lda  _var_0002                ; $C10F  A5 02
  sta PPU_DATA                   ; $C111  8D 07 20
  lda #$00                       ; $C114  A9 00
  sta  ppu_buffer,Y      ; $C116  99 1B 00
  dey                            ; $C119  88
  sta  ppu_buffer,Y      ; $C11A  99 1B 00
  lda  _var_0003                ; $C11D  A5 03
  sta PPU_DATA                   ; $C11F  8D 07 20
  dey                            ; $C122  88
  jmp _label_c10b                ; $C123  4C 0B C1

_label_c126:
  lda  clip_plane_1                ; $C126  A5 23
  sta  ppu_addr_temp                ; $C128  85 28

_label_c12a:
  dec  temp_b                ; $C12A  C6 26
  bmi _label_c145                ; $C12C  30 17
  lda  _var_0000                ; $C12E  A5 00
  sta PPU_DATA                   ; $C130  8D 07 20
  lda #$00                       ; $C133  A9 00
  sta  ppu_buffer,Y      ; $C135  99 1B 00
  dey                            ; $C138  88
  sta  ppu_buffer,Y      ; $C139  99 1B 00
  lda  _var_0001                ; $C13C  A5 01
  sta PPU_DATA                   ; $C13E  8D 07 20
  dey                            ; $C141  88
  jmp _label_c12a                ; $C142  4C 2A C1

_label_c145:
  lsr  ppu_addr_temp                ; $C145  46 28
  lda  temp_c                ; $C147  A5 27
  rol a                          ; $C149  2A
  tax                            ; $C14A  AA
  lda  clip_plane_2                ; $C14B  A5 24
  and  _data_ce31_indexed,X     ; $C14D  3D 31 CE
  sta PPU_DATA                   ; $C150  8D 07 20
  lda  _data_ce31_indexed,X     ; $C153  BD 31 CE
  sta  ppu_buffer,Y      ; $C156  99 1B 00
  dey                            ; $C159  88
  lda  clip_plane_2                ; $C15A  A5 24
  and  _data_ce35_indexed,X     ; $C15C  3D 35 CE
  sta PPU_DATA                   ; $C15F  8D 07 20
  lda  _data_ce35_indexed,X     ; $C162  BD 35 CE
  sta  ppu_buffer,Y      ; $C165  99 1B 00
  dey                            ; $C168  88
  dec  temp_a                ; $C169  C6 25
  bne _label_c145                ; $C16B  D0 D8

_label_c16d:
  ldy #$07                       ; $C16D  A0 07

_label_c16f:
  lda  ppu_buffer,Y      ; $C16F  B9 1B 00
  sta PPU_DATA                   ; $C172  8D 07 20
  dey                            ; $C175  88
  bpl _label_c16f                ; $C176  10 F7
  clc                            ; $C178  18
  lda  clip_plane_1                ; $C179  A5 23
  adc #$01                       ; $C17B  69 01
  cmp #$F0                       ; $C17D  C9 F0
  beq _label_c184                ; $C17F  F0 03
  jmp _label_c0ba                ; $C181  4C BA C0

_label_c184:
  lda  _var_0000                ; $C184  A5 00
  ldx  _var_0001                ; $C186  A6 01
  ldy #$04                       ; $C188  A0 04

_label_c18a:
  sta PPU_DATA                   ; $C18A  8D 07 20
  stx PPU_DATA                   ; $C18D  8E 07 20
  dey                            ; $C190  88
  bne _label_c18a                ; $C191  D0 F7
  ldx #$08                       ; $C193  A2 08

_label_c195:
  sty PPU_DATA                   ; $C195  8C 07 20
  dex                            ; $C198  CA
  bne _label_c195                ; $C199  D0 FA
  lda  _var_0002                ; $C19B  A5 02
  ldx  _var_0003                ; $C19D  A6 03
  ldy #$04                       ; $C19F  A0 04

_label_c1a1:
  sta PPU_DATA                   ; $C1A1  8D 07 20
  stx PPU_DATA                   ; $C1A4  8E 07 20
  dey                            ; $C1A7  88
  bne _label_c1a1                ; $C1A8  D0 F7
  ldx #$08                       ; $C1AA  A2 08

_label_c1ac:
  sty PPU_DATA                   ; $C1AC  8C 07 20
  dex                            ; $C1AF  CA
  bne _label_c1ac                ; $C1B0  D0 FA
  lda #$03                       ; $C1B2  A9 03
  sta  temp_b                ; $C1B4  85 26
  lda #$01                       ; $C1B6  A9 01
  sta  temp_a                ; $C1B8  85 25

_label_c1ba:
  ldy  temp_b                ; $C1BA  A4 26
  lda  _var_0000                ; $C1BC  A5 00
  ldx  _var_0001                ; $C1BE  A6 01

_label_c1c0:
  sta PPU_DATA                   ; $C1C0  8D 07 20
  stx PPU_DATA                   ; $C1C3  8E 07 20
  dey                            ; $C1C6  88
  bne _label_c1c0                ; $C1C7  D0 F7
  ldy  temp_a                ; $C1C9  A4 25
  lda #$00                       ; $C1CB  A9 00

_label_c1cd:
  sta PPU_DATA                   ; $C1CD  8D 07 20
  sta PPU_DATA                   ; $C1D0  8D 07 20
  dey                            ; $C1D3  88
  bne _label_c1cd                ; $C1D4  D0 F7
  ldx #$08                       ; $C1D6  A2 08

_label_c1d8:
  sty PPU_DATA                   ; $C1D8  8C 07 20
  dex                            ; $C1DB  CA
  bne _label_c1d8                ; $C1DC  D0 FA
  inc  temp_a                ; $C1DE  E6 25
  dec  temp_b                ; $C1E0  C6 26
  bne _label_c1ba                ; $C1E2  D0 D6
  lda #$03                       ; $C1E4  A9 03
  sta  temp_b                ; $C1E6  85 26
  lda #$01                       ; $C1E8  A9 01
  sta  temp_a                ; $C1EA  85 25

_label_c1ec:
  ldy  temp_a                ; $C1EC  A4 25
  lda #$00                       ; $C1EE  A9 00

_label_c1f0:
  sta PPU_DATA                   ; $C1F0  8D 07 20
  sta PPU_DATA                   ; $C1F3  8D 07 20
  dey                            ; $C1F6  88
  bne _label_c1f0                ; $C1F7  D0 F7
  ldy  temp_b                ; $C1F9  A4 26
  lda  _var_0002                ; $C1FB  A5 02
  ldx  _var_0003                ; $C1FD  A6 03

_label_c1ff:
  sta PPU_DATA                   ; $C1FF  8D 07 20
  stx PPU_DATA                   ; $C202  8E 07 20
  dey                            ; $C205  88
  bne _label_c1ff                ; $C206  D0 F7
  ldx #$08                       ; $C208  A2 08

_label_c20a:
  sty PPU_DATA                   ; $C20A  8C 07 20
  dex                            ; $C20D  CA
  bne _label_c20a                ; $C20E  D0 FA
  inc  temp_a                ; $C210  E6 25
  dec  temp_b                ; $C212  C6 26
  bne _label_c1ec                ; $C214  D0 D6
  rts                            ; $C216  60

_func_c217:
  lda #$00                       ; $C217  A9 00
  sta  joypad1_state                ; $C219  85 13
  sta  joypad2_state                ; $C21B  85 14
  sta  joypad1_mask                ; $C21D  85 15
  sta  joypad2_mask                ; $C21F  85 16
  rts                            ; $C221  60

_func_c222:
  lda  joypad1_state                ; $C222  A5 13
  eor #$FF                       ; $C224  49 FF
  sta  joypad1_mask                ; $C226  85 15
  lda  joypad2_state                ; $C228  A5 14
  eor #$FF                       ; $C22A  49 FF
  sta  joypad2_mask                ; $C22C  85 16
  lda #$01                       ; $C22E  A9 01
  sta JOYPAD1                    ; $C230  8D 16 40
  lsr a                          ; $C233  4A
  sta JOYPAD1                    ; $C234  8D 16 40
  ldx #$07                       ; $C237  A2 07

_label_c239:
  lda JOYPAD1                    ; $C239  AD 16 40
  and #$03                       ; $C23C  29 03
  cmp #$01                       ; $C23E  C9 01
  rol  joypad1_state                ; $C240  26 13
  lda JOYPAD2                    ; $C242  AD 17 40
  and #$03                       ; $C245  29 03
  cmp #$01                       ; $C247  C9 01
  rol  joypad2_state                ; $C249  26 14
  dex                            ; $C24B  CA
  bpl _label_c239                ; $C24C  10 EB
  lda  joypad1_state                ; $C24E  A5 13
  and  joypad1_mask                ; $C250  25 15
  sta  joypad1_mask                ; $C252  85 15
  lda  joypad2_state                ; $C254  A5 14
  and  joypad2_mask                ; $C256  25 16
  sta  joypad2_mask                ; $C258  85 16
  rts                            ; $C25A  60

_label_c25b:
  jsr _func_c217                 ; $C25B  20 17 C2
  ldx #$00                       ; $C25E  A2 00
  stx PPU_ADDR                   ; $C260  8E 06 20
  stx PPU_ADDR                   ; $C263  8E 06 20
  ldy #$30                       ; $C266  A0 30
  txa                            ; $C268  8A

_label_c269:
  sta PPU_DATA                   ; $C269  8D 07 20
  dex                            ; $C26C  CA
  bne _label_c269                ; $C26D  D0 FA
  dey                            ; $C26F  88
  bne _label_c269                ; $C270  D0 F7
  lda #$FF                       ; $C272  A9 FF
  sta  _var_0000                ; $C274  85 00
  lda #$FF                       ; $C276  A9 FF
  sta  _var_0001                ; $C278  85 01
  lda #$33                       ; $C27A  A9 33
  sta  _var_0002                ; $C27C  85 02
  lda #$CC                       ; $C27E  A9 CC
  sta  _var_0003                ; $C280  85 03
  jsr _func_c0a9                 ; $C282  20 A9 C0
  lda #$10                       ; $C285  A9 10
  sta  $1C                      ; $C287  85 1C
  lda #$F9                       ; $C289  A9 F9
  sta  lookup_table_a        ; $C28B  8D 00 03
  lda #$C9                       ; $C28E  A9 C9
  sta  lookup_table_c        ; $C290  8D 80 03
  ldy #$10                       ; $C293  A0 10
  ldx #$00                       ; $C295  A2 00

_label_c297:
  clc                            ; $C297  18
  tya                            ; $C298  98
  adc  lookup_table_a,X      ; $C299  7D 00 03
  sta  lookup_table_b,X      ; $C29C  9D 01 03
  lda  lookup_table_c,X      ; $C29F  BD 80 03
  adc #$00                       ; $C2A2  69 00
  sta  lookup_table_d,X      ; $C2A4  9D 81 03
  inx                            ; $C2A7  E8
  cpx #$7F                       ; $C2A8  E0 7F
  bne _label_c297                ; $C2AA  D0 EB
  lda #$20                       ; $C2AC  A9 20
  sta  camera_x                ; $C2AE  85 1D
  sta  camera_x2                ; $C2B0  85 1F
  lda #$06                       ; $C2B2  A9 06
  sta  camera_y                ; $C2B4  85 1E
  sta  camera_y2                ; $C2B6  85 20
  lda #$00                       ; $C2B8  A9 00
  sta  camera_angle                ; $C2BA  85 21
  lda #$A8                       ; $C2BC  A9 A8
  sta  ppu_buffer        ; $C2BE  85 1B
  lda #$00                       ; $C2C0  A9 00
  sta  polygon_index                ; $C2C2  85 2E
  sta  frame_counter                ; $C2C4  85 2D
  lda #$35                       ; $C2C6  A9 35
  sta  nmi_vector_lo                ; $C2C8  85 11
  lda #$CB                       ; $C2CA  A9 CB
  sta  nmi_vector_hi                ; $C2CC  85 12

_label_c2ce:
  jsr _func_c222                 ; $C2CE  20 22 C2
  lda  joypad1_state                ; $C2D1  A5 13
  and #$02                       ; $C2D3  29 02
  beq _label_c2e3                ; $C2D5  F0 0C
  ldx  camera_angle                ; $C2D7  A6 21
  dex                            ; $C2D9  CA
  dex                            ; $C2DA  CA
  cpx #$FE                       ; $C2DB  E0 FE
  bne _label_c2e1                ; $C2DD  D0 02
  ldx #$A6                       ; $C2DF  A2 A6

_label_c2e1:
  stx  camera_angle                ; $C2E1  86 21

_label_c2e3:
  lda  joypad1_state                ; $C2E3  A5 13
  and #$01                       ; $C2E5  29 01
  beq _label_c2f5                ; $C2E7  F0 0C
  ldx  camera_angle                ; $C2E9  A6 21
  inx                            ; $C2EB  E8
  inx                            ; $C2EC  E8
  cpx #$A8                       ; $C2ED  E0 A8
  bne _label_c2f3                ; $C2EF  D0 02
  ldx #$00                       ; $C2F1  A2 00

_label_c2f3:
  stx  camera_angle                ; $C2F3  86 21

_label_c2f5:
  lda  joypad1_state                ; $C2F5  A5 13
  and #$0C                       ; $C2F7  29 0C
  bne _label_c2fe                ; $C2F9  D0 03
  jmp _label_c444                ; $C2FB  4C 44 C4

_label_c2fe:
  ldx  camera_angle                ; $C2FE  A6 21
  lda  _data_d650_indexed,X     ; $C300  BD 50 D6
  sta  _var_0000                ; $C303  85 00
  lda  _data_d6f8_indexed,X     ; $C305  BD F8 D6
  cmp #$80                       ; $C308  C9 80
  ror a                          ; $C30A  6A
  ror  _var_0000                ; $C30B  66 00
  cmp #$80                       ; $C30D  C9 80
  ror a                          ; $C30F  6A
  ror  _var_0000                ; $C310  66 00
  sta  _var_0001                ; $C312  85 01
  lda  joypad1_state                ; $C314  A5 13
  and #$08                       ; $C316  29 08
  bne _label_c32b                ; $C318  D0 11
  clc                            ; $C31A  18
  lda  _var_0000                ; $C31B  A5 00
  eor #$FF                       ; $C31D  49 FF
  adc #$01                       ; $C31F  69 01
  sta  _var_0000                ; $C321  85 00
  lda  _var_0001                ; $C323  A5 01
  eor #$FF                       ; $C325  49 FF
  adc #$00                       ; $C327  69 00
  sta  _var_0001                ; $C329  85 01

_label_c32b:
  clc                            ; $C32B  18
  lda  camera_x2                ; $C32C  A5 1F
  adc  _var_0000                ; $C32E  65 00
  sta  camera_x2                ; $C330  85 1F
  lda  camera_y2                ; $C332  A5 20
  adc  _var_0001                ; $C334  65 01
  sta  camera_y2                ; $C336  85 20
  lda #$80                       ; $C338  A9 80
  ldy #$00                       ; $C33A  A0 00
  bit  _var_0001                ; $C33C  24 01
  bpl _label_c344                ; $C33E  10 04
  lda #$80                       ; $C340  A9 80
  ldy #$FF                       ; $C342  A0 FF

_label_c344:
  clc                            ; $C344  18
  adc  camera_x2                ; $C345  65 1F
  tya                            ; $C347  98
  adc  camera_y2                ; $C348  65 20
  lsr a                          ; $C34A  4A
  sta  _var_0003                ; $C34B  85 03
  tay                            ; $C34D  A8
  lda  lookup_table_a,Y      ; $C34E  B9 00 03
  sta  column_ptr        ; $C351  85 57
  lda  lookup_table_c,Y      ; $C353  B9 80 03
  sta  column_ptr_hi                ; $C356  85 58
  sec                            ; $C358  38
  lda  camera_x                ; $C359  A5 1D
  sbc #$80                       ; $C35B  E9 80
  lda  camera_y                ; $C35D  A5 1E
  sbc #$00                       ; $C35F  E9 00
  lsr a                          ; $C361  4A
  tay                            ; $C362  A8
  lda (column_ptr),Y      ; $C363  B1 57
  bmi _label_c376                ; $C365  30 0F
  clc                            ; $C367  18
  lda  camera_x                ; $C368  A5 1D
  adc #$80                       ; $C36A  69 80
  lda  camera_y                ; $C36C  A5 1E
  adc #$00                       ; $C36E  69 00
  lsr a                          ; $C370  4A
  tay                            ; $C371  A8
  lda (column_ptr),Y      ; $C372  B1 57
  bpl _label_c396                ; $C374  10 20

_label_c376:
  bit  _var_0001                ; $C376  24 01
  bpl _label_c389                ; $C378  10 0F
  lda #$81                       ; $C37A  A9 81
  sta  camera_x2                ; $C37C  85 1F
  clc                            ; $C37E  18
  lda  _var_0003                ; $C37F  A5 03
  adc #$01                       ; $C381  69 01
  asl a                          ; $C383  0A
  sta  camera_y2                ; $C384  85 20
  jmp _label_c396                ; $C386  4C 96 C3

_label_c389:
  lda #$7F                       ; $C389  A9 7F
  sta  camera_x2                ; $C38B  85 1F
  sec                            ; $C38D  38
  lda  _var_0003                ; $C38E  A5 03
  sbc #$01                       ; $C390  E9 01
  sec                            ; $C392  38
  rol a                          ; $C393  2A
  sta  camera_y2                ; $C394  85 20

_label_c396:
  clc                            ; $C396  18
  txa                            ; $C397  8A
  adc #$2A                       ; $C398  69 2A
  cmp #$A8                       ; $C39A  C9 A8
  bcc _label_c3a0                ; $C39C  90 02
  sbc #$A8                       ; $C39E  E9 A8

_label_c3a0:
  tax                            ; $C3A0  AA
  lda  _data_d650_indexed,X     ; $C3A1  BD 50 D6
  sta  _var_0000                ; $C3A4  85 00
  lda  _data_d6f8_indexed,X     ; $C3A6  BD F8 D6
  cmp #$80                       ; $C3A9  C9 80
  ror a                          ; $C3AB  6A
  ror  _var_0000                ; $C3AC  66 00
  cmp #$80                       ; $C3AE  C9 80
  ror a                          ; $C3B0  6A
  ror  _var_0000                ; $C3B1  66 00
  sta  _var_0001                ; $C3B3  85 01
  lda  joypad1_state                ; $C3B5  A5 13
  and #$08                       ; $C3B7  29 08
  bne _label_c3cc                ; $C3B9  D0 11
  clc                            ; $C3BB  18
  lda  _var_0000                ; $C3BC  A5 00
  eor #$FF                       ; $C3BE  49 FF
  adc #$01                       ; $C3C0  69 01
  sta  _var_0000                ; $C3C2  85 00
  lda  _var_0001                ; $C3C4  A5 01
  eor #$FF                       ; $C3C6  49 FF
  adc #$00                       ; $C3C8  69 00
  sta  _var_0001                ; $C3CA  85 01

_label_c3cc:
  clc                            ; $C3CC  18
  lda  camera_x                ; $C3CD  A5 1D
  adc  _var_0000                ; $C3CF  65 00
  sta  camera_x                ; $C3D1  85 1D
  lda  camera_y                ; $C3D3  A5 1E
  adc  _var_0001                ; $C3D5  65 01
  sta  camera_y                ; $C3D7  85 1E
  lda #$80                       ; $C3D9  A9 80
  ldy #$00                       ; $C3DB  A0 00
  bit  _var_0001                ; $C3DD  24 01
  bpl _label_c3e5                ; $C3DF  10 04
  lda #$80                       ; $C3E1  A9 80
  ldy #$FF                       ; $C3E3  A0 FF

_label_c3e5:
  clc                            ; $C3E5  18
  adc  camera_x                ; $C3E6  65 1D
  tya                            ; $C3E8  98
  adc  camera_y                ; $C3E9  65 1E
  lsr a                          ; $C3EB  4A
  sta  _var_0003                ; $C3EC  85 03
  sec                            ; $C3EE  38
  lda  camera_x2                ; $C3EF  A5 1F
  sbc #$80                       ; $C3F1  E9 80
  lda  camera_y2                ; $C3F3  A5 20
  sbc #$00                       ; $C3F5  E9 00
  lsr a                          ; $C3F7  4A
  tay                            ; $C3F8  A8
  lda  lookup_table_a,Y      ; $C3F9  B9 00 03
  sta  column_ptr        ; $C3FC  85 57
  lda  lookup_table_c,Y      ; $C3FE  B9 80 03
  sta  column_ptr_hi                ; $C401  85 58
  ldy  _var_0003                ; $C403  A4 03
  lda (column_ptr),Y      ; $C405  B1 57
  bmi _label_c424                ; $C407  30 1B
  clc                            ; $C409  18
  lda  camera_x2                ; $C40A  A5 1F
  adc #$80                       ; $C40C  69 80
  lda  camera_y2                ; $C40E  A5 20
  adc #$00                       ; $C410  69 00
  lsr a                          ; $C412  4A
  tay                            ; $C413  A8
  lda  lookup_table_a,Y      ; $C414  B9 00 03
  sta  column_ptr        ; $C417  85 57
  lda  lookup_table_c,Y      ; $C419  B9 80 03
  sta  column_ptr_hi                ; $C41C  85 58
  ldy  _var_0003                ; $C41E  A4 03
  lda (column_ptr),Y      ; $C420  B1 57
  bpl _label_c444                ; $C422  10 20

_label_c424:
  bit  _var_0001                ; $C424  24 01
  bpl _label_c437                ; $C426  10 0F
  lda #$81                       ; $C428  A9 81
  sta  camera_x                ; $C42A  85 1D
  clc                            ; $C42C  18
  lda  _var_0003                ; $C42D  A5 03
  adc #$01                       ; $C42F  69 01
  asl a                          ; $C431  0A
  sta  camera_y                ; $C432  85 1E
  jmp _label_c444                ; $C434  4C 44 C4

_label_c437:
  lda #$7F                       ; $C437  A9 7F
  sta  camera_x                ; $C439  85 1D
  sec                            ; $C43B  38
  lda  _var_0003                ; $C43C  A5 03
  sbc #$01                       ; $C43E  E9 01
  sec                            ; $C440  38
  rol a                          ; $C441  2A
  sta  camera_y                ; $C442  85 1E

_label_c444:
  sec                            ; $C444  38
  lda  camera_angle                ; $C445  A5 21
  sbc #$0E                       ; $C447  E9 0E
  bcs _label_c44d                ; $C449  B0 02
  adc #$A8                       ; $C44B  69 A8

_label_c44d:
  sta  poly_index_b                ; $C44D  85 2A
  adc #$29                       ; $C44F  69 29
  cmp #$A8                       ; $C451  C9 A8
  bcc _label_c457                ; $C453  90 02
  sbc #$A8                       ; $C455  E9 A8

_label_c457:
  sta  poly_index_a                ; $C457  85 29

_label_c459:
  lda  frame_counter                ; $C459  A5 2D
  bmi _label_c459                ; $C45B  30 FC
  lda #$8F                       ; $C45D  A9 8F
  sta  clip_plane_0                ; $C45F  85 22
  sta  clip_plane_1                ; $C461  85 23
  sta  clip_plane_2                ; $C463  85 24
  lda #$00                       ; $C465  A9 00
  sta  temp_c                ; $C467  85 27
  lda  ppu_buffer        ; $C469  A5 1B
  and #$03                       ; $C46B  29 03
  asl a                          ; $C46D  0A
  asl a                          ; $C46E  0A
  ora #$20                       ; $C46F  09 20
  sta  ppu_addr_temp                ; $C471  85 28
  lda #$00                       ; $C473  A9 00
  sta  poly_draw_index                ; $C475  85 2B
  sta  $2C                      ; $C477  85 2C
  ldx #$00                       ; $C479  A2 00

_label_c47b:
  lda  _data_d3cd_indexed,X     ; $C47B  BD CD D3
  sta  vertex_ptr        ; $C47E  85 38
  lda  _data_d3e9_indexed,X     ; $C480  BD E9 D3
  sta  vertex_ptr_hi                ; $C483  85 39
  ldy  poly_index_a                ; $C485  A4 29
  lda  _data_ce39_indexed,Y     ; $C487  B9 39 CE
  sta  vertex_index_a                ; $C48A  85 3A
  asl a                          ; $C48C  0A
  tay                            ; $C48D  A8
  lda (vertex_ptr),Y      ; $C48E  B1 38
  sta  vertex_a_x                ; $C490  85 3C
  lda  _data_d379_indexed,Y     ; $C492  B9 79 D3
  sta  edge_a_dx                ; $C495  85 40
  iny                            ; $C497  C8
  lda (vertex_ptr),Y      ; $C498  B1 38
  sta  vertex_a_y                ; $C49A  85 3D
  lda  _data_d379_indexed,Y     ; $C49C  B9 79 D3
  sta  edge_a_dy                ; $C49F  85 41
  ldy  poly_index_b                ; $C4A1  A4 2A
  lda  _data_ce39_indexed,Y     ; $C4A3  B9 39 CE
  sta  vertex_index_b                ; $C4A6  85 3B
  asl a                          ; $C4A8  0A
  tay                            ; $C4A9  A8
  lda (vertex_ptr),Y      ; $C4AA  B1 38
  sta  vertex_b_x                ; $C4AC  85 3E
  lda  _data_d379_indexed,Y     ; $C4AE  B9 79 D3
  sta  edge_b_dx                ; $C4B1  85 42
  iny                            ; $C4B3  C8
  lda (vertex_ptr),Y      ; $C4B4  B1 38
  sta  vertex_b_y                ; $C4B6  85 3F
  lda  _data_d379_indexed,Y     ; $C4B8  B9 79 D3
  sta  edge_b_dy                ; $C4BB  85 43
  lda  camera_y                ; $C4BD  A5 1E
  lsr a                          ; $C4BF  4A
  lda  camera_x                ; $C4C0  A5 1D
  ror a                          ; $C4C2  6A
  lsr a                          ; $C4C3  4A
  bit  vertex_index_a                ; $C4C4  24 3A
  bpl _label_c4d0                ; $C4C6  10 08
  eor #$80                       ; $C4C8  49 80
  ldy #$FF                       ; $C4CA  A0 FF
  sty  edge_a_sign                ; $C4CC  84 44
  bne _label_c4d7                ; $C4CE  D0 07

_label_c4d0:
  eor #$FF                       ; $C4D0  49 FF
  ldy #$01                       ; $C4D2  A0 01
  sty  edge_a_sign                ; $C4D4  84 44
  dey                            ; $C4D6  88

_label_c4d7:
  sty  edge_a_mask                ; $C4D7  84 46
  sta  bresenham_a_mask                ; $C4D9  85 4B
  sta  bresenham_a                ; $C4DB  85 48
  lda #$00                       ; $C4DD  A9 00
  sta  bresenham_a_x                ; $C4DF  85 4D
  lsr  bresenham_a                ; $C4E1  46 48
  bcc _label_c4f0                ; $C4E3  90 0B

_label_c4e5:
  tay                            ; $C4E5  A8
  clc                            ; $C4E6  18
  lda  bresenham_a_x                ; $C4E7  A5 4D
  adc  vertex_a_x                ; $C4E9  65 3C
  sta  bresenham_a_x                ; $C4EB  85 4D
  tya                            ; $C4ED  98
  adc  vertex_a_y                ; $C4EE  65 3D

_label_c4f0:
  ror a                          ; $C4F0  6A
  ror  bresenham_a_x                ; $C4F1  66 4D
  lsr  bresenham_a                ; $C4F3  46 48
  beq _label_c4fb                ; $C4F5  F0 04
  bcs _label_c4e5                ; $C4F7  B0 EC
  bcc _label_c4f0                ; $C4F9  90 F5

_label_c4fb:
  sta  bresenham_a_y                ; $C4FB  85 4E
  lda  camera_y2                ; $C4FD  A5 20
  lsr a                          ; $C4FF  4A
  lda  camera_x2                ; $C500  A5 1F
  ror a                          ; $C502  6A
  lsr a                          ; $C503  4A
  bit  vertex_index_b                ; $C504  24 3B
  bpl _label_c512                ; $C506  10 0A
  eor #$80                       ; $C508  49 80
  ldy #$FE                       ; $C50A  A0 FE
  sty  edge_b_sign                ; $C50C  84 45
  ldy #$00                       ; $C50E  A0 00
  beq _label_c519                ; $C510  F0 07

_label_c512:
  eor #$FF                       ; $C512  49 FF
  ldy #$00                       ; $C514  A0 00
  sty  edge_b_sign                ; $C516  84 45
  dey                            ; $C518  88

_label_c519:
  sty  edge_b_mask                ; $C519  84 47
  sta  bresenham_b_mask                ; $C51B  85 4C
  sta  bresenham_a                ; $C51D  85 48
  lda #$00                       ; $C51F  A9 00
  sta  bresenham_b_x                ; $C521  85 4F
  lsr  bresenham_a                ; $C523  46 48
  bcc _label_c532                ; $C525  90 0B

_label_c527:
  tay                            ; $C527  A8
  clc                            ; $C528  18
  lda  bresenham_b_x                ; $C529  A5 4F
  adc  vertex_b_x                ; $C52B  65 3E
  sta  bresenham_b_x                ; $C52D  85 4F
  tya                            ; $C52F  98
  adc  vertex_b_y                ; $C530  65 3F

_label_c532:
  ror a                          ; $C532  6A
  ror  bresenham_b_x                ; $C533  66 4F
  lsr  bresenham_a                ; $C535  46 48
  beq _label_c53d                ; $C537  F0 04
  bcs _label_c527                ; $C539  B0 EC
  bcc _label_c532                ; $C53B  90 F5

_label_c53d:
  sta  bresenham_b_y                ; $C53D  85 50
  lda  camera_y                ; $C53F  A5 1E
  lsr a                          ; $C541  4A
  sta  scanline_a                ; $C542  85 55
  lda  camera_y2                ; $C544  A5 20
  lsr a                          ; $C546  4A
  sta  scanline_b                ; $C547  85 56
  tay                            ; $C549  A8
  lda  lookup_table_a,Y      ; $C54A  B9 00 03
  sta  column_ptr        ; $C54D  85 57
  lda  lookup_table_c,Y      ; $C54F  B9 80 03
  sta  column_ptr_hi                ; $C552  85 58
  lda #$00                       ; $C554  A9 00
  sta  bresenham_a_count                ; $C556  85 49
  sta  bresenham_b_count                ; $C558  85 4A

_label_c55a:
  lda  bresenham_a_x                ; $C55A  A5 4D
  cmp  bresenham_b_x                ; $C55C  C5 4F
  lda  bresenham_a_y                ; $C55E  A5 4E
  sbc  bresenham_b_y                ; $C560  E5 50
  bcs _label_c581                ; $C562  B0 1D
  lda  scanline_a                ; $C564  A5 55
  adc  edge_a_sign                ; $C566  65 44
  sta  scanline_a                ; $C568  85 55
  tay                            ; $C56A  A8
  lda (column_ptr),Y      ; $C56B  B1 57
  bmi _label_c5ad                ; $C56D  30 3E
  inc  bresenham_a_count                ; $C56F  E6 49
  clc                            ; $C571  18
  lda  bresenham_a_x                ; $C572  A5 4D
  adc  vertex_a_x                ; $C574  65 3C
  sta  bresenham_a_x                ; $C576  85 4D
  lda  bresenham_a_y                ; $C578  A5 4E
  adc  vertex_a_y                ; $C57A  65 3D
  sta  bresenham_a_y                ; $C57C  85 4E
  jmp _label_c55a                ; $C57E  4C 5A C5

_label_c581:
  lda  scanline_b                ; $C581  A5 56
  adc  edge_b_sign                ; $C583  65 45
  sta  scanline_b                ; $C585  85 56
  tay                            ; $C587  A8
  lda  lookup_table_a,Y      ; $C588  B9 00 03
  sta  column_ptr        ; $C58B  85 57
  lda  lookup_table_c,Y      ; $C58D  B9 80 03
  sta  column_ptr_hi                ; $C590  85 58
  ldy  scanline_a                ; $C592  A4 55
  lda (column_ptr),Y      ; $C594  B1 57
  bmi _label_c5aa                ; $C596  30 12
  inc  bresenham_b_count                ; $C598  E6 4A
  clc                            ; $C59A  18
  lda  bresenham_b_x                ; $C59B  A5 4F
  adc  vertex_b_x                ; $C59D  65 3E
  sta  bresenham_b_x                ; $C59F  85 4F
  lda  bresenham_b_y                ; $C5A1  A5 50
  adc  vertex_b_y                ; $C5A3  65 3F
  sta  bresenham_b_y                ; $C5A5  85 50
  jmp _label_c55a                ; $C5A7  4C 5A C5

_label_c5aa:
  jmp _label_c62d                ; $C5AA  4C 2D C6

_label_c5ad:
  cmp #$FF                       ; $C5AD  C9 FF
  bne _label_c5b3                ; $C5AF  D0 02
  lda #$00                       ; $C5B1  A9 00

_label_c5b3:
  sta  polygon_visible,X      ; $C5B3  9D 38 01
  lda  bresenham_a_x                ; $C5B6  A5 4D
  sta  poly_x_buffer,X      ; $C5B8  9D 00 01
  lda  bresenham_a_y                ; $C5BB  A5 4E
  sta  poly_y_buffer,X      ; $C5BD  9D 1C 01
  lda #$00                       ; $C5C0  A9 00
  sta  temp_x                ; $C5C2  85 51
  lsr  bresenham_a_mask                ; $C5C4  46 4B
  bcc _label_c5d3                ; $C5C6  90 0B

_label_c5c8:
  tay                            ; $C5C8  A8
  clc                            ; $C5C9  18
  lda  temp_x                ; $C5CA  A5 51
  adc  edge_a_dx                ; $C5CC  65 40
  sta  temp_x                ; $C5CE  85 51
  tya                            ; $C5D0  98
  adc  edge_a_dy                ; $C5D1  65 41

_label_c5d3:
  ror a                          ; $C5D3  6A
  ror  temp_x                ; $C5D4  66 51
  lsr  bresenham_a_mask                ; $C5D6  46 4B
  beq _label_c5de                ; $C5D8  F0 04
  bcs _label_c5c8                ; $C5DA  B0 EC
  bcc _label_c5d3                ; $C5DC  90 F5

_label_c5de:
  sta  temp_y                ; $C5DE  85 52
  ldy  bresenham_a_count                ; $C5E0  A4 49
  beq _label_c5f4                ; $C5E2  F0 10

_label_c5e4:
  clc                            ; $C5E4  18
  lda  temp_x                ; $C5E5  A5 51
  adc  edge_a_dx                ; $C5E7  65 40
  sta  temp_x                ; $C5E9  85 51
  lda  temp_y                ; $C5EB  A5 52
  adc  edge_a_dy                ; $C5ED  65 41
  sta  temp_y                ; $C5EF  85 52
  dey                            ; $C5F1  88
  bne _label_c5e4                ; $C5F2  D0 F0

_label_c5f4:
  bit  vertex_index_b                ; $C5F4  24 3B
  bmi _label_c606                ; $C5F6  30 0E
  clc                            ; $C5F8  18
  lda  camera_x2                ; $C5F9  A5 1F
  adc  temp_x                ; $C5FB  65 51
  sta  temp_x                ; $C5FD  85 51
  lda  camera_y2                ; $C5FF  A5 20
  adc  temp_y                ; $C601  65 52
  jmp _label_c611                ; $C603  4C 11 C6

_label_c606:
  sec                            ; $C606  38
  lda  camera_x2                ; $C607  A5 1F
  sbc  temp_x                ; $C609  E5 51
  sta  temp_x                ; $C60B  85 51
  lda  camera_y2                ; $C60D  A5 20
  sbc  temp_y                ; $C60F  E5 52

_label_c611:
  lsr a                          ; $C611  4A
  ror  temp_x                ; $C612  66 51
  cmp  scanline_b                ; $C614  C5 56
  beq _label_c61f                ; $C616  F0 07
  lda  temp_x                ; $C618  A5 51
  eor #$FF                       ; $C61A  49 FF
  jmp _label_c621                ; $C61C  4C 21 C6

_label_c61f:
  lda  temp_x                ; $C61F  A5 51

_label_c621:
  eor  edge_a_mask                ; $C621  45 46
  lsr a                          ; $C623  4A
  lsr a                          ; $C624  4A
  lsr a                          ; $C625  4A
  lsr a                          ; $C626  4A
  lsr a                          ; $C627  4A
  sta  screen_column,X      ; $C628  9D 54 01
  bpl _label_c6ac                ; $C62B  10 7F

_label_c62d:
  cmp #$FF                       ; $C62D  C9 FF
  bne _label_c633                ; $C62F  D0 02
  lda #$00                       ; $C631  A9 00

_label_c633:
  sta  polygon_visible,X      ; $C633  9D 38 01
  lda  bresenham_b_x                ; $C636  A5 4F
  sta  poly_x_buffer,X      ; $C638  9D 00 01
  lda  bresenham_b_y                ; $C63B  A5 50
  sta  poly_y_buffer,X      ; $C63D  9D 1C 01
  lda #$00                       ; $C640  A9 00
  sta  temp_x2                ; $C642  85 53
  lsr  bresenham_b_mask                ; $C644  46 4C
  bcc _label_c653                ; $C646  90 0B

_label_c648:
  tay                            ; $C648  A8
  clc                            ; $C649  18
  lda  temp_x2                ; $C64A  A5 53
  adc  edge_b_dx                ; $C64C  65 42
  sta  temp_x2                ; $C64E  85 53
  tya                            ; $C650  98
  adc  edge_b_dy                ; $C651  65 43

_label_c653:
  ror a                          ; $C653  6A
  ror  temp_x2                ; $C654  66 53
  lsr  bresenham_b_mask                ; $C656  46 4C
  beq _label_c65e                ; $C658  F0 04
  bcs _label_c648                ; $C65A  B0 EC
  bcc _label_c653                ; $C65C  90 F5

_label_c65e:
  sta  temp_y2                ; $C65E  85 54
  ldy  bresenham_b_count                ; $C660  A4 4A
  beq _label_c674                ; $C662  F0 10

_label_c664:
  clc                            ; $C664  18
  lda  temp_x2                ; $C665  A5 53
  adc  edge_b_dx                ; $C667  65 42
  sta  temp_x2                ; $C669  85 53
  lda  temp_y2                ; $C66B  A5 54
  adc  edge_b_dy                ; $C66D  65 43
  sta  temp_y2                ; $C66F  85 54
  dey                            ; $C671  88
  bne _label_c664                ; $C672  D0 F0

_label_c674:
  bit  vertex_index_a                ; $C674  24 3A
  bmi _label_c686                ; $C676  30 0E
  clc                            ; $C678  18
  lda  camera_x                ; $C679  A5 1D
  adc  temp_x2                ; $C67B  65 53
  sta  temp_x2                ; $C67D  85 53
  lda  camera_y                ; $C67F  A5 1E
  adc  temp_y2                ; $C681  65 54
  jmp _label_c691                ; $C683  4C 91 C6

_label_c686:
  sec                            ; $C686  38
  lda  camera_x                ; $C687  A5 1D
  sbc  temp_x2                ; $C689  E5 53
  sta  temp_x2                ; $C68B  85 53
  lda  camera_y                ; $C68D  A5 1E
  sbc  temp_y2                ; $C68F  E5 54

_label_c691:
  lsr a                          ; $C691  4A
  ror  temp_x2                ; $C692  66 53
  cmp  scanline_a                ; $C694  C5 55
  beq _label_c69f                ; $C696  F0 07
  lda  temp_x2                ; $C698  A5 53
  eor #$FF                       ; $C69A  49 FF
  jmp _label_c6a1                ; $C69C  4C A1 C6

_label_c69f:
  lda  temp_x2                ; $C69F  A5 53

_label_c6a1:
  eor  edge_b_mask                ; $C6A1  45 47
  lsr a                          ; $C6A3  4A
  lsr a                          ; $C6A4  4A
  lsr a                          ; $C6A5  4A
  lsr a                          ; $C6A6  4A
  sec                            ; $C6A7  38
  ror a                          ; $C6A8  6A
  sta  screen_column,X      ; $C6A9  9D 54 01

_label_c6ac:
  inx                            ; $C6AC  E8
  txa                            ; $C6AD  8A
  and #$03                       ; $C6AE  29 03
  beq _label_c6cb                ; $C6B0  F0 19

_label_c6b2:
  ldy  poly_index_a                ; $C6B2  A4 29
  iny                            ; $C6B4  C8
  cpy #$A8                       ; $C6B5  C0 A8
  bne _label_c6bb                ; $C6B7  D0 02
  ldy #$00                       ; $C6B9  A0 00

_label_c6bb:
  sty  poly_index_a                ; $C6BB  84 29
  ldy  poly_index_b                ; $C6BD  A4 2A
  iny                            ; $C6BF  C8
  cpy #$A8                       ; $C6C0  C0 A8
  bne _label_c6c6                ; $C6C2  D0 02
  ldy #$00                       ; $C6C4  A0 00

_label_c6c6:
  sty  poly_index_b                ; $C6C6  84 2A
  jmp _label_c47b                ; $C6C8  4C 7B C4

_label_c6cb:
  sec                            ; $C6CB  38
  txa                            ; $C6CC  8A
  sbc #$04                       ; $C6CD  E9 04
  tax                            ; $C6CF  AA
  lda #$04                       ; $C6D0  A9 04

_label_c6d2:
  cmp  polygon_index                ; $C6D2  C5 2E
  beq _label_c6d2                ; $C6D4  F0 FC
  lda #$FF                       ; $C6D6  A9 FF
  sta  polygon_flags        ; $C6D8  85 30

_label_c6da:
  ldy  polygon_visible,X      ; $C6DA  BC 38 01
  bne _label_c6e2                ; $C6DD  D0 03
  tya                            ; $C6DF  98
  beq _label_c6e5                ; $C6E0  F0 03

_label_c6e2:
  jsr _func_cdbe                 ; $C6E2  20 BE CD

_label_c6e5:
  asl a                          ; $C6E5  0A
  asl a                          ; $C6E6  0A
  sta  temp_a                ; $C6E7  85 25
  ldy  polygon_type,X      ; $C6E9  BC 39 01
  bne _label_c6f1                ; $C6EC  D0 03
  tya                            ; $C6EE  98
  beq _label_c6f4                ; $C6EF  F0 03

_label_c6f1:
  jsr _func_cdbe                 ; $C6F1  20 BE CD

_label_c6f4:
  ora  temp_a                ; $C6F4  05 25
  tay                            ; $C6F6  A8
  lda  _data_d605_indexed,Y     ; $C6F7  B9 05 D6
  sta  temp_a                ; $C6FA  85 25
  bit  polygon_flags        ; $C6FC  24 30
  bpl _label_c704                ; $C6FE  10 04
  and #$33                       ; $C700  29 33
  sta  polygon_flags        ; $C702  85 30

_label_c704:
  lda #$FC                       ; $C704  A9 FC
  asl  temp_a                ; $C706  06 25
  rol a                          ; $C708  2A
  asl  screen_column,X      ; $C709  1E 54 01
  rol a                          ; $C70C  2A
  sta  column_flags                ; $C70D  85 59
  ldy #$00                       ; $C70F  A0 00
  sty  column_index_a                ; $C711  84 5C
  dey                            ; $C713  88
  sty  column_index_b                ; $C714  84 5D
  clc                            ; $C716  18
  lda  column_index_a                ; $C717  A5 5C
  adc  column_index_b                ; $C719  65 5D
  ror a                          ; $C71B  6A
  tay                            ; $C71C  A8
  lda  poly_x_buffer,X      ; $C71D  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C720  D9 05 D4
  lda  poly_y_buffer,X      ; $C723  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C726  F9 05 D5
  bcc _label_c730                ; $C729  90 05
  sty  column_index_b                ; $C72B  84 5D
  clc                            ; $C72D  18
  bcc _label_c733                ; $C72E  90 03

_label_c730:
  iny                            ; $C730  C8
  sty  column_index_a                ; $C731  84 5C

_label_c733:
  lda  column_index_a                ; $C733  A5 5C
  adc  column_index_b                ; $C735  65 5D
  ror a                          ; $C737  6A
  tay                            ; $C738  A8
  lda  poly_x_buffer,X      ; $C739  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C73C  D9 05 D4
  lda  poly_y_buffer,X      ; $C73F  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C742  F9 05 D5
  bcc _label_c74c                ; $C745  90 05
  sty  column_index_b                ; $C747  84 5D
  clc                            ; $C749  18
  bcc _label_c74f                ; $C74A  90 03

_label_c74c:
  iny                            ; $C74C  C8
  sty  column_index_a                ; $C74D  84 5C

_label_c74f:
  lda  column_index_a                ; $C74F  A5 5C
  adc  column_index_b                ; $C751  65 5D
  ror a                          ; $C753  6A
  tay                            ; $C754  A8
  lda  poly_x_buffer,X      ; $C755  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C758  D9 05 D4
  lda  poly_y_buffer,X      ; $C75B  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C75E  F9 05 D5
  bcc _label_c768                ; $C761  90 05
  sty  column_index_b                ; $C763  84 5D
  clc                            ; $C765  18
  bcc _label_c76b                ; $C766  90 03

_label_c768:
  iny                            ; $C768  C8
  sty  column_index_a                ; $C769  84 5C

_label_c76b:
  lda  column_index_a                ; $C76B  A5 5C
  adc  column_index_b                ; $C76D  65 5D
  ror a                          ; $C76F  6A
  tay                            ; $C770  A8
  lda  poly_x_buffer,X      ; $C771  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C774  D9 05 D4
  lda  poly_y_buffer,X      ; $C777  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C77A  F9 05 D5
  bcc _label_c784                ; $C77D  90 05
  sty  column_index_b                ; $C77F  84 5D
  clc                            ; $C781  18
  bcc _label_c787                ; $C782  90 03

_label_c784:
  iny                            ; $C784  C8
  sty  column_index_a                ; $C785  84 5C

_label_c787:
  lda  column_index_a                ; $C787  A5 5C
  adc  column_index_b                ; $C789  65 5D
  ror a                          ; $C78B  6A
  tay                            ; $C78C  A8
  lda  poly_x_buffer,X      ; $C78D  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C790  D9 05 D4
  lda  poly_y_buffer,X      ; $C793  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C796  F9 05 D5
  bcc _label_c7a0                ; $C799  90 05
  sty  column_index_b                ; $C79B  84 5D
  clc                            ; $C79D  18
  bcc _label_c7a3                ; $C79E  90 03

_label_c7a0:
  iny                            ; $C7A0  C8
  sty  column_index_a                ; $C7A1  84 5C

_label_c7a3:
  lda  column_index_a                ; $C7A3  A5 5C
  adc  column_index_b                ; $C7A5  65 5D
  ror a                          ; $C7A7  6A
  tay                            ; $C7A8  A8
  lda  poly_x_buffer,X      ; $C7A9  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C7AC  D9 05 D4
  lda  poly_y_buffer,X      ; $C7AF  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C7B2  F9 05 D5
  bcc _label_c7bc                ; $C7B5  90 05
  sty  column_index_b                ; $C7B7  84 5D
  clc                            ; $C7B9  18
  bcc _label_c7bf                ; $C7BA  90 03

_label_c7bc:
  iny                            ; $C7BC  C8
  sty  column_index_a                ; $C7BD  84 5C

_label_c7bf:
  lda  column_index_a                ; $C7BF  A5 5C
  adc  column_index_b                ; $C7C1  65 5D
  ror a                          ; $C7C3  6A
  tay                            ; $C7C4  A8
  lda  poly_x_buffer,X      ; $C7C5  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C7C8  D9 05 D4
  lda  poly_y_buffer,X      ; $C7CB  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C7CE  F9 05 D5
  bcc _label_c7d8                ; $C7D1  90 05
  sty  column_index_b                ; $C7D3  84 5D
  clc                            ; $C7D5  18
  bcc _label_c7db                ; $C7D6  90 03

_label_c7d8:
  iny                            ; $C7D8  C8
  sty  column_index_a                ; $C7D9  84 5C

_label_c7db:
  lda  column_index_a                ; $C7DB  A5 5C
  adc  column_index_b                ; $C7DD  65 5D
  ror a                          ; $C7DF  6A
  tay                            ; $C7E0  A8
  lda  poly_x_buffer,X      ; $C7E1  BD 00 01
  cmp  _data_d405_indexed,Y     ; $C7E4  D9 05 D4
  lda  poly_y_buffer,X      ; $C7E7  BD 1C 01
  sbc  _data_d505_indexed,Y     ; $C7EA  F9 05 D5
  bcc _label_c7f4                ; $C7ED  90 05
  sty  column_index_b                ; $C7EF  84 5D
  clc                            ; $C7F1  18
  bcc _label_c7f7                ; $C7F2  90 03

_label_c7f4:
  iny                            ; $C7F4  C8
  sty  column_index_a                ; $C7F5  84 5C

_label_c7f7:
  ldy  polygon_visible,X      ; $C7F7  BC 38 01
  lda  _data_ca7d_indexed,Y     ; $C7FA  B9 7D CA
  sta  vertex_ptr        ; $C7FD  85 38
  lda  _data_ca81_indexed,Y     ; $C7FF  B9 81 CA
  sta  vertex_ptr_hi                ; $C802  85 39
  ldy  screen_column,X      ; $C804  BC 54 01
  lda (vertex_ptr),Y      ; $C807  B1 38
  sta  column_b                ; $C809  85 5B
  iny                            ; $C80B  C8
  lda (vertex_ptr),Y      ; $C80C  B1 38
  sta  column_a                ; $C80E  85 5A
  lda  column_index_a                ; $C810  A5 5C
  cmp #$FF                       ; $C812  C9 FF
  bne _label_c890                ; $C814  D0 7A
  ldy  poly_x_buffer,X      ; $C816  BC 00 01
  cpy  _data_d504               ; $C819  CC 04 D5
  bcs _label_c890                ; $C81C  B0 72
  stx  temp_b                ; $C81E  86 26
  ldx  poly_draw_index                ; $C820  A6 2B
  lda  column_flags                ; $C822  A5 59
  ora #$04                       ; $C824  09 04
  sta  framebuffer_a,X      ; $C826  9D 00 04
  sta  framebuffer_b,X      ; $C829  9D 80 04
  ldy  column_a                ; $C82C  A4 5A
  cpy #$80                       ; $C82E  C0 80
  rol  framebuffer_a,X      ; $C830  3E 00 04
  cpy #$80                       ; $C833  C0 80
  rol  framebuffer_a,X      ; $C835  3E 00 04
  cpy #$80                       ; $C838  C0 80
  rol  framebuffer_a,X      ; $C83A  3E 00 04
  cpy #$80                       ; $C83D  C0 80
  rol  framebuffer_a,X      ; $C83F  3E 00 04
  ldy  column_b                ; $C842  A4 5B
  cpy #$80                       ; $C844  C0 80
  rol  framebuffer_b,X      ; $C846  3E 80 04
  cpy #$80                       ; $C849  C0 80
  rol  framebuffer_b,X      ; $C84B  3E 80 04
  cpy #$80                       ; $C84E  C0 80
  rol  framebuffer_b,X      ; $C850  3E 80 04
  cpy #$80                       ; $C853  C0 80
  rol  framebuffer_b,X      ; $C855  3E 80 04
  lda  framebuffer_a,X      ; $C858  BD 00 04
  sta  framebuffer_a_1,X      ; $C85B  9D 01 04
  sta  framebuffer_a_2,X      ; $C85E  9D 02 04
  sta  framebuffer_a_3,X      ; $C861  9D 03 04
  sta  framebuffer_a_4,X      ; $C864  9D 04 04
  sta  framebuffer_a_5,X      ; $C867  9D 05 04
  sta  framebuffer_a_6,X      ; $C86A  9D 06 04
  sta  framebuffer_a_7,X      ; $C86D  9D 07 04
  lda  framebuffer_b,X      ; $C870  BD 80 04
  sta  framebuffer_b_1,X      ; $C873  9D 81 04
  sta  framebuffer_b_2,X      ; $C876  9D 82 04
  sta  framebuffer_b_3,X      ; $C879  9D 83 04
  sta  framebuffer_b_4,X      ; $C87C  9D 84 04
  sta  framebuffer_b_5,X      ; $C87F  9D 85 04
  sta  framebuffer_b_6,X      ; $C882  9D 86 04
  sta  framebuffer_b_7,X      ; $C885  9D 87 04
  clc                            ; $C888  18
  txa                            ; $C889  8A
  adc #$08                       ; $C88A  69 08
  tax                            ; $C88C  AA
  jmp _label_c9c8                ; $C88D  4C C8 C9

_label_c890:
  stx  temp_b                ; $C890  86 26
  ldx  poly_draw_index                ; $C892  A6 2B
  cmp #$21                       ; $C894  C9 21
  bcc _label_c89a                ; $C896  90 02
  lda #$20                       ; $C898  A9 20

_label_c89a:
  sta  column_index_b                ; $C89A  85 5D
  lsr a                          ; $C89C  4A
  lsr a                          ; $C89D  4A
  sta  column_count                ; $C89E  85 5E
  eor #$FF                       ; $C8A0  49 FF
  sec                            ; $C8A2  38
  adc #$08                       ; $C8A3  69 08
  sta  column_skip                ; $C8A5  85 5F
  lda  column_index_b                ; $C8A7  A5 5D
  and #$03                       ; $C8A9  29 03
  sta  column_loop                ; $C8AB  85 60
  ldy  temp_b                ; $C8AD  A4 26
  lda  polygon_visible,Y      ; $C8AF  B9 38 01
  bne _label_c8ca                ; $C8B2  D0 16
  ldy  column_count                ; $C8B4  A4 5E
  bne _label_c8bb                ; $C8B6  D0 03
  jmp _label_c963                ; $C8B8  4C 63 C9

_label_c8bb:
  lda #$00                       ; $C8BB  A9 00

_label_c8bd:
  sta  framebuffer_a,X      ; $C8BD  9D 00 04
  sta  framebuffer_b,X      ; $C8C0  9D 80 04
  inx                            ; $C8C3  E8
  dey                            ; $C8C4  88
  bne _label_c8bd                ; $C8C5  D0 F6
  jmp _label_c963                ; $C8C7  4C 63 C9

_label_c8ca:
  lda  column_index_a                ; $C8CA  A5 5C
  eor #$FF                       ; $C8CC  49 FF
  sta  column_temp                ; $C8CE  85 61
  ldy  column_count                ; $C8D0  A4 5E
  bne _label_c8d7                ; $C8D2  D0 03
  jmp _label_c963                ; $C8D4  4C 63 C9

_label_c8d7:
  lda  column_flags                ; $C8D7  A5 59
  sta  framebuffer_a,X      ; $C8D9  9D 00 04
  ora #$04                       ; $C8DC  09 04
  sta  framebuffer_b,X      ; $C8DE  9D 80 04
  sec                            ; $C8E1  38
  lda  column_temp                ; $C8E2  A5 61
  adc #$07                       ; $C8E4  69 07
  bcc _label_c8f1                ; $C8E6  90 09

_label_c8e8:
  asl  column_a                ; $C8E8  06 5A
  asl  column_b                ; $C8EA  06 5B
  sec                            ; $C8EC  38
  sbc  column_index_a                ; $C8ED  E5 5C
  bcs _label_c8e8                ; $C8EF  B0 F7

_label_c8f1:
  ldy  column_a                ; $C8F1  A4 5A
  cpy #$80                       ; $C8F3  C0 80
  rol  framebuffer_a,X      ; $C8F5  3E 00 04
  ldy  column_b                ; $C8F8  A4 5B
  cpy #$80                       ; $C8FA  C0 80
  rol  framebuffer_b,X      ; $C8FC  3E 80 04
  adc #$07                       ; $C8FF  69 07
  bcc _label_c90c                ; $C901  90 09

_label_c903:
  asl  column_a                ; $C903  06 5A
  asl  column_b                ; $C905  06 5B
  sec                            ; $C907  38
  sbc  column_index_a                ; $C908  E5 5C
  bcs _label_c903                ; $C90A  B0 F7

_label_c90c:
  ldy  column_a                ; $C90C  A4 5A
  cpy #$80                       ; $C90E  C0 80
  rol  framebuffer_a,X      ; $C910  3E 00 04
  ldy  column_b                ; $C913  A4 5B
  cpy #$80                       ; $C915  C0 80
  rol  framebuffer_b,X      ; $C917  3E 80 04
  adc #$07                       ; $C91A  69 07
  bcc _label_c927                ; $C91C  90 09

_label_c91e:
  asl  column_a                ; $C91E  06 5A
  asl  column_b                ; $C920  06 5B
  sec                            ; $C922  38
  sbc  column_index_a                ; $C923  E5 5C
  bcs _label_c91e                ; $C925  B0 F7

_label_c927:
  ldy  column_a                ; $C927  A4 5A
  cpy #$80                       ; $C929  C0 80
  rol  framebuffer_a,X      ; $C92B  3E 00 04
  ldy  column_b                ; $C92E  A4 5B
  cpy #$80                       ; $C930  C0 80
  rol  framebuffer_b,X      ; $C932  3E 80 04
  adc #$07                       ; $C935  69 07
  bcc _label_c942                ; $C937  90 09

_label_c939:
  asl  column_a                ; $C939  06 5A
  asl  column_b                ; $C93B  06 5B
  sec                            ; $C93D  38
  sbc  column_index_a                ; $C93E  E5 5C
  bcs _label_c939                ; $C940  B0 F7

_label_c942:
  ldy  column_a                ; $C942  A4 5A
  cpy #$80                       ; $C944  C0 80
  rol  framebuffer_a,X      ; $C946  3E 00 04
  ldy  column_b                ; $C949  A4 5B
  cpy #$80                       ; $C94B  C0 80
  rol  framebuffer_b,X      ; $C94D  3E 80 04
  sta  column_temp                ; $C950  85 61
  ldy  framebuffer_a,X      ; $C952  BC 00 04
  lda  _data_d610_indexed,Y     ; $C955  B9 10 D6
  sta  framebuffer_a,X      ; $C958  9D 00 04
  inx                            ; $C95B  E8
  dec  column_count                ; $C95C  C6 5E
  beq _label_c963                ; $C95E  F0 03
  jmp _label_c8d7                ; $C960  4C D7 C8

_label_c963:
  ldy  temp_b                ; $C963  A4 26
  lda  polygon_visible,Y      ; $C965  B9 38 01
  bne _label_c983                ; $C968  D0 19
  ldy  column_loop                ; $C96A  A4 60
  bne _label_c971                ; $C96C  D0 03
  jmp _label_c9b6                ; $C96E  4C B6 C9

_label_c971:
  dec  column_skip                ; $C971  C6 5F
  clc                            ; $C973  18
  tya                            ; $C974  98
  adc #$F1                       ; $C975  69 F1
  sta  framebuffer_a,X      ; $C977  9D 00 04
  adc #$03                       ; $C97A  69 03
  sta  framebuffer_b,X      ; $C97C  9D 80 04
  inx                            ; $C97F  E8
  jmp _label_c9b6                ; $C980  4C B6 C9

_label_c983:
  ldy  column_loop                ; $C983  A4 60
  beq _label_c9b6                ; $C985  F0 2F
  dec  column_skip                ; $C987  C6 5F
  lda  column_flags                ; $C989  A5 59
  sta  framebuffer_a,X      ; $C98B  9D 00 04
  ora #$04                       ; $C98E  09 04
  sta  framebuffer_b,X      ; $C990  9D 80 04
  sec                            ; $C993  38
  lda  column_temp                ; $C994  A5 61

_label_c996:
  adc #$07                       ; $C996  69 07
  bcc _label_c9a3                ; $C998  90 09

_label_c99a:
  asl  column_a                ; $C99A  06 5A
  asl  column_b                ; $C99C  06 5B
  sec                            ; $C99E  38
  sbc  column_index_a                ; $C99F  E5 5C
  bcs _label_c99a                ; $C9A1  B0 F7

_label_c9a3:
  ldy  column_a                ; $C9A3  A4 5A
  cpy #$80                       ; $C9A5  C0 80
  rol  framebuffer_a,X      ; $C9A7  3E 00 04
  ldy  column_b                ; $C9AA  A4 5B
  cpy #$80                       ; $C9AC  C0 80
  rol  framebuffer_b,X      ; $C9AE  3E 80 04
  dec  column_loop                ; $C9B1  C6 60
  bne _label_c996                ; $C9B3  D0 E1
  inx                            ; $C9B5  E8

_label_c9b6:
  ldy  column_skip                ; $C9B6  A4 5F
  beq _label_c9c8                ; $C9B8  F0 0E

_label_c9ba:
  lda #$F0                       ; $C9BA  A9 F0
  sta  framebuffer_a,X      ; $C9BC  9D 00 04
  lda #$F1                       ; $C9BF  A9 F1
  sta  framebuffer_b,X      ; $C9C1  9D 80 04
  inx                            ; $C9C4  E8
  dey                            ; $C9C5  88
  bne _label_c9ba                ; $C9C6  D0 F2

_label_c9c8:
  stx  poly_draw_index                ; $C9C8  86 2B
  ldx  temp_b                ; $C9CA  A6 26
  inx                            ; $C9CC  E8
  txa                            ; $C9CD  8A
  lsr a                          ; $C9CE  4A
  bcc _label_c9d4                ; $C9CF  90 03
  jmp _label_c704                ; $C9D1  4C 04 C7

_label_c9d4:
  lsr a                          ; $C9D4  4A
  bcc _label_c9da                ; $C9D5  90 03
  jmp _label_c6da                ; $C9D7  4C DA C6

_label_c9da:
  tay                            ; $C9DA  A8
  lda  temp_a                ; $C9DB  A5 25
  ora  polygon_flags        ; $C9DD  05 30
  sta  polygon_flags,Y      ; $C9DF  99 30 00
  inc  polygon_index                ; $C9E2  E6 2E
  cpx #$1C                       ; $C9E4  E0 1C
  beq _label_c9f1                ; $C9E6  F0 09
  lda  poly_draw_index                ; $C9E8  A5 2B
  and #$7F                       ; $C9EA  29 7F
  sta  poly_draw_index                ; $C9EC  85 2B
  jmp _label_c6b2                ; $C9EE  4C B2 C6

_label_c9f1:
  jsr _func_c073                 ; $C9F1  20 73 C0
  dec  frame_counter                ; $C9F4  C6 2D
  jmp _label_c2ce                ; $C9F6  4C CE C2

.byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80 ; $C9F9
.byte $80, $00, $00, $00, $00, $00, $00, $81, $00, $00, $00, $00, $00, $00, $00, $80 ; $CA09
.byte $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $80 ; $CA19
.byte $80, $00, $00, $00, $00, $00, $00, $82, $00, $00, $00, $00, $00, $00, $00, $80 ; $CA29
.byte $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $80 ; $CA39
.byte $80, $00, $00, $00, $00, $00, $00, $81, $00, $00, $00, $00, $00, $00, $00, $80 ; $CA49
.byte $80, $00, $00, $00, $00, $00, $00, $81, $00, $00, $00, $00, $00, $00, $00, $80 ; $CA59
.byte $80, $00, $00, $00, $00, $00, $81, $81, $00, $00, $00, $00, $00, $00, $00, $80 ; $CA69

_data_ca79_indexed:
.byte $80, $00, $00, $00         ; $CA79

_data_ca7d_indexed:
.byte $00, $00, $00, $00         ; $CA7D

_data_ca81_indexed:
.byte $00, $00, $00, $00, $00, $00, $00, $80, $80, $82, $00, $00, $00, $00, $00, $80 ; $CA81
.byte $80, $80, $80, $80, $80, $00, $82, $80, $80, $00, $00, $00, $00, $82, $00, $80 ; $CA91
.byte $83, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00, $80 ; $CAA1
.byte $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00, $80 ; $CAB1
.byte $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00, $80 ; $CAC1
.byte $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $80, $00, $80, $00, $00, $80 ; $CAD1
.byte $83, $00, $00, $00, $00, $00, $00, $80, $80, $80, $80, $ff, $80, $80, $80, $80 ; $CAE1
.byte $80, $80, $80, $80, $80, $80, $80, $80, $12, $16, $27, $29, $05, $15, $25, $05 ; $CAF1
.byte $cb, $cb, $cb, $cb, $ff, $ff, $11, $09, $f1, $f9, $91, $09, $9f, $09, $fd, $ff ; $CB01
.byte $15, $09, $15, $09, $3f, $3f, $21, $21, $21, $21, $e1, $e1, $e1, $e1, $21, $21 ; $CB11
.byte $21, $21, $3f, $3f, $ff, $ff, $05, $65, $fd, $85, $65, $1d, $1d, $65, $85, $fd ; $CB21
.byte $65, $05, $ff, $ff, $48, $8a, $48, $98, $48, $a5, $2e, $f0, $03, $4c, $e2, $cb ; $CB31
.byte $24, $2d, $30, $03, $4c, $df, $cb, $e6, $2d, $a5, $1b, $49, $03, $85, $1b, $a5 ; $CB41
.byte $28, $09, $03, $8d, $06, $20, $a9, $c0, $8d, $06, $20, $a9, $a8, $8d, $00, $20 ; $CB51
.byte $a2, $04, $a5, $31, $8d, $07, $20, $a5, $32, $8d, $07, $20, $a5, $33, $8d, $07 ; $CB61
.byte $20, $a5, $34, $8d, $07, $20, $a5, $35, $8d, $07, $20, $a5, $36, $8d, $07, $20 ; $CB71
.byte $a5, $37, $8d, $07, $20, $a9, $00, $8d, $07, $20, $ca, $d0, $d5, $a2, $0f, $a4 ; $CB81
.byte $1c, $a9, $3f, $8d, $06, $20, $a9, $00, $8d, $06, $20, $a9, $27, $8e, $07, $20 ; $CB91
.byte $8d, $07, $20, $8d, $07, $20, $8d, $07, $20, $8e, $07, $20, $8c, $07, $20, $a5 ; $CBA1
.byte $22, $8d, $07, $20, $a5, $24, $8d, $07, $20, $8e, $07, $20, $8c, $07, $20, $a5 ; $CBB1
.byte $23, $8d, $07, $20, $a5, $22, $8d, $07, $20, $8e, $07, $20, $8c, $07, $20, $a5 ; $CBC1
.byte $24, $8d, $07, $20, $a5, $23, $8d, $07, $20, $a9, $0e, $8d, $01, $20, $4c, $a9 ; $CBD1
.byte $cd, $a9, $ac, $8d, $00, $20, $a9, $03, $85, $2f, $a6, $2c, $a4, $27, $a5, $28 ; $CBE1
.byte $8d, $06, $20, $8c, $06, $20, $c8, $bd, $07, $04, $8d, $07, $20, $bd, $06, $04 ; $CBF1
.byte $8d, $07, $20, $bd, $05, $04, $8d, $07, $20, $bd, $04, $04, $8d, $07, $20, $bd ; $CC01
.byte $03, $04, $8d, $07, $20, $bd, $02, $04, $8d, $07, $20, $bd, $01, $04, $8d, $07 ; $CC11
.byte $20, $bd, $00, $04, $8d, $07, $20, $bd, $80, $04, $8d, $07, $20, $bd, $81, $04 ; $CC21
.byte $8d, $07, $20, $bd, $82, $04, $8d, $07, $20, $bd, $83, $04, $8d, $07, $20, $bd ; $CC31
.byte $84, $04, $8d, $07, $20, $bd, $85, $04, $8d, $07, $20, $bd, $86, $04, $8d, $07 ; $CC41
.byte $20, $bd, $87, $04, $8d, $07, $20, $a5, $28, $8d, $06, $20, $8c, $06, $20, $c8 ; $CC51
.byte $bd, $0f, $04, $8d, $07, $20, $bd, $0e, $04, $8d, $07, $20, $bd, $0d, $04, $8d ; $CC61
.byte $07, $20, $bd, $0c, $04, $8d, $07, $20, $bd, $0b, $04, $8d, $07, $20, $bd, $0a ; $CC71
.byte $04, $8d, $07, $20, $bd, $09, $04, $8d, $07, $20, $bd, $08, $04, $8d, $07, $20 ; $CC81
.byte $bd, $88, $04, $8d, $07, $20, $bd, $89, $04, $8d, $07, $20, $bd, $8a, $04, $8d ; $CC91
.byte $07, $20, $bd, $8b, $04, $8d, $07, $20, $bd, $8c, $04, $8d, $07, $20, $bd, $8d ; $CCA1
.byte $04, $8d, $07, $20, $bd, $8e, $04, $8d, $07, $20, $bd, $8f, $04, $8d, $07, $20 ; $CCB1
.byte $a5, $28, $8d, $06, $20, $8c, $06, $20, $c8, $bd, $17, $04, $8d, $07, $20, $bd ; $CCC1
.byte $16, $04, $8d, $07, $20, $bd, $15, $04, $8d, $07, $20, $bd, $14, $04, $8d, $07 ; $CCD1
.byte $20, $bd, $13, $04, $8d, $07, $20, $bd, $12, $04, $8d, $07, $20, $bd, $11, $04 ; $CCE1
.byte $8d, $07, $20, $bd, $10, $04, $8d, $07, $20, $bd, $90, $04, $8d, $07, $20, $bd ; $CCF1
.byte $91, $04, $8d, $07, $20, $bd, $92, $04, $8d, $07, $20, $bd, $93, $04, $8d, $07 ; $CD01
.byte $20, $bd, $94, $04, $8d, $07, $20, $bd, $95, $04, $8d, $07, $20, $bd, $96, $04 ; $CD11
.byte $8d, $07, $20, $bd, $97, $04, $8d, $07, $20, $a5, $28, $8d, $06, $20, $8c, $06 ; $CD21
.byte $20, $c8, $bd, $1f, $04, $8d, $07, $20, $bd, $1e, $04, $8d, $07, $20, $bd, $1d ; $CD31
.byte $04, $8d, $07, $20, $bd, $1c, $04, $8d, $07, $20, $bd, $1b, $04, $8d, $07, $20 ; $CD41
.byte $bd, $1a, $04, $8d, $07, $20, $bd, $19, $04, $8d, $07, $20, $bd, $18, $04, $8d ; $CD51
.byte $07, $20, $bd, $98, $04, $8d, $07, $20, $bd, $99, $04, $8d, $07, $20, $bd, $9a ; $CD61
.byte $04, $8d, $07, $20, $bd, $9b, $04, $8d, $07, $20, $bd, $9c, $04, $8d, $07, $20 ; $CD71
.byte $bd, $9d, $04, $8d, $07, $20, $bd, $9e, $04, $8d, $07, $20, $bd, $9f, $04, $8d ; $CD81
.byte $07, $20, $18, $8a, $69, $20, $29, $7f, $aa, $c6, $2e, $f0, $07, $c6, $2f, $f0 ; $CD91
.byte $03, $4c, $ef, $cb, $84, $27, $86, $2c, $a5, $1b, $8d, $00, $20, $a9, $f0, $8d ; $CDA1
.byte $05, $20, $a9, $d0, $8d, $05, $20, $68, $a8, $68, $aa, $68, $40 ; $CDB1

_func_cdbe:
  lda  _data_ca79_indexed,Y     ; $CDBE  B9 79 CA
  bit  clip_plane_0                ; $CDC1  24 22
  bmi set_clip_plane_0                ; $CDC3  30 12
  cmp  clip_plane_0                ; $CDC5  C5 22
  beq return_plane_0                ; $CDC7  F0 10
  bit  clip_plane_1                ; $CDC9  24 23
  bmi set_next_plane                ; $CDCB  30 0F
  cmp  clip_plane_1                ; $CDCD  C5 23
  beq return_plane_1                ; $CDCF  F0 0D
  bit  clip_plane_2                ; $CDD1  24 24
  bmi set_next_edge                ; $CDD3  30 0C
  bpl return_plane_code                ; $CDD5  10 0C

set_clip_plane_0:
  sta  clip_plane_0                ; $CDD7  85 22

return_plane_0:
  lda #$00                       ; $CDD9  A9 00
  rts                            ; $CDDB  60

set_next_plane:
  sta  clip_plane_1                ; $CDDC  85 23

return_plane_1:
  lda #$01                       ; $CDDE  A9 01
  rts                            ; $CDE0  60

set_next_edge:
  sta  clip_plane_2                ; $CDE1  85 24

return_plane_code:
  lda #$02                       ; $CDE3  A9 02
  rts                            ; $CDE5  60

_data_cde6_indexed:
.byte $a0, $b0, $b1, $c1, $c2, $d2, $d3, $e3, $e4, $f4, $f5, $f6, $06, $07, $17, $18 ; $CDE6
.byte $28, $29, $39, $3a, $4a, $02, $01, $02, $01, $02, $01, $02, $01, $02, $01, $02 ; $CDF6
.byte $01, $03, $0c, $04, $0b, $05, $0a, $06, $09, $07, $08, $07, $08, $07, $08, $07 ; $CE06
.byte $08, $07, $08, $07, $08, $02, $01, $02, $01, $02, $01, $02, $01, $02, $01, $00 ; $CE16
.byte $00, $07, $08, $07, $08, $07, $08, $07, $08, $07, $08 ; $CE26

_data_ce31_indexed:
.byte $ff, $aa, $ff, $88         ; $CE31

_data_ce35_indexed:
.byte $ff, $aa, $aa, $22         ; $CE35

_data_ce39_indexed:
.byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; $CE39
.byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; $CE49
.byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $29, $28, $27, $26, $25, $24 ; $CE59
.byte $23, $22, $21, $20, $1f, $1e, $1d, $1c, $1b, $1a, $19, $18, $17, $16, $15, $14 ; $CE69
.byte $13, $12, $11, $10, $0f, $0e, $0d, $0c, $0b, $0a, $09, $08, $07, $06, $05, $04 ; $CE79
.byte $03, $02, $01, $00, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b ; $CE89
.byte $8c, $8d, $8e, $8f, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b ; $CE99
.byte $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $a9, $a8 ; $CEA9
.byte $a7, $a6, $a5, $a4, $a3, $a2, $a1, $a0, $9f, $9e, $9d, $9c, $9b, $9a, $99, $98 ; $CEB9
.byte $97, $96, $95, $94, $93, $92, $91, $90, $8f, $8e, $8d, $8c, $8b, $8a, $89, $88 ; $CEC9
.byte $87, $86, $85, $84, $83, $82, $81, $80, $f1, $6a, $aa, $23, $6b, $15, $52, $0f ; $CED9
.byte $f0, $0b, $ca, $09, $4f, $08, $39, $07, $66, $06, $c0, $05, $3a, $05, $cc, $04 ; $CEE9
.byte $70, $04, $22, $04, $e0, $03, $a7, $03, $75, $03, $49, $03, $22, $03, $00, $03 ; $CEF9
.byte $e2, $02, $c7, $02, $af, $02, $99, $02, $85, $02, $74, $02, $64, $02, $56, $02 ; $CF09
.byte $49, $02, $3d, $02, $33, $02, $2a, $02, $22, $02, $1b, $02, $15, $02, $0f, $02 ; $CF19
.byte $0b, $02, $07, $02, $04, $02, $02, $02, $01, $02, $00, $02, $ca, $6a, $9d, $23 ; $CF29
.byte $63, $15, $4c, $0f, $ec, $0b, $c7, $09, $4c, $08, $37, $07, $63, $06, $bd, $05 ; $CF39
.byte $38, $05, $ca, $04, $6e, $04, $21, $04, $de, $03, $a5, $03, $73, $03, $48, $03 ; $CF49
.byte $21, $03, $ff, $02, $e1, $02, $c6, $02, $ae, $02, $98, $02, $84, $02, $73, $02 ; $CF59
.byte $63, $02, $55, $02, $48, $02, $3d, $02, $32, $02, $29, $02, $21, $02, $1a, $02 ; $CF69
.byte $14, $02, $0f, $02, $0a, $02, $07, $02, $04, $02, $01, $02, $00, $02, $ff, $01 ; $CF79
.byte $7e, $6a, $83, $23, $54, $15, $41, $0f, $e3, $0b, $c0, $09, $46, $08, $31, $07 ; $CF89
.byte $5f, $06, $b9, $05, $34, $05, $c7, $04, $6b, $04, $1e, $04, $dc, $03, $a3, $03 ; $CF99
.byte $71, $03, $45, $03, $1f, $03, $fd, $02, $df, $02, $c4, $02, $ac, $02, $96, $02 ; $CFA9
.byte $83, $02, $71, $02, $61, $02, $53, $02, $46, $02, $3b, $02, $31, $02, $28, $02 ; $CFB9
.byte $20, $02, $19, $02, $12, $02, $0d, $02, $09, $02, $05, $02, $02, $02, $00, $02 ; $CFC9
.byte $ff, $01, $fe, $01, $0b, $6a, $5d, $23, $3d, $15, $31, $0f, $d6, $0b, $b5, $09 ; $CFD9
.byte $3d, $08, $2a, $07, $58, $06, $b3, $05, $2e, $05, $c1, $04, $66, $04, $19, $04 ; $CFE9
.byte $d8, $03, $9f, $03, $6d, $03, $42, $03, $1c, $03, $fa, $02, $dc, $02, $c1, $02 ; $CFF9
.byte $a9, $02, $93, $02, $80, $02, $6e, $02, $5f, $02, $51, $02, $44, $02, $39, $02 ; $D009
.byte $2e, $02, $25, $02, $1d, $02, $16, $02, $10, $02, $0b, $02, $07, $02, $03, $02 ; $D019
.byte $00, $02, $fe, $01, $fc, $01, $fc, $01, $72, $69, $2a, $23, $1e, $15, $1b, $0f ; $D029
.byte $c5, $0b, $a7, $09, $31, $08, $1f, $07, $4f, $06, $ab, $05, $27, $05, $bb, $04 ; $D039
.byte $60, $04, $14, $04, $d2, $03, $99, $03, $68, $03, $3d, $03, $17, $03, $f6, $02 ; $D049
.byte $d8, $02, $bd, $02, $a5, $02, $90, $02, $7c, $02, $6b, $02, $5b, $02, $4d, $02 ; $D059
.byte $41, $02, $35, $02, $2b, $02, $22, $02, $1a, $02, $13, $02, $0d, $02, $08, $02 ; $D069
.byte $04, $02, $00, $02, $fd, $01, $fb, $01, $fa, $01, $f9, $01, $b4, $68, $eb, $22 ; $D079
.byte $f8, $14, $00, $0f, $b0, $0b, $96, $09, $22, $08, $12, $07, $43, $06, $a1, $05 ; $D089
.byte $1e, $05, $b2, $04, $58, $04, $0c, $04, $cb, $03, $93, $03, $62, $03, $37, $03 ; $D099
.byte $12, $03, $f0, $02, $d2, $02, $b8, $02, $a0, $02, $8b, $02, $78, $02, $67, $02 ; $D0A9
.byte $57, $02, $49, $02, $3d, $02, $31, $02, $27, $02, $1f, $02, $17, $02, $10, $02 ; $D0B9
.byte $0a, $02, $04, $02, $00, $02, $fc, $01, $fa, $01, $f7, $01, $f6, $01, $f5, $01 ; $D0C9
.byte $d0, $67, $9f, $22, $cb, $14, $df, $0e, $97, $0b, $81, $09, $10, $08, $03, $07 ; $D0D9
.byte $36, $06, $95, $05, $13, $05, $a8, $04, $4f, $04, $03, $04, $c3, $03, $8b, $03 ; $D0E9
.byte $5b, $03, $30, $03, $0b, $03, $ea, $02, $cc, $02, $b2, $02, $9a, $02, $85, $02 ; $D0F9
.byte $72, $02, $61, $02, $52, $02, $44, $02, $38, $02, $2d, $02, $23, $02, $1a, $02 ; $D109
.byte $12, $02, $0b, $02, $05, $02, $00, $02, $fc, $01, $f8, $01, $f5, $01, $f3, $01 ; $D119
.byte $f2, $01, $f1, $01, $c7, $66, $46, $22, $96, $14, $b9, $0e, $79, $0b, $69, $09 ; $D129
.byte $fc, $07, $f1, $06, $26, $06, $86, $05, $06, $05, $9c, $04, $44, $04, $f9, $03 ; $D139
.byte $b9, $03, $82, $03, $52, $03, $28, $03, $03, $03, $e2, $02, $c5, $02, $ab, $02 ; $D149
.byte $94, $02, $7f, $02, $6c, $02, $5b, $02, $4c, $02, $3e, $02, $32, $02, $27, $02 ; $D159
.byte $1d, $02, $15, $02, $0d, $02, $06, $02, $00, $02, $fb, $01, $f7, $01, $f3, $01 ; $D169
.byte $f0, $01, $ee, $01, $ed, $01, $ec, $01, $99, $65, $e2, $21, $59, $14, $8e, $0e ; $D179
.byte $57, $0b, $4d, $09, $e4, $07, $dd, $06, $14, $06, $76, $05, $f7, $04, $8e, $04 ; $D189
.byte $37, $04, $ed, $03, $ae, $03, $78, $03, $48, $03, $1f, $03, $fa, $02, $da, $02 ; $D199
.byte $bd, $02, $a3, $02, $8c, $02, $78, $02, $65, $02, $54, $02, $45, $02, $38, $02 ; $D1A9
.byte $2c, $02, $21, $02, $17, $02, $0e, $02, $07, $02, $00, $02, $fa, $01, $f5, $01 ; $D1B9
.byte $f1, $01, $ed, $01, $eb, $01, $e8, $01, $e7, $01, $e6, $01, $47, $64, $71, $21 ; $D1C9
.byte $15, $14, $5e, $0e, $32, $0b, $2e, $09, $ca, $07, $c6, $06, $00, $06, $64, $05 ; $D1D9
.byte $e6, $04, $7f, $04, $29, $04, $e0, $03, $a2, $03, $6c, $03, $3e, $03, $15, $03 ; $D1E9
.byte $f0, $02, $d0, $02, $b4, $02, $9b, $02, $84, $02, $6f, $02, $5d, $02, $4d, $02 ; $D1F9
.byte $3e, $02, $30, $02, $24, $02, $1a, $02, $10, $02, $08, $02, $00, $02, $f9, $01 ; $D209
.byte $f4, $01, $ef, $01, $ea, $01, $e7, $01, $e4, $01, $e2, $01, $e1, $01, $e0, $01 ; $D219
.byte $d1, $62, $f4, $20, $ca, $13, $28, $0e, $08, $0b, $0c, $09, $ad, $07, $ad, $06 ; $D229
.byte $e9, $05, $50, $05, $d4, $04, $6e, $04, $1a, $04, $d2, $03, $95, $03, $60, $03 ; $D239
.byte $31, $03, $09, $03, $e5, $02, $c6, $02, $aa, $02, $91, $02, $7a, $02, $66, $02 ; $D249
.byte $54, $02, $44, $02, $35, $02, $28, $02, $1c, $02, $12, $02, $08, $02, $00, $02 ; $D259
.byte $f9, $01, $f2, $01, $ec, $01, $e7, $01, $e3, $01, $e0, $01, $dd, $01, $db, $01 ; $D269
.byte $da, $01, $d9, $01, $38, $61, $6c, $20, $78, $13, $ed, $0d, $da, $0a, $e6, $08 ; $D279
.byte $8d, $07, $91, $06, $d1, $05, $3a, $05, $c0, $04, $5c, $04, $09, $04, $c2, $03 ; $D289
.byte $86, $03, $52, $03, $24, $03, $fc, $02, $d9, $02, $ba, $02, $9f, $02, $86, $02 ; $D299
.byte $70, $02, $5c, $02, $4b, $02, $3b, $02, $2c, $02, $1f, $02, $14, $02, $09, $02 ; $D2A9
.byte $00, $02, $f8, $01, $f0, $01, $ea, $01, $e4, $01, $df, $01, $db, $01, $d8, $01 ; $D2B9
.byte $d5, $01, $d3, $01, $d2, $01, $d1, $01, $7b, $5f, $d8, $1f, $1f, $13, $ae, $0d ; $D2C9
.byte $a9, $0a, $be, $08, $6b, $07, $73, $06, $b6, $05, $22, $05, $aa, $04, $48, $04 ; $D2D9
.byte $f6, $03, $b1, $03, $76, $03, $42, $03, $16, $03, $ef, $02, $cc, $02, $ae, $02 ; $D2E9
.byte $93, $02, $7b, $02, $65, $02, $52, $02, $40, $02, $30, $02, $22, $02, $16, $02 ; $D2F9
.byte $0a, $02, $00, $02, $f7, $01, $ef, $01, $e8, $01, $e1, $01, $dc, $01, $d7, $01 ; $D309
.byte $d3, $01, $d0, $01, $cd, $01, $cb, $01, $ca, $01, $c9, $01, $9d, $5d, $38, $1f ; $D319
.byte $c0, $12, $69, $0d, $73, $0a, $92, $08, $46, $07, $53, $06, $9a, $05, $08, $05 ; $D329
.byte $93, $04, $33, $04, $e2, $03, $9e, $03, $64, $03, $32, $03, $06, $03, $e0, $02 ; $D339
.byte $be, $02, $a0, $02, $86, $02, $6e, $02, $59, $02, $46, $02, $35, $02, $25, $02 ; $D349
.byte $18, $02, $0b, $02, $00, $02, $f6, $01, $ed, $01, $e5, $01, $de, $01, $d8, $01 ; $D359
.byte $d2, $01, $ce, $01, $ca, $01, $c7, $01, $c4, $01, $c2, $01, $c1, $01, $c0, $01 ; $D369

_data_d379_indexed:
.byte $f1, $6a, $9d, $23, $54, $15, $31, $0f, $c5, $0b, $96, $09, $10, $08, $f1, $06 ; $D379
.byte $14, $06, $64, $05, $d4, $04, $5c, $04, $f6, $03, $9e, $03, $52, $03, $0e, $03 ; $D389
.byte $d2, $02, $9b, $02, $6a, $02, $3d, $02, $14, $02, $ed, $01, $ca, $01, $a8, $01 ; $D399
.byte $89, $01, $6b, $01, $4f, $01, $35, $01, $1b, $01, $02, $01, $eb, $00, $d4, $00 ; $D3A9
.byte $be, $00, $a8, $00, $94, $00, $7f, $00, $6b, $00, $57, $00, $43, $00, $30, $00 ; $D3B9
.byte $1d, $00, $0a, $00         ; $D3C9

_data_d3cd_indexed:
.byte $25, $d1, $7d, $29, $d5, $81, $2d, $d9, $85, $31, $dd, $89, $35, $e1, $e1, $35 ; $D3CD
.byte $89, $dd, $31, $85, $d9, $2d, $81, $d5, $29, $7d, $d1, $25 ; $D3DD

_data_d3e9_indexed:
.byte $d3, $d2, $d2, $d2, $d1, $d1, $d1, $d0, $d0, $d0, $cf, $cf, $cf, $ce, $ce, $cf ; $D3E9
.byte $cf, $cf, $d0, $d0, $d0, $d1, $d1, $d1, $d2, $d2, $d2, $d3 ; $D3F9

_data_d405_indexed:
.byte $01, $01, $34, $dc, $01, $a3, $9e, $67, $b5, $5f, $4a, $65, $a4, $01, $73, $f8 ; $D405
.byte $8c, $2c, $d7, $8a, $45, $06, $cd, $99, $69, $3d, $14, $ee, $cb, $aa, $8b, $6e ; $D415
.byte $53, $3a, $22, $0b, $f6, $e2, $cf, $bc, $ab, $9b, $8b, $7c, $6e, $60, $53, $47 ; $D425
.byte $3b, $2f, $24, $19, $0f, $05, $fc, $f3, $ea, $e1, $d9, $d1, $c9, $c2, $bb, $b4 ; $D435
.byte $ad, $a7, $a0, $9a, $94, $8e, $89, $83, $7e, $79, $74, $6f, $6a, $65, $61, $5c ; $D445
.byte $58, $54, $50, $4c, $48, $44, $40, $3c, $39, $35, $32, $2f, $2b, $28, $25, $22 ; $D455
.byte $1f, $1c, $19, $16, $14, $11, $0e, $0c, $09, $07, $04, $02, $ff, $fd, $fb, $f8 ; $D465
.byte $f6, $f4, $f2, $f0, $ee, $ec, $ea, $e8, $e6, $e4, $e2, $e0, $df, $dd, $db, $d9 ; $D475
.byte $d8, $d6, $d4, $d3, $d1, $d0, $ce, $cd, $cb, $ca, $c8, $c7, $c5, $c4, $c3, $c1 ; $D485
.byte $c0, $bf, $bd, $bc, $bb, $b9, $b8, $b7, $b6, $b5, $b3, $b2, $b1, $b0, $af, $ae ; $D495
.byte $ad, $ac, $ab, $aa, $a9, $a8, $a7, $a6, $a5, $a4, $a3, $a2, $a1, $a0, $9f, $9e ; $D4A5
.byte $9d, $9c, $9b, $9b, $9a, $99, $98, $97, $96, $96, $95, $94, $93, $92, $92, $91 ; $D4B5
.byte $90, $8f, $8f, $8e, $8d, $8c, $8c, $8b, $8a, $8a, $89, $88, $88, $87, $86, $86 ; $D4C5
.byte $85, $84, $84, $83, $83, $82, $81, $81, $80, $80, $7f, $7e, $7e, $7d, $7d, $7c ; $D4D5
.byte $7c, $7b, $7b, $7a, $79, $79, $78, $78, $77, $77, $76, $76, $75, $75, $74, $74 ; $D4E5
.byte $73, $73, $73, $72, $72, $71, $71, $70, $70, $6f, $6f, $6e, $6e, $6e, $6d ; $D4F5

_data_d504:
.byte $6d                        ; $D504

_data_d505_indexed:
.byte $d8, $48, $2b, $1e, $18, $13, $10, $0e, $0c, $0b, $0a, $09, $08, $08, $07, $06 ; $D505
.byte $06, $06, $05, $05, $05, $05, $04, $04, $04, $04, $04, $03, $03, $03, $03, $03 ; $D515
.byte $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02 ; $D525
.byte $02, $02, $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; $D535
.byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; $D545
.byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01 ; $D555
.byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00 ; $D565
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D575
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D585
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D595
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D5A5
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D5B5
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D5C5
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D5D5
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D5E5
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D5F5

_data_d605_indexed:
.byte $11, $a2, $51, $ff, $62, $22, $b3, $ff, $91, $73, $33 ; $D605

_data_d610_indexed:
.byte $40, $48, $44, $4c, $42, $4a, $46, $4e, $41, $49, $45, $4d, $43, $4b, $47, $4f ; $D610
.byte $50, $58, $54, $5c, $52, $5a, $56, $5e, $51, $59, $55, $5d, $53, $5b, $57, $5f ; $D620
.byte $60, $68, $64, $6c, $62, $6a, $66, $6e, $61, $69, $65, $6d, $63, $6b, $67, $6f ; $D630
.byte $70, $78, $74, $7c, $72, $7a, $76, $7e, $71, $79, $75, $7d, $73, $7b, $77, $7f ; $D640

_data_d650_indexed:
.byte $00, $0a, $13, $1d, $26, $30, $39, $42, $4b, $55, $5e, $66, $6f, $78, $80, $88 ; $D650
.byte $90, $98, $a0, $a7, $ae, $b5, $bc, $c2, $c8, $ce, $d4, $d9, $de, $e2, $e7, $eb ; $D660
.byte $ee, $f2, $f5, $f7, $fa, $fc, $fd, $fe, $ff, $00, $00, $00, $ff, $fe, $fd, $fc ; $D670
.byte $fa, $f7, $f5, $f2, $ee, $eb, $e7, $e2, $de, $d9, $d4, $ce, $c8, $c2, $bc, $b5 ; $D680
.byte $ae, $a7, $a0, $98, $90, $88, $80, $78, $6f, $66, $5e, $55, $4b, $42, $39, $30 ; $D690
.byte $26, $1d, $13, $0a, $00, $f6, $ed, $e3, $da, $d0, $c7, $be, $b5, $ab, $a2, $9a ; $D6A0
.byte $91, $88, $80, $78, $70, $68, $60, $59, $52, $4b, $44, $3e, $38, $32, $2c, $27 ; $D6B0
.byte $22, $1e, $19, $15, $12, $0e, $0b, $09, $06, $04, $03, $02, $01, $00, $00, $00 ; $D6C0
.byte $01, $02, $03, $04, $06, $09, $0b, $0e, $12, $15, $19, $1e, $22, $27, $2c, $32 ; $D6D0
.byte $38, $3e, $44, $4b, $52, $59, $60, $68, $70, $78, $80, $88, $91, $9a, $a2, $ab ; $D6E0
.byte $b5, $be, $c7, $d0, $da, $e3, $ed, $f6 ; $D6F0

_data_d6f8_indexed:
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D6F8
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D708
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $00, $00, $00, $00 ; $D718
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D728
.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $D738
.byte $00, $00, $00, $00, $00, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; $D748
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; $D758
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; $D768
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; $D778
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; $D788
.byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; $D798


.segment "CHARS"
  .incbin "assets/3dRenderer.chr"

; Sprite Attribute Memory (OAM) - 256 bytes at $0200-$02FF
; This segment is used for sprite data that gets transferred to the PPU
; Each sprite takes 4 bytes: Y position, tile index, attributes, X position
                        ; Reserve 256 bytes for OAM data
.segment "OAM"
.res 256

