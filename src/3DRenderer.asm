; NES Raycasting Demo: Modified NES Assembly Source
; Includes: basic raycasting engine on background tiles

.include "nes.inc"
.include "macros.inc"

.segment "HEADER"
.byte 'N', 'E', 'S', $1a
.byte $02
.byte $01
.byte $00, $00

.segment "VECTORS"
.addr nmi_handler
.addr reset_handler
.addr irq_handler

.segment "ZEROPAGE"
temp_var:       .res 1
controller_1:   .res 1
player_x:       .res 1
player_y:       .res 1
player_dir_x:   .res 1
player_dir_y:   .res 1
camera_plane_x: .res 1
camera_plane_y: .res 1

.segment "OAM"
oam: .res 256

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.proc nmi_handler
  LDA #0
  STA PPU_SCROLL
  STA PPU_SCROLL
  RTS
.endproc

.proc set_palette
    vram_set_address(PALETTE_ADDRESS)
    LDX #0
@loop:
    LDA palette_data, X
    STA PPU_VRAM_IO
    INX
    CPX #$20
    BNE @loop
    RTS
.endproc

.proc init_player
  LDA #$30
  STA player_x
  LDA #$30
  STA player_y
  LDA #$10
  STA player_dir_x
  LDA #$00
  STA player_dir_y
  LDA #$00
  STA camera_plane_x
  LDA #$08
  STA camera_plane_y
  RTS
.endproc

.proc cast_rays
    LDX #0
ray_loop:
    LDA PPU_STATUS
    LDA #$20
    STA PPU_ADDRESS
    TXA
    CLC
    ADC #$80
    STA PPU_ADDRESS
    LDA #$10
    STA PPU_VRAM_IO
    INX
    CPX #16
    BNE ray_loop
    RTS
.endproc

.proc update_player
  LDA controller_1
  AND #PAD_L
  BEQ not_left
    LDA player_x
    SEC
    SBC #1
    STA player_x
not_left:
  LDA controller_1
  AND #PAD_R
  BEQ not_right
    LDA player_x
    CLC
    ADC #1
    STA player_x
not_right:
  LDA controller_1
  AND #PAD_U
  BEQ not_up
    LDA player_y
    SEC
    SBC #1
    STA player_y
not_up:
  LDA controller_1
  AND #PAD_D
  BEQ not_down
    LDA player_y
    CLC
    ADC #1
    STA player_y
not_down:
  RTS
.endproc

.proc read_controller
  LDA #1
  STA JOYPAD1
  LDA #0
  STA JOYPAD1
  LDX #8
  LDA #0
  STA controller_1
read_loop:
  LDA JOYPAD1
  LSR A
  ROL controller_1
  DEX
  BNE read_loop
  RTS
.endproc

.proc main
  LDA #0
  STA PPU_CONTROL
  STA PPU_MASK
: BIT PPU_STATUS
  BPL :-
: BIT PPU_STATUS
  BPL :-
  JSR set_palette
  JSR init_player
: BIT PPU_STATUS
  BPL :-
  LDA #(PPUCTRL_ENABLE_NMI)
  STA PPU_CONTROL
  LDA #(PPUMASK_SHOW_BG | PPUMASK_SHOW_SPRITES)
  STA PPU_MASK
: BIT PPU_STATUS
  BPL :-
forever:
  wait_for_vblank()
  JSR read_controller
  JSR update_player
  JSR cast_rays
  JMP forever
.endproc

.segment "RODATA"
palette_data:
  .incbin "assets/palette.pal"

.segment "CHARS"
  .incbin "assets/tiles.chr"

.segment "STARTUP"
.proc reset_handler
  SEI
  CLD
  LDX #$40
  STX $4017
  LDX #$FF
  TXS
  LDA #0
  STA PPU_CONTROL
  STA PPU_MASK
: BIT PPU_STATUS
  BPL :-
  clear_oam(oam)
: BIT PPU_STATUS
  BPL :-
  JMP main
.endproc

.segment "RODATA"
map_data:
  .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
  .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
  .byte 1,0,0,0,0,1,1,0,0,1,1,0,0,0,0,1
  .byte 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1
  .byte 1,0,0,1,1,1,0,0,0,0,1,1,1,0,0,1
  .byte 1,0,0,1,0,0,0,1,1,0,0,0,1,0,0,1
  .byte 1,0,0,1,0,0,0,1,1,0,0,0,1,0,0,1
  .byte 1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1
  .byte 1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1
  .byte 1,0,0,1,0,0,0,1,1,0,0,0,1,0,0,1
  .byte 1,0,0,1,0,0,0,1,1,0,0,0,1,0,0,1
  .byte 1,0,0,1,1,1,0,0,0,0,1,1,1,0,0,1
  .byte 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1
  .byte 1,0,0,0,0,1,1,0,0,1,1,0,0,0,0,1
  .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
  .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
