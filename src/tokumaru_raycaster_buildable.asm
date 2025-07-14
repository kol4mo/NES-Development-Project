; Tokumaru Raycaster - Reconstructed ASM
; Compatible with ASM6 assembler

.inesprg 1        ; 1 x 16KB PRG
.ineschr 0        ; 0 x 8KB CHR (uses CHR RAM)
.inesmap 0        ; Mapper 0 (NROM)
.inesmir 1        ; Vertical mirroring

.org $8000
RESET:
78       SEI
D8       CLD
A2 00    LDX #$00
8E 00 20 STX $2000
8E 01 20 STX $2001
CA       DEX
9A       TXS
A9 40    LDA #$40
8D 17 40 STA $4017
A9 00    LDA #$00
8D 10 40 STA $4010
2C 02 20 BIT $2002
2C 02 20 BIT $2002
10 FB    BPL $00FB
2C 02 20 BIT $2002
10 FB    BPL $00FB
20 46 C0 JSR $C046
20 47 C0 JSR $C047
4C 5B C2 JMP $C25B
24 10    BIT $10
30 07    BMI $0007
24 12    BIT $12
10 06    BPL $0006
6C       .DB $6C
11       .DB $11
00       BRK
E6       .DB $E6
10 40    BPL $0040
48       PHA
8A       TXA
48       PHA
98       .DB $98
48       PHA
68       PLA
A8       .DB $A8
68       PLA
AA       TAX
68       PLA
40       RTI
40       RTI
60       RTS
A9 00    LDA #$00
85       .DB $85
10 85    BPL $0085
12       .DB $12
A2 00    LDX #$00
86       .DB $86
18       CLC
86       .DB $86
17       .DB $17
BD       .DB $BD
E6       .DB $E6
CD       .DB $CD
29 0F    AND #$0F
85       .DB $85
19       .DB $19
BD       .DB $BD
E6       .DB $E6
CD       .DB $CD
29 F0    AND #$F0
85       .DB $85
1A       .DB $1A
A9 A8    LDA #$A8
8D 00 20 STA $2000
A9 06    LDA #$06
8D 01 20 STA $2001
60       RTS
C6       .DB $C6
10 24    BPL $0024
10 30    BPL $0030
FC       .DB $FC
60       RTS
A5       .DB $A5
17       .DB $17
C5       .DB $C5
18       CLC
F0       .DB $F0
2F       .DB $2F
C6       .DB $C6
18       CLC
A5       .DB $A5
18       CLC
29 07    AND #$07
D0       .DB $D0
26       .DB $26
A5       .DB $A5
18       CLC
B0       .DB $B0
02       .DB $02
69       .DB $69
11       .DB $11
E9       .DB $E9
08       PHP
85       .DB $85
18       CLC
A5       .DB $A5
17       .DB $17
29 07    AND #$07
05 18    ORA $18
85       .DB $85
18       CLC
4A       .DB $4A
4A       .DB $4A
4A       .DB $4A
AA       TAX
BD       .DB $BD
E6       .DB $E6
CD       .DB $CD
29 0F    AND #$0F
85       .DB $85
19       .DB $19
BD       .DB $BD
E6       .DB $E6
CD       .DB $CD
29 F0    AND #$F0
85       .DB $85
1A       .DB $1A
18       CLC
60       RTS
38       SEC
60       RTS
A9 A8    LDA #$A8
8D 00 20 STA $2000
A9 04    LDA #$04
8D 06 20 STA $2006
A9 00    LDA #$00
8D 06 20 STA $2006
A9 40    LDA #$40
85       .DB $85
23       .DB $23
A2 04    LDX #$04
A0 00    LDY #$00
84       .DB $84
27       .DB $27
F0       .DB $F0
02       .DB $02
CA       DEX
C8       INY
0A       ASL A
B0       .DB $B0
FB       .DB $FB
86       .DB $86
25 84    AND $84
26       .DB $26
0A       ASL A
08       PHP
0A       ASL A
85       .DB $85
28       PLP
A9 FF    LDA #$FF
69       .DB $69
00       BRK
49       .DB $49
FF       .DB $FF
85       .DB $85
24 06    BIT $06
28       PLP
26       .DB $26
27       .DB $27
A0 07    LDY #$07
28       PLP
90       .DB $90
43       .DB $43
06 28    ASL $28
A5       .DB $A5
27       .DB $27
2A       .DB $2A
AA       TAX
A5       .DB $A5
24 3D    BIT $3D
31       .DB $31
CE       .DB $CE
8D 07 20 STA $2007
BD       .DB $BD
31       .DB $31
CE       .DB $CE
99       .DB $99
1B       .DB $1B
00       BRK
88       DEY
A5       .DB $A5
24 3D    BIT $3D
35       .DB $35
CE       .DB $CE
8D 07 20 STA $2007
BD       .DB $BD
35       .DB $35
CE       .DB $CE
99       .DB $99
1B       .DB $1B
00       BRK
88       DEY
C6       .DB $C6
25 D0    AND $D0
D8       CLD
C6       .DB $C6
26       .DB $26
30 5E    BMI $005E
A5       .DB $A5
02       .DB $02
8D 07 20 STA $2007
A9 00    LDA #$00
99       .DB $99
1B       .DB $1B
00       BRK
88       DEY
99       .DB $99
1B       .DB $1B
00       BRK
A5       .DB $A5
03       .DB $03
8D 07 20 STA $2007
88       DEY
4C 0B C1 JMP $C10B
A5       .DB $A5
23       .DB $23
85       .DB $85
28       PLP
C6       .DB $C6
26       .DB $26
30 17    BMI $0017
A5       .DB $A5
00       BRK
8D 07 20 STA $2007
A9 00    LDA #$00
99       .DB $99
1B       .DB $1B
00       BRK
88       DEY
99       .DB $99
1B       .DB $1B
00       BRK
A5       .DB $A5
01 8D    ORA ($8D,X)
07       .DB $07
20 88 4C JSR $4C88
2A       .DB $2A
C1       .DB $C1
46       .DB $46
28       PLP
A5       .DB $A5
27       .DB $27
2A       .DB $2A
AA       TAX
A5       .DB $A5
24 3D    BIT $3D
31       .DB $31
CE       .DB $CE
8D 07 20 STA $2007
BD       .DB $BD
31       .DB $31
CE       .DB $CE
99       .DB $99
1B       .DB $1B
00       BRK
88       DEY
A5       .DB $A5
24 3D    BIT $3D
35       .DB $35
CE       .DB $CE
8D 07 20 STA $2007
BD       .DB $BD
35       .DB $35
CE       .DB $CE
99       .DB $99
1B       .DB $1B
00       BRK
88       DEY
C6       .DB $C6
25 D0    AND $D0
D8       CLD
A0 07    LDY #$07
B9       .DB $B9
1B       .DB $1B
00       BRK
8D 07 20 STA $2007
88       DEY
10 F7    BPL $00F7
18       CLC
A5       .DB $A5
23       .DB $23
69       .DB $69
01 C9    ORA ($C9,X)
F0       .DB $F0
F0       .DB $F0
03       .DB $03
4C BA C0 JMP $C0BA
A5       .DB $A5
00       BRK
A6       .DB $A6
01 A0    ORA ($A0,X)
04       .DB $04
8D 07 20 STA $2007
8E 07 20 STX $2007
88       DEY
D0       .DB $D0
F7       .DB $F7
A2 08    LDX #$08
8C       .DB $8C
07       .DB $07
20 CA D0 JSR $D0CA
FA       .DB $FA
A5       .DB $A5
02       .DB $02
A6       .DB $A6
03       .DB $03
A0 04    LDY #$04
8D 07 20 STA $2007
8E 07 20 STX $2007
88       DEY
D0       .DB $D0
F7       .DB $F7
A2 08    LDX #$08
8C       .DB $8C
07       .DB $07
20 CA D0 JSR $D0CA
FA       .DB $FA
A9 03    LDA #$03
85       .DB $85
26       .DB $26
A9 01    LDA #$01
85       .DB $85
25 A4    AND $A4
26       .DB $26
A5       .DB $A5
00       BRK
A6       .DB $A6
01 8D    ORA ($8D,X)
07       .DB $07
20 8E 07 JSR $078E
20 88 D0 JSR $D088
F7       .DB $F7
A4       .DB $A4
25 A9    AND $A9
00       BRK
8D 07 20 STA $2007
8D 07 20 STA $2007
88       DEY
D0       .DB $D0
F7       .DB $F7
A2 08    LDX #$08
8C       .DB $8C
07       .DB $07
20 CA D0 JSR $D0CA
FA       .DB $FA
E6       .DB $E6
25 C6    AND $C6
26       .DB $26
D0       .DB $D0
D6       .DB $D6
A9 03    LDA #$03
85       .DB $85
26       .DB $26
A9 01    LDA #$01
85       .DB $85
25 A4    AND $A4
25 A9    AND $A9
00       BRK
8D 07 20 STA $2007
8D 07 20 STA $2007
88       DEY
D0       .DB $D0
F7       .DB $F7
A4       .DB $A4
26       .DB $26
A5       .DB $A5
02       .DB $02
A6       .DB $A6
03       .DB $03
8D 07 20 STA $2007
8E 07 20 STX $2007
88       DEY
D0       .DB $D0
F7       .DB $F7
A2 08    LDX #$08
8C       .DB $8C
07       .DB $07
20 CA D0 JSR $D0CA
FA       .DB $FA
E6       .DB $E6
25 C6    AND $C6
26       .DB $26
D0       .DB $D0
D6       .DB $D6
60       RTS
A9 00    LDA #$00
85       .DB $85
13       .DB $13
85       .DB $85
14       .DB $14
85       .DB $85
15       .DB $15
85       .DB $85
16       .DB $16
60       RTS
A5       .DB $A5
13       .DB $13
49       .DB $49
FF       .DB $FF
85       .DB $85
15       .DB $15
A5       .DB $A5
14       .DB $14
49       .DB $49
FF       .DB $FF
85       .DB $85
16       .DB $16
A9 01    LDA #$01
8D 16 40 STA $4016
4A       .DB $4A
8D 16 40 STA $4016
A2 07    LDX #$07
AD       .DB $AD
16       .DB $16
40       RTI
29 03    AND #$03
C9       .DB $C9
01 26    ORA ($26,X)
13       .DB $13
AD       .DB $AD
17       .DB $17
40       RTI
29 03    AND #$03
C9       .DB $C9
01 26    ORA ($26,X)
14       .DB $14
CA       DEX
10 EB    BPL $00EB
A5       .DB $A5
13       .DB $13
25 15    AND $15
85       .DB $85
15       .DB $15
A5       .DB $A5
14       .DB $14
25 16    AND $16
85       .DB $85
16       .DB $16
60       RTS
20 17 C2 JSR $C217
A2 00    LDX #$00
8E 06 20 STX $2006
8E 06 20 STX $2006
A0 30    LDY #$30
8A       TXA
8D 07 20 STA $2007
CA       DEX
D0       .DB $D0
FA       .DB $FA
88       DEY
D0       .DB $D0
F7       .DB $F7
A9 FF    LDA #$FF
85       .DB $85
00       BRK
A9 FF    LDA #$FF
85       .DB $85
01 A9    ORA ($A9,X)
33       .DB $33
85       .DB $85
02       .DB $02
A9 CC    LDA #$CC
85       .DB $85
03       .DB $03
20 A9 C0 JSR $C0A9
A9 10    LDA #$10
85       .DB $85
1C       .DB $1C
A9 F9    LDA #$F9
8D 00 03 STA $0300
A9 C9    LDA #$C9
8D 80 03 STA $0380
A0 10    LDY #$10
A2 00    LDX #$00
18       CLC
98       .DB $98
7D       .DB $7D
00       BRK
03       .DB $03
9D       .DB $9D
01 03    ORA ($03,X)
BD       .DB $BD
80       .DB $80
03       .DB $03
69       .DB $69
00       BRK
9D       .DB $9D
81       .DB $81
03       .DB $03
E8       INX
E0       .DB $E0
7F       .DB $7F
D0       .DB $D0
EB       .DB $EB
A9 20    LDA #$20
85       .DB $85
1D       .DB $1D
85       .DB $85
1F       .DB $1F
A9 06    LDA #$06
85       .DB $85
1E       .DB $1E
85       .DB $85
20 A9 00 JSR $00A9
85       .DB $85
21       .DB $21
A9 A8    LDA #$A8
85       .DB $85
1B       .DB $1B
A9 00    LDA #$00
85       .DB $85
2E       .DB $2E
85       .DB $85
2D       .DB $2D
A9 35    LDA #$35
85       .DB $85
11       .DB $11
A9 CB    LDA #$CB
85       .DB $85
12       .DB $12
20 22 C2 JSR $C222
A5       .DB $A5
13       .DB $13
29 02    AND #$02
F0       .DB $F0
0C       .DB $0C
A6       .DB $A6
21       .DB $21
CA       DEX
CA       DEX
E0       .DB $E0
FE       .DB $FE
D0       .DB $D0
02       .DB $02
A2 A6    LDX #$A6
86       .DB $86
21       .DB $21
A5       .DB $A5
13       .DB $13
29 01    AND #$01
F0       .DB $F0
0C       .DB $0C
A6       .DB $A6
21       .DB $21
E8       INX
E8       INX
E0       .DB $E0
A8       .DB $A8
D0       .DB $D0
02       .DB $02
A2 00    LDX #$00
86       .DB $86
21       .DB $21
A5       .DB $A5
13       .DB $13
29 0C    AND #$0C
D0       .DB $D0
03       .DB $03
4C 44 C4 JMP $C444
A6       .DB $A6
21       .DB $21
BD       .DB $BD
50       .DB $50
D6       .DB $D6
85       .DB $85
00       BRK
BD       .DB $BD
F8       .DB $F8
D6       .DB $D6
C9       .DB $C9
80       .DB $80
6A       .DB $6A
66       .DB $66
00       BRK
C9       .DB $C9
80       .DB $80
6A       .DB $6A
66       .DB $66
00       BRK
85       .DB $85
01 A5    ORA ($A5,X)
13       .DB $13
29 08    AND #$08
D0       .DB $D0
11       .DB $11
18       CLC
A5       .DB $A5
00       BRK
49       .DB $49
FF       .DB $FF
69       .DB $69
01 85    ORA ($85,X)
00       BRK
A5       .DB $A5
01 49    ORA ($49,X)
FF       .DB $FF
69       .DB $69
00       BRK
85       .DB $85
01 18    ORA ($18,X)
A5       .DB $A5
1F       .DB $1F
65       .DB $65
00       BRK
85       .DB $85
1F       .DB $1F
A5       .DB $A5
20 65 01 JSR $0165
85       .DB $85
20 A9 80 JSR $80A9
A0 00    LDY #$00
24 01    BIT $01
10 04    BPL $0004
A9 80    LDA #$80
A0 FF    LDY #$FF
18       CLC
65       .DB $65
1F       .DB $1F
98       .DB $98
65       .DB $65
20 4A 85 JSR $854A
03       .DB $03
A8       .DB $A8
B9       .DB $B9
00       BRK
03       .DB $03
85       .DB $85
57       .DB $57
B9       .DB $B9
80       .DB $80
03       .DB $03
85       .DB $85
58       .DB $58
38       SEC
A5       .DB $A5
1D       .DB $1D
E9       .DB $E9
80       .DB $80
A5       .DB $A5
1E       .DB $1E
E9       .DB $E9
00       BRK
4A       .DB $4A
A8       .DB $A8
B1       .DB $B1
57       .DB $57
30 0F    BMI $000F
18       CLC
A5       .DB $A5
1D       .DB $1D
69       .DB $69
80       .DB $80
A5       .DB $A5
1E       .DB $1E
69       .DB $69
00       BRK
4A       .DB $4A
A8       .DB $A8
B1       .DB $B1
57       .DB $57
10 20    BPL $0020
24 01    BIT $01
10 0F    BPL $000F
A9 81    LDA #$81
85       .DB $85
1F       .DB $1F
18       CLC
A5       .DB $A5
03       .DB $03
69       .DB $69
01 0A    ORA ($0A,X)
85       .DB $85
20 4C 96 JSR $964C
C3       .DB $C3
A9 7F    LDA #$7F
85       .DB $85
1F       .DB $1F
38       SEC
A5       .DB $A5
03       .DB $03
E9       .DB $E9
01 38    ORA ($38,X)
2A       .DB $2A
85       .DB $85
20 18 8A JSR $8A18
69       .DB $69
2A       .DB $2A
C9       .DB $C9
A8       .DB $A8
90       .DB $90
02       .DB $02
E9       .DB $E9
A8       .DB $A8
AA       TAX
BD       .DB $BD
50       .DB $50
D6       .DB $D6
85       .DB $85
00       BRK
BD       .DB $BD
F8       .DB $F8
D6       .DB $D6
C9       .DB $C9
80       .DB $80
6A       .DB $6A
66       .DB $66
00       BRK
C9       .DB $C9
80       .DB $80
6A       .DB $6A
66       .DB $66
00       BRK
85       .DB $85
01 A5    ORA ($A5,X)
13       .DB $13
29 08    AND #$08
D0       .DB $D0
11       .DB $11
18       CLC
A5       .DB $A5
00       BRK
49       .DB $49
FF       .DB $FF
69       .DB $69
01 85    ORA ($85,X)
00       BRK
A5       .DB $A5
01 49    ORA ($49,X)
FF       .DB $FF
69       .DB $69
00       BRK
85       .DB $85
01 18    ORA ($18,X)
A5       .DB $A5
1D       .DB $1D
65       .DB $65
00       BRK
85       .DB $85
1D       .DB $1D
A5       .DB $A5
1E       .DB $1E
65       .DB $65
01 85    ORA ($85,X)
1E       .DB $1E
A9 80    LDA #$80
A0 00    LDY #$00
24 01    BIT $01
10 04    BPL $0004
A9 80    LDA #$80
A0 FF    LDY #$FF
18       CLC
65       .DB $65
1D       .DB $1D
98       .DB $98
65       .DB $65
1E       .DB $1E
4A       .DB $4A
85       .DB $85
03       .DB $03
38       SEC
A5       .DB $A5
1F       .DB $1F
E9       .DB $E9
80       .DB $80
A5       .DB $A5
20 E9 00 JSR $00E9
4A       .DB $4A
A8       .DB $A8
B9       .DB $B9
00       BRK
03       .DB $03
85       .DB $85
57       .DB $57
B9       .DB $B9
80       .DB $80
03       .DB $03
85       .DB $85
58       .DB $58
A4       .DB $A4
03       .DB $03
B1       .DB $B1
57       .DB $57
30 1B    BMI $001B
18       CLC
A5       .DB $A5
1F       .DB $1F
69       .DB $69
80       .DB $80
A5       .DB $A5
20 69 00 JSR $0069
4A       .DB $4A
A8       .DB $A8
B9       .DB $B9
00       BRK
03       .DB $03
85       .DB $85
57       .DB $57
B9       .DB $B9
80       .DB $80
03       .DB $03
85       .DB $85
58       .DB $58
A4       .DB $A4
03       .DB $03
B1       .DB $B1
57       .DB $57
10 20    BPL $0020
24 01    BIT $01
10 0F    BPL $000F
A9 81    LDA #$81
85       .DB $85
1D       .DB $1D
18       CLC
A5       .DB $A5
03       .DB $03
69       .DB $69
01 0A    ORA ($0A,X)
85       .DB $85
1E       .DB $1E
4C 44 C4 JMP $C444
A9 7F    LDA #$7F
85       .DB $85
1D       .DB $1D
38       SEC
A5       .DB $A5
03       .DB $03
E9       .DB $E9
01 38    ORA ($38,X)
2A       .DB $2A
85       .DB $85
1E       .DB $1E
38       SEC
A5       .DB $A5
21       .DB $21
E9       .DB $E9
0E B0 02 ASL $02B0
69       .DB $69
A8       .DB $A8
85       .DB $85
2A       .DB $2A
69       .DB $69
29 C9    AND #$C9
A8       .DB $A8
90       .DB $90
02       .DB $02
E9       .DB $E9
A8       .DB $A8
85       .DB $85
29 A5    AND #$A5
2D       .DB $2D
30 FC    BMI $00FC
A9 8F    LDA #$8F
85       .DB $85
22       .DB $22
85       .DB $85
23       .DB $23
85       .DB $85
24 A9    BIT $A9
00       BRK
85       .DB $85
27       .DB $27
A5       .DB $A5
1B       .DB $1B
29 03    AND #$03
0A       ASL A
0A       ASL A
09 20    ORA #$20
85       .DB $85
28       PLP
A9 00    LDA #$00
85       .DB $85
2B       .DB $2B
85       .DB $85
2C A2 00 BIT $00A2
BD       .DB $BD
CD       .DB $CD
D3       .DB $D3
85       .DB $85
38       SEC
BD       .DB $BD
E9       .DB $E9
D3       .DB $D3
85       .DB $85
39       .DB $39
A4       .DB $A4
29 B9    AND #$B9
39       .DB $39
CE       .DB $CE
85       .DB $85
3A       .DB $3A
0A       ASL A
A8       .DB $A8
B1       .DB $B1
38       SEC
85       .DB $85
3C       .DB $3C
B9       .DB $B9
79       .DB $79
D3       .DB $D3
85       .DB $85
40       RTI
C8       INY
B1       .DB $B1
38       SEC
85       .DB $85
3D       .DB $3D
B9       .DB $B9
79       .DB $79
D3       .DB $D3
85       .DB $85
41       .DB $41
A4       .DB $A4
2A       .DB $2A
B9       .DB $B9
39       .DB $39
CE       .DB $CE
85       .DB $85
3B       .DB $3B
0A       ASL A
A8       .DB $A8
B1       .DB $B1
38       SEC
85       .DB $85
3E       .DB $3E
B9       .DB $B9
79       .DB $79
D3       .DB $D3
85       .DB $85
42       .DB $42
C8       INY
B1       .DB $B1
38       SEC
85       .DB $85
3F       .DB $3F
B9       .DB $B9
79       .DB $79
D3       .DB $D3
85       .DB $85
43       .DB $43
A5       .DB $A5
1E       .DB $1E
4A       .DB $4A
A5       .DB $A5
1D       .DB $1D
6A       .DB $6A
4A       .DB $4A
24 3A    BIT $3A
10 08    BPL $0008
49       .DB $49
80       .DB $80
A0 FF    LDY #$FF
84       .DB $84
44       .DB $44
D0       .DB $D0
07       .DB $07
49       .DB $49
FF       .DB $FF
A0 01    LDY #$01
84       .DB $84
44       .DB $44
88       DEY
84       .DB $84
46       .DB $46
85       .DB $85
4B       .DB $4B
85       .DB $85
48       PHA
A9 00    LDA #$00
85       .DB $85
4D       .DB $4D
46       .DB $46
48       PHA
90       .DB $90
0B       .DB $0B
A8       .DB $A8
18       CLC
A5       .DB $A5
4D       .DB $4D
65       .DB $65
3C       .DB $3C
85       .DB $85
4D       .DB $4D
98       .DB $98
65       .DB $65
3D       .DB $3D
6A       .DB $6A
66       .DB $66
4D       .DB $4D
46       .DB $46
48       PHA
F0       .DB $F0
04       .DB $04
B0       .DB $B0
EC       .DB $EC
90       .DB $90
F5       .DB $F5
85       .DB $85
4E       .DB $4E
A5       .DB $A5
20 4A A5 JSR $A54A
1F       .DB $1F
6A       .DB $6A
4A       .DB $4A
24 3B    BIT $3B
10 0A    BPL $000A
49       .DB $49
80       .DB $80
A0 FE    LDY #$FE
84       .DB $84
45       .DB $45
A0 00    LDY #$00
F0       .DB $F0
07       .DB $07
49       .DB $49
FF       .DB $FF
A0 00    LDY #$00
84       .DB $84
45       .DB $45
88       DEY
84       .DB $84
47       .DB $47
85       .DB $85
4C 85 48 JMP $4885
A9 00    LDA #$00
85       .DB $85
4F       .DB $4F
46       .DB $46
48       PHA
90       .DB $90
0B       .DB $0B
A8       .DB $A8
18       CLC
A5       .DB $A5
4F       .DB $4F
65       .DB $65
3E       .DB $3E
85       .DB $85
4F       .DB $4F
98       .DB $98
65       .DB $65
3F       .DB $3F
6A       .DB $6A
66       .DB $66
4F       .DB $4F
46       .DB $46
48       PHA
F0       .DB $F0
04       .DB $04
B0       .DB $B0
EC       .DB $EC
90       .DB $90
F5       .DB $F5
85       .DB $85
50       .DB $50
A5       .DB $A5
1E       .DB $1E
4A       .DB $4A
85       .DB $85
55       .DB $55
A5       .DB $A5
20 4A 85 JSR $854A
56       .DB $56
A8       .DB $A8
B9       .DB $B9
00       BRK
03       .DB $03
85       .DB $85
57       .DB $57
B9       .DB $B9
80       .DB $80
03       .DB $03
85       .DB $85
58       .DB $58
A9 00    LDA #$00
85       .DB $85
49       .DB $49
85       .DB $85
4A       .DB $4A
A5       .DB $A5
4D       .DB $4D
C5       .DB $C5
4F       .DB $4F
A5       .DB $A5
4E       .DB $4E
E5       .DB $E5
50       .DB $50
B0       .DB $B0
1D       .DB $1D
A5       .DB $A5
55       .DB $55
65       .DB $65
44       .DB $44
85       .DB $85
55       .DB $55
A8       .DB $A8
B1       .DB $B1
57       .DB $57
30 3E    BMI $003E
E6       .DB $E6
49       .DB $49
18       CLC
A5       .DB $A5
4D       .DB $4D
65       .DB $65
3C       .DB $3C
85       .DB $85
4D       .DB $4D
A5       .DB $A5
4E       .DB $4E
65       .DB $65
3D       .DB $3D
85       .DB $85
4E       .DB $4E
4C 5A C5 JMP $C55A
A5       .DB $A5
56       .DB $56
65       .DB $65
45       .DB $45
85       .DB $85
56       .DB $56
A8       .DB $A8
B9       .DB $B9
00       BRK
03       .DB $03
85       .DB $85
57       .DB $57
B9       .DB $B9
80       .DB $80
03       .DB $03
85       .DB $85
58       .DB $58
A4       .DB $A4
55       .DB $55
B1       .DB $B1
57       .DB $57
30 12    BMI $0012
E6       .DB $E6
4A       .DB $4A
18       CLC
A5       .DB $A5
4F       .DB $4F
65       .DB $65
3E       .DB $3E
85       .DB $85
4F       .DB $4F
A5       .DB $A5
50       .DB $50
65       .DB $65
3F       .DB $3F
85       .DB $85
50       .DB $50
4C 5A C5 JMP $C55A
4C 2D C6 JMP $C62D
C9       .DB $C9
FF       .DB $FF
D0       .DB $D0
02       .DB $02
A9 00    LDA #$00
9D       .DB $9D
38       SEC
01 A5    ORA ($A5,X)
4D       .DB $4D
9D       .DB $9D
00       BRK
01 A5    ORA ($A5,X)
4E       .DB $4E
9D       .DB $9D
1C       .DB $1C
01 A9    ORA ($A9,X)
00       BRK
85       .DB $85
51       .DB $51
46       .DB $46
4B       .DB $4B
90       .DB $90
0B       .DB $0B
A8       .DB $A8
18       CLC
A5       .DB $A5
51       .DB $51
65       .DB $65
40       RTI
85       .DB $85
51       .DB $51
98       .DB $98
65       .DB $65
41       .DB $41
6A       .DB $6A
66       .DB $66
51       .DB $51
46       .DB $46
4B       .DB $4B
F0       .DB $F0
04       .DB $04
B0       .DB $B0
EC       .DB $EC
90       .DB $90
F5       .DB $F5
85       .DB $85
52       .DB $52
A4       .DB $A4
49       .DB $49
F0       .DB $F0
10 18    BPL $0018
A5       .DB $A5
51       .DB $51
65       .DB $65
40       RTI
85       .DB $85
51       .DB $51
A5       .DB $A5
52       .DB $52
65       .DB $65
41       .DB $41
85       .DB $85
52       .DB $52
88       DEY
D0       .DB $D0
F0       .DB $F0
24 3B    BIT $3B
30 0E    BMI $000E
18       CLC
A5       .DB $A5
1F       .DB $1F
65       .DB $65
51       .DB $51
85       .DB $85
51       .DB $51
A5       .DB $A5
20 65 52 JSR $5265
4C 11 C6 JMP $C611
38       SEC
A5       .DB $A5
1F       .DB $1F
E5       .DB $E5
51       .DB $51
85       .DB $85
51       .DB $51
A5       .DB $A5
20 E5 52 JSR $52E5
4A       .DB $4A
66       .DB $66
51       .DB $51
C5       .DB $C5
56       .DB $56
F0       .DB $F0
07       .DB $07
A5       .DB $A5
51       .DB $51
49       .DB $49
FF       .DB $FF
4C 21 C6 JMP $C621
A5       .DB $A5
51       .DB $51
45       .DB $45
46       .DB $46
4A       .DB $4A
4A       .DB $4A
4A       .DB $4A
4A       .DB $4A
4A       .DB $4A
9D       .DB $9D
54       .DB $54
01 10    ORA ($10,X)
7F       .DB $7F
C9       .DB $C9
FF       .DB $FF
D0       .DB $D0
02       .DB $02
A9 00    LDA #$00
9D       .DB $9D
38       SEC
01 A5    ORA ($A5,X)
4F       .DB $4F
9D       .DB $9D
00       BRK
01 A5    ORA ($A5,X)
50       .DB $50
9D       .DB $9D
1C       .DB $1C
01 A9    ORA ($A9,X)
00       BRK
85       .DB $85
53       .DB $53
46       .DB $46
4C 90 0B JMP $0B90
A8       .DB $A8
18       CLC
A5       .DB $A5
53       .DB $53
65       .DB $65
42       .DB $42
85       .DB $85
53       .DB $53
98       .DB $98
65       .DB $65
43       .DB $43
6A       .DB $6A
66       .DB $66
53       .DB $53
46       .DB $46
4C F0 04 JMP $04F0
B0       .DB $B0
EC       .DB $EC
90       .DB $90
F5       .DB $F5
85       .DB $85
54       .DB $54
A4       .DB $A4
4A       .DB $4A
F0       .DB $F0
10 18    BPL $0018
A5       .DB $A5
53       .DB $53
65       .DB $65
42       .DB $42
85       .DB $85
53       .DB $53
A5       .DB $A5
54       .DB $54
65       .DB $65
43       .DB $43
85       .DB $85
54       .DB $54
88       DEY
D0       .DB $D0
F0       .DB $F0
24 3A    BIT $3A
30 0E    BMI $000E
18       CLC
A5       .DB $A5
1D       .DB $1D
65       .DB $65
53       .DB $53
85       .DB $85
53       .DB $53
A5       .DB $A5
1E       .DB $1E
65       .DB $65
54       .DB $54
4C 91 C6 JMP $C691
38       SEC
A5       .DB $A5
1D       .DB $1D
E5       .DB $E5
53       .DB $53
85       .DB $85
53       .DB $53
A5       .DB $A5
1E       .DB $1E
E5       .DB $E5
54       .DB $54
4A       .DB $4A
66       .DB $66
53       .DB $53
C5       .DB $C5
55       .DB $55
F0       .DB $F0
07       .DB $07
A5       .DB $A5
53       .DB $53
49       .DB $49
FF       .DB $FF
4C A1 C6 JMP $C6A1
A5       .DB $A5
53       .DB $53
45       .DB $45
47       .DB $47
4A       .DB $4A
4A       .DB $4A
4A       .DB $4A
4A       .DB $4A
38       SEC
6A       .DB $6A
9D       .DB $9D
54       .DB $54
01 E8    ORA ($E8,X)
8A       TXA
29 03    AND #$03
F0       .DB $F0
19       .DB $19
A4       .DB $A4
29 C8    AND #$C8
C0       .DB $C0
A8       .DB $A8
D0       .DB $D0
02       .DB $02
A0 00    LDY #$00
84       .DB $84
29 A4    AND #$A4
2A       .DB $2A
C8       INY
C0       .DB $C0
A8       .DB $A8
D0       .DB $D0
02       .DB $02
A0 00    LDY #$00
84       .DB $84
2A       .DB $2A
4C 7B C4 JMP $C47B
38       SEC
8A       TXA
E9       .DB $E9
04       .DB $04
AA       TAX
A9 04    LDA #$04
C5       .DB $C5
2E       .DB $2E
F0       .DB $F0
FC       .DB $FC
A9 FF    LDA #$FF
85       .DB $85
30 BC    BMI $00BC
38       SEC
01 D0    ORA ($D0,X)
03       .DB $03
98       .DB $98
F0       .DB $F0
03       .DB $03
20 BE CD JSR $CDBE
0A       ASL A
0A       ASL A
85       .DB $85
25 BC    AND $BC
39       .DB $39
01 D0    ORA ($D0,X)
03       .DB $03
98       .DB $98
F0       .DB $F0
03       .DB $03
20 BE CD JSR $CDBE
05 25    ORA $25
A8       .DB $A8
B9       .DB $B9
05 D6    ORA $D6
85       .DB $85
25 24    AND $24
30 10    BMI $0010
04       .DB $04
29 33    AND #$33
85       .DB $85
30 A9    BMI $00A9
FC       .DB $FC
06 25    ASL $25
2A       .DB $2A
1E       .DB $1E
54       .DB $54
01 2A    ORA ($2A,X)
85       .DB $85
59       .DB $59
A0 00    LDY #$00
84       .DB $84
5C       .DB $5C
88       DEY
84       .DB $84
5D       .DB $5D
18       CLC
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
A5       .DB $A5
5C       .DB $5C
65       .DB $65
5D       .DB $5D
6A       .DB $6A
A8       .DB $A8
BD       .DB $BD
00       BRK
01 D9    ORA ($D9,X)
05 D4    ORA $D4
BD       .DB $BD
1C       .DB $1C
01 F9    ORA ($F9,X)
05 D5    ORA $D5
90       .DB $90
05 84    ORA $84
5D       .DB $5D
18       CLC
90       .DB $90
03       .DB $03
C8       INY
84       .DB $84
5C       .DB $5C
BC       .DB $BC
38       SEC
01 B9    ORA ($B9,X)
7D       .DB $7D
CA       DEX
85       .DB $85
38       SEC
B9       .DB $B9
81       .DB $81
CA       DEX
85       .DB $85
39       .DB $39
BC       .DB $BC
54       .DB $54
01 B1    ORA ($B1,X)
38       SEC
85       .DB $85
5B       .DB $5B
C8       INY
B1       .DB $B1
38       SEC
85       .DB $85
5A       .DB $5A
A5       .DB $A5
5C       .DB $5C
C9       .DB $C9
FF       .DB $FF
D0       .DB $D0
7A       .DB $7A
BC       .DB $BC
00       BRK
01 CC    ORA ($CC,X)
04       .DB $04
D5       .DB $D5
B0       .DB $B0
72       .DB $72
86       .DB $86
26       .DB $26
A6       .DB $A6
2B       .DB $2B
A5       .DB $A5
59       .DB $59
09 04    ORA #$04
9D       .DB $9D
00       BRK
04       .DB $04
9D       .DB $9D
80       .DB $80
04       .DB $04
A4       .DB $A4
5A       .DB $5A
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
A4       .DB $A4
5B       .DB $5B
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
BD       .DB $BD
00       BRK
04       .DB $04
9D       .DB $9D
01 04    ORA ($04,X)
9D       .DB $9D
02       .DB $02
04       .DB $04
9D       .DB $9D
03       .DB $03
04       .DB $04
9D       .DB $9D
04       .DB $04
04       .DB $04
9D       .DB $9D
05 04    ORA $04
9D       .DB $9D
06 04    ASL $04
9D       .DB $9D
07       .DB $07
04       .DB $04
BD       .DB $BD
80       .DB $80
04       .DB $04
9D       .DB $9D
81       .DB $81
04       .DB $04
9D       .DB $9D
82       .DB $82
04       .DB $04
9D       .DB $9D
83       .DB $83
04       .DB $04
9D       .DB $9D
84       .DB $84
04       .DB $04
9D       .DB $9D
85       .DB $85
04       .DB $04
9D       .DB $9D
86       .DB $86
04       .DB $04
9D       .DB $9D
87       .DB $87
04       .DB $04
18       CLC
8A       TXA
69       .DB $69
08       PHP
AA       TAX
4C C8 C9 JMP $C9C8
86       .DB $86
26       .DB $26
A6       .DB $A6
2B       .DB $2B
C9       .DB $C9
21       .DB $21
90       .DB $90
02       .DB $02
A9 20    LDA #$20
85       .DB $85
5D       .DB $5D
4A       .DB $4A
4A       .DB $4A
85       .DB $85
5E       .DB $5E
49       .DB $49
FF       .DB $FF
38       SEC
69       .DB $69
08       PHP
85       .DB $85
5F       .DB $5F
A5       .DB $A5
5D       .DB $5D
29 03    AND #$03
85       .DB $85
60       RTS
A4       .DB $A4
26       .DB $26
B9       .DB $B9
38       SEC
01 D0    ORA ($D0,X)
16       .DB $16
A4       .DB $A4
5E       .DB $5E
D0       .DB $D0
03       .DB $03
4C 63 C9 JMP $C963
A9 00    LDA #$00
9D       .DB $9D
00       BRK
04       .DB $04
9D       .DB $9D
80       .DB $80
04       .DB $04
E8       INX
88       DEY
D0       .DB $D0
F6       .DB $F6
4C 63 C9 JMP $C963
A5       .DB $A5
5C       .DB $5C
49       .DB $49
FF       .DB $FF
85       .DB $85
61       .DB $61
A4       .DB $A4
5E       .DB $5E
D0       .DB $D0
03       .DB $03
4C 63 C9 JMP $C963
A5       .DB $A5
59       .DB $59
9D       .DB $9D
00       BRK
04       .DB $04
09 04    ORA #$04
9D       .DB $9D
80       .DB $80
04       .DB $04
38       SEC
A5       .DB $A5
61       .DB $61
69       .DB $69
07       .DB $07
90       .DB $90
09 06    ORA #$06
5A       .DB $5A
06 5B    ASL $5B
38       SEC
E5       .DB $E5
5C       .DB $5C
B0       .DB $B0
F7       .DB $F7
A4       .DB $A4
5A       .DB $5A
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
A4       .DB $A4
5B       .DB $5B
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
69       .DB $69
07       .DB $07
90       .DB $90
09 06    ORA #$06
5A       .DB $5A
06 5B    ASL $5B
38       SEC
E5       .DB $E5
5C       .DB $5C
B0       .DB $B0
F7       .DB $F7
A4       .DB $A4
5A       .DB $5A
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
A4       .DB $A4
5B       .DB $5B
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
69       .DB $69
07       .DB $07
90       .DB $90
09 06    ORA #$06
5A       .DB $5A
06 5B    ASL $5B
38       SEC
E5       .DB $E5
5C       .DB $5C
B0       .DB $B0
F7       .DB $F7
A4       .DB $A4
5A       .DB $5A
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
A4       .DB $A4
5B       .DB $5B
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
69       .DB $69
07       .DB $07
90       .DB $90
09 06    ORA #$06
5A       .DB $5A
06 5B    ASL $5B
38       SEC
E5       .DB $E5
5C       .DB $5C
B0       .DB $B0
F7       .DB $F7
A4       .DB $A4
5A       .DB $5A
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
A4       .DB $A4
5B       .DB $5B
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
85       .DB $85
61       .DB $61
BC       .DB $BC
00       BRK
04       .DB $04
B9       .DB $B9
10 D6    BPL $00D6
9D       .DB $9D
00       BRK
04       .DB $04
E8       INX
C6       .DB $C6
5E       .DB $5E
F0       .DB $F0
03       .DB $03
4C D7 C8 JMP $C8D7
A4       .DB $A4
26       .DB $26
B9       .DB $B9
38       SEC
01 D0    ORA ($D0,X)
19       .DB $19
A4       .DB $A4
60       RTS
D0       .DB $D0
03       .DB $03
4C B6 C9 JMP $C9B6
C6       .DB $C6
5F       .DB $5F
18       CLC
98       .DB $98
69       .DB $69
F1       .DB $F1
9D       .DB $9D
00       BRK
04       .DB $04
69       .DB $69
03       .DB $03
9D       .DB $9D
80       .DB $80
04       .DB $04
E8       INX
4C B6 C9 JMP $C9B6
A4       .DB $A4
60       RTS
F0       .DB $F0
2F       .DB $2F
C6       .DB $C6
5F       .DB $5F
A5       .DB $A5
59       .DB $59
9D       .DB $9D
00       BRK
04       .DB $04
09 04    ORA #$04
9D       .DB $9D
80       .DB $80
04       .DB $04
38       SEC
A5       .DB $A5
61       .DB $61
69       .DB $69
07       .DB $07
90       .DB $90
09 06    ORA #$06
5A       .DB $5A
06 5B    ASL $5B
38       SEC
E5       .DB $E5
5C       .DB $5C
B0       .DB $B0
F7       .DB $F7
A4       .DB $A4
5A       .DB $5A
C0       .DB $C0
80       .DB $80
3E       .DB $3E
00       BRK
04       .DB $04
A4       .DB $A4
5B       .DB $5B
C0       .DB $C0
80       .DB $80
3E       .DB $3E
80       .DB $80
04       .DB $04
C6       .DB $C6
60       RTS
D0       .DB $D0
E1       .DB $E1
E8       INX
A4       .DB $A4
5F       .DB $5F
F0       .DB $F0
0E A9 F0 ASL $F0A9
9D       .DB $9D
00       BRK
04       .DB $04
A9 F1    LDA #$F1
9D       .DB $9D
80       .DB $80
04       .DB $04
E8       INX
88       DEY
D0       .DB $D0
F2       .DB $F2
86       .DB $86
2B       .DB $2B
A6       .DB $A6
26       .DB $26
E8       INX
8A       TXA
4A       .DB $4A
90       .DB $90
03       .DB $03
4C 04 C7 JMP $C704
4A       .DB $4A
90       .DB $90
03       .DB $03
4C DA C6 JMP $C6DA
A8       .DB $A8
A5       .DB $A5
25 05    AND $05
30 99    BMI $0099
30 00    BMI $0000
E6       .DB $E6
2E       .DB $2E
E0       .DB $E0
1C       .DB $1C
F0       .DB $F0
09 A5    ORA #$A5
2B       .DB $2B
29 7F    AND #$7F
85       .DB $85
2B       .DB $2B
4C B2 C6 JMP $C6B2
20 73 C0 JSR $C073
C6       .DB $C6
2D       .DB $2D
4C CE C2 JMP $C2CE
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
81       .DB $81
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
82       .DB $82
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
81       .DB $81
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
81       .DB $81
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
81       .DB $81
81       .DB $81
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
82       .DB $82
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
00       BRK
82       .DB $82
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
82       .DB $82
00       BRK
80       .DB $80
83       .DB $83
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
00       BRK
80       .DB $80
00       BRK
80       .DB $80
00       BRK
00       BRK
80       .DB $80
83       .DB $83
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
FF       .DB $FF
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
80       .DB $80
12       .DB $12
16       .DB $16
27       .DB $27
29 05    AND #$05
15       .DB $15
25 05    AND $05
CB       .DB $CB
CB       .DB $CB
CB       .DB $CB
CB       .DB $CB
FF       .DB $FF
FF       .DB $FF
11       .DB $11
09 F1    ORA #$F1
F9       .DB $F9
91       .DB $91
09 9F    ORA #$9F
09 FD    ORA #$FD
FF       .DB $FF
15       .DB $15
09 15    ORA #$15
09 3F    ORA #$3F
3F       .DB $3F
21       .DB $21
21       .DB $21
21       .DB $21
21       .DB $21
E1       .DB $E1
E1       .DB $E1
E1       .DB $E1
E1       .DB $E1
21       .DB $21
21       .DB $21
21       .DB $21
21       .DB $21
3F       .DB $3F
3F       .DB $3F
FF       .DB $FF
FF       .DB $FF
05 65    ORA $65
FD       .DB $FD
85       .DB $85
65       .DB $65
1D       .DB $1D
1D       .DB $1D
65       .DB $65
85       .DB $85
FD       .DB $FD
65       .DB $65
05 FF    ORA $FF
FF       .DB $FF
48       PHA
8A       TXA
48       PHA
98       .DB $98
48       PHA
A5       .DB $A5
2E       .DB $2E
F0       .DB $F0
03       .DB $03
4C E2 CB JMP $CBE2
24 2D    BIT $2D
30 03    BMI $0003
4C DF CB JMP $CBDF
E6       .DB $E6
2D       .DB $2D
A5       .DB $A5
1B       .DB $1B
49       .DB $49
03       .DB $03
85       .DB $85
1B       .DB $1B
A5       .DB $A5
28       PLP
09 03    ORA #$03
8D 06 20 STA $2006
A9 C0    LDA #$C0
8D 06 20 STA $2006
A9 A8    LDA #$A8
8D 00 20 STA $2000
A2 04    LDX #$04
A5       .DB $A5
31       .DB $31
8D 07 20 STA $2007
A5       .DB $A5
32       .DB $32
8D 07 20 STA $2007
A5       .DB $A5
33       .DB $33
8D 07 20 STA $2007
A5       .DB $A5
34       .DB $34
8D 07 20 STA $2007
A5       .DB $A5
35       .DB $35
8D 07 20 STA $2007
A5       .DB $A5
36       .DB $36
8D 07 20 STA $2007
A5       .DB $A5
37       .DB $37
8D 07 20 STA $2007
A9 00    LDA #$00
8D 07 20 STA $2007
CA       DEX
D0       .DB $D0
D5       .DB $D5
A2 0F    LDX #$0F
A4       .DB $A4
1C       .DB $1C
A9 3F    LDA #$3F
8D 06 20 STA $2006
A9 00    LDA #$00
8D 06 20 STA $2006
A9 27    LDA #$27
8E 07 20 STX $2007
8D 07 20 STA $2007
8D 07 20 STA $2007
8D 07 20 STA $2007
8E 07 20 STX $2007
8C       .DB $8C
07       .DB $07
20 A5 22 JSR $22A5
8D 07 20 STA $2007
A5       .DB $A5
24 8D    BIT $8D
07       .DB $07
20 8E 07 JSR $078E
20 8C 07 JSR $078C
20 A5 23 JSR $23A5
8D 07 20 STA $2007
A5       .DB $A5
22       .DB $22
8D 07 20 STA $2007
8E 07 20 STX $2007
8C       .DB $8C
07       .DB $07
20 A5 24 JSR $24A5
8D 07 20 STA $2007
A5       .DB $A5
23       .DB $23
8D 07 20 STA $2007
A9 0E    LDA #$0E
8D 01 20 STA $2001
4C A9 CD JMP $CDA9
A9 AC    LDA #$AC
8D 00 20 STA $2000
A9 03    LDA #$03
85       .DB $85
2F       .DB $2F
A6       .DB $A6
2C A4 27 BIT $27A4
A5       .DB $A5
28       PLP
8D 06 20 STA $2006
8C       .DB $8C
06 20    ASL $20
C8       INY
BD       .DB $BD
07       .DB $07
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
06 04    ASL $04
8D 07 20 STA $2007
BD       .DB $BD
05 04    ORA $04
8D 07 20 STA $2007
BD       .DB $BD
04       .DB $04
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
03       .DB $03
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
02       .DB $02
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
01 04    ORA ($04,X)
8D 07 20 STA $2007
BD       .DB $BD
00       BRK
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
80       .DB $80
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
81       .DB $81
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
82       .DB $82
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
83       .DB $83
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
84       .DB $84
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
85       .DB $85
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
86       .DB $86
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
87       .DB $87
04       .DB $04
8D 07 20 STA $2007
A5       .DB $A5
28       PLP
8D 06 20 STA $2006
8C       .DB $8C
06 20    ASL $20
C8       INY
BD       .DB $BD
0F       .DB $0F
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
0E 04 8D ASL $8D04
07       .DB $07
20 BD 0D JSR $0DBD
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
0C       .DB $0C
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
0B       .DB $0B
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
0A       ASL A
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
09 04    ORA #$04
8D 07 20 STA $2007
BD       .DB $BD
08       PHP
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
88       DEY
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
89       .DB $89
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
8A       TXA
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
8B       .DB $8B
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
8C       .DB $8C
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
8D 04 8D STA $8D04
07       .DB $07
20 BD 8E JSR $8EBD
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
8F       .DB $8F
04       .DB $04
8D 07 20 STA $2007
A5       .DB $A5
28       PLP
8D 06 20 STA $2006
8C       .DB $8C
06 20    ASL $20
C8       INY
BD       .DB $BD
17       .DB $17
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
16       .DB $16
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
15       .DB $15
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
14       .DB $14
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
13       .DB $13
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
12       .DB $12
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
11       .DB $11
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
10 04    BPL $0004
8D 07 20 STA $2007
BD       .DB $BD
90       .DB $90
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
91       .DB $91
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
92       .DB $92
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
93       .DB $93
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
94       .DB $94
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
95       .DB $95
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
96       .DB $96
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
97       .DB $97
04       .DB $04
8D 07 20 STA $2007
A5       .DB $A5
28       PLP
8D 06 20 STA $2006
8C       .DB $8C
06 20    ASL $20
C8       INY
BD       .DB $BD
1F       .DB $1F
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
1E       .DB $1E
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
1D       .DB $1D
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
1C       .DB $1C
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
1B       .DB $1B
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
1A       .DB $1A
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
19       .DB $19
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
18       CLC
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
98       .DB $98
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
99       .DB $99
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
9A       TXS
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
9B       .DB $9B
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
9C       .DB $9C
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
9D       .DB $9D
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
9E       .DB $9E
04       .DB $04
8D 07 20 STA $2007
BD       .DB $BD
9F       .DB $9F
04       .DB $04
8D 07 20 STA $2007
18       CLC
8A       TXA
69       .DB $69
20 29 7F JSR $7F29
AA       TAX
C6       .DB $C6
2E       .DB $2E
F0       .DB $F0
07       .DB $07
C6       .DB $C6
2F       .DB $2F
F0       .DB $F0
03       .DB $03
4C EF CB JMP $CBEF
84       .DB $84
27       .DB $27
86       .DB $86
2C A5 1B BIT $1BA5
8D 00 20 STA $2000
A9 F0    LDA #$F0
8D 05 20 STA $2005
A9 D0    LDA #$D0
8D 05 20 STA $2005
68       PLA
A8       .DB $A8
68       PLA
AA       TAX
68       PLA
40       RTI
B9       .DB $B9
79       .DB $79
CA       DEX
24 22    BIT $22
30 12    BMI $0012
C5       .DB $C5
22       .DB $22
F0       .DB $F0
10 24    BPL $0024
23       .DB $23
30 0F    BMI $000F
C5       .DB $C5
23       .DB $23
F0       .DB $F0
0D 24 24 ORA $2424
30 0C    BMI $000C
10 0C    BPL $000C
85       .DB $85
22       .DB $22
A9 00    LDA #$00
60       RTS
85       .DB $85
23       .DB $23
A9 01    LDA #$01
60       RTS
85       .DB $85
24 A9    BIT $A9
02       .DB $02
60       RTS
A0 B0    LDY #$B0
B1       .DB $B1
C1       .DB $C1
C2       .DB $C2
D2       .DB $D2
D3       .DB $D3
E3       .DB $E3
E4       .DB $E4
F4       .DB $F4
F5       .DB $F5
F6       .DB $F6
06 07    ASL $07
17       .DB $17
18       CLC
28       PLP
29 39    AND #$39
3A       .DB $3A
4A       .DB $4A
02       .DB $02
01 02    ORA ($02,X)
01 02    ORA ($02,X)
01 02    ORA ($02,X)
01 02    ORA ($02,X)
01 02    ORA ($02,X)
01 03    ORA ($03,X)
0C       .DB $0C
04       .DB $04
0B       .DB $0B
05 0A    ORA $0A
06 09    ASL $09
07       .DB $07
08       PHP
07       .DB $07
08       PHP
07       .DB $07
08       PHP
07       .DB $07
08       PHP
07       .DB $07
08       PHP
07       .DB $07
08       PHP
02       .DB $02
01 02    ORA ($02,X)
01 02    ORA ($02,X)
01 02    ORA ($02,X)
01 02    ORA ($02,X)
01 00    ORA ($00,X)
00       BRK
07       .DB $07
08       PHP
07       .DB $07
08       PHP
07       .DB $07
08       PHP
07       .DB $07
08       PHP
07       .DB $07
08       PHP
FF       .DB $FF
AA       TAX
FF       .DB $FF
88       DEY
FF       .DB $FF
AA       TAX
AA       TAX
22       .DB $22
00       BRK
01 02    ORA ($02,X)
03       .DB $03
04       .DB $04
05 06    ORA $06
07       .DB $07
08       PHP
09 0A    ORA #$0A
0B       .DB $0B
0C       .DB $0C
0D 0E 0F ORA $0F0E
10 11    BPL $0011
12       .DB $12
13       .DB $13
14       .DB $14
15       .DB $15
16       .DB $16
17       .DB $17
18       CLC
19       .DB $19
1A       .DB $1A
1B       .DB $1B
1C       .DB $1C
1D       .DB $1D
1E       .DB $1E
1F       .DB $1F
20 21 22 JSR $2221
23       .DB $23
24 25    BIT $25
26       .DB $26
27       .DB $27
28       PLP
29 29    AND #$29
28       PLP
27       .DB $27
26       .DB $26
25 24    AND $24
23       .DB $23
22       .DB $22
21       .DB $21
20 1F 1E JSR $1E1F
1D       .DB $1D
1C       .DB $1C
1B       .DB $1B
1A       .DB $1A
19       .DB $19
18       CLC
17       .DB $17
16       .DB $16
15       .DB $15
14       .DB $14
13       .DB $13
12       .DB $12
11       .DB $11
10 0F    BPL $000F
0E 0D 0C ASL $0C0D
0B       .DB $0B
0A       ASL A
09 08    ORA #$08
07       .DB $07
06 05    ASL $05
04       .DB $04
03       .DB $03
02       .DB $02
01 00    ORA ($00,X)
80       .DB $80
81       .DB $81
82       .DB $82
83       .DB $83
84       .DB $84
85       .DB $85
86       .DB $86
87       .DB $87
88       DEY
89       .DB $89
8A       TXA
8B       .DB $8B
8C       .DB $8C
8D 8E 8F STA $8F8E
90       .DB $90
91       .DB $91
92       .DB $92
93       .DB $93
94       .DB $94
95       .DB $95
96       .DB $96
97       .DB $97
98       .DB $98
99       .DB $99
9A       TXS
9B       .DB $9B
9C       .DB $9C
9D       .DB $9D
9E       .DB $9E
9F       .DB $9F
A0 A1    LDY #$A1
A2 A3    LDX #$A3
A4       .DB $A4
A5       .DB $A5
A6       .DB $A6
A7       .DB $A7
A8       .DB $A8
A9 A9    LDA #$A9
A8       .DB $A8
A7       .DB $A7
A6       .DB $A6
A5       .DB $A5
A4       .DB $A4
A3       .DB $A3
A2 A1    LDX #$A1
A0 9F    LDY #$9F
9E       .DB $9E
9D       .DB $9D
9C       .DB $9C
9B       .DB $9B
9A       TXS
99       .DB $99
98       .DB $98
97       .DB $97
96       .DB $96
95       .DB $95
94       .DB $94
93       .DB $93
92       .DB $92
91       .DB $91
90       .DB $90
8F       .DB $8F
8E 8D 8C STX $8C8D
8B       .DB $8B
8A       TXA
89       .DB $89
88       DEY
87       .DB $87
86       .DB $86
85       .DB $85
84       .DB $84
83       .DB $83
82       .DB $82
81       .DB $81
80       .DB $80
F1       .DB $F1
6A       .DB $6A
AA       TAX
23       .DB $23
6B       .DB $6B
15       .DB $15
52       .DB $52
0F       .DB $0F
F0       .DB $F0
0B       .DB $0B
CA       DEX
09 4F    ORA #$4F
08       PHP
39       .DB $39
07       .DB $07
66       .DB $66
06 C0    ASL $C0
05 3A    ORA $3A
05 CC    ORA $CC
04       .DB $04
70       .DB $70
04       .DB $04
22       .DB $22
04       .DB $04
E0       .DB $E0
03       .DB $03
A7       .DB $A7
03       .DB $03
75       .DB $75
03       .DB $03
49       .DB $49
03       .DB $03
22       .DB $22
03       .DB $03
00       BRK
03       .DB $03
E2       .DB $E2
02       .DB $02
C7       .DB $C7
02       .DB $02
AF       .DB $AF
02       .DB $02
99       .DB $99
02       .DB $02
85       .DB $85
02       .DB $02
74       .DB $74
02       .DB $02
64       .DB $64
02       .DB $02
56       .DB $56
02       .DB $02
49       .DB $49
02       .DB $02
3D       .DB $3D
02       .DB $02
33       .DB $33
02       .DB $02
2A       .DB $2A
02       .DB $02
22       .DB $22
02       .DB $02
1B       .DB $1B
02       .DB $02
15       .DB $15
02       .DB $02
0F       .DB $0F
02       .DB $02
0B       .DB $0B
02       .DB $02
07       .DB $07
02       .DB $02
04       .DB $04
02       .DB $02
02       .DB $02
02       .DB $02
01 02    ORA ($02,X)
00       BRK
02       .DB $02
CA       DEX
6A       .DB $6A
9D       .DB $9D
23       .DB $23
63       .DB $63
15       .DB $15
4C 0F EC JMP $EC0F
0B       .DB $0B
C7       .DB $C7
09 4C    ORA #$4C
08       PHP
37       .DB $37
07       .DB $07
63       .DB $63
06 BD    ASL $BD
05 38    ORA $38
05 CA    ORA $CA
04       .DB $04
6E       .DB $6E
04       .DB $04
21       .DB $21
04       .DB $04
DE       .DB $DE
03       .DB $03
A5       .DB $A5
03       .DB $03
73       .DB $73
03       .DB $03
48       PHA
03       .DB $03
21       .DB $21
03       .DB $03
FF       .DB $FF
02       .DB $02
E1       .DB $E1
02       .DB $02
C6       .DB $C6
02       .DB $02
AE       .DB $AE
02       .DB $02
98       .DB $98
02       .DB $02
84       .DB $84
02       .DB $02
73       .DB $73
02       .DB $02
63       .DB $63
02       .DB $02
55       .DB $55
02       .DB $02
48       PHA
02       .DB $02
3D       .DB $3D
02       .DB $02
32       .DB $32
02       .DB $02
29 02    AND #$02
21       .DB $21
02       .DB $02
1A       .DB $1A
02       .DB $02
14       .DB $14
02       .DB $02
0F       .DB $0F
02       .DB $02
0A       ASL A
02       .DB $02
07       .DB $07
02       .DB $02
04       .DB $04
02       .DB $02
01 02    ORA ($02,X)
00       BRK
02       .DB $02
FF       .DB $FF
01 7E    ORA ($7E,X)
6A       .DB $6A
83       .DB $83
23       .DB $23
54       .DB $54
15       .DB $15
41       .DB $41
0F       .DB $0F
E3       .DB $E3
0B       .DB $0B
C0       .DB $C0
09 46    ORA #$46
08       PHP
31       .DB $31
07       .DB $07
5F       .DB $5F
06 B9    ASL $B9
05 34    ORA $34
05 C7    ORA $C7
04       .DB $04
6B       .DB $6B
04       .DB $04
1E       .DB $1E
04       .DB $04
DC       .DB $DC
03       .DB $03
A3       .DB $A3
03       .DB $03
71       .DB $71
03       .DB $03
45       .DB $45
03       .DB $03
1F       .DB $1F
03       .DB $03
FD       .DB $FD
02       .DB $02
DF       .DB $DF
02       .DB $02
C4       .DB $C4
02       .DB $02
AC       .DB $AC
02       .DB $02
96       .DB $96
02       .DB $02
83       .DB $83
02       .DB $02
71       .DB $71
02       .DB $02
61       .DB $61
02       .DB $02
53       .DB $53
02       .DB $02
46       .DB $46
02       .DB $02
3B       .DB $3B
02       .DB $02
31       .DB $31
02       .DB $02
28       PLP
02       .DB $02
20 02 19 JSR $1902
02       .DB $02
12       .DB $12
02       .DB $02
0D 02 09 ORA $0902
02       .DB $02
05 02    ORA $02
02       .DB $02
02       .DB $02
00       BRK
02       .DB $02
FF       .DB $FF
01 FE    ORA ($FE,X)
01 0B    ORA ($0B,X)
6A       .DB $6A
5D       .DB $5D
23       .DB $23
3D       .DB $3D
15       .DB $15
31       .DB $31
0F       .DB $0F
D6       .DB $D6
0B       .DB $0B
B5       .DB $B5
09 3D    ORA #$3D
08       PHP
2A       .DB $2A
07       .DB $07
58       .DB $58
06 B3    ASL $B3
05 2E    ORA $2E
05 C1    ORA $C1
04       .DB $04
66       .DB $66
04       .DB $04
19       .DB $19
04       .DB $04
D8       CLD
03       .DB $03
9F       .DB $9F
03       .DB $03
6D       .DB $6D
03       .DB $03
42       .DB $42
03       .DB $03
1C       .DB $1C
03       .DB $03
FA       .DB $FA
02       .DB $02
DC       .DB $DC
02       .DB $02
C1       .DB $C1
02       .DB $02
A9 02    LDA #$02
93       .DB $93
02       .DB $02
80       .DB $80
02       .DB $02
6E       .DB $6E
02       .DB $02
5F       .DB $5F
02       .DB $02
51       .DB $51
02       .DB $02
44       .DB $44
02       .DB $02
39       .DB $39
02       .DB $02
2E       .DB $2E
02       .DB $02
25 02    AND $02
1D       .DB $1D
02       .DB $02
16       .DB $16
02       .DB $02
10 02    BPL $0002
0B       .DB $0B
02       .DB $02
07       .DB $07
02       .DB $02
03       .DB $03
02       .DB $02
00       BRK
02       .DB $02
FE       .DB $FE
01 FC    ORA ($FC,X)
01 FC    ORA ($FC,X)
01 72    ORA ($72,X)
69       .DB $69
2A       .DB $2A
23       .DB $23
1E       .DB $1E
15       .DB $15
1B       .DB $1B
0F       .DB $0F
C5       .DB $C5
0B       .DB $0B
A7       .DB $A7
09 31    ORA #$31
08       PHP
1F       .DB $1F
07       .DB $07
4F       .DB $4F
06 AB    ASL $AB
05 27    ORA $27
05 BB    ORA $BB
04       .DB $04
60       RTS
04       .DB $04
14       .DB $14
04       .DB $04
D2       .DB $D2
03       .DB $03
99       .DB $99
03       .DB $03
68       PLA
03       .DB $03
3D       .DB $3D
03       .DB $03
17       .DB $17
03       .DB $03
F6       .DB $F6
02       .DB $02
D8       CLD
02       .DB $02
BD       .DB $BD
02       .DB $02
A5       .DB $A5
02       .DB $02
90       .DB $90
02       .DB $02
7C       .DB $7C
02       .DB $02
6B       .DB $6B
02       .DB $02
5B       .DB $5B
02       .DB $02
4D       .DB $4D
02       .DB $02
41       .DB $41
02       .DB $02
35       .DB $35
02       .DB $02
2B       .DB $2B
02       .DB $02
22       .DB $22
02       .DB $02
1A       .DB $1A
02       .DB $02
13       .DB $13
02       .DB $02
0D 02 08 ORA $0802
02       .DB $02
04       .DB $04
02       .DB $02
00       BRK
02       .DB $02
FD       .DB $FD
01 FB    ORA ($FB,X)
01 FA    ORA ($FA,X)
01 F9    ORA ($F9,X)
01 B4    ORA ($B4,X)
68       PLA
EB       .DB $EB
22       .DB $22
F8       .DB $F8
14       .DB $14
00       BRK
0F       .DB $0F
B0       .DB $B0
0B       .DB $0B
96       .DB $96
09 22    ORA #$22
08       PHP
12       .DB $12
07       .DB $07
43       .DB $43
06 A1    ASL $A1
05 1E    ORA $1E
05 B2    ORA $B2
04       .DB $04
58       .DB $58
04       .DB $04
0C       .DB $0C
04       .DB $04
CB       .DB $CB
03       .DB $03
93       .DB $93
03       .DB $03
62       .DB $62
03       .DB $03
37       .DB $37
03       .DB $03
12       .DB $12
03       .DB $03
F0       .DB $F0
02       .DB $02
D2       .DB $D2
02       .DB $02
B8       .DB $B8
02       .DB $02
A0 02    LDY #$02
8B       .DB $8B
02       .DB $02
78       SEI
02       .DB $02
67       .DB $67
02       .DB $02
57       .DB $57
02       .DB $02
49       .DB $49
02       .DB $02
3D       .DB $3D
02       .DB $02
31       .DB $31
02       .DB $02
27       .DB $27
02       .DB $02
1F       .DB $1F
02       .DB $02
17       .DB $17
02       .DB $02
10 02    BPL $0002
0A       ASL A
02       .DB $02
04       .DB $04
02       .DB $02
00       BRK
02       .DB $02
FC       .DB $FC
01 FA    ORA ($FA,X)
01 F7    ORA ($F7,X)
01 F6    ORA ($F6,X)
01 F5    ORA ($F5,X)
01 D0    ORA ($D0,X)
67       .DB $67
9F       .DB $9F
22       .DB $22
CB       .DB $CB
14       .DB $14
DF       .DB $DF
0E 97 0B ASL $0B97
81       .DB $81
09 10    ORA #$10
08       PHP
03       .DB $03
07       .DB $07
36       .DB $36
06 95    ASL $95
05 13    ORA $13
05 A8    ORA $A8
04       .DB $04
4F       .DB $4F
04       .DB $04
03       .DB $03
04       .DB $04
C3       .DB $C3
03       .DB $03
8B       .DB $8B
03       .DB $03
5B       .DB $5B
03       .DB $03
30 03    BMI $0003
0B       .DB $0B
03       .DB $03
EA       NOP
02       .DB $02
CC       .DB $CC
02       .DB $02
B2       .DB $B2
02       .DB $02
9A       TXS
02       .DB $02
85       .DB $85
02       .DB $02
72       .DB $72
02       .DB $02
61       .DB $61
02       .DB $02
52       .DB $52
02       .DB $02
44       .DB $44
02       .DB $02
38       SEC
02       .DB $02
2D       .DB $2D
02       .DB $02
23       .DB $23
02       .DB $02
1A       .DB $1A
02       .DB $02
12       .DB $12
02       .DB $02
0B       .DB $0B
02       .DB $02
05 02    ORA $02
00       BRK
02       .DB $02
FC       .DB $FC
01 F8    ORA ($F8,X)
01 F5    ORA ($F5,X)
01 F3    ORA ($F3,X)
01 F2    ORA ($F2,X)
01 F1    ORA ($F1,X)
01 C7    ORA ($C7,X)
66       .DB $66
46       .DB $46
22       .DB $22
96       .DB $96
14       .DB $14
B9       .DB $B9
0E 79 0B ASL $0B79
69       .DB $69
09 FC    ORA #$FC
07       .DB $07
F1       .DB $F1
06 26    ASL $26
06 86    ASL $86
05 06    ORA $06
05 9C    ORA $9C
04       .DB $04
44       .DB $44
04       .DB $04
F9       .DB $F9
03       .DB $03
B9       .DB $B9
03       .DB $03
82       .DB $82
03       .DB $03
52       .DB $52
03       .DB $03
28       PLP
03       .DB $03
03       .DB $03
03       .DB $03
E2       .DB $E2
02       .DB $02
C5       .DB $C5
02       .DB $02
AB       .DB $AB
02       .DB $02
94       .DB $94
02       .DB $02
7F       .DB $7F
02       .DB $02
6C       .DB $6C
02       .DB $02
5B       .DB $5B
02       .DB $02
4C 02 3E JMP $3E02
02       .DB $02
32       .DB $32
02       .DB $02
27       .DB $27
02       .DB $02
1D       .DB $1D
02       .DB $02
15       .DB $15
02       .DB $02
0D 02 06 ORA $0602
02       .DB $02
00       BRK
02       .DB $02
FB       .DB $FB
01 F7    ORA ($F7,X)
01 F3    ORA ($F3,X)
01 F0    ORA ($F0,X)
01 EE    ORA ($EE,X)
01 ED    ORA ($ED,X)
01 EC    ORA ($EC,X)
01 99    ORA ($99,X)
65       .DB $65
E2       .DB $E2
21       .DB $21
59       .DB $59
14       .DB $14
8E 0E 57 STX $570E
0B       .DB $0B
4D       .DB $4D
09 E4    ORA #$E4
07       .DB $07
DD       .DB $DD
06 14    ASL $14
06 76    ASL $76
05 F7    ORA $F7
04       .DB $04
8E 04 37 STX $3704
04       .DB $04
ED       .DB $ED
03       .DB $03
AE       .DB $AE
03       .DB $03
78       SEI
03       .DB $03
48       PHA
03       .DB $03
1F       .DB $1F
03       .DB $03
FA       .DB $FA
02       .DB $02
DA       .DB $DA
02       .DB $02
BD       .DB $BD
02       .DB $02
A3       .DB $A3
02       .DB $02
8C       .DB $8C
02       .DB $02
78       SEI
02       .DB $02
65       .DB $65
02       .DB $02
54       .DB $54
02       .DB $02
45       .DB $45
02       .DB $02
38       SEC
02       .DB $02
2C 02 21 BIT $2102
02       .DB $02
17       .DB $17
02       .DB $02
0E 02 07 ASL $0702
02       .DB $02
00       BRK
02       .DB $02
FA       .DB $FA
01 F5    ORA ($F5,X)
01 F1    ORA ($F1,X)
01 ED    ORA ($ED,X)
01 EB    ORA ($EB,X)
01 E8    ORA ($E8,X)
01 E7    ORA ($E7,X)
01 E6    ORA ($E6,X)
01 47    ORA ($47,X)
64       .DB $64
71       .DB $71
21       .DB $21
15       .DB $15
14       .DB $14
5E       .DB $5E
0E 32 0B ASL $0B32
2E       .DB $2E
09 CA    ORA #$CA
07       .DB $07
C6       .DB $C6
06 00    ASL $00
06 64    ASL $64
05 E6    ORA $E6
04       .DB $04
7F       .DB $7F
04       .DB $04
29 04    AND #$04
E0       .DB $E0
03       .DB $03
A2 03    LDX #$03
6C       .DB $6C
03       .DB $03
3E       .DB $3E
03       .DB $03
15       .DB $15
03       .DB $03
F0       .DB $F0
02       .DB $02
D0       .DB $D0
02       .DB $02
B4       .DB $B4
02       .DB $02
9B       .DB $9B
02       .DB $02
84       .DB $84
02       .DB $02
6F       .DB $6F
02       .DB $02
5D       .DB $5D
02       .DB $02
4D       .DB $4D
02       .DB $02
3E       .DB $3E
02       .DB $02
30 02    BMI $0002
24 02    BIT $02
1A       .DB $1A
02       .DB $02
10 02    BPL $0002
08       PHP
02       .DB $02
00       BRK
02       .DB $02
F9       .DB $F9
01 F4    ORA ($F4,X)
01 EF    ORA ($EF,X)
01 EA    ORA ($EA,X)
01 E7    ORA ($E7,X)
01 E4    ORA ($E4,X)
01 E2    ORA ($E2,X)
01 E1    ORA ($E1,X)
01 E0    ORA ($E0,X)
01 D1    ORA ($D1,X)
62       .DB $62
F4       .DB $F4
20 CA 13 JSR $13CA
28       PLP
0E 08 0B ASL $0B08
0C       .DB $0C
09 AD    ORA #$AD
07       .DB $07
AD       .DB $AD
06 E9    ASL $E9
05 50    ORA $50
05 D4    ORA $D4
04       .DB $04
6E       .DB $6E
04       .DB $04
1A       .DB $1A
04       .DB $04
D2       .DB $D2
03       .DB $03
95       .DB $95
03       .DB $03
60       RTS
03       .DB $03
31       .DB $31
03       .DB $03
09 03    ORA #$03
E5       .DB $E5
02       .DB $02
C6       .DB $C6
02       .DB $02
AA       TAX
02       .DB $02
91       .DB $91
02       .DB $02
7A       .DB $7A
02       .DB $02
66       .DB $66
02       .DB $02
54       .DB $54
02       .DB $02
44       .DB $44
02       .DB $02
35       .DB $35
02       .DB $02
28       PLP
02       .DB $02
1C       .DB $1C
02       .DB $02
12       .DB $12
02       .DB $02
08       PHP
02       .DB $02
00       BRK
02       .DB $02
F9       .DB $F9
01 F2    ORA ($F2,X)
01 EC    ORA ($EC,X)
01 E7    ORA ($E7,X)
01 E3    ORA ($E3,X)
01 E0    ORA ($E0,X)
01 DD    ORA ($DD,X)
01 DB    ORA ($DB,X)
01 DA    ORA ($DA,X)
01 D9    ORA ($D9,X)
01 38    ORA ($38,X)
61       .DB $61
6C       .DB $6C
20 78 13 JSR $1378
ED       .DB $ED
0D DA 0A ORA $0ADA
E6       .DB $E6
08       PHP
8D 07 91 STA $9107
06 D1    ASL $D1
05 3A    ORA $3A
05 C0    ORA $C0
04       .DB $04
5C       .DB $5C
04       .DB $04
09 04    ORA #$04
C2       .DB $C2
03       .DB $03
86       .DB $86
03       .DB $03
52       .DB $52
03       .DB $03
24 03    BIT $03
FC       .DB $FC
02       .DB $02
D9       .DB $D9
02       .DB $02
BA       .DB $BA
02       .DB $02
9F       .DB $9F
02       .DB $02
86       .DB $86
02       .DB $02
70       .DB $70
02       .DB $02
5C       .DB $5C
02       .DB $02
4B       .DB $4B
02       .DB $02
3B       .DB $3B
02       .DB $02
2C 02 1F BIT $1F02
02       .DB $02
14       .DB $14
02       .DB $02
09 02    ORA #$02
00       BRK
02       .DB $02
F8       .DB $F8
01 F0    ORA ($F0,X)
01 EA    ORA ($EA,X)
01 E4    ORA ($E4,X)
01 DF    ORA ($DF,X)
01 DB    ORA ($DB,X)
01 D8    ORA ($D8,X)
01 D5    ORA ($D5,X)
01 D3    ORA ($D3,X)
01 D2    ORA ($D2,X)
01 D1    ORA ($D1,X)
01 7B    ORA ($7B,X)
5F       .DB $5F
D8       CLD
1F       .DB $1F
1F       .DB $1F
13       .DB $13
AE       .DB $AE
0D A9 0A ORA $0AA9
BE       .DB $BE
08       PHP
6B       .DB $6B
07       .DB $07
73       .DB $73
06 B6    ASL $B6
05 22    ORA $22
05 AA    ORA $AA
04       .DB $04
48       PHA
04       .DB $04
F6       .DB $F6
03       .DB $03
B1       .DB $B1
03       .DB $03
76       .DB $76
03       .DB $03
42       .DB $42
03       .DB $03
16       .DB $16
03       .DB $03
EF       .DB $EF
02       .DB $02
CC       .DB $CC
02       .DB $02
AE       .DB $AE
02       .DB $02
93       .DB $93
02       .DB $02
7B       .DB $7B
02       .DB $02
65       .DB $65
02       .DB $02
52       .DB $52
02       .DB $02
40       RTI
02       .DB $02
30 02    BMI $0002
22       .DB $22
02       .DB $02
16       .DB $16
02       .DB $02
0A       ASL A
02       .DB $02
00       BRK
02       .DB $02
F7       .DB $F7
01 EF    ORA ($EF,X)
01 E8    ORA ($E8,X)
01 E1    ORA ($E1,X)
01 DC    ORA ($DC,X)
01 D7    ORA ($D7,X)
01 D3    ORA ($D3,X)
01 D0    ORA ($D0,X)
01 CD    ORA ($CD,X)
01 CB    ORA ($CB,X)
01 CA    ORA ($CA,X)
01 C9    ORA ($C9,X)
01 9D    ORA ($9D,X)
5D       .DB $5D
38       SEC
1F       .DB $1F
C0       .DB $C0
12       .DB $12
69       .DB $69
0D 73 0A ORA $0A73
92       .DB $92
08       PHP
46       .DB $46
07       .DB $07
53       .DB $53
06 9A    ASL $9A
05 08    ORA $08
05 93    ORA $93
04       .DB $04
33       .DB $33
04       .DB $04
E2       .DB $E2
03       .DB $03
9E       .DB $9E
03       .DB $03
64       .DB $64
03       .DB $03
32       .DB $32
03       .DB $03
06 03    ASL $03
E0       .DB $E0
02       .DB $02
BE       .DB $BE
02       .DB $02
A0 02    LDY #$02
86       .DB $86
02       .DB $02
6E       .DB $6E
02       .DB $02
59       .DB $59
02       .DB $02
46       .DB $46
02       .DB $02
35       .DB $35
02       .DB $02
25 02    AND $02
18       CLC
02       .DB $02
0B       .DB $0B
02       .DB $02
00       BRK
02       .DB $02
F6       .DB $F6
01 ED    ORA ($ED,X)
01 E5    ORA ($E5,X)
01 DE    ORA ($DE,X)
01 D8    ORA ($D8,X)
01 D2    ORA ($D2,X)
01 CE    ORA ($CE,X)
01 CA    ORA ($CA,X)
01 C7    ORA ($C7,X)
01 C4    ORA ($C4,X)
01 C2    ORA ($C2,X)
01 C1    ORA ($C1,X)
01 C0    ORA ($C0,X)
01 F1    ORA ($F1,X)
6A       .DB $6A
9D       .DB $9D
23       .DB $23
54       .DB $54
15       .DB $15
31       .DB $31
0F       .DB $0F
C5       .DB $C5
0B       .DB $0B
96       .DB $96
09 10    ORA #$10
08       PHP
F1       .DB $F1
06 14    ASL $14
06 64    ASL $64
05 D4    ORA $D4
04       .DB $04
5C       .DB $5C
04       .DB $04
F6       .DB $F6
03       .DB $03
9E       .DB $9E
03       .DB $03
52       .DB $52
03       .DB $03
0E 03 D2 ASL $D203
02       .DB $02
9B       .DB $9B
02       .DB $02
6A       .DB $6A
02       .DB $02
3D       .DB $3D
02       .DB $02
14       .DB $14
02       .DB $02
ED       .DB $ED
01 CA    ORA ($CA,X)
01 A8    ORA ($A8,X)
01 89    ORA ($89,X)
01 6B    ORA ($6B,X)
01 4F    ORA ($4F,X)
01 35    ORA ($35,X)
01 1B    ORA ($1B,X)
01 02    ORA ($02,X)
01 EB    ORA ($EB,X)
00       BRK
D4       .DB $D4
00       BRK
BE       .DB $BE
00       BRK
A8       .DB $A8
00       BRK
94       .DB $94
00       BRK
7F       .DB $7F
00       BRK
6B       .DB $6B
00       BRK
57       .DB $57
00       BRK
43       .DB $43
00       BRK
30 00    BMI $0000
1D       .DB $1D
00       BRK
0A       ASL A
00       BRK
25 D1    AND $D1
7D       .DB $7D
29 D5    AND #$D5
81       .DB $81
2D       .DB $2D
D9       .DB $D9
85       .DB $85
31       .DB $31
DD       .DB $DD
89       .DB $89
35       .DB $35
E1       .DB $E1
E1       .DB $E1
35       .DB $35
89       .DB $89
DD       .DB $DD
31       .DB $31
85       .DB $85
D9       .DB $D9
2D       .DB $2D
81       .DB $81
D5       .DB $D5
29 7D    AND #$7D
D1       .DB $D1
25 D3    AND $D3
D2       .DB $D2
D2       .DB $D2
D2       .DB $D2
D1       .DB $D1
D1       .DB $D1
D1       .DB $D1
D0       .DB $D0
D0       .DB $D0
D0       .DB $D0
CF       .DB $CF
CF       .DB $CF
CF       .DB $CF
CE       .DB $CE
CE       .DB $CE
CF       .DB $CF
CF       .DB $CF
CF       .DB $CF
D0       .DB $D0
D0       .DB $D0
D0       .DB $D0
D1       .DB $D1
D1       .DB $D1
D1       .DB $D1
D2       .DB $D2
D2       .DB $D2
D2       .DB $D2
D3       .DB $D3
01 01    ORA ($01,X)
34       .DB $34
DC       .DB $DC
01 A3    ORA ($A3,X)
9E       .DB $9E
67       .DB $67
B5       .DB $B5
5F       .DB $5F
4A       .DB $4A
65       .DB $65
A4       .DB $A4
01 73    ORA ($73,X)
F8       .DB $F8
8C       .DB $8C
2C D7 8A BIT $8AD7
45       .DB $45
06 CD    ASL $CD
99       .DB $99
69       .DB $69
3D       .DB $3D
14       .DB $14
EE       .DB $EE
CB       .DB $CB
AA       TAX
8B       .DB $8B
6E       .DB $6E
53       .DB $53
3A       .DB $3A
22       .DB $22
0B       .DB $0B
F6       .DB $F6
E2       .DB $E2
CF       .DB $CF
BC       .DB $BC
AB       .DB $AB
9B       .DB $9B
8B       .DB $8B
7C       .DB $7C
6E       .DB $6E
60       RTS
53       .DB $53
47       .DB $47
3B       .DB $3B
2F       .DB $2F
24 19    BIT $19
0F       .DB $0F
05 FC    ORA $FC
F3       .DB $F3
EA       NOP
E1       .DB $E1
D9       .DB $D9
D1       .DB $D1
C9       .DB $C9
C2       .DB $C2
BB       .DB $BB
B4       .DB $B4
AD       .DB $AD
A7       .DB $A7
A0 9A    LDY #$9A
94       .DB $94
8E 89 83 STX $8389
7E       .DB $7E
79       .DB $79
74       .DB $74
6F       .DB $6F
6A       .DB $6A
65       .DB $65
61       .DB $61
5C       .DB $5C
58       .DB $58
54       .DB $54
50       .DB $50
4C 48 44 JMP $4448
40       RTI
3C       .DB $3C
39       .DB $39
35       .DB $35
32       .DB $32
2F       .DB $2F
2B       .DB $2B
28       PLP
25 22    AND $22
1F       .DB $1F
1C       .DB $1C
19       .DB $19
16       .DB $16
14       .DB $14
11       .DB $11
0E 0C 09 ASL $090C
07       .DB $07
04       .DB $04
02       .DB $02
FF       .DB $FF
FD       .DB $FD
FB       .DB $FB
F8       .DB $F8
F6       .DB $F6
F4       .DB $F4
F2       .DB $F2
F0       .DB $F0
EE       .DB $EE
EC       .DB $EC
EA       NOP
E8       INX
E6       .DB $E6
E4       .DB $E4
E2       .DB $E2
E0       .DB $E0
DF       .DB $DF
DD       .DB $DD
DB       .DB $DB
D9       .DB $D9
D8       CLD
D6       .DB $D6
D4       .DB $D4
D3       .DB $D3
D1       .DB $D1
D0       .DB $D0
CE       .DB $CE
CD       .DB $CD
CB       .DB $CB
CA       DEX
C8       INY
C7       .DB $C7
C5       .DB $C5
C4       .DB $C4
C3       .DB $C3
C1       .DB $C1
C0       .DB $C0
BF       .DB $BF
BD       .DB $BD
BC       .DB $BC
BB       .DB $BB
B9       .DB $B9
B8       .DB $B8
B7       .DB $B7
B6       .DB $B6
B5       .DB $B5
B3       .DB $B3
B2       .DB $B2
B1       .DB $B1
B0       .DB $B0
AF       .DB $AF
AE       .DB $AE
AD       .DB $AD
AC       .DB $AC
AB       .DB $AB
AA       TAX
A9 A8    LDA #$A8
A7       .DB $A7
A6       .DB $A6
A5       .DB $A5
A4       .DB $A4
A3       .DB $A3
A2 A1    LDX #$A1
A0 9F    LDY #$9F
9E       .DB $9E
9D       .DB $9D
9C       .DB $9C
9B       .DB $9B
9B       .DB $9B
9A       TXS
99       .DB $99
98       .DB $98
97       .DB $97
96       .DB $96
96       .DB $96
95       .DB $95
94       .DB $94
93       .DB $93
92       .DB $92
92       .DB $92
91       .DB $91
90       .DB $90
8F       .DB $8F
8F       .DB $8F
8E 8D 8C STX $8C8D
8C       .DB $8C
8B       .DB $8B
8A       TXA
8A       TXA
89       .DB $89
88       DEY
88       DEY
87       .DB $87
86       .DB $86
86       .DB $86
85       .DB $85
84       .DB $84
84       .DB $84
83       .DB $83
83       .DB $83
82       .DB $82
81       .DB $81
81       .DB $81
80       .DB $80
80       .DB $80
7F       .DB $7F
7E       .DB $7E
7E       .DB $7E
7D       .DB $7D
7D       .DB $7D
7C       .DB $7C
7C       .DB $7C
7B       .DB $7B
7B       .DB $7B
7A       .DB $7A
79       .DB $79
79       .DB $79
78       SEI
78       SEI
77       .DB $77
77       .DB $77
76       .DB $76
76       .DB $76
75       .DB $75
75       .DB $75
74       .DB $74
74       .DB $74
73       .DB $73
73       .DB $73
73       .DB $73
72       .DB $72
72       .DB $72
71       .DB $71
71       .DB $71
70       .DB $70
70       .DB $70
6F       .DB $6F
6F       .DB $6F
6E       .DB $6E
6E       .DB $6E
6E       .DB $6E
6D       .DB $6D
6D       .DB $6D
D8       CLD
48       PHA
2B       .DB $2B
1E       .DB $1E
18       CLC
13       .DB $13
10 0E    BPL $000E
0C       .DB $0C
0B       .DB $0B
0A       ASL A
09 08    ORA #$08
08       PHP
07       .DB $07
06 06    ASL $06
06 05    ASL $05
05 05    ORA $05
05 04    ORA $04
04       .DB $04
04       .DB $04
04       .DB $04
04       .DB $04
03       .DB $03
03       .DB $03
03       .DB $03
03       .DB $03
03       .DB $03
03       .DB $03
03       .DB $03
03       .DB $03
03       .DB $03
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
02       .DB $02
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
01 01    ORA ($01,X)
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
11       .DB $11
A2 51    LDX #$51
FF       .DB $FF
62       .DB $62
22       .DB $22
B3       .DB $B3
FF       .DB $FF
91       .DB $91
73       .DB $73
33       .DB $33
40       RTI
48       PHA
44       .DB $44
4C 42 4A JMP $4A42
46       .DB $46
4E       .DB $4E
41       .DB $41
49       .DB $49
45       .DB $45
4D       .DB $4D
43       .DB $43
4B       .DB $4B
47       .DB $47
4F       .DB $4F
50       .DB $50
58       .DB $58
54       .DB $54
5C       .DB $5C
52       .DB $52
5A       .DB $5A
56       .DB $56
5E       .DB $5E
51       .DB $51
59       .DB $59
55       .DB $55
5D       .DB $5D
53       .DB $53
5B       .DB $5B
57       .DB $57
5F       .DB $5F
60       RTS
68       PLA
64       .DB $64
6C       .DB $6C
62       .DB $62
6A       .DB $6A
66       .DB $66
6E       .DB $6E
61       .DB $61
69       .DB $69
65       .DB $65
6D       .DB $6D
63       .DB $63
6B       .DB $6B
67       .DB $67
6F       .DB $6F
70       .DB $70
78       SEI
74       .DB $74
7C       .DB $7C
72       .DB $72
7A       .DB $7A
76       .DB $76
7E       .DB $7E
71       .DB $71
79       .DB $79
75       .DB $75
7D       .DB $7D
73       .DB $73
7B       .DB $7B
77       .DB $77
7F       .DB $7F
00       BRK
0A       ASL A
13       .DB $13
1D       .DB $1D
26       .DB $26
30 39    BMI $0039
42       .DB $42
4B       .DB $4B
55       .DB $55
5E       .DB $5E
66       .DB $66
6F       .DB $6F
78       SEI
80       .DB $80
88       DEY
90       .DB $90
98       .DB $98
A0 A7    LDY #$A7
AE       .DB $AE
B5       .DB $B5
BC       .DB $BC
C2       .DB $C2
C8       INY
CE       .DB $CE
D4       .DB $D4
D9       .DB $D9
DE       .DB $DE
E2       .DB $E2
E7       .DB $E7
EB       .DB $EB
EE       .DB $EE
F2       .DB $F2
F5       .DB $F5
F7       .DB $F7
FA       .DB $FA
FC       .DB $FC
FD       .DB $FD
FE       .DB $FE
FF       .DB $FF
00       BRK
00       BRK
00       BRK
FF       .DB $FF
FE       .DB $FE
FD       .DB $FD
FC       .DB $FC
FA       .DB $FA
F7       .DB $F7
F5       .DB $F5
F2       .DB $F2
EE       .DB $EE
EB       .DB $EB
E7       .DB $E7
E2       .DB $E2
DE       .DB $DE
D9       .DB $D9
D4       .DB $D4
CE       .DB $CE
C8       INY
C2       .DB $C2
BC       .DB $BC
B5       .DB $B5
AE       .DB $AE
A7       .DB $A7
A0 98    LDY #$98
90       .DB $90
88       DEY
80       .DB $80
78       SEI
6F       .DB $6F
66       .DB $66
5E       .DB $5E
55       .DB $55
4B       .DB $4B
42       .DB $42
39       .DB $39
30 26    BMI $0026
1D       .DB $1D
13       .DB $13
0A       ASL A
00       BRK
F6       .DB $F6
ED       .DB $ED
E3       .DB $E3
DA       .DB $DA
D0       .DB $D0
C7       .DB $C7
BE       .DB $BE
B5       .DB $B5
AB       .DB $AB
A2 9A    LDX #$9A
91       .DB $91
88       DEY
80       .DB $80
78       SEI
70       .DB $70
68       PLA
60       RTS
59       .DB $59
52       .DB $52
4B       .DB $4B
44       .DB $44
3E       .DB $3E
38       SEC
32       .DB $32
2C 27 22 BIT $2227
1E       .DB $1E
19       .DB $19
15       .DB $15
12       .DB $12
0E 0B 09 ASL $090B
06 04    ASL $04
03       .DB $03
02       .DB $02
01 00    ORA ($00,X)
00       BRK
00       BRK
01 02    ORA ($02,X)
03       .DB $03
04       .DB $04
06 09    ASL $09
0B       .DB $0B
0E 12 15 ASL $1512
19       .DB $19
1E       .DB $1E
22       .DB $22
27       .DB $27
2C 32 38 BIT $3832
3E       .DB $3E
44       .DB $44
4B       .DB $4B
52       .DB $52
59       .DB $59
60       RTS
68       PLA
70       .DB $70
78       SEI
80       .DB $80
88       DEY
91       .DB $91
9A       TXS
A2 AB    LDX #$AB
B5       .DB $B5
BE       .DB $BE
C7       .DB $C7
D0       .DB $D0
DA       .DB $DA
E3       .DB $E3
ED       .DB $ED
F6       .DB $F6
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
01 01    ORA ($01,X)
01 00    ORA ($00,X)
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
FF       .DB $FF
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
00       BRK
2C C0 00 BIT $00C0
C0       .DB $C0
45       .DB $45
C0       .DB $C0

; ====================
; Interrupt Vectors
; ====================
.org $FFFA
.dw NMI
.dw RESET
.dw IRQ

NMI:  RTI
IRQ:  RTI