.include "nes.inc"
.include "macros.inc"

.segment "STARTUP"
.proc reset_handler
C000  78             SEI
C001  D8             CLD
C002  A2 00          LDX #$00
C004  8E 00 20       STX PPU_CONTROL
C007  8E 01 20       STX PPU_MASK
C00A  CA             DEX
C00B  9A             TXS
C00C  A9 40          LDA #$40
C00E  8D 17 40       STA $4017
C011  A9 00          LDA #$00
C013  8D 10 40       STA APU_DM_CONTROL
C016  2C 02 20       BIT PPU_STATUS
:
C019  2C 02 20       BIT PPU_STATUS
C01C  10 FB          BPL :-
:
C01E  2C 02 20       BIT PPU_STATUS
C021  10 FB          BPL :-
C023  20 46 C0       JSR one_func
C026  20 47 C0       JSR two_func
C029  4C 5B C2       JMP main
.endproc

.segment "CODE"

.proc three_func
C02C  24 10          BIT $10
C02E  30 07          BMI irq_handler
C030  24 12          BIT $12
C032  10 06          BPL four_func
C034  6C 11 00       JMP five_func
.endproc

.proc irq_handler
  RTI                     ; Return from interrupt (we don't use IRQ)
.endproc

.proc four_func
C03A  48             PHA
C03B  8A             TXA
C03C  48             PHA
C03D  98             TYA
C03E  48             PHA
C03F  68             PLA
C040  A8             TAY
C041  68             PLA
C042  AA             TAX
C043  68             PLA
C044  40             RTI
.endproc

C045               --------unidentified--------

.proc one_func
C046  60             RTS
.endproc

.proc two_func
C047  A9 00          LDA #$00
C049  85 10          STA $10
C04B  85 12          STA $12
C04D  A2 00          LDX #$00
C04F  86 18          STX $18
C051  86 17          STX $17
C053  BD E6 CD       LDA $CDE6,X ;CDE6 is data
C056  29 0F          AND #$0F
C058  85 19          STA $19
C05A  BD E6 CD       LDA $CDE6,X;CDE6 is data
C05D  29 F0          AND #$F0
C05F  85 1A          STA $1A
C061  A9 A8          LDA #$A8
C063  8D 00 20       STA PPU_CONTROL
C066  A9 06          LDA #$06
C068  8D 01 20       STA PPU_MASK
C06B  60             RTS
.endproc

C06C               --------unidentified--------
C072               ---------------

.proc six_func
C073  A5 17          LDA $17
C075  C5 18          CMP $18
C077  F0 2F          BEQ seven_func
C079  C6 18          DEC $18
C07B  A5 18          LDA $18
C07D  29 07          AND #$07
C07F  D0 26          BNE irq_handler ; C0A7
C081  A5 18          LDA $18
C083  B0 02          BCS first
C085  69 11          ADC #$11
first:
C087  E9 08          SBC #$08
C089  85 18          STA $18
C08B  A5 17          LDA $17
C08D  29 07          AND #$07
C08F  05 18          ORA $18
C091  85 18          STA $18
C093  4A             LSR A
C094  4A             LSR A
C095  4A             LSR A
C096  AA             TAX
C097  BD E6 CD       LDA $CDE6,X;CDE6 is data
C09A  29 0F          AND #$0F
C09C  85 19          STA $19
C09E  BD E6 CD       LDA $CDE6,X;CDE6 is data
C0A1  29 F0          AND #$F0
C0A3  85 1A          STA $1A
C0A5  18             CLC
C0A6  60             RTS
.endproc

C0A7               --------unidentified--------

.proc seven_func
C0A8  60             RTS
.endproc

.proc eight_func
C0A9  A9 A8          LDA #$A8
C0AB  8D 00 20       STA PPU_CONTROL
C0AE  A9 04          LDA #$04
C0B0  8D 06 20       STA PPU_ADDRESS
C0B3  A9 00          LDA #$00
C0B5  8D 06 20       STA PPU_ADDRESS
C0B8  A9 40          LDA #$40
twelfth:
C0BA  85 23          STA $23
C0BC  A2 04          LDX #$04
C0BE  A0 00          LDY #$00
C0C0  84 27          STY $27
C0C2  F0 02          BEQ second
third:
C0C4  CA             DEX
C0C5  C8             INY
second:
C0C6  0A             ASL A
C0C7  B0 FB          BCS third
C0C9  86 25          STX $25
C0CB  84 26          STY $26
C0CD  0A             ASL A
C0CE  08             PHP
C0CF  0A             ASL A
C0D0  85 28          STA $28
C0D2  A9 FF          LDA #$FF
C0D4  69 00          ADC #$00
C0D6  49 FF          EOR #$FF
C0D8  85 24          STA $24
C0DA  06 28          ASL $28
C0DC  26 27          ROL $27
C0DE  A0 07          LDY #$07
C0E0  28             PLP
C0E1  90 43          BCC fourth
fifth:
C0E3  06 28          ASL $28
C0E5  A5 27          LDA $27
C0E7  2A             ROL A
C0E8  AA             TAX
C0E9  A5 24          LDA $24
C0EB  3D 31 CE       AND $CE31,X ;is in data
C0EE  8D 07 20       STA PPU_VRAM_IO
C0F1  BD 31 CE       LDA $CE31,X ;is in data
C0F4  99 1B 00       STA $001B,Y ; is in 0022 in ram
C0F7  88             DEY
C0F8  A5 24          LDA $24
C0FA  3D 35 CE       AND $CE35,X ;is in data
C0FD  8D 07 20       STA PPU_VRAM_IO
C100  BD 35 CE       LDA $CE35,X ;is in data
C103  99 1B 00       STA $001B,Y ; is in 0021 in ram
C106  88             DEY
C107  C6 25          DEC $25
C109  D0 D8          BNE fifth
seventh:
C10B  C6 26          DEC $26
C10D  30 5E          BMI sixth
C10F  A5 02          LDA $02
C111  8D 07 20       STA PPU_VRAM_IO
C114  A9 00          LDA #$00
C116  99 1B 00       STA $001B,Y
C119  88             DEY
C11A  99 1B 00       STA $001B,Y
C11D  A5 03          LDA $03
C11F  8D 07 20       STA PPU_VRAM_IO
C122  88             DEY
C123  4C 0B C1       JMP seventh
fourth:
C126  A5 23          LDA $23
C128  85 28          STA $28
ninth:
C12A  C6 26          DEC $26
C12C  30 17          BMI eight
C12E  A5 00          LDA $00
C130  8D 07 20       STA PPU_VRAM_IO
C133  A9 00          LDA #$00
C135  99 1B 00       STA $001B,Y
C138  88             DEY
C139  99 1B 00       STA $001B,Y
C13C  A5 01          LDA $01
C13E  8D 07 20       STA PPU_VRAM_IO
C141  88             DEY
C142  4C 2A C1       JMP ninth
eight:
C145  46 28          LSR $28
C147  A5 27          LDA $27
C149  2A             ROL A
C14A  AA             TAX
C14B  A5 24          LDA $24
C14D  3D 31 CE       AND $CE31,X
C150  8D 07 20       STA PPU_VRAM_IO
C153  BD 31 CE       LDA $CE31,X
C156  99 1B 00       STA $001B,Y
C159  88             DEY
C15A  A5 24          LDA $24
C15C  3D 35 CE       AND $CE35,X
C15F  8D 07 20       STA PPU_VRAM_IO
C162  BD 35 CE       LDA $CE35,X
C165  99 1B 00       STA $001B,Y
C168  88             DEY
C169  C6 25          DEC $25
C16B  D0 D8          BNE eight
sixth:
C16D  A0 07          LDY #$07
tenth:
C16F  B9 1B 00       LDA $001B,Y
C172  8D 07 20       STA PPU_VRAM_IO
C175  88             DEY
C176  10 F7          BPL tenth
C178  18             CLC
C179  A5 23          LDA $23
C17B  69 01          ADC #$01
C17D  C9 F0          CMP #$F0
C17F  F0 03          BEQ eleventh
C181  4C BA C0       JMP twelfth
eleventh:
C184  A5 00          LDA $00
C186  A6 01          LDX $01
C188  A0 04          LDY #$04
thirtenth:
C18A  8D 07 20       STA PPU_VRAM_IO
C18D  8E 07 20       STX PPU_VRAM_IO
C190  88             DEY
C191  D0 F7          BNE thirtenth
C193  A2 08          LDX #$08
fourtenth:
C195  8C 07 20       STY PPU_VRAM_IO
C198  CA             DEX
C199  D0 FA          BNE fourtenth
C19B  A5 02          LDA $02
C19D  A6 03          LDX $03
C19F  A0 04          LDY #$04
fifthtenth:
C1A1  8D 07 20       STA PPU_VRAM_IO
C1A4  8E 07 20       STX PPU_VRAM_IO
C1A7  88             DEY
C1A8  D0 F7          BNE fifthtenth
C1AA  A2 08          LDX #$08
sixtenth:
C1AC  8C 07 20       STY PPU_VRAM_IO
C1AF  CA             DEX
C1B0  D0 FA          BNE sixtenth
C1B2  A9 03          LDA #$03
C1B4  85 26          STA $26
C1B6  A9 01          LDA #$01
C1B8  85 25          STA $25
twentieth:
C1BA  A4 26          LDY $26
C1BC  A5 00          LDA $00
C1BE  A6 01          LDX $01
sevententh:
C1C0  8D 07 20       STA PPU_VRAM_IO
C1C3  8E 07 20       STX PPU_VRAM_IO
C1C6  88             DEY
C1C7  D0 F7          BNE sevententh
C1C9  A4 25          LDY $25
C1CB  A9 00          LDA #$00
eightenth:
C1CD  8D 07 20       STA PPU_VRAM_IO
C1D0  8D 07 20       STA PPU_VRAM_IO
C1D3  88             DEY
C1D4  D0 F7          BNE eightenth
C1D6  A2 08          LDX #$08
ninetenth:
C1D8  8C 07 20       STY PPU_VRAM_IO
C1DB  CA             DEX
C1DC  D0 FA          BNE ninetenth
C1DE  E6 25          INC $25
C1E0  C6 26          DEC $26
C1E2  D0 D6          BNE twentieth
C1E4  A9 03          LDA #$03
C1E6  85 26          STA $26
C1E8  A9 01          LDA #$01
C1EA  85 25          STA $25
twentyfourth:
C1EC  A4 25          LDY $25
C1EE  A9 00          LDA #$00
twentyfirst:
C1F0  8D 07 20       STA PPU_VRAM_IO
C1F3  8D 07 20       STA PPU_VRAM_IO
C1F6  88             DEY
C1F7  D0 F7          BNE twentyfirst
C1F9  A4 26          LDY $26
C1FB  A5 02          LDA $02
C1FD  A6 03          LDX $03
twentysecond:
C1FF  8D 07 20       STA PPU_VRAM_IO
C202  8E 07 20       STX PPU_VRAM_IO
C205  88             DEY
C206  D0 F7          BNE twentysecond
C208  A2 08          LDX #$08
twentyThird:
C20A  8C 07 20       STY PPU_VRAM_IO
C20D  CA             DEX
C20E  D0 FA          BNE twentyThird
C210  E6 25          INC $25
C212  C6 26          DEC $26
C214  D0 D6          BNE twentyfourth
C216  60             RTS
.endproc

.proc nine_func
C217  A9 00          LDA #$00
C219  85 13          STA $13
C21B  85 14          STA $14
C21D  85 15          STA $15
C21F  85 16          STA $16
C221  60             RTS
.endproc

.proc ten_func
C222  A5 13          LDA $13
C224  49 FF          EOR #$FF
C226  85 15          STA $15
C228  A5 14          LDA $14
C22A  49 FF          EOR #$FF
C22C  85 16          STA $16
C22E  A9 01          LDA #$01
C230  8D 16 40       STA $4016
C233  4A             LSR A
C234  8D 16 40       STA $4016
C237  A2 07          LDX #$07
twentyfifth:
C239  AD 16 40       LDA $4016
C23C  29 03          AND #$03
C23E  C9 01          CMP #$01
C240  26 13          ROL $13
C242  AD 17 40       LDA $4017
C245  29 03          AND #$03
C247  C9 01          CMP #$01
C249  26 14          ROL $14
C24B  CA             DEX
C24C  10 EB          BPL twentyfifth
C24E  A5 13          LDA $13
C250  25 15          AND $15
C252  85 15          STA $15
C254  A5 14          LDA $14
C256  25 16          AND $16
C258  85 16          STA $16
C25A  60             RTS
.endproc

.proc main
C25B  20 17 C2       JSR nine_func
C25E  A2 00          LDX #$00
C260  8E 06 20       STX PPU_ADDRESS
C263  8E 06 20       STX PPU_ADDRESS
C266  A0 30          LDY #$30
C268  8A             TXA
twentysixth:
C269  8D 07 20       STA PPU_VRAM_IO
C26C  CA             DEX
C26D  D0 FA          BNE twentysixth
C26F  88             DEY
C270  D0 F7          BNE twentysixth
C272  A9 FF          LDA #$FF
C274  85 00          STA $00
C276  A9 FF          LDA #$FF
C278  85 01          STA $01
C27A  A9 33          LDA #$33
C27C  85 02          STA $02
C27E  A9 CC          LDA #$CC
C280  85 03          STA $03
C282  20 A9 C0       JSR eight_func
C285  A9 10          LDA #$10
C287  85 1C          STA $1C
C289  A9 F9          LDA #$F9
C28B  8D 00 03       STA $0300
C28E  A9 C9          LDA #$C9
C290  8D 80 03       STA $0380
C293  A0 10          LDY #$10
C295  A2 00          LDX #$00
twentySeventh:
C297  18             CLC
C298  98             TYA
C299  7D 00 03       ADC $0300,X
C29C  9D 01 03       STA $0301,X
C29F  BD 80 03       LDA $0380,X
C2A2  69 00          ADC #$00
C2A4  9D 81 03       STA $0381,X
C2A7  E8             INX
C2A8  E0 7F          CPX #$7F
C2AA  D0 EB          BNE twentySeventh
C2AC  A9 20          LDA #$20
C2AE  85 1D          STA $1D
C2B0  85 1F          STA $1F
C2B2  A9 06          LDA #$06
C2B4  85 1E          STA $1E
C2B6  85 20          STA $20
C2B8  A9 00          LDA #$00
C2BA  85 21          STA $21
C2BC  A9 A8          LDA #$A8
C2BE  85 1B          STA $1B
C2C0  A9 00          LDA #$00
C2C2  85 2E          STA $2E
C2C4  85 2D          STA $2D
C2C6  A9 35          LDA #$35
C2C8  85 11          STA $11
C2CA  A9 CB          LDA #$CB
C2CC  85 12          STA $12
C2CE  20 22 C2       JSR ten_func
C2D1  A5 13          LDA $13
C2D3  29 02          AND #$02
C2D5  F0 0C          BEQ twentyEighth
C2D7  A6 21          LDX $21
C2D9  CA             DEX
C2DA  CA             DEX
C2DB  E0 FE          CPX #$FE
C2DD  D0 02          BNE twentyninth
C2DF  A2 A6          LDX #$A6
twentyninth:
C2E1  86 21          STX $21
twentyEighth:
C2E3  A5 13          LDA $13
C2E5  29 01          AND #$01
C2E7  F0 0C          BEQ thirtyith
C2E9  A6 21          LDX $21
C2EB  E8             INX
C2EC  E8             INX
C2ED  E0 A8          CPX #$A8
C2EF  D0 02          BNE $thirtyfirst
C2F1  A2 00          LDX #$00
thirtyfirst:
C2F3  86 21          STX $21
thirtyith:
C2F5  A5 13          LDA $13
C2F7  29 0C          AND #$0C
C2F9  D0 03          BNE irq_handler ;c2fe
C2FB  4C 44 C4       JMP eleven_func
.endproc

C2FE               --------unidentified--------
C443               ----------------

.proc eleven_func
C444  38             SEC
C445  A5 21          LDA $21
C447  E9 0E          SBC #$0E
C449  B0 02          BCS $C44D
C44B  69 A8          ADC #$A8
C44D  85 2A          STA $2A
C44F  69 29          ADC #$29
C451  C9 A8          CMP #$A8
C453  90 02          BCC $C457
C455  E9 A8          SBC #$A8
C457  85 29          STA $29
C459  A5 2D          LDA $2D
C45B  30 FC          BMI $C459
C45D  A9 8F          LDA #$8F
C45F  85 22          STA $22
C461  85 23          STA $23
C463  85 24          STA $24
C465  A9 00          LDA #$00
C467  85 27          STA $27
C469  A5 1B          LDA $1B
C46B  29 03          AND #$03
C46D  0A             ASL A
C46E  0A             ASL A
C46F  09 20          ORA #$20
C471  85 28          STA $28
C473  A9 00          LDA #$00
C475  85 2B          STA $2B
C477  85 2C          STA $2C
C479  A2 00          LDX #$00
C47B  BD CD D3       LDA $D3CD,X
C47E  85 38          STA $38
C480  BD E9 D3       LDA $D3E9,X
C483  85 39          STA $39
C485  A4 29          LDY $29
C487  B9 39 CE       LDA $CE39,Y
C48A  85 3A          STA $3A
C48C  0A             ASL A
C48D  A8             TAY
C48E  B1 38          LDA ($38),Y
C490  85 3C          STA $3C
C492  B9 79 D3       LDA $D379,Y
C495  85 40          STA $40
C497  C8             INY
C498  B1 38          LDA ($38),Y
C49A  85 3D          STA $3D
C49C  B9 79 D3       LDA $D379,Y
C49F  85 41          STA $41
C4A1  A4 2A          LDY $2A
C4A3  B9 39 CE       LDA $CE39,Y
C4A6  85 3B          STA $3B
C4A8  0A             ASL A
C4A9  A8             TAY
C4AA  B1 38          LDA ($38),Y
C4AC  85 3E          STA $3E
C4AE  B9 79 D3       LDA $D379,Y
C4B1  85 42          STA $42
C4B3  C8             INY
C4B4  B1 38          LDA ($38),Y
C4B6  85 3F          STA $3F
C4B8  B9 79 D3       LDA $D379,Y
C4BB  85 43          STA $43
C4BD  A5 1E          LDA $1E
C4BF  4A             LSR A
C4C0  A5 1D          LDA $1D
C4C2  6A             ROR A
C4C3  4A             LSR A
C4C4  24 3A          BIT $3A
C4C6  10 08          BPL $C4D0
C4C8  49 80          EOR #$80
C4CA  A0 FF          LDY #$FF
C4CC  84 44          STY $44
C4CE  D0 07          BNE $C4D7
C4D0  49 FF          EOR #$FF
C4D2  A0 01          LDY #$01
C4D4  84 44          STY $44
C4D6  88             DEY
C4D7  84 46          STY $46
C4D9  85 4B          STA $4B
C4DB  85 48          STA $48
C4DD  A9 00          LDA #$00
C4DF  85 4D          STA $4D
C4E1  46 48          LSR $48
C4E3  90 0B          BCC $C4F0
C4E5  A8             TAY
C4E6  18             CLC
C4E7  A5 4D          LDA $4D
C4E9  65 3C          ADC $3C
C4EB  85 4D          STA $4D
C4ED  98             TYA
C4EE  65 3D          ADC $3D
C4F0  6A             ROR A
C4F1  66 4D          ROR $4D
C4F3  46 48          LSR $48
C4F5  F0 04          BEQ $C4FB
C4F7  B0 EC          BCS $C4E5
C4F9  90 F5          BCC $C4F0
C4FB  85 4E          STA $4E
C4FD  A5 20          LDA $20
C4FF  4A             LSR A
C500  A5 1F          LDA $1F
C502  6A             ROR A
C503  4A             LSR A
C504  24 3B          BIT $3B
C506  10 0A          BPL $C512
C508  49 80          EOR #$80
C50A  A0 FE          LDY #$FE
C50C  84 45          STY $45
C50E  A0 00          LDY #$00
C510  F0 07          BEQ $C519
C512  49 FF          EOR #$FF
C514  A0 00          LDY #$00
C516  84 45          STY $45
C518  88             DEY
C519  84 47          STY $47
C51B  85 4C          STA $4C
C51D  85 48          STA $48
C51F  A9 00          LDA #$00
C521  85 4F          STA $4F
C523  46 48          LSR $48
C525  90 0B          BCC $C532
C527  A8             TAY
C528  18             CLC
C529  A5 4F          LDA $4F
C52B  65 3E          ADC $3E
C52D  85 4F          STA $4F
C52F  98             TYA
C530  65 3F          ADC $3F
C532  6A             ROR A
C533  66 4F          ROR $4F
C535  46 48          LSR $48
C537  F0 04          BEQ $C53D
C539  B0 EC          BCS $C527
C53B  90 F5          BCC $C532
C53D  85 50          STA $50
C53F  A5 1E          LDA $1E
C541  4A             LSR A
C542  85 55          STA $55
C544  A5 20          LDA $20
C546  4A             LSR A
C547  85 56          STA $56
C549  A8             TAY
C54A  B9 00 03       LDA $0300,Y
C54D  85 57          STA $57
C54F  B9 80 03       LDA $0380,Y
C552  85 58          STA $58
C554  A9 00          LDA #$00
C556  85 49          STA $49
C558  85 4A          STA $4A
C55A  A5 4D          LDA $4D
C55C  C5 4F          CMP $4F
C55E  A5 4E          LDA $4E
C560  E5 50          SBC $50
C562  B0 1D          BCS $C581
C564  A5 55          LDA $55
C566  65 44          ADC $44
C568  85 55          STA $55
C56A  A8             TAY
C56B  B1 57          LDA ($57),Y
C56D  30 3E          BMI $C5AD
C56F  E6 49          INC $49
C571  18             CLC
C572  A5 4D          LDA $4D
C574  65 3C          ADC $3C
C576  85 4D          STA $4D
C578  A5 4E          LDA $4E
C57A  65 3D          ADC $3D
C57C  85 4E          STA $4E
C57E  4C 5A C5       JMP $C55A
C581  A5 56          LDA $56
C583  65 45          ADC $45
C585  85 56          STA $56
C587  A8             TAY
C588  B9 00 03       LDA $0300,Y
C58B  85 57          STA $57
C58D  B9 80 03       LDA $0380,Y
C590  85 58          STA $58
C592  A4 55          LDY $55
C594  B1 57          LDA ($57),Y
C596  30 12          BMI $C5AA
C598  E6 4A          INC $4A
C59A  18             CLC
C59B  A5 4F          LDA $4F
C59D  65 3E          ADC $3E
C59F  85 4F          STA $4F
C5A1  A5 50          LDA $50
C5A3  65 3F          ADC $3F
C5A5  85 50          STA $50
C5A7  4C 5A C5       JMP $C55A
C5AA  4C 2D C6       JMP $C62D
C5AD  C9 FF          CMP #$FF
C5AF  D0 02          BNE $C5B3
C5B1  A9 00          LDA #$00
C5B3  9D 38 01       STA $0138,X
C5B6  A5 4D          LDA $4D
C5B8  9D 00 01       STA $0100,X
C5BB  A5 4E          LDA $4E
C5BD  9D 1C 01       STA $011C,X
C5C0  A9 00          LDA #$00
C5C2  85 51          STA $51
C5C4  46 4B          LSR $4B
C5C6  90 0B          BCC $C5D3
C5C8  A8             TAY
C5C9  18             CLC
C5CA  A5 51          LDA $51
C5CC  65 40          ADC $40
C5CE  85 51          STA $51
C5D0  98             TYA
C5D1  65 41          ADC $41
C5D3  6A             ROR A
C5D4  66 51          ROR $51
C5D6  46 4B          LSR $4B
C5D8  F0 04          BEQ $C5DE
C5DA  B0 EC          BCS $C5C8
C5DC  90 F5          BCC $C5D3
C5DE  85 52          STA $52
C5E0  A4 49          LDY $49
C5E2  F0 10          BEQ $C5F4
C5E4  18             CLC
C5E5  A5 51          LDA $51
C5E7  65 40          ADC $40
C5E9  85 51          STA $51
C5EB  A5 52          LDA $52
C5ED  65 41          ADC $41
C5EF  85 52          STA $52
C5F1  88             DEY
C5F2  D0 F0          BNE $C5E4
C5F4  24 3B          BIT $3B
C5F6  30 0E          BMI $C606
C5F8  18             CLC
C5F9  A5 1F          LDA $1F
C5FB  65 51          ADC $51
C5FD  85 51          STA $51
C5FF  A5 20          LDA $20
C601  65 52          ADC $52
C603  4C 11 C6       JMP $C611
C606  38             SEC
C607  A5 1F          LDA $1F
C609  E5 51          SBC $51
C60B  85 51          STA $51
C60D  A5 20          LDA $20
C60F  E5 52          SBC $52
C611  4A             LSR A
C612  66 51          ROR $51
C614  C5 56          CMP $56
C616  F0 07          BEQ $C61F
C618  A5 51          LDA $51
C61A  49 FF          EOR #$FF
C61C  4C 21 C6       JMP $C621
C61F  A5 51          LDA $51
C621  45 46          EOR $46
C623  4A             LSR A
C624  4A             LSR A
C625  4A             LSR A
C626  4A             LSR A
C627  4A             LSR A
C628  9D 54 01       STA $0154,X
C62B  10 7F          BPL $C6AC
C62D  C9 FF          CMP #$FF
C62F  D0 02          BNE $C633
C631  A9 00          LDA #$00
C633  9D 38 01       STA $0138,X
C636  A5 4F          LDA $4F
C638  9D 00 01       STA $0100,X
C63B  A5 50          LDA $50
C63D  9D 1C 01       STA $011C,X
C640  A9 00          LDA #$00
C642  85 53          STA $53
C644  46 4C          LSR $4C
C646  90 0B          BCC $C653
C648  A8             TAY
C649  18             CLC
C64A  A5 53          LDA $53
C64C  65 42          ADC $42
C64E  85 53          STA $53
C650  98             TYA
C651  65 43          ADC $43
C653  6A             ROR A
C654  66 53          ROR $53
C656  46 4C          LSR $4C
C658  F0 04          BEQ $C65E
C65A  B0 EC          BCS $C648
C65C  90 F5          BCC $C653
C65E  85 54          STA $54
C660  A4 4A          LDY $4A
C662  F0 10          BEQ $C674
C664  18             CLC
C665  A5 53          LDA $53
C667  65 42          ADC $42
C669  85 53          STA $53
C66B  A5 54          LDA $54
C66D  65 43          ADC $43
C66F  85 54          STA $54
C671  88             DEY
C672  D0 F0          BNE $C664
C674  24 3A          BIT $3A
C676  30 0E          BMI $C686
C678  18             CLC
C679  A5 1D          LDA $1D
C67B  65 53          ADC $53
C67D  85 53          STA $53
C67F  A5 1E          LDA $1E
C681  65 54          ADC $54
C683  4C 91 C6       JMP $C691
.endproc

C686               --------unidentified--------
C690               ----------------
C691  4A             LSR A
C692  66 53          ROR $53
C694  C5 55          CMP $55
C696  F0 07          BEQ $C69F
C698  A5 53          LDA $53
C69A  49 FF          EOR #$FF
C69C  4C A1 C6       JMP $C6A1
C69F  A5 53          LDA $53
C6A1  45 47          EOR $47
C6A3  4A             LSR A
C6A4  4A             LSR A
C6A5  4A             LSR A
C6A6  4A             LSR A
C6A7  38             SEC
C6A8  6A             ROR A
C6A9  9D 54 01       STA $0154,X
C6AC  E8             INX
C6AD  8A             TXA
C6AE  29 03          AND #$03
C6B0  F0 19          BEQ $C6CB
C6B2  A4 29          LDY $29
C6B4  C8             INY
C6B5  C0 A8          CPY #$A8
C6B7  D0 02          BNE $C6BB
C6B9  A0 00          LDY #$00
C6BB  84 29          STY $29
C6BD  A4 2A          LDY $2A
C6BF  C8             INY
C6C0  C0 A8          CPY #$A8
C6C2  D0 02          BNE $C6C6
C6C4  A0 00          LDY #$00
C6C6  84 2A          STY $2A
C6C8  4C 7B C4       JMP $C47B
C6CB  38             SEC
C6CC  8A             TXA
C6CD  E9 04          SBC #$04
C6CF  AA             TAX
C6D0  A9 04          LDA #$04
C6D2  C5 2E          CMP $2E
C6D4  F0 FC          BEQ $C6D2
C6D6  A9 FF          LDA #$FF
C6D8  85 30          STA $30
C6DA  BC 38 01       LDY $0138,X
C6DD  D0 03          BNE $C6E2
C6DF  98             TYA
C6E0  F0 03          BEQ $C6E5
C6E2  20 BE CD       JSR $CDBE
C6E5  0A             ASL A
C6E6  0A             ASL A
C6E7  85 25          STA $25
C6E9  BC 39 01       LDY $0139,X
C6EC  D0 03          BNE $C6F1
C6EE  98             TYA
C6EF  F0 03          BEQ $C6F4
C6F1  20 BE CD       JSR $CDBE
C6F4  05 25          ORA $25
C6F6  A8             TAY
C6F7  B9 05 D6       LDA $D605,Y
C6FA  85 25          STA $25
C6FC  24 30          BIT $30
C6FE  10 04          BPL $C704
C700  29 33          AND #$33
C702  85 30          STA $30
C704  A9 FC          LDA #$FC
C706  06 25          ASL $25
C708  2A             ROL A
C709  1E 54 01       ASL $0154,X
C70C  2A             ROL A
C70D  85 59          STA $59
C70F  A0 00          LDY #$00
C711  84 5C          STY $5C
C713  88             DEY
C714  84 5D          STY $5D
C716  18             CLC
C717  A5 5C          LDA $5C
C719  65 5D          ADC $5D
C71B  6A             ROR A
C71C  A8             TAY
C71D  BD 00 01       LDA $0100,X
C720  D9 05 D4       CMP $D405,Y
C723  BD 1C 01       LDA $011C,X
C726  F9 05 D5       SBC $D505,Y
C729  90 05          BCC $C730
C72B  84 5D          STY $5D
C72D  18             CLC
C72E  90 03          BCC $C733
C730  C8             INY
C731  84 5C          STY $5C
C733  A5 5C          LDA $5C
C735  65 5D          ADC $5D
C737  6A             ROR A
C738  A8             TAY
C739  BD 00 01       LDA $0100,X
C73C  D9 05 D4       CMP $D405,Y
C73F  BD 1C 01       LDA $011C,X
C742  F9 05 D5       SBC $D505,Y
C745  90 05          BCC $C74C
C747  84 5D          STY $5D
C749  18             CLC
C74A  90 03          BCC $C74F
C74C  C8             INY
C74D  84 5C          STY $5C
C74F  A5 5C          LDA $5C
C751  65 5D          ADC $5D
C753  6A             ROR A
C754  A8             TAY
C755  BD 00 01       LDA $0100,X
C758  D9 05 D4       CMP $D405,Y
C75B  BD 1C 01       LDA $011C,X
C75E  F9 05 D5       SBC $D505,Y
C761  90 05          BCC $C768
C763  84 5D          STY $5D
C765  18             CLC
C766  90 03          BCC $C76B
C768  C8             INY
C769  84 5C          STY $5C
C76B  A5 5C          LDA $5C
C76D  65 5D          ADC $5D
C76F  6A             ROR A
C770  A8             TAY
C771  BD 00 01       LDA $0100,X
C774  D9 05 D4       CMP $D405,Y
C777  BD 1C 01       LDA $011C,X
C77A  F9 05 D5       SBC $D505,Y
C77D  90 05          BCC $C784
C77F  84 5D          STY $5D
C781  18             CLC
C782  90 03          BCC $C787
C784  C8             INY
C785  84 5C          STY $5C
C787  A5 5C          LDA $5C
C789  65 5D          ADC $5D
C78B  6A             ROR A
C78C  A8             TAY
C78D  BD 00 01       LDA $0100,X
C790  D9 05 D4       CMP $D405,Y
C793  BD 1C 01       LDA $011C,X
C796  F9 05 D5       SBC $D505,Y
C799  90 05          BCC $C7A0
C79B  84 5D          STY $5D
C79D  18             CLC
C79E  90 03          BCC $C7A3
C7A0  C8             INY
C7A1  84 5C          STY $5C
C7A3  A5 5C          LDA $5C
C7A5  65 5D          ADC $5D
C7A7  6A             ROR A
C7A8  A8             TAY
C7A9  BD 00 01       LDA $0100,X
C7AC  D9 05 D4       CMP $D405,Y
C7AF  BD 1C 01       LDA $011C,X
C7B2  F9 05 D5       SBC $D505,Y
C7B5  90 05          BCC $C7BC
C7B7  84 5D          STY $5D
C7B9  18             CLC
C7BA  90 03          BCC $C7BF
C7BC  C8             INY
C7BD  84 5C          STY $5C
C7BF  A5 5C          LDA $5C
C7C1  65 5D          ADC $5D
C7C3  6A             ROR A
C7C4  A8             TAY
C7C5  BD 00 01       LDA $0100,X
C7C8  D9 05 D4       CMP $D405,Y
C7CB  BD 1C 01       LDA $011C,X
C7CE  F9 05 D5       SBC $D505,Y
C7D1  90 05          BCC $C7D8
C7D3  84 5D          STY $5D
C7D5  18             CLC
C7D6  90 03          BCC $C7DB
C7D8  C8             INY
C7D9  84 5C          STY $5C
C7DB  A5 5C          LDA $5C
C7DD  65 5D          ADC $5D
C7DF  6A             ROR A
C7E0  A8             TAY
C7E1  BD 00 01       LDA $0100,X
C7E4  D9 05 D4       CMP $D405,Y
C7E7  BD 1C 01       LDA $011C,X
C7EA  F9 05 D5       SBC $D505,Y
C7ED  90 05          BCC $C7F4
C7EF  84 5D          STY $5D
C7F1  18             CLC
C7F2  90 03          BCC $C7F7
C7F4  C8             INY
C7F5  84 5C          STY $5C
C7F7  BC 38 01       LDY $0138,X
C7FA  B9 7D CA       LDA $CA7D,Y
C7FD  85 38          STA $38
C7FF  B9 81 CA       LDA $CA81,Y
C802  85 39          STA $39
C804  BC 54 01       LDY $0154,X
C807  B1 38          LDA ($38),Y
C809  85 5B          STA $5B
C80B  C8             INY
C80C  B1 38          LDA ($38),Y
C80E  85 5A          STA $5A
C810  A5 5C          LDA $5C
C812  C9 FF          CMP #$FF
C814  D0 7A          BNE $C890
C816  BC 00 01       LDY $0100,X
C819  CC 04 D5       CPY $D504
C81C  B0 72          BCS $C890
C81E  86 26          STX $26
C820  A6 2B          LDX $2B
C822  A5 59          LDA $59
C824  09 04          ORA #$04
C826  9D 00 04       STA $0400,X
C829  9D 80 04       STA $0480,X
C82C  A4 5A          LDY $5A
C82E  C0 80          CPY #$80
C830  3E 00 04       ROL $0400,X
C833  C0 80          CPY #$80
C835  3E 00 04       ROL $0400,X
C838  C0 80          CPY #$80
C83A  3E 00 04       ROL $0400,X
C83D  C0 80          CPY #$80
C83F  3E 00 04       ROL $0400,X
C842  A4 5B          LDY $5B
C844  C0 80          CPY #$80
C846  3E 80 04       ROL $0480,X
C849  C0 80          CPY #$80
C84B  3E 80 04       ROL $0480,X
C84E  C0 80          CPY #$80
C850  3E 80 04       ROL $0480,X
C853  C0 80          CPY #$80
C855  3E 80 04       ROL $0480,X
C858  BD 00 04       LDA $0400,X
C85B  9D 01 04       STA $0401,X
C85E  9D 02 04       STA $0402,X
C861  9D 03 04       STA $0403,X
C864  9D 04 04       STA $0404,X
C867  9D 05 04       STA $0405,X
C86A  9D 06 04       STA $0406,X
C86D  9D 07 04       STA $0407,X
C870  BD 80 04       LDA $0480,X
C873  9D 81 04       STA $0481,X
C876  9D 82 04       STA $0482,X
C879  9D 83 04       STA $0483,X
C87C  9D 84 04       STA $0484,X
C87F  9D 85 04       STA $0485,X
C882  9D 86 04       STA $0486,X
C885  9D 87 04       STA $0487,X
C888  18             CLC
C889  8A             TXA
C88A  69 08          ADC #$08
C88C  AA             TAX
C88D  4C C8 C9       JMP $C9C8
C890  86 26          STX $26
C892  A6 2B          LDX $2B
C894  C9 21          CMP #$21
C896  90 02          BCC $C89A
C898  A9 20          LDA #$20
C89A  85 5D          STA $5D
C89C  4A             LSR A
C89D  4A             LSR A
C89E  85 5E          STA $5E
C8A0  49 FF          EOR #$FF
C8A2  38             SEC
C8A3  69 08          ADC #$08
C8A5  85 5F          STA $5F
C8A7  A5 5D          LDA $5D
C8A9  29 03          AND #$03
C8AB  85 60          STA $60
C8AD  A4 26          LDY $26
C8AF  B9 38 01       LDA $0138,Y
C8B2  D0 16          BNE $C8CA
C8B4  A4 5E          LDY $5E
C8B6  D0 03          BNE $C8BB
C8B8  4C 63 C9       JMP $C963
C8BB               --------unidentified--------
C8C9               ----------------
C8CA  A5 5C          LDA $5C
C8CC  49 FF          EOR #$FF
C8CE  85 61          STA $61
C8D0  A4 5E          LDY $5E
C8D2  D0 03          BNE $C8D7
C8D4  4C 63 C9       JMP $C963
C8D7  A5 59          LDA $59
C8D9  9D 00 04       STA $0400,X
C8DC  09 04          ORA #$04
C8DE  9D 80 04       STA $0480,X
C8E1  38             SEC
C8E2  A5 61          LDA $61
C8E4  69 07          ADC #$07
C8E6  90 09          BCC $C8F1
C8E8  06 5A          ASL $5A
C8EA  06 5B          ASL $5B
C8EC  38             SEC
C8ED  E5 5C          SBC $5C
C8EF  B0 F7          BCS $C8E8
C8F1  A4 5A          LDY $5A
C8F3  C0 80          CPY #$80
C8F5  3E 00 04       ROL $0400,X
C8F8  A4 5B          LDY $5B
C8FA  C0 80          CPY #$80
C8FC  3E 80 04       ROL $0480,X
C8FF  69 07          ADC #$07
C901  90 09          BCC $C90C
C903  06 5A          ASL $5A
C905  06 5B          ASL $5B
C907  38             SEC
C908  E5 5C          SBC $5C
C90A  B0 F7          BCS $C903
C90C  A4 5A          LDY $5A
C90E  C0 80          CPY #$80
C910  3E 00 04       ROL $0400,X
C913  A4 5B          LDY $5B
C915  C0 80          CPY #$80
C917  3E 80 04       ROL $0480,X
C91A  69 07          ADC #$07
C91C  90 09          BCC $C927
C91E  06 5A          ASL $5A
C920  06 5B          ASL $5B
C922  38             SEC
C923  E5 5C          SBC $5C
C925  B0 F7          BCS $C91E
C927  A4 5A          LDY $5A
C929  C0 80          CPY #$80
C92B  3E 00 04       ROL $0400,X
C92E  A4 5B          LDY $5B
C930  C0 80          CPY #$80
C932  3E 80 04       ROL $0480,X
C935  69 07          ADC #$07
C937  90 09          BCC $C942
C939  06 5A          ASL $5A
C93B  06 5B          ASL $5B
C93D  38             SEC
C93E  E5 5C          SBC $5C
C940  B0 F7          BCS $C939
C942  A4 5A          LDY $5A
C944  C0 80          CPY #$80
C946  3E 00 04       ROL $0400,X
C949  A4 5B          LDY $5B
C94B  C0 80          CPY #$80
C94D  3E 80 04       ROL $0480,X
C950  85 61          STA $61
C952  BC 00 04       LDY $0400,X
C955  B9 10 D6       LDA $D610,Y
C958  9D 00 04       STA $0400,X
C95B  E8             INX
C95C  C6 5E          DEC $5E
C95E  F0 03          BEQ $C963
C960  4C D7 C8       JMP $C8D7
C963  A4 26          LDY $26
C965  B9 38 01       LDA $0138,Y
C968  D0 19          BNE $C983
C96A  A4 60          LDY $60
C96C  D0 03          BNE $C971
C96E  4C B6 C9       JMP $C9B6
C971               --------unidentified--------
C982               ----------------
C983  A4 60          LDY $60
C985  F0 2F          BEQ $C9B6
C987  C6 5F          DEC $5F
C989  A5 59          LDA $59
C98B  9D 00 04       STA $0400,X
C98E  09 04          ORA #$04
C990  9D 80 04       STA $0480,X
C993  38             SEC
C994  A5 61          LDA $61
C996  69 07          ADC #$07
C998  90 09          BCC $C9A3
C99A  06 5A          ASL $5A
C99C  06 5B          ASL $5B
C99E  38             SEC
C99F  E5 5C          SBC $5C
C9A1  B0 F7          BCS $C99A
C9A3  A4 5A          LDY $5A
C9A5  C0 80          CPY #$80
C9A7  3E 00 04       ROL $0400,X
C9AA  A4 5B          LDY $5B
C9AC  C0 80          CPY #$80
C9AE  3E 80 04       ROL $0480,X
C9B1  C6 60          DEC $60
C9B3  D0 E1          BNE $C996
C9B5  E8             INX
C9B6  A4 5F          LDY $5F
C9B8  F0 0E          BEQ $C9C8
C9BA  A9 F0          LDA #$F0
C9BC  9D 00 04       STA $0400,X
C9BF  A9 F1          LDA #$F1
C9C1  9D 80 04       STA $0480,X
C9C4  E8             INX
C9C5  88             DEY
C9C6  D0 F2          BNE $C9BA
C9C8  86 2B          STX $2B
C9CA  A6 26          LDX $26
C9CC  E8             INX
C9CD  8A             TXA
C9CE  4A             LSR A
C9CF  90 03          BCC $C9D4
C9D1  4C 04 C7       JMP $C704
C9D4  4A             LSR A
C9D5  90 03          BCC $C9DA
C9D7  4C DA C6       JMP $C6DA
C9DA  A8             TAY
C9DB  A5 25          LDA $25
C9DD  05 30          ORA $30
C9DF  99 30 00       STA $0030,Y
C9E2  E6 2E          INC $2E
C9E4  E0 1C          CPX #$1C
C9E6  F0 09          BEQ $C9F1
C9E8  A5 2B          LDA $2B
C9EA  29 7F          AND #$7F
C9EC  85 2B          STA $2B
C9EE  4C B2 C6       JMP $C6B2
C9F1  20 73 C0       JSR $C073
C9F4  C6 2D          DEC $2D
C9F6  4C CE C2       JMP $C2CE
C9F9               --------unidentified--------
CB34               ----------------
.proc five_func
CB35  48             PHA
CB36  8A             TXA
CB37  48             PHA
CB38  98             TYA
CB39  48             PHA
CB3A  A5 2E          LDA $2E
CB3C  F0 03          BEQ $CB41
CB3E  4C E2 CB       JMP $CBE2
CB41  24 2D          BIT $2D
CB43  30 03          BMI $CB48
CB45  4C DF CB       JMP $CBDF
CB48  E6 2D          INC $2D
CB4A  A5 1B          LDA $1B
CB4C  49 03          EOR #$03
CB4E  85 1B          STA $1B
CB50  A5 28          LDA $28
CB52  09 03          ORA #$03
CB54  8D 06 20       STA PpuAddr_2006
CB57  A9 C0          LDA #$C0
CB59  8D 06 20       STA PpuAddr_2006
CB5C  A9 A8          LDA #$A8
CB5E  8D 00 20       STA PpuControl_2000
CB61  A2 04          LDX #$04
CB63  A5 31          LDA $31
CB65  8D 07 20       STA PpuData_2007
CB68  A5 32          LDA $32
CB6A  8D 07 20       STA PpuData_2007
CB6D  A5 33          LDA $33
CB6F  8D 07 20       STA PpuData_2007
CB72  A5 34          LDA $34
CB74  8D 07 20       STA PpuData_2007
CB77  A5 35          LDA $35
CB79  8D 07 20       STA PpuData_2007
CB7C  A5 36          LDA $36
CB7E  8D 07 20       STA PpuData_2007
CB81  A5 37          LDA $37
CB83  8D 07 20       STA PpuData_2007
CB86  A9 00          LDA #$00
CB88  8D 07 20       STA PpuData_2007
CB8B  CA             DEX
CB8C  D0 D5          BNE $CB63
CB8E  A2 0F          LDX #$0F
CB90  A4 1C          LDY $1C
CB92  A9 3F          LDA #$3F
CB94  8D 06 20       STA PpuAddr_2006
CB97  A9 00          LDA #$00
CB99  8D 06 20       STA PpuAddr_2006
CB9C  A9 27          LDA #$27
CB9E  8E 07 20       STX PpuData_2007
CBA1  8D 07 20       STA PpuData_2007
CBA4  8D 07 20       STA PpuData_2007
CBA7  8D 07 20       STA PpuData_2007
CBAA  8E 07 20       STX PpuData_2007
CBAD  8C 07 20       STY PpuData_2007
CBB0  A5 22          LDA $22
CBB2  8D 07 20       STA PpuData_2007
CBB5  A5 24          LDA $24
CBB7  8D 07 20       STA PpuData_2007
CBBA  8E 07 20       STX PpuData_2007
CBBD  8C 07 20       STY PpuData_2007
CBC0  A5 23          LDA $23
CBC2  8D 07 20       STA PpuData_2007
CBC5  A5 22          LDA $22
CBC7  8D 07 20       STA PpuData_2007
CBCA  8E 07 20       STX PpuData_2007
CBCD  8C 07 20       STY PpuData_2007
CBD0  A5 24          LDA $24
CBD2  8D 07 20       STA PpuData_2007
CBD5  A5 23          LDA $23
CBD7  8D 07 20       STA PpuData_2007
CBDA  A9 0E          LDA #$0E
CBDC  8D 01 20       STA PpuMask_2001
CBDF  4C A9 CD       JMP $CDA9
CBE2  A9 AC          LDA #$AC
CBE4  8D 00 20       STA PpuControl_2000
CBE7  A9 03          LDA #$03
CBE9  85 2F          STA $2F
CBEB  A6 2C          LDX $2C
CBED  A4 27          LDY $27
CBEF  A5 28          LDA $28
CBF1  8D 06 20       STA PpuAddr_2006
CBF4  8C 06 20       STY PpuAddr_2006
CBF7  C8             INY
CBF8  BD 07 04       LDA $0407,X
CBFB  8D 07 20       STA PpuData_2007
CBFE  BD 06 04       LDA $0406,X
CC01  8D 07 20       STA PpuData_2007
CC04  BD 05 04       LDA $0405,X
CC07  8D 07 20       STA PpuData_2007
CC0A  BD 04 04       LDA $0404,X
CC0D  8D 07 20       STA PpuData_2007
CC10  BD 03 04       LDA $0403,X
CC13  8D 07 20       STA PpuData_2007
CC16  BD 02 04       LDA $0402,X
CC19  8D 07 20       STA PpuData_2007
CC1C  BD 01 04       LDA $0401,X
CC1F  8D 07 20       STA PpuData_2007
CC22  BD 00 04       LDA $0400,X
CC25  8D 07 20       STA PpuData_2007
CC28  BD 80 04       LDA $0480,X
CC2B  8D 07 20       STA PpuData_2007
CC2E  BD 81 04       LDA $0481,X
CC31  8D 07 20       STA PpuData_2007
CC34  BD 82 04       LDA $0482,X
CC37  8D 07 20       STA PpuData_2007
CC3A  BD 83 04       LDA $0483,X
CC3D  8D 07 20       STA PpuData_2007
CC40  BD 84 04       LDA $0484,X
CC43  8D 07 20       STA PpuData_2007
CC46  BD 85 04       LDA $0485,X
CC49  8D 07 20       STA PpuData_2007
CC4C  BD 86 04       LDA $0486,X
CC4F  8D 07 20       STA PpuData_2007
CC52  BD 87 04       LDA $0487,X
CC55  8D 07 20       STA PpuData_2007
CC58  A5 28          LDA $28
CC5A  8D 06 20       STA PpuAddr_2006
CC5D  8C 06 20       STY PpuAddr_2006
CC60  C8             INY
CC61  BD 0F 04       LDA $040F,X
CC64  8D 07 20       STA PpuData_2007
CC67  BD 0E 04       LDA $040E,X
CC6A  8D 07 20       STA PpuData_2007
CC6D  BD 0D 04       LDA $040D,X
CC70  8D 07 20       STA PpuData_2007
CC73  BD 0C 04       LDA $040C,X
CC76  8D 07 20       STA PpuData_2007
CC79  BD 0B 04       LDA $040B,X
CC7C  8D 07 20       STA PpuData_2007
CC7F  BD 0A 04       LDA $040A,X
CC82  8D 07 20       STA PpuData_2007
CC85  BD 09 04       LDA $0409,X
CC88  8D 07 20       STA PpuData_2007
CC8B  BD 08 04       LDA $0408,X
CC8E  8D 07 20       STA PpuData_2007
CC91  BD 88 04       LDA $0488,X
CC94  8D 07 20       STA PpuData_2007
CC97  BD 89 04       LDA $0489,X
CC9A  8D 07 20       STA PpuData_2007
CC9D  BD 8A 04       LDA $048A,X
CCA0  8D 07 20       STA PpuData_2007
CCA3  BD 8B 04       LDA $048B,X
CCA6  8D 07 20       STA PpuData_2007
CCA9  BD 8C 04       LDA $048C,X
CCAC  8D 07 20       STA PpuData_2007
CCAF  BD 8D 04       LDA $048D,X
CCB2  8D 07 20       STA PpuData_2007
CCB5  BD 8E 04       LDA $048E,X
CCB8  8D 07 20       STA PpuData_2007
CCBB  BD 8F 04       LDA $048F,X
CCBE  8D 07 20       STA PpuData_2007
CCC1  A5 28          LDA $28
CCC3  8D 06 20       STA PpuAddr_2006
CCC6  8C 06 20       STY PpuAddr_2006
CCC9  C8             INY
CCCA  BD 17 04       LDA $0417,X
CCCD  8D 07 20       STA PpuData_2007
CCD0  BD 16 04       LDA $0416,X
CCD3  8D 07 20       STA PpuData_2007
CCD6  BD 15 04       LDA $0415,X
CCD9  8D 07 20       STA PpuData_2007
CCDC  BD 14 04       LDA $0414,X
CCDF  8D 07 20       STA PpuData_2007
CCE2  BD 13 04       LDA $0413,X
CCE5  8D 07 20       STA PpuData_2007
CCE8  BD 12 04       LDA $0412,X
CCEB  8D 07 20       STA PpuData_2007
CCEE  BD 11 04       LDA $0411,X
CCF1  8D 07 20       STA PpuData_2007
CCF4  BD 10 04       LDA $0410,X
CCF7  8D 07 20       STA PpuData_2007
CCFA  BD 90 04       LDA $0490,X
CCFD  8D 07 20       STA PpuData_2007
CD00  BD 91 04       LDA $0491,X
CD03  8D 07 20       STA PpuData_2007
CD06  BD 92 04       LDA $0492,X
CD09  8D 07 20       STA PpuData_2007
CD0C  BD 93 04       LDA $0493,X
CD0F  8D 07 20       STA PpuData_2007
CD12  BD 94 04       LDA $0494,X
CD15  8D 07 20       STA PpuData_2007
CD18  BD 95 04       LDA $0495,X
CD1B  8D 07 20       STA PpuData_2007
CD1E  BD 96 04       LDA $0496,X
CD21  8D 07 20       STA PpuData_2007
CD24  BD 97 04       LDA $0497,X
CD27  8D 07 20       STA PpuData_2007
CD2A  A5 28          LDA $28
CD2C  8D 06 20       STA PpuAddr_2006
CD2F  8C 06 20       STY PpuAddr_2006
CD32  C8             INY
CD33  BD 1F 04       LDA $041F,X
CD36  8D 07 20       STA PpuData_2007
CD39  BD 1E 04       LDA $041E,X
CD3C  8D 07 20       STA PpuData_2007
CD3F  BD 1D 04       LDA $041D,X
CD42  8D 07 20       STA PpuData_2007
CD45  BD 1C 04       LDA $041C,X
CD48  8D 07 20       STA PpuData_2007
CD4B  BD 1B 04       LDA $041B,X
CD4E  8D 07 20       STA PpuData_2007
CD51  BD 1A 04       LDA $041A,X
CD54  8D 07 20       STA PpuData_2007
CD57  BD 19 04       LDA $0419,X
CD5A  8D 07 20       STA PpuData_2007
CD5D  BD 18 04       LDA $0418,X
CD60  8D 07 20       STA PpuData_2007
CD63  BD 98 04       LDA $0498,X
CD66  8D 07 20       STA PpuData_2007
CD69  BD 99 04       LDA $0499,X
CD6C  8D 07 20       STA PpuData_2007
CD6F  BD 9A 04       LDA $049A,X
CD72  8D 07 20       STA PpuData_2007
CD75  BD 9B 04       LDA $049B,X
CD78  8D 07 20       STA PpuData_2007
CD7B  BD 9C 04       LDA $049C,X
CD7E  8D 07 20       STA PpuData_2007
CD81  BD 9D 04       LDA $049D,X
CD84  8D 07 20       STA PpuData_2007
CD87  BD 9E 04       LDA $049E,X
CD8A  8D 07 20       STA PpuData_2007
CD8D  BD 9F 04       LDA $049F,X
CD90  8D 07 20       STA PpuData_2007
CD93  18             CLC
CD94  8A             TXA
CD95  69 20          ADC #$20
CD97  29 7F          AND #$7F
CD99  AA             TAX
CD9A  C6 2E          DEC $2E
CD9C  F0 07          BEQ $CDA5
CD9E  C6 2F          DEC $2F
CDA0  F0 03          BEQ $CDA5
CDA2  4C EF CB       JMP $CBEF
CDA5  84 27          STY $27
CDA7  86 2C          STX $2C
CDA9  A5 1B          LDA $1B
CDAB  8D 00 20       STA PpuControl_2000
CDAE  A9 F0          LDA #$F0
CDB0  8D 05 20       STA PpuScroll_2005
CDB3  A9 D0          LDA #$D0
CDB5  8D 05 20       STA PpuScroll_2005
CDB8  68             PLA
CDB9  A8             TAY
CDBA  68             PLA
CDBB  AA             TAX
CDBC  68             PLA
CDBD  40             RTI
.endproc
                   ----------------
                   --------sub start--------
CDBE  B9 79 CA       LDA $CA79,Y
CDC1  24 22          BIT $22
CDC3  30 12          BMI $CDD7
CDC5  C5 22          CMP $22
CDC7  F0 10          BEQ $CDD9
CDC9  24 23          BIT $23
CDCB  30 0F          BMI $CDDC
CDCD  C5 23          CMP $23
CDCF  F0 0D          BEQ $CDDE
CDD1  24 24          BIT $24
CDD3  30 0C          BMI $CDE1
CDD5  10 0C          BPL $CDE3
CDD7  85 22          STA $22
CDD9  A9 00          LDA #$00
CDDB  60             RTS
                   ----------------
CDDC  85 23          STA $23
CDDE  A9 01          LDA #$01
CDE0  60             RTS
                   ----------------
CDE1  85 24          STA $24
CDE3  A9 02          LDA #$02
CDE5  60             RTS
                   ----------------
CDE6               --------data--------
FFFF               ----------------


