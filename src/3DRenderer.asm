; NES Raycaster Skeleton (ca65)
; Step 1: Project skeleton with reset, NMI, main loop, PPU/controller init

	.segment "HEADER"
	.byte "NES"
	.byte $1A
	.byte 2		; 16KB PRG-ROM banks
	.byte 1		; 8KB CHR-ROM banks
	.byte %00000001	; Mapper 0, vertical mirroring
	.byte $00		; Mapper 0
	.byte 0		; PRG-RAM size
	.byte 0		; TV system
	.byte 0		; TV system, PRG-RAM presence
	.byte 0		; Reserved
	.byte 0		; Reserved
	.byte 0		; Reserved
	.byte 0		; Reserved

	.segment "STARTUP"
	; Startup code can go here if needed

	.segment "CHARS"
	; Tile data for raycaster
	; Tile 0: Empty/background (all zeros)
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00

	; Tile 1: Wall (solid)
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

	; Tile 2: Wall (brick pattern)
	.byte $AA,$55,$AA,$55,$AA,$55,$AA,$55
	.byte $AA,$55,$AA,$55,$AA,$55,$AA,$55

	; Tile 3: Wall (striped)
	.byte $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0
	.byte $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0

	; Tile 4: Wall (dots)
	.byte $88,$22,$88,$22,$88,$22,$88,$22
	.byte $88,$22,$88,$22,$88,$22,$88,$22

	; Tile 5: Wall (crosshatch)
	.byte $AA,$55,$AA,$55,$AA,$55,$AA,$55
	.byte $55,$AA,$55,$AA,$55,$AA,$55,$AA

	; Tile 6: Wall (vertical lines)
	.byte $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC
	.byte $CC,$CC,$CC,$CC,$CC,$CC,$CC,$CC

	; Tile 7: Wall (horizontal lines)
	.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00
	.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00

	; Tile 8: Wall (diagonal)
	.byte $80,$40,$20,$10,$08,$04,$02,$01
	.byte $80,$40,$20,$10,$08,$04,$02,$01

	; Tile 9: Wall (inverse diagonal)
	.byte $01,$02,$04,$08,$10,$20,$40,$80
	.byte $01,$02,$04,$08,$10,$20,$40,$80

	; Tile 10: Wall (checkerboard small)
	.byte $CC,$CC,$33,$33,$CC,$CC,$33,$33
	.byte $CC,$CC,$33,$33,$CC,$CC,$33,$33

	; Tile 11: Wall (dots sparse)
	.byte $80,$00,$00,$00,$80,$00,$00,$00
	.byte $80,$00,$00,$00,$80,$00,$00,$00

	; Tile 12: Wall (zigzag)
	.byte $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F
	.byte $F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F

	; Tile 13: Wall (weave)
	.byte $AA,$55,$AA,$55,$AA,$55,$AA,$55
	.byte $55,$AA,$55,$AA,$55,$AA,$55,$AA

	; Tile 14: Wall (grid)
	.byte $FF,$81,$81,$81,$81,$81,$81,$FF
	.byte $FF,$81,$81,$81,$81,$81,$81,$FF

	; Tile 15: Wall (circles)
	.byte $3C,$42,$81,$81,$81,$81,$42,$3C
	.byte $3C,$42,$81,$81,$81,$81,$42,$3C

	; Fill the rest with zeros
	.res 7936	; 8192 - 256 = 7936 bytes remaining
	; TODO: Add actual tile data here

	.segment "OAM"
	; Sprite OAM data
	.res 256	; 256 bytes for OAM

	.segment "ZEROPAGE"
controller_state: .res 1 ; Holds current controller state
player_x_lo:    .res 1 ; Player X position, low byte (8.8 fixed)
player_x_hi:    .res 1 ; Player X position, high byte
player_y_lo:    .res 1 ; Player Y position, low byte
player_y_hi:    .res 1 ; Player Y position, high byte
player_angle:   .res 1 ; Player angle (0-255 = 0-360 degrees)
player_speed:   .res 1 ; Player speed (8.8 fixed, e.g. $01 = 1/256)

; --- Movement Flags (ZEROPAGE) ---
.segment "ZEROPAGE"
move_up:    .res 1 ; Set if Up is pressed
move_down:  .res 1 ; Set if Down is pressed
move_left:  .res 1 ; Set if Left is pressed
move_right: .res 1 ; Set if Right is pressed

	.segment "BSS"
; (Room for variables later)

	.segment "RODATA"
; (Room for tables later)
; --- Map Data (ROM) ---
.segment "RODATA"
map_width:  .byte 6
map_height: .byte 19
map_data:
    .byte 1,1,1,1,1,1
    .byte 2,0,0,0,0,3
    .byte 2,0,0,0,0,3
    .byte 2,0,0,0,0,3
    .byte 2,0,0,0,0,3
    .byte 4,4,0,0,4,4
    .byte 0,1,0,0,1,0
    .byte 0,1,0,0,1,0
    .byte 0,1,0,0,1,0
    .byte 0,1,0,0,1,0
    .byte 0,1,0,0,1,0
    .byte 0,1,0,0,1,0
    .byte 0,1,0,0,1,0
    .byte 1,1,0,0,1,1
    .byte 2,0,0,0,0,3
    .byte 2,0,0,0,0,3
    .byte 2,0,0,0,0,3
    .byte 2,0,0,0,0,3
    .byte 4,4,4,4,4,4

; --- Sine and Cosine Lookup Tables (8-bit signed, -127..127) ---
.segment "RODATA"
sine_table:
    .byte 0,3,6,9,12,16,19,22,25,28,31,34,37,40,43,46
    .byte 49,52,55,58,61,64,67,70,73,76,78,81,84,86,89,91
    .byte 94,96,99,101,103,106,108,110,112,114,116,118,120,122,123,125
    .byte 126,127,127,128,128,128,128,128,128,127,127,126,125,123,122,120
    .byte 118,116,114,112,110,108,106,103,101,99,96,94,91,89,86,84
    .byte 81,78,76,73,70,67,64,61,58,55,52,49,46,43,40,37
    .byte 34,31,28,25,22,19,16,12,9,6,3,0,3,6,9,12
    .byte 16,19,22,25,28,31,34,37,40,43,46,49,52,55,58,61
    .byte 64,67,70,73,76,78,81,84,86,89,91,94,96,99,101,103
    .byte 106,108,110,112,114,116,118,120,122,123,125,126,127,127,128,128
    .byte 128,128,128,128,127,127,126,125,123,122,120,118,116,114,112,110
    .byte 108,106,103,101,99,96,94,91,89,86,84,81,78,76,73,70
    .byte 67,64,61,58,55,52,49,46,43,40,37,34,31,28,25,22
    .byte 19,16,12,9,6,3,0,3,6,9,12,16,19,22,25,28
    .byte 31,34,37,40,43,46,49,52,55,58,61,64,67,70,73,76
    .byte 78,81,84,86,89,91,94,96,99,101,103,106,108,110,112,114
    .byte 116,118,120,122,123,125,126,127,127,128,128,128,128,128,128,127
    .byte 127,126,125,123,122,120,118,116,114,112,110,108,106,103,101,99
    .byte 96,94,91,89,86,84,81,78,76,73,70,67,64,61,58,55
    .byte 52,49,46,43,40,37,34,31,28,25,22,19,16,12,9,6
    .byte 3,0,3,6,9,12,16,19,22,25,28,31,34,37,40,43
    .byte 46,49,52,55,58,61,64,67,70,73,76,78,81,84,86,89
    .byte 91,94,96,99,101,103,106,108,110,112,114,116,118,120,122,123
    .byte 125,126,127,127,128,128,128,128,128,127,127,126,125,123,122,120
    .byte 118,116,114,112,110,108,106,103,101,99,96,94,91,89,86,84
    .byte 81,78,76,73,70,67,64,61,58,55,52,49,46,43,40,37
    .byte 34,31,28,25,22,19,16,12,9,6,3,0

cosine_table:
    .byte 127,127,128,128,128,128,128,128,127,127,126,125,123,122,120,118
    .byte 116,114,112,110,108,106,103,101,99,96,94,91,89,86,84,81
    .byte 78,76,73,70,67,64,61,58,55,52,49,46,43,40,37,34
    .byte 31,28,25,22,19,16,12,9,6,3,0,3,6,9,12,16
    .byte 19,22,25,28,31,34,37,40,43,46,49,52,55,58,61,64
    .byte 67,70,73,76,78,81,84,86,89,91,94,96,99,101,103,106
    .byte 108,110,112,114,116,118,120,122,123,125,126,127,127,128,128,128
    .byte 128,128,128,127,127,126,125,123,122,120,118,116,114,112,110,108
    .byte 106,103,101,99,96,94,91,89,86,84,81,78,76,73,70,67
    .byte 64,61,58,55,52,49,46,43,40,37,34,31,28,25,22,19
    .byte 16,12,9,6,3,0,3,6,9,12,16,19,22,25,28,31
    .byte 34,37,40,43,46,49,52,55,58,61,64,67,70,73,76,78
    .byte 81,84,86,89,91,94,96,99,101,103,106,108,110,112,114,116
    .byte 118,120,122,123,125,126,127,127,128,128,128,128,128,128,127,127
    .byte 126,125,123,122,120,118,116,114,112,110,108,106,103,101,99,96
    .byte 94,91,89,86,84,81,78,76,73,70,67,64,61,58,55,52
    .byte 49,46,43,40,37,34,31,28,25,22,19,16,12,9,6,3
    .byte 0,3,6,9,12,16,19,22,25,28,31,34,37,40,43,46
    .byte 49,52,55,58,61,64,67,70,73,76,78,81,84,86,89,91
    .byte 94,96,99,101,103,106,108,110,112,114,116,118,120,122,123,125
    .byte 126,127,127,128,128,128,128,128,128,127,127,126,125,123,122,120
    .byte 118,116,114,112,110,108,106,103,101,99,96,94,91,89,86,84
    .byte 81,78,76,73,70,67,64,61,58,55,52,49,46,43,40,37
    .byte 34,31,28,25,22,19,16,12,9,6,3,0

; --- Player Data Initialization (in reset or a new routine) ---
.segment "CODE"
init_player:
    lda #$03        ; X = 3.0
    sta player_x_hi
    lda #$00
    sta player_x_lo
    lda #$03        ; Y = 3.0
    sta player_y_hi
    lda #$00
    sta player_y_lo
    lda #$40        ; Angle = 90 degrees (256/4 = 64 = $40)
    sta player_angle
    lda #$08        ; Speed = 0.03125 (8/256)
    sta player_speed
    rts

; (Call jsr init_player in reset after controller_init)

reset:
	sei                ; Disable IRQs
	cld                ; Clear decimal mode
	ldx #$40
	stx $4017          ; Disable APU frame IRQ
	ldx #$ff
	stx $4010          ; Disable DMC IRQs
	ldx #$00
	stx $2000          ; Disable NMI
	stx $2001          ; Disable rendering
	stx $4015          ; Silence APU
	ldx #$00
	stx $4016          ; Controller strobe off

	; Wait for PPU to stabilize
	ldx #$00
r_wait1:
	bit $2002
	bpl r_wait1
	ldx #$00
r_wait2:
	bit $2002
	bpl r_wait2

	jsr ppu_init
	jsr controller_init
	jsr init_player   ; Initialize player position, angle, speed

	; Enable NMI and rendering
	lda #%10000000     ; Enable NMI
	sta $2000
	lda #%00011110     ; Enable sprites/background
	sta $2001

	jmp main



; --- IRQ Handler ---
irq:
	rti

; --- Main Loop ---
main:
	jsr wait_vblank      ; Wait for vblank before updating
	jsr read_controller
	jsr player_movement
	jsr raycast_render   ; Cast rays and fill distances array
	; (Game logic and rendering go here)
	jmp main

; --- PPU Initialization ---
ppu_init:
	; Clear nametable
	lda #$20
	sta $2006
	lda #$00
	sta $2006
	ldx #$00
	ldy #$00
	lda #$00	; Clear with tile 0
@clear_loop:
	sta $2007
	dex
	bne @clear_loop
	dey
	bne @clear_loop

	; Set up palette
	lda #$3F
	sta $2006
	lda #$00
	sta $2006
	lda #$0F	; Background color (black)
	sta $2007
	lda #$30	; Wall color (white)
	sta $2007
	lda #$30	; Wall color (white)
	sta $2007
	lda #$30	; Wall color (white)
	sta $2007

	rts

; --- Controller Initialization ---
controller_init:
	lda #$00
	sta controller_state
	rts

; --- Read NES Controller (expanded for D-pad) ---
.segment "CODE"
read_controller:
    lda #$01
    sta $4016          ; Strobe on
    lda #$00
    sta $4016          ; Strobe off

    ; Read A, B, Select, Start, Up, Down, Left, Right (in that order)
    ldx #$00
    lda $4016          ; A
    lda $4016          ; B
    lda $4016          ; Select
    lda $4016          ; Start

    lda $4016          ; Up
    and #$01
    sta move_up

    lda $4016          ; Down
    and #$01
    sta move_down

    lda $4016          ; Left
    and #$01
    sta move_left

    lda $4016          ; Right
    and #$01
    sta move_right

    rts

; (You can now use move_up, move_down, move_left, move_right as flags in your player movement routine)

; --- Vectors ---
	.segment "VECTORS"
	.word nmi
	.word reset
	.word irq

; --- Player Movement Routine ---
.segment "CODE"
player_movement:
    ; Turn left (Left D-pad)
    lda move_left
    beq :+
    lda player_angle
    sec
    sbc #$04         ; Turn left (adjust step as needed)
    sta player_angle
:
    ; Turn right (Right D-pad)
    lda move_right
    beq :+
    lda player_angle
    clc
    adc #$04         ; Turn right (adjust step as needed)
    sta player_angle
:
    ; Move forward (Up D-pad)
    lda move_up
    beq move_backward
    ldy player_angle
    lda cosine_table,y ; X direction
    ldx player_speed
    jsr add_scaled_to_pos_x
    lda sine_table,y   ; Y direction
    ldx player_speed
    jsr add_scaled_to_pos_y
    jmp pm_done
move_backward:
    lda move_down
    beq pm_done
    ldy player_angle
    lda cosine_table,y ; X direction
    eor #$FF
    clc
    adc #$01          ; Negate for backward
    ldx player_speed
    jsr add_scaled_to_pos_x
    lda sine_table,y   ; Y direction
    eor #$FF
    clc
    adc #$01
    ldx player_speed
    jsr add_scaled_to_pos_y
pm_done:
    rts

; --- Add Scaled Value to Player X (A = direction, X = speed) ---
; Adds (A * X) >> 7 to player_x (8.8 fixed)
add_scaled_to_pos_x:
    ; Multiply A (signed) by X (unsigned), shift right 7, add to player_x
    pha
    txa
    asl a
    tax
    pla
    jsr signed_mult
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    clc
    adc player_x_lo
    sta player_x_lo
    bcc :+
    inc player_x_hi
:
    rts

; --- Add Scaled Value to Player Y (A = direction, X = speed) ---
add_scaled_to_pos_y:
    pha
    txa
    asl a
    tax
    pla
    jsr signed_mult
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    lsr a
    clc
    adc player_y_lo
    sta player_y_lo
    bcc :+
    inc player_y_hi
:
    rts

; --- Signed Multiply: A (signed) * X (unsigned) => A (signed result) ---
; Result in A, high byte in Y (not used here)
signed_mult:
    sta temp_mult_a
    stx temp_mult_x
    clc
    lda #0
    ldy #8
sm_loop:
    asl temp_mult_a
    rol a
    dey
    beq sm_done
    asl temp_mult_x
    bcc sm_loop
    clc
    adc temp_mult_a
    bcc sm_loop
    sec
    sbc temp_mult_a
    bcc sm_loop
sm_done:
    rts

temp_mult_a: .res 1
temp_mult_x: .res 1

; --- Call player_movement from main loop ---
; (Insert jsr player_movement after jsr read_controller in main)

; --- Raycasting Core ---
.segment "BSS"
distances: .res 32 ; Store wall distances for each column (32 columns for NES)

.segment "ZEROPAGE"
ray_col:    .res 1 ; Current column
ray_angle:  .res 1 ; Current ray angle
ray_x_lo:   .res 1 ; Ray X position, low byte (8.8 fixed)
ray_x_hi:   .res 1 ; Ray X position, high byte
ray_y_lo:   .res 1 ; Ray Y position, low byte
ray_y_hi:   .res 1 ; Ray Y position, high byte
ray_dx:     .res 1 ; Ray X step (signed)
ray_dy:     .res 1 ; Ray Y step (signed)
ray_dist:   .res 1 ; Ray distance (8-bit, for now)

.segment "CODE"
raycast_render:
    lda #0
    sta ray_col
    jmp rc_loop
rc_done_short:
    jmp rc_done
rc_loop:
    lda ray_col
    cmp #32
    bcs rc_done_short
    ; Calculate ray angle: player_angle +/- FOV offset
    lda player_angle
    sec
    sbc #16         ; FOV/2 (example: 32 columns, 32 FOV)
    clc
    adc ray_col     ; ray_col = 0..31
    sta ray_angle
    ; Set ray position to player position
    lda player_x_lo
    sta ray_x_lo
    lda player_x_hi
    sta ray_x_hi
    lda player_y_lo
    sta ray_y_lo
    lda player_y_hi
    sta ray_y_hi
    ; Get direction from tables
    ldy ray_angle
    lda cosine_table,y
    sta ray_dx
    lda sine_table,y
    sta ray_dy
    ; Step through map
    lda #0
    sta ray_dist
rc_step:
    ; ray_x += ray_dx * step (step = 1/8 for smoothness)
    lda ray_dx
    lsr a
    lsr a
    lsr a
    clc
    adc ray_x_lo
    sta ray_x_lo
    bcc :+
    inc ray_x_hi
:
    lda ray_dy
    lsr a
    lsr a
    lsr a
    clc
    adc ray_y_lo
    sta ray_y_lo
    bcc :+
    inc ray_y_hi
:
    ; Check map bounds
    lda ray_x_hi
    cmp map_width
    bcs rc_hit
    lda ray_y_hi
    cmp map_height
    bcs rc_hit
    ; Get map tile
    lda ray_y_hi
    sta temp1
    lda map_width
    jsr mul8       ; temp1 = y * width
    clc
    lda ray_x_hi
    adc temp1
    tay
    lda map_data,y
    beq rc_next      ; 0 = empty, keep going
rc_hit:
    ; Store distance (ray_dist)
    lda ray_dist
    ldx ray_col
    sta distances,x
    jmp rc_next_col
rc_next:
    inc ray_dist
    lda ray_dist
    cmp #64          ; Max distance
    bcc rc_step
    ; If no wall found, store max
    lda #64
    ldx ray_col
    sta distances,x
rc_next_col:
    inc ray_col
    jmp rc_loop
rc_done:
    rts

; --- 8-bit multiply: A = A * temp1 ---
mul8:
    ldx temp1
    stx temp2
    ldx #0
    sta temp3
    beq mul8_done
mul8_loop:
    clc
    adc temp3
    dex
    bne mul8_loop
mul8_done:
    sta temp3
    rts

temp1: .res 1
temp2: .res 1
temp3: .res 1

; (Call jsr raycast_render before rendering each frame)

; --- Rendering Routine: Draw Wall Slices During VBlank ---
.segment "CODE"

; --- VBlank Synchronization ---
.segment "ZEROPAGE"
vblank_flag: .res 1

.segment "CODE"
nmi:
    inc vblank_flag      ; Signal vblank
    jsr draw_walls
    rti

wait_vblank:
    lda vblank_flag
    beq wait_vblank
    lda #0
    sta vblank_flag
    rts

; --- Draw Walls: Use distances to draw vertical slices ---
draw_walls:
    ; Clear the screen first
    lda #$20
    sta $2006
    lda #$00
    sta $2006
    ldx #0
    ldy #0
    lda #$00	; Background tile
@clear_screen:
    sta $2007
    dex
    bne @clear_screen
    dey
    bne @clear_screen

    ; Now draw the walls
    ldx #0           ; Column index
@col_loop:
    cpx #32
    bcs @done
    lda distances,x  ; Get distance for this column
    jsr calc_slice_height
    ; A = slice height (8..64, smaller = farther)
    sta temp_height
    lda #15          ; Screen center Y (tile row) - adjusted for NES
    sec
    sbc temp_height  ; Top of slice
    bpl :+
    lda #0
:
    sta temp_top
    lda #15
    clc
    adc temp_height  ; Bottom of slice
    cmp #30
    bcc :+
    lda #29
:
    sta temp_bottom

        ; Compute: base = $2000 + row * 32 + column
    lda temp_top       ; tile row
    asl a              ; *2
    asl a              ; *4
    asl a              ; *8
    asl a              ; *16
    asl a              ; *32 => A = temp_top * 32
    clc
    adc ray_col        ; X = column (use same ray_col as in distances)
    sta temp1          ; low byte
    lda #$20
    sta temp2          ; high byte ($2000)
    ; Set PPU address
    lda temp2
    sta $2006
    lda temp1
    sta $2006


    ; Draw vertical slice (fill column from temp_top to temp_bottom)
    ldy temp_top
@draw_slice:
    cpy temp_bottom
    bcs @next_col       ; If Y >= bottom, stop

    ; Compute PPU address: $2000 + y*32 + x (ray_col)
    tya                 ; A = current row
    asl a               ; A *= 2
    asl a               ; A *= 4
    asl a               ; A *= 8
    asl a               ; A *= 16
    asl a               ; A *= 32
    clc
    adc ray_col         ; Add column offset
    sta temp1           ; Store low byte
    lda #$20
    sta $2006           ; High byte = $20
    lda temp1
    sta $2006           ; Low byte = computed offset

    lda #$01            ; Tile index for wall (can be changed)
    sta $2007           ; Write tile

    iny
    jmp @draw_slice
@next_col:
    inx
    jmp @col_loop
@done:
    rts

; --- Calculate Slice Height from Distance ---
; Input: A = distance (1..64)
; Output: A = height (larger = closer)
calc_slice_height:
    sta temp_height
    lda #64
    sec
    sbc temp_height             ; Inverse: closer = bigger
    lsr a
    lsr a
    clc
    adc #8           ; Minimum height
    rts

temp_height:  .res 1
temp_top:     .res 1
temp_bottom:  .res 1
