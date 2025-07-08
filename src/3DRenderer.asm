; NES Minimal Raycasting Wireframe Example
.include "nes.inc"

.segment "HEADER"
.byte 'N', 'E', 'S', $1a
.byte $02
.byte $01
.byte $00, $00

.segment "VECTORS"
.addr nmi
.addr reset
.addr irq

.segment "ZEROPAGE"
player_x: .res 1
player_y: .res 1
player_angle: .res 1
sprite_index: .res 1
temp_var: .res 1
temp_ptr_low: .res 1
temp_ptr_high: .res 1
controller_state: .res 1
controller_prev: .res 1

.segment "OAM"
oam: .res 256

.segment "CODE"
.proc nmi
  RTI
.endproc

.proc irq
  RTI
.endproc

.segment "STARTUP"
.proc reset
  SEI
  CLD
  LDX #$FF
  TXS
  ; Disable rendering
  LDA #$00
  STA PPU_CONTROL
  STA PPU_MASK
: BIT PPU_STATUS
  BPL :-
  ; Set palette (hardcoded)
  LDA #$3F
  STA $2006
  LDA #$00
  STA $2006
  LDA #$0F
  STA $2007
  LDA #$21
  STA $2007
  LDA #$11
  STA $2007
  LDA #$31
  STA $2007
  ; Initialize player
  LDA #$20
  STA player_x
  LDA #$20
  STA player_y
  LDA #$00
  STA player_angle
  ; Enable rendering (sprites only), force sprite pattern table $0000
  LDA #%00000000
  STA PPU_CONTROL
  LDA #$10
  STA PPU_MASK
  JMP main
.endproc

; === Controller Input Routine ===
.proc read_controller
    LDA controller_state
    STA controller_prev
    LDA #$01
    STA $4016
    LDA #$00
    STA $4016
    LDX #$08
read_loop:
    LDA $4016
    LSR A
    ROL controller_state
    DEX
    BNE read_loop
    RTS
.endproc

; === Player Movement Routine ===
.proc update_player
    JSR read_controller
    LDA controller_state
    STA temp_var
    ; D-Pad Left (bit 6)
    LDA temp_var
    AND #%01000000
    BEQ not_left
    LDA player_angle
    SEC
    SBC #4            ; Turn left
    STA player_angle
not_left:
    ; D-Pad Right (bit 7)
    LDA temp_var
    AND #%10000000
    BEQ not_right
    LDA player_angle
    CLC
    ADC #4            ; Turn right
    STA player_angle
not_right:
    ; D-Pad Up (bit 4) - move forward
    LDA temp_var
    AND #%00010000
    BEQ not_up
    LDA player_angle
    AND #$3F          ; 0-63 for 0-360 deg
    TAX
    LDA sine_table, X ; sin(angle)
    CLC
    ADC player_y
    STA player_y
    LDA sine_table+64, X ; cos(angle) (sine + 64)
    CLC
    ADC player_x
    STA player_x
not_up:
    ; D-Pad Down (bit 5) - move backward
    LDA temp_var
    AND #%00100000
    BEQ not_down
    LDA player_angle
    AND #$3F
    TAX
    LDA player_y
    SEC
    SBC sine_table, X
    STA player_y
    LDA player_x
    SEC
    SBC sine_table+64, X
    STA player_x
not_down:
    RTS
.endproc

; Simple 8x8 map (1=wall, 0=empty)
.segment "RODATA"
map_data:
.byte 1,1,1,1,1,1,1,1
.byte 1,0,0,0,0,0,0,1
.byte 1,0,1,0,1,0,0,1
.byte 1,0,1,0,1,0,0,1
.byte 1,0,0,0,0,1,0,1
.byte 1,0,1,1,0,0,0,1
.byte 1,0,0,0,0,0,0,1
.byte 1,1,1,1,1,1,1,1

sine_table:
.byte 0, 3, 6, 9, 12, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46
.byte 49, 52, 55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85, 88, 91, 94
.byte 96, 99, 102, 105, 108, 110, 113, 116, 118, 121, 124, 126, 127, 127, 127, 127
.byte 127, 127, 127, 127, 126, 124, 121, 118, 116, 113, 110, 108, 105, 102, 99, 96
.byte 94, 91, 88, 85, 82, 79, 76, 73, 70, 67, 64, 61, 58, 55, 52, 49
.byte 46, 43, 40, 37, 34, 31, 28, 25, 22, 19, 16, 12, 9, 6, 3, 0

bitmasks:
.byte $01, $02, $04, $08, $10, $20, $40, $80

ray_angle_offsets:
.byte $F0,$F4,$F8,$FC,$00,$04,$08,$0C,$10,$14,$18,$1C,$20,$24,$28,$2C
.byte $30,$34,$38,$3C,$40,$44,$48,$4C,$50,$54,$58,$5C,$60,$64,$68,$6C

.segment "CODE"
.proc raycast_and_render
    LDX #$00
    STX sprite_index
    ; Draw a sprite at the player's current position
    LDY sprite_index
    LDA player_y
    STA oam, Y
    LDA #$00
    STA oam+1, Y
    LDA #$00
    STA oam+2, Y
    LDA player_x
    STA oam+3, Y
    LDA sprite_index
    CLC
    ADC #4
    STA sprite_index
    ; For each ray, draw a sprite at a fixed Y (debug)
    LDX #$00
ray_loop:
    LDY sprite_index
    LDA #100
    STA oam, Y
    ; Cycle through tile indices 0,1,2,3 for each sprite
    LDA sprite_index
    LSR A
    LSR A
    AND #$03
    STA oam+1, Y
    LDA #$00
    STA oam+2, Y
    TXA
    ASL A
    ASL A
    CLC
    ADC #32
    STA oam+3, Y
    LDA sprite_index
    CLC
    ADC #4
    STA sprite_index
    INX
    CPX #32
    BNE ray_loop
    RTS
.endproc

.proc main
main_loop:
    JSR update_player
    JSR raycast_and_render
    LDA #$00
    STA PPU_SPRRAM_ADDRESS
    LDA #>oam
    STA $4014
    JMP main_loop
.endproc

.segment "CHARS"
  .incbin "assets/tiles.chr"
