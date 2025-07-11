
.segment "STARTUP"
;C000 to C029
.proc system_init
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
        JSR $C046               ; Call function at $C046 (outside range)
        JSR $C047               ; Call function at $C047 (outside range)
        JMP $C25B               ; Jump to $C25B (outside range)
.endproc

.segment "CODE"
;C02C to C044
.proc interrupt_handler
        BIT $10                 ; Test bits in zero page location $10
        BMI skip_dispatch       ; Branch if bit 7 is set (negative flag)
        BIT $12                 ; Test bits in zero page location $12
        BPL save_registers      ; Branch if bit 7 is clear (positive flag)
        JMP ($0011)             ; Indirect jump through address stored at $0011-$0012
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
        STA $10                 ; Clear zero page flags
        STA $12
        LDX #$00
        STX $18                 ; Initialize counters/indices
        STX $17

        LDA $CDE6,X             ; Load data from lookup table
        AND #$0F                ; Extract lower nibble
        STA $19
        LDA $CDE6,X             ; Load same data again
        AND #$F0                ; Extract upper nibble
        STA $1A

        LDA #$A8                ; PPU control: NMI enabled, BG pattern table $1000
        STA PPU_CONTROL
        LDA #$06                ; PPU mask: Show background, no sprites
        STA PPU_MASK
        RTS
.endproc

;C073 - C0A6
.proc counter_update
        LDA $17                 ; Load target value
        CMP $18                 ; Compare with current counter
        BEQ exit                ; If equal, skip update

        DEC $18                 ; Decrement counter
        LDA $18
        AND #$07                ; Check if counter is multiple of 8
        BNE exit                ; If not, skip table lookup

        LDA $18                 ; Reload counter value
        BCS skip_add            ; Branch if carry set from previous operations
        ADC #$11                ; Add offset
skip_add:
        SBC #$08                ; Subtract 8 (carry should be set)
        STA $18                 ; Store modified counter

        LDA $17                 ; Load target value
        AND #$07                ; Mask to 3 bits
        ORA $18                 ; Combine with counter
        STA $18                 ; Store result

        LSR A                   ; Shift right 3 times to get table index
        LSR A
        LSR A
        TAX                     ; Use as index

        LDA $CDE6,X             ; Load from data table
        AND #$0F                ; Extract lower nibble
        STA $19
        LDA $CDE6,X             ; Load again
        AND #$F0                ; Extract upper nibble
        STA $1A

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
        STA $23

main_loop:
        LDX #$04                ; Initialize X counter
        LDY #$00                ; Initialize Y counter
        STY $27                 ; Clear shift register
        BEQ setup_shift         ; Always branch (Y=0)

shift_loop:
        DEX                     ; Decrement X
        INY                     ; Increment Y

setup_shift:
        ASL A                   ; Shift accumulator left
        BCS shift_loop          ; Branch if carry set
        STX $25                 ; Store X counter
        STY $26                 ; Store Y counter

        ASL A                   ; Shift again
        PHP                     ; Push processor status
        ASL A                   ; Shift once more
        STA $28                 ; Store shifted value

        LDA #$FF                ; Set up mask value
        ADC #$00                ; Add carry
        EOR #$FF                ; Invert
        STA $24                 ; Store mask

        ASL $28                 ; Shift data left
        ROL $27                 ; Rotate into high byte

        LDY #$07                ; Set up counter for 8 bytes
        PLP                     ; Pull processor status
        BCC simple_render       ; Branch if no special processing

complex_render:
        ASL $28                 ; Shift data
        LDA $27                 ; Get high byte
        ROL A                   ; Rotate
        TAX                     ; Use as index

        LDA $24                 ; Get mask
        AND $CE31,X             ; Apply mask to lookup table
        STA PPU_DATA            ; Write to PPU
        LDA $CE31,X             ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        LDA $24                 ; Get mask again
        AND $CE35,X             ; Apply to second table
        STA PPU_DATA            ; Write to PPU
        LDA $CE35,X             ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        DEC $25                 ; Decrement line counter
        BNE complex_render      ; Continue if not done

        DEC $26                 ; Decrement block counter
        BMI write_buffer        ; Branch if negative

        LDA $02                 ; Get pattern data
        STA PPU_DATA            ; Write to PPU
        LDA #$00                ; Clear value
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement Y
        STA $001B,Y             ; Store again
        LDA $03                 ; Get second pattern
        STA PPU_DATA            ; Write to PPU
        DEY                     ; Decrement Y
        JMP complex_render + 2  ; Continue loop

simple_render:
        LDA $23                 ; Get counter value
        STA $28                 ; Store as data
        DEC $26                 ; Decrement block counter
        BMI final_shift         ; Branch if negative

        LDA $00                 ; Get pattern data
        STA PPU_DATA            ; Write to PPU
        LDA #$00                ; Clear value
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement Y
        STA $001B,Y             ; Store again
        LDA $01                 ; Get second pattern
        STA PPU_DATA            ; Write to PPU
        DEY                     ; Decrement Y
        JMP simple_render + 2   ; Continue loop

final_shift:
        LSR $28                 ; Shift right
        LDA $27                 ; Get high byte
        ROL A                   ; Rotate
        TAX                     ; Use as index

        LDA $24                 ; Get mask
        AND $CE31,X             ; Apply mask
        STA PPU_DATA            ; Write to PPU
        LDA $CE31,X             ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        LDA $24                 ; Get mask again
        AND $CE35,X             ; Apply to second table
        STA PPU_DATA            ; Write to PPU
        LDA $CE35,X             ; Get unmasked data
        STA $001B,Y             ; Store in buffer
        DEY                     ; Decrement counter

        DEC $25                 ; Decrement line counter
        BNE final_shift         ; Continue if not done

write_buffer:
        LDY #$07                ; Set counter for 8 bytes

buffer_loop:
        LDA $001B,Y             ; Load from buffer
        STA PPU_DATA            ; Write to PPU
        DEY                     ; Decrement counter
        BPL buffer_loop         ; Continue if not negative

        CLC                     ; Clear carry
        LDA $23                 ; Get counter
        ADC #$01                ; Increment
        CMP #$F0                ; Check if done
        BEQ fill_patterns       ; Branch if complete
        JMP main_loop           ; Continue main loop

fill_patterns:
        ; Fill pattern data blocks
        LDA $00                 ; Get first pattern
        LDX $01                 ; Get second pattern
        LDY #$04                ; Set counter

fill_loop1:
        STA PPU_DATA            ; Write first pattern
        STX PPU_DATA            ; Write second pattern
        DEY                     ; Decrement counter
        BNE fill_loop1          ; Continue loop

        LDX #$08                ; Set counter for zeros

zero_loop1:
        STY PPU_DATA            ; Write zero (Y=0)
        DEX                     ; Decrement counter
        BNE zero_loop1          ; Continue loop

        LDA $02                 ; Get third pattern
        LDX $03                 ; Get fourth pattern
        LDY #$04                ; Set counter

fill_loop2:
        STA PPU_DATA            ; Write third pattern
        STX PPU_DATA            ; Write fourth pattern
        DEY                     ; Decrement counter
        BNE fill_loop2          ; Continue loop

        LDX #$08                ; Set counter for zeros

zero_loop2:
        STY PPU_DATA            ; Write zero (Y=0)
        DEX                     ; Decrement counter
        BNE zero_loop2          ; Continue loop

        ; Pattern arrangement loops
        LDA #$03                ; Set up counters
        STA $26
        LDA #$01
        STA $25

arrange_loop1:
        LDY $26                 ; Get counter
        LDA $00                 ; Get pattern
        LDX $01

pattern_write1:
        STA PPU_DATA            ; Write pattern data
        STX PPU_DATA
        DEY                     ; Decrement counter
        BNE pattern_write1      ; Continue loop

        LDY $25                 ; Get second counter
        LDA #$00                ; Clear pattern

clear_write1:
        STA PPU_DATA            ; Write zeros
        STA PPU_DATA
        DEY                     ; Decrement counter
        BNE clear_write1        ; Continue loop

        LDX #$08                ; Fill with zeros

final_zero1:
        STY PPU_DATA            ; Write zero
        DEX                     ; Decrement counter
        BNE final_zero1         ; Continue loop

        INC $25                 ; Increment counter
        DEC $26                 ; Decrement counter
        BNE arrange_loop1       ; Continue if not done

        ; Second arrangement phase
        LDA #$03                ; Reset counters
        STA $26
        LDA #$01
        STA $25

arrange_loop2:
        LDY $25                 ; Get first counter
        LDA #$00                ; Clear pattern

clear_write2:
        STA PPU_DATA            ; Write zeros
        STA PPU_DATA
        DEY                     ; Decrement counter
        BNE clear_write2        ; Continue loop

        LDY $26                 ; Get second counter
        LDA $02                 ; Get pattern
        LDX $03

pattern_write2:
        STA PPU_DATA            ; Write pattern data
        STX PPU_DATA
        DEY                     ; Decrement counter
        BNE pattern_write2      ; Continue loop

        LDX #$08                ; Fill with zeros

final_zero2:
        STY PPU_DATA            ; Write zero
        DEX                     ; Decrement counter
        BNE final_zero2         ; Continue loop

        INC $25                 ; Increment counter
        DEC $26                 ; Decrement counter
        BNE arrange_loop2       ; Continue if not done

        RTS
.endproc

;c217 to c221
.proc clear_variables
        LDA #$00                ; Load zero
        STA $13                 ; Clear zero page variables
        STA $14
        STA $15
        STA $16
        RTS
.endproc

;c222 to c25a
.proc read_controllers
        LDA $13                 ; Create inverted masks for edge detection
        EOR #$FF
        STA $15
        LDA $14
        EOR #$FF
        STA $16

        LDA #$01                ; Strobe controllers
        STA $4016
        LSR A
        STA $4016

        LDX #$07                ; Read 8 buttons
read_loop:
        LDA $4016               ; Read controller states
        AND #$03
        CMP #$01
        ROL $13

        LDA $4017
        AND #$03
        CMP #$01
        ROL $14

        DEX
        BPL read_loop

        LDA $13                 ; Isolate newly pressed buttons
        AND $15
        STA $15

        LDA $14
        AND $16
        STA $16

        RTS
.endproc

;C25B - C2FB
.proc game_init
        JSR $C217               ; Clear variables

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
        STA $00
        LDA #$FF
        STA $01
        LDA #$33
        STA $02
        LDA #$CC
        STA $03

        JSR $C0A9               ; Setup graphics

        LDA #$10                ; Initialize game variables
        STA $1C
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
        STA $1D
        STA $1F
        LDA #$06
        STA $1E
        STA $20
        LDA #$00
        STA $21
        LDA #$A8
        STA $1B
        LDA #$00
        STA $2E
        STA $2D

        LDA #$35                ; Setup function pointer
        STA $11
        LDA #$CB
        STA $12
jumpC2CE:
        JSR $C222               ; Read controller input

        LDA $13                 ; Handle B button (move left)
        AND #$02
        BEQ check_a
        LDX $21
        DEX
        DEX
        CPX #$FE
        BNE store_x
        LDX #$A6
store_x:
        STX $21

check_a:
        LDA $13                 ; Handle A button (move right)
        AND #$01
        BEQ check_select_start
        LDX $21
        INX
        INX
        CPX #$A8
        BNE store_x2
        LDX #$00
store_x2:
        STX $21

check_select_start:
        LDA $13                 ; Check Select/Start buttons
        AND #$0C
        BNE continue_game
        JMP $C444               ; Exit if no Select/Start

continue_game:
        ; Function continues...
.endproc

;c444 - c683
.proc ray_cast
        SEC                     ; Calculate angle offsets
        LDA $21
        SBC #$0E
        BCS calc_angle1
        ADC #$A8
calc_angle1:
        STA $2A
        ADC #$29
        CMP #$A8
        BCC calc_angle2
        SBC #$A8
calc_angle2:
        STA $29

        LDA $2D                 ; Wait for specific flag
        BMI calc_angle2

        LDA #$8F                ; Initialize ray parameters
        STA $22
        STA $23
        STA $24
        LDA #$00
        STA $27

        LDA $1B                 ; Setup rendering flags
        AND #$03
        ASL A
        ASL A
        ORA #$20
        STA $28

        LDA #$00
        STA $2B
        STA $2C

        LDX #$00                ; Load sine/cosine tables
        LDA $D3CD,X
        STA $38
        LDA $D3E9,X
        STA $39

        LDY $29                 ; Get direction data
        LDA $CE39,Y
        STA $3A
        ASL A
        TAY
        LDA ($38),Y
        STA $3C
        LDA $D379,Y
        STA $40
        INY
        LDA ($38),Y
        STA $3D
        LDA $D379,Y
        STA $41

        LDY $2A                 ; Get second direction data
        LDA $CE39,Y
        STA $3B
        ASL A
        TAY
        LDA ($38),Y
        STA $3E
        LDA $D379,Y
        STA $42
        INY
        LDA ($38),Y
        STA $3F
        LDA $D379,Y
        STA $43

        LDA $1E                 ; Calculate ray direction X
        LSR A
        LDA $1D
        ROR A
        LSR A
        BIT $3A
        BPL calc_ray_x
        EOR #$80
        LDY #$FF
        STY $44
        BNE setup_ray_x
calc_ray_x:
        EOR #$FF
        LDY #$01
        STY $44
        DEY
setup_ray_x:
        STY $46
        STA $4B
        STA $48

        LDA #$00                ; Multiply ray direction
        STA $4D
multiply_loop1:
        LSR $48
        BCC shift_result1
        TAY
        CLC
        LDA $4D
        ADC $3C
        STA $4D
        TYA
        ADC $3D
shift_result1:
        ROR A
        ROR $4D
        LSR $48
        BEQ end_multiply1
        BCS multiply_loop1
        BCC shift_result1
end_multiply1:
        STA $4E

        LDA $20                 ; Calculate ray direction Y
        LSR A
        LDA $1F
        ROR A
        LSR A
        BIT $3B
        BPL calc_ray_y
        EOR #$80
        LDY #$FE
        STY $45
        LDY #$00
        BEQ setup_ray_y
calc_ray_y:
        EOR #$FF
        LDY #$00
        STY $45
        DEY
setup_ray_y:
        STY $47
        STA $4C
        STA $48

        LDA #$00                ; Multiply ray direction Y
        STA $4F
multiply_loop2:
        LSR $48
        BCC shift_result2
        TAY
        CLC
        LDA $4F
        ADC $3E
        STA $4F
        TYA
        ADC $3F
shift_result2:
        ROR A
        ROR $4F
        LSR $48
        BEQ end_multiply2
        BCS multiply_loop2
        BCC shift_result2
end_multiply2:
        STA $50

        LDA $1E                 ; Setup map lookup
        LSR A
        STA $55
        LDA $20
        LSR A
        STA $56
        TAY
        LDA $0300,Y
        STA $57
        LDA $0380,Y
        STA $58

        LDA #$00                ; Initialize step counters
        STA $49
        STA $4A

ray_loop:
        LDA $4D                 ; Compare ray positions
        CMP $4F
        LDA $4E
        SBC $50
        BCS step_y

        LDA $55                 ; Step X direction
        ADC $44
        STA $55
        TAY
        LDA ($57),Y
        BMI hit_wall_x
        INC $49
        CLC
        LDA $4D
        ADC $3C
        STA $4D
        LDA $4E
        ADC $3D
        STA $4E
        JMP ray_loop

step_y:
        LDA $56                 ; Step Y direction
        ADC $45
        STA $56
        TAY
        LDA $0300,Y
        STA $57
        LDA $0380,Y
        STA $58
        LDY $55
        LDA ($57),Y
        BMI hit_wall_y
        INC $4A
        CLC
        LDA $4F
        ADC $3E
        STA $4F
        LDA $50
        ADC $3F
        STA $50
        JMP ray_loop

hit_wall_x:
        CMP #$FF                ; Handle wall hit X
        BNE store_wall_x
        LDA #$00
store_wall_x:
        STA $0138,X
        LDA $4D
        STA $0100,X
        LDA $4E
        STA $011C,X

        LDA #$00                ; Calculate wall distance
        STA $51
distance_calc_x:
        LSR $4B
        BCC shift_dist_x
        TAY
        CLC
        LDA $51
        ADC $40
        STA $51
        TYA
        ADC $41
shift_dist_x:
        ROR A
        ROR $51
        LSR $4B
        BEQ end_dist_x
        BCS distance_calc_x
        BCC shift_dist_x
end_dist_x:
        STA $52

        LDY $49                 ; Apply step count
        BEQ apply_direction_x
step_apply_x:
        CLC
        LDA $51
        ADC $40
        STA $51
        LDA $52
        ADC $41
        STA $52
        DEY
        BNE step_apply_x

apply_direction_x:
        BIT $3B
        BMI sub_direction_x
        CLC
        LDA $1F
        ADC $51
        STA $51
        LDA $20
        ADC $52
        JMP finish_calc_x
sub_direction_x:
        SEC
        LDA $1F
        SBC $51
        STA $51
        LDA $20
        SBC $52
finish_calc_x:
        LSR A
        ROR $51
        CMP $56
        BEQ no_invert_x
        LDA $51
        EOR #$FF
        JMP apply_shading_x
no_invert_x:
        LDA $51
apply_shading_x:
        EOR $46
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
        LDA $4F
        STA $0100,X
        LDA $50
        STA $011C,X

        LDA #$00                ; Calculate wall distance Y
        STA $53
distance_calc_y:
        LSR $4C
        BCC shift_dist_y
        TAY
        CLC
        LDA $53
        ADC $42
        STA $53
        TYA
        ADC $43
shift_dist_y:
        ROR A
        ROR $53
        LSR $4C
        BEQ end_dist_y
        BCS distance_calc_y
        BCC shift_dist_y
end_dist_y:
        STA $54

        LDY $4A                 ; Apply step count Y
        BEQ apply_direction_y
step_apply_y:
        CLC
        LDA $53
        ADC $42
        STA $53
        LDA $54
        ADC $43
        STA $54
        DEY
        BNE step_apply_y

apply_direction_y:
        BIT $3A
        BMI sub_direction_y
        CLC
        LDA $1D
        ADC $53
        STA $53
        LDA $1E
        ADC $54
        JMP finish_calc_y
sub_direction_y:

continue_function:
        ; Function continues beyond provided code...

.endproc

.proc calculate_sprite_data
    LSR A
    ROR $53
    CMP $55
    BEQ load_value
    LDA $53
    EOR #$FF
    JMP store_value

load_value:
    LDA $53

store_value:
    EOR $47
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
    LDY $29
    INY
    CPY #$A8
    BNE update_y1
    LDY #$00
update_y1:
    STY $29
    LDY $2A
    INY
    CPY #$A8
    BNE update_y2
    LDY #$00
update_y2:
    STY $2A
    JMP $C47B

process_complete:
    SEC
    TXA
    SBC #$04
    TAX
    LDA #$04
wait_loop:
    CMP $2E
    BEQ wait_loop

    LDA #$FF
    STA $30
jump6DA:
    LDY $0138,X
    BNE call_lookup1
    TYA
    BEQ skip_lookup1
call_lookup1:
    JSR $CDBE
skip_lookup1:
    ASL A
    ASL A
    STA $25
    LDY $0139,X
    BNE call_lookup2
    TYA
    BEQ skip_lookup2
call_lookup2:
    JSR $CDBE
skip_lookup2:
    ORA $25
    TAY
    LDA $D605,Y
    STA $25
    BIT $30
    BPL setup_rotation
    AND #$33
    STA $30

setup_rotation:
    LDA #$FC
    ASL $25
    ROL A
    ASL $0154,X
    ROL A
    STA $59

    ; Binary search initialization
    LDY #$00
    STY $5C
    DEY
    STY $5D

    ; Binary search loop (8 iterations)
binary_search:
    CLC
    LDA $5C
    ADC $5D
    ROR A
    TAY
    LDA $0100,X
    CMP $D405,Y
    LDA $011C,X
    SBC $D505,Y
    BCC update_low
    STY $5D
    CLC
    BCC continue_search
update_low:
    INY
    STY $5C
continue_search:
    ; [Repeat pattern 7 more times - condensed for clarity]

    ; Get sprite data
    LDY $0138,X
    LDA $CA7D,Y
    STA $38
    LDA $CA81,Y
    STA $39
    LDY $0154,X
    LDA ($38),Y
    STA $5B
    INY
    LDA ($38),Y
    STA $5A

    LDA $5C
    CMP #$FF
    BNE normal_render

    ; Special case rendering
    LDY $0100,X
    CPY $D504
    BCS normal_render

    STX $26
    LDX $2B
    LDA $59
    ORA #$04
    STA $0400,X
    STA $0480,X

    ; Process high byte
    LDY $5A
    CPY #$80
    ROL $0400,X
    CPY #$80
    ROL $0400,X
    CPY #$80
    ROL $0400,X
    CPY #$80
    ROL $0400,X

    ; Process low byte
    LDY $5B
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
    JMP $C9C8

normal_render:
    STX $26
    LDX $2B
    CMP #$21
    BCC clamp_value
    LDA #$20
clamp_value:
    STA $5D
    LSR A
    LSR A
    STA $5E
    EOR #$FF
    SEC
    ADC #$08
    STA $5F
    LDA $5D
    AND #$03
    STA $60
    LDY $26
    LDA $0138,Y
    BNE continue_processing
    LDY $5E
    BNE continue_processing
    JMP $C963
.endproc

; This function performs sprite data calculation and rendering
; It includes binary search for lookup tables and special rendering modes

;c8ca - c96e
.proc render_sprite_column
    LDA $5C
    EOR #$FF
    STA $61
    LDY $5E
    BNE column_loop
    JMP $C963

column_loop:
    LDA $59
    STA $0400,X
    ORA #$04
    STA $0480,X

    ; Process first pixel pair
    SEC
    LDA $61
    ADC #$07
    BCC check_pixel1
shift_data1:
    ASL $5A
    ASL $5B
    SEC
    SBC $5C
    BCS shift_data1

check_pixel1:
    LDY $5A
    CPY #$80
    ROL $0400,X
    LDY $5B
    CPY #$80
    ROL $0480,X

    ; Process second pixel pair
    ADC #$07
    BCC check_pixel2
shift_data2:
    ASL $5A
    ASL $5B
    SEC
    SBC $5C
    BCS shift_data2

check_pixel2:
    LDY $5A
    CPY #$80
    ROL $0400,X
    LDY $5B
    CPY #$80
    ROL $0480,X

    ; Process third pixel pair
    ADC #$07
    BCC check_pixel3
shift_data3:
    ASL $5A
    ASL $5B
    SEC
    SBC $5C
    BCS shift_data3

check_pixel3:
    LDY $5A
    CPY #$80
    ROL $0400,X
    LDY $5B
    CPY #$80
    ROL $0480,X

    ; Process fourth pixel pair
    ADC #$07
    BCC check_pixel4
shift_data4:
    ASL $5A
    ASL $5B
    SEC
    SBC $5C
    BCS shift_data4

check_pixel4:
    LDY $5A
    CPY #$80
    ROL $0400,X
    LDY $5B
    CPY #$80
    ROL $0480,X

    STA $61

    ; Apply palette lookup
    LDY $0400,X
    LDA $D610,Y
    STA $0400,X

    INX
    DEC $5E
    BEQ column_done
    JMP column_loop

column_done:
    LDY $26
    LDA $0138,Y
    BNE continue_processing
    LDY $60
    BNE continue_processing
    JMP $C9B6
.endproc

; This function renders a column of sprite data by:
; 1. Processing 4 pixel pairs per column iteration
; 2. Using bit shifting and rotation for pixel extraction
; 3. Applying palette lookup through $D610 table
; 4. Continuing until all columns are processed

;c983 -c9f6
.proc render_sprite_remainder
    LDY $60
    BEQ fill_empty_columns
    DEC $5F

pixel_loop:
    LDA $59
    STA $0400,X
    ORA #$04
    STA $0480,X

    ; Extract single pixel
    SEC
    LDA $61
    ADC #$07
    BCC check_pixel
shift_data:
    ASL $5A
    ASL $5B
    SEC
    SBC $5C
    BCS shift_data

check_pixel:
    LDY $5A
    CPY #$80
    ROL $0400,X
    LDY $5B
    CPY #$80
    ROL $0480,X

    DEC $60
    BNE pixel_loop
    INX

fill_empty_columns:
    LDY $5F
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
    STX $2B
    LDX $26
    INX
    TXA
    LSR A
    BCC check_next_bit
    JMP $C704a ----------------------------------------------------------------------------------------------------------------------------

check_next_bit:
    LSR A
    BCC store_result
    JMP jump6DA

store_result:
    TAY
    LDA $25
    ORA $30
    STA $0030,Y
    INC $2E
    CPX #$1C
    BEQ process_complete

    LDA $2B
    AND #$7F
    STA $2B
    JMP jump6B2

process_complete:
    JSR counter_update
    DEC $2D
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

    LDA $2E
    BEQ check_frame_flag
    JMP upload_graphics_data

check_frame_flag:
    BIT $2D
    BMI setup_palettes
    JMP restore_state

setup_palettes:
    INC $2D
    LDA $1B
    EOR #$03
    STA $1B

    ; Set PPU address to $23C0 (attribute table)
    LDA $28
    ORA #$03
    STA PPU_ADDRESS
    LDA #$C0
    STA PPU_ADDRESS

    LDA #$A8
    STA PPU_CONTROL

    ; Upload 4 blocks of 7 bytes + 1 zero byte
    LDX #$04
upload_block:
    LDA $31
    STA PPU_VRAM_IO
    LDA $32
    STA PPU_VRAM_IO
    LDA $33
    STA PPU_VRAM_IO
    LDA $34
    STA PPU_VRAM_IO
    LDA $35
    STA PPU_VRAM_IO
    LDA $36
    STA PPU_VRAM_IO
    LDA $37
    STA PPU_VRAM_IO
    LDA #$00
    STA PPU_VRAM_IO
    DEX
    BNE upload_block

    ; Setup palette colors
    LDX #$0F
    LDY $1C
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
    LDA $22
    STA PPU_VRAM_IO
    LDA $24
    STA PPU_VRAM_IO
    STX PPU_VRAM_IO
    STY PPU_VRAM_IO
    LDA $23
    STA PPU_VRAM_IO
    LDA $22
    STA PPU_VRAM_IO
    STX PPU_VRAM_IO
    STY PPU_VRAM_IO
    LDA $24
    STA PPU_VRAM_IO
    LDA $23
    STA PPU_VRAM_IO

    LDA #$0E
    STA PPU_MASK
    JMP restore_state

upload_graphics_data:
    LDA #$AC
    STA PPU_CONTROL
    LDA #$03
    STA $2F
    LDX $2C
    LDY $27

upload_row:
    LDA $28
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
    LDA $28
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
    LDA $28
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
    LDA $28
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
    DEC $2E
    BEQ upload_complete
    DEC $2F
    BEQ upload_complete
    JMP upload_row

upload_complete:
    STY $27
    STX $2C

restore_state:
    LDA $1B
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
    LDA $CA79,Y         ; Load value from lookup table
    BIT $22             ; Test sign bit of variable $22
    BMI store_and_exit  ; Branch if negative
    CMP $22             ; Compare with variable $22
    BEQ return_zero     ; Return 0 if equal
    BIT $23             ; Test sign bit of variable $23
    BMI skip_var23      ; Branch if negative
    CMP $23             ; Compare with variable $23
    BEQ skip_var23_exit ; Return 0 if equal
    BIT $24             ; Test sign bit of variable $24
    BMI skip_var24      ; Branch if negative
    BPL store_value     ; Always branch (unconditional)

store_and_exit:
    STA $22             ; Store A in variable $22
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
.endproc

;cddc- cde0
.proc store_and_return_one
    STA $23             ; Store A in variable $23
jumpDDE:
    LDA #$01            ; Load 1
    RTS                 ; Return
.endproc

;cde1 - cde5
.proc store_and_return_two
    STA $24             ; Store A in variable $24
jumpDE3:
    LDA #$02            ; Load 2
    RTS                 ; Return
.endproc
