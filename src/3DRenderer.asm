;---------------------------------------
; Fake 3D NES maze engine (no raycasting)
; Converted for CA65
;---------------------------------------

.segment "HEADER"
    .byte 'N', 'E', 'S', $1A
    .byte 1      ; 1 x 16KB PRG-ROM
    .byte 1      ; 1 x 8KB CHR-ROM
    .byte 0      ; mapper, mirroring
    .byte 0, 0, 0, 0, 0, 0, 0, 0

.segment "ZEROPAGE"
player_x:     .res 1
player_y:     .res 1
player_dir:   .res 1
ptr:          .res 2

.segment "BSS"
temp_x:       .res 1
temp_y:       .res 1
temp_dir:     .res 1

.segment "CODE"
.org $8000

reset:
    sei
    cld
    ldx #$ff
    txs

    lda #$00
    sta $2000
    sta $2001
    sta $4010

    jsr wait_vblank
    jsr draw_view
    jsr wait_vblank

    lda #%10000000
    sta $2000
    lda #%00011110
    sta $2001

main_loop:
    jmp main_loop

wait_vblank:
    bit $2002
    bpl wait_vblank
    rts

draw_view:
    lda player_dir
    sta temp_dir

    lda player_x
    sta temp_x
    lda player_y
    sta temp_y

    ldx #0
view_loop:
    jsr step_forward

    lda temp_x
    cmp #8
    bcs skip_draw
    lda temp_y
    cmp #8
    bcs skip_draw

    ldy temp_y
    lda map_row_lo,y
    sta ptr
    lda map_row_hi,y
    sta ptr+1
    ldy temp_x
    lda (ptr),y

    cmp #1
    beq draw_wall

skip_draw:
    inx
    cpx #3
    bne view_loop
    rts

draw_wall:
    lda wall_tile,x
    sta $2006
    lda wall_column,x
    sta $2006
    lda #$01
    sta $2007
    rts

step_forward:
    ldy temp_dir
    lda dir_dx,y
    clc
    adc temp_x
    sta temp_x
    lda dir_dy,y
    clc
    adc temp_y
    sta temp_y
    rts

dir_dx:
    .byte $00, $01, $00, $FF   ; 0, +1, 0, -1

dir_dy:
    .byte $FF, $00, $01, $00   ; -1, 0, +1, 0


wall_tile:
    .byte $20, $20, $20
wall_column:
    .byte $70, $78, $7C

.segment "RODATA"
map_row_lo:
    .lobytes map0, map1, map2, map3, map4, map5, map6, map7
map_row_hi:
    .hibytes map0, map1, map2, map3, map4, map5, map6, map7

map0: .byte 1,1,1,1,1,1,1,1
map1: .byte 1,0,0,0,0,0,0,1
map2: .byte 1,0,1,0,1,0,0,1
map3: .byte 1,0,1,0,1,0,0,1
map4: .byte 1,0,0,0,0,1,0,1
map5: .byte 1,0,1,1,0,0,0,1
map6: .byte 1,0,0,0,0,0,0,1
map7: .byte 1,1,1,1,1,1,1,1

.segment "VECTORS"
    .word 0         ; NMI vector (placeholder)
    .word reset     ; RESET vector
    .word 0         ; IRQ vector (placeholder)
