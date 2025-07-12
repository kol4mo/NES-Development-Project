.include "nes.inc"
.include "macros.inc"


.segment "HEADER"
.byte 'N', 'E', 'S', $1a      ; "NES" followed by MS-DOS EOF marker
.byte $02                     ; 2 x 16KB PRG-ROM banks
.byte $01                     ; 1 x 8KB CHR-ROM bank
.byte $00, $00                ; Mapper 0, no special features

.segment "ZEROPAGE"
; Pattern data and temporary storage
zp_tmp0:    .res 1    ; $00
zp_tmp1:    .res 1    ; $01
zp_tmp2:    .res 1    ; $02
zp_tmp3:    .res 1    ; $03

; Interrupt/dispatch flags and function pointers
zp_flag0:   .res 1    ; $10
zp_func_lo: .res 1    ; $11 (function pointer low)
zp_func_hi: .res 1    ; $12 (function pointer high)

; Controller state and edge detection
zp_ctrl0:   .res 1    ; $13 (controller 1 state)
zp_ctrl1:   .res 1    ; $14 (controller 2 state)
zp_edge0:   .res 1    ; $15 (controller 1 edge)
zp_edge1:   .res 1    ; $16 (controller 2 edge)

; Counters, lookup, and rendering
zp_target:  .res 1    ; $17
zp_counter: .res 1    ; $18
zp_lownib:  .res 1    ; $19
zp_highnib: .res 1    ; $1A

; Rendering parameters and flags
zp_ppuctrl: .res 1    ; $1B (PPU control)
zp_var1C:   .res 1    ; $1C
zp_var1D:   .res 1    ; $1D
zp_var1E:   .res 1    ; $1E
zp_var1F:   .res 1    ; $1F

; Raycasting and rendering variables
zp_var20:   .res 1    ; $20
zp_var21:   .res 1    ; $21
zp_var22:   .res 1    ; $22
zp_var23:   .res 1    ; $23
zp_var24:   .res 1    ; $24
zp_var25:   .res 1    ; $25
zp_var26:   .res 1    ; $26
zp_var27:   .res 1    ; $27
zp_var28:   .res 1    ; $28
zp_var29:   .res 1    ; $29
zp_var2A:   .res 1    ; $2A
zp_var2B:   .res 1    ; $2B
zp_var2C:   .res 1    ; $2C
zp_var2D:   .res 1    ; $2D
zp_var2E:   .res 1    ; $2E

; Upload state, palette, etc.
zp_var2F:   .res 1    ; $2F

; General-purpose buffer for results (used as $0030,Y, size 4)
zp_buffer:  .res 4    ; $30-$33

zp_var31:   .res 1    ; $31
zp_var32:   .res 1    ; $32
zp_var33:   .res 1    ; $33
zp_var34:   .res 1    ; $34
zp_var35:   .res 1    ; $35
zp_var36:   .res 1    ; $36
zp_var37:   .res 1    ; $37

; Raycasting, rendering, and sprite variables
zp_var38:   .res 1    ; $38
zp_var39:   .res 1    ; $39
zp_var3A:   .res 1    ; $3A
zp_var3B:   .res 1    ; $3B
zp_var3C:   .res 1    ; $3C
zp_var3D:   .res 1    ; $3D
zp_var3E:   .res 1    ; $3E
zp_var3F:   .res 1    ; $3F
zp_var40:   .res 1    ; $40
zp_var41:   .res 1    ; $41
zp_var42:   .res 1    ; $42
zp_var43:   .res 1    ; $43
zp_var44:   .res 1    ; $44
zp_var45:   .res 1    ; $45
zp_var46:   .res 1    ; $46
zp_var47:   .res 1    ; $47
zp_var48:   .res 1    ; $48
zp_var49:   .res 1    ; $49
zp_var4A:   .res 1    ; $4A
zp_var4B:   .res 1    ; $4B
zp_var4C:   .res 1    ; $4C
zp_var4D:   .res 1    ; $4D
zp_var4E:   .res 1    ; $4E
zp_var4F:   .res 1    ; $4F
zp_var50:   .res 1    ; $50
zp_var51:   .res 1    ; $51
zp_var52:   .res 1    ; $52
zp_var53:   .res 1    ; $53
zp_var54:   .res 1    ; $54
zp_var55:   .res 1    ; $55
zp_var56:   .res 1    ; $56
zp_var57:   .res 1    ; $57
zp_var58:   .res 1    ; $58
zp_var59:   .res 1    ; $59
zp_var5A:   .res 1    ; $5A
zp_var5B:   .res 1    ; $5B
zp_var5C:   .res 1    ; $5C
zp_var5D:   .res 1    ; $5D
zp_var5E:   .res 1    ; $5E
zp_var5F:   .res 1    ; $5F
zp_var60:   .res 1    ; $60
zp_var61:   .res 1    ; $61



.segment "CODE"
lookup_CA79:
    .byte 64, 60, 56, 52, 48, 44, 40, 36, 32, 28, 24, 20, 16, 12, 8, 4
    .byte 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60
    .byte 64, 60, 56, 52, 48, 44, 40, 36, 32, 28, 24, 20, 16, 12, 8, 4
    .byte 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60
    .byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
    .byte 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32
    .byte 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48
    .byte 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64

lookup_CE31:
    .byte %11111111, %01111110, %00111100, %00011000, %00000000, %00011000, %00111100, %01111110
    .byte %11111111, %11111111, %01111110, %00111100, %00011000, %00000000, %00011000, %00111100
    .byte %01111110, %11111111, %11111111, %01111110, %00111100, %00011000, %00000000, %00011000
    .byte %00111100, %01111110, %11111111, %11111111, %01111110, %00111100, %00011000, %00000000
lookup_CE35:
    .byte %00000000, %10000001, %11000011, %11100111, %11111111, %11100111, %11000011, %10000001
    .byte %00000000, %00000000, %10000001, %11000011, %11100111, %11111111, %11100111, %11000011
    .byte %10000001, %00000000, %00000000, %10000001, %11000011, %11100111, %11111111, %11100111
    .byte %11000011, %10000001, %00000000, %00000000, %10000001, %11000011, %11100111, %11111111

lookup_D379:
    .byte 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60
    .byte 64, 60, 56, 52, 48, 44, 40, 36, 32, 28, 24, 20, 16, 12, 8, 4
    .byte 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60
    .byte 64, 60, 56, 52, 48, 44, 40, 36, 32, 28, 24, 20, 16, 12, 8, 4

;C02C to C044
.proc interrupt_handler
        BIT zp_flag0                 ; Test bits in zero page location $10
        BMI skip_dispatch       ; Branch if bit 7 is set (negative flag)
        BIT zp_func_hi                 ; Test bits in zero page location $12
        BPL save_registers      ; Branch if bit 7 is clear (positive flag)
        JMP (zp_func_lo)             ; Indirect jump through address stored at $0011-$0012
skip_dispatch:
save_registers:
        PHA                     ; Push accumulator to stack
        TXA                     ; Transfer X to accumulator
        PHA                     ; Push X register to stack
        TYA                     ; Transfer Y to accumulator
        PHA                     ; Push Y register to stack
        PLA                     ; Pull Y register from stack
        TAY                     ; Transfer accumulator to Y
        PLA                     ; Pull X register from stack
        TAX                     ; Transfer accumulator to X
        PLA                     ; Pull accumulator from stack
        RTI                     ; Return from interrupt
.endproc

;C046
.proc empty_function
        RTS                     ; Return from subroutine (do nothing)
.endproc

;c047-c06b
.proc ppu_setup
        LDA #$00
        STA zp_flag0                 ; Clear zero page flags
        STA zp_func_hi
        LDX #$00
        STX zp_counter                 ; Initialize counters/indices
        STX zp_target

        LDA $CDE6,X             ; Load data from lookup table
        AND #$0F                ; Extract lower nibble
        STA zp_lownib
        LDA $CDE6,X             ; Load same data again
        AND #$F0                ; Extract upper nibble
        STA zp_highnib

        LDA #$A8                ; PPU control: NMI enabled, BG pattern table $1000
        STA PPU_CONTROL
        LDA #$06                ; PPU mask: Show background, no sprites
        STA PPU_MASK
        RTS
.endproc

;C073 - C0A6
.proc counter_update
        LDA zp_target                 ; Load target value
        CMP zp_counter                 ; Compare with current counter
        BEQ exit                ; If equal, skip update

        DEC zp_counter                 ; Decrement counter
        LDA zp_counter
        AND #$07                ; Check if counter is multiple of 8
        BNE exit                ; If not, skip table lookup

        LDA zp_counter                 ; Reload counter value
        BCS skip_add            ; Branch if carry set from previous operations
        ADC #$11                ; Add offset
skip_add:
        SBC #$08                ; Subtract 8 (carry should be set)
        STA zp_counter                 ; Store modified counter

        LDA zp_target                 ; Load target value
        AND #$07                ; Mask to 3 bits
        ORA zp_counter                 ; Combine with counter
        STA zp_counter                 ; Store result

        LSR A                   ; Shift right 3 times to get table index
        LSR A
        LSR A
        TAX                     ; Use as index

        LDA $CDE6,X             ; Load from data table
        AND #$0F                ; Extract lower nibble
        STA zp_lownib
        LDA $CDE6,X             ; Load again
        AND #$F0                ; Extract upper nibble
        STA zp_highnib

        CLC                     ; Clear carry flag
exit:
        RTS
.endproc

;C0A8
.proc empty_function2
        RTS                     ; Return immediately (stub function)
.endproc

;c0A9 - c216
.proc graphics_renderer
        LDA #$A8                ; Set PPU control
        STA PPU_CONTROL
        LDA #$04                ; Set PPU address high byte
        STA PPU_ADDRESS
        LDA #$00                ; Set PPU address low byte
        STA PPU_ADDRESS

        LDA #$40                ; Initialize graphics counter
        STA zp_var23

main_loop:
        LDX #$04                ; Initialize X counter
        LDY #$00                ; Initialize Y counter
        STY zp_var27                 ; Clear shift register
        BEQ setup_shift         ; Always branch (Y=0)

shift_loop:
        DEX                     ; Decrement X
        INY                     ; Increment Y

setup_shift:
        ASL A                   ; Shift accumulator left
        BCS shift_loop          ; Branch if carry set
        STX zp_var25                 ; Store X counter
        STY zp_var26                 ; Store Y counter

        ASL A                   ; Shift again
        PHP                     ; Push processor status
        ASL A                   ; Shift once more
        STA zp_var28                 ; Store shifted value

        LDA #$FF                ; Set up mask value
        ADC #$00                ; Add carry
        EOR #$FF                ; Invert
        STA zp_var24                 ; Store mask

        ASL zp_var28                 ; Shift data left
        ROL zp_var27                 ; Rotate into high byte

        LDY #$07                ; Set up counter for 8 bytes
        PLP                     ; Pull processor status
        BCC simple_render       ; Branch if no special processing

complex_render:
        ASL zp_var28                 ; Shift data
        LDA zp_var27                 ; Get high byte
        ROL A                   ; Rotate
        TAX                     ; Use as index

        LDA zp_var24                 ; Get mask
        AND lookup_CE31,X       ; Apply mask to lookup table
        STA PPU_VRAM_IO            ; Write to PPU
        LDA lookup_CE31,X       ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        LDA zp_var24                 ; Get mask again
        AND lookup_CE35,X       ; Apply to second table
        STA PPU_VRAM_IO            ; Write to PPU
        LDA lookup_CE35,X       ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        DEC zp_var25                 ; Decrement line counter
        BNE complex_render      ; Continue if not done

        DEC zp_var26                 ; Decrement block counter
        BMI write_buffer        ; Branch if negative

        LDA zp_tmp2                 ; Get pattern data
        STA PPU_VRAM_IO            ; Write to PPU
        LDA #$00                ; Clear value
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement Y
        STA $001B,Y             ; Store again
        LDA zp_tmp3                 ; Get second pattern
        STA PPU_VRAM_IO            ; Write to PPU
        DEY                     ; Decrement Y
        JMP complex_render + 2  ; Continue loop

simple_render:
        LDA zp_var23                 ; Get counter value
        STA zp_var28                 ; Store as data
        DEC zp_var26                 ; Decrement block counter
        BMI final_shift         ; Branch if negative

        LDA zp_tmp0                 ; Get pattern data
        STA PPU_VRAM_IO            ; Write to PPU
        LDA #$00                ; Clear value
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement Y
        STA $001B,Y             ; Store again
        LDA zp_tmp1                 ; Get second pattern
        STA PPU_VRAM_IO            ; Write to PPU
        DEY                     ; Decrement Y
        JMP simple_render + 2   ; Continue loop

final_shift:
        LSR zp_var28                 ; Shift right
        LDA zp_var27                 ; Get high byte
        ROL A                   ; Rotate
        TAX                     ; Use as index

        LDA zp_var24                 ; Get mask
        AND lookup_CE31,X       ; Apply mask
        STA PPU_VRAM_IO            ; Write to PPU
        LDA lookup_CE31,X       ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        LDA zp_var24                 ; Get mask again
        AND lookup_CE35,X       ; Apply to second table
        STA PPU_VRAM_IO            ; Write to PPU
        LDA lookup_CE35,X       ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        DEC zp_var25                 ; Decrement line counter
        BNE final_shift         ; Continue if not done

write_buffer:
        LDY #$07                ; Set counter for 8 bytes

buffer_loop:
        LDA $001B,Y             ; Load from buffer
        STA PPU_VRAM_IO            ; Write to PPU
        DEY                     ; Decrement counter
        BPL buffer_loop         ; Continue if not negative

        CLC                     ; Clear carry
        LDA zp_var23                 ; Get counter
        ADC #$01                ; Increment
        CMP #$F0                ; Check if done
        BEQ fill_patterns       ; Branch if complete
        JMP main_loop           ; Continue main loop

fill_patterns:
        ; Fill pattern data blocks
        LDA zp_tmp0                 ; Get first pattern
        LDX zp_tmp1                 ; Get second pattern
        LDY #$04                ; Set counter

fill_loop1:
        STA PPU_VRAM_IO            ; Write first pattern
        STX PPU_VRAM_IO            ; Write second pattern
        DEY                     ; Decrement counter
        BNE fill_loop1          ; Continue loop

        LDX #$08                ; Set counter for zeros

zero_loop1:
        STY PPU_VRAM_IO            ; Write zero (Y=0)
        DEX                     ; Decrement counter
        BNE zero_loop1          ; Continue loop

        LDA zp_tmp2                 ; Get third pattern
        LDX zp_tmp3                 ; Get fourth pattern
        LDY #$04                ; Set counter

fill_loop2:
        STA PPU_VRAM_IO            ; Write third pattern
        STX PPU_VRAM_IO            ; Write fourth pattern
        DEY                     ; Decrement counter
        BNE fill_loop2          ; Continue loop

        LDX #$08                ; Set counter for zeros

zero_loop2:
        STY PPU_VRAM_IO            ; Write zero (Y=0)
        DEX                     ; Decrement counter
        BNE zero_loop2          ; Continue loop

        ; Pattern arrangement loops
        LDA #$03                ; Set up counters
        STA zp_var26
        LDA #$01
        STA zp_var25

arrange_loop1:
        LDY zp_var26                 ; Get counter
        LDA zp_tmp0                 ; Get pattern
        LDX zp_tmp1

pattern_write1:
        STA PPU_VRAM_IO            ; Write pattern data
        STX PPU_VRAM_IO
        DEY                     ; Decrement counter
        BNE pattern_write1      ; Continue loop

        LDY zp_var25                 ; Get second counter
        LDA #$00                ; Clear pattern

clear_write1:
        STA PPU_VRAM_IO            ; Write zeros
        STA PPU_VRAM_IO
        DEY                     ; Decrement counter
        BNE clear_write1        ; Continue loop

        LDX #$08                ; Fill with zeros

final_zero1:
        STY PPU_VRAM_IO            ; Write zero
        DEX                     ; Decrement counter
        BNE final_zero1         ; Continue loop

        INC zp_var25                 ; Increment counter
        DEC zp_var26                 ; Decrement counter
        BNE arrange_loop1       ; Continue if not done

        ; Second arrangement phase
        LDA #$03                ; Reset counters
        STA zp_var26
        LDA #$01
        STA zp_var25

arrange_loop2:
        LDY zp_var25                 ; Get first counter
        LDA #$00                ; Clear pattern

clear_write2:
        STA PPU_VRAM_IO            ; Write zeros
        STA PPU_VRAM_IO
        DEY                     ; Decrement counter
        BNE clear_write2        ; Continue loop

        LDY zp_var26                 ; Get second counter
        LDA zp_tmp2                 ; Get pattern
        LDX zp_tmp3

pattern_write2:
        STA PPU_VRAM_IO            ; Write pattern data
        STX PPU_VRAM_IO
        DEY                     ; Decrement counter
        BNE pattern_write2      ; Continue loop

        LDX #$08                ; Fill with zeros

final_zero2:
        STY PPU_VRAM_IO            ; Write zero
        DEX                     ; Decrement counter
        BNE final_zero2         ; Continue loop

        INC zp_var25                 ; Increment counter
        DEC zp_var26                 ; Decrement counter
        BNE arrange_loop2       ; Continue if not done

        RTS
.endproc

;c217 to c221
.proc clear_variables
        LDA #$00                ; Load zero
        STA zp_ctrl0                 ; Clear zero page variables
        STA zp_ctrl1
        STA zp_edge0
        STA zp_edge1
        RTS
.endproc

;c222 to c25a
.proc read_controllers
        LDA zp_ctrl0                 ; Create inverted masks for edge detection
        EOR #$FF
        STA zp_edge0
        LDA zp_ctrl1
        EOR #$FF
        STA zp_edge1

        LDA #$01                ; Strobe controllers
        STA $4016
        LSR A
        STA $4016

        LDX #$07                ; Read 8 buttons
read_loop:
        LDA $4016               ; Read controller states
        AND #$03
        CMP #$01
        ROL zp_ctrl0

        LDA $4017
        AND #$03
        CMP #$01
        ROL zp_ctrl1

        DEX
        BPL read_loop

        LDA zp_ctrl0                 ; Isolate newly pressed buttons
        AND zp_edge0
        STA zp_edge0

        LDA zp_ctrl1
        AND zp_edge1
        STA zp_edge1

        RTS
.endproc

;C25B - C2FB
.proc game_init
        JSR clear_variables              ; Clear variables

        LDX #$00                ; Clear PPU memory
        STX PPU_ADDRESS
        STX PPU_ADDRESS
        LDY #$30
clear_ppu:
        TXA
        STA PPU_VRAM_IO
        DEX
        BNE clear_ppu
        DEY
        BNE clear_ppu

        LDA #$FF                ; Initialize pattern data
        STA zp_tmp0
        LDA #$FF
        STA zp_tmp1
        LDA #$33
        STA zp_tmp2
        LDA #$CC
        STA zp_tmp3

        JSR graphics_renderer               ; Setup graphics

        LDA #$10                ; Initialize game variables
        STA zp_var1C
        LDA #$F9
        STA $0300
        LDA #$C9
        STA $0380

        LDY #$10                ; Initialize sprite data tables
        LDX #$00
        CLC
sprite_init:
        TYA
        ADC $0300,X
        STA $0301,X
        LDA $0380,X
        ADC #$00
        STA $0381,X
        INX
        CPX #$7F
        BNE sprite_init

        LDA #$20                ; Setup rendering parameters
        STA zp_var1D
        STA zp_var1F
        LDA #$06
        STA zp_var1E
        STA zp_var20
        LDA #$00
        STA zp_var21
        LDA #$A8
        STA zp_ppuctrl
        LDA #$00
        STA zp_var2E
        STA zp_var2D

        LDA #$35                ; Setup function pointer
        STA zp_func_lo
        LDA #$CB
        STA zp_func_hi
jumpC2CE:
        JSR read_controllers               ; Read controller input

        LDA zp_ctrl0                 ; Handle B button (move left)
        AND #$02
        BEQ check_a
        LDX zp_var21
        DEX
        DEX
        CPX #$FE
        BNE store_x
        LDX #$A6
store_x:
        STX zp_var21

check_a:
        LDA zp_ctrl0                 ; Handle A button (move right)
        AND #$01
        BEQ check_select_start
        LDX zp_var21
        INX
        INX
        CPX #$A8
        BNE store_x2
        LDX #$00
store_x2:
        STX zp_var21

check_select_start:
        LDA zp_ctrl0                 ; Check Select/Start buttons
        AND #$0C
        BNE continue_game
        JMP ray_cast               ; Exit if no Select/Start

continue_game:
        ; Function continues...


;c444 - c683
ray_cast:
        SEC                     ; Calculate angle offsets
        LDA zp_var21
        SBC #$0E
        BCS calc_angle1
        ADC #$A8
calc_angle1:
        STA zp_var2A
        ADC #$29
        CMP #$A8
        BCC calc_angle2
        SBC #$A8
calc_angle2:
        STA zp_var29

        LDA zp_var2D                 ; Wait for specific flag
        BMI calc_angle2

        LDA #$8F                ; Initialize ray parameters
        STA zp_var22
        STA zp_var23
        STA zp_var24
        LDA #$00
        STA zp_var27

        LDA zp_ppuctrl                 ; Setup rendering flags
        AND #$03
        ASL A
        ASL A
        ORA #$20
        STA zp_var28

        LDA #$00
        STA zp_var2B
        STA zp_var2C

        LDX #$00                ; Load sine/cosine tables
jump47B:
        LDA $D3CD,X
        STA zp_var38
        LDA $D3E9,X
        STA zp_var39

        LDY zp_var29                 ; Get direction data
        LDA $CE39,Y
        STA zp_var3A
        ASL A
        TAY
        LDA zp_var38,Y
        STA zp_var3C
        LDA $D379,Y
        STA zp_var40
        INY
        LDA zp_var38,Y
        STA zp_var3D
        LDA $D379,Y
        STA zp_var41

        LDY zp_var2A                 ; Get second direction data
        LDA $CE39,Y
        STA zp_var3B
        ASL A
        TAY
        LDA zp_var38,Y
        STA zp_var3E
        LDA $D379,Y
        STA zp_var42
        INY
        LDA zp_var38,Y
        STA zp_var3F
        LDA $D379,Y
        STA zp_var43

        LDA zp_var1E                 ; Calculate ray direction X
        LSR A
        LDA zp_var1D
        ROR A
        LSR A
        BIT zp_var3A
        BPL calc_ray_x
        EOR #$80
        LDY #$FF
        STY zp_var44
        BNE setup_ray_x
calc_ray_x:
        EOR #$FF
        LDY #$01
        STY zp_var44
        DEY
setup_ray_x:
        STY zp_var46
        STA zp_var4B
        STA zp_var48

        LDA #$00                ; Multiply ray direction
        STA zp_var4D
multiply_loop1:
        LSR zp_var48
        BCC shift_result1
        TAY
        CLC
        LDA zp_var4D
        ADC zp_var3C
        STA zp_var4D
        TYA
        ADC zp_var3D
shift_result1:
        ROR A
        ROR zp_var4D
        LSR zp_var48
        BEQ end_multiply1
        BCS multiply_loop1
        BCC shift_result1
end_multiply1:
        STA zp_var4E

        LDA zp_var20                 ; Calculate ray direction Y
        LSR A
        LDA zp_var1F
        ROR A
        LSR A
        BIT zp_var3B
        BPL calc_ray_y
        EOR #$80
        LDY #$FE
        STY zp_var45
        LDY #$00
        BEQ setup_ray_y
calc_ray_y:
        EOR #$FF
        LDY #$00
        STY zp_var45
        DEY
setup_ray_y:
        STY zp_var47
        STA zp_var4C
        STA zp_var48

        LDA #$00                ; Multiply ray direction Y
        STA zp_var4F
multiply_loop2:
        LSR zp_var48
        BCC shift_result2
        TAY
        CLC
        LDA zp_var4F
        ADC zp_var3E
        STA zp_var4F
        TYA
        ADC zp_var3F
shift_result2:
        ROR A
        ROR zp_var4F
        LSR zp_var48
        BEQ end_multiply2
        BCS multiply_loop2
        BCC shift_result2
end_multiply2:
        STA zp_var50

        LDA zp_var1E                 ; Setup map lookup
        LSR A
        STA zp_var55
        LDA zp_var20
        LSR A
        STA zp_var56
        TAY
        LDA $0300,Y
        STA zp_var57
        LDA $0380,Y
        STA zp_var58

        LDA #$00                ; Initialize step counters
        STA zp_var49
        STA zp_var4A

ray_loop:
        LDA zp_var4D                 ; Compare ray positions
        CMP zp_var4F
        LDA zp_var4E
        SBC zp_var50
        BCS step_y

        LDA zp_var55                 ; Step X direction
        ADC zp_var44
        STA zp_var55
        TAY
        LDA zp_var57,Y
        BMI hit_wall_x
        INC zp_var49
        CLC
        LDA zp_var4D
        ADC zp_var3C
        STA zp_var4D
        LDA zp_var4E
        ADC zp_var3D
        STA zp_var4E
        JMP ray_loop
hit_wall_y_short:
        JMP hit_wall_y
step_y:
        LDA zp_var56                 ; Step Y direction
        ADC zp_var45
        STA zp_var56
        TAY
        LDA $0300,Y
        STA zp_var57
        LDA $0380,Y
        STA zp_var58
        LDY zp_var55
        LDA zp_var57,Y
        BMI hit_wall_y_short
        INC zp_var4A
        CLC
        LDA zp_var4F
        ADC zp_var3E
        STA zp_var4F
        LDA zp_var50
        ADC zp_var3F
        STA zp_var50
        JMP ray_loop

hit_wall_x:
        CMP #$FF                ; Handle wall hit X
        BNE store_wall_x
        LDA #$00
store_wall_x:
        STA $0138,X
        LDA zp_var4D
        STA $0100,X
        LDA zp_var4E
        STA $011C,X

        LDA #$00                ; Calculate wall distance
        STA zp_var51
distance_calc_x:
        LSR zp_var4B
        BCC shift_dist_x
        TAY
        CLC
        LDA zp_var51
        ADC zp_var40
        STA zp_var51
        TYA
        ADC zp_var41
shift_dist_x:
        ROR A
        ROR zp_var51
        LSR zp_var4B
        BEQ end_dist_x
        BCS distance_calc_x
        BCC shift_dist_x
end_dist_x:
        STA zp_var52

        LDY zp_var49                 ; Apply step count
        BEQ apply_direction_x
step_apply_x:
        CLC
        LDA zp_var51
        ADC zp_var40
        STA zp_var51
        LDA zp_var52
        ADC zp_var41
        STA zp_var52
        DEY
        BNE step_apply_x

apply_direction_x:
        BIT zp_var3B
        BMI sub_direction_x
        CLC
        LDA zp_var1F
        ADC zp_var51
        STA zp_var51
        LDA zp_var20
        ADC zp_var52
        JMP finish_calc_x
sub_direction_x:
        SEC
        LDA zp_var1F
        SBC zp_var51
        STA zp_var51
        LDA zp_var20
        SBC zp_var52
finish_calc_x:
        LSR A
        ROR zp_var51
        CMP zp_var56
        BEQ no_invert_x
        LDA zp_var51
        EOR #$FF
        JMP apply_shading_x
no_invert_x:
        LDA zp_var51
apply_shading_x:
        EOR zp_var46
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        STA $0154,X
        BPL continue_function

hit_wall_y:
        CMP #$FF                ; Handle wall hit Y
        BNE store_wall_y
        LDA #$00
store_wall_y:
        STA $0138,X
        LDA zp_var4F
        STA $0100,X
        LDA zp_var50
        STA $011C,X

        LDA #$00                ; Calculate wall distance Y
        STA zp_var53
distance_calc_y:
        LSR zp_var4C
        BCC shift_dist_y
        TAY
        CLC
        LDA zp_var53
        ADC zp_var42
        STA zp_var53
        TYA
        ADC zp_var43
shift_dist_y:
        ROR A
        ROR zp_var53
        LSR zp_var4C
        BEQ end_dist_y
        BCS distance_calc_y
        BCC shift_dist_y
end_dist_y:
        STA zp_var54

        LDY zp_var4A                 ; Apply step count Y
        BEQ apply_direction_y
step_apply_y:
        CLC
        LDA zp_var53
        ADC zp_var42
        STA zp_var53
        LDA zp_var54
        ADC zp_var43
        STA zp_var54
        DEY
        BNE step_apply_y

apply_direction_y:
        BIT zp_var3A
        BMI sub_direction_y
        CLC
        LDA zp_var1D
        ADC zp_var53
        STA zp_var53
        LDA zp_var1E
        ADC zp_var54
        JMP calculate_sprite_data
sub_direction_y:

continue_function:
        ; Function continues beyond provided code...



calculate_sprite_data:
    LSR A
    ROR zp_var53
    CMP zp_var55
    BEQ load_value
    LDA zp_var53
    EOR #$FF
    JMP store_value

load_value:
    LDA zp_var53

store_value:
    EOR zp_var47
    LSR A
    LSR A
    LSR A
    LSR A
    SEC
    ROR A
    STA $0154,X
    INX
    TXA
    AND #$03
    BEQ process_complete
jump6B2:
    ; Update Y coordinates
    LDY zp_var29
    INY
    CPY #$A8
    BNE update_y1
    LDY #$00
update_y1:
    STY zp_var29
    LDY zp_var2A
    INY
    CPY #$A8
    BNE update_y2
    LDY #$00
update_y2:
    STY zp_var2A
    JMP jump47B

process_complete:
    SEC
    TXA
    SBC #$04
    TAX
    LDA #$04
wait_loop:
    CMP zp_var2E
    BEQ wait_loop

    LDA #$FF
    STA zp_buffer
jump6DA:
    LDY $0138,X
    BNE call_lookup1
    TYA
    BEQ skip_lookup1
call_lookup1:
    JSR variable_compare_check
skip_lookup1:
    ASL A
    ASL A
    STA zp_var25
    LDY $0139,X
    BNE call_lookup2
    TYA
    BEQ skip_lookup2
call_lookup2:
    JSR variable_compare_check
skip_lookup2:
    ORA zp_var25
    TAY
    LDA $D605,Y
    STA zp_var25
    BIT zp_buffer
    BPL setup_rotation
    AND #$33
    STA zp_buffer

setup_rotation:
    LDA #$FC
    ASL zp_var25
    ROL A
    ASL $0154,X
    ROL A
    STA zp_var59

    ; Binary search initialization
    LDY #$00
    STY zp_var5C
    DEY
    STY zp_var5D

    ; Binary search loop (8 iterations)
binary_search:
    CLC
    LDA zp_var5C
    ADC zp_var5D
    ROR A
    TAY
    LDA $0100,X
    CMP $D405,Y
    LDA $011C,X
    SBC $D505,Y
    BCC update_low
    STY zp_var5D
    CLC
    BCC continue_search
update_low:
    INY
    STY zp_var5C
continue_search:
    ; [Repeat pattern 7 more times - condensed for clarity]

    ; Get sprite data
    LDY $0138,X
    LDA lookup_CA79,Y
    STA zp_var38
    LDA lookup_CA79+($CA7D-$CA79),Y
    STA zp_var39
    LDY $0154,X
    LDA lookup_CA79+($CA7D-$CA79),Y
    STA zp_var5B
    INY
    LDA lookup_CA79+($CA7D-$CA79),Y
    STA zp_var5A

    LDA zp_var5C
    CMP #$FF
    BNE normal_render

    ; Special case rendering
    LDY $0100,X
    CPY $D504
    BCS normal_render

    STX zp_var26
    LDX zp_var2B
    LDA zp_var59
    ORA #$04
    STA $0400,X
    STA $0480,X

    ; Process high byte
    LDY zp_var5A
    CPY #$80
    ROL $0400,X
    CPY #$80
    ROL $0400,X
    CPY #$80
    ROL $0400,X
    CPY #$80
    ROL $0400,X

    ; Process low byte
    LDY zp_var5B
    CPY #$80
    ROL $0480,X
    CPY #$80
    ROL $0480,X
    CPY #$80
    ROL $0480,X
    CPY #$80
    ROL $0480,X

    ; Duplicate data across 8 bytes
    LDA $0400,X
    STA $0401,X
    STA $0402,X
    STA $0403,X
    STA $0404,X
    STA $0405,X
    STA $0406,X
    STA $0407,X
    LDA $0480,X
    STA $0481,X
    STA $0482,X
    STA $0483,X
    STA $0484,X
    STA $0485,X
    STA $0486,X
    STA $0487,X

    CLC
    TXA
    ADC #$08
    TAX
    JMP sprite_complete

normal_render:
    STX zp_var26
    LDX zp_var2B
    CMP #$21
    BCC clamp_value
    LDA #$20
clamp_value:
    STA zp_var5D
    LSR A
    LSR A
    STA zp_var5E
    EOR #$FF
    SEC
    ADC #$08
    STA zp_var5F
    LDA zp_var5D
    AND #$03
    STA zp_var60
    LDY zp_var26
    LDA $0138,Y
    BNE render_sprite_column
    LDY zp_var5E
    JMP column_done

; This function performs sprite data calculation and rendering
; It includes binary search for lookup tables and special rendering modes

;c8ca - c96e
render_sprite_column:
    LDA zp_var5C
    EOR #$FF
    STA zp_var61
    LDY zp_var5E
    BNE column_loop
    JMP column_done

column_loop:
    LDA zp_var59
    STA $0400,X
    ORA #$04
    STA $0480,X

    ; Process first pixel pair
    SEC
    LDA zp_var61
    ADC #$07
    BCC check_pixel1
shift_data1:
    ASL zp_var5A
    ASL zp_var5B
    SEC
    SBC zp_var5C
    BCS shift_data1

check_pixel1:
    LDY zp_var5A
    CPY #$80
    ROL $0400,X
    LDY zp_var5B
    CPY #$80
    ROL $0480,X

    ; Process second pixel pair
    ADC #$07
    BCC check_pixel2
shift_data2:
    ASL zp_var5A
    ASL zp_var5B
    SEC
    SBC zp_var5C
    BCS shift_data2

check_pixel2:
    LDY zp_var5A
    CPY #$80
    ROL $0400,X
    LDY zp_var5B
    CPY #$80
    ROL $0480,X

    ; Process third pixel pair
    ADC #$07
    BCC check_pixel3
shift_data3:
    ASL zp_var5A
    ASL zp_var5B
    SEC
    SBC zp_var5C
    BCS shift_data3

check_pixel3:
    LDY zp_var5A
    CPY #$80
    ROL $0400,X
    LDY zp_var5B
    CPY #$80
    ROL $0480,X

    ; Process fourth pixel pair
    ADC #$07
    BCC check_pixel4
shift_data4:
    ASL zp_var5A
    ASL zp_var5B
    SEC
    SBC zp_var5C
    BCS shift_data4

check_pixel4:
    LDY zp_var5A
    CPY #$80
    ROL $0400,X
    LDY zp_var5B
    CPY #$80
    ROL $0480,X

    STA zp_var61

    ; Apply palette lookup
    LDY $0400,X
    LDA $D610,Y
    STA $0400,X

    INX
    DEC zp_var5E
    BEQ column_done
    JMP column_loop

column_done:
    LDY zp_var26
    LDA $0138,Y
    BNE render_sprite_remainder
    LDY zp_var60
    JMP fill_empty_columns


; This function renders a column of sprite data by:
; 1. Processing 4 pixel pairs per column iteration
; 2. Using bit shifting and rotation for pixel extraction
; 3. Applying palette lookup through $D610 table
; 4. Continuing until all columns are processed

;c983 -c9f6
render_sprite_remainder:
    LDY zp_var60
    BEQ fill_empty_columns
    DEC zp_var5F

pixel_loop:
    LDA zp_var59
    STA $0400,X
    ORA #$04
    STA $0480,X

    ; Extract single pixel
    SEC
    LDA zp_var61
    ADC #$07
    BCC check_pixel
shift_data:
    ASL zp_var5A
    ASL zp_var5B
    SEC
    SBC zp_var5C
    BCS shift_data

check_pixel:
    LDY zp_var5A
    CPY #$80
    ROL $0400,X
    LDY zp_var5B
    CPY #$80
    ROL $0480,X

    DEC zp_var60
    BNE pixel_loop
    INX

fill_empty_columns:
    LDY zp_var5F
    BEQ sprite_complete

fill_loop:
    LDA #$F0
    STA $0400,X
    LDA #$F1
    STA $0480,X
    INX
    DEY
    BNE fill_loop

sprite_complete:
    STX zp_var2B
    LDX zp_var26
    INX
    TXA
    LSR A
    BCC check_next_bit
    JMP setup_rotation

check_next_bit:
    LSR A
    BCC store_result
    JMP jump6DA

store_result:
    TAY
    LDA zp_var25
    ORA zp_buffer
    STA $0030,Y
    INC zp_var2E
    CPX #$1C
    BEQ process_completed

    LDA zp_var2B
    AND #$7F
    STA zp_var2B
    JMP jump6B2

process_completed:
    JSR counter_update
    DEC zp_var2D
    JMP jumpC2CE
.endproc

; This function completes sprite rendering by:
; 1. Processing remaining pixels in the current column
; 2. Filling empty columns with pattern $F0/$F1
; 3. Managing sprite indexing and state transitions
; 4. Jumping to appropriate next processing stages

;cb35 - cdbd
.proc vblank_handler
    PHA
    TXA
    PHA
    TYA
    PHA

    LDA zp_var2E
    BEQ check_frame_flag
    JMP upload_graphics_data

check_frame_flag:
    BIT zp_var2D
    BMI setup_palettes
    JMP restore_state

setup_palettes:
    INC zp_var2D
    LDA zp_ppuctrl
    EOR #$03
    STA zp_ppuctrl

    ; Set PPU address to $23C0 (attribute table)
    LDA zp_var28
    ORA #$03
    STA PPU_ADDRESS
    LDA #$C0
    STA PPU_ADDRESS

    LDA #$A8
    STA PPU_CONTROL

    ; Upload 4 blocks of 7 bytes + 1 zero byte
    LDX #$04
upload_block:
    LDA zp_var31
    STA PPU_VRAM_IO
    LDA zp_var32
    STA PPU_VRAM_IO
    LDA zp_var33
    STA PPU_VRAM_IO
    LDA zp_var34
    STA PPU_VRAM_IO
    LDA zp_var35
    STA PPU_VRAM_IO
    LDA zp_var36
    STA PPU_VRAM_IO
    LDA zp_var37
    STA PPU_VRAM_IO
    LDA #$00
    STA PPU_VRAM_IO
    DEX
    BNE upload_block

    ; Setup palette colors
    LDX #$0F
    LDY zp_var1C
    LDA #$3F
    STA PPU_ADDRESS
    LDA #$00
    STA PPU_ADDRESS

    ; Upload 16 palette entries
    LDA #$27
    STX PPU_VRAM_IO
    STA PPU_VRAM_IO
    STA PPU_VRAM_IO
    STA PPU_VRAM_IO
    STX PPU_VRAM_IO
    STY PPU_VRAM_IO
    LDA zp_var22
    STA PPU_VRAM_IO
    LDA zp_var24
    STA PPU_VRAM_IO
    STX PPU_VRAM_IO
    STY PPU_VRAM_IO
    LDA zp_var23
    STA PPU_VRAM_IO
    LDA zp_var22
    STA PPU_VRAM_IO
    STX PPU_VRAM_IO
    STY PPU_VRAM_IO
    LDA zp_var24
    STA PPU_VRAM_IO
    LDA zp_var23
    STA PPU_VRAM_IO

    LDA #$0E
    STA PPU_MASK
    JMP restore_state

upload_graphics_data:
    LDA #$AC
    STA PPU_CONTROL
    LDA #$03
    STA zp_var2F
    LDX zp_var2C
    LDY zp_var27

upload_row:
    LDA zp_var28
    STA PPU_ADDRESS
    STY PPU_ADDRESS
    INY

    ; Upload 8 bytes in reverse order
    LDA $0407,X
    STA PPU_VRAM_IO
    LDA $0406,X
    STA PPU_VRAM_IO
    LDA $0405,X
    STA PPU_VRAM_IO
    LDA $0404,X
    STA PPU_VRAM_IO
    LDA $0403,X
    STA PPU_VRAM_IO
    LDA $0402,X
    STA PPU_VRAM_IO
    LDA $0401,X
    STA PPU_VRAM_IO
    LDA $0400,X
    STA PPU_VRAM_IO

    ; Upload corresponding high bitplane
    LDA $0480,X
    STA PPU_VRAM_IO
    LDA $0481,X
    STA PPU_VRAM_IO
    LDA $0482,X
    STA PPU_VRAM_IO
    LDA $0483,X
    STA PPU_VRAM_IO
    LDA $0484,X
    STA PPU_VRAM_IO
    LDA $0485,X
    STA PPU_VRAM_IO
    LDA $0486,X
    STA PPU_VRAM_IO
    LDA $0487,X
    STA PPU_VRAM_IO

    ; Upload second row
    LDA zp_var28
    STA PPU_ADDRESS
    STY PPU_ADDRESS
    INY

    LDA $040F,X
    STA PPU_VRAM_IO
    LDA $040E,X
    STA PPU_VRAM_IO
    LDA $040D,X
    STA PPU_VRAM_IO
    LDA $040C,X
    STA PPU_VRAM_IO
    LDA $040B,X
    STA PPU_VRAM_IO
    LDA $040A,X
    STA PPU_VRAM_IO
    LDA $0409,X
    STA PPU_VRAM_IO
    LDA $0408,X
    STA PPU_VRAM_IO

    LDA $0488,X
    STA PPU_VRAM_IO
    LDA $0489,X
    STA PPU_VRAM_IO
    LDA $048A,X
    STA PPU_VRAM_IO
    LDA $048B,X
    STA PPU_VRAM_IO
    LDA $048C,X
    STA PPU_VRAM_IO
    LDA $048D,X
    STA PPU_VRAM_IO
    LDA $048E,X
    STA PPU_VRAM_IO
    LDA $048F,X
    STA PPU_VRAM_IO

    ; Upload third row
    LDA zp_var28
    STA PPU_ADDRESS
    STY PPU_ADDRESS
    INY

    LDA $0417,X
    STA PPU_VRAM_IO
    LDA $0416,X
    STA PPU_VRAM_IO
    LDA $0415,X
    STA PPU_VRAM_IO
    LDA $0414,X
    STA PPU_VRAM_IO
    LDA $0413,X
    STA PPU_VRAM_IO
    LDA $0412,X
    STA PPU_VRAM_IO
    LDA $0411,X
    STA PPU_VRAM_IO
    LDA $0410,X
    STA PPU_VRAM_IO

    LDA $0490,X
    STA PPU_VRAM_IO
    LDA $0491,X
    STA PPU_VRAM_IO
    LDA $0492,X
    STA PPU_VRAM_IO
    LDA $0493,X
    STA PPU_VRAM_IO
    LDA $0494,X
    STA PPU_VRAM_IO
    LDA $0495,X
    STA PPU_VRAM_IO
    LDA $0496,X
    STA PPU_VRAM_IO
    LDA $0497,X
    STA PPU_VRAM_IO

    ; Upload fourth row
    LDA zp_var28
    STA PPU_ADDRESS
    STY PPU_ADDRESS
    INY

    LDA $041F,X
    STA PPU_VRAM_IO
    LDA $041E,X
    STA PPU_VRAM_IO
    LDA $041D,X
    STA PPU_VRAM_IO
    LDA $041C,X
    STA PPU_VRAM_IO
    LDA $041B,X
    STA PPU_VRAM_IO
    LDA $041A,X
    STA PPU_VRAM_IO
    LDA $0419,X
    STA PPU_VRAM_IO
    LDA $0418,X
    STA PPU_VRAM_IO

    LDA $0498,X
    STA PPU_VRAM_IO
    LDA $0499,X
    STA PPU_VRAM_IO
    LDA $049A,X
    STA PPU_VRAM_IO
    LDA $049B,X
    STA PPU_VRAM_IO
    LDA $049C,X
    STA PPU_VRAM_IO
    LDA $049D,X
    STA PPU_VRAM_IO
    LDA $049E,X
    STA PPU_VRAM_IO
    LDA $049F,X
    STA PPU_VRAM_IO

    ; Move to next block
    CLC
    TXA
    ADC #$20
    AND #$7F
    TAX
    DEC zp_var2E
    BEQ upload_complete
    DEC zp_var2F
    BEQ upload_complete
    JMP upload_row

upload_complete:
    STY zp_var27
    STX zp_var2C

restore_state:
    LDA zp_ppuctrl
    STA PPU_CONTROL
    LDA #$F0
    STA PPU_SCROLL
    LDA #$D0
    STA PPU_SCROLL

    PLA
    TAY
    PLA
    TAX
    PLA
    RTI
.endproc

; VBlank interrupt handler that manages PPU uploads:
; - Uploads attribute table data and palettes during setup
; - Transfers graphics data from $0400-$049F to PPU pattern tables
; - Handles multi-frame uploads with proper PPU addressing

;cdbe - cddb
.proc variable_compare_check
    LDA lookup_CA79,Y   ; Load value from lookup table
    BIT zp_var22             ; Test sign bit of variable $22
    BMI store_and_exit  ; Branch if negative
    CMP zp_var22             ; Compare with variable $22
    BEQ return_zero     ; Return 0 if equal
    BIT zp_var23           ; Test sign bit of variable $23
    BMI skip_var23      ; Branch if negative
    CMP zp_var23             ; Compare with variable $23
    BEQ skip_var23_exit ; Return 0 if equal
    BIT zp_var24             ; Test sign bit of variable $24
    BMI skip_var24      ; Branch if negative
    BPL store_value     ; Always branch (unconditional)

store_and_exit:
    STA zp_var22             ; Store A in variable $22
return_zero:
    LDA #$00            ; Load 0
    RTS                 ; Return

skip_var23:
skip_var24:
    JMP store_and_return_two          ; Jump to external routine

skip_var23_exit:
    JMP jumpDDE           ; Jump to external routine

store_value:
    JMP jumpDE3           ; Jump to external routine


;cddc- cde0
store_and_return_one:
    STA zp_var23             ; Store A in variable $23
jumpDDE:
    LDA #$01            ; Load 1
    RTS                 ; Return


;cde1 - cde5
store_and_return_two:
    STA zp_var24             ; Store A in variable $24
jumpDE3:
    LDA #$02            ; Load 2
    RTS                 ; Return
.endproc

.proc nmi_handler
    RTI
.endproc

.proc irq_handler
    RTI
.endproc

.segment "OAM"
oam: .res 256	; sprite OAM data

.segment "CHARS"
    .res $2000, $00            ; Reserve 8KB for CHR data (fill with zeros)

; Add NMI and IRQ handler stubs if not present


.segment "VECTORS"
    .word nmi_handler          ; NMI vector
    .word reset_handler         ; RESET vector
    .word irq_handler          ; IRQ/BRK vector

.segment "STARTUP"
;C000 to C029
.proc reset_handler
        SEI                     ; Disable interrupts (critical for setup)
        CLD                     ; Clear decimal mode (NES doesn't use BCD)
        LDX #$00                ; Load X register with 0
        STX PPU_CONTROL         ; Disable PPU control register ($2000)
        STX PPU_MASK            ; Disable PPU mask register ($2001) - screen off
        DEX                     ; Decrement X (now $FF)
        TXS                     ; Set stack pointer to $FF (top of stack page)
        LDA #$40                ; Load accumulator with $40 (bit 6 set)
        STA $4017               ; Disable frame counter IRQ in APU
        LDA #$00                ; Load accumulator with 0
        STA APU_DM_CONTROL      ; Disable DMC (Delta Modulation Channel)
        BIT PPU_STATUS          ; Read PPU status to clear VBlank flag
wait_vblank1:
        BIT PPU_STATUS          ; Check PPU status register
        BPL wait_vblank1        ; Branch if VBlank flag not set (bit 7 = 0)
wait_vblank2:
        BIT PPU_STATUS          ; Check PPU status register again
        BPL wait_vblank2        ; Branch if VBlank flag not set (bit 7 = 0)
        JSR empty_function               ; Call function at $C046 (outside range)
        JSR ppu_setup               ; Call function at $C047 (outside range)
        JMP game_init               ; Jump to $C25B (outside range)
.endproc
