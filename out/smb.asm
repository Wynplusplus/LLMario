; Super Mario Bros. (World) PRG disassembly
; 32 KiB PRG mapped at $8000-$FFFF. Code from recursive traversal
; (RESET/NMI/IRQ + in-line jump tables); other bytes are data.
; Each line is commented with its address and raw opcode bytes.
.setcpu "6502"
.segment "PRG"

        SEI                        ; $8000: 78
        CLD                        ; $8001: D8
        LDA #$10                   ; $8002: A9 10
        STA a:$2000                ; $8004: 8D 00 20
        LDX #$FF                   ; $8007: A2 FF
        TXS                        ; $8009: 9A
L800A:
        LDA a:$2002                ; $800A: AD 02 20
        BPL L800A                  ; $800D: 10 FB
L800F:
        LDA a:$2002                ; $800F: AD 02 20
        BPL L800F                  ; $8012: 10 FB
        LDY #$FE                   ; $8014: A0 FE
        LDX #$05                   ; $8016: A2 05
L8018:
        LDA a:$07D7,x              ; $8018: BD D7 07
        CMP #$0A                   ; $801B: C9 0A
        BCS L802B                  ; $801D: B0 0C
        DEX                        ; $801F: CA
        BPL L8018                  ; $8020: 10 F6
        LDA a:$07FF                ; $8022: AD FF 07
        CMP #$A5                   ; $8025: C9 A5
        BNE L802B                  ; $8027: D0 02
        LDY #$D6                   ; $8029: A0 D6
L802B:
        JSR a:$90CC                ; $802B: 20 CC 90
        STA a:$4011                ; $802E: 8D 11 40
        STA a:$0770                ; $8031: 8D 70 07
        LDA #$A5                   ; $8034: A9 A5
        STA a:$07FF                ; $8036: 8D FF 07
        STA a:$07A7                ; $8039: 8D A7 07
        LDA #$0F                   ; $803C: A9 0F
        STA a:$4015                ; $803E: 8D 15 40
        LDA #$06                   ; $8041: A9 06
        STA a:$2001                ; $8043: 8D 01 20
        JSR a:$8220                ; $8046: 20 20 82
        JSR a:$8E19                ; $8049: 20 19 8E
        INC a:$0774                ; $804C: EE 74 07
        LDA a:$0778                ; $804F: AD 78 07
        ORA #$80                   ; $8052: 09 80
        JSR a:$8EED                ; $8054: 20 ED 8E
        JMP a:$8057                ; $8057: 4C 57 80
        .byte $01,$A4,$C8,$EC,$10,$00,$41,$41,$4C,$34,$3C,$44,$54,$68,$7C,$A8   ; $805A
        .byte $BF,$DE,$EF,$03,$8C,$8C,$8C,$8D,$03,$03,$03,$8D,$8D,$8D,$8D,$8D   ; $806A
        .byte $8D,$8D,$8D,$8D,$8D,$8D,$00,$40   ; $807A
        LDA a:$0778                ; $8082: AD 78 07
        AND #$7F                   ; $8085: 29 7F
        STA a:$0778                ; $8087: 8D 78 07
        AND #$7E                   ; $808A: 29 7E
        STA a:$2000                ; $808C: 8D 00 20
        LDA a:$0779                ; $808F: AD 79 07
        AND #$E6                   ; $8092: 29 E6
        LDY a:$0774                ; $8094: AC 74 07
        BNE L809E                  ; $8097: D0 05
        LDA a:$0779                ; $8099: AD 79 07
        ORA #$1E                   ; $809C: 09 1E
L809E:
        STA a:$0779                ; $809E: 8D 79 07
        AND #$E7                   ; $80A1: 29 E7
        STA a:$2001                ; $80A3: 8D 01 20
        LDX a:$2002                ; $80A6: AE 02 20
        LDA #$00                   ; $80A9: A9 00
        JSR a:$8EE6                ; $80AB: 20 E6 8E
        STA a:$2003                ; $80AE: 8D 03 20
        LDA #$02                   ; $80B1: A9 02
        STA a:$4014                ; $80B3: 8D 14 40
        LDX a:$0773                ; $80B6: AE 73 07
        LDA a:$805A,x              ; $80B9: BD 5A 80
        STA z:$00                  ; $80BC: 85 00
        LDA a:$806D,x              ; $80BE: BD 6D 80
        STA z:$01                  ; $80C1: 85 01
        JSR a:$8EDD                ; $80C3: 20 DD 8E
        LDY #$00                   ; $80C6: A0 00
        LDX a:$0773                ; $80C8: AE 73 07
        CPX #$06                   ; $80CB: E0 06
        BNE L80D0                  ; $80CD: D0 01
        INY                        ; $80CF: C8
L80D0:
        LDX a:$8080,y              ; $80D0: BE 80 80
        LDA #$00                   ; $80D3: A9 00
        STA a:$0300,x              ; $80D5: 9D 00 03
        STA a:$0301,x              ; $80D8: 9D 01 03
        STA a:$0773                ; $80DB: 8D 73 07
        LDA a:$0779                ; $80DE: AD 79 07
        STA a:$2001                ; $80E1: 8D 01 20
        JSR a:$F2D0                ; $80E4: 20 D0 F2
        JSR a:$8E5C                ; $80E7: 20 5C 8E
        JSR a:$8182                ; $80EA: 20 82 81
        JSR a:$8F97                ; $80ED: 20 97 8F
        LDA a:$0776                ; $80F0: AD 76 07
        LSR a                      ; $80F3: 4A
        BCS L811B                  ; $80F4: B0 25
        LDA a:$0747                ; $80F6: AD 47 07
        BEQ L8100                  ; $80F9: F0 05
        DEC a:$0747                ; $80FB: CE 47 07
        BNE L8119                  ; $80FE: D0 19
L8100:
        LDX #$14                   ; $8100: A2 14
        DEC a:$077F                ; $8102: CE 7F 07
        BPL L810E                  ; $8105: 10 07
        LDA #$14                   ; $8107: A9 14
        STA a:$077F                ; $8109: 8D 7F 07
        LDX #$23                   ; $810C: A2 23
L810E:
        LDA a:$0780,x              ; $810E: BD 80 07
        BEQ L8116                  ; $8111: F0 03
        DEC a:$0780,x              ; $8113: DE 80 07
L8116:
        DEX                        ; $8116: CA
        BPL L810E                  ; $8117: 10 F5
L8119:
        INC z:$09                  ; $8119: E6 09
L811B:
        LDX #$00                   ; $811B: A2 00
        LDY #$07                   ; $811D: A0 07
        LDA a:$07A7                ; $811F: AD A7 07
        AND #$02                   ; $8122: 29 02
        STA z:$00                  ; $8124: 85 00
        LDA a:$07A8                ; $8126: AD A8 07
        AND #$02                   ; $8129: 29 02
        EOR z:$00                  ; $812B: 45 00
        CLC                        ; $812D: 18
        BEQ L8131                  ; $812E: F0 01
        SEC                        ; $8130: 38
L8131:
        ROR a:$07A7,x              ; $8131: 7E A7 07
        INX                        ; $8134: E8
        DEY                        ; $8135: 88
        BNE L8131                  ; $8136: D0 F9
        LDA a:$0722                ; $8138: AD 22 07
        BEQ L815C                  ; $813B: F0 1F
L813D:
        LDA a:$2002                ; $813D: AD 02 20
        AND #$40                   ; $8140: 29 40
        BNE L813D                  ; $8142: D0 F9
        LDA a:$0776                ; $8144: AD 76 07
        LSR a                      ; $8147: 4A
        BCS L8150                  ; $8148: B0 06
        JSR a:$8223                ; $814A: 20 23 82
        JSR a:$81C6                ; $814D: 20 C6 81
L8150:
        LDA a:$2002                ; $8150: AD 02 20
        AND #$40                   ; $8153: 29 40
        BEQ L8150                  ; $8155: F0 F9
        LDY #$14                   ; $8157: A0 14
L8159:
        DEY                        ; $8159: 88
        BNE L8159                  ; $815A: D0 FD
L815C:
        LDA a:$073F                ; $815C: AD 3F 07
        STA a:$2005                ; $815F: 8D 05 20
        LDA a:$0740                ; $8162: AD 40 07
        STA a:$2005                ; $8165: 8D 05 20
        LDA a:$0778                ; $8168: AD 78 07
        PHA                        ; $816B: 48
        STA a:$2000                ; $816C: 8D 00 20
        LDA a:$0776                ; $816F: AD 76 07
        LSR a                      ; $8172: 4A
        BCS L8178                  ; $8173: B0 03
        JSR a:$8212                ; $8175: 20 12 82
L8178:
        LDA a:$2002                ; $8178: AD 02 20
        PLA                        ; $817B: 68
        ORA #$80                   ; $817C: 09 80
        STA a:$2000                ; $817E: 8D 00 20
        RTI                        ; $8181: 40
        LDA a:$0770                ; $8182: AD 70 07
        CMP #$02                   ; $8185: C9 02
        BEQ L8194                  ; $8187: F0 0B
        CMP #$01                   ; $8189: C9 01
        BNE L81C5                  ; $818B: D0 38
        LDA a:$0772                ; $818D: AD 72 07
        CMP #$03                   ; $8190: C9 03
        BNE L81C5                  ; $8192: D0 31
L8194:
        LDA a:$0777                ; $8194: AD 77 07
        BEQ L819D                  ; $8197: F0 04
        DEC a:$0777                ; $8199: CE 77 07
        RTS                        ; $819C: 60
L819D:
        LDA a:$06FC                ; $819D: AD FC 06
        AND #$10                   ; $81A0: 29 10
        BEQ L81BD                  ; $81A2: F0 19
        LDA a:$0776                ; $81A4: AD 76 07
        AND #$80                   ; $81A7: 29 80
        BNE L81C5                  ; $81A9: D0 1A
        LDA #$2B                   ; $81AB: A9 2B
        STA a:$0777                ; $81AD: 8D 77 07
        LDA a:$0776                ; $81B0: AD 76 07
        TAY                        ; $81B3: A8
        INY                        ; $81B4: C8
        STY z:$FA                  ; $81B5: 84 FA
        EOR #$01                   ; $81B7: 49 01
        ORA #$80                   ; $81B9: 09 80
        BNE L81C2                  ; $81BB: D0 05
L81BD:
        LDA a:$0776                ; $81BD: AD 76 07
        AND #$7F                   ; $81C0: 29 7F
L81C2:
        STA a:$0776                ; $81C2: 8D 76 07
L81C5:
        RTS                        ; $81C5: 60
        LDY a:$074E                ; $81C6: AC 4E 07
        LDA #$28                   ; $81C9: A9 28
        STA z:$00                  ; $81CB: 85 00
        LDX #$0E                   ; $81CD: A2 0E
L81CF:
        LDA a:$06E4,x              ; $81CF: BD E4 06
        CMP z:$00                  ; $81D2: C5 00
        BCC L81E5                  ; $81D4: 90 0F
        LDY a:$06E0                ; $81D6: AC E0 06
        CLC                        ; $81D9: 18
        ADC a:$06E1,y              ; $81DA: 79 E1 06
        BCC L81E2                  ; $81DD: 90 03
        CLC                        ; $81DF: 18
        ADC z:$00                  ; $81E0: 65 00
L81E2:
        STA a:$06E4,x              ; $81E2: 9D E4 06
L81E5:
        DEX                        ; $81E5: CA
        BPL L81CF                  ; $81E6: 10 E7
        LDX a:$06E0                ; $81E8: AE E0 06
        INX                        ; $81EB: E8
        CPX #$03                   ; $81EC: E0 03
        BNE L81F2                  ; $81EE: D0 02
        LDX #$00                   ; $81F0: A2 00
L81F2:
        STX a:$06E0                ; $81F2: 8E E0 06
        LDX #$08                   ; $81F5: A2 08
        LDY #$02                   ; $81F7: A0 02
L81F9:
        LDA a:$06E9,y              ; $81F9: B9 E9 06
        STA a:$06F1,x              ; $81FC: 9D F1 06
        CLC                        ; $81FF: 18
        ADC #$08                   ; $8200: 69 08
        STA a:$06F2,x              ; $8202: 9D F2 06
        CLC                        ; $8205: 18
        ADC #$08                   ; $8206: 69 08
        STA a:$06F3,x              ; $8208: 9D F3 06
        DEX                        ; $820B: CA
        DEX                        ; $820C: CA
        DEX                        ; $820D: CA
        DEY                        ; $820E: 88
        BPL L81F9                  ; $820F: 10 E8
        RTS                        ; $8211: 60
        LDA a:$0770                ; $8212: AD 70 07
        JSR a:$8E04                ; $8215: 20 04 8E
        AND ($82),y                ; $8218: 31 82
        .byte $DC,$AE,$8B,$83,$18,$92   ; $821A
        LDY #$00                   ; $8220: A0 00
        BIT a:$04A0                ; $8222: 2C A0 04
        LDA #$F8                   ; $8225: A9 F8
L8227:
        STA a:$0200,y              ; $8227: 99 00 02
        INY                        ; $822A: C8
        INY                        ; $822B: C8
        INY                        ; $822C: C8
        INY                        ; $822D: C8
        BNE L8227                  ; $822E: D0 F7
        RTS                        ; $8230: 60
        LDA a:$0772                ; $8231: AD 72 07
        JSR a:$8E04                ; $8234: 20 04 8E
        .byte $CF,$8F,$67,$85,$61,$90,$45,$82,$04,$20,$73,$01,$00,$00   ; $8237
        LDY #$00                   ; $8245: A0 00
        LDA a:$06FC                ; $8247: AD FC 06
        ORA a:$06FD                ; $824A: 0D FD 06
        CMP #$10                   ; $824D: C9 10
        BEQ L8255                  ; $824F: F0 04
        CMP #$90                   ; $8251: C9 90
        BNE L8258                  ; $8253: D0 03
L8255:
        JMP a:$82D8                ; $8255: 4C D8 82
L8258:
        CMP #$20                   ; $8258: C9 20
        BEQ L8276                  ; $825A: F0 1A
        LDX a:$07A2                ; $825C: AE A2 07
        BNE L826C                  ; $825F: D0 0B
        STA a:$0780                ; $8261: 8D 80 07
        JSR a:$836B                ; $8264: 20 6B 83
        BCS L82C9                  ; $8267: B0 60
        JMP a:$82C0                ; $8269: 4C C0 82
L826C:
        LDX a:$07FC                ; $826C: AE FC 07
        BEQ L82BB                  ; $826F: F0 4A
        CMP #$40                   ; $8271: C9 40
        BNE L82BB                  ; $8273: D0 46
        INY                        ; $8275: C8
L8276:
        LDA a:$07A2                ; $8276: AD A2 07
        BEQ L82C9                  ; $8279: F0 4E
        LDA #$18                   ; $827B: A9 18
        STA a:$07A2                ; $827D: 8D A2 07
        LDA a:$0780                ; $8280: AD 80 07
        BNE L82BB                  ; $8283: D0 36
        LDA #$10                   ; $8285: A9 10
        STA a:$0780                ; $8287: 8D 80 07
        CPY #$01                   ; $828A: C0 01
        BEQ L829C                  ; $828C: F0 0E
        LDA a:$077A                ; $828E: AD 7A 07
        EOR #$01                   ; $8291: 49 01
        STA a:$077A                ; $8293: 8D 7A 07
        JSR a:$8325                ; $8296: 20 25 83
        JMP a:$82BB                ; $8299: 4C BB 82
L829C:
        LDX a:$076B                ; $829C: AE 6B 07
        INX                        ; $829F: E8
        TXA                        ; $82A0: 8A
        AND #$07                   ; $82A1: 29 07
        STA a:$076B                ; $82A3: 8D 6B 07
        JSR a:$830E                ; $82A6: 20 0E 83
L82A9:
        LDA a:$823F,x              ; $82A9: BD 3F 82
        STA a:$0300,x              ; $82AC: 9D 00 03
        INX                        ; $82AF: E8
        CPX #$06                   ; $82B0: E0 06
        BMI L82A9                  ; $82B2: 30 F5
        LDY a:$075F                ; $82B4: AC 5F 07
        INY                        ; $82B7: C8
        STY a:$0304                ; $82B8: 8C 04 03
L82BB:
        LDA #$00                   ; $82BB: A9 00
        STA a:$06FC                ; $82BD: 8D FC 06
        JSR a:$AEEA                ; $82C0: 20 EA AE
        LDA z:$0E                  ; $82C3: A5 0E
        CMP #$06                   ; $82C5: C9 06
        BNE L830D                  ; $82C7: D0 44
L82C9:
        LDA #$00                   ; $82C9: A9 00
        STA a:$0770                ; $82CB: 8D 70 07
        STA a:$0772                ; $82CE: 8D 72 07
        STA a:$0722                ; $82D1: 8D 22 07
        INC a:$0774                ; $82D4: EE 74 07
        RTS                        ; $82D7: 60
        LDY a:$07A2                ; $82D8: AC A2 07
        BEQ L82C9                  ; $82DB: F0 EC
        ASL a                      ; $82DD: 0A
        BCC L82E6                  ; $82DE: 90 06
        LDA a:$07FD                ; $82E0: AD FD 07
        JSR a:$830E                ; $82E3: 20 0E 83
L82E6:
        JSR a:$9C03                ; $82E6: 20 03 9C
        INC a:$075D                ; $82E9: EE 5D 07
        INC a:$0764                ; $82EC: EE 64 07
        INC a:$0757                ; $82EF: EE 57 07
        INC a:$0770                ; $82F2: EE 70 07
        LDA a:$07FC                ; $82F5: AD FC 07
        STA a:$076A                ; $82F8: 8D 6A 07
        LDA #$00                   ; $82FB: A9 00
        STA a:$0772                ; $82FD: 8D 72 07
        STA a:$07A2                ; $8300: 8D A2 07
        LDX #$17                   ; $8303: A2 17
        LDA #$00                   ; $8305: A9 00
L8307:
        STA a:$07DD,x              ; $8307: 9D DD 07
        DEX                        ; $830A: CA
        BPL L8307                  ; $830B: 10 FA
L830D:
        RTS                        ; $830D: 60
        STA a:$075F                ; $830E: 8D 5F 07
        STA a:$0766                ; $8311: 8D 66 07
        LDX #$00                   ; $8314: A2 00
        STX a:$0760                ; $8316: 8E 60 07
        STX a:$0767                ; $8319: 8E 67 07
        RTS                        ; $831C: 60
        .byte $07,$22,$49,$83,$CE,$24,$24,$00   ; $831D
        LDY #$07                   ; $8325: A0 07
L8327:
        LDA a:$831D,y              ; $8327: B9 1D 83
        STA a:$0300,y              ; $832A: 99 00 03
        DEY                        ; $832D: 88
        BPL L8327                  ; $832E: 10 F7
        LDA a:$077A                ; $8330: AD 7A 07
        BEQ L833F                  ; $8333: F0 0A
        LDA #$24                   ; $8335: A9 24
        STA a:$0304                ; $8337: 8D 04 03
        LDA #$CE                   ; $833A: A9 CE
        STA a:$0306                ; $833C: 8D 06 03
L833F:
        RTS                        ; $833F: 60
        .byte $01,$80,$02,$81,$41,$80,$01,$42,$C2,$02,$80,$41,$C1,$41,$C1,$01   ; $8340
        .byte $C1,$01,$02,$80,$00,$9B,$10,$18,$05,$2C,$20,$24,$15,$5A,$10,$20   ; $8350
        .byte $28,$30,$20,$10,$80,$20,$30,$30,$01,$FF,$00   ; $8360
        LDX a:$0717                ; $836B: AE 17 07
        LDA a:$0718                ; $836E: AD 18 07
        BNE L8380                  ; $8371: D0 0D
        INX                        ; $8373: E8
        INC a:$0717                ; $8374: EE 17 07
        SEC                        ; $8377: 38
        LDA a:$8354,x              ; $8378: BD 54 83
        STA a:$0718                ; $837B: 8D 18 07
        BEQ L838A                  ; $837E: F0 0A
L8380:
        LDA a:$833F,x              ; $8380: BD 3F 83
        STA a:$06FC                ; $8383: 8D FC 06
        DEC a:$0718                ; $8386: CE 18 07
        CLC                        ; $8389: 18
L838A:
        RTS                        ; $838A: 60
        JSR a:$83A0                ; $838B: 20 A0 83
        LDA a:$0772                ; $838E: AD 72 07
        BEQ L839A                  ; $8391: F0 07
        LDX #$00                   ; $8393: A2 00
        STX z:$08                  ; $8395: 86 08
        JSR a:$C047                ; $8397: 20 47 C0
L839A:
        JSR a:$F12A                ; $839A: 20 2A F1
        JMP a:$EEE9                ; $839D: 4C E9 EE
        LDA a:$0772                ; $83A0: AD 72 07
        JSR a:$8E04                ; $83A3: 20 04 8E
        .byte $EC,$CF,$B0,$83,$BD,$83,$F6,$83,$61,$84   ; $83A6
        LDX a:$071B                ; $83B0: AE 1B 07
        INX                        ; $83B3: E8
        STX z:$34                  ; $83B4: 86 34
        LDA #$08                   ; $83B6: A9 08
        STA z:$FC                  ; $83B8: 85 FC
        JMP a:$874E                ; $83BA: 4C 4E 87
        LDY #$00                   ; $83BD: A0 00
        STY z:$35                  ; $83BF: 84 35
        LDA z:$6D                  ; $83C1: A5 6D
        CMP z:$34                  ; $83C3: C5 34
        BNE L83CD                  ; $83C5: D0 06
        LDA z:$86                  ; $83C7: A5 86
        CMP #$60                   ; $83C9: C9 60
        BCS L83D0                  ; $83CB: B0 03
L83CD:
        INC z:$35                  ; $83CD: E6 35
        INY                        ; $83CF: C8
L83D0:
        TYA                        ; $83D0: 98
        JSR a:$B0E6                ; $83D1: 20 E6 B0
        LDA a:$071A                ; $83D4: AD 1A 07
        CMP z:$34                  ; $83D7: C5 34
        BEQ L83F1                  ; $83D9: F0 16
        LDA a:$0768                ; $83DB: AD 68 07
        CLC                        ; $83DE: 18
        ADC #$80                   ; $83DF: 69 80
        STA a:$0768                ; $83E1: 8D 68 07
        LDA #$01                   ; $83E4: A9 01
        ADC #$00                   ; $83E6: 69 00
        TAY                        ; $83E8: A8
        JSR a:$AFC4                ; $83E9: 20 C4 AF
        JSR a:$AF6F                ; $83EC: 20 6F AF
        INC z:$35                  ; $83EF: E6 35
L83F1:
        LDA z:$35                  ; $83F1: A5 35
        BEQ L845D                  ; $83F3: F0 68
        RTS                        ; $83F5: 60
        LDA a:$0749                ; $83F6: AD 49 07
        BNE L8443                  ; $83F9: D0 48
        LDA a:$0719                ; $83FB: AD 19 07
        BEQ L8418                  ; $83FE: F0 18
        CMP #$09                   ; $8400: C9 09
        BCS L8443                  ; $8402: B0 3F
        LDY a:$075F                ; $8404: AC 5F 07
        CPY #$07                   ; $8407: C0 07
        BNE L8414                  ; $8409: D0 09
        CMP #$03                   ; $840B: C9 03
        BCC L8443                  ; $840D: 90 34
        SBC #$01                   ; $840F: E9 01
        JMP a:$8418                ; $8411: 4C 18 84
L8414:
        CMP #$02                   ; $8414: C9 02
        BCC L8443                  ; $8416: 90 2B
L8418:
        TAY                        ; $8418: A8
        BNE L8423                  ; $8419: D0 08
        LDA a:$0753                ; $841B: AD 53 07
        BEQ L8434                  ; $841E: F0 14
        INY                        ; $8420: C8
        BNE L8434                  ; $8421: D0 11
L8423:
        INY                        ; $8423: C8
        LDA a:$075F                ; $8424: AD 5F 07
        CMP #$07                   ; $8427: C9 07
        BEQ L8434                  ; $8429: F0 09
        DEY                        ; $842B: 88
        CPY #$04                   ; $842C: C0 04
        BCS L8456                  ; $842E: B0 26
        CPY #$03                   ; $8430: C0 03
        BCS L8443                  ; $8432: B0 0F
L8434:
        CPY #$03                   ; $8434: C0 03
        BNE L843C                  ; $8436: D0 04
        LDA #$04                   ; $8438: A9 04
        STA z:$FC                  ; $843A: 85 FC
L843C:
        TYA                        ; $843C: 98
        CLC                        ; $843D: 18
        ADC #$0C                   ; $843E: 69 0C
        STA a:$0773                ; $8440: 8D 73 07
L8443:
        LDA a:$0749                ; $8443: AD 49 07
        CLC                        ; $8446: 18
        ADC #$04                   ; $8447: 69 04
        STA a:$0749                ; $8449: 8D 49 07
        LDA a:$0719                ; $844C: AD 19 07
        ADC #$00                   ; $844F: 69 00
        STA a:$0719                ; $8451: 8D 19 07
        CMP #$07                   ; $8454: C9 07
L8456:
        BCC L8460                  ; $8456: 90 08
        LDA #$06                   ; $8458: A9 06
        STA a:$07A1                ; $845A: 8D A1 07
L845D:
        INC a:$0772                ; $845D: EE 72 07
L8460:
        RTS                        ; $8460: 60
        LDA a:$07A1                ; $8461: AD A1 07
        BNE L8486                  ; $8464: D0 20
        LDY a:$075F                ; $8466: AC 5F 07
        CPY #$07                   ; $8469: C0 07
        BCS L8487                  ; $846B: B0 1A
        LDA #$00                   ; $846D: A9 00
        STA a:$0760                ; $846F: 8D 60 07
        STA a:$075C                ; $8472: 8D 5C 07
        STA a:$0772                ; $8475: 8D 72 07
        INC a:$075F                ; $8478: EE 5F 07
        JSR a:$9C03                ; $847B: 20 03 9C
        INC a:$0757                ; $847E: EE 57 07
        LDA #$01                   ; $8481: A9 01
        STA a:$0770                ; $8483: 8D 70 07
L8486:
        RTS                        ; $8486: 60
L8487:
        LDA a:$06FC                ; $8487: AD FC 06
        ORA a:$06FD                ; $848A: 0D FD 06
        AND #$40                   ; $848D: 29 40
        BEQ L849E                  ; $848F: F0 0D
        LDA #$01                   ; $8491: A9 01
        STA a:$07FC                ; $8493: 8D FC 07
        LDA #$FF                   ; $8496: A9 FF
        STA a:$075A                ; $8498: 8D 5A 07
        JSR a:$9248                ; $849B: 20 48 92
L849E:
        RTS                        ; $849E: 60
        .byte $FF,$FF,$F6,$FB,$F7,$FB,$F8,$FB,$F9,$FB,$FA,$FB,$F6,$50,$F7,$50   ; $849F
        .byte $F8,$50,$F9,$50,$FA,$50,$FD,$FE,$FF,$41,$42,$44,$45,$48,$31,$32   ; $84AF
        .byte $34,$35,$38,$00   ; $84BF
        LDA a:$0110,x              ; $84C3: BD 10 01
        BEQ L8486                  ; $84C6: F0 BE
        CMP #$0B                   ; $84C8: C9 0B
        BCC L84D1                  ; $84CA: 90 05
        LDA #$0B                   ; $84CC: A9 0B
        STA a:$0110,x              ; $84CE: 9D 10 01
L84D1:
        TAY                        ; $84D1: A8
        LDA a:$012C,x              ; $84D2: BD 2C 01
        BNE L84DB                  ; $84D5: D0 04
        STA a:$0110,x              ; $84D7: 9D 10 01
        RTS                        ; $84DA: 60
L84DB:
        DEC a:$012C,x              ; $84DB: DE 2C 01
        CMP #$2B                   ; $84DE: C9 2B
        BNE L8500                  ; $84E0: D0 1E
        CPY #$0B                   ; $84E2: C0 0B
        BNE L84ED                  ; $84E4: D0 07
        INC a:$075A                ; $84E6: EE 5A 07
        LDA #$40                   ; $84E9: A9 40
        STA z:$FE                  ; $84EB: 85 FE
L84ED:
        LDA a:$84B7,y              ; $84ED: B9 B7 84
        LSR a                      ; $84F0: 4A
        LSR a                      ; $84F1: 4A
        LSR a                      ; $84F2: 4A
        LSR a                      ; $84F3: 4A
        TAX                        ; $84F4: AA
        LDA a:$84B7,y              ; $84F5: B9 B7 84
        AND #$0F                   ; $84F8: 29 0F
        STA a:$0134,x              ; $84FA: 9D 34 01
        JSR a:$BC27                ; $84FD: 20 27 BC
L8500:
        LDY a:$06E5,x              ; $8500: BC E5 06
        LDA z:$16,x                ; $8503: B5 16
        CMP #$12                   ; $8505: C9 12
        BEQ L852B                  ; $8507: F0 22
        CMP #$0D                   ; $8509: C9 0D
        BEQ L852B                  ; $850B: F0 1E
        CMP #$05                   ; $850D: C9 05
        BEQ L8523                  ; $850F: F0 12
        CMP #$0A                   ; $8511: C9 0A
        BEQ L852B                  ; $8513: F0 16
        CMP #$0B                   ; $8515: C9 0B
        BEQ L852B                  ; $8517: F0 12
        CMP #$09                   ; $8519: C9 09
        BCS L8523                  ; $851B: B0 06
        LDA z:$1E,x                ; $851D: B5 1E
        CMP #$02                   ; $851F: C9 02
        BCS L852B                  ; $8521: B0 08
L8523:
        LDX a:$03EE                ; $8523: AE EE 03
        LDY a:$06EC,x              ; $8526: BC EC 06
        LDX z:$08                  ; $8529: A6 08
L852B:
        LDA a:$011E,x              ; $852B: BD 1E 01
        CMP #$18                   ; $852E: C9 18
        BCC L8537                  ; $8530: 90 05
        SBC #$01                   ; $8532: E9 01
        STA a:$011E,x              ; $8534: 9D 1E 01
L8537:
        LDA a:$011E,x              ; $8537: BD 1E 01
        SBC #$08                   ; $853A: E9 08
        JSR a:$E5C1                ; $853C: 20 C1 E5
        LDA a:$0117,x              ; $853F: BD 17 01
        STA a:$0203,y              ; $8542: 99 03 02
        CLC                        ; $8545: 18
        ADC #$08                   ; $8546: 69 08
        STA a:$0207,y              ; $8548: 99 07 02
        LDA #$02                   ; $854B: A9 02
        STA a:$0202,y              ; $854D: 99 02 02
        STA a:$0206,y              ; $8550: 99 06 02
        LDA a:$0110,x              ; $8553: BD 10 01
        ASL a                      ; $8556: 0A
        TAX                        ; $8557: AA
        LDA a:$849F,x              ; $8558: BD 9F 84
        STA a:$0201,y              ; $855B: 99 01 02
        LDA a:$84A0,x              ; $855E: BD A0 84
        STA a:$0205,y              ; $8561: 99 05 02
        LDX z:$08                  ; $8564: A6 08
        RTS                        ; $8566: 60
        LDA a:$073C                ; $8567: AD 3C 07
        JSR a:$8E04                ; $856A: 20 04 8E
        .byte $8B,$85,$9B,$85,$52,$86,$5A,$86,$93,$86,$9D,$88,$A8,$86,$9D,$88   ; $856D
        .byte $E6,$86,$BF,$85,$E3,$85,$43,$86,$FF,$86,$32,$87,$49,$87   ; $857D
        JSR a:$8220                ; $858B: 20 20 82
        JSR a:$8E19                ; $858E: 20 19 8E
        LDA a:$0770                ; $8591: AD 70 07
        BEQ L85C8                  ; $8594: F0 32
        LDX #$03                   ; $8596: A2 03
        JMP a:$85C5                ; $8598: 4C C5 85
        LDA a:$0744                ; $859B: AD 44 07
        PHA                        ; $859E: 48
        LDA a:$0756                ; $859F: AD 56 07
        PHA                        ; $85A2: 48
        LDA #$00                   ; $85A3: A9 00
        STA a:$0756                ; $85A5: 8D 56 07
        LDA #$02                   ; $85A8: A9 02
        STA a:$0744                ; $85AA: 8D 44 07
        JSR a:$85F1                ; $85AD: 20 F1 85
        PLA                        ; $85B0: 68
        STA a:$0756                ; $85B1: 8D 56 07
        PLA                        ; $85B4: 68
        STA a:$0744                ; $85B5: 8D 44 07
        JMP a:$8745                ; $85B8: 4C 45 87
        .byte $01,$02,$03,$04   ; $85BB
        LDY a:$074E                ; $85BF: AC 4E 07
        LDX a:$85BB,y              ; $85C2: BE BB 85
        STX a:$0773                ; $85C5: 8E 73 07
L85C8:
        JMP a:$8745                ; $85C8: 4C 45 87
        .byte $00,$09,$0A,$04,$22,$22,$0F,$0F,$0F,$22,$0F,$0F,$22,$16,$27,$18   ; $85CB
        .byte $22,$30,$27,$19,$22,$37,$27,$16   ; $85DB
        LDY a:$0744                ; $85E3: AC 44 07
        BEQ L85EE                  ; $85E6: F0 06
        LDA a:$85C7,y              ; $85E8: B9 C7 85
        STA a:$0773                ; $85EB: 8D 73 07
L85EE:
        INC a:$073C                ; $85EE: EE 3C 07
        LDX a:$0300                ; $85F1: AE 00 03
        LDY #$00                   ; $85F4: A0 00
        LDA a:$0753                ; $85F6: AD 53 07
        BEQ L85FD                  ; $85F9: F0 02
        LDY #$04                   ; $85FB: A0 04
L85FD:
        LDA a:$0756                ; $85FD: AD 56 07
        CMP #$02                   ; $8600: C9 02
        BNE L8606                  ; $8602: D0 02
        LDY #$08                   ; $8604: A0 08
L8606:
        LDA #$03                   ; $8606: A9 03
        STA z:$00                  ; $8608: 85 00
L860A:
        LDA a:$85D7,y              ; $860A: B9 D7 85
        STA a:$0304,x              ; $860D: 9D 04 03
        INY                        ; $8610: C8
        INX                        ; $8611: E8
        DEC z:$00                  ; $8612: C6 00
        BPL L860A                  ; $8614: 10 F4
        LDX a:$0300                ; $8616: AE 00 03
        LDY a:$0744                ; $8619: AC 44 07
        BNE L8621                  ; $861C: D0 03
        LDY a:$074E                ; $861E: AC 4E 07
L8621:
        LDA a:$85CF,y              ; $8621: B9 CF 85
        STA a:$0304,x              ; $8624: 9D 04 03
        LDA #$3F                   ; $8627: A9 3F
        STA a:$0301,x              ; $8629: 9D 01 03
        LDA #$10                   ; $862C: A9 10
        STA a:$0302,x              ; $862E: 9D 02 03
        LDA #$04                   ; $8631: A9 04
        STA a:$0303,x              ; $8633: 9D 03 03
        LDA #$00                   ; $8636: A9 00
        STA a:$0308,x              ; $8638: 9D 08 03
        TXA                        ; $863B: 8A
        CLC                        ; $863C: 18
        ADC #$07                   ; $863D: 69 07
        STA a:$0300                ; $863F: 8D 00 03
        RTS                        ; $8642: 60
        LDA a:$0733                ; $8643: AD 33 07
        CMP #$01                   ; $8646: C9 01
        BNE L864F                  ; $8648: D0 05
        LDA #$0B                   ; $864A: A9 0B
        STA a:$0773                ; $864C: 8D 73 07
L864F:
        JMP a:$8745                ; $864F: 4C 45 87
        LDA #$00                   ; $8652: A9 00
        JSR a:$8808                ; $8654: 20 08 88
        JMP a:$8745                ; $8657: 4C 45 87
        JSR a:$BC30                ; $865A: 20 30 BC
        LDX a:$0300                ; $865D: AE 00 03
        LDA #$20                   ; $8660: A9 20
        STA a:$0301,x              ; $8662: 9D 01 03
        LDA #$73                   ; $8665: A9 73
        STA a:$0302,x              ; $8667: 9D 02 03
        LDA #$03                   ; $866A: A9 03
        STA a:$0303,x              ; $866C: 9D 03 03
        LDY a:$075F                ; $866F: AC 5F 07
        INY                        ; $8672: C8
        TYA                        ; $8673: 98
        STA a:$0304,x              ; $8674: 9D 04 03
        LDA #$28                   ; $8677: A9 28
        STA a:$0305,x              ; $8679: 9D 05 03
        LDY a:$075C                ; $867C: AC 5C 07
        INY                        ; $867F: C8
        TYA                        ; $8680: 98
        STA a:$0306,x              ; $8681: 9D 06 03
        LDA #$00                   ; $8684: A9 00
        STA a:$0307,x              ; $8686: 9D 07 03
        TXA                        ; $8689: 8A
        CLC                        ; $868A: 18
        ADC #$06                   ; $868B: 69 06
        STA a:$0300                ; $868D: 8D 00 03
        JMP a:$8745                ; $8690: 4C 45 87
        LDA a:$0759                ; $8693: AD 59 07
        BEQ L86A2                  ; $8696: F0 0A
        LDA #$00                   ; $8698: A9 00
        STA a:$0759                ; $869A: 8D 59 07
        LDA #$02                   ; $869D: A9 02
        JMP a:$86C7                ; $869F: 4C C7 86
L86A2:
        INC a:$073C                ; $86A2: EE 3C 07
        JMP a:$8745                ; $86A5: 4C 45 87
        LDA a:$0770                ; $86A8: AD 70 07
        BEQ L86E0                  ; $86AB: F0 33
        CMP #$03                   ; $86AD: C9 03
        BEQ L86D3                  ; $86AF: F0 22
        LDA a:$0752                ; $86B1: AD 52 07
        BNE L86E0                  ; $86B4: D0 2A
        LDY a:$074E                ; $86B6: AC 4E 07
        CPY #$03                   ; $86B9: C0 03
        BEQ L86C2                  ; $86BB: F0 05
        LDA a:$0769                ; $86BD: AD 69 07
        BNE L86E0                  ; $86C0: D0 1E
L86C2:
        JSR a:$EFA4                ; $86C2: 20 A4 EF
        LDA #$01                   ; $86C5: A9 01
        JSR a:$8808                ; $86C7: 20 08 88
        JSR a:$88A5                ; $86CA: 20 A5 88
        LDA #$00                   ; $86CD: A9 00
        STA a:$0774                ; $86CF: 8D 74 07
        RTS                        ; $86D2: 60
L86D3:
        LDA #$12                   ; $86D3: A9 12
        STA a:$07A0                ; $86D5: 8D A0 07
        LDA #$03                   ; $86D8: A9 03
        JSR a:$8808                ; $86DA: 20 08 88
        JMP a:$874E                ; $86DD: 4C 4E 87
L86E0:
        LDA #$08                   ; $86E0: A9 08
        STA a:$073C                ; $86E2: 8D 3C 07
        RTS                        ; $86E5: 60
        INC a:$0774                ; $86E6: EE 74 07
L86E9:
        JSR a:$92B0                ; $86E9: 20 B0 92
        LDA a:$071F                ; $86EC: AD 1F 07
        BNE L86E9                  ; $86EF: D0 F8
        DEC a:$071E                ; $86F1: CE 1E 07
        BPL L86F9                  ; $86F4: 10 03
        INC a:$073C                ; $86F6: EE 3C 07
L86F9:
        LDA #$06                   ; $86F9: A9 06
        STA a:$0773                ; $86FB: 8D 73 07
        RTS                        ; $86FE: 60
        LDA a:$0770                ; $86FF: AD 70 07
        BNE L874E                  ; $8702: D0 4A
        LDA #$1E                   ; $8704: A9 1E
        STA a:$2006                ; $8706: 8D 06 20
        LDA #$C0                   ; $8709: A9 C0
        STA a:$2006                ; $870B: 8D 06 20
        LDA #$03                   ; $870E: A9 03
        STA z:$01                  ; $8710: 85 01
        LDY #$00                   ; $8712: A0 00
        STY z:$00                  ; $8714: 84 00
        LDA a:$2007                ; $8716: AD 07 20
L8719:
        LDA a:$2007                ; $8719: AD 07 20
        STA ($00),y                ; $871C: 91 00
        INY                        ; $871E: C8
        BNE L8723                  ; $871F: D0 02
        INC z:$01                  ; $8721: E6 01
L8723:
        LDA z:$01                  ; $8723: A5 01
        CMP #$04                   ; $8725: C9 04
        BNE L8719                  ; $8727: D0 F0
        CPY #$3A                   ; $8729: C0 3A
        BCC L8719                  ; $872B: 90 EC
        LDA #$05                   ; $872D: A9 05
        JMP a:$864C                ; $872F: 4C 4C 86
        LDA a:$0770                ; $8732: AD 70 07
        BNE L874E                  ; $8735: D0 17
        LDX #$00                   ; $8737: A2 00
L8739:
        STA a:$0300,x              ; $8739: 9D 00 03
        STA a:$0400,x              ; $873C: 9D 00 04
        DEX                        ; $873F: CA
        BNE L8739                  ; $8740: D0 F7
        JSR a:$8325                ; $8742: 20 25 83
        INC a:$073C                ; $8745: EE 3C 07
        RTS                        ; $8748: 60
        LDA #$FA                   ; $8749: A9 FA
        JSR a:$BC36                ; $874B: 20 36 BC
L874E:
        INC a:$0772                ; $874E: EE 72 07
        RTS                        ; $8751: 60
        .byte $20,$43,$05,$16,$0A,$1B,$12,$18,$20,$52,$0B,$20,$18,$1B,$15,$0D   ; $8752
        .byte $24,$24,$1D,$12,$16,$0E,$20,$68,$05,$00,$24,$24,$2E,$29,$23,$C0   ; $8762
        .byte $7F,$AA,$23,$C2,$01,$EA,$FF,$21,$CD,$07,$24,$24,$29,$24,$24,$24   ; $8772
        .byte $24,$21,$4B,$09,$20,$18,$1B,$15,$0D,$24,$24,$28,$24,$22,$0C,$47   ; $8782
        .byte $24,$23,$DC,$01,$BA,$FF,$21,$CD,$05,$16,$0A,$1B,$12,$18,$22,$0C   ; $8792
        .byte $07,$1D,$12,$16,$0E,$24,$1E,$19,$FF,$21,$CD,$05,$16,$0A,$1B,$12   ; $87A2
        .byte $18,$22,$0B,$09,$10,$0A,$16,$0E,$24,$18,$1F,$0E,$1B,$FF,$25,$84   ; $87B2
        .byte $15,$20,$0E,$15,$0C,$18,$16,$0E,$24,$1D,$18,$24,$20,$0A,$1B,$19   ; $87C2
        .byte $24,$23,$18,$17,$0E,$2B,$26,$25,$01,$24,$26,$2D,$01,$24,$26,$35   ; $87D2
        .byte $01,$24,$27,$D9,$46,$AA,$27,$E1,$45,$AA,$FF,$15,$1E,$12,$10,$12   ; $87E2
        .byte $04,$03,$02,$00,$24,$05,$24,$00,$08,$07,$06,$00,$00,$00,$27,$27   ; $87F2
        .byte $46,$4E   ; $8802
        EOR a:$6E61,y              ; $8804: 59 61 6E
        .byte $6E   ; $8807
        PHA                        ; $8808: 48
        ASL a                      ; $8809: 0A
        TAY                        ; $880A: A8
        CPY #$04                   ; $880B: C0 04
        BCC L881B                  ; $880D: 90 0C
        CPY #$08                   ; $880F: C0 08
        BCC L8815                  ; $8811: 90 02
        LDY #$08                   ; $8813: A0 08
L8815:
        LDA a:$077A                ; $8815: AD 7A 07
        BNE L881B                  ; $8818: D0 01
        INY                        ; $881A: C8
L881B:
        LDX a:$87FE,y              ; $881B: BE FE 87
        LDY #$00                   ; $881E: A0 00
L8820:
        LDA a:$8752,x              ; $8820: BD 52 87
        CMP #$FF                   ; $8823: C9 FF
        BEQ L882E                  ; $8825: F0 07
        STA a:$0301,y              ; $8827: 99 01 03
        INX                        ; $882A: E8
        INY                        ; $882B: C8
        BNE L8820                  ; $882C: D0 F2
L882E:
        LDA #$00                   ; $882E: A9 00
        STA a:$0301,y              ; $8830: 99 01 03
        PLA                        ; $8833: 68
        TAX                        ; $8834: AA
        CMP #$04                   ; $8835: C9 04
        BCS L8882                  ; $8837: B0 49
        DEX                        ; $8839: CA
        BNE L885F                  ; $883A: D0 23
        LDA a:$075A                ; $883C: AD 5A 07
        CLC                        ; $883F: 18
        ADC #$01                   ; $8840: 69 01
        CMP #$0A                   ; $8842: C9 0A
        BCC L884D                  ; $8844: 90 07
        SBC #$0A                   ; $8846: E9 0A
        LDY #$9F                   ; $8848: A0 9F
        STY a:$0308                ; $884A: 8C 08 03
L884D:
        STA a:$0309                ; $884D: 8D 09 03
        LDY a:$075F                ; $8850: AC 5F 07
        INY                        ; $8853: C8
        STY a:$0314                ; $8854: 8C 14 03
        LDY a:$075C                ; $8857: AC 5C 07
        INY                        ; $885A: C8
        STY a:$0316                ; $885B: 8C 16 03
        RTS                        ; $885E: 60
L885F:
        LDA a:$077A                ; $885F: AD 7A 07
        BEQ L8881                  ; $8862: F0 1D
        LDA a:$0753                ; $8864: AD 53 07
        DEX                        ; $8867: CA
        BNE L8873                  ; $8868: D0 09
        LDY a:$0770                ; $886A: AC 70 07
        CPY #$03                   ; $886D: C0 03
        BEQ L8873                  ; $886F: F0 02
        EOR #$01                   ; $8871: 49 01
L8873:
        LSR a                      ; $8873: 4A
        BCC L8881                  ; $8874: 90 0B
        LDY #$04                   ; $8876: A0 04
L8878:
        LDA a:$87ED,y              ; $8878: B9 ED 87
        STA a:$0304,y              ; $887B: 99 04 03
        DEY                        ; $887E: 88
        BPL L8878                  ; $887F: 10 F7
L8881:
        RTS                        ; $8881: 60
L8882:
        SBC #$04                   ; $8882: E9 04
        ASL a                      ; $8884: 0A
        ASL a                      ; $8885: 0A
        TAX                        ; $8886: AA
        LDY #$00                   ; $8887: A0 00
L8889:
        LDA a:$87F2,x              ; $8889: BD F2 87
        STA a:$031C,y              ; $888C: 99 1C 03
        INX                        ; $888F: E8
        INY                        ; $8890: C8
        INY                        ; $8891: C8
        INY                        ; $8892: C8
        INY                        ; $8893: C8
        CPY #$0C                   ; $8894: C0 0C
        BCC L8889                  ; $8896: 90 F1
        LDA #$2C                   ; $8898: A9 2C
        JMP a:$863F                ; $889A: 4C 3F 86
        LDA a:$07A0                ; $889D: AD A0 07
        BNE L88AD                  ; $88A0: D0 0B
        JSR a:$8220                ; $88A2: 20 20 82
        LDA #$07                   ; $88A5: A9 07
        STA a:$07A0                ; $88A7: 8D A0 07
        INC a:$073C                ; $88AA: EE 3C 07
L88AD:
        RTS                        ; $88AD: 60
        LDA a:$0726                ; $88AE: AD 26 07
        AND #$01                   ; $88B1: 29 01
        STA z:$05                  ; $88B3: 85 05
        LDY a:$0340                ; $88B5: AC 40 03
        STY z:$00                  ; $88B8: 84 00
        LDA a:$0721                ; $88BA: AD 21 07
        STA a:$0342,y              ; $88BD: 99 42 03
        LDA a:$0720                ; $88C0: AD 20 07
        STA a:$0341,y              ; $88C3: 99 41 03
        LDA #$9A                   ; $88C6: A9 9A
        STA a:$0343,y              ; $88C8: 99 43 03
        LDA #$00                   ; $88CB: A9 00
        STA z:$04                  ; $88CD: 85 04
        TAX                        ; $88CF: AA
L88D0:
        STX z:$01                  ; $88D0: 86 01
        LDA a:$06A1,x              ; $88D2: BD A1 06
        AND #$C0                   ; $88D5: 29 C0
        STA z:$03                  ; $88D7: 85 03
        ASL a                      ; $88D9: 0A
        ROL a                      ; $88DA: 2A
        ROL a                      ; $88DB: 2A
        TAY                        ; $88DC: A8
        LDA a:$8B08,y              ; $88DD: B9 08 8B
        STA z:$06                  ; $88E0: 85 06
        LDA a:$8B0C,y              ; $88E2: B9 0C 8B
        STA z:$07                  ; $88E5: 85 07
        LDA a:$06A1,x              ; $88E7: BD A1 06
        ASL a                      ; $88EA: 0A
        ASL a                      ; $88EB: 0A
        STA z:$02                  ; $88EC: 85 02
        LDA a:$071F                ; $88EE: AD 1F 07
        AND #$01                   ; $88F1: 29 01
        EOR #$01                   ; $88F3: 49 01
        ASL a                      ; $88F5: 0A
        ADC z:$02                  ; $88F6: 65 02
        TAY                        ; $88F8: A8
        LDX z:$00                  ; $88F9: A6 00
        LDA ($06),y                ; $88FB: B1 06
        STA a:$0344,x              ; $88FD: 9D 44 03
        INY                        ; $8900: C8
        LDA ($06),y                ; $8901: B1 06
        STA a:$0345,x              ; $8903: 9D 45 03
        LDY z:$04                  ; $8906: A4 04
        LDA z:$05                  ; $8908: A5 05
        BNE L891A                  ; $890A: D0 0E
        LDA z:$01                  ; $890C: A5 01
        LSR a                      ; $890E: 4A
        BCS L892A                  ; $890F: B0 19
        ROL z:$03                  ; $8911: 26 03
        ROL z:$03                  ; $8913: 26 03
        ROL z:$03                  ; $8915: 26 03
        JMP a:$8930                ; $8917: 4C 30 89
L891A:
        LDA z:$01                  ; $891A: A5 01
        LSR a                      ; $891C: 4A
        BCS L892E                  ; $891D: B0 0F
        LSR z:$03                  ; $891F: 46 03
        LSR z:$03                  ; $8921: 46 03
        LSR z:$03                  ; $8923: 46 03
        LSR z:$03                  ; $8925: 46 03
        JMP a:$8930                ; $8927: 4C 30 89
L892A:
        LSR z:$03                  ; $892A: 46 03
        LSR z:$03                  ; $892C: 46 03
L892E:
        INC z:$04                  ; $892E: E6 04
        LDA a:$03F9,y              ; $8930: B9 F9 03
        ORA z:$03                  ; $8933: 05 03
        STA a:$03F9,y              ; $8935: 99 F9 03
        INC z:$00                  ; $8938: E6 00
        INC z:$00                  ; $893A: E6 00
        LDX z:$01                  ; $893C: A6 01
        INX                        ; $893E: E8
        CPX #$0D                   ; $893F: E0 0D
        BCC L88D0                  ; $8941: 90 8D
        LDY z:$00                  ; $8943: A4 00
        INY                        ; $8945: C8
        INY                        ; $8946: C8
        INY                        ; $8947: C8
        LDA #$00                   ; $8948: A9 00
        STA a:$0341,y              ; $894A: 99 41 03
        STY a:$0340                ; $894D: 8C 40 03
        INC a:$0721                ; $8950: EE 21 07
        LDA a:$0721                ; $8953: AD 21 07
        AND #$1F                   ; $8956: 29 1F
        BNE L8967                  ; $8958: D0 0D
        LDA #$80                   ; $895A: A9 80
        STA a:$0721                ; $895C: 8D 21 07
        LDA a:$0720                ; $895F: AD 20 07
        EOR #$04                   ; $8962: 49 04
        STA a:$0720                ; $8964: 8D 20 07
L8967:
        JMP a:$89BD                ; $8967: 4C BD 89
        LDA a:$0721                ; $896A: AD 21 07
        AND #$1F                   ; $896D: 29 1F
        SEC                        ; $896F: 38
        SBC #$04                   ; $8970: E9 04
        AND #$1F                   ; $8972: 29 1F
        STA z:$01                  ; $8974: 85 01
        LDA a:$0720                ; $8976: AD 20 07
        BCS L897D                  ; $8979: B0 02
        EOR #$04                   ; $897B: 49 04
L897D:
        AND #$04                   ; $897D: 29 04
        ORA #$23                   ; $897F: 09 23
        STA z:$00                  ; $8981: 85 00
        LDA z:$01                  ; $8983: A5 01
        LSR a                      ; $8985: 4A
        LSR a                      ; $8986: 4A
        ADC #$C0                   ; $8987: 69 C0
        STA z:$01                  ; $8989: 85 01
        LDX #$00                   ; $898B: A2 00
        LDY a:$0340                ; $898D: AC 40 03
L8990:
        LDA z:$00                  ; $8990: A5 00
        STA a:$0341,y              ; $8992: 99 41 03
        LDA z:$01                  ; $8995: A5 01
        CLC                        ; $8997: 18
        ADC #$08                   ; $8998: 69 08
        STA a:$0342,y              ; $899A: 99 42 03
        STA z:$01                  ; $899D: 85 01
        LDA a:$03F9,x              ; $899F: BD F9 03
        STA a:$0344,y              ; $89A2: 99 44 03
        LDA #$01                   ; $89A5: A9 01
        STA a:$0343,y              ; $89A7: 99 43 03
        LSR a                      ; $89AA: 4A
        STA a:$03F9,x              ; $89AB: 9D F9 03
        INY                        ; $89AE: C8
        INY                        ; $89AF: C8
        INY                        ; $89B0: C8
        INY                        ; $89B1: C8
        INX                        ; $89B2: E8
        CPX #$07                   ; $89B3: E0 07
        BCC L8990                  ; $89B5: 90 D9
        STA a:$0341,y              ; $89B7: 99 41 03
        STY a:$0340                ; $89BA: 8C 40 03
        LDA #$06                   ; $89BD: A9 06
        STA a:$0773                ; $89BF: 8D 73 07
        RTS                        ; $89C2: 60
        .byte $27,$27,$27,$17,$07,$17,$3F,$0C,$04,$FF,$FF,$FF,$FF,$00,$0F,$07   ; $89C3
        .byte $12,$0F,$0F,$07,$17,$0F,$0F,$07,$17,$1C,$0F,$07,$17,$00   ; $89D3
        LDA z:$09                  ; $89E1: A5 09
        AND #$07                   ; $89E3: 29 07
        BNE L8A38                  ; $89E5: D0 51
        LDX a:$0300                ; $89E7: AE 00 03
        CPX #$31                   ; $89EA: E0 31
        BCS L8A38                  ; $89EC: B0 4A
        TAY                        ; $89EE: A8
L89EF:
        LDA a:$89C9,y              ; $89EF: B9 C9 89
        STA a:$0301,x              ; $89F2: 9D 01 03
        INX                        ; $89F5: E8
        INY                        ; $89F6: C8
        CPY #$08                   ; $89F7: C0 08
        BCC L89EF                  ; $89F9: 90 F4
        LDX a:$0300                ; $89FB: AE 00 03
        LDA #$03                   ; $89FE: A9 03
        STA z:$00                  ; $8A00: 85 00
        LDA a:$074E                ; $8A02: AD 4E 07
        ASL a                      ; $8A05: 0A
        ASL a                      ; $8A06: 0A
        TAY                        ; $8A07: A8
L8A08:
        LDA a:$89D1,y              ; $8A08: B9 D1 89
        STA a:$0304,x              ; $8A0B: 9D 04 03
        INY                        ; $8A0E: C8
        INX                        ; $8A0F: E8
        DEC z:$00                  ; $8A10: C6 00
        BPL L8A08                  ; $8A12: 10 F4
        LDX a:$0300                ; $8A14: AE 00 03
        LDY a:$06D4                ; $8A17: AC D4 06
        LDA a:$89C3,y              ; $8A1A: B9 C3 89
        STA a:$0305,x              ; $8A1D: 9D 05 03
        LDA a:$0300                ; $8A20: AD 00 03
        CLC                        ; $8A23: 18
        ADC #$07                   ; $8A24: 69 07
        STA a:$0300                ; $8A26: 8D 00 03
        INC a:$06D4                ; $8A29: EE D4 06
        LDA a:$06D4                ; $8A2C: AD D4 06
        CMP #$06                   ; $8A2F: C9 06
        BCC L8A38                  ; $8A31: 90 05
        LDA #$00                   ; $8A33: A9 00
        STA a:$06D4                ; $8A35: 8D D4 06
L8A38:
        RTS                        ; $8A38: 60
        .byte $45,$45,$47,$47,$47,$47,$47,$47,$57,$58,$59,$5A,$24,$24,$24,$24   ; $8A39
        .byte $26,$26,$26,$26   ; $8A49
        LDY #$41                   ; $8A4D: A0 41
        LDA #$03                   ; $8A4F: A9 03
        LDX a:$074E                ; $8A51: AE 4E 07
        BNE L8A58                  ; $8A54: D0 02
        LDA #$04                   ; $8A56: A9 04
L8A58:
        JSR a:$8A97                ; $8A58: 20 97 8A
        LDA #$06                   ; $8A5B: A9 06
        STA a:$0773                ; $8A5D: 8D 73 07
        RTS                        ; $8A60: 60
        JSR a:$8A6D                ; $8A61: 20 6D 8A
        INC a:$03F0                ; $8A64: EE F0 03
        DEC a:$03EC,x              ; $8A67: DE EC 03
        RTS                        ; $8A6A: 60
        LDA #$00                   ; $8A6B: A9 00
        LDY #$03                   ; $8A6D: A0 03
        CMP #$00                   ; $8A6F: C9 00
        BEQ L8A87                  ; $8A71: F0 14
        LDY #$00                   ; $8A73: A0 00
        CMP #$58                   ; $8A75: C9 58
        BEQ L8A87                  ; $8A77: F0 0E
        CMP #$51                   ; $8A79: C9 51
        BEQ L8A87                  ; $8A7B: F0 0A
        INY                        ; $8A7D: C8
        CMP #$5D                   ; $8A7E: C9 5D
        BEQ L8A87                  ; $8A80: F0 05
        CMP #$52                   ; $8A82: C9 52
        BEQ L8A87                  ; $8A84: F0 01
        INY                        ; $8A86: C8
L8A87:
        TYA                        ; $8A87: 98
        LDY a:$0300                ; $8A88: AC 00 03
        INY                        ; $8A8B: C8
        JSR a:$8A97                ; $8A8C: 20 97 8A
        DEY                        ; $8A8F: 88
        TYA                        ; $8A90: 98
        CLC                        ; $8A91: 18
        ADC #$0A                   ; $8A92: 69 0A
        JMP a:$863F                ; $8A94: 4C 3F 86
        STX z:$00                  ; $8A97: 86 00
        STY z:$01                  ; $8A99: 84 01
        ASL a                      ; $8A9B: 0A
        ASL a                      ; $8A9C: 0A
        TAX                        ; $8A9D: AA
        LDY #$20                   ; $8A9E: A0 20
        LDA z:$06                  ; $8AA0: A5 06
        CMP #$D0                   ; $8AA2: C9 D0
        BCC L8AA8                  ; $8AA4: 90 02
        LDY #$24                   ; $8AA6: A0 24
L8AA8:
        STY z:$03                  ; $8AA8: 84 03
        AND #$0F                   ; $8AAA: 29 0F
        ASL a                      ; $8AAC: 0A
        STA z:$04                  ; $8AAD: 85 04
        LDA #$00                   ; $8AAF: A9 00
        STA z:$05                  ; $8AB1: 85 05
        LDA z:$02                  ; $8AB3: A5 02
        CLC                        ; $8AB5: 18
        ADC #$20                   ; $8AB6: 69 20
        ASL a                      ; $8AB8: 0A
        ROL z:$05                  ; $8AB9: 26 05
        ASL a                      ; $8ABB: 0A
        ROL z:$05                  ; $8ABC: 26 05
        ADC z:$04                  ; $8ABE: 65 04
        STA z:$04                  ; $8AC0: 85 04
        LDA z:$05                  ; $8AC2: A5 05
        ADC #$00                   ; $8AC4: 69 00
        CLC                        ; $8AC6: 18
        ADC z:$03                  ; $8AC7: 65 03
        STA z:$05                  ; $8AC9: 85 05
        LDY z:$01                  ; $8ACB: A4 01
        LDA a:$8A39,x              ; $8ACD: BD 39 8A
        STA a:$0303,y              ; $8AD0: 99 03 03
        LDA a:$8A3A,x              ; $8AD3: BD 3A 8A
        STA a:$0304,y              ; $8AD6: 99 04 03
        LDA a:$8A3B,x              ; $8AD9: BD 3B 8A
        STA a:$0308,y              ; $8ADC: 99 08 03
        LDA a:$8A3C,x              ; $8ADF: BD 3C 8A
        STA a:$0309,y              ; $8AE2: 99 09 03
        LDA z:$04                  ; $8AE5: A5 04
        STA a:$0301,y              ; $8AE7: 99 01 03
        CLC                        ; $8AEA: 18
        ADC #$20                   ; $8AEB: 69 20
        STA a:$0306,y              ; $8AED: 99 06 03
        LDA z:$05                  ; $8AF0: A5 05
        STA a:$0300,y              ; $8AF2: 99 00 03
        STA a:$0305,y              ; $8AF5: 99 05 03
        LDA #$02                   ; $8AF8: A9 02
        STA a:$0302,y              ; $8AFA: 99 02 03
        STA a:$0307,y              ; $8AFD: 99 07 03
        LDA #$00                   ; $8B00: A9 00
        STA a:$030A,y              ; $8B02: 99 0A 03
        LDX z:$00                  ; $8B05: A6 00
        RTS                        ; $8B07: 60
        .byte $10,$AC,$64,$8C,$8B,$8B,$8C,$8C,$24,$24,$24,$24,$27,$27,$27,$27   ; $8B08
        .byte $24,$24,$24,$35,$36,$25,$37,$25,$24,$38,$24,$24,$24,$30,$30,$26   ; $8B18
        .byte $26,$26,$34,$26,$24,$31,$24,$32,$33,$26,$24,$33,$34,$26,$26,$26   ; $8B28
        .byte $26,$26,$26,$26,$24,$C0,$24,$C0,$24,$7F,$7F,$24,$B8,$BA,$B9,$BB   ; $8B38
        .byte $B8,$BC,$B9,$BD,$BA,$BC,$BB,$BD,$60,$64,$61,$65,$62,$66,$63,$67   ; $8B48
        .byte $60,$64,$61,$65,$62,$66,$63,$67,$68,$68,$69,$69,$26,$26,$6A,$6A   ; $8B58
        .byte $4B,$4C,$4D,$4E,$4D,$4F,$4D,$4F,$4D,$4E,$50,$51,$6B,$70,$2C,$2D   ; $8B68
        .byte $6C,$71,$6D,$72,$6E,$73,$6F,$74,$86,$8A,$87,$8B,$88,$8C,$88,$8C   ; $8B78
        .byte $89,$8D,$69,$69,$8E,$91,$8F,$92,$26,$93,$26,$93,$90,$94,$69,$69   ; $8B88
        .byte $A4,$E9,$EA,$EB,$24,$24,$24,$24,$24,$2F,$24,$3D,$A2,$A2,$A3,$A3   ; $8B98
        .byte $24,$24,$24,$24,$A2,$A2,$A3,$A3,$99,$24,$99,$24,$24,$A2,$3E,$3F   ; $8BA8
        .byte $5B,$5C,$24,$A3,$24,$24,$24,$24,$9D,$47,$9E,$47,$47,$47,$27,$27   ; $8BB8
        .byte $47,$47,$47,$47,$27,$27,$47,$47,$A9,$47,$AA,$47,$9B,$27,$9C,$27   ; $8BC8
        .byte $27,$27,$27,$27,$52,$52,$52,$52,$80,$A0,$81,$A1,$BE,$BE,$BF,$BF   ; $8BD8
        .byte $75,$BA,$76,$BB,$BA,$BA,$BB,$BB,$45,$47,$45,$47,$47,$47,$47,$47   ; $8BE8
        .byte $45,$47,$45,$47,$B4,$B6,$B5,$B7,$45,$47,$45,$47,$45,$47,$45,$47   ; $8BF8
        .byte $45,$47,$45,$47,$45,$47,$45,$47,$45,$47,$45,$47,$47,$47,$47,$47   ; $8C08
        .byte $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47   ; $8C18
        .byte $24,$24,$24,$24,$24,$24,$24,$24,$AB,$AC,$AD,$AE,$5D,$5E,$5D,$5E   ; $8C28
        .byte $C1,$24,$C1,$24,$C6,$C8,$C7,$C9,$CA,$CC,$CB,$CD,$2A,$2A,$40,$40   ; $8C38
        .byte $24,$24,$24,$24,$24,$47,$24,$47,$82,$83,$84,$85,$24,$47,$24,$47   ; $8C48
        .byte $86,$8A,$87,$8B,$8E,$91,$8F,$92,$24,$2F,$24,$3D,$24,$24,$24,$35   ; $8C58
        .byte $36,$25,$37,$25,$24,$38,$24,$24,$24,$24,$39,$24,$3A,$24,$3B,$24   ; $8C68
        .byte $3C,$24,$24,$24,$41,$26,$41,$26,$26,$26,$26,$26,$B0,$B1,$B2,$B3   ; $8C78
        .byte $77,$79,$77,$79,$53,$55,$54,$56,$53,$55,$54,$56,$A5,$A7,$A6,$A8   ; $8C88
        .byte $C2,$C4,$C3,$C5,$57,$59,$58,$5A,$7B,$7D,$7C,$7E,$3F,$00,$20,$0F   ; $8C98
        .byte $15,$12,$25,$0F,$3A,$1A,$0F,$0F,$30,$12,$0F,$0F,$27,$12,$0F,$22   ; $8CA8
        .byte $16,$27,$18,$0F,$10,$30,$27,$0F,$16,$30,$27,$0F,$0F,$30,$10,$00   ; $8CB8
        .byte $3F,$00,$20,$0F,$29,$1A,$0F,$0F,$36,$17,$0F,$0F,$30,$21,$0F,$0F   ; $8CC8
        .byte $27,$17,$0F,$0F,$16,$27,$18,$0F,$1A,$30,$27,$0F,$16,$30,$27,$0F   ; $8CD8
        .byte $0F,$36,$17,$00,$3F,$00,$20,$0F,$29,$1A,$09,$0F,$3C,$1C,$0F,$0F   ; $8CE8
        .byte $30,$21,$1C,$0F,$27,$17,$1C,$0F   ; $8CF8
        ASL z:$27,x                ; $8D00: 16 27
        CLC                        ; $8D02: 18
        .byte $0F,$1C,$36,$17,$0F,$16,$30,$27,$0F,$0C,$3C,$1C,$00,$3F,$00,$20   ; $8D03
        .byte $0F,$30,$10,$00,$0F,$30,$10,$00,$0F,$30,$16,$00,$0F,$27,$17,$00   ; $8D13
        .byte $0F,$16,$27,$18,$0F,$1C,$36,$17,$0F,$16,$30,$27,$0F,$00,$30,$10   ; $8D23
        .byte $00,$3F,$00,$04,$22,$30,$00,$10,$00,$3F,$00,$04,$0F,$30,$00,$10   ; $8D33
        .byte $00,$3F,$00,$04,$22,$27,$16,$0F,$00,$3F,$14,$04,$0F,$1A,$30,$27   ; $8D43
        .byte $00,$25,$48,$10,$1D,$11,$0A,$17,$14,$24,$22,$18,$1E,$24,$16,$0A   ; $8D53
        .byte $1B,$12,$18,$2B,$00,$25,$48,$10,$1D,$11,$0A,$17,$14,$24,$22,$18   ; $8D63
        .byte $1E,$24,$15,$1E,$12,$10,$12,$2B,$00,$25,$C5,$16,$0B   ; $8D73
        ASL a:$241D,x              ; $8D80: 1E 1D 24
        CLC                        ; $8D83: 18
        ASL a:$241B,x              ; $8D84: 1E 1B 24
        ORA a:$121B,y              ; $8D87: 19 1B 12
        .byte $17,$0C,$0E,$1C,$1C,$24,$12,$1C,$24,$12,$17,$26,$05,$0F,$0A,$17   ; $8D8A
        .byte $18,$1D,$11,$0E,$1B,$24,$0C,$0A,$1C,$1D,$15,$0E,$2B,$00,$25,$A7   ; $8D9A
        .byte $13,$22,$18,$1E,$1B,$24,$1A,$1E,$0E,$1C,$1D,$24,$12,$1C,$24,$18   ; $8DAA
        .byte $1F,$0E,$1B,$AF,$00,$25,$E3,$1B,$20,$0E,$24,$19,$1B,$0E,$1C,$0E   ; $8DBA
        .byte $17,$1D,$24,$22,$18,$1E,$24,$0A,$24,$17,$0E,$20,$24,$1A,$1E,$0E   ; $8DCA
        .byte $1C,$1D,$AF,$00,$26,$4A,$0D,$19,$1E,$1C,$11,$24,$0B,$1E,$1D,$1D   ; $8DDA
        .byte $18,$17,$24,$0B,$00,$26,$88,$11,$1D,$18,$24,$1C,$0E,$15,$0E,$0C   ; $8DEA
        .byte $1D,$24,$0A,$24,$20   ; $8DFA
        CLC                        ; $8DFF: 18
        .byte $1B,$15,$0D,$00   ; $8E00
        ASL a                      ; $8E04: 0A
        TAY                        ; $8E05: A8
        PLA                        ; $8E06: 68
        STA z:$04                  ; $8E07: 85 04
        PLA                        ; $8E09: 68
        STA z:$05                  ; $8E0A: 85 05
        INY                        ; $8E0C: C8
        LDA ($04),y                ; $8E0D: B1 04
        STA z:$06                  ; $8E0F: 85 06
        INY                        ; $8E11: C8
        LDA ($04),y                ; $8E12: B1 04
        STA z:$07                  ; $8E14: 85 07
        JMP ($0006)                ; $8E16: 6C 06 00
        LDA a:$2002                ; $8E19: AD 02 20
        LDA a:$0778                ; $8E1C: AD 78 07
        ORA #$10                   ; $8E1F: 09 10
        AND #$F0                   ; $8E21: 29 F0
        JSR a:$8EED                ; $8E23: 20 ED 8E
        LDA #$24                   ; $8E26: A9 24
        JSR a:$8E2D                ; $8E28: 20 2D 8E
        LDA #$20                   ; $8E2B: A9 20
        STA a:$2006                ; $8E2D: 8D 06 20
        LDA #$00                   ; $8E30: A9 00
        STA a:$2006                ; $8E32: 8D 06 20
        LDX #$04                   ; $8E35: A2 04
        LDY #$C0                   ; $8E37: A0 C0
        LDA #$24                   ; $8E39: A9 24
L8E3B:
        STA a:$2007                ; $8E3B: 8D 07 20
        DEY                        ; $8E3E: 88
        BNE L8E3B                  ; $8E3F: D0 FA
        DEX                        ; $8E41: CA
        BNE L8E3B                  ; $8E42: D0 F7
        LDY #$40                   ; $8E44: A0 40
        TXA                        ; $8E46: 8A
        STA a:$0300                ; $8E47: 8D 00 03
        STA a:$0301                ; $8E4A: 8D 01 03
L8E4D:
        STA a:$2007                ; $8E4D: 8D 07 20
        DEY                        ; $8E50: 88
        BNE L8E4D                  ; $8E51: D0 FA
        STA a:$073F                ; $8E53: 8D 3F 07
        STA a:$0740                ; $8E56: 8D 40 07
        JMP a:$8EE6                ; $8E59: 4C E6 8E
        LDA #$01                   ; $8E5C: A9 01
        STA a:$4016                ; $8E5E: 8D 16 40
        LSR a                      ; $8E61: 4A
        TAX                        ; $8E62: AA
        STA a:$4016                ; $8E63: 8D 16 40
        JSR a:$8E6A                ; $8E66: 20 6A 8E
        INX                        ; $8E69: E8
        LDY #$08                   ; $8E6A: A0 08
L8E6C:
        PHA                        ; $8E6C: 48
        LDA a:$4016,x              ; $8E6D: BD 16 40
        STA z:$00                  ; $8E70: 85 00
        LSR a                      ; $8E72: 4A
        ORA z:$00                  ; $8E73: 05 00
        LSR a                      ; $8E75: 4A
        PLA                        ; $8E76: 68
        ROL a                      ; $8E77: 2A
        DEY                        ; $8E78: 88
        BNE L8E6C                  ; $8E79: D0 F1
        STA a:$06FC,x              ; $8E7B: 9D FC 06
        PHA                        ; $8E7E: 48
        AND #$30                   ; $8E7F: 29 30
        AND a:$074A,x              ; $8E81: 3D 4A 07
        BEQ L8E8D                  ; $8E84: F0 07
        PLA                        ; $8E86: 68
        AND #$CF                   ; $8E87: 29 CF
        STA a:$06FC,x              ; $8E89: 9D FC 06
        RTS                        ; $8E8C: 60
L8E8D:
        PLA                        ; $8E8D: 68
        STA a:$074A,x              ; $8E8E: 9D 4A 07
        RTS                        ; $8E91: 60
L8E92:
        STA a:$2006                ; $8E92: 8D 06 20
        INY                        ; $8E95: C8
        LDA ($00),y                ; $8E96: B1 00
        STA a:$2006                ; $8E98: 8D 06 20
        INY                        ; $8E9B: C8
        LDA ($00),y                ; $8E9C: B1 00
        ASL a                      ; $8E9E: 0A
        PHA                        ; $8E9F: 48
        LDA a:$0778                ; $8EA0: AD 78 07
        ORA #$04                   ; $8EA3: 09 04
        BCS L8EA9                  ; $8EA5: B0 02
        AND #$FB                   ; $8EA7: 29 FB
L8EA9:
        JSR a:$8EED                ; $8EA9: 20 ED 8E
        PLA                        ; $8EAC: 68
        ASL a                      ; $8EAD: 0A
        BCC L8EB3                  ; $8EAE: 90 03
        ORA #$02                   ; $8EB0: 09 02
        INY                        ; $8EB2: C8
L8EB3:
        LSR a                      ; $8EB3: 4A
        LSR a                      ; $8EB4: 4A
        TAX                        ; $8EB5: AA
L8EB6:
        BCS L8EB9                  ; $8EB6: B0 01
        INY                        ; $8EB8: C8
L8EB9:
        LDA ($00),y                ; $8EB9: B1 00
        STA a:$2007                ; $8EBB: 8D 07 20
        DEX                        ; $8EBE: CA
        BNE L8EB6                  ; $8EBF: D0 F5
        SEC                        ; $8EC1: 38
        TYA                        ; $8EC2: 98
        ADC z:$00                  ; $8EC3: 65 00
        STA z:$00                  ; $8EC5: 85 00
        LDA #$00                   ; $8EC7: A9 00
        ADC z:$01                  ; $8EC9: 65 01
        STA z:$01                  ; $8ECB: 85 01
        LDA #$3F                   ; $8ECD: A9 3F
        STA a:$2006                ; $8ECF: 8D 06 20
        LDA #$00                   ; $8ED2: A9 00
        STA a:$2006                ; $8ED4: 8D 06 20
        STA a:$2006                ; $8ED7: 8D 06 20
        STA a:$2006                ; $8EDA: 8D 06 20
        LDX a:$2002                ; $8EDD: AE 02 20
        LDY #$00                   ; $8EE0: A0 00
        LDA ($00),y                ; $8EE2: B1 00
        BNE L8E92                  ; $8EE4: D0 AC
        STA a:$2005                ; $8EE6: 8D 05 20
        STA a:$2005                ; $8EE9: 8D 05 20
        RTS                        ; $8EEC: 60
        STA a:$2000                ; $8EED: 8D 00 20
        STA a:$0778                ; $8EF0: 8D 78 07
        RTS                        ; $8EF3: 60
        .byte $F0,$06,$62,$06,$62,$06,$6D,$02,$6D,$02,$7A,$03,$06,$0C,$12,$18   ; $8EF4
        .byte $1E,$24   ; $8F04
        STA z:$00                  ; $8F06: 85 00
        JSR a:$8F11                ; $8F08: 20 11 8F
        LDA z:$00                  ; $8F0B: A5 00
        LSR a                      ; $8F0D: 4A
        LSR a                      ; $8F0E: 4A
        LSR a                      ; $8F0F: 4A
        LSR a                      ; $8F10: 4A
        CLC                        ; $8F11: 18
        ADC #$01                   ; $8F12: 69 01
        AND #$0F                   ; $8F14: 29 0F
        CMP #$06                   ; $8F16: C9 06
        BCS L8F5E                  ; $8F18: B0 44
        PHA                        ; $8F1A: 48
        ASL a                      ; $8F1B: 0A
        TAY                        ; $8F1C: A8
        LDX a:$0300                ; $8F1D: AE 00 03
        LDA #$20                   ; $8F20: A9 20
        CPY #$00                   ; $8F22: C0 00
        BNE L8F28                  ; $8F24: D0 02
        LDA #$22                   ; $8F26: A9 22
L8F28:
        STA a:$0301,x              ; $8F28: 9D 01 03
        LDA a:$8EF4,y              ; $8F2B: B9 F4 8E
        STA a:$0302,x              ; $8F2E: 9D 02 03
        LDA a:$8EF5,y              ; $8F31: B9 F5 8E
        STA a:$0303,x              ; $8F34: 9D 03 03
        STA z:$03                  ; $8F37: 85 03
        STX z:$02                  ; $8F39: 86 02
        PLA                        ; $8F3B: 68
        TAX                        ; $8F3C: AA
        LDA a:$8F00,x              ; $8F3D: BD 00 8F
        SEC                        ; $8F40: 38
        SBC a:$8EF5,y              ; $8F41: F9 F5 8E
        TAY                        ; $8F44: A8
        LDX z:$02                  ; $8F45: A6 02
L8F47:
        LDA a:$07D7,y              ; $8F47: B9 D7 07
        STA a:$0304,x              ; $8F4A: 9D 04 03
        INX                        ; $8F4D: E8
        INY                        ; $8F4E: C8
        DEC z:$03                  ; $8F4F: C6 03
        BNE L8F47                  ; $8F51: D0 F4
        LDA #$00                   ; $8F53: A9 00
        STA a:$0304,x              ; $8F55: 9D 04 03
        INX                        ; $8F58: E8
        INX                        ; $8F59: E8
        INX                        ; $8F5A: E8
        STX a:$0300                ; $8F5B: 8E 00 03
L8F5E:
        RTS                        ; $8F5E: 60
        LDA a:$0770                ; $8F5F: AD 70 07
        CMP #$00                   ; $8F62: C9 00
        BEQ L8F7C                  ; $8F64: F0 16
        LDX #$05                   ; $8F66: A2 05
L8F68:
        LDA a:$0134,x              ; $8F68: BD 34 01
        CLC                        ; $8F6B: 18
        ADC a:$07D7,y              ; $8F6C: 79 D7 07
        BMI L8F87                  ; $8F6F: 30 16
        CMP #$0A                   ; $8F71: C9 0A
        BCS L8F8E                  ; $8F73: B0 19
L8F75:
        STA a:$07D7,y              ; $8F75: 99 D7 07
        DEY                        ; $8F78: 88
        DEX                        ; $8F79: CA
        BPL L8F68                  ; $8F7A: 10 EC
L8F7C:
        LDA #$00                   ; $8F7C: A9 00
        LDX #$06                   ; $8F7E: A2 06
L8F80:
        STA a:$0133,x              ; $8F80: 9D 33 01
        DEX                        ; $8F83: CA
        BPL L8F80                  ; $8F84: 10 FA
        RTS                        ; $8F86: 60
L8F87:
        DEC a:$0133,x              ; $8F87: DE 33 01
        LDA #$09                   ; $8F8A: A9 09
        BNE L8F75                  ; $8F8C: D0 E7
L8F8E:
        SEC                        ; $8F8E: 38
        SBC #$0A                   ; $8F8F: E9 0A
        INC a:$0133,x              ; $8F91: FE 33 01
        JMP a:$8F75                ; $8F94: 4C 75 8F
        LDX #$05                   ; $8F97: A2 05
        JSR a:$8F9E                ; $8F99: 20 9E 8F
        LDX #$0B                   ; $8F9C: A2 0B
        LDY #$05                   ; $8F9E: A0 05
        SEC                        ; $8FA0: 38
L8FA1:
        LDA a:$07DD,x              ; $8FA1: BD DD 07
        SBC a:$07D7,y              ; $8FA4: F9 D7 07
        DEX                        ; $8FA7: CA
        DEY                        ; $8FA8: 88
        BPL L8FA1                  ; $8FA9: 10 F6
        BCC L8FBB                  ; $8FAB: 90 0E
        INX                        ; $8FAD: E8
        INY                        ; $8FAE: C8
L8FAF:
        LDA a:$07DD,x              ; $8FAF: BD DD 07
        STA a:$07D7,y              ; $8FB2: 99 D7 07
        INX                        ; $8FB5: E8
        INY                        ; $8FB6: C8
        CPY #$06                   ; $8FB7: C0 06
        BCC L8FAF                  ; $8FB9: 90 F4
L8FBB:
        RTS                        ; $8FBB: 60
        .byte $04,$30,$48,$60,$78,$90,$A8,$C0,$D8,$E8,$24,$F8,$FC,$28,$2C,$18   ; $8FBC
        .byte $FF,$23,$58   ; $8FCC
        LDY #$6F                   ; $8FCF: A0 6F
        JSR a:$90CC                ; $8FD1: 20 CC 90
        LDY #$1F                   ; $8FD4: A0 1F
L8FD6:
        STA a:$07B0,y              ; $8FD6: 99 B0 07
        DEY                        ; $8FD9: 88
        BPL L8FD6                  ; $8FDA: 10 FA
        LDA #$18                   ; $8FDC: A9 18
        STA a:$07A2                ; $8FDE: 8D A2 07
        JSR a:$9C03                ; $8FE1: 20 03 9C
        LDY #$4B                   ; $8FE4: A0 4B
        JSR a:$90CC                ; $8FE6: 20 CC 90
        LDX #$21                   ; $8FE9: A2 21
        LDA #$00                   ; $8FEB: A9 00
L8FED:
        STA a:$0780,x              ; $8FED: 9D 80 07
        DEX                        ; $8FF0: CA
        BPL L8FED                  ; $8FF1: 10 FA
        LDA a:$075B                ; $8FF3: AD 5B 07
        LDY a:$0752                ; $8FF6: AC 52 07
        BEQ L8FFE                  ; $8FF9: F0 03
        LDA a:$0751                ; $8FFB: AD 51 07
L8FFE:
        STA a:$071A                ; $8FFE: 8D 1A 07
        STA a:$0725                ; $9001: 8D 25 07
        STA a:$0728                ; $9004: 8D 28 07
        JSR a:$B038                ; $9007: 20 38 B0
        LDY #$20                   ; $900A: A0 20
        AND #$01                   ; $900C: 29 01
        BEQ L9012                  ; $900E: F0 02
        LDY #$24                   ; $9010: A0 24
L9012:
        STY a:$0720                ; $9012: 8C 20 07
        LDY #$80                   ; $9015: A0 80
        STY a:$0721                ; $9017: 8C 21 07
        ASL a                      ; $901A: 0A
        ASL a                      ; $901B: 0A
        ASL a                      ; $901C: 0A
        ASL a                      ; $901D: 0A
        STA a:$06A0                ; $901E: 8D A0 06
        DEC a:$0730                ; $9021: CE 30 07
        DEC a:$0731                ; $9024: CE 31 07
        DEC a:$0732                ; $9027: CE 32 07
        LDA #$0B                   ; $902A: A9 0B
        STA a:$071E                ; $902C: 8D 1E 07
        JSR a:$9C22                ; $902F: 20 22 9C
        LDA a:$076A                ; $9032: AD 6A 07
        BNE L9047                  ; $9035: D0 10
        LDA a:$075F                ; $9037: AD 5F 07
        CMP #$04                   ; $903A: C9 04
        BCC L904A                  ; $903C: 90 0C
        BNE L9047                  ; $903E: D0 07
        LDA a:$075C                ; $9040: AD 5C 07
        CMP #$02                   ; $9043: C9 02
        BCC L904A                  ; $9045: 90 03
L9047:
        INC a:$06CC                ; $9047: EE CC 06
L904A:
        LDA a:$075B                ; $904A: AD 5B 07
        BEQ L9054                  ; $904D: F0 05
        LDA #$02                   ; $904F: A9 02
        STA a:$0710                ; $9051: 8D 10 07
L9054:
        LDA #$80                   ; $9054: A9 80
        STA z:$FB                  ; $9056: 85 FB
        LDA #$01                   ; $9058: A9 01
        STA a:$0774                ; $905A: 8D 74 07
        INC a:$0772                ; $905D: EE 72 07
        RTS                        ; $9060: 60
        LDA #$01                   ; $9061: A9 01
        STA a:$0757                ; $9063: 8D 57 07
        STA a:$0754                ; $9066: 8D 54 07
        LDA #$02                   ; $9069: A9 02
        STA a:$075A                ; $906B: 8D 5A 07
        STA a:$0761                ; $906E: 8D 61 07
        LDA #$00                   ; $9071: A9 00
        STA a:$0774                ; $9073: 8D 74 07
        TAY                        ; $9076: A8
L9077:
        STA a:$0300,y              ; $9077: 99 00 03
        INY                        ; $907A: C8
        BNE L9077                  ; $907B: D0 FA
        STA a:$0759                ; $907D: 8D 59 07
        STA a:$0769                ; $9080: 8D 69 07
        STA a:$0728                ; $9083: 8D 28 07
        LDA #$FF                   ; $9086: A9 FF
        STA a:$03A0                ; $9088: 8D A0 03
        LDA a:$071A                ; $908B: AD 1A 07
        LSR a:$0778                ; $908E: 4E 78 07
        AND #$01                   ; $9091: 29 01
        ROR a                      ; $9093: 6A
        ROL a:$0778                ; $9094: 2E 78 07
        JSR a:$90ED                ; $9097: 20 ED 90
        LDA #$38                   ; $909A: A9 38
        STA a:$06E3                ; $909C: 8D E3 06
        LDA #$48                   ; $909F: A9 48
        STA a:$06E2                ; $90A1: 8D E2 06
        LDA #$58                   ; $90A4: A9 58
        STA a:$06E1                ; $90A6: 8D E1 06
        LDX #$0E                   ; $90A9: A2 0E
L90AB:
        LDA a:$8FBC,x              ; $90AB: BD BC 8F
        STA a:$06E4,x              ; $90AE: 9D E4 06
        DEX                        ; $90B1: CA
        BPL L90AB                  ; $90B2: 10 F7
        LDY #$03                   ; $90B4: A0 03
L90B6:
        LDA a:$8FCB,y              ; $90B6: B9 CB 8F
        STA a:$0200,y              ; $90B9: 99 00 02
        DEY                        ; $90BC: 88
        BPL L90B6                  ; $90BD: 10 F7
        JSR a:$92AF                ; $90BF: 20 AF 92
        JSR a:$92AA                ; $90C2: 20 AA 92
        INC a:$0722                ; $90C5: EE 22 07
        INC a:$0772                ; $90C8: EE 72 07
        RTS                        ; $90CB: 60
        LDX #$07                   ; $90CC: A2 07
        LDA #$00                   ; $90CE: A9 00
        STA z:$06                  ; $90D0: 85 06
L90D2:
        STX z:$07                  ; $90D2: 86 07
L90D4:
        CPX #$01                   ; $90D4: E0 01
        BNE L90DC                  ; $90D6: D0 04
        CPY #$60                   ; $90D8: C0 60
        BCS L90DE                  ; $90DA: B0 02
L90DC:
        STA ($06),y                ; $90DC: 91 06
L90DE:
        DEY                        ; $90DE: 88
        CPY #$FF                   ; $90DF: C0 FF
        BNE L90D4                  ; $90E1: D0 F1
        DEX                        ; $90E3: CA
        BPL L90D2                  ; $90E4: 10 EC
        RTS                        ; $90E6: 60
        .byte $02,$01,$04,$08,$10,$20   ; $90E7
        LDA a:$0770                ; $90ED: AD 70 07
        BEQ L9115                  ; $90F0: F0 23
        LDA a:$0752                ; $90F2: AD 52 07
        CMP #$02                   ; $90F5: C9 02
        BEQ L9106                  ; $90F7: F0 0D
        LDY #$05                   ; $90F9: A0 05
        LDA a:$0710                ; $90FB: AD 10 07
        CMP #$06                   ; $90FE: C9 06
        BEQ L9110                  ; $9100: F0 0E
        CMP #$07                   ; $9102: C9 07
        BEQ L9110                  ; $9104: F0 0A
L9106:
        LDY a:$074E                ; $9106: AC 4E 07
        LDA a:$0743                ; $9109: AD 43 07
        BEQ L9110                  ; $910C: F0 02
        LDY #$04                   ; $910E: A0 04
L9110:
        LDA a:$90E7,y              ; $9110: B9 E7 90
        STA z:$FB                  ; $9113: 85 FB
L9115:
        RTS                        ; $9115: 60
        .byte $28,$18,$38,$28,$08,$00,$00,$20,$B0,$50,$00,$00,$B0,$B0,$F0,$00   ; $9116
        .byte $20,$00,$00,$00,$00,$00,$00,$20,$04,$03,$02   ; $9126
        LDA a:$071A                ; $9131: AD 1A 07
        STA z:$6D                  ; $9134: 85 6D
        LDA #$28                   ; $9136: A9 28
        STA a:$070A                ; $9138: 8D 0A 07
        LDA #$01                   ; $913B: A9 01
        STA z:$33                  ; $913D: 85 33
        STA z:$B5                  ; $913F: 85 B5
        LDA #$00                   ; $9141: A9 00
        STA z:$1D                  ; $9143: 85 1D
        DEC a:$0490                ; $9145: CE 90 04
        LDY #$00                   ; $9148: A0 00
        STY a:$075B                ; $914A: 8C 5B 07
        LDA a:$074E                ; $914D: AD 4E 07
        BNE L9153                  ; $9150: D0 01
        INY                        ; $9152: C8
L9153:
        STY a:$0704                ; $9153: 8C 04 07
        LDX a:$0710                ; $9156: AE 10 07
        LDY a:$0752                ; $9159: AC 52 07
        BEQ L9165                  ; $915C: F0 07
        CPY #$01                   ; $915E: C0 01
        BEQ L9165                  ; $9160: F0 03
        LDX a:$9118,y              ; $9162: BE 18 91
L9165:
        LDA a:$9116,y              ; $9165: B9 16 91
        STA z:$86                  ; $9168: 85 86
        LDA a:$911C,x              ; $916A: BD 1C 91
        STA z:$CE                  ; $916D: 85 CE
        LDA a:$9125,x              ; $916F: BD 25 91
        STA a:$03C4                ; $9172: 8D C4 03
        JSR a:$85F1                ; $9175: 20 F1 85
        LDY a:$0715                ; $9178: AC 15 07
        BEQ L9197                  ; $917B: F0 1A
        LDA a:$0757                ; $917D: AD 57 07
        BEQ L9197                  ; $9180: F0 15
        LDA a:$912D,y              ; $9182: B9 2D 91
        STA a:$07F8                ; $9185: 8D F8 07
        LDA #$01                   ; $9188: A9 01
        STA a:$07FA                ; $918A: 8D FA 07
        LSR a                      ; $918D: 4A
        STA a:$07F9                ; $918E: 8D F9 07
        STA a:$0757                ; $9191: 8D 57 07
        STA a:$079F                ; $9194: 8D 9F 07
L9197:
        LDY a:$0758                ; $9197: AC 58 07
        BEQ L91B0                  ; $919A: F0 14
        LDA #$03                   ; $919C: A9 03
        STA z:$1D                  ; $919E: 85 1D
        LDX #$00                   ; $91A0: A2 00
        JSR a:$BD84                ; $91A2: 20 84 BD
        LDA #$F0                   ; $91A5: A9 F0
        STA z:$D7                  ; $91A7: 85 D7
        LDX #$05                   ; $91A9: A2 05
        LDY #$00                   ; $91AB: A0 00
        JSR a:$B91E                ; $91AD: 20 1E B9
L91B0:
        LDY a:$074E                ; $91B0: AC 4E 07
        BNE L91B8                  ; $91B3: D0 03
        JSR a:$B70B                ; $91B5: 20 0B B7
L91B8:
        LDA #$07                   ; $91B8: A9 07
        STA z:$0E                  ; $91BA: 85 0E
        RTS                        ; $91BC: 60
        .byte $56,$40,$65,$70,$66,$40,$66,$40,$66,$40,$66,$60,$65,$70,$00,$00   ; $91BD
        INC a:$0774                ; $91CD: EE 74 07
        LDA #$00                   ; $91D0: A9 00
        STA a:$0722                ; $91D2: 8D 22 07
        LDA #$80                   ; $91D5: A9 80
        STA z:$FC                  ; $91D7: 85 FC
        DEC a:$075A                ; $91D9: CE 5A 07
        BPL L91E9                  ; $91DC: 10 0B
        LDA #$00                   ; $91DE: A9 00
        STA a:$0772                ; $91E0: 8D 72 07
        LDA #$03                   ; $91E3: A9 03
        STA a:$0770                ; $91E5: 8D 70 07
        RTS                        ; $91E8: 60
L91E9:
        LDA a:$075F                ; $91E9: AD 5F 07
        ASL a                      ; $91EC: 0A
        TAX                        ; $91ED: AA
        LDA a:$075C                ; $91EE: AD 5C 07
        AND #$02                   ; $91F1: 29 02
        BEQ L91F6                  ; $91F3: F0 01
        INX                        ; $91F5: E8
L91F6:
        LDY a:$91BD,x              ; $91F6: BC BD 91
        LDA a:$075C                ; $91F9: AD 5C 07
        LSR a                      ; $91FC: 4A
        TYA                        ; $91FD: 98
        BCS L9204                  ; $91FE: B0 04
        LSR a                      ; $9200: 4A
        LSR a                      ; $9201: 4A
        LSR a                      ; $9202: 4A
        LSR a                      ; $9203: 4A
L9204:
        AND #$0F                   ; $9204: 29 0F
        CMP a:$071A                ; $9206: CD 1A 07
        BEQ L920F                  ; $9209: F0 04
        BCC L920F                  ; $920B: 90 02
        LDA #$00                   ; $920D: A9 00
L920F:
        STA a:$075B                ; $920F: 8D 5B 07
        JSR a:$9282                ; $9212: 20 82 92
        JMP a:$9264                ; $9215: 4C 64 92
        LDA a:$0772                ; $9218: AD 72 07
        JSR a:$8E04                ; $921B: 20 04 8E
        .byte $24,$92,$67,$85,$37,$92   ; $921E
        LDA #$00                   ; $9224: A9 00
        STA a:$073C                ; $9226: 8D 3C 07
        STA a:$0722                ; $9229: 8D 22 07
        LDA #$02                   ; $922C: A9 02
        STA z:$FC                  ; $922E: 85 FC
        INC a:$0774                ; $9230: EE 74 07
        INC a:$0772                ; $9233: EE 72 07
        RTS                        ; $9236: 60
        LDA #$00                   ; $9237: A9 00
        STA a:$0774                ; $9239: 8D 74 07
        LDA a:$06FC                ; $923C: AD FC 06
        AND #$10                   ; $923F: 29 10
        BNE L9248                  ; $9241: D0 05
        LDA a:$07A0                ; $9243: AD A0 07
        BNE L9281                  ; $9246: D0 39
L9248:
        LDA #$80                   ; $9248: A9 80
        STA z:$FC                  ; $924A: 85 FC
        JSR a:$9282                ; $924C: 20 82 92
        BCC L9264                  ; $924F: 90 13
        LDA a:$075F                ; $9251: AD 5F 07
        STA a:$07FD                ; $9254: 8D FD 07
        LDA #$00                   ; $9257: A9 00
        ASL a                      ; $9259: 0A
        STA a:$0772                ; $925A: 8D 72 07
        STA a:$07A0                ; $925D: 8D A0 07
        STA a:$0770                ; $9260: 8D 70 07
        RTS                        ; $9263: 60
L9264:
        JSR a:$9C03                ; $9264: 20 03 9C
        LDA #$01                   ; $9267: A9 01
        STA a:$0754                ; $9269: 8D 54 07
        INC a:$0757                ; $926C: EE 57 07
        LDA #$00                   ; $926F: A9 00
        STA a:$0747                ; $9271: 8D 47 07
        STA a:$0756                ; $9274: 8D 56 07
        STA z:$0E                  ; $9277: 85 0E
        STA a:$0772                ; $9279: 8D 72 07
        LDA #$01                   ; $927C: A9 01
        STA a:$0770                ; $927E: 8D 70 07
L9281:
        RTS                        ; $9281: 60
        SEC                        ; $9282: 38
        LDA a:$077A                ; $9283: AD 7A 07
        BEQ L92A9                  ; $9286: F0 21
        LDA a:$0761                ; $9288: AD 61 07
        BMI L92A9                  ; $928B: 30 1C
        LDA a:$0753                ; $928D: AD 53 07
        EOR #$01                   ; $9290: 49 01
        STA a:$0753                ; $9292: 8D 53 07
        LDX #$06                   ; $9295: A2 06
L9297:
        LDA a:$075A,x              ; $9297: BD 5A 07
        PHA                        ; $929A: 48
        LDA a:$0761,x              ; $929B: BD 61 07
        STA a:$075A,x              ; $929E: 9D 5A 07
        PLA                        ; $92A1: 68
        STA a:$0761,x              ; $92A2: 9D 61 07
        DEX                        ; $92A5: CA
        BPL L9297                  ; $92A6: 10 EF
        CLC                        ; $92A8: 18
L92A9:
        RTS                        ; $92A9: 60
        LDA #$FF                   ; $92AA: A9 FF
        STA a:$06C9                ; $92AC: 8D C9 06
        RTS                        ; $92AF: 60
        LDY a:$071F                ; $92B0: AC 1F 07
        BNE L92BA                  ; $92B3: D0 05
        LDY #$08                   ; $92B5: A0 08
        STY a:$071F                ; $92B7: 8C 1F 07
L92BA:
        DEY                        ; $92BA: 88
        TYA                        ; $92BB: 98
        JSR a:$92C8                ; $92BC: 20 C8 92
        DEC a:$071F                ; $92BF: CE 1F 07
        BNE L92C7                  ; $92C2: D0 03
        JSR a:$896A                ; $92C4: 20 6A 89
L92C7:
        RTS                        ; $92C7: 60
        JSR a:$8E04                ; $92C8: 20 04 8E
        .byte $DB,$92,$AE,$88,$AE,$88,$FC,$93,$DB,$92,$AE,$88,$AE,$88,$FC,$93   ; $92CB
        INC a:$0726                ; $92DB: EE 26 07
        LDA a:$0726                ; $92DE: AD 26 07
        AND #$0F                   ; $92E1: 29 0F
        BNE L92EB                  ; $92E3: D0 06
        STA a:$0726                ; $92E5: 8D 26 07
        INC a:$0725                ; $92E8: EE 25 07
L92EB:
        INC a:$06A0                ; $92EB: EE A0 06
        LDA a:$06A0                ; $92EE: AD A0 06
        AND #$1F                   ; $92F1: 29 1F
        STA a:$06A0                ; $92F3: 8D A0 06
        RTS                        ; $92F6: 60
        .byte $00,$30,$60,$93,$00,$00,$11,$12,$12,$13,$00,$00,$51,$52,$53,$00   ; $92F7
        .byte $00,$00,$00,$00,$00,$01,$02,$02,$03,$00,$00,$00,$00,$00,$00,$91   ; $9307
        .byte $92,$93,$00,$00,$00,$00,$51,$52,$53,$41,$42,$43,$00,$00,$00,$00   ; $9317
        .byte $00,$91,$92,$97,$87,$88,$89,$99,$00,$00,$00,$11,$12,$13,$A4,$A5   ; $9327
        .byte $A5,$A5,$A6,$97,$98,$99,$01,$02,$03,$00,$A4,$A5,$A6,$00,$11,$12   ; $9337
        .byte $12,$12,$13,$00,$00,$00,$00,$01,$02,$02,$03,$00,$A4,$A5,$A5,$A6   ; $9347
        .byte $00,$00,$00,$11,$12,$12,$13,$00,$00   ; $9357
        BRK                        ; $9360: 00
        .byte $00,$00,$00,$00,$9C,$00,$8B,$AA,$AA,$AA,$AA,$11,$12,$13,$8B,$00   ; $9361
        .byte $9C,$9C,$00,$00,$01,$02,$03,$11,$12,$12,$13,$00,$00,$00,$00,$AA   ; $9371
        .byte $AA,$9C,$AA,$00,$8B,$00,$01,$02,$03,$80,$83,$00,$81,$84,$00,$82   ; $9381
        .byte $85,$00,$02,$00,$00,$03,$00,$00,$04,$00,$00,$00,$05,$06,$07,$06   ; $9391
        .byte $0A,$00,$08,$09,$4D,$00,$00,$0D,$0F,$4E,$0E,$4E,$4E,$00,$0D,$1A   ; $93A1
        .byte $86,$87,$87,$87,$87,$87,$87,$87,$87,$87,$87,$69,$69,$00,$00,$00   ; $93B1
        .byte $00,$00,$45,$47,$47,$47,$47,$47,$00,$00,$00,$00,$00,$00,$00,$00   ; $93C1
        .byte $00,$00,$00,$00,$00,$86,$87,$69,$54,$52,$62,$00,$00,$00,$18,$01   ; $93D1
        .byte $18,$07,$18,$0F,$18,$FF,$18,$01,$1F,$07,$1F,$0F,$1F,$81,$1F,$01   ; $93E1
        .byte $00,$8F,$1F,$F1,$1F,$F9,$18,$F1,$18,$FF,$1F   ; $93F1
        LDA a:$0728                ; $93FC: AD 28 07
        BEQ L9404                  ; $93FF: F0 03
        JSR a:$9508                ; $9401: 20 08 95
L9404:
        LDX #$0C                   ; $9404: A2 0C
        LDA #$00                   ; $9406: A9 00
L9408:
        STA a:$06A1,x              ; $9408: 9D A1 06
        DEX                        ; $940B: CA
        BPL L9408                  ; $940C: 10 FA
        LDY a:$0742                ; $940E: AC 42 07
        BEQ L9455                  ; $9411: F0 42
        LDA a:$0725                ; $9413: AD 25 07
L9416:
        CMP #$03                   ; $9416: C9 03
        BMI L941F                  ; $9418: 30 05
        SEC                        ; $941A: 38
        SBC #$03                   ; $941B: E9 03
        BPL L9416                  ; $941D: 10 F7
L941F:
        ASL a                      ; $941F: 0A
        ASL a                      ; $9420: 0A
        ASL a                      ; $9421: 0A
        ASL a                      ; $9422: 0A
        ADC a:$92F6,y              ; $9423: 79 F6 92
        ADC a:$0726                ; $9426: 6D 26 07
        TAX                        ; $9429: AA
        LDA a:$92FA,x              ; $942A: BD FA 92
        BEQ L9455                  ; $942D: F0 26
        PHA                        ; $942F: 48
        AND #$0F                   ; $9430: 29 0F
        SEC                        ; $9432: 38
        SBC #$01                   ; $9433: E9 01
        STA z:$00                  ; $9435: 85 00
        ASL a                      ; $9437: 0A
        ADC z:$00                  ; $9438: 65 00
        TAX                        ; $943A: AA
        PLA                        ; $943B: 68
        LSR a                      ; $943C: 4A
        LSR a                      ; $943D: 4A
        LSR a                      ; $943E: 4A
        LSR a                      ; $943F: 4A
        TAY                        ; $9440: A8
        LDA #$03                   ; $9441: A9 03
        STA z:$00                  ; $9443: 85 00
L9445:
        LDA a:$938A,x              ; $9445: BD 8A 93
        STA a:$06A1,y              ; $9448: 99 A1 06
        INX                        ; $944B: E8
        INY                        ; $944C: C8
        CPY #$0B                   ; $944D: C0 0B
        BEQ L9455                  ; $944F: F0 04
        DEC z:$00                  ; $9451: C6 00
        BNE L9445                  ; $9453: D0 F0
L9455:
        LDX a:$0741                ; $9455: AE 41 07
        BEQ L946D                  ; $9458: F0 13
        LDY a:$93AD,x              ; $945A: BC AD 93
        LDX #$00                   ; $945D: A2 00
L945F:
        LDA a:$93B1,y              ; $945F: B9 B1 93
        BEQ L9467                  ; $9462: F0 03
        STA a:$06A1,x              ; $9464: 9D A1 06
L9467:
        INY                        ; $9467: C8
        INX                        ; $9468: E8
        CPX #$0D                   ; $9469: E0 0D
        BNE L945F                  ; $946B: D0 F2
L946D:
        LDY a:$074E                ; $946D: AC 4E 07
        BNE L947E                  ; $9470: D0 0C
        LDA a:$075F                ; $9472: AD 5F 07
        CMP #$07                   ; $9475: C9 07
        BNE L947E                  ; $9477: D0 05
        LDA #$62                   ; $9479: A9 62
        JMP a:$9488                ; $947B: 4C 88 94
L947E:
        LDA a:$93D8,y              ; $947E: B9 D8 93
        LDY a:$0743                ; $9481: AC 43 07
        BEQ L9488                  ; $9484: F0 02
        LDA #$88                   ; $9486: A9 88
L9488:
        STA z:$07                  ; $9488: 85 07
        LDX #$00                   ; $948A: A2 00
        LDA a:$0727                ; $948C: AD 27 07
        ASL a                      ; $948F: 0A
        TAY                        ; $9490: A8
L9491:
        LDA a:$93DC,y              ; $9491: B9 DC 93
        STA z:$00                  ; $9494: 85 00
        INY                        ; $9496: C8
        STY z:$01                  ; $9497: 84 01
        LDA a:$0743                ; $9499: AD 43 07
        BEQ L94A8                  ; $949C: F0 0A
        CPX #$00                   ; $949E: E0 00
        BEQ L94A8                  ; $94A0: F0 06
        LDA z:$00                  ; $94A2: A5 00
        AND #$08                   ; $94A4: 29 08
        STA z:$00                  ; $94A6: 85 00
L94A8:
        LDY #$00                   ; $94A8: A0 00
L94AA:
        LDA a:$C68A,y              ; $94AA: B9 8A C6
        BIT z:$00                  ; $94AD: 24 00
        BEQ L94B6                  ; $94AF: F0 05
        LDA z:$07                  ; $94B1: A5 07
        STA a:$06A1,x              ; $94B3: 9D A1 06
L94B6:
        INX                        ; $94B6: E8
        CPX #$0D                   ; $94B7: E0 0D
        BEQ L94D3                  ; $94B9: F0 18
        LDA a:$074E                ; $94BB: AD 4E 07
        CMP #$02                   ; $94BE: C9 02
        BNE L94CA                  ; $94C0: D0 08
        CPX #$0B                   ; $94C2: E0 0B
        BNE L94CA                  ; $94C4: D0 04
        LDA #$54                   ; $94C6: A9 54
        STA z:$07                  ; $94C8: 85 07
L94CA:
        INY                        ; $94CA: C8
        CPY #$08                   ; $94CB: C0 08
        BNE L94AA                  ; $94CD: D0 DB
        LDY z:$01                  ; $94CF: A4 01
        BNE L9491                  ; $94D1: D0 BE
L94D3:
        JSR a:$9508                ; $94D3: 20 08 95
        LDA a:$06A0                ; $94D6: AD A0 06
        JSR a:$9BE1                ; $94D9: 20 E1 9B
        LDX #$00                   ; $94DC: A2 00
        LDY #$00                   ; $94DE: A0 00
L94E0:
        STY z:$00                  ; $94E0: 84 00
        LDA a:$06A1,x              ; $94E2: BD A1 06
        AND #$C0                   ; $94E5: 29 C0
        ASL a                      ; $94E7: 0A
        ROL a                      ; $94E8: 2A
        ROL a                      ; $94E9: 2A
        TAY                        ; $94EA: A8
        LDA a:$06A1,x              ; $94EB: BD A1 06
        CMP a:$9504,y              ; $94EE: D9 04 95
        BCS L94F5                  ; $94F1: B0 02
        LDA #$00                   ; $94F3: A9 00
L94F5:
        LDY z:$00                  ; $94F5: A4 00
        STA ($06),y                ; $94F7: 91 06
        TYA                        ; $94F9: 98
        CLC                        ; $94FA: 18
        ADC #$10                   ; $94FB: 69 10
        TAY                        ; $94FD: A8
        INX                        ; $94FE: E8
        CPX #$0D                   ; $94FF: E0 0D
        BCC L94E0                  ; $9501: 90 DD
        RTS                        ; $9503: 60
        .byte $10,$51   ; $9504
        DEY                        ; $9506: 88
        .byte $C0   ; $9507
L9508:
        LDX #$02                   ; $9508: A2 02
L950A:
        STX z:$08                  ; $950A: 86 08
        LDA #$00                   ; $950C: A9 00
        STA a:$0729                ; $950E: 8D 29 07
        LDY a:$072C                ; $9511: AC 2C 07
        LDA ($E7),y                ; $9514: B1 E7
        CMP #$FD                   ; $9516: C9 FD
        BEQ L9565                  ; $9518: F0 4B
        LDA a:$0730,x              ; $951A: BD 30 07
        BPL L9565                  ; $951D: 10 46
        INY                        ; $951F: C8
        LDA ($E7),y                ; $9520: B1 E7
        ASL a                      ; $9522: 0A
        BCC L9530                  ; $9523: 90 0B
        LDA a:$072B                ; $9525: AD 2B 07
        BNE L9530                  ; $9528: D0 06
        INC a:$072B                ; $952A: EE 2B 07
        INC a:$072A                ; $952D: EE 2A 07
L9530:
        DEY                        ; $9530: 88
        LDA ($E7),y                ; $9531: B1 E7
        AND #$0F                   ; $9533: 29 0F
        CMP #$0D                   ; $9535: C9 0D
        BNE L9554                  ; $9537: D0 1B
        INY                        ; $9539: C8
        LDA ($E7),y                ; $953A: B1 E7
        DEY                        ; $953C: 88
        AND #$40                   ; $953D: 29 40
        BNE L955D                  ; $953F: D0 1C
        LDA a:$072B                ; $9541: AD 2B 07
        BNE L955D                  ; $9544: D0 17
        INY                        ; $9546: C8
        LDA ($E7),y                ; $9547: B1 E7
        AND #$1F                   ; $9549: 29 1F
        STA a:$072A                ; $954B: 8D 2A 07
        INC a:$072B                ; $954E: EE 2B 07
        JMP a:$956E                ; $9551: 4C 6E 95
L9554:
        CMP #$0E                   ; $9554: C9 0E
        BNE L955D                  ; $9556: D0 05
        LDA a:$0728                ; $9558: AD 28 07
        BNE L9565                  ; $955B: D0 08
L955D:
        LDA a:$072A                ; $955D: AD 2A 07
        CMP a:$0725                ; $9560: CD 25 07
        BCC L956B                  ; $9563: 90 06
L9565:
        JSR a:$9595                ; $9565: 20 95 95
        JMP a:$9571                ; $9568: 4C 71 95
L956B:
        INC a:$0729                ; $956B: EE 29 07
        JSR a:$9589                ; $956E: 20 89 95
        LDX z:$08                  ; $9571: A6 08
        LDA a:$0730,x              ; $9573: BD 30 07
        BMI L957B                  ; $9576: 30 03
        DEC a:$0730,x              ; $9578: DE 30 07
L957B:
        DEX                        ; $957B: CA
        BPL L950A                  ; $957C: 10 8C
        LDA a:$0729                ; $957E: AD 29 07
        BNE L9508                  ; $9581: D0 85
        LDA a:$0728                ; $9583: AD 28 07
        BNE L9508                  ; $9586: D0 80
L9588:
        RTS                        ; $9588: 60
        INC a:$072C                ; $9589: EE 2C 07
        INC a:$072C                ; $958C: EE 2C 07
        LDA #$00                   ; $958F: A9 00
        STA a:$072B                ; $9591: 8D 2B 07
        RTS                        ; $9594: 60
        LDA a:$0730,x              ; $9595: BD 30 07
        BMI L959D                  ; $9598: 30 03
        LDY a:$072D,x              ; $959A: BC 2D 07
L959D:
        LDX #$10                   ; $959D: A2 10
        LDA ($E7),y                ; $959F: B1 E7
        CMP #$FD                   ; $95A1: C9 FD
        BEQ L9588                  ; $95A3: F0 E3
        AND #$0F                   ; $95A5: 29 0F
        CMP #$0F                   ; $95A7: C9 0F
        BEQ L95B3                  ; $95A9: F0 08
        LDX #$08                   ; $95AB: A2 08
        CMP #$0C                   ; $95AD: C9 0C
        BEQ L95B3                  ; $95AF: F0 02
        LDX #$00                   ; $95B1: A2 00
L95B3:
        STX z:$07                  ; $95B3: 86 07
        LDX z:$08                  ; $95B5: A6 08
        CMP #$0E                   ; $95B7: C9 0E
        BNE L95C3                  ; $95B9: D0 08
        LDA #$00                   ; $95BB: A9 00
        STA z:$07                  ; $95BD: 85 07
        LDA #$2E                   ; $95BF: A9 2E
        BNE L9616                  ; $95C1: D0 53
L95C3:
        CMP #$0D                   ; $95C3: C9 0D
        BNE L95E2                  ; $95C5: D0 1B
        LDA #$22                   ; $95C7: A9 22
        STA z:$07                  ; $95C9: 85 07
        INY                        ; $95CB: C8
        LDA ($E7),y                ; $95CC: B1 E7
        AND #$40                   ; $95CE: 29 40
        BEQ L9635                  ; $95D0: F0 63
        LDA ($E7),y                ; $95D2: B1 E7
        AND #$7F                   ; $95D4: 29 7F
        CMP #$4B                   ; $95D6: C9 4B
        BNE L95DD                  ; $95D8: D0 03
        INC a:$0745                ; $95DA: EE 45 07
L95DD:
        AND #$3F                   ; $95DD: 29 3F
        JMP a:$9616                ; $95DF: 4C 16 96
L95E2:
        CMP #$0C                   ; $95E2: C9 0C
        BCS L960D                  ; $95E4: B0 27
        INY                        ; $95E6: C8
        LDA ($E7),y                ; $95E7: B1 E7
        AND #$70                   ; $95E9: 29 70
        BNE L95F8                  ; $95EB: D0 0B
        LDA #$16                   ; $95ED: A9 16
        STA z:$07                  ; $95EF: 85 07
        LDA ($E7),y                ; $95F1: B1 E7
        AND #$0F                   ; $95F3: 29 0F
        JMP a:$9616                ; $95F5: 4C 16 96
L95F8:
        STA z:$00                  ; $95F8: 85 00
        CMP #$70                   ; $95FA: C9 70
        BNE L9608                  ; $95FC: D0 0A
        LDA ($E7),y                ; $95FE: B1 E7
        AND #$08                   ; $9600: 29 08
        BEQ L9608                  ; $9602: F0 04
        LDA #$00                   ; $9604: A9 00
        STA z:$00                  ; $9606: 85 00
L9608:
        LDA z:$00                  ; $9608: A5 00
        JMP a:$9612                ; $960A: 4C 12 96
L960D:
        INY                        ; $960D: C8
        LDA ($E7),y                ; $960E: B1 E7
        AND #$70                   ; $9610: 29 70
        LSR a                      ; $9612: 4A
        LSR a                      ; $9613: 4A
        LSR a                      ; $9614: 4A
        LSR a                      ; $9615: 4A
L9616:
        STA z:$00                  ; $9616: 85 00
        LDA a:$0730,x              ; $9618: BD 30 07
        BPL L965F                  ; $961B: 10 42
        LDA a:$072A                ; $961D: AD 2A 07
        CMP a:$0725                ; $9620: CD 25 07
        BEQ L9636                  ; $9623: F0 11
        LDY a:$072C                ; $9625: AC 2C 07
        LDA ($E7),y                ; $9628: B1 E7
        AND #$0F                   ; $962A: 29 0F
        CMP #$0E                   ; $962C: C9 0E
        BNE L9635                  ; $962E: D0 05
        LDA a:$0728                ; $9630: AD 28 07
        BNE L9656                  ; $9633: D0 21
L9635:
        RTS                        ; $9635: 60
L9636:
        LDA a:$0728                ; $9636: AD 28 07
        BEQ L9646                  ; $9639: F0 0B
        LDA #$00                   ; $963B: A9 00
        STA a:$0728                ; $963D: 8D 28 07
        STA a:$0729                ; $9640: 8D 29 07
        STA z:$08                  ; $9643: 85 08
        RTS                        ; $9645: 60
L9646:
        LDY a:$072C                ; $9646: AC 2C 07
        LDA ($E7),y                ; $9649: B1 E7
        AND #$F0                   ; $964B: 29 F0
        LSR a                      ; $964D: 4A
        LSR a                      ; $964E: 4A
        LSR a                      ; $964F: 4A
        LSR a                      ; $9650: 4A
        CMP a:$0726                ; $9651: CD 26 07
        BNE L9635                  ; $9654: D0 DF
L9656:
        LDA a:$072C                ; $9656: AD 2C 07
        STA a:$072D,x              ; $9659: 9D 2D 07
        JSR a:$9589                ; $965C: 20 89 95
L965F:
        LDA z:$00                  ; $965F: A5 00
        CLC                        ; $9661: 18
        ADC z:$07                  ; $9662: 65 07
        JSR a:$8E04                ; $9664: 20 04 8E
        .byte $E5,$98,$40,$97,$2E,$9A,$3E,$9A,$F2,$99,$50,$9A,$59,$9A,$E5,$98   ; $9667
        .byte $41,$9B,$BA,$97,$79,$99,$7C,$99,$7F,$99,$57,$99,$68,$99,$6B,$99   ; $9677
        .byte $D0,$99,$D7,$99,$06,$98,$B7,$9A,$AB,$98,$94,$99,$0E,$9B,$0E,$9B   ; $9687
        .byte $0E,$9B,$01,$9B,$19,$9B   ; $9697
        ORA a:$199B,y              ; $969D: 19 9B 19
        .byte $9B,$14,$9B,$19,$9B,$6F,$98,$19,$9A,$D3,$9A,$82,$98,$9E,$99,$09   ; $96A0
        .byte $9A,$0E,$9A,$01,$9A,$F2,$96,$0D,$97,$0D,$97,$2B,$97,$2B,$97,$2B   ; $96B0
        .byte $97,$45,$96,$C5,$96,$BC,$2D,$07,$C8,$B1,$E7,$48,$29,$40,$D0,$12   ; $96C0
        .byte $68,$48,$29,$0F,$8D,$27,$07,$68,$29,$30,$4A,$4A,$4A,$4A,$8D,$42   ; $96D0
        .byte $07,$60,$68,$29,$07,$C9,$04,$90,$05,$8D,$44,$07,$A9,$00,$8D,$41   ; $96E0
        .byte $07,$60,$A2,$04,$AD,$5F,$07,$F0,$08,$E8,$AC,$4E,$07,$88,$D0,$01   ; $96F0
        .byte $E8,$8A,$8D,$D6,$06,$20,$08,$88,$A9,$0D,$20,$16,$97,$AD,$23,$07   ; $9700
        .byte $49,$01,$8D,$23,$07,$60   ; $9710
        STA z:$00                  ; $9716: 85 00
        LDA #$00                   ; $9718: A9 00
        LDX #$04                   ; $971A: A2 04
L971C:
        LDY z:$16,x                ; $971C: B4 16
        CPY z:$00                  ; $971E: C4 00
        BNE L9724                  ; $9720: D0 02
        STA z:$0F,x                ; $9722: 95 0F
L9724:
        DEX                        ; $9724: CA
        BPL L971C                  ; $9725: 10 F5
        RTS                        ; $9727: 60
        .byte $14,$17,$18,$A6,$00,$BD,$20,$97,$A0,$05,$88,$30,$07,$D9,$16,$00   ; $9728
        .byte $D0,$F8,$A9,$00,$8D,$CD,$06,$60   ; $9738
        LDA a:$0733                ; $9740: AD 33 07
        JSR a:$8E04                ; $9743: 20 04 8E
        .byte $4C,$97,$78,$97,$69,$9A   ; $9746
        JSR a:$9BBB                ; $974C: 20 BB 9B
        LDA a:$0730,x              ; $974F: BD 30 07
        BEQ L9773                  ; $9752: F0 1F
        BPL L9767                  ; $9754: 10 11
        TYA                        ; $9756: 98
        STA a:$0730,x              ; $9757: 9D 30 07
        LDA a:$0725                ; $975A: AD 25 07
        ORA a:$0726                ; $975D: 0D 26 07
        BEQ L9767                  ; $9760: F0 05
        LDA #$16                   ; $9762: A9 16
        JMP a:$97B0                ; $9764: 4C B0 97
L9767:
        LDX z:$07                  ; $9767: A6 07
        LDA #$17                   ; $9769: A9 17
        STA a:$06A1,x              ; $976B: 9D A1 06
        LDA #$4C                   ; $976E: A9 4C
        JMP a:$97AA                ; $9770: 4C AA 97
L9773:
        LDA #$18                   ; $9773: A9 18
        JMP a:$97B0                ; $9775: 4C B0 97
        JSR a:$9BAC                ; $9778: 20 AC 9B
        STY z:$06                  ; $977B: 84 06
        BCC L978B                  ; $977D: 90 0C
        LDA a:$0730,x              ; $977F: BD 30 07
        LSR a                      ; $9782: 4A
        STA a:$0736,x              ; $9783: 9D 36 07
        LDA #$19                   ; $9786: A9 19
        JMP a:$97B0                ; $9788: 4C B0 97
L978B:
        LDA #$1B                   ; $978B: A9 1B
        LDY a:$0730,x              ; $978D: BC 30 07
        BEQ L97B0                  ; $9790: F0 1E
        LDA a:$0736,x              ; $9792: BD 36 07
        STA z:$06                  ; $9795: 85 06
        LDX z:$07                  ; $9797: A6 07
        LDA #$1A                   ; $9799: A9 1A
        STA a:$06A1,x              ; $979B: 9D A1 06
        CPY z:$06                  ; $979E: C4 06
        BNE L97CE                  ; $97A0: D0 2C
        INX                        ; $97A2: E8
        LDA #$4F                   ; $97A3: A9 4F
        STA a:$06A1,x              ; $97A5: 9D A1 06
        LDA #$50                   ; $97A8: A9 50
        INX                        ; $97AA: E8
        LDY #$0F                   ; $97AB: A0 0F
        JMP a:$9B7D                ; $97AD: 4C 7D 9B
L97B0:
        LDX z:$07                  ; $97B0: A6 07
        LDY #$00                   ; $97B2: A0 00
        JMP a:$9B7D                ; $97B4: 4C 7D 9B
        .byte $42,$41,$43   ; $97B7
        JSR a:$9BAC                ; $97BA: 20 AC 9B
        LDY #$00                   ; $97BD: A0 00
        BCS L97C8                  ; $97BF: B0 07
        INY                        ; $97C1: C8
        LDA a:$0730,x              ; $97C2: BD 30 07
        BNE L97C8                  ; $97C5: D0 01
        INY                        ; $97C7: C8
L97C8:
        LDA a:$97B7,y              ; $97C8: B9 B7 97
        STA a:$06A1                ; $97CB: 8D A1 06
L97CE:
        RTS                        ; $97CE: 60
        .byte $00,$45,$45,$45,$00,$00,$48,$47,$46,$00,$45,$49,$49,$49,$45,$47   ; $97CF
        .byte $47,$4A,$47,$47,$47,$47,$4B,$47,$47,$49,$49,$49,$49,$49,$47,$4A   ; $97DF
        .byte $47,$4A,$47,$47,$4B,$47,$4B,$47,$47,$47,$47,$47,$47,$4A,$47,$4A   ; $97EF
        .byte $47,$4A,$4B,$47,$4B,$47,$4B   ; $97FF
        JSR a:$9BBB                ; $9806: 20 BB 9B
        STY z:$07                  ; $9809: 84 07
        LDY #$04                   ; $980B: A0 04
        JSR a:$9BAF                ; $980D: 20 AF 9B
        TXA                        ; $9810: 8A
        PHA                        ; $9811: 48
        LDY a:$0730,x              ; $9812: BC 30 07
        LDX z:$07                  ; $9815: A6 07
        LDA #$0B                   ; $9817: A9 0B
        STA z:$06                  ; $9819: 85 06
L981B:
        LDA a:$97CF,y              ; $981B: B9 CF 97
        STA a:$06A1,x              ; $981E: 9D A1 06
        INX                        ; $9821: E8
        LDA z:$06                  ; $9822: A5 06
        BEQ L982D                  ; $9824: F0 07
        INY                        ; $9826: C8
        INY                        ; $9827: C8
        INY                        ; $9828: C8
        INY                        ; $9829: C8
        INY                        ; $982A: C8
        DEC z:$06                  ; $982B: C6 06
L982D:
        CPX #$0B                   ; $982D: E0 0B
        BNE L981B                  ; $982F: D0 EA
        PLA                        ; $9831: 68
        TAX                        ; $9832: AA
        LDA a:$0725                ; $9833: AD 25 07
        BEQ L986E                  ; $9836: F0 36
        LDA a:$0730,x              ; $9838: BD 30 07
        CMP #$01                   ; $983B: C9 01
        BEQ L9869                  ; $983D: F0 2A
        LDY z:$07                  ; $983F: A4 07
        BNE L9847                  ; $9841: D0 04
        CMP #$03                   ; $9843: C9 03
        BEQ L9869                  ; $9845: F0 22
L9847:
        CMP #$02                   ; $9847: C9 02
        BNE L986E                  ; $9849: D0 23
        JSR a:$9BCB                ; $984B: 20 CB 9B
        PHA                        ; $984E: 48
        JSR a:$994A                ; $984F: 20 4A 99
        PLA                        ; $9852: 68
        STA z:$87,x                ; $9853: 95 87
        LDA a:$0725                ; $9855: AD 25 07
        STA z:$6E,x                ; $9858: 95 6E
        LDA #$01                   ; $985A: A9 01
        STA z:$B6,x                ; $985C: 95 B6
        STA z:$0F,x                ; $985E: 95 0F
        LDA #$90                   ; $9860: A9 90
        STA z:$CF,x                ; $9862: 95 CF
        LDA #$31                   ; $9864: A9 31
        STA z:$16,x                ; $9866: 95 16
        RTS                        ; $9868: 60
L9869:
        LDY #$52                   ; $9869: A0 52
        STY a:$06AB                ; $986B: 8C AB 06
L986E:
        RTS                        ; $986E: 60
        JSR a:$9BBB                ; $986F: 20 BB 9B
        LDY a:$0730,x              ; $9872: BC 30 07
        LDX z:$07                  ; $9875: A6 07
        LDA #$6B                   ; $9877: A9 6B
        STA a:$06A1,x              ; $9879: 9D A1 06
        LDA #$6C                   ; $987C: A9 6C
        STA a:$06A2,x              ; $987E: 9D A2 06
        RTS                        ; $9881: 60
        .byte $A0,$03,$20,$AF,$9B,$A0,$0A,$20,$B3,$98,$B0,$10,$A2,$06,$A9,$00   ; $9882
        .byte $9D,$A1,$06,$CA,$10,$F8,$B9,$DD,$98,$8D,$A8,$06,$60,$15,$14,$00   ; $9892
        .byte $00,$15,$1E,$1D,$1C,$15,$21,$20,$1F   ; $98A2
        LDY #$03                   ; $98AB: A0 03
        JSR a:$9BAF                ; $98AD: 20 AF 9B
        JSR a:$9BBB                ; $98B0: 20 BB 9B
        DEY                        ; $98B3: 88
        DEY                        ; $98B4: 88
        STY z:$05                  ; $98B5: 84 05
        LDY a:$0730,x              ; $98B7: BC 30 07
        STY z:$06                  ; $98BA: 84 06
        LDX z:$05                  ; $98BC: A6 05
        INX                        ; $98BE: E8
        LDA a:$989F,y              ; $98BF: B9 9F 98
        CMP #$00                   ; $98C2: C9 00
        BEQ L98CE                  ; $98C4: F0 08
        LDX #$00                   ; $98C6: A2 00
        LDY z:$05                  ; $98C8: A4 05
        JSR a:$9B7D                ; $98CA: 20 7D 9B
        CLC                        ; $98CD: 18
L98CE:
        LDY z:$06                  ; $98CE: A4 06
        LDA a:$98A3,y              ; $98D0: B9 A3 98
        STA a:$06A1,x              ; $98D3: 9D A1 06
        LDA a:$98A7,y              ; $98D6: B9 A7 98
        STA a:$06A2,x              ; $98D9: 9D A2 06
        RTS                        ; $98DC: 60
        .byte $11,$10,$15,$14,$13,$12,$15,$14   ; $98DD
        JSR a:$9939                ; $98E5: 20 39 99
        LDA z:$00                  ; $98E8: A5 00
        BEQ L98F0                  ; $98EA: F0 04
        INY                        ; $98EC: C8
        INY                        ; $98ED: C8
        INY                        ; $98EE: C8
        INY                        ; $98EF: C8
L98F0:
        TYA                        ; $98F0: 98
        PHA                        ; $98F1: 48
        LDA a:$0760                ; $98F2: AD 60 07
        ORA a:$075F                ; $98F5: 0D 5F 07
        BEQ L9925                  ; $98F8: F0 2B
        LDY a:$0730,x              ; $98FA: BC 30 07
        BEQ L9925                  ; $98FD: F0 26
        JSR a:$994A                ; $98FF: 20 4A 99
        BCS L9925                  ; $9902: B0 21
        JSR a:$9BCB                ; $9904: 20 CB 9B
        CLC                        ; $9907: 18
        ADC #$08                   ; $9908: 69 08
        STA z:$87,x                ; $990A: 95 87
        LDA a:$0725                ; $990C: AD 25 07
        ADC #$00                   ; $990F: 69 00
        STA z:$6E,x                ; $9911: 95 6E
        LDA #$01                   ; $9913: A9 01
        STA z:$B6,x                ; $9915: 95 B6
        STA z:$0F,x                ; $9917: 95 0F
        JSR a:$9BD3                ; $9919: 20 D3 9B
        STA z:$CF,x                ; $991C: 95 CF
        LDA #$0D                   ; $991E: A9 0D
        STA z:$16,x                ; $9920: 95 16
        JSR a:$C787                ; $9922: 20 87 C7
L9925:
        PLA                        ; $9925: 68
        TAY                        ; $9926: A8
        LDX z:$07                  ; $9927: A6 07
        LDA a:$98DD,y              ; $9929: B9 DD 98
        STA a:$06A1,x              ; $992C: 9D A1 06
        INX                        ; $992F: E8
        LDA a:$98DF,y              ; $9930: B9 DF 98
        LDY z:$06                  ; $9933: A4 06
        DEY                        ; $9935: 88
        JMP a:$9B7D                ; $9936: 4C 7D 9B
        LDY #$01                   ; $9939: A0 01
        JSR a:$9BAF                ; $993B: 20 AF 9B
        JSR a:$9BBB                ; $993E: 20 BB 9B
        TYA                        ; $9941: 98
        AND #$07                   ; $9942: 29 07
        STA z:$06                  ; $9944: 85 06
        LDY a:$0730,x              ; $9946: BC 30 07
        RTS                        ; $9949: 60
        LDX #$00                   ; $994A: A2 00
L994C:
        CLC                        ; $994C: 18
        LDA z:$0F,x                ; $994D: B5 0F
        BEQ L9956                  ; $994F: F0 05
        INX                        ; $9951: E8
        CPX #$05                   ; $9952: E0 05
        BNE L994C                  ; $9954: D0 F6
L9956:
        RTS                        ; $9956: 60
        JSR a:$9BAC                ; $9957: 20 AC 9B
        LDA #$86                   ; $995A: A9 86
        STA a:$06AB                ; $995C: 8D AB 06
        LDX #$0B                   ; $995F: A2 0B
        LDY #$01                   ; $9961: A0 01
        LDA #$87                   ; $9963: A9 87
        JMP a:$9B7D                ; $9965: 4C 7D 9B
        LDA #$03                   ; $9968: A9 03
        .byte $2C   ; $996A
        LDA #$07                   ; $996B: A9 07
        PHA                        ; $996D: 48
        JSR a:$9BAC                ; $996E: 20 AC 9B
        PLA                        ; $9971: 68
        TAX                        ; $9972: AA
        LDA #$C0                   ; $9973: A9 C0
        STA a:$06A1,x              ; $9975: 9D A1 06
        RTS                        ; $9978: 60
        LDA #$06                   ; $9979: A9 06
        .byte $2C   ; $997B
        LDA #$07                   ; $997C: A9 07
        .byte $2C   ; $997E
        LDA #$09                   ; $997F: A9 09
        PHA                        ; $9981: 48
        JSR a:$9BAC                ; $9982: 20 AC 9B
        PLA                        ; $9985: 68
        TAX                        ; $9986: AA
        LDA #$0B                   ; $9987: A9 0B
        STA a:$06A1,x              ; $9989: 9D A1 06
        INX                        ; $998C: E8
        LDY #$00                   ; $998D: A0 00
        LDA #$63                   ; $998F: A9 63
        JMP a:$9B7D                ; $9991: 4C 7D 9B
        JSR a:$9BBB                ; $9994: 20 BB 9B
        LDX #$02                   ; $9997: A2 02
        LDA #$6D                   ; $9999: A9 6D
        JMP a:$9B7D                ; $999B: 4C 7D 9B
        .byte $A9,$24,$8D,$A1,$06,$A2,$01,$A0,$08,$A9,$25,$20,$7D,$9B,$A9,$61   ; $999E
        .byte $8D,$AB,$06,$20,$CB,$9B,$38,$E9,$08,$85,$8C,$AD,$25,$07,$E9,$00   ; $99AE
        .byte $85,$73,$A9,$30,$85,$D4,$A9,$B0,$8D,$0D,$01,$A9,$30,$85,$1B,$E6   ; $99BE
        .byte $14,$60   ; $99CE
        LDX #$00                   ; $99D0: A2 00
        LDY #$0F                   ; $99D2: A0 0F
        JMP a:$99E9                ; $99D4: 4C E9 99
        TXA                        ; $99D7: 8A
        PHA                        ; $99D8: 48
        LDX #$01                   ; $99D9: A2 01
        LDY #$0F                   ; $99DB: A0 0F
        LDA #$44                   ; $99DD: A9 44
        JSR a:$9B7D                ; $99DF: 20 7D 9B
        PLA                        ; $99E2: 68
        TAX                        ; $99E3: AA
        JSR a:$9BBB                ; $99E4: 20 BB 9B
        LDX #$01                   ; $99E7: A2 01
        LDA #$40                   ; $99E9: A9 40
        JMP a:$9B7D                ; $99EB: 4C 7D 9B
        .byte $C3,$C2,$C2,$C2   ; $99EE
        LDY a:$074E                ; $99F2: AC 4E 07
        LDA a:$99EE,y              ; $99F5: B9 EE 99
        JMP a:$9A44                ; $99F8: 4C 44 9A
        .byte $06,$07,$08,$C5,$0C,$89,$A0,$0C,$20,$AF,$9B,$4C,$0E,$9A,$A9,$08   ; $99FB
        .byte $8D,$73,$07,$A4,$00,$BE,$F9,$99,$B9,$FC,$99,$4C,$20,$9A,$20,$BB   ; $9A0B
        .byte $9B,$A6,$07,$A9,$C4,$A0,$00,$4C,$7D,$9B,$69,$61,$61,$62,$22,$51   ; $9A1B
        .byte $52,$52,$88   ; $9A2B
        LDY a:$074E                ; $9A2E: AC 4E 07
        LDA a:$0743                ; $9A31: AD 43 07
        BEQ L9A38                  ; $9A34: F0 02
        LDY #$04                   ; $9A36: A0 04
L9A38:
        LDA a:$9A29,y              ; $9A38: B9 29 9A
        JMP a:$9A44                ; $9A3B: 4C 44 9A
        LDY a:$074E                ; $9A3E: AC 4E 07
        LDA a:$9A25,y              ; $9A41: B9 25 9A
        PHA                        ; $9A44: 48
        JSR a:$9BAC                ; $9A45: 20 AC 9B
        LDX z:$07                  ; $9A48: A6 07
        LDY #$00                   ; $9A4A: A0 00
        PLA                        ; $9A4C: 68
        JMP a:$9B7D                ; $9A4D: 4C 7D 9B
        LDY a:$074E                ; $9A50: AC 4E 07
        LDA a:$9A29,y              ; $9A53: B9 29 9A
        JMP a:$9A5F                ; $9A56: 4C 5F 9A
        LDY a:$074E                ; $9A59: AC 4E 07
        LDA a:$9A25,y              ; $9A5C: B9 25 9A
        PHA                        ; $9A5F: 48
        JSR a:$9BBB                ; $9A60: 20 BB 9B
        PLA                        ; $9A63: 68
        LDX z:$07                  ; $9A64: A6 07
        JMP a:$9B7D                ; $9A66: 4C 7D 9B
        JSR a:$9BBB                ; $9A69: 20 BB 9B
        LDX z:$07                  ; $9A6C: A6 07
        LDA #$64                   ; $9A6E: A9 64
        STA a:$06A1,x              ; $9A70: 9D A1 06
        INX                        ; $9A73: E8
        DEY                        ; $9A74: 88
        BMI L9A85                  ; $9A75: 30 0E
        LDA #$65                   ; $9A77: A9 65
        STA a:$06A1,x              ; $9A79: 9D A1 06
        INX                        ; $9A7C: E8
        DEY                        ; $9A7D: 88
        BMI L9A85                  ; $9A7E: 30 05
        LDA #$66                   ; $9A80: A9 66
        JSR a:$9B7D                ; $9A82: 20 7D 9B
L9A85:
        LDX a:$046A                ; $9A85: AE 6A 04
        JSR a:$9BD3                ; $9A88: 20 D3 9B
        STA a:$0477,x              ; $9A8B: 9D 77 04
        LDA a:$0725                ; $9A8E: AD 25 07
        STA a:$046B,x              ; $9A91: 9D 6B 04
        JSR a:$9BCB                ; $9A94: 20 CB 9B
        STA a:$0471,x              ; $9A97: 9D 71 04
        INX                        ; $9A9A: E8
        CPX #$06                   ; $9A9B: E0 06
        BCC L9AA1                  ; $9A9D: 90 02
        LDX #$00                   ; $9A9F: A2 00
L9AA1:
        STX a:$046A                ; $9AA1: 8E 6A 04
        RTS                        ; $9AA4: 60
        .byte $07,$07,$06,$05,$04,$03,$02,$01,$00,$03,$03,$04,$05,$06,$07,$08   ; $9AA5
        .byte $09,$0A   ; $9AB5
        JSR a:$9BAC                ; $9AB7: 20 AC 9B
        BCC L9AC1                  ; $9ABA: 90 05
        LDA #$09                   ; $9ABC: A9 09
        STA a:$0734                ; $9ABE: 8D 34 07
L9AC1:
        DEC a:$0734                ; $9AC1: CE 34 07
        LDY a:$0734                ; $9AC4: AC 34 07
        LDX a:$9AAE,y              ; $9AC7: BE AE 9A
        LDA a:$9AA5,y              ; $9ACA: B9 A5 9A
        TAY                        ; $9ACD: A8
        LDA #$61                   ; $9ACE: A9 61
        JMP a:$9B7D                ; $9AD0: 4C 7D 9B
        .byte $20,$BB,$9B,$20,$4A,$99,$20,$CB,$9B,$95,$87,$AD,$25,$07,$95,$6E   ; $9AD3
        .byte $20,$D3,$9B,$95,$CF,$95,$58,$A9,$32,$95,$16,$A0,$01,$94,$B6,$F6   ; $9AE3
        .byte $0F,$A6,$07,$A9,$67,$9D,$A1,$06,$A9,$68,$9D,$A2,$06,$60   ; $9AF3
        LDA a:$075D                ; $9B01: AD 5D 07
        BEQ L9B3C                  ; $9B04: F0 36
        LDA #$00                   ; $9B06: A9 00
        STA a:$075D                ; $9B08: 8D 5D 07
        JMP a:$9B19                ; $9B0B: 4C 19 9B
        JSR a:$9B36                ; $9B0E: 20 36 9B
        JMP a:$9B2C                ; $9B11: 4C 2C 9B
        LDA #$00                   ; $9B14: A9 00
        STA a:$06BC                ; $9B16: 8D BC 06
        JSR a:$9B36                ; $9B19: 20 36 9B
        STY z:$07                  ; $9B1C: 84 07
        LDA #$00                   ; $9B1E: A9 00
        LDY a:$074E                ; $9B20: AC 4E 07
        DEY                        ; $9B23: 88
        BEQ L9B28                  ; $9B24: F0 02
        LDA #$05                   ; $9B26: A9 05
L9B28:
        CLC                        ; $9B28: 18
        ADC z:$07                  ; $9B29: 65 07
        TAY                        ; $9B2B: A8
        LDA a:$BDE8,y              ; $9B2C: B9 E8 BD
        PHA                        ; $9B2F: 48
        JSR a:$9BBB                ; $9B30: 20 BB 9B
        JMP a:$9A48                ; $9B33: 4C 48 9A
        LDA z:$00                  ; $9B36: A5 00
        SEC                        ; $9B38: 38
        SBC #$00                   ; $9B39: E9 00
        TAY                        ; $9B3B: A8
L9B3C:
        RTS                        ; $9B3C: 60
        .byte $87,$00,$00,$00   ; $9B3D
        JSR a:$9BAC                ; $9B41: 20 AC 9B
        BCC L9B73                  ; $9B44: 90 2D
        LDA a:$074E                ; $9B46: AD 4E 07
        BNE L9B73                  ; $9B49: D0 28
        LDX a:$046A                ; $9B4B: AE 6A 04
        JSR a:$9BCB                ; $9B4E: 20 CB 9B
        SEC                        ; $9B51: 38
        SBC #$10                   ; $9B52: E9 10
        STA a:$0471,x              ; $9B54: 9D 71 04
        LDA a:$0725                ; $9B57: AD 25 07
        SBC #$00                   ; $9B5A: E9 00
        STA a:$046B,x              ; $9B5C: 9D 6B 04
        INY                        ; $9B5F: C8
        INY                        ; $9B60: C8
        TYA                        ; $9B61: 98
        ASL a                      ; $9B62: 0A
        ASL a                      ; $9B63: 0A
        ASL a                      ; $9B64: 0A
        ASL a                      ; $9B65: 0A
        STA a:$0477,x              ; $9B66: 9D 77 04
        INX                        ; $9B69: E8
        CPX #$05                   ; $9B6A: E0 05
        BCC L9B70                  ; $9B6C: 90 02
        LDX #$00                   ; $9B6E: A2 00
L9B70:
        STX a:$046A                ; $9B70: 8E 6A 04
L9B73:
        LDX a:$074E                ; $9B73: AE 4E 07
        LDA a:$9B3D,x              ; $9B76: BD 3D 9B
        LDX #$08                   ; $9B79: A2 08
        LDY #$0F                   ; $9B7B: A0 0F
L9B7D:
        STY a:$0735                ; $9B7D: 8C 35 07
        LDY a:$06A1,x              ; $9B80: BC A1 06
        BEQ L9B9D                  ; $9B83: F0 18
        CPY #$17                   ; $9B85: C0 17
        BEQ L9BA0                  ; $9B87: F0 17
        CPY #$1A                   ; $9B89: C0 1A
        BEQ L9BA0                  ; $9B8B: F0 13
        CPY #$C0                   ; $9B8D: C0 C0
        BEQ L9B9D                  ; $9B8F: F0 0C
        CPY #$C0                   ; $9B91: C0 C0
        BCS L9BA0                  ; $9B93: B0 0B
        CPY #$54                   ; $9B95: C0 54
        BNE L9B9D                  ; $9B97: D0 04
        CMP #$50                   ; $9B99: C9 50
        BEQ L9BA0                  ; $9B9B: F0 03
L9B9D:
        STA a:$06A1,x              ; $9B9D: 9D A1 06
L9BA0:
        INX                        ; $9BA0: E8
        CPX #$0D                   ; $9BA1: E0 0D
        BCS L9BAB                  ; $9BA3: B0 06
        LDY a:$0735                ; $9BA5: AC 35 07
        DEY                        ; $9BA8: 88
        BPL L9B7D                  ; $9BA9: 10 D2
L9BAB:
        RTS                        ; $9BAB: 60
        JSR a:$9BBB                ; $9BAC: 20 BB 9B
        LDA a:$0730,x              ; $9BAF: BD 30 07
        CLC                        ; $9BB2: 18
        BPL L9BBA                  ; $9BB3: 10 05
        TYA                        ; $9BB5: 98
        STA a:$0730,x              ; $9BB6: 9D 30 07
        SEC                        ; $9BB9: 38
L9BBA:
        RTS                        ; $9BBA: 60
        LDY a:$072D,x              ; $9BBB: BC 2D 07
        LDA ($E7),y                ; $9BBE: B1 E7
        AND #$0F                   ; $9BC0: 29 0F
        STA z:$07                  ; $9BC2: 85 07
        INY                        ; $9BC4: C8
        LDA ($E7),y                ; $9BC5: B1 E7
        AND #$0F                   ; $9BC7: 29 0F
        TAY                        ; $9BC9: A8
        RTS                        ; $9BCA: 60
        LDA a:$0726                ; $9BCB: AD 26 07
        ASL a                      ; $9BCE: 0A
        ASL a                      ; $9BCF: 0A
        ASL a                      ; $9BD0: 0A
        ASL a                      ; $9BD1: 0A
        RTS                        ; $9BD2: 60
        LDA z:$07                  ; $9BD3: A5 07
        ASL a                      ; $9BD5: 0A
        ASL a                      ; $9BD6: 0A
        ASL a                      ; $9BD7: 0A
        ASL a                      ; $9BD8: 0A
        CLC                        ; $9BD9: 18
        ADC #$20                   ; $9BDA: 69 20
        RTS                        ; $9BDC: 60
        .byte $00,$D0,$05,$05   ; $9BDD
        PHA                        ; $9BE1: 48
        LSR a                      ; $9BE2: 4A
        LSR a                      ; $9BE3: 4A
        LSR a                      ; $9BE4: 4A
        LSR a                      ; $9BE5: 4A
        TAY                        ; $9BE6: A8
        LDA a:$9BDF,y              ; $9BE7: B9 DF 9B
        STA z:$07                  ; $9BEA: 85 07
        PLA                        ; $9BEC: 68
        AND #$0F                   ; $9BED: 29 0F
        CLC                        ; $9BEF: 18
        ADC a:$9BDD,y              ; $9BF0: 79 DD 9B
        STA z:$06                  ; $9BF3: 85 06
        RTS                        ; $9BF5: 60
        .byte $FF,$FF,$12,$36,$0E,$0E,$0E,$32,$32,$32,$0A,$26,$40   ; $9BF6
        JSR a:$9C13                ; $9C03: 20 13 9C
        STA a:$0750                ; $9C06: 8D 50 07
        AND #$60                   ; $9C09: 29 60
        ASL a                      ; $9C0B: 0A
        ROL a                      ; $9C0C: 2A
        ROL a                      ; $9C0D: 2A
        ROL a                      ; $9C0E: 2A
        STA a:$074E                ; $9C0F: 8D 4E 07
        RTS                        ; $9C12: 60
        LDY a:$075F                ; $9C13: AC 5F 07
        LDA a:$9CB4,y              ; $9C16: B9 B4 9C
        CLC                        ; $9C19: 18
        ADC a:$0760                ; $9C1A: 6D 60 07
        TAY                        ; $9C1D: A8
        LDA a:$9CBC,y              ; $9C1E: B9 BC 9C
        RTS                        ; $9C21: 60
        LDA a:$0750                ; $9C22: AD 50 07
        JSR a:$9C09                ; $9C25: 20 09 9C
        TAY                        ; $9C28: A8
        LDA a:$0750                ; $9C29: AD 50 07
        AND #$1F                   ; $9C2C: 29 1F
        STA a:$074F                ; $9C2E: 8D 4F 07
        LDA a:$9CE0,y              ; $9C31: B9 E0 9C
        CLC                        ; $9C34: 18
        ADC a:$074F                ; $9C35: 6D 4F 07
        TAY                        ; $9C38: A8
        LDA a:$9CE4,y              ; $9C39: B9 E4 9C
        STA z:$E9                  ; $9C3C: 85 E9
        LDA a:$9D06,y              ; $9C3E: B9 06 9D
        STA z:$EA                  ; $9C41: 85 EA
        LDY a:$074E                ; $9C43: AC 4E 07
        LDA a:$9D28,y              ; $9C46: B9 28 9D
        CLC                        ; $9C49: 18
        ADC a:$074F                ; $9C4A: 6D 4F 07
        TAY                        ; $9C4D: A8
        LDA a:$9D2C,y              ; $9C4E: B9 2C 9D
        STA z:$E7                  ; $9C51: 85 E7
        LDA a:$9D4E,y              ; $9C53: B9 4E 9D
        STA z:$E8                  ; $9C56: 85 E8
        LDY #$00                   ; $9C58: A0 00
        LDA ($E7),y                ; $9C5A: B1 E7
        PHA                        ; $9C5C: 48
        AND #$07                   ; $9C5D: 29 07
        CMP #$04                   ; $9C5F: C9 04
        BCC L9C68                  ; $9C61: 90 05
        STA a:$0744                ; $9C63: 8D 44 07
        LDA #$00                   ; $9C66: A9 00
L9C68:
        STA a:$0741                ; $9C68: 8D 41 07
        PLA                        ; $9C6B: 68
        PHA                        ; $9C6C: 48
        AND #$38                   ; $9C6D: 29 38
        LSR a                      ; $9C6F: 4A
        LSR a                      ; $9C70: 4A
        LSR a                      ; $9C71: 4A
        STA a:$0710                ; $9C72: 8D 10 07
        PLA                        ; $9C75: 68
        AND #$C0                   ; $9C76: 29 C0
        CLC                        ; $9C78: 18
        ROL a                      ; $9C79: 2A
        ROL a                      ; $9C7A: 2A
        ROL a                      ; $9C7B: 2A
        STA a:$0715                ; $9C7C: 8D 15 07
        INY                        ; $9C7F: C8
        LDA ($E7),y                ; $9C80: B1 E7
        PHA                        ; $9C82: 48
        AND #$0F                   ; $9C83: 29 0F
        STA a:$0727                ; $9C85: 8D 27 07
        PLA                        ; $9C88: 68
        PHA                        ; $9C89: 48
        AND #$30                   ; $9C8A: 29 30
        LSR a                      ; $9C8C: 4A
        LSR a                      ; $9C8D: 4A
        LSR a                      ; $9C8E: 4A
        LSR a                      ; $9C8F: 4A
        STA a:$0742                ; $9C90: 8D 42 07
        PLA                        ; $9C93: 68
        AND #$C0                   ; $9C94: 29 C0
        CLC                        ; $9C96: 18
        ROL a                      ; $9C97: 2A
        ROL a                      ; $9C98: 2A
        ROL a                      ; $9C99: 2A
        CMP #$03                   ; $9C9A: C9 03
        BNE L9CA3                  ; $9C9C: D0 05
        STA a:$0743                ; $9C9E: 8D 43 07
        LDA #$00                   ; $9CA1: A9 00
L9CA3:
        STA a:$0733                ; $9CA3: 8D 33 07
        LDA z:$E7                  ; $9CA6: A5 E7
        CLC                        ; $9CA8: 18
        ADC #$02                   ; $9CA9: 69 02
        STA z:$E7                  ; $9CAB: 85 E7
        LDA z:$E8                  ; $9CAD: A5 E8
        ADC #$00                   ; $9CAF: 69 00
        STA z:$E8                  ; $9CB1: 85 E8
        RTS                        ; $9CB3: 60
        .byte $00,$05,$0A,$0E,$13,$17,$1B,$20,$25,$29,$C0,$26,$60,$28,$29,$01   ; $9CB4
        .byte $27,$62,$24,$35,$20,$63,$22,$29,$41,$2C,$61,$2A,$31,$26,$62,$2E   ; $9CC4
        .byte $23,$2D,$60,$33,$29,$01,$27,$64,$30,$32,$21,$65,$1F,$06,$1C,$00   ; $9CD4
        .byte $70,$97,$B0,$DF,$0A,$1F,$59,$7E,$9B,$A9,$D0,$01,$1F,$3C,$51,$7B   ; $9CE4
        .byte $7C,$A0,$A9,$CE,$F1,$FA,$FB,$35,$60,$8E,$AA,$B3,$D8   ; $9CF4
        ORA z:$33                  ; $9D01: 05 33
        RTS                        ; $9D03: 60
        .byte $71,$9B,$9D,$9D,$9D,$9D,$9E,$9E,$9E,$9E,$9E,$9E,$9E,$9F,$9F,$9F   ; $9D04
        .byte $9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$9F,$A0,$A0,$A0,$A0,$A0,$A0,$A1   ; $9D14
        .byte $A1,$A1,$A1,$A1,$00,$03,$19,$1C,$06,$45,$C0,$6B,$CE,$37,$8A,$19   ; $9D24
        .byte $8E,$F3,$48,$CD,$32,$3B,$7A,$8F,$F6,$5B,$CE,$FF,$92,$05,$7E,$D7   ; $9D34
        .byte $02,$35,$D8,$79,$AF,$10,$8F,$02,$6F,$FA,$AE,$AE,$AE,$A4,$A4,$A5   ; $9D44
        .byte $A5,$A6,$A6,$A6,$A7,$A7,$A8,$A8,$A8,$A8,$A8,$A9,$A9,$A9,$AA,$AB   ; $9D54
        .byte $AB,$AB,$AC,$AC,$AC,$AD,$A1,$A2,$A2,$A3,$A3,$A3,$76,$DD,$BB,$4C   ; $9D64
        .byte $EA,$1D,$1B,$CC,$56,$5D,$16,$9D,$C6,$1D,$36,$9D   ; $9D74
        CMP #$1D                   ; $9D80: C9 1D
        .byte $04,$DB,$49,$1D,$84,$1B,$C9,$5D,$88,$95,$0F,$08,$30,$4C,$78,$2D   ; $9D82
        .byte $A6,$28,$90,$B5,$FF,$0F,$03,$56,$1B,$C9,$1B,$0F,$07,$36,$1B,$AA   ; $9D92
        .byte $1B,$48,$95,$0F,$0A,$2A,$1B,$5B,$0C,$78,$2D,$90,$B5,$FF,$0B,$8C   ; $9DA2
        .byte $4B,$4C,$77,$5F,$EB,$0C,$BD,$DB,$19,$9D,$75,$1D,$7D,$5B,$D9,$1D   ; $9DB2
        .byte $3D,$DD,$99,$1D,$26,$9D,$5A,$2B,$8A,$2C,$CA,$1B,$20,$95,$7B,$5C   ; $9DC2
        .byte $DB,$4C,$1B,$CC,$3B,$CC,$78,$2D,$A6,$28,$90,$B5,$FF,$0B,$8C,$3B   ; $9DD2
        .byte $1D,$8B,$1D,$AB,$0C,$DB,$1D,$0F,$03,$65,$1D,$6B,$1B,$05,$9D,$0B   ; $9DE2
        .byte $1B,$05,$9B,$0B,$1D,$8B,$0C,$1B,$8C,$70,$15,$7B,$0C,$DB,$0C,$0F   ; $9DF2
        .byte $08,$78,$2D,$A6,$28,$90,$B5,$FF,$27,$A9,$4B,$0C,$68,$29,$0F,$06   ; $9E02
        .byte $77,$1B,$0F,$0B,$60,$15,$4B,$8C,$78,$2D,$90,$B5,$FF,$0F,$03,$8E   ; $9E12
        .byte $65,$E1,$BB,$38,$6D,$A8,$3E,$E5,$E7,$0F,$08,$0B,$02,$2B,$02,$5E   ; $9E22
        .byte $65,$E1,$BB,$0E,$DB,$0E,$BB,$8E,$DB,$0E,$FE,$65,$EC,$0F,$0D,$4E   ; $9E32
        .byte $65,$E1,$0F,$0E,$4E,$02,$E0,$0F,$10,$FE,$E5,$E1,$1B,$85,$7B,$0C   ; $9E42
        .byte $5B,$95,$78,$2D,$90,$B5,$FF,$A5,$86,$E4,$28,$18,$A8,$45,$83,$69   ; $9E52
        .byte $03,$C6,$29,$9B,$83,$16,$A4,$88,$24,$E9,$28,$05,$A8,$7B,$28,$24   ; $9E62
        .byte $8F,$C8,$03,$E8,$03,$46,$A8,$85,$24,$C8,$24,$FF,$EB,$8E,$0F,$03   ; $9E72
        .byte $FB,$05,$17,$85,$DB,$8E,$0F,$07,$57,$05,$7B,$05,$9B,$80,$2B,$85   ; $9E82
        .byte $FB,$05,$0F,$0B,$1B,$05,$9B,$05,$FF,$2E,$C2,$66,$E2,$11,$0F,$07   ; $9E92
        .byte $02,$11,$0F,$0C,$12,$11,$FF,$0E,$C2,$A8,$AB,$00,$BB,$8E,$6B,$82   ; $9EA2
        .byte $DE,$00,$A0,$33,$86,$43,$06,$3E,$B4,$A0,$CB,$02,$0F,$07,$7E,$42   ; $9EB2
        .byte $A6,$83,$02,$0F,$0A,$3B,$02,$CB,$37,$0F,$0C,$E3,$0E,$FF,$9B,$8E   ; $9EC2
        .byte $CA,$0E,$EE,$42,$44,$5B,$86,$80,$B8,$1B,$80,$50,$BA,$10,$B7,$5B   ; $9ED2
        .byte $00,$17,$85,$4B,$05,$FE,$34,$40,$B7,$86,$C6,$06,$5B,$80,$83,$00   ; $9EE2
        .byte $D0,$38,$5B,$8E,$8A,$0E,$A6,$00,$BB,$0E,$C5,$80,$F3,$00,$FF,$1E   ; $9EF2
        .byte $C2,$00,$6B,$06,$8B,$86,$63,$B7,$0F,$05,$03,$06,$23,$06,$4B,$B7   ; $9F02
        .byte $BB,$00,$5B,$B7,$FB,$37,$3B,$B7,$0F,$0B,$1B,$37,$FF,$2B,$D7,$E3   ; $9F12
        .byte $03,$C2,$86,$E2,$06,$76,$A5,$A3,$8F,$03,$86,$2B,$57,$68,$28,$E9   ; $9F22
        .byte $28,$E5,$83,$24,$8F,$36,$A8,$5B,$03,$FF,$0F,$02,$78,$40,$48,$CE   ; $9F32
        .byte $F8,$C3,$F8,$C3,$0F,$07,$7B,$43,$C6,$D0,$0F,$8A,$C8,$50,$FF,$85   ; $9F42
        .byte $86,$0B,$80,$1B,$00,$DB,$37,$77,$80,$EB,$37,$FE,$2B,$20,$2B,$80   ; $9F52
        .byte $7B,$38,$AB,$B8,$77,$86,$FE,$42,$20,$49,$86,$8B,$06,$9B,$80,$7B   ; $9F62
        .byte $8E,$5B,$B7,$9B,$0E,$BB,$0E,$9B,$80,$FF,$0B,$80,$60,$38,$10,$B8   ; $9F72
        .byte $C0,$3B,$DB,$8E,$40,$B8,$F0,$38,$7B,$8E,$A0,$B8,$C0,$B8,$FB,$00   ; $9F82
        .byte $A0,$B8,$30,$BB,$EE,$42,$88,$0F,$0B,$2B,$0E,$67,$0E,$FF,$0A,$AA   ; $9F92
        .byte $0E,$28,$2A,$0E,$31,$88,$FF,$C7,$83,$D7,$03,$42,$8F,$7A,$03,$05   ; $9FA2
        .byte $A4,$78,$24,$A6,$25,$E4,$25,$4B,$83,$E3,$03,$05,$A4,$89,$24,$B5   ; $9FB2
        .byte $24,$09,$A4,$65,$24,$C9,$24,$0F,$08,$85,$25,$FF,$CD,$A5,$B5,$A8   ; $9FC2
        .byte $07,$A8,$76,$28,$CC,$25,$65,$A4,$A9,$24,$E5,$24,$19,$A4,$0F,$07   ; $9FD2
        .byte $95,$28,$E6,$24,$19,$A4,$D7,$29,$16,$A9,$58,$29,$97,$29,$FF,$0F   ; $9FE2
        .byte $02,$02,$11,$0F,$07,$02,$11,$FF,$FF,$2B,$82,$AB,$38,$DE,$42,$E2   ; $9FF2
        .byte $1B,$B8,$EB,$3B,$DB,$80,$8B,$B8,$1B,$82,$FB,$B8,$7B,$80,$FB,$3C   ; $A002
        .byte $5B,$BC,$7B,$B8,$1B,$8E,$CB,$0E,$1B,$8E,$0F,$0D,$2B,$3B,$BB,$B8   ; $A012
        .byte $EB,$82,$4B,$B8,$BB,$38,$3B,$B7,$BB,$02,$0F,$13,$1B,$00,$CB,$80   ; $A022
        .byte $6B,$BC,$FF,$7B,$80,$AE,$00,$80,$8B,$8E,$E8,$05,$F9,$86,$17,$86   ; $A032
        .byte $16,$85,$4E,$2B,$80,$AB,$8E,$87,$85,$C3,$05,$8B,$82,$9B,$02,$AB   ; $A042
        .byte $02,$BB,$86,$CB,$06,$D3,$03,$3B,$8E,$6B,$0E,$A7,$8E,$FF   ; $A052
        AND #$8E                   ; $A060: 29 8E
        .byte $52,$11,$83,$0E,$0F,$03,$9B,$0E,$2B,$8E,$5B,$0E,$CB,$8E,$FB,$0E   ; $A062
        .byte $FB,$82,$9B,$82,$BB,$02,$FE,$42,$E8,$BB,$8E,$0F,$0A,$AB,$0E,$CB   ; $A072
        .byte $0E,$F9,$0E,$88,$86   ; $A082
        LDX z:$06                  ; $A087: A6 06
        .byte $DB,$02,$B6,$8E,$FF,$AB,$CE,$DE,$42,$C0,$CB,$CE,$5B,$8E,$1B,$CE   ; $A089
        .byte $4B,$85,$67,$45,$0F,$07,$2B,$00,$7B,$85,$97,$05,$0F,$0A,$92,$02   ; $A099
        .byte $FF,$0A,$AA,$0E,$24,$4A,$1E,$23,$AA,$FF,$1B,$80,$BB,$38,$4B,$BC   ; $A0A9
        .byte $EB,$3B,$0F,$04,$2B,$00,$AB,$38,$EB,$00,$CB,$8E,$FB,$80,$AB,$B8   ; $A0B9
        .byte $6B,$80,$FB,$3C,$9B,$BB,$5B,$BC,$FB,$00,$6B,$B8,$FB,$38,$FF,$0B   ; $A0C9
        .byte $86,$1A,$06,$DB,$06,$DE,$C2,$02,$F0,$3B,$BB,$80,$EB,$06,$0B,$86   ; $A0D9
        .byte $93,$06,$F0,$39,$0F   ; $A0E9
        ASL z:$60                  ; $A0EE: 06 60
        CLV                        ; $A0F0: B8
        .byte $1B,$86,$A0,$B9,$B7,$27,$BD,$27,$2B,$83,$A1,$26,$A9   ; $A0F1
        ROL z:$EE                  ; $A0FE: 26 EE
        AND z:$0B                  ; $A100: 25 0B
        .byte $27,$B4,$FF,$0F,$02,$1E,$2F,$60,$E0,$3A,$A5,$A7,$DB,$80,$3B,$82   ; $A102
        .byte $8B,$02,$FE,$42,$68,$70,$BB,$25,$A7,$2C,$27,$B2,$26,$B9,$26,$9B   ; $A112
        .byte $80,$A8,$82,$B5,$27,$BC,$27,$B0,$BB,$3B,$82,$87,$34,$EE,$25,$6B   ; $A122
        .byte $FF,$1E,$A5,$0A,$2E,$28,$27,$2E,$33,$C7,$0F,$03,$1E,$40,$07,$2E   ; $A132
        .byte $30,$E7,$0F,$05,$1E,$24,$44,$0F,$07,$1E,$22,$6A,$2E,$23,$AB,$0F   ; $A142
        .byte $09,$1E,$41,$68,$1E,$2A,$8A,$2E,$23,$A2,$2E,$32,$EA,$FF,$3B,$87   ; $A152
        .byte $66,$27,$CC,$27,$EE,$31,$87,$EE,$23,$A7,$3B,$87,$DB,$07,$FF,$0F   ; $A162
        .byte $01,$2E,$25,$2B,$2E,$25,$4B,$4E,$25,$CB,$6B,$07,$97,$47,$E9,$87   ; $A172
        .byte $47,$C7,$7A,$07,$D6,$C7,$78,$07,$38,$87,$AB,$47,$E3,$07,$9B,$87   ; $A182
        .byte $0F,$09,$68,$47,$DB,$C7,$3B,$C7,$FF,$47,$9B,$CB,$07,$FA,$1D,$86   ; $A192
        .byte $9B,$3A,$87,$56,$07,$88,$1B,$07,$9D,$2E,$65,$F0,$FF,$9B,$07,$05   ; $A1A2
        .byte $32,$06,$33,$07,$34,$CE,$03,$DC,$51,$EE,$07,$73,$E0,$74,$0A,$7E   ; $A1B2
        .byte $06,$9E,$0A,$CE,$06,$E4,$00,$E8,$0A,$FE,$0A,$2E,$89,$4E,$0B,$54   ; $A1C2
        .byte $0A,$14,$8A,$C4,$0A,$34,$8A,$7E,$06,$C7,$0A,$01,$E0,$02,$0A,$47   ; $A1D2
        .byte $0A,$81,$60,$82,$0A,$C7,$0A,$0E,$87,$7E,$02,$A7,$02,$B3,$02,$D7   ; $A1E2
        .byte $02,$E3,$02,$07,$82,$13,$02,$3E,$06,$7E,$02,$AE,$07,$FE,$0A,$0D   ; $A1F2
        .byte $C4,$CD,$43,$CE,$09,$DE,$0B,$DD,$42,$FE,$02,$5D,$C7,$FD,$5B,$07   ; $A202
        .byte $05,$32,$06,$33,$07,$34,$5E,$0A,$68,$64,$98,$64,$A8,$64,$CE,$06   ; $A212
        .byte $FE,$02,$0D,$01,$1E,$0E,$7E,$02,$94,$63,$B4,$63,$D4,$63,$F4,$63   ; $A222
        .byte $14,$E3,$2E,$0E,$5E,$02,$64,$35,$88,$72,$BE,$0E,$0D,$04,$AE,$02   ; $A232
        .byte $CE,$08,$CD,$4B,$FE,$02,$0D,$05,$68,$31,$7E,$0A,$96,$31,$A9,$63   ; $A242
        .byte $A8,$33,$D5,$30,$EE,$02,$E6,$62,$F4,$61,$04,$B1,$08,$3F,$44,$33   ; $A252
        .byte $94,$63,$A4,$31,$E4,$31,$04,$BF,$08,$3F,$04,$BF,$08,$3F,$CD,$4B   ; $A262
        .byte $03,$E4,$0E,$03,$2E,$01,$7E,$06,$BE,$02,$DE,$06,$FE,$0A,$0D,$C4   ; $A272
        .byte $CD,$43,$CE,$09,$DE,$0B,$DD,$42,$FE,$02,$5D,$C7,$FD,$9B,$07,$05   ; $A282
        .byte $32,$06,$33,$07,$34,$FE,$00,$27,$B1,$65,$32,$75,$0A,$71,$00,$B7   ; $A292
        .byte $31,$08,$E4,$18,$64,$1E,$04,$57,$3B,$BB,$0A,$17,$8A,$27,$3A,$73   ; $A2A2
        .byte $0A,$7B,$0A,$D7   ; $A2B2
        ASL a                      ; $A2B6: 0A
        .byte $E7,$3A,$3B,$8A,$97   ; $A2B7
        ASL a                      ; $A2BC: 0A
        INC a:$2408,x              ; $A2BD: FE 08 24
        TXA                        ; $A2C0: 8A
        ROL a:$3E00                ; $A2C1: 2E 00 3E
        RTI                        ; $A2C4: 40
        .byte $38,$64,$6F,$00,$9F,$00,$BE,$43,$C8,$0A,$C9,$63,$CE,$07,$FE,$07   ; $A2C5
        .byte $2E,$81,$66,$42,$6A,$42,$79,$0A,$BE,$00,$C8,$64,$F8,$64,$08,$E4   ; $A2D5
        .byte $2E,$07,$7E,$03,$9E,$07,$BE,$03,$DE,$07,$FE,$0A,$03,$A5,$0D,$44   ; $A2E5
        .byte $CD,$43,$CE,$09,$DD,$42,$DE,$0B,$FE,$02,$5D,$C7,$FD,$9B,$07,$05   ; $A2F5
        .byte $32,$06,$33,$07,$34,$FE,$06,$0C,$81,$39,$0A,$5C,$01,$89,$0A,$AC   ; $A305
        .byte $01,$D9,$0A,$FC,$01,$2E,$83,$A7,$01,$B7,$00,$C7,$01,$DE,$0A,$FE   ; $A315
        .byte $02,$4E,$83,$5A,$32,$63,$0A,$69,$0A,$7E,$02,$EE,$03,$FA,$32,$03   ; $A325
        .byte $8A,$09,$0A,$1E,$02,$EE,$03,$FA,$32,$03,$8A,$09,$0A,$14,$42,$1E   ; $A335
        .byte $02,$7E,$0A,$9E,$07,$FE,$0A,$2E,$86,$5E,$0A,$8E,$06,$BE,$0A,$EE   ; $A345
        .byte $07,$3E,$83,$5E,$07,$FE,$0A,$0D,$C4,$41,$52,$51,$52,$CD,$43,$CE   ; $A355
        .byte $09,$DE,$0B,$DD,$42,$FE,$02,$5D,$C7,$FD,$5B,$07,$05,$32,$06,$33   ; $A365
        .byte $07,$34,$FE,$0A,$AE,$86,$BE,$07,$FE,$02,$0D,$02,$27,$32,$46,$61   ; $A375
        .byte $55,$62,$5E,$0E,$1E,$82,$68,$3C,$74,$3A,$7D,$4B,$5E,$8E,$7D,$4B   ; $A385
        .byte $7E,$82,$84,$62,$94,$61,$A4,$31,$BD,$4B,$CE,$06,$FE,$02,$0D,$06   ; $A395
        .byte $34,$31,$3E,$0A,$64,$32,$75,$0A,$7B,$61,$A4,$33,$AE,$02,$DE,$0E   ; $A3A5
        .byte $3E,$82,$64,$32,$78,$32,$B4,$36,$C8,$36,$DD,$4B,$44,$B2,$58,$32   ; $A3B5
        .byte $94,$63,$A4,$3E,$BA,$30,$C9,$61,$CE,$06,$DD,$4B,$CE,$86,$DD,$4B   ; $A3C5
        .byte $FE,$02,$2E,$86,$5E,$02,$7E,$06,$FE,$02,$1E,$86,$3E,$02,$5E,$06   ; $A3D5
        .byte $7E,$02,$9E,$06,$FE,$0A,$0D,$C4,$CD,$43,$CE,$09,$DE,$0B,$DD,$42   ; $A3E5
        .byte $FE,$02,$5D,$C7,$FD,$5B,$06,$05,$32,$06,$33,$07,$34,$5E,$0A,$AE   ; $A3F5
        .byte $02,$0D,$01,$39,$73,$0D,$03,$39,$7B,$4D,$4B,$DE,$06,$1E,$8A,$AE   ; $A405
        .byte $06,$C4,$33,$16,$FE,$A5,$77,$FE,$02,$FE,$82,$0D,$07,$39,$73,$A8   ; $A415
        .byte $74,$ED,$4B,$49,$FB,$E8,$74,$FE,$0A,$2E,$82,$67,$02,$84,$7A,$87   ; $A425
        .byte $31,$0D,$0B,$FE,$02,$0D,$0C,$39,$73,$5E,$06,$C6,$76,$45,$FF,$BE   ; $A435
        .byte $0A,$DD,$48,$FE,$06,$3D,$CB,$46,$7E,$AD,$4A,$FE,$82,$39,$F3,$A9   ; $A445
        .byte $7B,$4E,$8A,$9E,$07,$FE,$0A,$0D,$C4,$CD,$43,$CE,$09,$DE,$0B,$DD   ; $A455
        .byte $42,$FE,$02,$5D,$C7,$FD,$94,$11,$0F,$26,$FE,$10,$28,$94,$65,$15   ; $A465
        .byte $EB,$12,$FA,$41,$4A,$96,$54,$40,$A4,$42,$B7,$13,$E9,$19,$F5,$15   ; $A475
        .byte $11,$80,$47,$42,$71,$13,$80,$41,$15,$92,$1B,$1F,$24,$40,$55,$12   ; $A485
        .byte $64,$40,$95,$12,$A4,$40,$D2,$12,$E1,$40,$13,$C0,$2C,$17,$2F,$12   ; $A495
        .byte $49,$13,$83,$40,$9F,$14,$A3,$40,$17,$92,$83,$13,$92,$41   ; $A4A5
        LDA a:$C514,y              ; $A4B3: B9 14 C5
        .byte $12,$C8,$40,$D4,$40,$4B,$92,$78,$1B,$9C,$94,$9F,$11,$DF,$14,$FE   ; $A4B6
        .byte $11,$7D,$C1,$9E,$42,$CF,$20,$FD,$90,$B1,$0F,$26,$29,$91,$7E,$42   ; $A4C6
        .byte $FE,$40,$28,$92,$4E,$42,$2E,$C0,$57,$73,$C3,$25,$C7,$27,$23,$84   ; $A4D6
        .byte $33,$20,$5C,$01,$77,$63,$88,$62,$99,$61,$AA,$60,$BC,$01,$EE,$42   ; $A4E6
        .byte $4E,$C0,$69,$11,$7E,$42,$DE,$40,$F8,$62,$0E,$C2,$AE,$40,$D7,$63   ; $A4F6
        .byte $E7,$63,$33,$A7,$37,$27,$43,$04,$CC,$01,$E7,$73,$0C   ; $A506
        STA ($3E,x)                ; $A513: 81 3E
        .byte $42,$0D,$0A,$5E,$40,$88,$72,$BE,$42,$E7,$87,$FE,$40,$39,$E1,$4E   ; $A515
        .byte $00,$69,$60,$87,$60,$A5,$60,$C3,$31,$FE,$31,$6D,$C1,$BE,$42,$EF   ; $A525
        JSR a:$52FD                ; $A535: 20 FD 52
        AND ($0F,x)                ; $A538: 21 0F
        JSR a:$406E                ; $A53A: 20 6E 40
        CLI                        ; $A53D: 58
        .byte $F2,$93,$01,$97,$00,$0C,$81,$97,$40,$A6,$41,$C7,$40,$0D,$04,$03   ; $A53E
        .byte $01,$07,$01,$23,$01,$27,$01,$EC,$03,$AC,$F3,$C3,$03,$78,$E2,$94   ; $A54E
        .byte $43,$47,$F3,$74,$43,$47,$FB,$74,$43,$2C,$F1,$4C,$63,$47,$00,$57   ; $A55E
        .byte $21,$5C,$01,$7C,$72,$39,$F1,$EC,$02,$4C,$81,$D8,$62,$EC,$01,$0D   ; $A56E
        .byte $0D,$0F,$38,$C7,$07,$ED,$4A,$1D,$C1,$5F,$26,$FD,$54,$21,$0F,$26   ; $A57E
        .byte $A7,$22,$37,$FB,$73,$20,$83,$07,$87,$02,$93,$20,$C7,$73,$04,$F1   ; $A58E
        .byte $06,$31,$39,$71,$59,$71,$E7,$73,$37,$A0,$47,$04,$86,$7C,$E5,$71   ; $A59E
        .byte $E7,$31,$33,$A4,$39,$71,$A9,$71,$D3,$23,$08,$F2,$13,$05,$27,$02   ; $A5AE
        .byte $49,$71,$75,$75,$E8,$72,$67,$F3,$99,$71,$E7,$20,$F4,$72,$F7,$31   ; $A5BE
        .byte $17,$A0,$33,$20,$39,$71,$73,$28,$BC,$05,$39,$F1,$79,$71,$A6,$21   ; $A5CE
        .byte $C3,$06,$D3,$20,$DC,$00,$FC,$00,$07,$A2,$13,$21,$5F,$32,$8C,$00   ; $A5DE
        .byte $98,$7A,$C7,$63,$D9,$61,$03,$A2,$07,$22,$74,$72,$77,$31,$E7,$73   ; $A5EE
        .byte $39,$F1,$58,$72,$77,$73,$D8,$72,$7F,$B1,$97,$73,$B6,$64,$C5,$65   ; $A5FE
        .byte $D4,$66,$E3,$67,$F3,$67,$8D,$C1,$CF,$26,$FD,$52,$31,$0F,$20,$6E   ; $A60E
        .byte $66,$07,$81,$36,$01,$66,$00,$A7,$22,$08,$F2,$67,$7B,$DC,$02,$98   ; $A61E
        .byte $F2,$D7,$20,$39,$F1,$9F,$33,$DC,$27,$DC,$57,$23,$83,$57,$63,$6C   ; $A62E
        .byte $51,$87,$63,$99,$61,$A3,$06,$B3,$21,$77,$F3,$F3,$21,$F7,$2A,$13   ; $A63E
        .byte $81,$23,$22,$53,$00,$63,$22,$E9,$0B,$0C,$83,$13,$21,$16,$22,$33   ; $A64E
        .byte $05,$8F,$35,$EC,$01,$63,$A0,$67,$20,$73,$01,$77,$01,$83,$20,$87   ; $A65E
        .byte $20,$B3,$20,$B7,$20,$C3,$01,$C7,$00,$D3,$20,$D7,$20,$67,$A0,$77   ; $A66E
        .byte $07,$87,$22,$E8,$62,$F5,$65,$1C,$82,$7F,$38,$8D,$C1,$CF,$26,$FD   ; $A67E
        .byte $50,$21,$07,$81,$47,$24,$57,$00,$63   ; $A68E
        ORA ($77,x)                ; $A697: 01 77
        ORA ($C9,x)                ; $A699: 01 C9
        ADC ($68),y                ; $A69B: 71 68
        .byte $F2,$E7,$73,$97,$FB,$06,$83,$5C,$01,$D7,$22,$E7,$00,$03,$A7,$6C   ; $A69D
        .byte $02,$B3,$22,$E3,$01,$E7,$07,$47,$A0,$57,$06,$A7,$01,$D3,$00,$D7   ; $A6AD
        .byte $01,$07,$81,$67,$20,$93,$22,$03,$A3,$1C,$61,$17,$21,$6F,$33,$C7   ; $A6BD
        .byte $63,$D8,$62,$E9,$61,$FA,$60,$4F,$B3,$87,$63,$9C,$01,$B7,$63,$C8   ; $A6CD
        .byte $62,$D9,$61,$EA,$60,$39,$F1,$87,$21,$A7,$01,$B7,$20,$39,$F1,$5F   ; $A6DD
        .byte $38,$6D,$C1,$AF,$26,$FD,$90,$11,$0F,$26,$FE,$10,$2A,$93,$87,$17   ; $A6ED
        .byte $A3,$14,$B2,$42,$0A,$92,$19,$40,$36,$14,$50,$41,$82,$16,$2B,$93   ; $A6FD
        .byte $24,$41,$BB,$14,$B8,$00,$C2,$43,$C3,$13,$1B,$94,$67,$12,$C4,$15   ; $A70D
        .byte $53,$C1,$D2,$41,$12,$C1,$29,$13,$85,$17,$1B,$92,$1A,$42,$47,$13   ; $A71D
        .byte $83,$41,$A7,$13,$0E,$91,$A7,$63,$B7,$63,$C5,$65,$D5,$65,$DD,$4A   ; $A72D
        .byte $E3,$67,$F3,$67,$8D,$C1,$AE,$42,$DF,$20,$FD,$90,$11,$0F,$26,$6E   ; $A73D
        .byte $10,$8B,$17,$AF,$32,$D8,$62,$E8,$62,$FC,$3F,$AD,$C8,$F8,$64,$0C   ; $A74D
        .byte $BE,$43,$43,$F8,$64,$0C,$BF,$73,$40,$84,$40,$93,$40,$A4,$40,$B3   ; $A75D
        .byte $40,$F8,$64,$48,$E4,$5C,$39,$83,$40,$92,$41,$B3,$40,$F8,$64,$48   ; $A76D
        .byte $E4,$5C,$39,$F8,$64,$13,$C2,$37,$65,$4C,$24,$63,$00,$97,$65,$C3   ; $A77D
        .byte $42,$0B,$97,$AC,$32,$F8,$64,$0C,$BE,$53,$45,$9D,$48,$F8,$64,$2A   ; $A78D
        .byte $E2,$3C,$47,$56,$43,$BA,$62,$F8,$64,$0C,$B7,$88,$64,$BC,$31,$D4   ; $A79D
        .byte $45,$FC,$31,$3C,$B1,$78,$64,$8C,$38,$0B,$9C,$1A,$33,$18,$61,$28   ; $A7AD
        .byte $61,$39,$60,$5D,$4A,$EE,$11,$0F,$B8,$1D,$C1,$3E,$42,$6F,$20,$FD   ; $A7BD
        .byte $52,$31,$0F,$20,$6E,$40,$F7,$20,$07,$84,$17,$20,$4F,$34,$C3,$03   ; $A7CD
        .byte $C7,$02,$D3,$22,$27,$E3,$39,$61,$E7,$73,$5C,$E4,$57,$00,$6C,$73   ; $A7DD
        .byte $47,$A0,$53,$06,$63,$22,$A7,$73,$FC,$73,$13,$A1,$33,$05,$43,$21   ; $A7ED
        .byte $5C,$72,$C3,$23,$CC,$03,$77,$FB,$AC,$02,$39,$F1,$A7,$73,$D3,$04   ; $A7FD
        .byte $E8,$72,$E3,$22,$26,$F4,$BC,$02,$8C,$81,$A8,$62,$17,$87,$43,$24   ; $A80D
        .byte $A7,$01,$C3,$04,$08,$F2,$97,$21,$A3,$02,$C9,$0B,$E1,$69,$F1,$69   ; $A81D
        .byte $8D,$C1,$CF,$26,$FD,$38,$11,$0F,$26,$AD,$40,$3D,$C7,$FD,$95,$B1   ; $A82D
        .byte $0F,$26,$0D,$02,$C8,$72,$1C,$81,$38,$72,$0D,$05,$97,$34,$98,$62   ; $A83D
        .byte $A3,$20,$B3,$06,$C3,$20,$CC,$03,$F9,$91,$2C,$81,$48,$62,$0D,$09   ; $A84D
        .byte $37,$63,$47,$03,$57,$21,$8C,$02,$C5,$79,$C7,$31,$F9,$11,$39,$F1   ; $A85D
        .byte $A9,$11,$6F,$B4,$D3,$65,$E3,$65,$7D,$C1,$BF,$26,$FD,$00,$C1,$4C   ; $A86D
        .byte $00,$F4,$4F,$0D,$02,$02,$42,$43,$4F,$52,$C2,$DE,$00,$5A,$C2,$4D   ; $A87D
        .byte $C7,$FD,$90,$51,$0F,$26,$EE,$10,$0B,$94,$33,$14,$42,$42,$77,$16   ; $A88D
        .byte $86,$44,$02,$92,$4A,$16,$69,$42,$73,$14,$B0,$00,$C7,$12,$05,$C0   ; $A89D
        .byte $1C,$17,$1F,$11,$36,$12,$8F,$14,$91,$40,$1B,$94,$35,$12,$34,$42   ; $A8AD
        RTS                        ; $A8BD: 60
        .byte $42,$61,$12,$87,$12,$96,$40,$A3,$14,$1C,$98,$1F,$11,$47,$12,$9F   ; $A8BE
        .byte $15,$CC,$15,$CF,$11,$05,$C0,$1F,$15,$39,$12,$7C,$16,$7F,$11,$82   ; $A8CE
        .byte $40,$98,$12,$DF,$15,$16,$C4,$17,$14,$54,$12,$9B,$16,$28,$94,$CE   ; $A8DE
        .byte $01,$3D,$C1,$5E,$42,$8F,$20,$FD,$97,$11,$0F,$26,$FE,$10,$2B,$92   ; $A8EE
        .byte $57,$12,$8B,$12   ; $A8FE
        CPY #$41                   ; $A902: C0 41
        .byte $F7,$13,$5B,$92,$69,$0B,$BB,$12,$B2,$46,$19,$93,$71,$00,$17,$94   ; $A904
        .byte $7C,$14,$7F,$11,$93,$41,$BF,$15,$FC,$13,$FF,$11,$2F,$95,$50,$42   ; $A914
        .byte $51,$12,$58,$14,$A6,$12,$DB,$12,$1B,$93,$46,$43,$7B,$12,$8D,$49   ; $A924
        .byte $B7,$14,$1B,$94,$49,$0B,$BB,$12,$FC,$13,$FF,$12,$03,$C1,$2F,$15   ; $A934
        .byte $43,$12,$4B,$13,$77,$13,$9D,$4A,$15,$C1,$A1,$41,$C3,$12,$FE,$01   ; $A944
        .byte $7D,$C1,$9E,$42,$CF,$20,$FD,$52,$21,$0F,$20,$6E,$44,$0C,$F1,$4C   ; $A954
        .byte $01,$AA,$35,$D9,$34,$EE,$20,$08,$B3,$37,$32,$43,$04,$4E,$21,$53   ; $A964
        .byte $20,$7C,$01,$97,$21,$B7,$07,$9C,$81,$E7,$42,$5F,$B3,$97,$63,$AC   ; $A974
        .byte $02,$C5,$41,$49,$E0,$58,$61,$76,$64,$85,$65,$94,$66,$A4,$22,$A6   ; $A984
        .byte $03,$C8,$22,$DC,$02,$68,$F2,$96,$42,$13,$82,$17,$02,$AF,$34,$F6   ; $A994
        .byte $21,$FC,$06,$26,$80,$2A,$24,$36,$01,$8C,$00,$FF,$35,$4E,$A0,$55   ; $A9A4
        .byte $21,$77,$20,$87,$07,$89,$22,$AE,$21,$4C,$82,$9F,$34,$EC,$01,$03   ; $A9B4
        .byte $E7,$13,$67,$8D,$4A,$AD,$41,$0F,$A6,$FD,$10,$51,$4C,$00,$C7,$12   ; $A9C4
        .byte $C6,$42,$03,$92,$02,$42,$29,$12,$63,$12,$62,$42,$69,$14,$A5,$12   ; $A9D4
        .byte $A4,$42,$E2,$14,$E1,$44,$F8,$16,$37,$C1,$8F,$38,$02,$BB,$28,$7A   ; $A9E4
        .byte $68,$7A,$A8,$7A,$E0,$6A,$F0,$6A,$6D,$C5,$FD,$92,$31,$0F,$20,$6E   ; $A9F4
        .byte $40,$0D,$02,$37,$73,$EC,$00,$0C,$80,$3C,$00,$6C,$00,$9C,$00,$06   ; $AA04
        .byte $C0,$C7,$73,$06,$83,$28,$72,$96,$40,$E7,$73,$26,$C0,$87,$7B,$D2   ; $AA14
        .byte $41,$39,$F1,$C8,$F2,$97,$E3,$A3,$23,$E7,$02,$E3,$07,$F3,$22,$37   ; $AA24
        .byte $E3,$9C,$00,$BC,$00,$EC,$00,$0C,$80,$3C,$00,$86,$21,$A6,$06,$B6   ; $AA34
        .byte $24,$5C,$80,$7C,$00,$9C,$00,$29   ; $AA44
        SBC ($DC,x)                ; $AA4C: E1 DC
        ORA z:$F6                  ; $AA4E: 05 F6
        EOR ($DC,x)                ; $AA50: 41 DC
        .byte $80,$E8,$72,$0C,$81,$27,$73,$4C,$01,$66,$74,$0D,$11,$3F,$35,$B6   ; $AA52
        .byte $41,$2C,$82,$36,$40,$7C,$02,$86,$40,$F9,$61,$39,$E1,$AC,$04,$C6   ; $AA62
        .byte $41,$0C,$83,$16,$41,$88,$F2,$39,$F1,$7C,$00,$89,$61,$9C,$00,$A7   ; $AA72
        .byte $63,$BC,$00,$C5,$65,$DC,$00,$E3,$67,$F3,$67,$8D,$C1,$CF,$26,$FD   ; $AA82
        .byte $55,$B1,$0F,$26,$CF,$33,$07,$B2,$15,$11,$52,$42,$99,$0B,$AC,$02   ; $AA92
        .byte $D3,$24,$D6,$42,$D7,$25,$23,$84,$CF,$33,$07,$E3,$19,$61,$78,$7A   ; $AAA2
        .byte $EF,$33,$2C,$81,$46,$64,$55,$65,$65,$65,$EC,$74,$47,$82,$53,$05   ; $AAB2
        .byte $63,$21,$62,$41,$96,$22,$9A,$41,$CC,$03,$B9,$91,$39,$F1,$63,$26   ; $AAC2
        .byte $67,$27,$D3,$06,$FC,$01,$18,$E2,$D9,$07,$E9,$04,$0C,$86,$37,$22   ; $AAD2
        .byte $93,$24,$87,$84,$AC,$02,$C2,$41,$C3,$23,$D9,$71,$FC,$01,$7F,$B1   ; $AAE2
        .byte $9C,$00,$A7,$63,$B6,$64,$CC,$00,$D4,$66,$E3,$67,$F3,$67,$8D,$C1   ; $AAF2
        .byte $CF,$26,$FD,$50,$B1,$0F,$26,$FC,$00,$1F,$B3,$5C,$00,$65,$65,$74   ; $AB02
        .byte $66,$83,$67,$93,$67,$DC,$73,$4C,$80,$B3,$20,$C9,$0B,$C3,$08,$D3   ; $AB12
        .byte $2F,$DC,$00,$2C,$80,$4C,$00,$8C,$00,$D3,$2E,$ED,$4A,$FC,$00,$D7   ; $AB22
        .byte $A1,$EC,$01,$4C,$80,$59,$11,$D8,$11,$DA,$10,$37,$A0,$47,$04,$99   ; $AB32
        .byte $11,$E7,$21,$3A,$90,$67,$20,$76,$10,$77,$60,$87,$07,$D8,$12,$39   ; $AB42
        .byte $F1,$AC,$00,$E9,$71,$0C,$80,$2C,$00,$4C,$05,$C7,$7B,$39,$F1,$EC   ; $AB52
        .byte $00,$F9,$11,$0C,$82,$6F,$34,$F8,$11,$FA,$10,$7F,$B2,$AC,$00,$B6   ; $AB62
        .byte $64,$CC,$01,$E3,$67,$F3,$67,$8D,$C1,$CF,$26,$FD,$52,$B1,$0F,$20   ; $AB72
        .byte $6E,$45,$39,$91,$B3,$04,$C3,$21,$C8,$11,$CA,$10,$49,$91,$7C,$73   ; $AB82
        .byte $E8,$12,$88,$91,$8A,$10,$E7,$21,$05,$91,$07,$30,$17,$07,$27,$20   ; $AB92
        .byte $49,$11,$9C,$01,$C8,$72,$23,$A6,$27,$26,$D3,$03,$D8,$7A,$89,$91   ; $ABA2
        .byte $D8,$72,$39,$F1,$A9,$11,$09,$F1,$63,$24,$67,$24,$D8,$62,$28,$91   ; $ABB2
        .byte $2A,$10,$56,$21,$70,$04,$79,$0B,$8C,$00,$94,$21,$9F,$35,$2F,$B8   ; $ABC2
        .byte $3D,$C1,$7F,$26,$FD,$06,$C1,$4C,$00,$F4,$4F,$0D,$02,$06,$20,$24   ; $ABD2
        .byte $4F,$35,$A0,$36,$20,$53,$46,$D5,$20,$D6,$20,$34,$A1,$73,$49,$74   ; $ABE2
        .byte $20,$94,$20,$B4,$20,$D4,$20,$F4,$20,$2E,$80,$59,$42,$4D,$C7,$FD   ; $ABF2
        .byte $96,$31,$0F   ; $AC02
        ROL z:$0D                  ; $AC05: 26 0D
        .byte $03,$1A,$60,$77,$42,$C4,$00,$C8,$62,$B9,$E1,$D3,$06,$D7,$07,$F9   ; $AC07
        .byte $61,$0C,$81,$4E,$B1,$8E,$B1,$BC,$01   ; $AC17
        CPX z:$50                  ; $AC20: E4 50
        SBC #$61                   ; $AC22: E9 61
        .byte $0C,$81,$0D,$0A,$84,$43,$98,$72,$0D,$0C,$0F,$38,$1D,$C1,$5F,$26   ; $AC24
        .byte $FD,$48,$0F,$0E,$01,$5E,$02,$A7,$00,$BC,$73,$1A,$E0,$39,$61,$58   ; $AC34
        .byte $62,$77,$63,$97,$63,$B8,$62,$D6,$07,$F8,$62,$19,$E1,$75,$52,$86   ; $AC44
        .byte $40,$87,$50,$95,$52,$93,$43,$A5,$21,$C5,$52,$D6,$40,$D7,$20,$E5   ; $AC54
        .byte $06,$E6,$51,$3E,$8D,$5E,$03,$67,$52,$77,$52,$7E,$02,$9E,$03,$A6   ; $AC64
        .byte $43,$A7,$23,$DE,$05,$FE,$02,$1E,$83,$33,$54,$46,$40,$47,$21,$56   ; $AC74
        .byte $04,$5E,$02,$83,$54,$93,$52,$96,$07,$97,$50,$BE,$03,$C7,$23,$FE   ; $AC84
        .byte $02,$0C,$82,$43,$45,$45,$24,$46,$24,$90,$08,$95,$51,$78,$FA,$D7   ; $AC94
        .byte $73,$39,$F1,$8C,$01,$A8,$52,$B8,$52,$CC,$01,$5F,$B3,$97,$63,$9E   ; $ACA4
        .byte $00,$0E,$81,$16,$24,$66,$04,$8E,$00,$FE,$01,$08,$D2,$0E,$06,$6F   ; $ACB4
        .byte $47,$9E,$0F,$0E,$82,$2D,$47,$28,$7A,$68,$7A,$A8,$7A,$AE,$01,$DE   ; $ACC4
        .byte $0F,$6D,$C5,$FD,$48,$0F,$0E,$01,$5E,$02,$BC,$01,$FC,$01,$2C,$82   ; $ACD4
        .byte $41,$52,$4E,$04,$67,$25,$68,$24,$69,$24,$BA,$42,$C7,$04,$DE,$0B   ; $ACE4
        .byte $B2,$87,$FE,$02,$2C,$E1,$2C,$71,$67,$01,$77,$00,$87,$01,$8E,$00   ; $ACF4
        .byte $EE,$01   ; $AD04
        INC z:$02,x                ; $AD06: F6 02
        .byte $03,$85,$05,$02,$13,$21,$16,$02,$27,$02,$2E,$02,$88,$72,$C7,$20   ; $AD08
        .byte $D7,$07,$E4,$76,$07,$A0,$17,$06,$48,$7A,$76,$20,$98,$72,$79,$E1   ; $AD18
        .byte $88,$62,$9C,$01,$B7,$73,$DC,$01,$F8,$62,$FE,$01,$08,$E2,$0E,$00   ; $AD28
        .byte $6E,$02,$73,$20,$77,$23,$83,$04,$93,$20,$AE,$00,$FE,$0A,$0E,$82   ; $AD38
        .byte $39,$71,$A8,$72,$E7,$73,$0C,$81,$8F,$32,$AE,$00,$FE,$04,$04,$D1   ; $AD48
        .byte $17,$04,$26,$49,$27,$29,$DF,$33   ; $AD58
        INC a:$4402,x              ; $AD60: FE 02 44
        INC z:$7C,x                ; $AD63: F6 7C
        ORA ($8E,x)                ; $AD65: 01 8E
        ASL z:$BF                  ; $AD67: 06 BF
        .byte $47,$EE,$0F,$4D,$C7   ; $AD69
        ASL a:$6882                ; $AD6E: 0E 82 68
        .byte $7A,$AE,$01,$DE,$0F,$6D,$C5,$FD,$48,$01,$0E,$01   ; $AD71
LAD7D:
        BRK                        ; $AD7D: 00
        .byte $5A,$3E,$06,$45,$46,$47,$46,$53,$44,$AE,$01,$DF,$4A,$4D,$C7,$0E   ; $AD7E
        .byte $81,$00,$5A,$2E,$04,$37,$28,$3A,$48,$46,$47,$C7,$07,$CE,$0F,$DF   ; $AD8E
        .byte $4A,$4D,$C7,$0E,$81,$00,$5A,$33,$53,$43,$51,$46,$40,$47,$50,$53   ; $AD9E
        .byte $04,$55,$40,$56,$50,$62,$43,$64,$40,$65,$50,$71,$41,$73,$51,$83   ; $ADAE
        .byte $51,$94,$40,$95,$50,$A3,$50,$A5,$40,$A6   ; $ADBE
        BVC LAD7D                  ; $ADC8: 50 B3
        EOR ($B6),y                ; $ADCA: 51 B6
        RTI                        ; $ADCC: 40
        .byte $B7,$50,$C3,$53,$DF,$4A,$4D,$C7,$0E,$81,$00,$5A,$2E,$02,$36,$47   ; $ADCD
        .byte $37,$52,$3A,$49,$47,$25,$A7,$52,$D7,$04,$DF,$4A,$4D,$C7,$0E,$81   ; $ADDD
        .byte $00,$5A,$3E,$02,$44,$51,$53,$44,$54,$44,$55,$24,$A1,$54,$AE,$01   ; $ADED
        .byte $B4,$21,$DF,$4A,$E5,$07,$4D,$C7,$FD,$41,$01,$B4,$34,$C8,$52,$F2   ; $ADFD
        .byte $51,$47,$D3,$6C,$03,$65,$49,$9E,$07,$BE,$01,$CC,$03   ; $AE0D
        INC a:$0D07,x              ; $AE1A: FE 07 0D
        CMP #$1E                   ; $AE1D: C9 1E
        ORA ($6C,x)                ; $AE1F: 01 6C
        ORA ($62,x)                ; $AE21: 01 62
        AND z:$63,x                ; $AE23: 35 63
        .byte $53,$8A,$41,$AC,$01,$B3,$53,$E9,$51,$26,$C3,$27,$33,$63,$43,$64   ; $AE25
        .byte $33,$BA,$60,$C9,$61,$CE,$0B,$E5,$09,$EE,$0F,$7D,$CA,$7D,$47,$FD   ; $AE35
        .byte $41,$01,$B8,$52,$EA,$41,$27,$B2,$B3,$42,$16,$D4,$4A,$42,$A5,$51   ; $AE45
        .byte $A7,$31,$27,$D3,$08,$E2,$16,$64,$2C,$04,$38,$42,$76,$64,$88,$62   ; $AE55
        .byte $DE,$07,$FE,$01,$0D,$C9,$23,$32,$31,$51,$98,$52,$0D,$C9,$59,$42   ; $AE65
        .byte $63,$53,$67,$31,$14,$C2,$36,$31,$87,$53,$17,$E3,$29   ; $AE75
        ADC ($30,x)                ; $AE82: 61 30
        .byte $62,$3C,$08,$42,$37,$59,$40,$6A,$42,$99,$40,$C9,$61,$D7,$63,$39   ; $AE84
        .byte $D1,$58,$52,$C3,$67,$D3,$31,$DC,$06,$F7,$42,$FA,$42,$23,$B1,$43   ; $AE94
        .byte $67,$C3,$34,$C7,$34,$D1,$51,$43,$B3,$47,$33,$9A,$30,$A9,$61,$B8   ; $AEA4
        .byte $62,$BE,$0B,$D5,$09,$DE,$0F,$0D,$CA,$7D,$47,$FD,$49,$0F,$1E,$01   ; $AEB4
        .byte $39,$73,$5E,$07,$AE,$0B,$1E,$82,$6E,$88,$9E,$02,$0D,$04,$2E,$0B   ; $AEC4
        .byte $45,$09,$4E,$0F,$ED,$47,$FD,$FF   ; $AED4
        LDA a:$0772                ; $AEDC: AD 72 07
        JSR a:$8E04                ; $AEDF: 20 04 8E
        .byte $E4,$8F,$67,$85,$71,$90,$EA,$AE   ; $AEE2
        LDX a:$0753                ; $AEEA: AE 53 07
        LDA a:$06FC,x              ; $AEED: BD FC 06
        STA a:$06FC                ; $AEF0: 8D FC 06
        JSR a:$B04A                ; $AEF3: 20 4A B0
        LDA a:$0772                ; $AEF6: AD 72 07
        CMP #$03                   ; $AEF9: C9 03
        BCS LAEFE                  ; $AEFB: B0 01
        RTS                        ; $AEFD: 60
LAEFE:
        JSR a:$B624                ; $AEFE: 20 24 B6
        LDX #$00                   ; $AF01: A2 00
LAF03:
        STX z:$08                  ; $AF03: 86 08
        JSR a:$C047                ; $AF05: 20 47 C0
        JSR a:$84C3                ; $AF08: 20 C3 84
        INX                        ; $AF0B: E8
        CPX #$06                   ; $AF0C: E0 06
        BNE LAF03                  ; $AF0E: D0 F3
        JSR a:$F180                ; $AF10: 20 80 F1
        JSR a:$F12A                ; $AF13: 20 2A F1
        JSR a:$EEE9                ; $AF16: 20 E9 EE
        JSR a:$BED4                ; $AF19: 20 D4 BE
        LDX #$01                   ; $AF1C: A2 01
        STX z:$08                  ; $AF1E: 86 08
        JSR a:$BE70                ; $AF20: 20 70 BE
        DEX                        ; $AF23: CA
        STX z:$08                  ; $AF24: 86 08
        JSR a:$BE70                ; $AF26: 20 70 BE
        JSR a:$BB96                ; $AF29: 20 96 BB
        JSR a:$B9BC                ; $AF2C: 20 BC B9
        JSR a:$B7B8                ; $AF2F: 20 B8 B7
        JSR a:$B855                ; $AF32: 20 55 B8
        JSR a:$B74F                ; $AF35: 20 4F B7
        JSR a:$89E1                ; $AF38: 20 E1 89
        LDA z:$B5                  ; $AF3B: A5 B5
        CMP #$02                   ; $AF3D: C9 02
        BPL LAF52                  ; $AF3F: 10 11
        LDA a:$079F                ; $AF41: AD 9F 07
        BEQ LAF64                  ; $AF44: F0 1E
        CMP #$04                   ; $AF46: C9 04
        BNE LAF52                  ; $AF48: D0 08
        LDA a:$077F                ; $AF4A: AD 7F 07
        BNE LAF52                  ; $AF4D: D0 03
        JSR a:$90ED                ; $AF4F: 20 ED 90
LAF52:
        LDY a:$079F                ; $AF52: AC 9F 07
        LDA z:$09                  ; $AF55: A5 09
        CPY #$08                   ; $AF57: C0 08
        BCS LAF5D                  ; $AF59: B0 02
        LSR a                      ; $AF5B: 4A
        LSR a                      ; $AF5C: 4A
LAF5D:
        LSR a                      ; $AF5D: 4A
        JSR a:$B288                ; $AF5E: 20 88 B2
        JMP a:$AF67                ; $AF61: 4C 67 AF
LAF64:
        JSR a:$B29A                ; $AF64: 20 9A B2
        LDA z:$0A                  ; $AF67: A5 0A
        STA z:$0D                  ; $AF69: 85 0D
        LDA #$00                   ; $AF6B: A9 00
        STA z:$0C                  ; $AF6D: 85 0C
        LDA a:$0773                ; $AF6F: AD 73 07
        CMP #$06                   ; $AF72: C9 06
        BEQ LAF92                  ; $AF74: F0 1C
        LDA a:$071F                ; $AF76: AD 1F 07
        BNE LAF8F                  ; $AF79: D0 14
        LDA a:$073D                ; $AF7B: AD 3D 07
        CMP #$20                   ; $AF7E: C9 20
        BMI LAF92                  ; $AF80: 30 10
        LDA a:$073D                ; $AF82: AD 3D 07
        SBC #$20                   ; $AF85: E9 20
        STA a:$073D                ; $AF87: 8D 3D 07
        LDA #$00                   ; $AF8A: A9 00
        STA a:$0340                ; $AF8C: 8D 40 03
LAF8F:
        JSR a:$92B0                ; $AF8F: 20 B0 92
LAF92:
        RTS                        ; $AF92: 60
        LDA a:$06FF                ; $AF93: AD FF 06
        CLC                        ; $AF96: 18
        ADC a:$03A1                ; $AF97: 6D A1 03
        STA a:$06FF                ; $AF9A: 8D FF 06
        LDA a:$0723                ; $AF9D: AD 23 07
        BNE LAFFB                  ; $AFA0: D0 59
        LDA a:$0755                ; $AFA2: AD 55 07
        CMP #$50                   ; $AFA5: C9 50
        BCC LAFFB                  ; $AFA7: 90 52
        LDA a:$0785                ; $AFA9: AD 85 07
        BNE LAFFB                  ; $AFAC: D0 4D
        LDY a:$06FF                ; $AFAE: AC FF 06
        DEY                        ; $AFB1: 88
        BMI LAFFB                  ; $AFB2: 30 47
        INY                        ; $AFB4: C8
        CPY #$02                   ; $AFB5: C0 02
        BCC LAFBA                  ; $AFB7: 90 01
        DEY                        ; $AFB9: 88
LAFBA:
        LDA a:$0755                ; $AFBA: AD 55 07
        CMP #$70                   ; $AFBD: C9 70
        BCC LAFC4                  ; $AFBF: 90 03
        LDY a:$06FF                ; $AFC1: AC FF 06
LAFC4:
        TYA                        ; $AFC4: 98
        STA a:$0775                ; $AFC5: 8D 75 07
        CLC                        ; $AFC8: 18
        ADC a:$073D                ; $AFC9: 6D 3D 07
        STA a:$073D                ; $AFCC: 8D 3D 07
        TYA                        ; $AFCF: 98
        CLC                        ; $AFD0: 18
        ADC a:$071C                ; $AFD1: 6D 1C 07
        STA a:$071C                ; $AFD4: 8D 1C 07
        STA a:$073F                ; $AFD7: 8D 3F 07
        LDA a:$071A                ; $AFDA: AD 1A 07
        ADC #$00                   ; $AFDD: 69 00
        STA a:$071A                ; $AFDF: 8D 1A 07
        AND #$01                   ; $AFE2: 29 01
        STA z:$00                  ; $AFE4: 85 00
        LDA a:$0778                ; $AFE6: AD 78 07
        AND #$FE                   ; $AFE9: 29 FE
        ORA z:$00                  ; $AFEB: 05 00
        STA a:$0778                ; $AFED: 8D 78 07
        JSR a:$B038                ; $AFF0: 20 38 B0
        LDA #$08                   ; $AFF3: A9 08
        STA a:$0795                ; $AFF5: 8D 95 07
        JMP a:$B000                ; $AFF8: 4C 00 B0
LAFFB:
        LDA #$00                   ; $AFFB: A9 00
        STA a:$0775                ; $AFFD: 8D 75 07
        LDX #$00                   ; $B000: A2 00
        JSR a:$F1F6                ; $B002: 20 F6 F1
        STA z:$00                  ; $B005: 85 00
        LDY #$00                   ; $B007: A0 00
        ASL a                      ; $B009: 0A
        BCS LB013                  ; $B00A: B0 07
        INY                        ; $B00C: C8
        LDA z:$00                  ; $B00D: A5 00
        AND #$20                   ; $B00F: 29 20
        BEQ LB02E                  ; $B011: F0 1B
LB013:
        LDA a:$071C,y              ; $B013: B9 1C 07
        SEC                        ; $B016: 38
        SBC a:$B034,y              ; $B017: F9 34 B0
        STA z:$86                  ; $B01A: 85 86
        LDA a:$071A,y              ; $B01C: B9 1A 07
        SBC #$00                   ; $B01F: E9 00
        STA z:$6D                  ; $B021: 85 6D
        LDA z:$0C                  ; $B023: A5 0C
        CMP a:$B036,y              ; $B025: D9 36 B0
        BEQ LB02E                  ; $B028: F0 04
        LDA #$00                   ; $B02A: A9 00
        STA z:$57                  ; $B02C: 85 57
LB02E:
        LDA #$00                   ; $B02E: A9 00
        STA a:$03A1                ; $B030: 8D A1 03
        RTS                        ; $B033: 60
        .byte $00,$10,$01,$02   ; $B034
        LDA a:$071C                ; $B038: AD 1C 07
        CLC                        ; $B03B: 18
        ADC #$FF                   ; $B03C: 69 FF
        STA a:$071D                ; $B03E: 8D 1D 07
        LDA a:$071A                ; $B041: AD 1A 07
        ADC #$00                   ; $B044: 69 00
        STA a:$071B                ; $B046: 8D 1B 07
        RTS                        ; $B049: 60
        LDA z:$0E                  ; $B04A: A5 0E
        JSR a:$8E04                ; $B04C: 20 04 8E
        .byte $31,$91,$C7,$B1,$06,$B2,$E5,$B1,$A4,$B2,$CA,$B2,$CD,$91,$69,$B0   ; $B04F
        .byte $E9   ; $B05F
        BCS LB095                  ; $B060: B0 33
        .byte $B2,$45,$B2,$69,$B2,$7D,$B2   ; $B062
        LDA a:$0752                ; $B069: AD 52 07
        CMP #$02                   ; $B06C: C9 02
        BEQ LB09B                  ; $B06E: F0 2B
        LDA #$00                   ; $B070: A9 00
        LDY z:$CE                  ; $B072: A4 CE
        CPY #$30                   ; $B074: C0 30
        BCC LB0E6                  ; $B076: 90 6E
        LDA a:$0710                ; $B078: AD 10 07
        CMP #$06                   ; $B07B: C9 06
        BEQ LB083                  ; $B07D: F0 04
        CMP #$07                   ; $B07F: C9 07
        BNE LB0D3                  ; $B081: D0 50
LB083:
        LDA a:$03C4                ; $B083: AD C4 03
        BNE LB08D                  ; $B086: D0 05
        LDA #$01                   ; $B088: A9 01
        JMP a:$B0E6                ; $B08A: 4C E6 B0
LB08D:
        JSR a:$B21F                ; $B08D: 20 1F B2
        DEC a:$06DE                ; $B090: CE DE 06
        BNE LB0E5                  ; $B093: D0 50
LB095:
        INC a:$0769                ; $B095: EE 69 07
        JMP a:$B315                ; $B098: 4C 15 B3
LB09B:
        LDA a:$0758                ; $B09B: AD 58 07
        BNE LB0AC                  ; $B09E: D0 0C
        LDA #$FF                   ; $B0A0: A9 FF
        JSR a:$B200                ; $B0A2: 20 00 B2
        LDA z:$CE                  ; $B0A5: A5 CE
        CMP #$91                   ; $B0A7: C9 91
        BCC LB0D3                  ; $B0A9: 90 28
        RTS                        ; $B0AB: 60
LB0AC:
        LDA a:$0399                ; $B0AC: AD 99 03
        CMP #$60                   ; $B0AF: C9 60
        BNE LB0E5                  ; $B0B1: D0 32
        LDA z:$CE                  ; $B0B3: A5 CE
        CMP #$99                   ; $B0B5: C9 99
        LDY #$00                   ; $B0B7: A0 00
        LDA #$01                   ; $B0B9: A9 01
        BCC LB0C7                  ; $B0BB: 90 0A
        LDA #$03                   ; $B0BD: A9 03
        STA z:$1D                  ; $B0BF: 85 1D
        INY                        ; $B0C1: C8
        LDA #$08                   ; $B0C2: A9 08
        STA a:$05B4                ; $B0C4: 8D B4 05
LB0C7:
        STY a:$0716                ; $B0C7: 8C 16 07
        JSR a:$B0E6                ; $B0CA: 20 E6 B0
        LDA z:$86                  ; $B0CD: A5 86
        CMP #$48                   ; $B0CF: C9 48
        BCC LB0E5                  ; $B0D1: 90 12
LB0D3:
        LDA #$08                   ; $B0D3: A9 08
        STA z:$0E                  ; $B0D5: 85 0E
        LDA #$01                   ; $B0D7: A9 01
        STA z:$33                  ; $B0D9: 85 33
        LSR a                      ; $B0DB: 4A
        STA a:$0752                ; $B0DC: 8D 52 07
        STA a:$0716                ; $B0DF: 8D 16 07
        STA a:$0758                ; $B0E2: 8D 58 07
LB0E5:
        RTS                        ; $B0E5: 60
LB0E6:
        STA a:$06FC                ; $B0E6: 8D FC 06
        LDA z:$0E                  ; $B0E9: A5 0E
        CMP #$0B                   ; $B0EB: C9 0B
        BEQ LB12B                  ; $B0ED: F0 3C
        LDA a:$074E                ; $B0EF: AD 4E 07
        BNE LB104                  ; $B0F2: D0 10
        LDY z:$B5                  ; $B0F4: A4 B5
        DEY                        ; $B0F6: 88
        BNE LB0FF                  ; $B0F7: D0 06
        LDA z:$CE                  ; $B0F9: A5 CE
        CMP #$D0                   ; $B0FB: C9 D0
        BCC LB104                  ; $B0FD: 90 05
LB0FF:
        LDA #$00                   ; $B0FF: A9 00
        STA a:$06FC                ; $B101: 8D FC 06
LB104:
        LDA a:$06FC                ; $B104: AD FC 06
        AND #$C0                   ; $B107: 29 C0
        STA z:$0A                  ; $B109: 85 0A
        LDA a:$06FC                ; $B10B: AD FC 06
        AND #$03                   ; $B10E: 29 03
        STA z:$0C                  ; $B110: 85 0C
        LDA a:$06FC                ; $B112: AD FC 06
        AND #$0C                   ; $B115: 29 0C
        STA z:$0B                  ; $B117: 85 0B
        AND #$04                   ; $B119: 29 04
        BEQ LB12B                  ; $B11B: F0 0E
        LDA z:$1D                  ; $B11D: A5 1D
        BNE LB12B                  ; $B11F: D0 0A
        LDY z:$0C                  ; $B121: A4 0C
        BEQ LB12B                  ; $B123: F0 06
        LDA #$00                   ; $B125: A9 00
        STA z:$0C                  ; $B127: 85 0C
        STA z:$0B                  ; $B129: 85 0B
LB12B:
        JSR a:$B329                ; $B12B: 20 29 B3
        LDY #$01                   ; $B12E: A0 01
        LDA a:$0754                ; $B130: AD 54 07
        BNE LB13E                  ; $B133: D0 09
        LDY #$00                   ; $B135: A0 00
        LDA a:$0714                ; $B137: AD 14 07
        BEQ LB13E                  ; $B13A: F0 02
        LDY #$02                   ; $B13C: A0 02
LB13E:
        STY a:$0499                ; $B13E: 8C 99 04
        LDA #$01                   ; $B141: A9 01
        LDY z:$57                  ; $B143: A4 57
        BEQ LB14C                  ; $B145: F0 05
        BPL LB14A                  ; $B147: 10 01
        ASL a                      ; $B149: 0A
LB14A:
        STA z:$45                  ; $B14A: 85 45
LB14C:
        JSR a:$AF93                ; $B14C: 20 93 AF
        JSR a:$F180                ; $B14F: 20 80 F1
        JSR a:$F12A                ; $B152: 20 2A F1
        LDX #$00                   ; $B155: A2 00
        JSR a:$E29C                ; $B157: 20 9C E2
        JSR a:$DC64                ; $B15A: 20 64 DC
        LDA z:$CE                  ; $B15D: A5 CE
        CMP #$40                   ; $B15F: C9 40
        BCC LB179                  ; $B161: 90 16
        LDA z:$0E                  ; $B163: A5 0E
        CMP #$05                   ; $B165: C9 05
        BEQ LB179                  ; $B167: F0 10
        CMP #$07                   ; $B169: C9 07
        BEQ LB179                  ; $B16B: F0 0C
        CMP #$04                   ; $B16D: C9 04
        BCC LB179                  ; $B16F: 90 08
        LDA a:$03C4                ; $B171: AD C4 03
        AND #$DF                   ; $B174: 29 DF
        STA a:$03C4                ; $B176: 8D C4 03
LB179:
        LDA z:$B5                  ; $B179: A5 B5
        CMP #$02                   ; $B17B: C9 02
        BMI LB1BA                  ; $B17D: 30 3B
        LDX #$01                   ; $B17F: A2 01
        STX a:$0723                ; $B181: 8E 23 07
        LDY #$04                   ; $B184: A0 04
        STY z:$07                  ; $B186: 84 07
        LDX #$00                   ; $B188: A2 00
        LDY a:$0759                ; $B18A: AC 59 07
        BNE LB194                  ; $B18D: D0 05
        LDY a:$0743                ; $B18F: AC 43 07
        BNE LB1AA                  ; $B192: D0 16
LB194:
        INX                        ; $B194: E8
        LDY z:$0E                  ; $B195: A4 0E
        CPY #$0B                   ; $B197: C0 0B
        BEQ LB1AA                  ; $B199: F0 0F
        LDY a:$0712                ; $B19B: AC 12 07
        BNE LB1A6                  ; $B19E: D0 06
        INY                        ; $B1A0: C8
        STY z:$FC                  ; $B1A1: 84 FC
        STY a:$0712                ; $B1A3: 8C 12 07
LB1A6:
        LDY #$06                   ; $B1A6: A0 06
        STY z:$07                  ; $B1A8: 84 07
LB1AA:
        CMP z:$07                  ; $B1AA: C5 07
        BMI LB1BA                  ; $B1AC: 30 0C
        DEX                        ; $B1AE: CA
        BMI LB1BB                  ; $B1AF: 30 0A
        LDY a:$07B1                ; $B1B1: AC B1 07
        BNE LB1BA                  ; $B1B4: D0 04
        LDA #$06                   ; $B1B6: A9 06
        STA z:$0E                  ; $B1B8: 85 0E
LB1BA:
        RTS                        ; $B1BA: 60
LB1BB:
        LDA #$00                   ; $B1BB: A9 00
        STA a:$0758                ; $B1BD: 8D 58 07
        JSR a:$B1DD                ; $B1C0: 20 DD B1
        INC a:$0752                ; $B1C3: EE 52 07
        RTS                        ; $B1C6: 60
        LDA z:$B5                  ; $B1C7: A5 B5
        BNE LB1D1                  ; $B1C9: D0 06
        LDA z:$CE                  ; $B1CB: A5 CE
        CMP #$E4                   ; $B1CD: C9 E4
        BCC LB1DD                  ; $B1CF: 90 0C
LB1D1:
        LDA #$08                   ; $B1D1: A9 08
        STA a:$0758                ; $B1D3: 8D 58 07
        LDY #$03                   ; $B1D6: A0 03
        STY z:$1D                  ; $B1D8: 84 1D
        JMP a:$B0E6                ; $B1DA: 4C E6 B0
LB1DD:
        LDA #$02                   ; $B1DD: A9 02
        STA a:$0752                ; $B1DF: 8D 52 07
        JMP a:$B213                ; $B1E2: 4C 13 B2
        LDA #$01                   ; $B1E5: A9 01
        JSR a:$B200                ; $B1E7: 20 00 B2
        JSR a:$AF93                ; $B1EA: 20 93 AF
        LDY #$00                   ; $B1ED: A0 00
        LDA a:$06D6                ; $B1EF: AD D6 06
        BNE LB20B                  ; $B1F2: D0 17
        INY                        ; $B1F4: C8
        LDA a:$074E                ; $B1F5: AD 4E 07
        CMP #$03                   ; $B1F8: C9 03
        BNE LB20B                  ; $B1FA: D0 0F
        INY                        ; $B1FC: C8
        JMP a:$B20B                ; $B1FD: 4C 0B B2
        CLC                        ; $B200: 18
        ADC z:$CE                  ; $B201: 65 CE
        STA z:$CE                  ; $B203: 85 CE
        RTS                        ; $B205: 60
        JSR a:$B21F                ; $B206: 20 1F B2
        LDY #$02                   ; $B209: A0 02
LB20B:
        DEC a:$06DE                ; $B20B: CE DE 06
        BNE LB21E                  ; $B20E: D0 0E
        STY a:$0752                ; $B210: 8C 52 07
        INC a:$0774                ; $B213: EE 74 07
        LDA #$00                   ; $B216: A9 00
        STA a:$0772                ; $B218: 8D 72 07
        STA a:$0722                ; $B21B: 8D 22 07
LB21E:
        RTS                        ; $B21E: 60
        LDA #$08                   ; $B21F: A9 08
        STA z:$57                  ; $B221: 85 57
        LDY #$01                   ; $B223: A0 01
        LDA z:$86                  ; $B225: A5 86
        AND #$0F                   ; $B227: 29 0F
        BNE LB22E                  ; $B229: D0 03
        STA z:$57                  ; $B22B: 85 57
        TAY                        ; $B22D: A8
LB22E:
        TYA                        ; $B22E: 98
        JSR a:$B0E6                ; $B22F: 20 E6 B0
        RTS                        ; $B232: 60
        LDA a:$0747                ; $B233: AD 47 07
        CMP #$F8                   ; $B236: C9 F8
        BNE LB23D                  ; $B238: D0 03
        JMP a:$B255                ; $B23A: 4C 55 B2
LB23D:
        CMP #$C4                   ; $B23D: C9 C4
        BNE LB244                  ; $B23F: D0 03
        JSR a:$B273                ; $B241: 20 73 B2
LB244:
        RTS                        ; $B244: 60
        LDA a:$0747                ; $B245: AD 47 07
        CMP #$F0                   ; $B248: C9 F0
        BCS LB253                  ; $B24A: B0 07
        CMP #$C8                   ; $B24C: C9 C8
        BEQ LB273                  ; $B24E: F0 23
        JMP a:$B0E9                ; $B250: 4C E9 B0
LB253:
        BNE LB268                  ; $B253: D0 13
        LDY a:$070B                ; $B255: AC 0B 07
        BNE LB268                  ; $B258: D0 0E
        STY a:$070D                ; $B25A: 8C 0D 07
        INC a:$070B                ; $B25D: EE 0B 07
        LDA a:$0754                ; $B260: AD 54 07
        EOR #$01                   ; $B263: 49 01
        STA a:$0754                ; $B265: 8D 54 07
LB268:
        RTS                        ; $B268: 60
        LDA a:$0747                ; $B269: AD 47 07
        CMP #$F0                   ; $B26C: C9 F0
        BCS LB2A3                  ; $B26E: B0 33
        JMP a:$B0E9                ; $B270: 4C E9 B0
LB273:
        LDA #$00                   ; $B273: A9 00
        STA a:$0747                ; $B275: 8D 47 07
        LDA #$08                   ; $B278: A9 08
        STA z:$0E                  ; $B27A: 85 0E
        RTS                        ; $B27C: 60
        LDA a:$0747                ; $B27D: AD 47 07
        CMP #$C0                   ; $B280: C9 C0
        BEQ LB297                  ; $B282: F0 13
        LDA z:$09                  ; $B284: A5 09
        LSR a                      ; $B286: 4A
        LSR a                      ; $B287: 4A
        AND #$03                   ; $B288: 29 03
        STA z:$00                  ; $B28A: 85 00
        LDA a:$03C4                ; $B28C: AD C4 03
        AND #$FC                   ; $B28F: 29 FC
        ORA z:$00                  ; $B291: 05 00
        STA a:$03C4                ; $B293: 8D C4 03
        RTS                        ; $B296: 60
LB297:
        JSR a:$B273                ; $B297: 20 73 B2
        LDA a:$03C4                ; $B29A: AD C4 03
        AND #$FC                   ; $B29D: 29 FC
        STA a:$03C4                ; $B29F: 8D C4 03
        RTS                        ; $B2A2: 60
LB2A3:
        RTS                        ; $B2A3: 60
        LDA z:$1B                  ; $B2A4: A5 1B
        CMP #$30                   ; $B2A6: C9 30
        BNE LB2BF                  ; $B2A8: D0 15
        LDA a:$0713                ; $B2AA: AD 13 07
        STA z:$FF                  ; $B2AD: 85 FF
        LDA #$00                   ; $B2AF: A9 00
        STA a:$0713                ; $B2B1: 8D 13 07
        LDY z:$CE                  ; $B2B4: A4 CE
        CPY #$9E                   ; $B2B6: C0 9E
        BCS LB2BC                  ; $B2B8: B0 02
        LDA #$04                   ; $B2BA: A9 04
LB2BC:
        JMP a:$B0E6                ; $B2BC: 4C E6 B0
LB2BF:
        INC z:$0E                  ; $B2BF: E6 0E
        RTS                        ; $B2C1: 60
        .byte $15,$23,$16,$1B,$17,$18,$23,$63   ; $B2C2
        LDA #$01                   ; $B2CA: A9 01
        JSR a:$B0E6                ; $B2CC: 20 E6 B0
        LDA z:$CE                  ; $B2CF: A5 CE
        CMP #$AE                   ; $B2D1: C9 AE
        BCC LB2E3                  ; $B2D3: 90 0E
        LDA a:$0723                ; $B2D5: AD 23 07
        BEQ LB2E3                  ; $B2D8: F0 09
        LDA #$20                   ; $B2DA: A9 20
        STA z:$FC                  ; $B2DC: 85 FC
        LDA #$00                   ; $B2DE: A9 00
        STA a:$0723                ; $B2E0: 8D 23 07
LB2E3:
        LDA a:$0490                ; $B2E3: AD 90 04
        LSR a                      ; $B2E6: 4A
        BCS LB2F6                  ; $B2E7: B0 0D
        LDA a:$0746                ; $B2E9: AD 46 07
        BNE LB2F1                  ; $B2EC: D0 03
        INC a:$0746                ; $B2EE: EE 46 07
LB2F1:
        LDA #$20                   ; $B2F1: A9 20
        STA a:$03C4                ; $B2F3: 8D C4 03
LB2F6:
        LDA a:$0746                ; $B2F6: AD 46 07
        CMP #$05                   ; $B2F9: C9 05
        BNE LB328                  ; $B2FB: D0 2B
        INC a:$075C                ; $B2FD: EE 5C 07
        LDA a:$075C                ; $B300: AD 5C 07
        CMP #$03                   ; $B303: C9 03
        BNE LB315                  ; $B305: D0 0E
        LDY a:$075F                ; $B307: AC 5F 07
        LDA a:$0748                ; $B30A: AD 48 07
        CMP a:$B2C2,y              ; $B30D: D9 C2 B2
        BCC LB315                  ; $B310: 90 03
        INC a:$075D                ; $B312: EE 5D 07
LB315:
        INC a:$0760                ; $B315: EE 60 07
        JSR a:$9C03                ; $B318: 20 03 9C
        INC a:$0757                ; $B31B: EE 57 07
        JSR a:$B213                ; $B31E: 20 13 B2
        STA a:$075B                ; $B321: 8D 5B 07
        LDA #$80                   ; $B324: A9 80
        STA z:$FC                  ; $B326: 85 FC
LB328:
        RTS                        ; $B328: 60
        LDA #$00                   ; $B329: A9 00
        LDY a:$0754                ; $B32B: AC 54 07
        BNE LB338                  ; $B32E: D0 08
        LDA z:$1D                  ; $B330: A5 1D
        BNE LB33B                  ; $B332: D0 07
        LDA z:$0B                  ; $B334: A5 0B
        AND #$04                   ; $B336: 29 04
LB338:
        STA a:$0714                ; $B338: 8D 14 07
LB33B:
        JSR a:$B450                ; $B33B: 20 50 B4
        LDA a:$070B                ; $B33E: AD 0B 07
        BNE LB359                  ; $B341: D0 16
        LDA z:$1D                  ; $B343: A5 1D
        CMP #$03                   ; $B345: C9 03
        BEQ LB34E                  ; $B347: F0 05
        LDY #$18                   ; $B349: A0 18
        STY a:$0789                ; $B34B: 8C 89 07
LB34E:
        JSR a:$8E04                ; $B34E: 20 04 8E
        .byte $5A,$B3,$76,$B3,$6D,$B3,$CF,$B3   ; $B351
LB359:
        RTS                        ; $B359: 60
        JSR a:$B58F                ; $B35A: 20 8F B5
        LDA z:$0C                  ; $B35D: A5 0C
        BEQ LB363                  ; $B35F: F0 02
        STA z:$33                  ; $B361: 85 33
LB363:
        JSR a:$B5CC                ; $B363: 20 CC B5
        JSR a:$BF09                ; $B366: 20 09 BF
        STA a:$06FF                ; $B369: 8D FF 06
        RTS                        ; $B36C: 60
        LDA a:$070A                ; $B36D: AD 0A 07
        STA a:$0709                ; $B370: 8D 09 07
        JMP a:$B3AC                ; $B373: 4C AC B3
        LDY z:$9F                  ; $B376: A4 9F
        BPL LB38D                  ; $B378: 10 13
        LDA z:$0A                  ; $B37A: A5 0A
        AND #$80                   ; $B37C: 29 80
        AND z:$0D                  ; $B37E: 25 0D
        BNE LB393                  ; $B380: D0 11
        LDA a:$0708                ; $B382: AD 08 07
        SEC                        ; $B385: 38
        SBC z:$CE                  ; $B386: E5 CE
        CMP a:$0706                ; $B388: CD 06 07
        BCC LB393                  ; $B38B: 90 06
LB38D:
        LDA a:$070A                ; $B38D: AD 0A 07
        STA a:$0709                ; $B390: 8D 09 07
LB393:
        LDA a:$0704                ; $B393: AD 04 07
        BEQ LB3AC                  ; $B396: F0 14
        JSR a:$B58F                ; $B398: 20 8F B5
        LDA z:$CE                  ; $B39B: A5 CE
        CMP #$14                   ; $B39D: C9 14
        BCS LB3A6                  ; $B39F: B0 05
        LDA #$18                   ; $B3A1: A9 18
        STA a:$0709                ; $B3A3: 8D 09 07
LB3A6:
        LDA z:$0C                  ; $B3A6: A5 0C
        BEQ LB3AC                  ; $B3A8: F0 02
        STA z:$33                  ; $B3AA: 85 33
LB3AC:
        LDA z:$0C                  ; $B3AC: A5 0C
        BEQ LB3B3                  ; $B3AE: F0 03
        JSR a:$B5CC                ; $B3B0: 20 CC B5
LB3B3:
        JSR a:$BF09                ; $B3B3: 20 09 BF
        STA a:$06FF                ; $B3B6: 8D FF 06
        LDA z:$0E                  ; $B3B9: A5 0E
        CMP #$0B                   ; $B3BB: C9 0B
        BNE LB3C4                  ; $B3BD: D0 05
        LDA #$28                   ; $B3BF: A9 28
        STA a:$0709                ; $B3C1: 8D 09 07
LB3C4:
        JMP a:$BF4D                ; $B3C4: 4C 4D BF
        .byte $0E,$04,$FC,$F2,$00,$00,$FF,$FF   ; $B3C7
        LDA a:$0416                ; $B3CF: AD 16 04
        CLC                        ; $B3D2: 18
        ADC a:$0433                ; $B3D3: 6D 33 04
        STA a:$0416                ; $B3D6: 8D 16 04
        LDY #$00                   ; $B3D9: A0 00
        LDA z:$9F                  ; $B3DB: A5 9F
        BPL LB3E0                  ; $B3DD: 10 01
        DEY                        ; $B3DF: 88
LB3E0:
        STY z:$00                  ; $B3E0: 84 00
        ADC z:$CE                  ; $B3E2: 65 CE
        STA z:$CE                  ; $B3E4: 85 CE
        LDA z:$B5                  ; $B3E6: A5 B5
        ADC z:$00                  ; $B3E8: 65 00
        STA z:$B5                  ; $B3EA: 85 B5
        LDA z:$0C                  ; $B3EC: A5 0C
        AND a:$0490                ; $B3EE: 2D 90 04
        BEQ LB420                  ; $B3F1: F0 2D
        LDY a:$0789                ; $B3F3: AC 89 07
        BNE LB41F                  ; $B3F6: D0 27
        LDY #$18                   ; $B3F8: A0 18
        STY a:$0789                ; $B3FA: 8C 89 07
        LDX #$00                   ; $B3FD: A2 00
        LDY z:$33                  ; $B3FF: A4 33
        LSR a                      ; $B401: 4A
        BCS LB406                  ; $B402: B0 02
        INX                        ; $B404: E8
        INX                        ; $B405: E8
LB406:
        DEY                        ; $B406: 88
        BEQ LB40A                  ; $B407: F0 01
        INX                        ; $B409: E8
LB40A:
        LDA z:$86                  ; $B40A: A5 86
        CLC                        ; $B40C: 18
        ADC a:$B3C7,x              ; $B40D: 7D C7 B3
        STA z:$86                  ; $B410: 85 86
        LDA z:$6D                  ; $B412: A5 6D
        ADC a:$B3CB,x              ; $B414: 7D CB B3
        STA z:$6D                  ; $B417: 85 6D
        LDA z:$0C                  ; $B419: A5 0C
        EOR #$03                   ; $B41B: 49 03
        STA z:$33                  ; $B41D: 85 33
LB41F:
        RTS                        ; $B41F: 60
LB420:
        STA a:$0789                ; $B420: 8D 89 07
        RTS                        ; $B423: 60
        .byte $20,$20,$1E,$28,$28,$0D,$04,$70,$70,$60,$90,$90,$0A,$09,$FC,$FC   ; $B424
        .byte $FC,$FB,$FB,$FE,$FF,$00,$00,$00,$00,$00,$80,$00,$D8,$E8,$F0,$28   ; $B434
        .byte $18,$10,$0C,$E4,$98,$D0,$00,$FF,$01,$00,$20,$FF   ; $B444
        LDA z:$1D                  ; $B450: A5 1D
        CMP #$03                   ; $B452: C9 03
        BNE LB479                  ; $B454: D0 23
        LDY #$00                   ; $B456: A0 00
        LDA z:$0B                  ; $B458: A5 0B
        AND a:$0490                ; $B45A: 2D 90 04
        BEQ LB465                  ; $B45D: F0 06
        INY                        ; $B45F: C8
        AND #$08                   ; $B460: 29 08
        BNE LB465                  ; $B462: D0 01
        INY                        ; $B464: C8
LB465:
        LDX a:$B44D,y              ; $B465: BE 4D B4
        STX a:$0433                ; $B468: 8E 33 04
        LDA #$08                   ; $B46B: A9 08
        LDX a:$B44A,y              ; $B46D: BE 4A B4
        STX z:$9F                  ; $B470: 86 9F
        BMI LB475                  ; $B472: 30 01
        LSR a                      ; $B474: 4A
LB475:
        STA a:$070C                ; $B475: 8D 0C 07
        RTS                        ; $B478: 60
LB479:
        LDA a:$070E                ; $B479: AD 0E 07
        BNE LB488                  ; $B47C: D0 0A
        LDA z:$0A                  ; $B47E: A5 0A
        AND #$80                   ; $B480: 29 80
        BEQ LB488                  ; $B482: F0 04
        AND z:$0D                  ; $B484: 25 0D
        BEQ LB48B                  ; $B486: F0 03
LB488:
        JMP a:$B51C                ; $B488: 4C 1C B5
LB48B:
        LDA z:$1D                  ; $B48B: A5 1D
        BEQ LB4A0                  ; $B48D: F0 11
        LDA a:$0704                ; $B48F: AD 04 07
        BEQ LB488                  ; $B492: F0 F4
        LDA a:$0782                ; $B494: AD 82 07
        BNE LB4A0                  ; $B497: D0 07
        LDA z:$9F                  ; $B499: A5 9F
        BPL LB4A0                  ; $B49B: 10 03
        JMP a:$B51C                ; $B49D: 4C 1C B5
LB4A0:
        LDA #$20                   ; $B4A0: A9 20
        STA a:$0782                ; $B4A2: 8D 82 07
        LDY #$00                   ; $B4A5: A0 00
        STY a:$0416                ; $B4A7: 8C 16 04
        STY a:$0433                ; $B4AA: 8C 33 04
        LDA z:$B5                  ; $B4AD: A5 B5
        STA a:$0707                ; $B4AF: 8D 07 07
        LDA z:$CE                  ; $B4B2: A5 CE
        STA a:$0708                ; $B4B4: 8D 08 07
        LDA #$01                   ; $B4B7: A9 01
        STA z:$1D                  ; $B4B9: 85 1D
        LDA a:$0700                ; $B4BB: AD 00 07
        CMP #$09                   ; $B4BE: C9 09
        BCC LB4D2                  ; $B4C0: 90 10
        INY                        ; $B4C2: C8
        CMP #$10                   ; $B4C3: C9 10
        BCC LB4D2                  ; $B4C5: 90 0B
        INY                        ; $B4C7: C8
        CMP #$19                   ; $B4C8: C9 19
        BCC LB4D2                  ; $B4CA: 90 06
        INY                        ; $B4CC: C8
        CMP #$1C                   ; $B4CD: C9 1C
        BCC LB4D2                  ; $B4CF: 90 01
        INY                        ; $B4D1: C8
LB4D2:
        LDA #$01                   ; $B4D2: A9 01
        STA a:$0706                ; $B4D4: 8D 06 07
        LDA a:$0704                ; $B4D7: AD 04 07
        BEQ LB4E4                  ; $B4DA: F0 08
        LDY #$05                   ; $B4DC: A0 05
        LDA a:$047D                ; $B4DE: AD 7D 04
        BEQ LB4E4                  ; $B4E1: F0 01
        INY                        ; $B4E3: C8
LB4E4:
        LDA a:$B424,y              ; $B4E4: B9 24 B4
        STA a:$0709                ; $B4E7: 8D 09 07
        LDA a:$B42B,y              ; $B4EA: B9 2B B4
        STA a:$070A                ; $B4ED: 8D 0A 07
        LDA a:$B439,y              ; $B4F0: B9 39 B4
        STA a:$0433                ; $B4F3: 8D 33 04
        LDA a:$B432,y              ; $B4F6: B9 32 B4
        STA z:$9F                  ; $B4F9: 85 9F
        LDA a:$0704                ; $B4FB: AD 04 07
        BEQ LB511                  ; $B4FE: F0 11
        LDA #$04                   ; $B500: A9 04
        STA z:$FF                  ; $B502: 85 FF
        LDA z:$CE                  ; $B504: A5 CE
        CMP #$14                   ; $B506: C9 14
        BCS LB51C                  ; $B508: B0 12
        LDA #$00                   ; $B50A: A9 00
        STA z:$9F                  ; $B50C: 85 9F
        JMP a:$B51C                ; $B50E: 4C 1C B5
LB511:
        LDA #$01                   ; $B511: A9 01
        LDY a:$0754                ; $B513: AC 54 07
        BEQ LB51A                  ; $B516: F0 02
        LDA #$80                   ; $B518: A9 80
LB51A:
        STA z:$FF                  ; $B51A: 85 FF
LB51C:
        LDY #$00                   ; $B51C: A0 00
        STY z:$00                  ; $B51E: 84 00
        LDA z:$1D                  ; $B520: A5 1D
        BEQ LB52D                  ; $B522: F0 09
        LDA a:$0700                ; $B524: AD 00 07
        CMP #$19                   ; $B527: C9 19
        BCS LB55E                  ; $B529: B0 33
        BCC LB545                  ; $B52B: 90 18
LB52D:
        INY                        ; $B52D: C8
        LDA a:$074E                ; $B52E: AD 4E 07
        BEQ LB545                  ; $B531: F0 12
        DEY                        ; $B533: 88
        LDA z:$0C                  ; $B534: A5 0C
        CMP z:$45                  ; $B536: C5 45
        BNE LB545                  ; $B538: D0 0B
        LDA z:$0A                  ; $B53A: A5 0A
        AND #$40                   ; $B53C: 29 40
        BNE LB559                  ; $B53E: D0 19
        LDA a:$0783                ; $B540: AD 83 07
        BNE LB55E                  ; $B543: D0 19
LB545:
        INY                        ; $B545: C8
        INC z:$00                  ; $B546: E6 00
        LDA a:$0703                ; $B548: AD 03 07
        BNE LB554                  ; $B54B: D0 07
        LDA a:$0700                ; $B54D: AD 00 07
        CMP #$21                   ; $B550: C9 21
        BCC LB55E                  ; $B552: 90 0A
LB554:
        INC z:$00                  ; $B554: E6 00
        JMP a:$B55E                ; $B556: 4C 5E B5
LB559:
        LDA #$0A                   ; $B559: A9 0A
        STA a:$0783                ; $B55B: 8D 83 07
LB55E:
        LDA a:$B440,y              ; $B55E: B9 40 B4
        STA a:$0450                ; $B561: 8D 50 04
        LDA z:$0E                  ; $B564: A5 0E
        CMP #$07                   ; $B566: C9 07
        BNE LB56C                  ; $B568: D0 02
        LDY #$03                   ; $B56A: A0 03
LB56C:
        LDA a:$B443,y              ; $B56C: B9 43 B4
        STA a:$0456                ; $B56F: 8D 56 04
        LDY z:$00                  ; $B572: A4 00
        LDA a:$B447,y              ; $B574: B9 47 B4
        STA a:$0702                ; $B577: 8D 02 07
        LDA #$00                   ; $B57A: A9 00
        STA a:$0701                ; $B57C: 8D 01 07
        LDA z:$33                  ; $B57F: A5 33
        CMP z:$45                  ; $B581: C5 45
        BEQ LB58B                  ; $B583: F0 06
        ASL a:$0702                ; $B585: 0E 02 07
        ROL a:$0701                ; $B588: 2E 01 07
LB58B:
        RTS                        ; $B58B: 60
        .byte $02,$04,$07   ; $B58C
        LDY #$00                   ; $B58F: A0 00
        LDA a:$0700                ; $B591: AD 00 07
        CMP #$1C                   ; $B594: C9 1C
        BCS LB5AD                  ; $B596: B0 15
        INY                        ; $B598: C8
        CMP #$0E                   ; $B599: C9 0E
        BCS LB59E                  ; $B59B: B0 01
        INY                        ; $B59D: C8
LB59E:
        LDA a:$06FC                ; $B59E: AD FC 06
        AND #$7F                   ; $B5A1: 29 7F
        BEQ LB5C5                  ; $B5A3: F0 20
        AND #$03                   ; $B5A5: 29 03
        CMP z:$45                  ; $B5A7: C5 45
        BNE LB5B3                  ; $B5A9: D0 08
        LDA #$00                   ; $B5AB: A9 00
LB5AD:
        STA a:$0703                ; $B5AD: 8D 03 07
        JMP a:$B5C5                ; $B5B0: 4C C5 B5
LB5B3:
        LDA a:$0700                ; $B5B3: AD 00 07
        CMP #$0B                   ; $B5B6: C9 0B
        BCS LB5C5                  ; $B5B8: B0 0B
        LDA z:$33                  ; $B5BA: A5 33
        STA z:$45                  ; $B5BC: 85 45
        LDA #$00                   ; $B5BE: A9 00
        STA z:$57                  ; $B5C0: 85 57
        STA a:$0705                ; $B5C2: 8D 05 07
LB5C5:
        LDA a:$B58C,y              ; $B5C5: B9 8C B5
        STA a:$070C                ; $B5C8: 8D 0C 07
        RTS                        ; $B5CB: 60
        AND a:$0490                ; $B5CC: 2D 90 04
        CMP #$00                   ; $B5CF: C9 00
        BNE LB5DB                  ; $B5D1: D0 08
        LDA z:$57                  ; $B5D3: A5 57
        BEQ LB620                  ; $B5D5: F0 49
        BPL LB5FC                  ; $B5D7: 10 23
        BMI LB5DE                  ; $B5D9: 30 03
LB5DB:
        LSR a                      ; $B5DB: 4A
        BCC LB5FC                  ; $B5DC: 90 1E
LB5DE:
        LDA a:$0705                ; $B5DE: AD 05 07
        CLC                        ; $B5E1: 18
        ADC a:$0702                ; $B5E2: 6D 02 07
        STA a:$0705                ; $B5E5: 8D 05 07
        LDA z:$57                  ; $B5E8: A5 57
        ADC a:$0701                ; $B5EA: 6D 01 07
        STA z:$57                  ; $B5ED: 85 57
        CMP a:$0456                ; $B5EF: CD 56 04
        BMI LB617                  ; $B5F2: 30 23
        LDA a:$0456                ; $B5F4: AD 56 04
        STA z:$57                  ; $B5F7: 85 57
        JMP a:$B620                ; $B5F9: 4C 20 B6
LB5FC:
        LDA a:$0705                ; $B5FC: AD 05 07
        SEC                        ; $B5FF: 38
        SBC a:$0702                ; $B600: ED 02 07
        STA a:$0705                ; $B603: 8D 05 07
        LDA z:$57                  ; $B606: A5 57
        SBC a:$0701                ; $B608: ED 01 07
        STA z:$57                  ; $B60B: 85 57
        CMP a:$0450                ; $B60D: CD 50 04
        BPL LB617                  ; $B610: 10 05
        LDA a:$0450                ; $B612: AD 50 04
        STA z:$57                  ; $B615: 85 57
LB617:
        CMP #$00                   ; $B617: C9 00
        BPL LB620                  ; $B619: 10 05
        EOR #$FF                   ; $B61B: 49 FF
        CLC                        ; $B61D: 18
        ADC #$01                   ; $B61E: 69 01
LB620:
        STA a:$0700                ; $B620: 8D 00 07
        RTS                        ; $B623: 60
        LDA a:$0756                ; $B624: AD 56 07
        CMP #$02                   ; $B627: C9 02
        BCC LB66E                  ; $B629: 90 43
        LDA z:$0A                  ; $B62B: A5 0A
        AND #$40                   ; $B62D: 29 40
        BEQ LB664                  ; $B62F: F0 33
        AND z:$0D                  ; $B631: 25 0D
        BNE LB664                  ; $B633: D0 2F
        LDA a:$06CE                ; $B635: AD CE 06
        AND #$01                   ; $B638: 29 01
        TAX                        ; $B63A: AA
        LDA z:$24,x                ; $B63B: B5 24
        BNE LB664                  ; $B63D: D0 25
        LDY z:$B5                  ; $B63F: A4 B5
        DEY                        ; $B641: 88
        BNE LB664                  ; $B642: D0 20
        LDA a:$0714                ; $B644: AD 14 07
        BNE LB664                  ; $B647: D0 1B
        LDA z:$1D                  ; $B649: A5 1D
        CMP #$03                   ; $B64B: C9 03
        BEQ LB664                  ; $B64D: F0 15
        LDA #$20                   ; $B64F: A9 20
        STA z:$FF                  ; $B651: 85 FF
        LDA #$02                   ; $B653: A9 02
        STA z:$24,x                ; $B655: 95 24
        LDY a:$070C                ; $B657: AC 0C 07
        STY a:$0711                ; $B65A: 8C 11 07
        DEY                        ; $B65D: 88
        STY a:$0781                ; $B65E: 8C 81 07
        INC a:$06CE                ; $B661: EE CE 06
LB664:
        LDX #$00                   ; $B664: A2 00
        JSR a:$B689                ; $B666: 20 89 B6
        LDX #$01                   ; $B669: A2 01
        JSR a:$B689                ; $B66B: 20 89 B6
LB66E:
        LDA a:$074E                ; $B66E: AD 4E 07
        BNE LB686                  ; $B671: D0 13
        LDX #$02                   ; $B673: A2 02
LB675:
        STX z:$08                  ; $B675: 86 08
        JSR a:$B6F9                ; $B677: 20 F9 B6
        JSR a:$F131                ; $B67A: 20 31 F1
        JSR a:$F191                ; $B67D: 20 91 F1
        JSR a:$EDE1                ; $B680: 20 E1 ED
        DEX                        ; $B683: CA
        BPL LB675                  ; $B684: 10 EF
LB686:
        RTS                        ; $B686: 60
        .byte $40,$C0   ; $B687
        STX z:$08                  ; $B689: 86 08
        LDA z:$24,x                ; $B68B: B5 24
        ASL a                      ; $B68D: 0A
        BCS LB6F3                  ; $B68E: B0 63
        LDY z:$24,x                ; $B690: B4 24
        BEQ LB6F2                  ; $B692: F0 5E
        DEY                        ; $B694: 88
        BEQ LB6BE                  ; $B695: F0 27
        LDA z:$86                  ; $B697: A5 86
        ADC #$04                   ; $B699: 69 04
        STA z:$8D,x                ; $B69B: 95 8D
        LDA z:$6D                  ; $B69D: A5 6D
        ADC #$00                   ; $B69F: 69 00
        STA z:$74,x                ; $B6A1: 95 74
        LDA z:$CE                  ; $B6A3: A5 CE
        STA z:$D5,x                ; $B6A5: 95 D5
        LDA #$01                   ; $B6A7: A9 01
        STA z:$BC,x                ; $B6A9: 95 BC
        LDY z:$33                  ; $B6AB: A4 33
        DEY                        ; $B6AD: 88
        LDA a:$B687,y              ; $B6AE: B9 87 B6
        STA z:$5E,x                ; $B6B1: 95 5E
        LDA #$04                   ; $B6B3: A9 04
        STA z:$A6,x                ; $B6B5: 95 A6
        LDA #$07                   ; $B6B7: A9 07
        STA a:$04A0,x              ; $B6B9: 9D A0 04
        DEC z:$24,x                ; $B6BC: D6 24
LB6BE:
        TXA                        ; $B6BE: 8A
        CLC                        ; $B6BF: 18
        ADC #$07                   ; $B6C0: 69 07
        TAX                        ; $B6C2: AA
        LDA #$50                   ; $B6C3: A9 50
        STA z:$00                  ; $B6C5: 85 00
        LDA #$03                   ; $B6C7: A9 03
        STA z:$02                  ; $B6C9: 85 02
        LDA #$00                   ; $B6CB: A9 00
        JSR a:$BFD7                ; $B6CD: 20 D7 BF
        JSR a:$BF0F                ; $B6D0: 20 0F BF
        LDX z:$08                  ; $B6D3: A6 08
        JSR a:$F13B                ; $B6D5: 20 3B F1
        JSR a:$F187                ; $B6D8: 20 87 F1
        JSR a:$E22D                ; $B6DB: 20 2D E2
        JSR a:$E1C8                ; $B6DE: 20 C8 E1
        LDA a:$03D2                ; $B6E1: AD D2 03
        AND #$CC                   ; $B6E4: 29 CC
        BNE LB6EE                  ; $B6E6: D0 06
        JSR a:$D6D9                ; $B6E8: 20 D9 D6
        JMP a:$ECDE                ; $B6EB: 4C DE EC
LB6EE:
        LDA #$00                   ; $B6EE: A9 00
        STA z:$24,x                ; $B6F0: 95 24
LB6F2:
        RTS                        ; $B6F2: 60
LB6F3:
        JSR a:$F13B                ; $B6F3: 20 3B F1
        JMP a:$ED09                ; $B6F6: 4C 09 ED
        LDA a:$07A8,x              ; $B6F9: BD A8 07
        AND #$01                   ; $B6FC: 29 01
        STA z:$07                  ; $B6FE: 85 07
        LDA z:$E4,x                ; $B700: B5 E4
        CMP #$F8                   ; $B702: C9 F8
        BNE LB732                  ; $B704: D0 2C
        LDA a:$0792                ; $B706: AD 92 07
        BNE LB74A                  ; $B709: D0 3F
        LDY #$00                   ; $B70B: A0 00
        LDA z:$33                  ; $B70D: A5 33
        LSR a                      ; $B70F: 4A
        BCC LB714                  ; $B710: 90 02
        LDY #$08                   ; $B712: A0 08
LB714:
        TYA                        ; $B714: 98
        ADC z:$86                  ; $B715: 65 86
        STA z:$9C,x                ; $B717: 95 9C
        LDA z:$6D                  ; $B719: A5 6D
        ADC #$00                   ; $B71B: 69 00
        STA z:$83,x                ; $B71D: 95 83
        LDA z:$CE                  ; $B71F: A5 CE
        CLC                        ; $B721: 18
        ADC #$08                   ; $B722: 69 08
        STA z:$E4,x                ; $B724: 95 E4
        LDA #$01                   ; $B726: A9 01
        STA z:$CB,x                ; $B728: 95 CB
        LDY z:$07                  ; $B72A: A4 07
        LDA a:$B74D,y              ; $B72C: B9 4D B7
        STA a:$0792                ; $B72F: 8D 92 07
LB732:
        LDY z:$07                  ; $B732: A4 07
        LDA a:$042C,x              ; $B734: BD 2C 04
        SEC                        ; $B737: 38
        SBC a:$B74B,y              ; $B738: F9 4B B7
        STA a:$042C,x              ; $B73B: 9D 2C 04
        LDA z:$E4,x                ; $B73E: B5 E4
        SBC #$00                   ; $B740: E9 00
        CMP #$20                   ; $B742: C9 20
        BCS LB748                  ; $B744: B0 02
        LDA #$F8                   ; $B746: A9 F8
LB748:
        STA z:$E4,x                ; $B748: 95 E4
LB74A:
        RTS                        ; $B74A: 60
        .byte $FF,$50,$40,$20   ; $B74B
        LDA a:$0770                ; $B74F: AD 70 07
        BEQ LB7A3                  ; $B752: F0 4F
        LDA z:$0E                  ; $B754: A5 0E
        CMP #$08                   ; $B756: C9 08
        BCC LB7A3                  ; $B758: 90 49
        CMP #$0B                   ; $B75A: C9 0B
        BEQ LB7A3                  ; $B75C: F0 45
        LDA z:$B5                  ; $B75E: A5 B5
        CMP #$02                   ; $B760: C9 02
        BCS LB7A3                  ; $B762: B0 3F
        LDA a:$0787                ; $B764: AD 87 07
        BNE LB7A3                  ; $B767: D0 3A
        LDA a:$07F8                ; $B769: AD F8 07
        ORA a:$07F9                ; $B76C: 0D F9 07
        ORA a:$07FA                ; $B76F: 0D FA 07
        BEQ LB79A                  ; $B772: F0 26
        LDY a:$07F8                ; $B774: AC F8 07
        DEY                        ; $B777: 88
        BNE LB786                  ; $B778: D0 0C
        LDA a:$07F9                ; $B77A: AD F9 07
        ORA a:$07FA                ; $B77D: 0D FA 07
        BNE LB786                  ; $B780: D0 04
        LDA #$40                   ; $B782: A9 40
        STA z:$FC                  ; $B784: 85 FC
LB786:
        LDA #$18                   ; $B786: A9 18
        STA a:$0787                ; $B788: 8D 87 07
        LDY #$23                   ; $B78B: A0 23
        LDA #$FF                   ; $B78D: A9 FF
        STA a:$0139                ; $B78F: 8D 39 01
        JSR a:$8F5F                ; $B792: 20 5F 8F
        LDA #$A4                   ; $B795: A9 A4
        JMP a:$8F06                ; $B797: 4C 06 8F
LB79A:
        STA a:$0756                ; $B79A: 8D 56 07
        JSR a:$D931                ; $B79D: 20 31 D9
        INC a:$0759                ; $B7A0: EE 59 07
LB7A3:
        RTS                        ; $B7A3: 60
        .byte $AD,$23,$07,$F0,$FA,$A5,$CE,$25,$B5,$D0,$F4,$8D,$23,$07,$EE,$D6   ; $B7A4
        .byte $06,$4C,$98,$C9   ; $B7B4
        LDA a:$074E                ; $B7B8: AD 4E 07
        BNE LB7F4                  ; $B7BB: D0 37
        STA a:$047D                ; $B7BD: 8D 7D 04
        LDA a:$0747                ; $B7C0: AD 47 07
        BNE LB7F4                  ; $B7C3: D0 2F
        LDY #$04                   ; $B7C5: A0 04
LB7C7:
        LDA a:$0471,y              ; $B7C7: B9 71 04
        CLC                        ; $B7CA: 18
        ADC a:$0477,y              ; $B7CB: 79 77 04
        STA z:$02                  ; $B7CE: 85 02
        LDA a:$046B,y              ; $B7D0: B9 6B 04
        BEQ LB7F1                  ; $B7D3: F0 1C
        ADC #$00                   ; $B7D5: 69 00
        STA z:$01                  ; $B7D7: 85 01
        LDA z:$86                  ; $B7D9: A5 86
        SEC                        ; $B7DB: 38
        SBC a:$0471,y              ; $B7DC: F9 71 04
        LDA z:$6D                  ; $B7DF: A5 6D
        SBC a:$046B,y              ; $B7E1: F9 6B 04
        BMI LB7F1                  ; $B7E4: 30 0B
        LDA z:$02                  ; $B7E6: A5 02
        SEC                        ; $B7E8: 38
        SBC z:$86                  ; $B7E9: E5 86
        LDA z:$01                  ; $B7EB: A5 01
        SBC z:$6D                  ; $B7ED: E5 6D
        BPL LB7F5                  ; $B7EF: 10 04
LB7F1:
        DEY                        ; $B7F1: 88
        BPL LB7C7                  ; $B7F2: 10 D3
LB7F4:
        RTS                        ; $B7F4: 60
LB7F5:
        LDA a:$0477,y              ; $B7F5: B9 77 04
        LSR a                      ; $B7F8: 4A
        STA z:$00                  ; $B7F9: 85 00
        LDA a:$0471,y              ; $B7FB: B9 71 04
        CLC                        ; $B7FE: 18
        ADC z:$00                  ; $B7FF: 65 00
        STA z:$01                  ; $B801: 85 01
        LDA a:$046B,y              ; $B803: B9 6B 04
        ADC #$00                   ; $B806: 69 00
        STA z:$00                  ; $B808: 85 00
        LDA z:$09                  ; $B80A: A5 09
        LSR a                      ; $B80C: 4A
        BCC LB83B                  ; $B80D: 90 2C
        LDA z:$01                  ; $B80F: A5 01
        SEC                        ; $B811: 38
        SBC z:$86                  ; $B812: E5 86
        LDA z:$00                  ; $B814: A5 00
        SBC z:$6D                  ; $B816: E5 6D
        BPL LB828                  ; $B818: 10 0E
        LDA z:$86                  ; $B81A: A5 86
        SEC                        ; $B81C: 38
        SBC #$01                   ; $B81D: E9 01
        STA z:$86                  ; $B81F: 85 86
        LDA z:$6D                  ; $B821: A5 6D
        SBC #$00                   ; $B823: E9 00
        JMP a:$B839                ; $B825: 4C 39 B8
LB828:
        LDA a:$0490                ; $B828: AD 90 04
        LSR a                      ; $B82B: 4A
        BCC LB83B                  ; $B82C: 90 0D
        LDA z:$86                  ; $B82E: A5 86
        CLC                        ; $B830: 18
        ADC #$01                   ; $B831: 69 01
        STA z:$86                  ; $B833: 85 86
        LDA z:$6D                  ; $B835: A5 6D
        ADC #$00                   ; $B837: 69 00
        STA z:$6D                  ; $B839: 85 6D
LB83B:
        LDA #$10                   ; $B83B: A9 10
        STA z:$00                  ; $B83D: 85 00
        LDA #$01                   ; $B83F: A9 01
        STA a:$047D                ; $B841: 8D 7D 04
        STA z:$02                  ; $B844: 85 02
        LSR a                      ; $B846: 4A
        TAX                        ; $B847: AA
        JMP a:$BFD7                ; $B848: 4C D7 BF
        .byte $05,$02,$08,$04,$01,$03,$03,$04,$04,$04   ; $B84B
        LDX #$05                   ; $B855: A2 05
        STX z:$08                  ; $B857: 86 08
        LDA z:$16,x                ; $B859: B5 16
        CMP #$30                   ; $B85B: C9 30
        BNE LB8B5                  ; $B85D: D0 56
        LDA z:$0E                  ; $B85F: A5 0E
        CMP #$04                   ; $B861: C9 04
        BNE LB896                  ; $B863: D0 31
        LDA z:$1D                  ; $B865: A5 1D
        CMP #$03                   ; $B867: C9 03
        BNE LB896                  ; $B869: D0 2B
        LDA z:$CF,x                ; $B86B: B5 CF
        CMP #$AA                   ; $B86D: C9 AA
        BCS LB899                  ; $B86F: B0 28
        LDA z:$CE                  ; $B871: A5 CE
        CMP #$A2                   ; $B873: C9 A2
        BCS LB899                  ; $B875: B0 22
        LDA a:$0417,x              ; $B877: BD 17 04
        ADC #$FF                   ; $B87A: 69 FF
        STA a:$0417,x              ; $B87C: 9D 17 04
        LDA z:$CF,x                ; $B87F: B5 CF
        ADC #$01                   ; $B881: 69 01
        STA z:$CF,x                ; $B883: 95 CF
        LDA a:$010E                ; $B885: AD 0E 01
        SEC                        ; $B888: 38
        SBC #$FF                   ; $B889: E9 FF
        STA a:$010E                ; $B88B: 8D 0E 01
        LDA a:$010D                ; $B88E: AD 0D 01
        SBC #$01                   ; $B891: E9 01
        STA a:$010D                ; $B893: 8D 0D 01
LB896:
        JMP a:$B8AC                ; $B896: 4C AC B8
LB899:
        LDY a:$010F                ; $B899: AC 0F 01
        LDA a:$B84B,y              ; $B89C: B9 4B B8
        LDX a:$B850,y              ; $B89F: BE 50 B8
        STA a:$0134,x              ; $B8A2: 9D 34 01
        JSR a:$BC27                ; $B8A5: 20 27 BC
        LDA #$05                   ; $B8A8: A9 05
        STA z:$0E                  ; $B8AA: 85 0E
        JSR a:$F1AF                ; $B8AC: 20 AF F1
        JSR a:$F152                ; $B8AF: 20 52 F1
        JSR a:$E54B                ; $B8B2: 20 4B E5
LB8B5:
        RTS                        ; $B8B5: 60
        .byte $08,$10,$08,$00   ; $B8B6
        JSR a:$F1AF                ; $B8BA: 20 AF F1
        LDA a:$0747                ; $B8BD: AD 47 07
        BNE LB902                  ; $B8C0: D0 40
        LDA a:$070E                ; $B8C2: AD 0E 07
        BEQ LB902                  ; $B8C5: F0 3B
        TAY                        ; $B8C7: A8
        DEY                        ; $B8C8: 88
        TYA                        ; $B8C9: 98
        AND #$02                   ; $B8CA: 29 02
        BNE LB8D5                  ; $B8CC: D0 07
        INC z:$CE                  ; $B8CE: E6 CE
        INC z:$CE                  ; $B8D0: E6 CE
        JMP a:$B8D9                ; $B8D2: 4C D9 B8
LB8D5:
        DEC z:$CE                  ; $B8D5: C6 CE
        DEC z:$CE                  ; $B8D7: C6 CE
        LDA z:$58,x                ; $B8D9: B5 58
        CLC                        ; $B8DB: 18
        ADC a:$B8B6,y              ; $B8DC: 79 B6 B8
        STA z:$CF,x                ; $B8DF: 95 CF
        CPY #$01                   ; $B8E1: C0 01
        BCC LB8F4                  ; $B8E3: 90 0F
        LDA z:$0A                  ; $B8E5: A5 0A
        AND #$80                   ; $B8E7: 29 80
        BEQ LB8F4                  ; $B8E9: F0 09
        AND z:$0D                  ; $B8EB: 25 0D
        BNE LB8F4                  ; $B8ED: D0 05
        LDA #$F4                   ; $B8EF: A9 F4
        STA a:$06DB                ; $B8F1: 8D DB 06
LB8F4:
        CPY #$03                   ; $B8F4: C0 03
        BNE LB902                  ; $B8F6: D0 0A
        LDA a:$06DB                ; $B8F8: AD DB 06
        STA z:$9F                  ; $B8FB: 85 9F
        LDA #$00                   ; $B8FD: A9 00
        STA a:$070E                ; $B8FF: 8D 0E 07
LB902:
        JSR a:$F152                ; $B902: 20 52 F1
        JSR a:$E87D                ; $B905: 20 7D E8
        JSR a:$D67A                ; $B908: 20 7A D6
        LDA a:$070E                ; $B90B: AD 0E 07
        BEQ LB91D                  ; $B90E: F0 0D
        LDA a:$0786                ; $B910: AD 86 07
        BNE LB91D                  ; $B913: D0 08
        LDA #$04                   ; $B915: A9 04
        STA a:$0786                ; $B917: 8D 86 07
        INC a:$070E                ; $B91A: EE 0E 07
LB91D:
        RTS                        ; $B91D: 60
        LDA #$2F                   ; $B91E: A9 2F
        STA z:$16,x                ; $B920: 95 16
        LDA #$01                   ; $B922: A9 01
        STA z:$0F,x                ; $B924: 95 0F
        LDA a:$0076,y              ; $B926: B9 76 00
        STA z:$6E,x                ; $B929: 95 6E
        LDA a:$008F,y              ; $B92B: B9 8F 00
        STA z:$87,x                ; $B92E: 95 87
        LDA a:$00D7,y              ; $B930: B9 D7 00
        STA z:$CF,x                ; $B933: 95 CF
        LDY a:$0398                ; $B935: AC 98 03
        BNE LB93D                  ; $B938: D0 03
        STA a:$039D                ; $B93A: 8D 9D 03
LB93D:
        TXA                        ; $B93D: 8A
        STA a:$039A,y              ; $B93E: 99 9A 03
        INC a:$0398                ; $B941: EE 98 03
        LDA #$04                   ; $B944: A9 04
        STA z:$FE                  ; $B946: 85 FE
        RTS                        ; $B948: 60
        .byte $30,$60   ; $B949
        CPX #$05                   ; $B94B: E0 05
        BNE LB9B7                  ; $B94D: D0 68
        LDY a:$0398                ; $B94F: AC 98 03
        DEY                        ; $B952: 88
        LDA a:$0399                ; $B953: AD 99 03
        CMP a:$B949,y              ; $B956: D9 49 B9
        BEQ LB96A                  ; $B959: F0 0F
        LDA z:$09                  ; $B95B: A5 09
        LSR a                      ; $B95D: 4A
        LSR a                      ; $B95E: 4A
        BCC LB96A                  ; $B95F: 90 09
        LDA z:$D4                  ; $B961: A5 D4
        SBC #$01                   ; $B963: E9 01
        STA z:$D4                  ; $B965: 85 D4
        INC a:$0399                ; $B967: EE 99 03
LB96A:
        LDA a:$0399                ; $B96A: AD 99 03
        CMP #$08                   ; $B96D: C9 08
        BCC LB9B7                  ; $B96F: 90 46
        JSR a:$F152                ; $B971: 20 52 F1
        JSR a:$F1AF                ; $B974: 20 AF F1
        LDY #$00                   ; $B977: A0 00
LB979:
        JSR a:$E435                ; $B979: 20 35 E4
        INY                        ; $B97C: C8
        CPY a:$0398                ; $B97D: CC 98 03
        BNE LB979                  ; $B980: D0 F7
        LDA a:$03D1                ; $B982: AD D1 03
        AND #$0C                   ; $B985: 29 0C
        BEQ LB999                  ; $B987: F0 10
        DEY                        ; $B989: 88
LB98A:
        LDX a:$039A,y              ; $B98A: BE 9A 03
        JSR a:$C998                ; $B98D: 20 98 C9
        DEY                        ; $B990: 88
        BPL LB98A                  ; $B991: 10 F7
        STA a:$0398                ; $B993: 8D 98 03
        STA a:$0399                ; $B996: 8D 99 03
LB999:
        LDA a:$0399                ; $B999: AD 99 03
        CMP #$20                   ; $B99C: C9 20
        BCC LB9B7                  ; $B99E: 90 17
        LDX #$06                   ; $B9A0: A2 06
        LDA #$01                   ; $B9A2: A9 01
        LDY #$1B                   ; $B9A4: A0 1B
        JSR a:$E3F0                ; $B9A6: 20 F0 E3
        LDY z:$02                  ; $B9A9: A4 02
        CPY #$D0                   ; $B9AB: C0 D0
        BCS LB9B7                  ; $B9AD: B0 08
        LDA ($06),y                ; $B9AF: B1 06
        BNE LB9B7                  ; $B9B1: D0 04
        LDA #$26                   ; $B9B3: A9 26
        STA ($06),y                ; $B9B5: 91 06
LB9B7:
        LDX z:$08                  ; $B9B7: A6 08
        RTS                        ; $B9B9: 60
        .byte $0F,$07   ; $B9BA
        LDA a:$074E                ; $B9BC: AD 4E 07
        BEQ LBA30                  ; $B9BF: F0 6F
        LDX #$02                   ; $B9C1: A2 02
LB9C3:
        STX z:$08                  ; $B9C3: 86 08
        LDA z:$0F,x                ; $B9C5: B5 0F
        BNE LBA1A                  ; $B9C7: D0 51
        LDA a:$07A8,x              ; $B9C9: BD A8 07
        LDY a:$06CC                ; $B9CC: AC CC 06
        AND a:$B9BA,y              ; $B9CF: 39 BA B9
        CMP #$06                   ; $B9D2: C9 06
        BCS LBA1A                  ; $B9D4: B0 44
        TAY                        ; $B9D6: A8
        LDA a:$046B,y              ; $B9D7: B9 6B 04
        BEQ LBA1A                  ; $B9DA: F0 3E
        LDA a:$047D,y              ; $B9DC: B9 7D 04
        BEQ LB9E9                  ; $B9DF: F0 08
        SBC #$00                   ; $B9E1: E9 00
        STA a:$047D,y              ; $B9E3: 99 7D 04
        JMP a:$BA1A                ; $B9E6: 4C 1A BA
LB9E9:
        LDA a:$0747                ; $B9E9: AD 47 07
        BNE LBA1A                  ; $B9EC: D0 2C
        LDA #$0E                   ; $B9EE: A9 0E
        STA a:$047D,y              ; $B9F0: 99 7D 04
        LDA a:$046B,y              ; $B9F3: B9 6B 04
        STA z:$6E,x                ; $B9F6: 95 6E
        LDA a:$0471,y              ; $B9F8: B9 71 04
        STA z:$87,x                ; $B9FB: 95 87
        LDA a:$0477,y              ; $B9FD: B9 77 04
        SEC                        ; $BA00: 38
        SBC #$08                   ; $BA01: E9 08
        STA z:$CF,x                ; $BA03: 95 CF
        LDA #$01                   ; $BA05: A9 01
        STA z:$B6,x                ; $BA07: 95 B6
        STA z:$0F,x                ; $BA09: 95 0F
        LSR a                      ; $BA0B: 4A
        STA z:$1E,x                ; $BA0C: 95 1E
        LDA #$09                   ; $BA0E: A9 09
        STA a:$049A,x              ; $BA10: 9D 9A 04
        LDA #$33                   ; $BA13: A9 33
        STA z:$16,x                ; $BA15: 95 16
        JMP a:$BA2D                ; $BA17: 4C 2D BA
LBA1A:
        LDA z:$16,x                ; $BA1A: B5 16
        CMP #$33                   ; $BA1C: C9 33
        BNE LBA2D                  ; $BA1E: D0 0D
        JSR a:$D67A                ; $BA20: 20 7A D6
        LDA z:$0F,x                ; $BA23: B5 0F
        BEQ LBA2D                  ; $BA25: F0 06
        JSR a:$F1AF                ; $BA27: 20 AF F1
        JSR a:$BA33                ; $BA2A: 20 33 BA
LBA2D:
        DEX                        ; $BA2D: CA
        BPL LB9C3                  ; $BA2E: 10 93
LBA30:
        RTS                        ; $BA30: 60
        .byte $18,$E8   ; $BA31
        LDA a:$0747                ; $BA33: AD 47 07
        BNE LBA76                  ; $BA36: D0 3E
        LDA z:$1E,x                ; $BA38: B5 1E
        BNE LBA6A                  ; $BA3A: D0 2E
        LDA a:$03D1                ; $BA3C: AD D1 03
        AND #$0C                   ; $BA3F: 29 0C
        CMP #$0C                   ; $BA41: C9 0C
        BEQ LBA85                  ; $BA43: F0 40
        LDY #$01                   ; $BA45: A0 01
        JSR a:$E143                ; $BA47: 20 43 E1
        BMI LBA4D                  ; $BA4A: 30 01
        INY                        ; $BA4C: C8
LBA4D:
        STY z:$46,x                ; $BA4D: 94 46
        DEY                        ; $BA4F: 88
        LDA a:$BA31,y              ; $BA50: B9 31 BA
        STA z:$58,x                ; $BA53: 95 58
        LDA z:$00                  ; $BA55: A5 00
        ADC #$28                   ; $BA57: 69 28
        CMP #$50                   ; $BA59: C9 50
        BCC LBA85                  ; $BA5B: 90 28
        LDA #$01                   ; $BA5D: A9 01
        STA z:$1E,x                ; $BA5F: 95 1E
        LDA #$0A                   ; $BA61: A9 0A
        STA a:$078A,x              ; $BA63: 9D 8A 07
        LDA #$08                   ; $BA66: A9 08
        STA z:$FE                  ; $BA68: 85 FE
LBA6A:
        LDA z:$1E,x                ; $BA6A: B5 1E
        AND #$20                   ; $BA6C: 29 20
        BEQ LBA73                  ; $BA6E: F0 03
        JSR a:$BF63                ; $BA70: 20 63 BF
LBA73:
        JSR a:$BF02                ; $BA73: 20 02 BF
LBA76:
        JSR a:$F1AF                ; $BA76: 20 AF F1
        JSR a:$F152                ; $BA79: 20 52 F1
        JSR a:$E243                ; $BA7C: 20 43 E2
        JSR a:$D853                ; $BA7F: 20 53 D8
        JMP a:$E87D                ; $BA82: 4C 7D E8
LBA85:
        JSR a:$C998                ; $BA85: 20 98 C9
        RTS                        ; $BA88: 60
        .byte $04,$04,$04,$05,$05,$05,$06,$06,$06,$10,$F0   ; $BA89
        LDA a:$07A8                ; $BA94: AD A8 07
        AND #$07                   ; $BA97: 29 07
        BNE LBAA0                  ; $BA99: D0 05
        LDA a:$07A8                ; $BA9B: AD A8 07
        AND #$08                   ; $BA9E: 29 08
LBAA0:
        TAY                        ; $BAA0: A8
        LDA a:$002A,y              ; $BAA1: B9 2A 00
        BNE LBABF                  ; $BAA4: D0 19
        LDX a:$BA89,y              ; $BAA6: BE 89 BA
        LDA z:$0F,x                ; $BAA9: B5 0F
        BNE LBABF                  ; $BAAB: D0 12
        LDX z:$08                  ; $BAAD: A6 08
        TXA                        ; $BAAF: 8A
        STA a:$06AE,y              ; $BAB0: 99 AE 06
        LDA #$90                   ; $BAB3: A9 90
        STA a:$002A,y              ; $BAB5: 99 2A 00
        LDA #$07                   ; $BAB8: A9 07
        STA a:$04A2,y              ; $BABA: 99 A2 04
        SEC                        ; $BABD: 38
        RTS                        ; $BABE: 60
LBABF:
        LDX z:$08                  ; $BABF: A6 08
        CLC                        ; $BAC1: 18
        RTS                        ; $BAC2: 60
        LDA a:$0747                ; $BAC3: AD 47 07
        BNE LBB2B                  ; $BAC6: D0 63
        LDA z:$2A,x                ; $BAC8: B5 2A
        AND #$7F                   ; $BACA: 29 7F
        LDY a:$06AE,x              ; $BACC: BC AE 06
        CMP #$02                   ; $BACF: C9 02
        BEQ LBAF3                  ; $BAD1: F0 20
        BCS LBB09                  ; $BAD3: B0 34
        TXA                        ; $BAD5: 8A
        CLC                        ; $BAD6: 18
        ADC #$0D                   ; $BAD7: 69 0D
        TAX                        ; $BAD9: AA
        LDA #$10                   ; $BADA: A9 10
        STA z:$00                  ; $BADC: 85 00
        LDA #$0F                   ; $BADE: A9 0F
        STA z:$01                  ; $BAE0: 85 01
        LDA #$04                   ; $BAE2: A9 04
        STA z:$02                  ; $BAE4: 85 02
        LDA #$00                   ; $BAE6: A9 00
        JSR a:$BFD7                ; $BAE8: 20 D7 BF
        JSR a:$BF0F                ; $BAEB: 20 0F BF
        LDX z:$08                  ; $BAEE: A6 08
        JMP a:$BB28                ; $BAF0: 4C 28 BB
LBAF3:
        LDA #$FE                   ; $BAF3: A9 FE
        STA z:$AC,x                ; $BAF5: 95 AC
        LDA a:$001E,y              ; $BAF7: B9 1E 00
        AND #$F7                   ; $BAFA: 29 F7
        STA a:$001E,y              ; $BAFC: 99 1E 00
        LDX z:$46,y                ; $BAFF: B6 46
        DEX                        ; $BB01: CA
        LDA a:$BA92,x              ; $BB02: BD 92 BA
        LDX z:$08                  ; $BB05: A6 08
        STA z:$64,x                ; $BB07: 95 64
LBB09:
        DEC z:$2A,x                ; $BB09: D6 2A
        LDA a:$0087,y              ; $BB0B: B9 87 00
        CLC                        ; $BB0E: 18
        ADC #$02                   ; $BB0F: 69 02
        STA z:$93,x                ; $BB11: 95 93
        LDA a:$006E,y              ; $BB13: B9 6E 00
        ADC #$00                   ; $BB16: 69 00
        STA z:$7A,x                ; $BB18: 95 7A
        LDA a:$00CF,y              ; $BB1A: B9 CF 00
        SEC                        ; $BB1D: 38
        SBC #$0A                   ; $BB1E: E9 0A
        STA z:$DB,x                ; $BB20: 95 DB
        LDA #$01                   ; $BB22: A9 01
        STA z:$C2,x                ; $BB24: 95 C2
        BNE LBB2B                  ; $BB26: D0 03
        JSR a:$D7C4                ; $BB28: 20 C4 D7
LBB2B:
        JSR a:$F19B                ; $BB2B: 20 9B F1
        JSR a:$F148                ; $BB2E: 20 48 F1
        JSR a:$E236                ; $BB31: 20 36 E2
        JSR a:$E4DC                ; $BB34: 20 DC E4
        RTS                        ; $BB37: 60
        JSR a:$BB84                ; $BB38: 20 84 BB
        LDA z:$76,x                ; $BB3B: B5 76
        STA a:$007A,y              ; $BB3D: 99 7A 00
        LDA z:$8F,x                ; $BB40: B5 8F
        ORA #$05                   ; $BB42: 09 05
        STA a:$0093,y              ; $BB44: 99 93 00
        LDA z:$D7,x                ; $BB47: B5 D7
        SBC #$10                   ; $BB49: E9 10
        STA a:$00DB,y              ; $BB4B: 99 DB 00
        JMP a:$BB6C                ; $BB4E: 4C 6C BB
        JSR a:$BB84                ; $BB51: 20 84 BB
        LDA a:$03EA,x              ; $BB54: BD EA 03
        STA a:$007A,y              ; $BB57: 99 7A 00
        LDA z:$06                  ; $BB5A: A5 06
        ASL a                      ; $BB5C: 0A
        ASL a                      ; $BB5D: 0A
        ASL a                      ; $BB5E: 0A
        ASL a                      ; $BB5F: 0A
        ORA #$05                   ; $BB60: 09 05
        STA a:$0093,y              ; $BB62: 99 93 00
        LDA z:$02                  ; $BB65: A5 02
        ADC #$20                   ; $BB67: 69 20
        STA a:$00DB,y              ; $BB69: 99 DB 00
        LDA #$FB                   ; $BB6C: A9 FB
        STA a:$00AC,y              ; $BB6E: 99 AC 00
        LDA #$01                   ; $BB71: A9 01
        STA a:$00C2,y              ; $BB73: 99 C2 00
        STA a:$002A,y              ; $BB76: 99 2A 00
        STA z:$FE                  ; $BB79: 85 FE
        STX z:$08                  ; $BB7B: 86 08
        JSR a:$BBFE                ; $BB7D: 20 FE BB
        INC a:$0748                ; $BB80: EE 48 07
        RTS                        ; $BB83: 60
        LDY #$08                   ; $BB84: A0 08
LBB86:
        LDA a:$002A,y              ; $BB86: B9 2A 00
        BEQ LBB92                  ; $BB89: F0 07
        DEY                        ; $BB8B: 88
        CPY #$05                   ; $BB8C: C0 05
        BNE LBB86                  ; $BB8E: D0 F6
        LDY #$08                   ; $BB90: A0 08
LBB92:
        STY a:$06B7                ; $BB92: 8C B7 06
        RTS                        ; $BB95: 60
        LDX #$08                   ; $BB96: A2 08
LBB98:
        STX z:$08                  ; $BB98: 86 08
        LDA z:$2A,x                ; $BB9A: B5 2A
        BEQ LBBF4                  ; $BB9C: F0 56
        ASL a                      ; $BB9E: 0A
        BCC LBBA7                  ; $BB9F: 90 06
        JSR a:$BAC3                ; $BBA1: 20 C3 BA
        JMP a:$BBF4                ; $BBA4: 4C F4 BB
LBBA7:
        LDY z:$2A,x                ; $BBA7: B4 2A
        DEY                        ; $BBA9: 88
        BEQ LBBC9                  ; $BBAA: F0 1D
        INC z:$2A,x                ; $BBAC: F6 2A
        LDA z:$93,x                ; $BBAE: B5 93
        CLC                        ; $BBB0: 18
        ADC a:$0775                ; $BBB1: 6D 75 07
        STA z:$93,x                ; $BBB4: 95 93
        LDA z:$7A,x                ; $BBB6: B5 7A
        ADC #$00                   ; $BBB8: 69 00
        STA z:$7A,x                ; $BBBA: 95 7A
        LDA z:$2A,x                ; $BBBC: B5 2A
        CMP #$30                   ; $BBBE: C9 30
        BNE LBBE8                  ; $BBC0: D0 26
        LDA #$00                   ; $BBC2: A9 00
        STA z:$2A,x                ; $BBC4: 95 2A
        JMP a:$BBF4                ; $BBC6: 4C F4 BB
LBBC9:
        TXA                        ; $BBC9: 8A
        CLC                        ; $BBCA: 18
        ADC #$0D                   ; $BBCB: 69 0D
        TAX                        ; $BBCD: AA
        LDA #$50                   ; $BBCE: A9 50
        STA z:$00                  ; $BBD0: 85 00
        LDA #$06                   ; $BBD2: A9 06
        STA z:$02                  ; $BBD4: 85 02
        LSR a                      ; $BBD6: 4A
        STA z:$01                  ; $BBD7: 85 01
        LDA #$00                   ; $BBD9: A9 00
        JSR a:$BFD7                ; $BBDB: 20 D7 BF
        LDX z:$08                  ; $BBDE: A6 08
        LDA z:$AC,x                ; $BBE0: B5 AC
        CMP #$05                   ; $BBE2: C9 05
        BNE LBBE8                  ; $BBE4: D0 02
        INC z:$2A,x                ; $BBE6: F6 2A
LBBE8:
        JSR a:$F148                ; $BBE8: 20 48 F1
        JSR a:$F19B                ; $BBEB: 20 9B F1
        JSR a:$E236                ; $BBEE: 20 36 E2
        JSR a:$E686                ; $BBF1: 20 86 E6
LBBF4:
        DEX                        ; $BBF4: CA
        BPL LBB98                  ; $BBF5: 10 A1
        RTS                        ; $BBF7: 60
        .byte $17,$1D,$0B,$11,$02,$13   ; $BBF8
        LDA #$01                   ; $BBFE: A9 01
        STA a:$0139                ; $BC00: 8D 39 01
        LDX a:$0753                ; $BC03: AE 53 07
        LDY a:$BBF8,x              ; $BC06: BC F8 BB
        JSR a:$8F5F                ; $BC09: 20 5F 8F
        INC a:$075E                ; $BC0C: EE 5E 07
        LDA a:$075E                ; $BC0F: AD 5E 07
        CMP #$64                   ; $BC12: C9 64
        BNE LBC22                  ; $BC14: D0 0C
        LDA #$00                   ; $BC16: A9 00
        STA a:$075E                ; $BC18: 8D 5E 07
        INC a:$075A                ; $BC1B: EE 5A 07
        LDA #$40                   ; $BC1E: A9 40
        STA z:$FE                  ; $BC20: 85 FE
LBC22:
        LDA #$02                   ; $BC22: A9 02
        STA a:$0138                ; $BC24: 8D 38 01
        LDX a:$0753                ; $BC27: AE 53 07
        LDY a:$BBFA,x              ; $BC2A: BC FA BB
        JSR a:$8F5F                ; $BC2D: 20 5F 8F
        LDY a:$0753                ; $BC30: AC 53 07
        LDA a:$BBFC,y              ; $BC33: B9 FC BB
        JSR a:$8F06                ; $BC36: 20 06 8F
        LDY a:$0300                ; $BC39: AC 00 03
        LDA a:$02FB,y              ; $BC3C: B9 FB 02
        BNE LBC46                  ; $BC3F: D0 05
        LDA #$24                   ; $BC41: A9 24
        STA a:$02FB,y              ; $BC43: 99 FB 02
LBC46:
        LDX z:$08                  ; $BC46: A6 08
        RTS                        ; $BC48: 60
        LDA #$2E                   ; $BC49: A9 2E
        STA z:$1B                  ; $BC4B: 85 1B
        LDA z:$76,x                ; $BC4D: B5 76
        STA z:$73                  ; $BC4F: 85 73
        LDA z:$8F,x                ; $BC51: B5 8F
        STA z:$8C                  ; $BC53: 85 8C
        LDA #$01                   ; $BC55: A9 01
        STA z:$BB                  ; $BC57: 85 BB
        LDA z:$D7,x                ; $BC59: B5 D7
        SEC                        ; $BC5B: 38
        SBC #$08                   ; $BC5C: E9 08
        STA z:$D4                  ; $BC5E: 85 D4
        LDA #$01                   ; $BC60: A9 01
        STA z:$23                  ; $BC62: 85 23
        STA z:$14                  ; $BC64: 85 14
        LDA #$03                   ; $BC66: A9 03
        STA a:$049F                ; $BC68: 8D 9F 04
        LDA z:$39                  ; $BC6B: A5 39
        CMP #$02                   ; $BC6D: C9 02
        BCS LBC7B                  ; $BC6F: B0 0A
        LDA a:$0756                ; $BC71: AD 56 07
        CMP #$02                   ; $BC74: C9 02
        BCC LBC79                  ; $BC76: 90 01
        LSR a                      ; $BC78: 4A
LBC79:
        STA z:$39                  ; $BC79: 85 39
LBC7B:
        LDA #$20                   ; $BC7B: A9 20
        STA a:$03CA                ; $BC7D: 8D CA 03
        LDA #$02                   ; $BC80: A9 02
        STA z:$FE                  ; $BC82: 85 FE
        RTS                        ; $BC84: 60
        LDX #$05                   ; $BC85: A2 05
        STX z:$08                  ; $BC87: 86 08
        LDA z:$23                  ; $BC89: A5 23
        BEQ LBCEA                  ; $BC8B: F0 5D
        ASL a                      ; $BC8D: 0A
        BCC LBCB3                  ; $BC8E: 90 23
        LDA a:$0747                ; $BC90: AD 47 07
        BNE LBCD8                  ; $BC93: D0 43
        LDA z:$39                  ; $BC95: A5 39
        BEQ LBCAA                  ; $BC97: F0 11
        CMP #$03                   ; $BC99: C9 03
        BEQ LBCAA                  ; $BC9B: F0 0D
        CMP #$02                   ; $BC9D: C9 02
        BNE LBCD8                  ; $BC9F: D0 37
        JSR a:$CAF9                ; $BCA1: 20 F9 CA
        JSR a:$E163                ; $BCA4: 20 63 E1
        JMP a:$BCD8                ; $BCA7: 4C D8 BC
LBCAA:
        JSR a:$CA77                ; $BCAA: 20 77 CA
        JSR a:$DFC1                ; $BCAD: 20 C1 DF
        JMP a:$BCD8                ; $BCB0: 4C D8 BC
LBCB3:
        LDA z:$09                  ; $BCB3: A5 09
        AND #$03                   ; $BCB5: 29 03
        BNE LBCD2                  ; $BCB7: D0 19
        DEC z:$D4                  ; $BCB9: C6 D4
        LDA z:$23                  ; $BCBB: A5 23
        INC z:$23                  ; $BCBD: E6 23
        CMP #$11                   ; $BCBF: C9 11
        BCC LBCD2                  ; $BCC1: 90 0F
        LDA #$10                   ; $BCC3: A9 10
        STA z:$58,x                ; $BCC5: 95 58
        LDA #$80                   ; $BCC7: A9 80
        STA z:$23                  ; $BCC9: 85 23
        ASL a                      ; $BCCB: 0A
        STA a:$03CA                ; $BCCC: 8D CA 03
        ROL a                      ; $BCCF: 2A
        STA z:$46,x                ; $BCD0: 95 46
LBCD2:
        LDA z:$23                  ; $BCD2: A5 23
        CMP #$06                   ; $BCD4: C9 06
        BCC LBCEA                  ; $BCD6: 90 12
LBCD8:
        JSR a:$F152                ; $BCD8: 20 52 F1
        JSR a:$F1AF                ; $BCDB: 20 AF F1
        JSR a:$E243                ; $BCDE: 20 43 E2
        JSR a:$E6D2                ; $BCE1: 20 D2 E6
        JSR a:$D853                ; $BCE4: 20 53 D8
        JSR a:$D67A                ; $BCE7: 20 7A D6
LBCEA:
        RTS                        ; $BCEA: 60
        .byte $04,$12   ; $BCEB
        PHA                        ; $BCED: 48
        LDA #$11                   ; $BCEE: A9 11
        LDX a:$03EE                ; $BCF0: AE EE 03
        LDY a:$0754                ; $BCF3: AC 54 07
        BNE LBCFA                  ; $BCF6: D0 02
        LDA #$12                   ; $BCF8: A9 12
LBCFA:
        STA z:$26,x                ; $BCFA: 95 26
        JSR a:$8A6B                ; $BCFC: 20 6B 8A
        LDX a:$03EE                ; $BCFF: AE EE 03
        LDA z:$02                  ; $BD02: A5 02
        STA a:$03E4,x              ; $BD04: 9D E4 03
        TAY                        ; $BD07: A8
        LDA z:$06                  ; $BD08: A5 06
        STA a:$03E6,x              ; $BD0A: 9D E6 03
        LDA ($06),y                ; $BD0D: B1 06
        JSR a:$BDF6                ; $BD0F: 20 F6 BD
        STA z:$00                  ; $BD12: 85 00
        LDY a:$0754                ; $BD14: AC 54 07
        BNE LBD1A                  ; $BD17: D0 01
        TYA                        ; $BD19: 98
LBD1A:
        BCC LBD41                  ; $BD1A: 90 25
        LDY #$11                   ; $BD1C: A0 11
        STY z:$26,x                ; $BD1E: 94 26
        LDA #$C4                   ; $BD20: A9 C4
        LDY z:$00                  ; $BD22: A4 00
        CPY #$58                   ; $BD24: C0 58
        BEQ LBD2C                  ; $BD26: F0 04
        CPY #$5D                   ; $BD28: C0 5D
        BNE LBD41                  ; $BD2A: D0 15
LBD2C:
        LDA a:$06BC                ; $BD2C: AD BC 06
        BNE LBD39                  ; $BD2F: D0 08
        LDA #$0B                   ; $BD31: A9 0B
        STA a:$079D                ; $BD33: 8D 9D 07
        INC a:$06BC                ; $BD36: EE BC 06
LBD39:
        LDA a:$079D                ; $BD39: AD 9D 07
        BNE LBD40                  ; $BD3C: D0 02
        LDY #$C4                   ; $BD3E: A0 C4
LBD40:
        TYA                        ; $BD40: 98
LBD41:
        STA a:$03E8,x              ; $BD41: 9D E8 03
        JSR a:$BD84                ; $BD44: 20 84 BD
        LDY z:$02                  ; $BD47: A4 02
        LDA #$23                   ; $BD49: A9 23
        STA ($06),y                ; $BD4B: 91 06
        LDA #$10                   ; $BD4D: A9 10
        STA a:$0784                ; $BD4F: 8D 84 07
        PLA                        ; $BD52: 68
        STA z:$05                  ; $BD53: 85 05
        LDY #$00                   ; $BD55: A0 00
        LDA a:$0714                ; $BD57: AD 14 07
        BNE LBD61                  ; $BD5A: D0 05
        LDA a:$0754                ; $BD5C: AD 54 07
        BEQ LBD62                  ; $BD5F: F0 01
LBD61:
        INY                        ; $BD61: C8
LBD62:
        LDA z:$CE                  ; $BD62: A5 CE
        CLC                        ; $BD64: 18
        ADC a:$BCEB,y              ; $BD65: 79 EB BC
        AND #$F0                   ; $BD68: 29 F0
        STA z:$D7,x                ; $BD6A: 95 D7
        LDY z:$26,x                ; $BD6C: B4 26
        CPY #$11                   ; $BD6E: C0 11
        BEQ LBD78                  ; $BD70: F0 06
        JSR a:$BE02                ; $BD72: 20 02 BE
        JMP a:$BD7B                ; $BD75: 4C 7B BD
LBD78:
        JSR a:$BD9B                ; $BD78: 20 9B BD
        LDA a:$03EE                ; $BD7B: AD EE 03
        EOR #$01                   ; $BD7E: 49 01
        STA a:$03EE                ; $BD80: 8D EE 03
        RTS                        ; $BD83: 60
        LDA z:$86                  ; $BD84: A5 86
        CLC                        ; $BD86: 18
        ADC #$08                   ; $BD87: 69 08
        AND #$F0                   ; $BD89: 29 F0
        STA z:$8F,x                ; $BD8B: 95 8F
        LDA z:$6D                  ; $BD8D: A5 6D
        ADC #$00                   ; $BD8F: 69 00
        STA z:$76,x                ; $BD91: 95 76
        STA a:$03EA,x              ; $BD93: 9D EA 03
        LDA z:$B5                  ; $BD96: A5 B5
        STA z:$BE,x                ; $BD98: 95 BE
        RTS                        ; $BD9A: 60
        JSR a:$BE1F                ; $BD9B: 20 1F BE
        LDA #$02                   ; $BD9E: A9 02
        STA z:$FF                  ; $BDA0: 85 FF
        LDA #$00                   ; $BDA2: A9 00
        STA z:$60,x                ; $BDA4: 95 60
        STA a:$043C,x              ; $BDA6: 9D 3C 04
        STA z:$9F                  ; $BDA9: 85 9F
        LDA #$FE                   ; $BDAB: A9 FE
        STA z:$A8,x                ; $BDAD: 95 A8
        LDA z:$05                  ; $BDAF: A5 05
        JSR a:$BDF6                ; $BDB1: 20 F6 BD
        BCC LBDE7                  ; $BDB4: 90 31
        TYA                        ; $BDB6: 98
        CMP #$09                   ; $BDB7: C9 09
        BCC LBDBD                  ; $BDB9: 90 02
        SBC #$05                   ; $BDBB: E9 05
LBDBD:
        JSR a:$8E04                ; $BDBD: 20 04 8E
        .byte $D2,$BD,$38,$BB,$38,$BB,$D8,$BD,$D2,$BD,$DF,$BD,$D5,$BD,$38,$BB   ; $BDC0
        .byte $D8,$BD   ; $BDD0
        LDA #$00                   ; $BDD2: A9 00
        .byte $2C   ; $BDD4
        LDA #$02                   ; $BDD5: A9 02
        .byte $2C   ; $BDD7
        LDA #$03                   ; $BDD8: A9 03
        STA z:$39                  ; $BDDA: 85 39
        JMP a:$BC49                ; $BDDC: 4C 49 BC
        LDX #$05                   ; $BDDF: A2 05
        LDY a:$03EE                ; $BDE1: AC EE 03
        JSR a:$B91E                ; $BDE4: 20 1E B9
LBDE7:
        RTS                        ; $BDE7: 60
        .byte $C1,$C0,$5F,$60,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E   ; $BDE8
        LDY #$0D                   ; $BDF6: A0 0D
LBDF8:
        CMP a:$BDE8,y              ; $BDF8: D9 E8 BD
        BEQ LBE01                  ; $BDFB: F0 04
        DEY                        ; $BDFD: 88
        BPL LBDF8                  ; $BDFE: 10 F8
        CLC                        ; $BE00: 18
LBE01:
        RTS                        ; $BE01: 60
        JSR a:$BE1F                ; $BE02: 20 1F BE
        LDA #$01                   ; $BE05: A9 01
        STA a:$03EC,x              ; $BE07: 9D EC 03
        STA z:$FD                  ; $BE0A: 85 FD
        JSR a:$BE41                ; $BE0C: 20 41 BE
        LDA #$FE                   ; $BE0F: A9 FE
        STA z:$9F                  ; $BE11: 85 9F
        LDA #$05                   ; $BE13: A9 05
        STA a:$0139                ; $BE15: 8D 39 01
        JSR a:$BC27                ; $BE18: 20 27 BC
        LDX a:$03EE                ; $BE1B: AE EE 03
        RTS                        ; $BE1E: 60
        LDX a:$03EE                ; $BE1F: AE EE 03
        LDY z:$02                  ; $BE22: A4 02
        BEQ LBE40                  ; $BE24: F0 1A
        TYA                        ; $BE26: 98
        SEC                        ; $BE27: 38
        SBC #$10                   ; $BE28: E9 10
        STA z:$02                  ; $BE2A: 85 02
        TAY                        ; $BE2C: A8
        LDA ($06),y                ; $BE2D: B1 06
        CMP #$C2                   ; $BE2F: C9 C2
        BNE LBE40                  ; $BE31: D0 0D
        LDA #$00                   ; $BE33: A9 00
        STA ($06),y                ; $BE35: 91 06
        JSR a:$8A4D                ; $BE37: 20 4D 8A
        LDX a:$03EE                ; $BE3A: AE EE 03
        JSR a:$BB51                ; $BE3D: 20 51 BB
LBE40:
        RTS                        ; $BE40: 60
        LDA z:$8F,x                ; $BE41: B5 8F
        STA a:$03F1,x              ; $BE43: 9D F1 03
        LDA #$F0                   ; $BE46: A9 F0
        STA z:$60,x                ; $BE48: 95 60
        STA z:$62,x                ; $BE4A: 95 62
        LDA #$FA                   ; $BE4C: A9 FA
        STA z:$A8,x                ; $BE4E: 95 A8
        LDA #$FC                   ; $BE50: A9 FC
        STA z:$AA,x                ; $BE52: 95 AA
        LDA #$00                   ; $BE54: A9 00
        STA a:$043C,x              ; $BE56: 9D 3C 04
        STA a:$043E,x              ; $BE59: 9D 3E 04
        LDA z:$76,x                ; $BE5C: B5 76
        STA z:$78,x                ; $BE5E: 95 78
        LDA z:$8F,x                ; $BE60: B5 8F
        STA z:$91,x                ; $BE62: 95 91
        LDA z:$D7,x                ; $BE64: B5 D7
        CLC                        ; $BE66: 18
        ADC #$08                   ; $BE67: 69 08
        STA z:$D9,x                ; $BE69: 95 D9
        LDA #$FA                   ; $BE6B: A9 FA
        STA z:$A8,x                ; $BE6D: 95 A8
        RTS                        ; $BE6F: 60
        LDA z:$26,x                ; $BE70: B5 26
        BEQ LBED1                  ; $BE72: F0 5D
        AND #$0F                   ; $BE74: 29 0F
        PHA                        ; $BE76: 48
        TAY                        ; $BE77: A8
        TXA                        ; $BE78: 8A
        CLC                        ; $BE79: 18
        ADC #$09                   ; $BE7A: 69 09
        TAX                        ; $BE7C: AA
        DEY                        ; $BE7D: 88
        BEQ LBEB3                  ; $BE7E: F0 33
        JSR a:$BFA4                ; $BE80: 20 A4 BF
        JSR a:$BF0F                ; $BE83: 20 0F BF
        TXA                        ; $BE86: 8A
        CLC                        ; $BE87: 18
        ADC #$02                   ; $BE88: 69 02
        TAX                        ; $BE8A: AA
        JSR a:$BFA4                ; $BE8B: 20 A4 BF
        JSR a:$BF0F                ; $BE8E: 20 0F BF
        LDX z:$08                  ; $BE91: A6 08
        JSR a:$F159                ; $BE93: 20 59 F1
        JSR a:$F1B6                ; $BE96: 20 B6 F1
        JSR a:$EC53                ; $BE99: 20 53 EC
        PLA                        ; $BE9C: 68
        LDY z:$BE,x                ; $BE9D: B4 BE
        BEQ LBED1                  ; $BE9F: F0 30
        PHA                        ; $BEA1: 48
        LDA #$F0                   ; $BEA2: A9 F0
        CMP z:$D9,x                ; $BEA4: D5 D9
        BCS LBEAA                  ; $BEA6: B0 02
        STA z:$D9,x                ; $BEA8: 95 D9
LBEAA:
        LDA z:$D7,x                ; $BEAA: B5 D7
        CMP #$F0                   ; $BEAC: C9 F0
        PLA                        ; $BEAE: 68
        BCC LBED1                  ; $BEAF: 90 20
        BCS LBECF                  ; $BEB1: B0 1C
LBEB3:
        JSR a:$BFA4                ; $BEB3: 20 A4 BF
        LDX z:$08                  ; $BEB6: A6 08
        JSR a:$F159                ; $BEB8: 20 59 F1
        JSR a:$F1B6                ; $BEBB: 20 B6 F1
        JSR a:$EBD1                ; $BEBE: 20 D1 EB
        LDA z:$D7,x                ; $BEC1: B5 D7
        AND #$0F                   ; $BEC3: 29 0F
        CMP #$05                   ; $BEC5: C9 05
        PLA                        ; $BEC7: 68
        BCS LBED1                  ; $BEC8: B0 07
        LDA #$01                   ; $BECA: A9 01
        STA a:$03EC,x              ; $BECC: 9D EC 03
LBECF:
        LDA #$00                   ; $BECF: A9 00
LBED1:
        STA z:$26,x                ; $BED1: 95 26
        RTS                        ; $BED3: 60
        LDX #$01                   ; $BED4: A2 01
LBED6:
        STX z:$08                  ; $BED6: 86 08
        LDA a:$0301                ; $BED8: AD 01 03
        BNE LBEFE                  ; $BEDB: D0 21
        LDA a:$03EC,x              ; $BEDD: BD EC 03
        BEQ LBEFE                  ; $BEE0: F0 1C
        LDA a:$03E6,x              ; $BEE2: BD E6 03
        STA z:$06                  ; $BEE5: 85 06
        LDA #$05                   ; $BEE7: A9 05
        STA z:$07                  ; $BEE9: 85 07
        LDA a:$03E4,x              ; $BEEB: BD E4 03
        STA z:$02                  ; $BEEE: 85 02
        TAY                        ; $BEF0: A8
        LDA a:$03E8,x              ; $BEF1: BD E8 03
        STA ($06),y                ; $BEF4: 91 06
        JSR a:$8A61                ; $BEF6: 20 61 8A
        LDA #$00                   ; $BEF9: A9 00
        STA a:$03EC,x              ; $BEFB: 9D EC 03
LBEFE:
        DEX                        ; $BEFE: CA
        BPL LBED6                  ; $BEFF: 10 D5
        RTS                        ; $BF01: 60
        INX                        ; $BF02: E8
        JSR a:$BF0F                ; $BF03: 20 0F BF
        LDX z:$08                  ; $BF06: A6 08
        RTS                        ; $BF08: 60
        LDA a:$070E                ; $BF09: AD 0E 07
        BNE LBF4C                  ; $BF0C: D0 3E
        TAX                        ; $BF0E: AA
        LDA z:$57,x                ; $BF0F: B5 57
        ASL a                      ; $BF11: 0A
        ASL a                      ; $BF12: 0A
        ASL a                      ; $BF13: 0A
        ASL a                      ; $BF14: 0A
        STA z:$01                  ; $BF15: 85 01
        LDA z:$57,x                ; $BF17: B5 57
        LSR a                      ; $BF19: 4A
        LSR a                      ; $BF1A: 4A
        LSR a                      ; $BF1B: 4A
        LSR a                      ; $BF1C: 4A
        CMP #$08                   ; $BF1D: C9 08
        BCC LBF23                  ; $BF1F: 90 02
        ORA #$F0                   ; $BF21: 09 F0
LBF23:
        STA z:$00                  ; $BF23: 85 00
        LDY #$00                   ; $BF25: A0 00
        CMP #$00                   ; $BF27: C9 00
        BPL LBF2C                  ; $BF29: 10 01
        DEY                        ; $BF2B: 88
LBF2C:
        STY z:$02                  ; $BF2C: 84 02
        LDA a:$0400,x              ; $BF2E: BD 00 04
        CLC                        ; $BF31: 18
        ADC z:$01                  ; $BF32: 65 01
        STA a:$0400,x              ; $BF34: 9D 00 04
        LDA #$00                   ; $BF37: A9 00
        ROL a                      ; $BF39: 2A
        PHA                        ; $BF3A: 48
        ROR a                      ; $BF3B: 6A
        LDA z:$86,x                ; $BF3C: B5 86
        ADC z:$00                  ; $BF3E: 65 00
        STA z:$86,x                ; $BF40: 95 86
        LDA z:$6D,x                ; $BF42: B5 6D
        ADC z:$02                  ; $BF44: 65 02
        STA z:$6D,x                ; $BF46: 95 6D
        PLA                        ; $BF48: 68
        CLC                        ; $BF49: 18
        ADC z:$00                  ; $BF4A: 65 00
LBF4C:
        RTS                        ; $BF4C: 60
        LDX #$00                   ; $BF4D: A2 00
        LDA a:$0747                ; $BF4F: AD 47 07
        BNE LBF59                  ; $BF52: D0 05
        LDA a:$070E                ; $BF54: AD 0E 07
        BNE LBF4C                  ; $BF57: D0 F3
LBF59:
        LDA a:$0709                ; $BF59: AD 09 07
        STA z:$00                  ; $BF5C: 85 00
        LDA #$04                   ; $BF5E: A9 04
        JMP a:$BFAD                ; $BF60: 4C AD BF
        LDY #$3D                   ; $BF63: A0 3D
        LDA z:$1E,x                ; $BF65: B5 1E
        CMP #$05                   ; $BF67: C9 05
        BNE LBF6D                  ; $BF69: D0 02
        LDY #$20                   ; $BF6B: A0 20
LBF6D:
        JMP a:$BF94                ; $BF6D: 4C 94 BF
        .byte $A0,$00,$4C,$77,$BF,$A0,$01,$E8,$A9,$03,$85,$00,$A9,$06,$85,$01   ; $BF70
        .byte $A9,$02,$85,$02,$98,$4C,$D1,$BF   ; $BF80
        LDY #$7F                   ; $BF88: A0 7F
        BNE LBF8E                  ; $BF8A: D0 02
        LDY #$0F                   ; $BF8C: A0 0F
LBF8E:
        LDA #$02                   ; $BF8E: A9 02
        BNE LBF96                  ; $BF90: D0 04
        LDY #$1C                   ; $BF92: A0 1C
        LDA #$03                   ; $BF94: A9 03
LBF96:
        STY z:$00                  ; $BF96: 84 00
        INX                        ; $BF98: E8
        JSR a:$BFAD                ; $BF99: 20 AD BF
        LDX z:$08                  ; $BF9C: A6 08
        RTS                        ; $BF9E: 60
        .byte $06,$08,$A0,$00,$2C   ; $BF9F
        LDY #$01                   ; $BFA4: A0 01
        LDA #$50                   ; $BFA6: A9 50
        STA z:$00                  ; $BFA8: 85 00
        LDA a:$BF9F,y              ; $BFAA: B9 9F BF
        STA z:$02                  ; $BFAD: 85 02
        LDA #$00                   ; $BFAF: A9 00
        JMP a:$BFD7                ; $BFB1: 4C D7 BF
        LDA #$00                   ; $BFB4: A9 00
        BIT a:$01A9                ; $BFB6: 2C A9 01
        PHA                        ; $BFB9: 48
        LDY z:$16,x                ; $BFBA: B4 16
        INX                        ; $BFBC: E8
        LDA #$05                   ; $BFBD: A9 05
        CPY #$29                   ; $BFBF: C0 29
        BNE LBFC5                  ; $BFC1: D0 02
        LDA #$09                   ; $BFC3: A9 09
LBFC5:
        STA z:$00                  ; $BFC5: 85 00
        LDA #$0A                   ; $BFC7: A9 0A
        STA z:$01                  ; $BFC9: 85 01
        LDA #$03                   ; $BFCB: A9 03
        STA z:$02                  ; $BFCD: 85 02
        PLA                        ; $BFCF: 68
        TAY                        ; $BFD0: A8
        JSR a:$BFD7                ; $BFD1: 20 D7 BF
        LDX z:$08                  ; $BFD4: A6 08
        RTS                        ; $BFD6: 60
        PHA                        ; $BFD7: 48
        LDA a:$0416,x              ; $BFD8: BD 16 04
        CLC                        ; $BFDB: 18
        ADC a:$0433,x              ; $BFDC: 7D 33 04
        STA a:$0416,x              ; $BFDF: 9D 16 04
        LDY #$00                   ; $BFE2: A0 00
        LDA z:$9F,x                ; $BFE4: B5 9F
        BPL LBFE9                  ; $BFE6: 10 01
        DEY                        ; $BFE8: 88
LBFE9:
        STY z:$07                  ; $BFE9: 84 07
        ADC z:$CE,x                ; $BFEB: 75 CE
        STA z:$CE,x                ; $BFED: 95 CE
        LDA z:$B5,x                ; $BFEF: B5 B5
        ADC z:$07                  ; $BFF1: 65 07
        STA z:$B5,x                ; $BFF3: 95 B5
        LDA a:$0433,x              ; $BFF5: BD 33 04
        CLC                        ; $BFF8: 18
        ADC z:$00                  ; $BFF9: 65 00
        STA a:$0433,x              ; $BFFB: 9D 33 04
        LDA z:$9F,x                ; $BFFE: B5 9F
        ADC #$00                   ; $C000: 69 00
        STA z:$9F,x                ; $C002: 95 9F
        CMP z:$02                  ; $C004: C5 02
        BMI LC018                  ; $C006: 30 10
        LDA a:$0433,x              ; $C008: BD 33 04
        CMP #$80                   ; $C00B: C9 80
        BCC LC018                  ; $C00D: 90 09
        LDA z:$02                  ; $C00F: A5 02
        STA z:$9F,x                ; $C011: 95 9F
        LDA #$00                   ; $C013: A9 00
        STA a:$0433,x              ; $C015: 9D 33 04
LC018:
        PLA                        ; $C018: 68
        BEQ LC046                  ; $C019: F0 2B
        LDA z:$02                  ; $C01B: A5 02
        EOR #$FF                   ; $C01D: 49 FF
        TAY                        ; $C01F: A8
        INY                        ; $C020: C8
        STY z:$07                  ; $C021: 84 07
        LDA a:$0433,x              ; $C023: BD 33 04
        SEC                        ; $C026: 38
        SBC z:$01                  ; $C027: E5 01
        STA a:$0433,x              ; $C029: 9D 33 04
        LDA z:$9F,x                ; $C02C: B5 9F
        SBC #$00                   ; $C02E: E9 00
        STA z:$9F,x                ; $C030: 95 9F
        CMP z:$07                  ; $C032: C5 07
        BPL LC046                  ; $C034: 10 10
        LDA a:$0433,x              ; $C036: BD 33 04
        CMP #$80                   ; $C039: C9 80
        BCS LC046                  ; $C03B: B0 09
        LDA z:$07                  ; $C03D: A5 07
        STA z:$9F,x                ; $C03F: 95 9F
        LDA #$FF                   ; $C041: A9 FF
        STA a:$0433,x              ; $C043: 9D 33 04
LC046:
        RTS                        ; $C046: 60
        LDA z:$0F,x                ; $C047: B5 0F
        PHA                        ; $C049: 48
        ASL a                      ; $C04A: 0A
        BCS LC05F                  ; $C04B: B0 12
        PLA                        ; $C04D: 68
        BEQ LC053                  ; $C04E: F0 03
        JMP a:$C882                ; $C050: 4C 82 C8
LC053:
        LDA a:$071F                ; $C053: AD 1F 07
        AND #$07                   ; $C056: 29 07
        CMP #$07                   ; $C058: C9 07
        BEQ LC06A                  ; $C05A: F0 0E
        JMP a:$C0CC                ; $C05C: 4C CC C0
LC05F:
        PLA                        ; $C05F: 68
        AND #$0F                   ; $C060: 29 0F
        TAY                        ; $C062: A8
        LDA a:$000F,y              ; $C063: B9 0F 00
        BNE LC06A                  ; $C066: D0 02
        STA z:$0F,x                ; $C068: 95 0F
LC06A:
        RTS                        ; $C06A: 60
        .byte $03,$03,$06,$06,$06,$06,$06,$06,$07,$07,$07,$05,$09,$04,$05,$06   ; $C06B
        .byte $08,$09,$0A,$06,$0B,$10,$40,$B0,$B0,$80,$40,$40,$80,$40,$F0,$F0   ; $C07B
        .byte $F0   ; $C08B
        LDA z:$6D                  ; $C08C: A5 6D
        SEC                        ; $C08E: 38
        SBC #$04                   ; $C08F: E9 04
        STA z:$6D                  ; $C091: 85 6D
        LDA a:$0725                ; $C093: AD 25 07
        SEC                        ; $C096: 38
        SBC #$04                   ; $C097: E9 04
        STA a:$0725                ; $C099: 8D 25 07
        LDA a:$071A                ; $C09C: AD 1A 07
        SEC                        ; $C09F: 38
        SBC #$04                   ; $C0A0: E9 04
        STA a:$071A                ; $C0A2: 8D 1A 07
        LDA a:$071B                ; $C0A5: AD 1B 07
        SEC                        ; $C0A8: 38
        SBC #$04                   ; $C0A9: E9 04
        STA a:$071B                ; $C0AB: 8D 1B 07
        LDA a:$072A                ; $C0AE: AD 2A 07
        SEC                        ; $C0B1: 38
        SBC #$04                   ; $C0B2: E9 04
        STA a:$072A                ; $C0B4: 8D 2A 07
        LDA #$00                   ; $C0B7: A9 00
        STA a:$073B                ; $C0B9: 8D 3B 07
        STA a:$072B                ; $C0BC: 8D 2B 07
        STA a:$0739                ; $C0BF: 8D 39 07
        STA a:$073A                ; $C0C2: 8D 3A 07
        LDA a:$9BF8,y              ; $C0C5: B9 F8 9B
        STA a:$072C                ; $C0C8: 8D 2C 07
        RTS                        ; $C0CB: 60
        LDA a:$0745                ; $C0CC: AD 45 07
        BEQ LC12F                  ; $C0CF: F0 5E
        LDA a:$0726                ; $C0D1: AD 26 07
        BNE LC12F                  ; $C0D4: D0 59
        LDY #$0B                   ; $C0D6: A0 0B
LC0D8:
        DEY                        ; $C0D8: 88
        BMI LC12F                  ; $C0D9: 30 54
        LDA a:$075F                ; $C0DB: AD 5F 07
        CMP a:$C06B,y              ; $C0DE: D9 6B C0
        BNE LC0D8                  ; $C0E1: D0 F5
        LDA a:$0725                ; $C0E3: AD 25 07
        CMP a:$C076,y              ; $C0E6: D9 76 C0
        BNE LC0D8                  ; $C0E9: D0 ED
        LDA z:$CE                  ; $C0EB: A5 CE
        CMP a:$C081,y              ; $C0ED: D9 81 C0
        BNE LC115                  ; $C0F0: D0 23
        LDA z:$1D                  ; $C0F2: A5 1D
        CMP #$00                   ; $C0F4: C9 00
        BNE LC115                  ; $C0F6: D0 1D
        LDA a:$075F                ; $C0F8: AD 5F 07
        CMP #$06                   ; $C0FB: C9 06
        BNE LC122                  ; $C0FD: D0 23
        INC a:$06D9                ; $C0FF: EE D9 06
LC102:
        INC a:$06DA                ; $C102: EE DA 06
        LDA a:$06DA                ; $C105: AD DA 06
        CMP #$03                   ; $C108: C9 03
        BNE LC12A                  ; $C10A: D0 1E
        LDA a:$06D9                ; $C10C: AD D9 06
        CMP #$03                   ; $C10F: C9 03
        BEQ LC122                  ; $C111: F0 0F
        BNE LC11C                  ; $C113: D0 07
LC115:
        LDA a:$075F                ; $C115: AD 5F 07
        CMP #$06                   ; $C118: C9 06
        BEQ LC102                  ; $C11A: F0 E6
LC11C:
        JSR a:$C08C                ; $C11C: 20 8C C0
        JSR a:$D071                ; $C11F: 20 71 D0
LC122:
        LDA #$00                   ; $C122: A9 00
        STA a:$06DA                ; $C124: 8D DA 06
        STA a:$06D9                ; $C127: 8D D9 06
LC12A:
        LDA #$00                   ; $C12A: A9 00
        STA a:$0745                ; $C12C: 8D 45 07
LC12F:
        LDA a:$06CD                ; $C12F: AD CD 06
        BEQ LC144                  ; $C132: F0 10
        STA z:$16,x                ; $C134: 95 16
        LDA #$01                   ; $C136: A9 01
        STA z:$0F,x                ; $C138: 95 0F
        LDA #$00                   ; $C13A: A9 00
        STA z:$1E,x                ; $C13C: 95 1E
        STA a:$06CD                ; $C13E: 8D CD 06
        JMP a:$C226                ; $C141: 4C 26 C2
LC144:
        LDY a:$0739                ; $C144: AC 39 07
        LDA ($E9),y                ; $C147: B1 E9
        CMP #$FF                   ; $C149: C9 FF
        BNE LC150                  ; $C14B: D0 03
        JMP a:$C216                ; $C14D: 4C 16 C2
LC150:
        AND #$0F                   ; $C150: 29 0F
        CMP #$0E                   ; $C152: C9 0E
        BEQ LC164                  ; $C154: F0 0E
        CPX #$05                   ; $C156: E0 05
        BCC LC164                  ; $C158: 90 0A
        INY                        ; $C15A: C8
        LDA ($E9),y                ; $C15B: B1 E9
        AND #$3F                   ; $C15D: 29 3F
        CMP #$2E                   ; $C15F: C9 2E
        BEQ LC164                  ; $C161: F0 01
        RTS                        ; $C163: 60
LC164:
        LDA a:$071D                ; $C164: AD 1D 07
        CLC                        ; $C167: 18
        ADC #$30                   ; $C168: 69 30
        AND #$F0                   ; $C16A: 29 F0
        STA z:$07                  ; $C16C: 85 07
        LDA a:$071B                ; $C16E: AD 1B 07
        ADC #$00                   ; $C171: 69 00
        STA z:$06                  ; $C173: 85 06
        LDY a:$0739                ; $C175: AC 39 07
        INY                        ; $C178: C8
        LDA ($E9),y                ; $C179: B1 E9
        ASL a                      ; $C17B: 0A
        BCC LC189                  ; $C17C: 90 0B
        LDA a:$073B                ; $C17E: AD 3B 07
        BNE LC189                  ; $C181: D0 06
        INC a:$073B                ; $C183: EE 3B 07
        INC a:$073A                ; $C186: EE 3A 07
LC189:
        DEY                        ; $C189: 88
        LDA ($E9),y                ; $C18A: B1 E9
        AND #$0F                   ; $C18C: 29 0F
        CMP #$0F                   ; $C18E: C9 0F
        BNE LC1AB                  ; $C190: D0 19
        LDA a:$073B                ; $C192: AD 3B 07
        BNE LC1AB                  ; $C195: D0 14
        INY                        ; $C197: C8
        LDA ($E9),y                ; $C198: B1 E9
        AND #$3F                   ; $C19A: 29 3F
        STA a:$073A                ; $C19C: 8D 3A 07
        INC a:$0739                ; $C19F: EE 39 07
        INC a:$0739                ; $C1A2: EE 39 07
        INC a:$073B                ; $C1A5: EE 3B 07
        JMP a:$C0CC                ; $C1A8: 4C CC C0
LC1AB:
        LDA a:$073A                ; $C1AB: AD 3A 07
        STA z:$6E,x                ; $C1AE: 95 6E
        LDA ($E9),y                ; $C1B0: B1 E9
        AND #$F0                   ; $C1B2: 29 F0
        STA z:$87,x                ; $C1B4: 95 87
        CMP a:$071D                ; $C1B6: CD 1D 07
        LDA z:$6E,x                ; $C1B9: B5 6E
        SBC a:$071B                ; $C1BB: ED 1B 07
        BCS LC1CB                  ; $C1BE: B0 0B
        LDA ($E9),y                ; $C1C0: B1 E9
        AND #$0F                   ; $C1C2: 29 0F
        CMP #$0E                   ; $C1C4: C9 0E
        BEQ LC231                  ; $C1C6: F0 69
        JMP a:$C250                ; $C1C8: 4C 50 C2
LC1CB:
        LDA z:$07                  ; $C1CB: A5 07
        CMP z:$87,x                ; $C1CD: D5 87
        LDA z:$06                  ; $C1CF: A5 06
        SBC z:$6E,x                ; $C1D1: F5 6E
        BCC LC216                  ; $C1D3: 90 41
        LDA #$01                   ; $C1D5: A9 01
        STA z:$B6,x                ; $C1D7: 95 B6
        LDA ($E9),y                ; $C1D9: B1 E9
        ASL a                      ; $C1DB: 0A
        ASL a                      ; $C1DC: 0A
        ASL a                      ; $C1DD: 0A
        ASL a                      ; $C1DE: 0A
        STA z:$CF,x                ; $C1DF: 95 CF
        CMP #$E0                   ; $C1E1: C9 E0
        BEQ LC231                  ; $C1E3: F0 4C
        INY                        ; $C1E5: C8
        LDA ($E9),y                ; $C1E6: B1 E9
        AND #$40                   ; $C1E8: 29 40
        BEQ LC1F1                  ; $C1EA: F0 05
        LDA a:$06CC                ; $C1EC: AD CC 06
        BEQ LC25E                  ; $C1EF: F0 6D
LC1F1:
        LDA ($E9),y                ; $C1F1: B1 E9
        AND #$3F                   ; $C1F3: 29 3F
        CMP #$37                   ; $C1F5: C9 37
        BCC LC1FD                  ; $C1F7: 90 04
        CMP #$3F                   ; $C1F9: C9 3F
        BCC LC22E                  ; $C1FB: 90 31
LC1FD:
        CMP #$06                   ; $C1FD: C9 06
        BNE LC208                  ; $C1FF: D0 07
        LDY a:$076A                ; $C201: AC 6A 07
        BEQ LC208                  ; $C204: F0 02
        LDA #$02                   ; $C206: A9 02
LC208:
        STA z:$16,x                ; $C208: 95 16
        LDA #$01                   ; $C20A: A9 01
        STA z:$0F,x                ; $C20C: 95 0F
        JSR a:$C226                ; $C20E: 20 26 C2
        LDA z:$0F,x                ; $C211: B5 0F
        BNE LC25E                  ; $C213: D0 49
        RTS                        ; $C215: 60
LC216:
        LDA a:$06CB                ; $C216: AD CB 06
        BNE LC224                  ; $C219: D0 09
        LDA a:$0398                ; $C21B: AD 98 03
        CMP #$01                   ; $C21E: C9 01
        BNE LC22D                  ; $C220: D0 0B
        LDA #$2F                   ; $C222: A9 2F
LC224:
        STA z:$16,x                ; $C224: 95 16
        LDA #$00                   ; $C226: A9 00
        STA z:$1E,x                ; $C228: 95 1E
        JSR a:$C26C                ; $C22A: 20 6C C2
LC22D:
        RTS                        ; $C22D: 60
LC22E:
        JMP a:$C71B                ; $C22E: 4C 1B C7
LC231:
        INY                        ; $C231: C8
        INY                        ; $C232: C8
        LDA ($E9),y                ; $C233: B1 E9
        LSR a                      ; $C235: 4A
        LSR a                      ; $C236: 4A
        LSR a                      ; $C237: 4A
        LSR a                      ; $C238: 4A
        LSR a                      ; $C239: 4A
        CMP a:$075F                ; $C23A: CD 5F 07
        BNE LC24D                  ; $C23D: D0 0E
        DEY                        ; $C23F: 88
        LDA ($E9),y                ; $C240: B1 E9
        STA a:$0750                ; $C242: 8D 50 07
        INY                        ; $C245: C8
        LDA ($E9),y                ; $C246: B1 E9
        AND #$1F                   ; $C248: 29 1F
        STA a:$0751                ; $C24A: 8D 51 07
LC24D:
        JMP a:$C25B                ; $C24D: 4C 5B C2
        LDY a:$0739                ; $C250: AC 39 07
        LDA ($E9),y                ; $C253: B1 E9
        AND #$0F                   ; $C255: 29 0F
        CMP #$0E                   ; $C257: C9 0E
        BNE LC25E                  ; $C259: D0 03
        INC a:$0739                ; $C25B: EE 39 07
LC25E:
        INC a:$0739                ; $C25E: EE 39 07
        INC a:$0739                ; $C261: EE 39 07
        LDA #$00                   ; $C264: A9 00
        STA a:$073B                ; $C266: 8D 3B 07
        LDX z:$08                  ; $C269: A6 08
        RTS                        ; $C26B: 60
        LDA z:$16,x                ; $C26C: B5 16
        CMP #$15                   ; $C26E: C9 15
        BCS LC27F                  ; $C270: B0 0D
        TAY                        ; $C272: A8
        LDA z:$CF,x                ; $C273: B5 CF
        ADC #$08                   ; $C275: 69 08
        STA z:$CF,x                ; $C277: 95 CF
        LDA #$01                   ; $C279: A9 01
        STA a:$03D8,x              ; $C27B: 9D D8 03
        TYA                        ; $C27E: 98
LC27F:
        JSR a:$8E04                ; $C27F: 20 04 8E
        .byte $0E,$C3,$0E,$C3,$0E,$C3,$1E,$C3,$F0,$C2,$28,$C3,$F1,$C2,$42,$C3   ; $C282
        .byte $6B,$C3,$F0,$C2,$75,$C3,$75,$C3,$F7,$C2,$87,$C7,$D1,$C7,$4A,$C3   ; $C292
        .byte $3D,$C3,$85,$C3,$A0,$C7,$F0,$C2,$A0,$C7,$A0,$C7,$A0,$C7,$A0,$C7   ; $C2A2
        .byte $B8,$C7,$F0,$C2,$F0,$C2,$5C,$C4,$5C,$C4,$5C,$C4,$5C,$C4,$59,$C4   ; $C2B2
        .byte $F0,$C2,$F0,$C2,$F0,$C2,$F0,$C2,$DF,$C7,$12,$C8,$3F,$C8,$45,$C8   ; $C2C2
        .byte $0B,$C8,$03,$C8,$0B,$C8,$4B,$C8,$57,$C8,$49,$C5,$60,$BC,$1E,$B9   ; $C2D2
        .byte $F0,$C2,$F0,$C2,$F0,$C2,$F0,$C2,$F0,$C2,$07,$C3,$81,$C8   ; $C2E2
        RTS                        ; $C2F0: 60
        JSR a:$C30E                ; $C2F1: 20 0E C3
        JMP a:$C346                ; $C2F4: 4C 46 C3
        LDA #$02                   ; $C2F7: A9 02
        STA z:$B6,x                ; $C2F9: 95 B6
        STA z:$CF,x                ; $C2FB: 95 CF
        LSR a                      ; $C2FD: 4A
        STA a:$0796,x              ; $C2FE: 9D 96 07
        LSR a                      ; $C301: 4A
        STA z:$1E,x                ; $C302: 95 1E
        JMP a:$C346                ; $C304: 4C 46 C3
        .byte $A9,$B8,$95,$CF,$60,$F8,$F4   ; $C307
        LDY #$01                   ; $C30E: A0 01
        LDA a:$076A                ; $C310: AD 6A 07
        BNE LC316                  ; $C313: D0 01
        DEY                        ; $C315: 88
LC316:
        LDA a:$C30C,y              ; $C316: B9 0C C3
        STA z:$58,x                ; $C319: 95 58
        JMP a:$C35A                ; $C31B: 4C 5A C3
        JSR a:$C30E                ; $C31E: 20 0E C3
        LDA #$01                   ; $C321: A9 01
        STA z:$1E,x                ; $C323: 95 1E
        RTS                        ; $C325: 60
        .byte $80,$50   ; $C326
        LDA #$00                   ; $C328: A9 00
        STA a:$03A2,x              ; $C32A: 9D A2 03
        STA z:$58,x                ; $C32D: 95 58
        LDY a:$06CC                ; $C32F: AC CC 06
        LDA a:$C326,y              ; $C332: B9 26 C3
        STA a:$0796,x              ; $C335: 9D 96 07
        LDA #$0B                   ; $C338: A9 0B
        JMP a:$C35C                ; $C33A: 4C 5C C3
        LDA #$00                   ; $C33D: A9 00
        JMP a:$C319                ; $C33F: 4C 19 C3
        LDA #$00                   ; $C342: A9 00
        STA z:$58,x                ; $C344: 95 58
        LDA #$09                   ; $C346: A9 09
        BNE LC35C                  ; $C348: D0 12
        LDY #$30                   ; $C34A: A0 30
        LDA z:$CF,x                ; $C34C: B5 CF
        STA a:$0401,x              ; $C34E: 9D 01 04
        BPL LC355                  ; $C351: 10 02
        LDY #$E0                   ; $C353: A0 E0
LC355:
        TYA                        ; $C355: 98
        ADC z:$CF,x                ; $C356: 75 CF
        STA z:$58,x                ; $C358: 95 58
        LDA #$03                   ; $C35A: A9 03
LC35C:
        STA a:$049A,x              ; $C35C: 9D 9A 04
        LDA #$02                   ; $C35F: A9 02
        STA z:$46,x                ; $C361: 95 46
        LDA #$00                   ; $C363: A9 00
        STA z:$A0,x                ; $C365: 95 A0
        STA a:$0434,x              ; $C367: 9D 34 04
        RTS                        ; $C36A: 60
        LDA #$02                   ; $C36B: A9 02
        STA z:$46,x                ; $C36D: 95 46
        LDA #$09                   ; $C36F: A9 09
        STA a:$049A,x              ; $C371: 9D 9A 04
        RTS                        ; $C374: 60
        JSR a:$C346                ; $C375: 20 46 C3
        LDA a:$07A7,x              ; $C378: BD A7 07
        AND #$10                   ; $C37B: 29 10
        STA z:$58,x                ; $C37D: 95 58
        LDA z:$CF,x                ; $C37F: B5 CF
        STA a:$0434,x              ; $C381: 9D 34 04
        RTS                        ; $C384: 60
        LDA a:$06CB                ; $C385: AD CB 06
        BNE LC395                  ; $C388: D0 0B
        LDA #$00                   ; $C38A: A9 00
        STA a:$06D1                ; $C38C: 8D D1 06
        JSR a:$C33D                ; $C38F: 20 3D C3
        JMP a:$C7D9                ; $C392: 4C D9 C7
LC395:
        JMP a:$C998                ; $C395: 4C 98 C9
        .byte $26,$2C,$32,$38,$20,$22,$24,$26,$13,$14,$15,$16   ; $C398
        LDA a:$078F                ; $C3A4: AD 8F 07
        BNE LC3E5                  ; $C3A7: D0 3C
        CPX #$05                   ; $C3A9: E0 05
        BCS LC3E5                  ; $C3AB: B0 38
        LDA #$80                   ; $C3AD: A9 80
        STA a:$078F                ; $C3AF: 8D 8F 07
        LDY #$04                   ; $C3B2: A0 04
LC3B4:
        LDA a:$0016,y              ; $C3B4: B9 16 00
        CMP #$11                   ; $C3B7: C9 11
        BEQ LC3E6                  ; $C3B9: F0 2B
        DEY                        ; $C3BB: 88
        BPL LC3B4                  ; $C3BC: 10 F6
        INC a:$06D1                ; $C3BE: EE D1 06
        LDA a:$06D1                ; $C3C1: AD D1 06
        CMP #$07                   ; $C3C4: C9 07
        BCC LC3E5                  ; $C3C6: 90 1D
        LDX #$04                   ; $C3C8: A2 04
LC3CA:
        LDA z:$0F,x                ; $C3CA: B5 0F
        BEQ LC3D3                  ; $C3CC: F0 05
        DEX                        ; $C3CE: CA
        BPL LC3CA                  ; $C3CF: 10 F9
        BMI LC3E3                  ; $C3D1: 30 10
LC3D3:
        LDA #$00                   ; $C3D3: A9 00
        STA z:$1E,x                ; $C3D5: 95 1E
        LDA #$11                   ; $C3D7: A9 11
        STA z:$16,x                ; $C3D9: 95 16
        JSR a:$C38A                ; $C3DB: 20 8A C3
        LDA #$20                   ; $C3DE: A9 20
        JSR a:$C5D8                ; $C3E0: 20 D8 C5
LC3E3:
        LDX z:$08                  ; $C3E3: A6 08
LC3E5:
        RTS                        ; $C3E5: 60
LC3E6:
        LDA z:$CE                  ; $C3E6: A5 CE
        CMP #$2C                   ; $C3E8: C9 2C
        BCC LC3E5                  ; $C3EA: 90 F9
        LDA a:$001E,y              ; $C3EC: B9 1E 00
        BNE LC3E5                  ; $C3EF: D0 F4
        LDA a:$006E,y              ; $C3F1: B9 6E 00
        STA z:$6E,x                ; $C3F4: 95 6E
        LDA a:$0087,y              ; $C3F6: B9 87 00
        STA z:$87,x                ; $C3F9: 95 87
        LDA #$01                   ; $C3FB: A9 01
        STA z:$B6,x                ; $C3FD: 95 B6
        LDA a:$00CF,y              ; $C3FF: B9 CF 00
        SEC                        ; $C402: 38
        SBC #$08                   ; $C403: E9 08
        STA z:$CF,x                ; $C405: 95 CF
        LDA a:$07A7,x              ; $C407: BD A7 07
        AND #$03                   ; $C40A: 29 03
        TAY                        ; $C40C: A8
        LDX #$02                   ; $C40D: A2 02
LC40F:
        LDA a:$C398,y              ; $C40F: B9 98 C3
        STA z:$01,x                ; $C412: 95 01
        INY                        ; $C414: C8
        INY                        ; $C415: C8
        INY                        ; $C416: C8
        INY                        ; $C417: C8
        DEX                        ; $C418: CA
        BPL LC40F                  ; $C419: 10 F4
        LDX z:$08                  ; $C41B: A6 08
        JSR a:$CF6C                ; $C41D: 20 6C CF
        LDY z:$57                  ; $C420: A4 57
        CPY #$08                   ; $C422: C0 08
        BCS LC434                  ; $C424: B0 0E
        TAY                        ; $C426: A8
        LDA a:$07A8,x              ; $C427: BD A8 07
        AND #$03                   ; $C42A: 29 03
        BEQ LC433                  ; $C42C: F0 05
        TYA                        ; $C42E: 98
        EOR #$FF                   ; $C42F: 49 FF
        TAY                        ; $C431: A8
        INY                        ; $C432: C8
LC433:
        TYA                        ; $C433: 98
LC434:
        JSR a:$C346                ; $C434: 20 46 C3
        LDY #$02                   ; $C437: A0 02
        STA z:$58,x                ; $C439: 95 58
        CMP #$00                   ; $C43B: C9 00
        BMI LC440                  ; $C43D: 30 01
        DEY                        ; $C43F: 88
LC440:
        STY z:$46,x                ; $C440: 94 46
        LDA #$FD                   ; $C442: A9 FD
        STA z:$A0,x                ; $C444: 95 A0
        LDA #$01                   ; $C446: A9 01
        STA z:$0F,x                ; $C448: 95 0F
        LDA #$05                   ; $C44A: A9 05
        STA z:$1E,x                ; $C44C: 95 1E
LC44E:
        RTS                        ; $C44E: 60
        .byte $28,$38,$28,$38,$28,$00,$00,$10,$10,$00   ; $C44F
        JSR a:$C575                ; $C459: 20 75 C5
        LDA #$00                   ; $C45C: A9 00
        STA z:$58,x                ; $C45E: 95 58
        LDA z:$16,x                ; $C460: B5 16
        SEC                        ; $C462: 38
        SBC #$1B                   ; $C463: E9 1B
        TAY                        ; $C465: A8
        LDA a:$C44F,y              ; $C466: B9 4F C4
        STA a:$0388,x              ; $C469: 9D 88 03
        LDA a:$C454,y              ; $C46C: B9 54 C4
        STA z:$34,x                ; $C46F: 95 34
        LDA z:$CF,x                ; $C471: B5 CF
        CLC                        ; $C473: 18
        ADC #$04                   ; $C474: 69 04
        STA z:$CF,x                ; $C476: 95 CF
        LDA z:$87,x                ; $C478: B5 87
        CLC                        ; $C47A: 18
        ADC #$04                   ; $C47B: 69 04
        STA z:$87,x                ; $C47D: 95 87
        LDA z:$6E,x                ; $C47F: B5 6E
        ADC #$00                   ; $C481: 69 00
        STA z:$6E,x                ; $C483: 95 6E
        JMP a:$C7D9                ; $C485: 4C D9 C7
        .byte $80,$30,$40,$80,$30,$50,$50,$70,$20,$40,$80,$A0,$70,$40,$90,$68   ; $C488
        .byte $0E,$05,$06,$0E,$1C,$20,$10,$0C,$1E,$22,$18,$14,$10,$60,$20,$48   ; $C498
        LDA a:$078F                ; $C4A8: AD 8F 07
        BNE LC44E                  ; $C4AB: D0 A1
        JSR a:$C346                ; $C4AD: 20 46 C3
        LDA a:$07A8,x              ; $C4B0: BD A8 07
        AND #$03                   ; $C4B3: 29 03
        TAY                        ; $C4B5: A8
        LDA a:$C4A4,y              ; $C4B6: B9 A4 C4
        STA a:$078F                ; $C4B9: 8D 8F 07
        LDY #$03                   ; $C4BC: A0 03
        LDA a:$06CC                ; $C4BE: AD CC 06
        BEQ LC4C4                  ; $C4C1: F0 01
        INY                        ; $C4C3: C8
LC4C4:
        STY z:$00                  ; $C4C4: 84 00
        CPX z:$00                  ; $C4C6: E4 00
        BCS LC44E                  ; $C4C8: B0 84
        LDA a:$07A7,x              ; $C4CA: BD A7 07
        AND #$03                   ; $C4CD: 29 03
        STA z:$00                  ; $C4CF: 85 00
        STA z:$01                  ; $C4D1: 85 01
        LDA #$FB                   ; $C4D3: A9 FB
        STA z:$A0,x                ; $C4D5: 95 A0
        LDA #$00                   ; $C4D7: A9 00
        LDY z:$57                  ; $C4D9: A4 57
        BEQ LC4E4                  ; $C4DB: F0 07
        LDA #$04                   ; $C4DD: A9 04
        CPY #$19                   ; $C4DF: C0 19
        BCC LC4E4                  ; $C4E1: 90 01
        ASL a                      ; $C4E3: 0A
LC4E4:
        PHA                        ; $C4E4: 48
        CLC                        ; $C4E5: 18
        ADC z:$00                  ; $C4E6: 65 00
        STA z:$00                  ; $C4E8: 85 00
        LDA a:$07A8,x              ; $C4EA: BD A8 07
        AND #$03                   ; $C4ED: 29 03
        BEQ LC4F8                  ; $C4EF: F0 07
        LDA a:$07A9,x              ; $C4F1: BD A9 07
        AND #$0F                   ; $C4F4: 29 0F
        STA z:$00                  ; $C4F6: 85 00
LC4F8:
        PLA                        ; $C4F8: 68
        CLC                        ; $C4F9: 18
        ADC z:$01                  ; $C4FA: 65 01
        TAY                        ; $C4FC: A8
        LDA a:$C498,y              ; $C4FD: B9 98 C4
        STA z:$58,x                ; $C500: 95 58
        LDA #$01                   ; $C502: A9 01
        STA z:$46,x                ; $C504: 95 46
        LDA z:$57                  ; $C506: A5 57
        BNE LC51C                  ; $C508: D0 12
        LDY z:$00                  ; $C50A: A4 00
        TYA                        ; $C50C: 98
        AND #$02                   ; $C50D: 29 02
        BEQ LC51C                  ; $C50F: F0 0B
        LDA z:$58,x                ; $C511: B5 58
        EOR #$FF                   ; $C513: 49 FF
        CLC                        ; $C515: 18
        ADC #$01                   ; $C516: 69 01
        STA z:$58,x                ; $C518: 95 58
        INC z:$46,x                ; $C51A: F6 46
LC51C:
        TYA                        ; $C51C: 98
        AND #$02                   ; $C51D: 29 02
        BEQ LC530                  ; $C51F: F0 0F
        LDA z:$86                  ; $C521: A5 86
        CLC                        ; $C523: 18
        ADC a:$C488,y              ; $C524: 79 88 C4
        STA z:$87,x                ; $C527: 95 87
        LDA z:$6D                  ; $C529: A5 6D
        ADC #$00                   ; $C52B: 69 00
        JMP a:$C53C                ; $C52D: 4C 3C C5
LC530:
        LDA z:$86                  ; $C530: A5 86
        SEC                        ; $C532: 38
        SBC a:$C488,y              ; $C533: F9 88 C4
        STA z:$87,x                ; $C536: 95 87
        LDA z:$6D                  ; $C538: A5 6D
        SBC #$00                   ; $C53A: E9 00
        STA z:$6E,x                ; $C53C: 95 6E
        LDA #$01                   ; $C53E: A9 01
        STA z:$0F,x                ; $C540: 95 0F
        STA z:$B6,x                ; $C542: 95 B6
        LDA #$F8                   ; $C544: A9 F8
        STA z:$CF,x                ; $C546: 95 CF
        RTS                        ; $C548: 60
        .byte $20,$75,$C5,$8E,$68,$03,$A9,$00,$8D,$63,$03,$8D,$69,$03,$B5,$87   ; $C549
        .byte $8D,$66,$03,$A9,$DF,$8D,$90,$07,$95,$46,$A9,$20,$8D,$64,$03,$9D   ; $C559
        .byte $8A,$07,$A9,$05   ; $C569
        STA a:$0483                ; $C56D: 8D 83 04
        LSR a                      ; $C570: 4A
        STA a:$0365                ; $C571: 8D 65 03
        RTS                        ; $C574: 60
        LDY #$FF                   ; $C575: A0 FF
LC577:
        INY                        ; $C577: C8
        LDA a:$000F,y              ; $C578: B9 0F 00
        BNE LC577                  ; $C57B: D0 FA
        STY a:$06CF                ; $C57D: 8C CF 06
        TXA                        ; $C580: 8A
        ORA #$80                   ; $C581: 09 80
        STA a:$000F,y              ; $C583: 99 0F 00
        LDA z:$6E,x                ; $C586: B5 6E
        STA a:$006E,y              ; $C588: 99 6E 00
        LDA z:$87,x                ; $C58B: B5 87
        STA a:$0087,y              ; $C58D: 99 87 00
        LDA #$01                   ; $C590: A9 01
        STA z:$0F,x                ; $C592: 95 0F
        STA a:$00B6,y              ; $C594: 99 B6 00
        LDA z:$CF,x                ; $C597: B5 CF
        STA a:$00CF,y              ; $C599: 99 CF 00
LC59C:
        RTS                        ; $C59C: 60
        .byte $90,$80,$70,$90,$FF,$01   ; $C59D
        LDA a:$078F                ; $C5A3: AD 8F 07
        BNE LC59C                  ; $C5A6: D0 F4
        STA a:$0434,x              ; $C5A8: 9D 34 04
        LDA z:$FD                  ; $C5AB: A5 FD
        ORA #$02                   ; $C5AD: 09 02
        STA z:$FD                  ; $C5AF: 85 FD
        LDY a:$0368                ; $C5B1: AC 68 03
        LDA a:$0016,y              ; $C5B4: B9 16 00
        CMP #$2D                   ; $C5B7: C9 2D
        BEQ LC5EC                  ; $C5B9: F0 31
        JSR a:$D1D9                ; $C5BB: 20 D9 D1
        CLC                        ; $C5BE: 18
        ADC #$20                   ; $C5BF: 69 20
        LDY a:$06CC                ; $C5C1: AC CC 06
        BEQ LC5C9                  ; $C5C4: F0 03
        SEC                        ; $C5C6: 38
        SBC #$10                   ; $C5C7: E9 10
LC5C9:
        STA a:$078F                ; $C5C9: 8D 8F 07
        LDA a:$07A7,x              ; $C5CC: BD A7 07
        AND #$03                   ; $C5CF: 29 03
        STA a:$0417,x              ; $C5D1: 9D 17 04
        TAY                        ; $C5D4: A8
        LDA a:$C59D,y              ; $C5D5: B9 9D C5
        STA z:$CF,x                ; $C5D8: 95 CF
        LDA a:$071D                ; $C5DA: AD 1D 07
        CLC                        ; $C5DD: 18
        ADC #$20                   ; $C5DE: 69 20
        STA z:$87,x                ; $C5E0: 95 87
        LDA a:$071B                ; $C5E2: AD 1B 07
        ADC #$00                   ; $C5E5: 69 00
        STA z:$6E,x                ; $C5E7: 95 6E
        JMP a:$C61F                ; $C5E9: 4C 1F C6
LC5EC:
        LDA a:$0087,y              ; $C5EC: B9 87 00
        SEC                        ; $C5EF: 38
        SBC #$0E                   ; $C5F0: E9 0E
        STA z:$87,x                ; $C5F2: 95 87
        LDA a:$006E,y              ; $C5F4: B9 6E 00
        STA z:$6E,x                ; $C5F7: 95 6E
        LDA a:$00CF,y              ; $C5F9: B9 CF 00
        CLC                        ; $C5FC: 18
        ADC #$08                   ; $C5FD: 69 08
        STA z:$CF,x                ; $C5FF: 95 CF
        LDA a:$07A7,x              ; $C601: BD A7 07
        AND #$03                   ; $C604: 29 03
        STA a:$0417,x              ; $C606: 9D 17 04
        TAY                        ; $C609: A8
        LDA a:$C59D,y              ; $C60A: B9 9D C5
        LDY #$00                   ; $C60D: A0 00
        CMP z:$CF,x                ; $C60F: D5 CF
        BCC LC614                  ; $C611: 90 01
        INY                        ; $C613: C8
LC614:
        LDA a:$C5A1,y              ; $C614: B9 A1 C5
        STA a:$0434,x              ; $C617: 9D 34 04
        LDA #$00                   ; $C61A: A9 00
        STA a:$06CB                ; $C61C: 8D CB 06
        LDA #$08                   ; $C61F: A9 08
        STA a:$049A,x              ; $C621: 9D 9A 04
        LDA #$01                   ; $C624: A9 01
        STA z:$B6,x                ; $C626: 95 B6
        STA z:$0F,x                ; $C628: 95 0F
        LSR a                      ; $C62A: 4A
        STA a:$0401,x              ; $C62B: 9D 01 04
        STA z:$1E,x                ; $C62E: 95 1E
        RTS                        ; $C630: 60
        .byte $00,$30,$60,$60,$00,$20,$60,$40,$70,$40,$60,$30   ; $C631
        LDA a:$078F                ; $C63D: AD 8F 07
        BNE LC689                  ; $C640: D0 47
        LDA #$20                   ; $C642: A9 20
        STA a:$078F                ; $C644: 8D 8F 07
        DEC a:$06D7                ; $C647: CE D7 06
        LDY #$06                   ; $C64A: A0 06
LC64C:
        DEY                        ; $C64C: 88
        LDA a:$0016,y              ; $C64D: B9 16 00
        CMP #$31                   ; $C650: C9 31
        BNE LC64C                  ; $C652: D0 F8
        LDA a:$0087,y              ; $C654: B9 87 00
        SEC                        ; $C657: 38
        SBC #$30                   ; $C658: E9 30
        PHA                        ; $C65A: 48
        LDA a:$006E,y              ; $C65B: B9 6E 00
        SBC #$00                   ; $C65E: E9 00
        STA z:$00                  ; $C660: 85 00
        LDA a:$06D7                ; $C662: AD D7 06
        CLC                        ; $C665: 18
        ADC a:$001E,y              ; $C666: 79 1E 00
        TAY                        ; $C669: A8
        PLA                        ; $C66A: 68
        CLC                        ; $C66B: 18
        ADC a:$C631,y              ; $C66C: 79 31 C6
        STA z:$87,x                ; $C66F: 95 87
        LDA z:$00                  ; $C671: A5 00
        ADC #$00                   ; $C673: 69 00
        STA z:$6E,x                ; $C675: 95 6E
        LDA a:$C637,y              ; $C677: B9 37 C6
        STA z:$CF,x                ; $C67A: 95 CF
        LDA #$01                   ; $C67C: A9 01
        STA z:$B6,x                ; $C67E: 95 B6
        STA z:$0F,x                ; $C680: 95 0F
        LSR a                      ; $C682: 4A
        STA z:$58,x                ; $C683: 95 58
        LDA #$08                   ; $C685: A9 08
        STA z:$A0,x                ; $C687: 95 A0
LC689:
        RTS                        ; $C689: 60
        .byte $01,$02,$04,$08,$10,$20,$40,$80,$40,$30,$90,$50,$20,$60,$A0,$70   ; $C68A
        .byte $0A,$0B   ; $C69A
        LDA a:$078F                ; $C69C: AD 8F 07
        BNE LC710                  ; $C69F: D0 6F
        LDA a:$074E                ; $C6A1: AD 4E 07
        BNE LC6FD                  ; $C6A4: D0 57
        CPX #$03                   ; $C6A6: E0 03
        BCS LC710                  ; $C6A8: B0 66
        LDY #$00                   ; $C6AA: A0 00
        LDA a:$07A7,x              ; $C6AC: BD A7 07
        CMP #$AA                   ; $C6AF: C9 AA
        BCC LC6B4                  ; $C6B1: 90 01
        INY                        ; $C6B3: C8
LC6B4:
        LDA a:$075F                ; $C6B4: AD 5F 07
        CMP #$01                   ; $C6B7: C9 01
        BEQ LC6BC                  ; $C6B9: F0 01
        INY                        ; $C6BB: C8
LC6BC:
        TYA                        ; $C6BC: 98
        AND #$01                   ; $C6BD: 29 01
        TAY                        ; $C6BF: A8
        LDA a:$C69A,y              ; $C6C0: B9 9A C6
LC6C3:
        STA z:$16,x                ; $C6C3: 95 16
        LDA a:$06DD                ; $C6C5: AD DD 06
        CMP #$FF                   ; $C6C8: C9 FF
        BNE LC6D1                  ; $C6CA: D0 05
        LDA #$00                   ; $C6CC: A9 00
        STA a:$06DD                ; $C6CE: 8D DD 06
LC6D1:
        LDA a:$07A7,x              ; $C6D1: BD A7 07
        AND #$07                   ; $C6D4: 29 07
        TAY                        ; $C6D6: A8
        LDA a:$C68A,y              ; $C6D7: B9 8A C6
        BIT a:$06DD                ; $C6DA: 2C DD 06
        BEQ LC6E6                  ; $C6DD: F0 07
        INY                        ; $C6DF: C8
        TYA                        ; $C6E0: 98
        AND #$07                   ; $C6E1: 29 07
        JMP a:$C6D6                ; $C6E3: 4C D6 C6
LC6E6:
        ORA a:$06DD                ; $C6E6: 0D DD 06
        STA a:$06DD                ; $C6E9: 8D DD 06
        LDA a:$C692,y              ; $C6EC: B9 92 C6
        JSR a:$C5D8                ; $C6EF: 20 D8 C5
        STA a:$0417,x              ; $C6F2: 9D 17 04
        LDA #$20                   ; $C6F5: A9 20
        STA a:$078F                ; $C6F7: 8D 8F 07
        JMP a:$C26C                ; $C6FA: 4C 6C C2
LC6FD:
        LDY #$FF                   ; $C6FD: A0 FF
LC6FF:
        INY                        ; $C6FF: C8
        CPY #$05                   ; $C700: C0 05
        BCS LC711                  ; $C702: B0 0D
        LDA a:$000F,y              ; $C704: B9 0F 00
        BEQ LC6FF                  ; $C707: F0 F6
        LDA a:$0016,y              ; $C709: B9 16 00
        CMP #$08                   ; $C70C: C9 08
        BNE LC6FF                  ; $C70E: D0 EF
LC710:
        RTS                        ; $C710: 60
LC711:
        LDA z:$FE                  ; $C711: A5 FE
        ORA #$08                   ; $C713: 09 08
        STA z:$FE                  ; $C715: 85 FE
        LDA #$08                   ; $C717: A9 08
        BNE LC6C3                  ; $C719: D0 A8
        LDY #$00                   ; $C71B: A0 00
        SEC                        ; $C71D: 38
        SBC #$37                   ; $C71E: E9 37
        PHA                        ; $C720: 48
        CMP #$04                   ; $C721: C9 04
        BCS LC730                  ; $C723: B0 0B
        PHA                        ; $C725: 48
        LDY #$06                   ; $C726: A0 06
        LDA a:$076A                ; $C728: AD 6A 07
        BEQ LC72F                  ; $C72B: F0 02
        LDY #$02                   ; $C72D: A0 02
LC72F:
        PLA                        ; $C72F: 68
LC730:
        STY z:$01                  ; $C730: 84 01
        LDY #$B0                   ; $C732: A0 B0
        AND #$02                   ; $C734: 29 02
        BEQ LC73A                  ; $C736: F0 02
        LDY #$70                   ; $C738: A0 70
LC73A:
        STY z:$00                  ; $C73A: 84 00
        LDA a:$071B                ; $C73C: AD 1B 07
        STA z:$02                  ; $C73F: 85 02
        LDA a:$071D                ; $C741: AD 1D 07
        STA z:$03                  ; $C744: 85 03
        LDY #$02                   ; $C746: A0 02
        PLA                        ; $C748: 68
        LSR a                      ; $C749: 4A
        BCC LC74D                  ; $C74A: 90 01
        INY                        ; $C74C: C8
LC74D:
        STY a:$06D3                ; $C74D: 8C D3 06
LC750:
        LDX #$FF                   ; $C750: A2 FF
LC752:
        INX                        ; $C752: E8
        CPX #$05                   ; $C753: E0 05
        BCS LC784                  ; $C755: B0 2D
        LDA z:$0F,x                ; $C757: B5 0F
        BNE LC752                  ; $C759: D0 F7
        LDA z:$01                  ; $C75B: A5 01
        STA z:$16,x                ; $C75D: 95 16
        LDA z:$02                  ; $C75F: A5 02
        STA z:$6E,x                ; $C761: 95 6E
        LDA z:$03                  ; $C763: A5 03
        STA z:$87,x                ; $C765: 95 87
        CLC                        ; $C767: 18
        ADC #$18                   ; $C768: 69 18
        STA z:$03                  ; $C76A: 85 03
        LDA z:$02                  ; $C76C: A5 02
        ADC #$00                   ; $C76E: 69 00
        STA z:$02                  ; $C770: 85 02
        LDA z:$00                  ; $C772: A5 00
        STA z:$CF,x                ; $C774: 95 CF
        LDA #$01                   ; $C776: A9 01
        STA z:$B6,x                ; $C778: 95 B6
        STA z:$0F,x                ; $C77A: 95 0F
        JSR a:$C26C                ; $C77C: 20 6C C2
        DEC a:$06D3                ; $C77F: CE D3 06
        BNE LC750                  ; $C782: D0 CC
LC784:
        JMP a:$C25E                ; $C784: 4C 5E C2
        LDA #$01                   ; $C787: A9 01
        STA z:$58,x                ; $C789: 95 58
        LSR a                      ; $C78B: 4A
        STA z:$1E,x                ; $C78C: 95 1E
        STA z:$A0,x                ; $C78E: 95 A0
        LDA z:$CF,x                ; $C790: B5 CF
        STA a:$0434,x              ; $C792: 9D 34 04
        SEC                        ; $C795: 38
        SBC #$18                   ; $C796: E9 18
        STA a:$0417,x              ; $C798: 9D 17 04
        LDA #$09                   ; $C79B: A9 09
        JMP a:$C7DB                ; $C79D: 4C DB C7
        LDA z:$16,x                ; $C7A0: B5 16
        STA a:$06CB                ; $C7A2: 8D CB 06
        SEC                        ; $C7A5: 38
        SBC #$12                   ; $C7A6: E9 12
        JSR a:$8E04                ; $C7A8: 20 04 8E
        .byte $A4,$C3,$B7,$C7,$A8,$C4,$A3,$C5,$3D,$C6,$9C,$C6   ; $C7AB
        RTS                        ; $C7B7: 60
        LDY #$05                   ; $C7B8: A0 05
LC7BA:
        LDA a:$0016,y              ; $C7BA: B9 16 00
        CMP #$11                   ; $C7BD: C9 11
        BNE LC7C6                  ; $C7BF: D0 05
        LDA #$01                   ; $C7C1: A9 01
        STA a:$001E,y              ; $C7C3: 99 1E 00
LC7C6:
        DEY                        ; $C7C6: 88
        BPL LC7BA                  ; $C7C7: 10 F1
        LDA #$00                   ; $C7C9: A9 00
        STA a:$06CB                ; $C7CB: 8D CB 06
        STA z:$0F,x                ; $C7CE: 95 0F
        RTS                        ; $C7D0: 60
        LDA #$02                   ; $C7D1: A9 02
        STA z:$46,x                ; $C7D3: 95 46
        LDA #$F8                   ; $C7D5: A9 F8
        STA z:$58,x                ; $C7D7: 95 58
        LDA #$03                   ; $C7D9: A9 03
        STA a:$049A,x              ; $C7DB: 9D 9A 04
        RTS                        ; $C7DE: 60
        .byte $D6,$CF,$D6,$CF,$AC,$CC,$06,$D0,$05,$A0,$02,$20,$71,$C8,$A0,$FF   ; $C7DF
        .byte $AD,$A0,$03,$95,$1E,$10,$02,$8A,$A8,$8C,$A0,$03,$A9,$00,$95,$46   ; $C7EF
        .byte $A8,$20,$71,$C8,$A9,$FF,$9D,$A2,$03,$4C,$28,$C8,$A9,$00,$95,$58   ; $C7FF
        .byte $4C,$28,$C8,$A0,$40,$B5,$CF,$10,$07,$49,$FF,$18,$69,$01,$A0,$C0   ; $C80F
        .byte $9D,$01,$04,$98,$18,$75,$CF,$95,$58   ; $C81F
        JSR a:$C363                ; $C828: 20 63 C3
        LDA #$05                   ; $C82B: A9 05
        LDY a:$074E                ; $C82D: AC 4E 07
        CPY #$03                   ; $C830: C0 03
        BEQ LC83B                  ; $C832: F0 07
        LDY a:$06CC                ; $C834: AC CC 06
        BNE LC83B                  ; $C837: D0 02
        LDA #$06                   ; $C839: A9 06
LC83B:
        STA a:$049A,x              ; $C83B: 9D 9A 04
        RTS                        ; $C83E: 60
        .byte $20,$4B,$C8,$4C,$48,$C8,$20,$57,$C8,$4C,$2B,$C8,$A9,$10,$9D,$34   ; $C83F
        .byte $04,$A9,$FF,$95,$A0,$4C,$60,$C8,$A9,$F0,$9D,$34,$04,$A9,$00,$95   ; $C84F
        .byte $A0,$A0,$01,$20,$71,$C8,$A9,$04,$9D,$9A,$04,$60,$08,$0C,$F8,$00   ; $C85F
        .byte $00,$FF,$B5,$87,$18,$79,$6B,$C8,$95,$87,$B5,$6E,$79,$6E,$C8,$95   ; $C86F
        .byte $6E,$60,$60   ; $C87F
        LDX z:$08                  ; $C882: A6 08
        LDA #$00                   ; $C884: A9 00
        LDY z:$16,x                ; $C886: B4 16
        CPY #$15                   ; $C888: C0 15
        BCC LC88F                  ; $C88A: 90 03
        TYA                        ; $C88C: 98
        SBC #$14                   ; $C88D: E9 14
LC88F:
        JSR a:$8E04                ; $C88F: 20 04 8E
        .byte $E0,$C8,$35,$C9,$95,$D2,$D6,$C8,$D6,$C8,$D6,$C8,$D6,$C8,$47,$C9   ; $C892
        .byte $47,$C9,$47,$C9,$47,$C9,$47,$C9,$47,$C9,$47,$C9,$47,$C9,$D6,$C8   ; $C8A2
        .byte $65,$C9,$65,$C9,$65,$C9,$65,$C9,$65,$C9,$65,$C9,$65,$C9,$4D,$C9   ; $C8B2
        .byte $4D,$C9,$65,$D0,$85,$BC,$4B,$B9,$D6,$C8,$D9,$D2,$BA,$B8,$D6,$C8   ; $C8C2
        .byte $A4,$B7,$D7,$C8   ; $C8D2
        RTS                        ; $C8D6: 60
        JSR a:$F1AF                ; $C8D7: 20 AF F1
        JSR a:$F152                ; $C8DA: 20 52 F1
        JMP a:$E87D                ; $C8DD: 4C 7D E8
        LDA #$00                   ; $C8E0: A9 00
        STA a:$03C5,x              ; $C8E2: 9D C5 03
        JSR a:$F1AF                ; $C8E5: 20 AF F1
        JSR a:$F152                ; $C8E8: 20 52 F1
        JSR a:$E87D                ; $C8EB: 20 7D E8
        JSR a:$E243                ; $C8EE: 20 43 E2
        JSR a:$DFC1                ; $C8F1: 20 C1 DF
        JSR a:$DA33                ; $C8F4: 20 33 DA
        JSR a:$D853                ; $C8F7: 20 53 D8
        LDY a:$0747                ; $C8FA: AC 47 07
        BNE LC902                  ; $C8FD: D0 03
        JSR a:$C905                ; $C8FF: 20 05 C9
LC902:
        .byte $4C,$7A   ; $C902
        DEC z:$B5,x                ; $C904: D6 B5
        ASL z:$20,x                ; $C906: 16 20
        .byte $04,$8E,$77,$CA,$77,$CA,$77,$CA,$77,$CA,$77,$CA,$D8,$C9,$77,$CA   ; $C908
        .byte $89,$CB,$36,$CC,$34,$C9,$4A,$CC,$4A,$CC,$B0,$C9,$B0,$D3,$F9,$CA   ; $C918
        .byte $FF,$CA,$25,$CB,$28,$CF,$77,$CA,$34,$C9,$DF,$CE,$60   ; $C928
        JSR a:$D1EB                ; $C935: 20 EB D1
        JSR a:$F1AF                ; $C938: 20 AF F1
        JSR a:$F152                ; $C93B: 20 52 F1
        JSR a:$E243                ; $C93E: 20 43 E2
        JSR a:$D853                ; $C941: 20 53 D8
        JMP a:$D67A                ; $C944: 4C 7A D6
        JSR a:$CD3C                ; $C947: 20 3C CD
        JMP a:$D67A                ; $C94A: 4C 7A D6
        JSR a:$F1AF                ; $C94D: 20 AF F1
        JSR a:$F152                ; $C950: 20 52 F1
        JSR a:$E24C                ; $C953: 20 4C E2
        JSR a:$DB7B                ; $C956: 20 7B DB
        JSR a:$F152                ; $C959: 20 52 F1
        JSR a:$ED66                ; $C95C: 20 66 ED
        JSR a:$D655                ; $C95F: 20 55 D6
        JMP a:$D67A                ; $C962: 4C 7A D6
        JSR a:$F1AF                ; $C965: 20 AF F1
        JSR a:$F152                ; $C968: 20 52 F1
        JSR a:$E273                ; $C96B: 20 73 E2
        JSR a:$DB45                ; $C96E: 20 45 DB
        LDA a:$0747                ; $C971: AD 47 07
        BNE LC979                  ; $C974: D0 03
        JSR a:$C982                ; $C976: 20 82 C9
LC979:
        JSR a:$F152                ; $C979: 20 52 F1
        JSR a:$E5C8                ; $C97C: 20 C8 E5
        JMP a:$D67A                ; $C97F: 4C 7A D6
        LDA z:$16,x                ; $C982: B5 16
        SEC                        ; $C984: 38
        SBC #$24                   ; $C985: E9 24
        JSR a:$8E04                ; $C987: 20 04 8E
        .byte $32,$D4,$D3,$D5,$4F,$D6,$4F,$D6,$07,$D6,$31,$D6,$3D,$D6   ; $C98A
        LDA #$00                   ; $C998: A9 00
        STA z:$0F,x                ; $C99A: 95 0F
        STA z:$16,x                ; $C99C: 95 16
        STA z:$1E,x                ; $C99E: 95 1E
        STA a:$0110,x              ; $C9A0: 9D 10 01
        STA a:$0796,x              ; $C9A3: 9D 96 07
        STA a:$0125,x              ; $C9A6: 9D 25 01
        STA a:$03C5,x              ; $C9A9: 9D C5 03
        STA a:$078A,x              ; $C9AC: 9D 8A 07
        RTS                        ; $C9AF: 60
        .byte $BD,$96,$07,$D0,$16,$20,$F7,$C2,$BD,$A8,$07,$09,$80,$9D,$34,$04   ; $C9B0
        .byte $29,$0F,$09,$06,$9D,$96,$07,$A9,$F9,$95,$A0,$4C,$92,$BF,$30,$1C   ; $C9C0
        .byte $00,$E8,$00,$18,$08,$F8,$0C,$F4,$B5,$1E,$29,$20,$F0,$03,$4C,$E5   ; $C9D0
        .byte $CA,$B5,$3C,$F0,$2D,$D6,$3C,$AD,$D1,$03,$29,$0C,$D0,$6A,$BD,$A2   ; $C9E0
        .byte $03,$D0,$17,$AC,$CC,$06,$B9,$CE,$C9,$9D,$A2,$03,$20,$94,$BA,$90   ; $C9F0
        .byte $09,$B5,$1E,$09,$08,$95,$1E,$4C,$58,$CA,$DE,$A2,$03,$4C,$58,$CA   ; $CA00
        .byte $20,$37,$B5,$1E,$29,$07,$C9,$01,$F0,$3E,$A9,$00,$85,$00,$A0,$FA   ; $CA10
        .byte $B5,$CF,$30,$13,$A0,$FD,$C9,$70,$E6,$00,$90,$0B,$C6,$00,$BD,$A8   ; $CA20
        .byte $07,$29,$01,$D0,$02,$A0,$FA   ; $CA30
        STY z:$A0,x                ; $CA37: 94 A0
        LDA z:$1E,x                ; $CA39: B5 1E
        ORA #$01                   ; $CA3B: 09 01
        STA z:$1E,x                ; $CA3D: 95 1E
        LDA z:$00                  ; $CA3F: A5 00
        AND a:$07A9,x              ; $CA41: 3D A9 07
        TAY                        ; $CA44: A8
        LDA a:$06CC                ; $CA45: AD CC 06
        BNE LCA4B                  ; $CA48: D0 01
        TAY                        ; $CA4A: A8
LCA4B:
        LDA a:$CA10,y              ; $CA4B: B9 10 CA
        STA a:$078A,x              ; $CA4E: 9D 8A 07
        LDA a:$07A8,x              ; $CA51: BD A8 07
        ORA #$C0                   ; $CA54: 09 C0
        STA z:$3C,x                ; $CA56: 95 3C
        LDY #$FC                   ; $CA58: A0 FC
        LDA z:$09                  ; $CA5A: A5 09
        AND #$40                   ; $CA5C: 29 40
        BNE LCA62                  ; $CA5E: D0 02
        LDY #$04                   ; $CA60: A0 04
LCA62:
        STY z:$58,x                ; $CA62: 94 58
        LDY #$01                   ; $CA64: A0 01
        JSR a:$E143                ; $CA66: 20 43 E1
        BMI LCA75                  ; $CA69: 30 0A
        INY                        ; $CA6B: C8
        LDA a:$0796,x              ; $CA6C: BD 96 07
        BNE LCA75                  ; $CA6F: D0 04
        LDA #$F8                   ; $CA71: A9 F8
        STA z:$58,x                ; $CA73: 95 58
LCA75:
        STY z:$46,x                ; $CA75: 94 46
        LDY #$00                   ; $CA77: A0 00
        LDA z:$1E,x                ; $CA79: B5 1E
        AND #$40                   ; $CA7B: 29 40
        BNE LCA98                  ; $CA7D: D0 19
        LDA z:$1E,x                ; $CA7F: B5 1E
        ASL a                      ; $CA81: 0A
        BCS LCAB4                  ; $CA82: B0 30
        LDA z:$1E,x                ; $CA84: B5 1E
        AND #$20                   ; $CA86: 29 20
        BNE LCAE5                  ; $CA88: D0 5B
        LDA z:$1E,x                ; $CA8A: B5 1E
        AND #$07                   ; $CA8C: 29 07
        BEQ LCAB4                  ; $CA8E: F0 24
        CMP #$05                   ; $CA90: C9 05
        BEQ LCA98                  ; $CA92: F0 04
        CMP #$03                   ; $CA94: C9 03
        BCS LCAC8                  ; $CA96: B0 30
LCA98:
        JSR a:$BF63                ; $CA98: 20 63 BF
        LDY #$00                   ; $CA9B: A0 00
        LDA z:$1E,x                ; $CA9D: B5 1E
        CMP #$02                   ; $CA9F: C9 02
        BEQ LCAAF                  ; $CAA1: F0 0C
        AND #$40                   ; $CAA3: 29 40
        BEQ LCAB4                  ; $CAA5: F0 0D
        LDA z:$16,x                ; $CAA7: B5 16
        CMP #$2E                   ; $CAA9: C9 2E
        BEQ LCAB4                  ; $CAAB: F0 07
        BNE LCAB2                  ; $CAAD: D0 03
LCAAF:
        JMP a:$BF02                ; $CAAF: 4C 02 BF
LCAB2:
        LDY #$01                   ; $CAB2: A0 01
LCAB4:
        LDA z:$58,x                ; $CAB4: B5 58
        PHA                        ; $CAB6: 48
        BPL LCABB                  ; $CAB7: 10 02
        INY                        ; $CAB9: C8
        INY                        ; $CABA: C8
LCABB:
        CLC                        ; $CABB: 18
        ADC a:$C9D0,y              ; $CABC: 79 D0 C9
        STA z:$58,x                ; $CABF: 95 58
        JSR a:$BF02                ; $CAC1: 20 02 BF
        PLA                        ; $CAC4: 68
        STA z:$58,x                ; $CAC5: 95 58
        RTS                        ; $CAC7: 60
LCAC8:
        LDA a:$0796,x              ; $CAC8: BD 96 07
        BNE LCAEB                  ; $CACB: D0 1E
        STA z:$1E,x                ; $CACD: 95 1E
        LDA z:$09                  ; $CACF: A5 09
        AND #$01                   ; $CAD1: 29 01
        TAY                        ; $CAD3: A8
        INY                        ; $CAD4: C8
        STY z:$46,x                ; $CAD5: 94 46
        DEY                        ; $CAD7: 88
        LDA a:$076A                ; $CAD8: AD 6A 07
        BEQ LCADF                  ; $CADB: F0 02
        INY                        ; $CADD: C8
        INY                        ; $CADE: C8
LCADF:
        LDA a:$C9D4,y              ; $CADF: B9 D4 C9
        STA z:$58,x                ; $CAE2: 95 58
        RTS                        ; $CAE4: 60
LCAE5:
        JSR a:$BF63                ; $CAE5: 20 63 BF
        JMP a:$BF02                ; $CAE8: 4C 02 BF
LCAEB:
        CMP #$0E                   ; $CAEB: C9 0E
        BNE LCAF8                  ; $CAED: D0 09
        LDA z:$16,x                ; $CAEF: B5 16
        CMP #$06                   ; $CAF1: C9 06
        BNE LCAF8                  ; $CAF3: D0 03
        JSR a:$C998                ; $CAF5: 20 98 C9
LCAF8:
        RTS                        ; $CAF8: 60
        JSR a:$BF92                ; $CAF9: 20 92 BF
        JMP a:$BF02                ; $CAFC: 4C 02 BF
        .byte $B5,$A0,$1D,$34,$04,$D0,$13,$9D,$17,$04,$B5,$CF,$DD,$01,$04,$B0   ; $CAFF
        .byte $09,$A5,$09,$29,$07,$D0,$02,$F6,$CF,$60,$B5,$CF,$D5,$58,$90,$03   ; $CB0F
        .byte $4C,$75,$BF,$4C,$70,$BF,$20,$45,$CB,$20,$66,$CB,$A0,$01,$A5,$09   ; $CB1F
        .byte $29,$03,$D0,$11,$A5,$09,$29,$40,$D0,$02,$A0,$FF,$84,$00,$B5,$CF   ; $CB2F
        .byte $18,$65,$00,$95,$CF,$60,$A9,$13   ; $CB3F
        STA z:$01                  ; $CB47: 85 01
        LDA z:$09                  ; $CB49: A5 09
        AND #$03                   ; $CB4B: 29 03
        BNE LCB5C                  ; $CB4D: D0 0D
        LDY z:$58,x                ; $CB4F: B4 58
        LDA z:$A0,x                ; $CB51: B5 A0
        LSR a                      ; $CB53: 4A
        BCS LCB60                  ; $CB54: B0 0A
        CPY z:$01                  ; $CB56: C4 01
        BEQ LCB5D                  ; $CB58: F0 03
        INC z:$58,x                ; $CB5A: F6 58
LCB5C:
        RTS                        ; $CB5C: 60
LCB5D:
        INC z:$A0,x                ; $CB5D: F6 A0
        RTS                        ; $CB5F: 60
LCB60:
        TYA                        ; $CB60: 98
        BEQ LCB5D                  ; $CB61: F0 FA
        DEC z:$58,x                ; $CB63: D6 58
        RTS                        ; $CB65: 60
        LDA z:$58,x                ; $CB66: B5 58
        PHA                        ; $CB68: 48
        LDY #$01                   ; $CB69: A0 01
        LDA z:$A0,x                ; $CB6B: B5 A0
        AND #$02                   ; $CB6D: 29 02
        BNE LCB7C                  ; $CB6F: D0 0B
        LDA z:$58,x                ; $CB71: B5 58
        EOR #$FF                   ; $CB73: 49 FF
        CLC                        ; $CB75: 18
        ADC #$01                   ; $CB76: 69 01
        STA z:$58,x                ; $CB78: 95 58
        LDY #$02                   ; $CB7A: A0 02
LCB7C:
        STY z:$46,x                ; $CB7C: 94 46
        JSR a:$BF02                ; $CB7E: 20 02 BF
        STA z:$00                  ; $CB81: 85 00
        PLA                        ; $CB83: 68
        STA z:$58,x                ; $CB84: 95 58
        RTS                        ; $CB86: 60
        .byte $3F,$03,$B5,$1E,$29,$20   ; $CB87
        BNE LCBDC                  ; $CB8D: D0 4D
        LDY a:$06CC                ; $CB8F: AC CC 06
        LDA a:$07A8,x              ; $CB92: BD A8 07
        AND a:$CB87,y              ; $CB95: 39 87 CB
        BNE LCBAC                  ; $CB98: D0 12
        TXA                        ; $CB9A: 8A
        LSR a                      ; $CB9B: 4A
        BCC LCBA2                  ; $CB9C: 90 04
        LDY z:$45                  ; $CB9E: A4 45
        BCS LCBAA                  ; $CBA0: B0 08
LCBA2:
        LDY #$02                   ; $CBA2: A0 02
        JSR a:$E143                ; $CBA4: 20 43 E1
        BPL LCBAA                  ; $CBA7: 10 01
        DEY                        ; $CBA9: 88
LCBAA:
        STY z:$46,x                ; $CBAA: 94 46
LCBAC:
        JSR a:$CBDF                ; $CBAC: 20 DF CB
        LDA z:$CF,x                ; $CBAF: B5 CF
        SEC                        ; $CBB1: 38
        SBC a:$0434,x              ; $CBB2: FD 34 04
        CMP #$20                   ; $CBB5: C9 20
        BCC LCBBB                  ; $CBB7: 90 02
        STA z:$CF,x                ; $CBB9: 95 CF
LCBBB:
        LDY z:$46,x                ; $CBBB: B4 46
        DEY                        ; $CBBD: 88
        BNE LCBCE                  ; $CBBE: D0 0E
        LDA z:$87,x                ; $CBC0: B5 87
        CLC                        ; $CBC2: 18
        ADC z:$58,x                ; $CBC3: 75 58
        STA z:$87,x                ; $CBC5: 95 87
        LDA z:$6E,x                ; $CBC7: B5 6E
        ADC #$00                   ; $CBC9: 69 00
        STA z:$6E,x                ; $CBCB: 95 6E
        RTS                        ; $CBCD: 60
LCBCE:
        LDA z:$87,x                ; $CBCE: B5 87
        SEC                        ; $CBD0: 38
        SBC z:$58,x                ; $CBD1: F5 58
        STA z:$87,x                ; $CBD3: 95 87
        LDA z:$6E,x                ; $CBD5: B5 6E
        SBC #$00                   ; $CBD7: E9 00
        STA z:$6E,x                ; $CBD9: 95 6E
        RTS                        ; $CBDB: 60
LCBDC:
        JMP a:$BF8C                ; $CBDC: 4C 8C BF
        LDA z:$A0,x                ; $CBDF: B5 A0
        AND #$02                   ; $CBE1: 29 02
        BNE LCC1C                  ; $CBE3: D0 37
        LDA z:$09                  ; $CBE5: A5 09
        AND #$07                   ; $CBE7: 29 07
        PHA                        ; $CBE9: 48
        LDA z:$A0,x                ; $CBEA: B5 A0
        LSR a                      ; $CBEC: 4A
        BCS LCC04                  ; $CBED: B0 15
        PLA                        ; $CBEF: 68
        BNE LCC03                  ; $CBF0: D0 11
        LDA a:$0434,x              ; $CBF2: BD 34 04
        CLC                        ; $CBF5: 18
        ADC #$01                   ; $CBF6: 69 01
        STA a:$0434,x              ; $CBF8: 9D 34 04
        STA z:$58,x                ; $CBFB: 95 58
        CMP #$02                   ; $CBFD: C9 02
        BNE LCC03                  ; $CBFF: D0 02
        INC z:$A0,x                ; $CC01: F6 A0
LCC03:
        RTS                        ; $CC03: 60
LCC04:
        PLA                        ; $CC04: 68
        BNE LCC1B                  ; $CC05: D0 14
        LDA a:$0434,x              ; $CC07: BD 34 04
        SEC                        ; $CC0A: 38
        SBC #$01                   ; $CC0B: E9 01
        STA a:$0434,x              ; $CC0D: 9D 34 04
        STA z:$58,x                ; $CC10: 95 58
        BNE LCC1B                  ; $CC12: D0 07
        INC z:$A0,x                ; $CC14: F6 A0
        LDA #$02                   ; $CC16: A9 02
        STA a:$0796,x              ; $CC18: 9D 96 07
LCC1B:
        RTS                        ; $CC1B: 60
LCC1C:
        LDA a:$0796,x              ; $CC1C: BD 96 07
        .byte $F0   ; $CC1F
        PHP                        ; $CC20: 08
        LDA z:$09                  ; $CC21: A5 09
        LSR a                      ; $CC23: 4A
        BCS LCC28                  ; $CC24: B0 02
        INC z:$CF,x                ; $CC26: F6 CF
LCC28:
        RTS                        ; $CC28: 60
        .byte $B5,$CF,$69,$10,$C5,$CE,$90,$F0,$A9,$00,$95,$A0,$60,$B5,$1E,$29   ; $CC29
        .byte $20,$F0,$03,$4C,$92,$BF,$A9,$E8,$95,$58,$4C,$02,$BF,$40,$80,$04   ; $CC39
        .byte $04,$B5,$1E,$29,$20,$F0,$03,$4C,$8C,$BF,$85,$03,$B5,$16,$38,$E9   ; $CC49
        .byte $0A,$A8,$B9,$46,$CC,$85,$02,$BD,$01,$04,$38,$E5,$02,$9D,$01,$04   ; $CC59
        .byte $B5,$87,$E9,$00,$95,$87,$B5,$6E,$E9,$00,$95,$6E,$A9,$20,$85,$02   ; $CC69
        .byte $E0,$02,$90,$49,$B5,$58,$C9,$10,$90,$16,$BD,$17,$04,$18,$65,$02   ; $CC79
        .byte $9D,$17,$04,$B5,$CF,$65,$03,$95,$CF,$B5,$B6,$69,$00,$4C,$AC,$CC   ; $CC89
        .byte $BD,$17,$04,$38,$E5,$02,$9D,$17,$04,$B5,$CF,$E5,$03,$95,$CF,$B5   ; $CC99
        .byte $B6,$E9,$00   ; $CCA9
        STA z:$B6,x                ; $CCAC: 95 B6
        LDY #$00                   ; $CCAE: A0 00
        LDA z:$CF,x                ; $CCB0: B5 CF
        SEC                        ; $CCB2: 38
        SBC a:$0434,x              ; $CCB3: FD 34 04
        BPL LCCBF                  ; $CCB6: 10 07
        LDY #$10                   ; $CCB8: A0 10
        EOR #$FF                   ; $CCBA: 49 FF
        CLC                        ; $CCBC: 18
        ADC #$01                   ; $CCBD: 69 01
LCCBF:
        CMP #$0F                   ; $CCBF: C9 0F
        BCC LCCC6                  ; $CCC1: 90 03
        TYA                        ; $CCC3: 98
        STA z:$58,x                ; $CCC4: 95 58
LCCC6:
        RTS                        ; $CCC6: 60
        .byte $00,$01,$03,$04,$05,$06,$07,$07,$08,$00,$03,$06,$09,$0B,$0D,$0E   ; $CCC7
        .byte $0F,$10,$00,$04,$09,$0D,$10,$13,$16,$17,$18,$00,$06,$0C,$12,$16   ; $CCD7
        .byte $1A,$1D,$1F,$20,$00,$07,$0F,$16,$1C,$21,$25,$27,$28,$00,$09,$12   ; $CCE7
        .byte $1B,$21,$27,$2C,$2F,$30,$00,$0B,$15,$1F,$27,$2E,$33,$37,$38,$00   ; $CCF7
        .byte $0C,$18,$24,$2D,$35,$3B,$3E,$40,$00,$0E,$1B,$28,$32,$3B,$42,$46   ; $CD07
        .byte $48,$00,$0F,$1F,$2D,$38,$42,$4A,$4E,$50,$00,$11,$22,$31,$3E,$49   ; $CD17
        .byte $51,$56,$58,$01,$03,$02,$00,$00,$09,$12,$1B,$24,$2D,$36,$3F,$48   ; $CD27
        .byte $51,$5A,$63,$0C,$18   ; $CD37
        JSR a:$F1AF                ; $CD3C: 20 AF F1
        LDA a:$03D1                ; $CD3F: AD D1 03
        AND #$08                   ; $CD42: 29 08
        BNE LCDBA                  ; $CD44: D0 74
        LDA a:$0747                ; $CD46: AD 47 07
        BNE LCD55                  ; $CD49: D0 0A
        LDA a:$0388,x              ; $CD4B: BD 88 03
        JSR a:$D410                ; $CD4E: 20 10 D4
        AND #$1F                   ; $CD51: 29 1F
        STA z:$A0,x                ; $CD53: 95 A0
LCD55:
        LDA z:$A0,x                ; $CD55: B5 A0
        LDY z:$16,x                ; $CD57: B4 16
        CPY #$1F                   ; $CD59: C0 1F
        BCC LCD6A                  ; $CD5B: 90 0D
        CMP #$08                   ; $CD5D: C9 08
        BEQ LCD65                  ; $CD5F: F0 04
        CMP #$18                   ; $CD61: C9 18
        BNE LCD6A                  ; $CD63: D0 05
LCD65:
        CLC                        ; $CD65: 18
        ADC #$01                   ; $CD66: 69 01
        STA z:$A0,x                ; $CD68: 95 A0
LCD6A:
        STA z:$EF                  ; $CD6A: 85 EF
        JSR a:$F152                ; $CD6C: 20 52 F1
        JSR a:$CE8E                ; $CD6F: 20 8E CE
        LDY a:$06E5,x              ; $CD72: BC E5 06
        LDA a:$03B9                ; $CD75: AD B9 03
        STA a:$0200,y              ; $CD78: 99 00 02
        STA z:$07                  ; $CD7B: 85 07
        LDA a:$03AE                ; $CD7D: AD AE 03
        STA a:$0203,y              ; $CD80: 99 03 02
        STA z:$06                  ; $CD83: 85 06
        LDA #$01                   ; $CD85: A9 01
        STA z:$00                  ; $CD87: 85 00
        JSR a:$CE08                ; $CD89: 20 08 CE
        LDY #$05                   ; $CD8C: A0 05
        LDA z:$16,x                ; $CD8E: B5 16
        CMP #$1F                   ; $CD90: C9 1F
        BCC LCD96                  ; $CD92: 90 02
        LDY #$0B                   ; $CD94: A0 0B
LCD96:
        STY z:$ED                  ; $CD96: 84 ED
        LDA #$00                   ; $CD98: A9 00
        STA z:$00                  ; $CD9A: 85 00
LCD9C:
        LDA z:$EF                  ; $CD9C: A5 EF
        JSR a:$CE8E                ; $CD9E: 20 8E CE
        JSR a:$CDBB                ; $CDA1: 20 BB CD
        LDA z:$00                  ; $CDA4: A5 00
        CMP #$04                   ; $CDA6: C9 04
        BNE LCDB2                  ; $CDA8: D0 08
        LDY a:$06CF                ; $CDAA: AC CF 06
        LDA a:$06E5,y              ; $CDAD: B9 E5 06
        STA z:$06                  ; $CDB0: 85 06
LCDB2:
        INC z:$00                  ; $CDB2: E6 00
        LDA z:$00                  ; $CDB4: A5 00
        CMP z:$ED                  ; $CDB6: C5 ED
        BCC LCD9C                  ; $CDB8: 90 E2
LCDBA:
        RTS                        ; $CDBA: 60
        LDA z:$03                  ; $CDBB: A5 03
        STA z:$05                  ; $CDBD: 85 05
        LDY z:$06                  ; $CDBF: A4 06
        LDA z:$01                  ; $CDC1: A5 01
        LSR z:$05                  ; $CDC3: 46 05
        BCS LCDCB                  ; $CDC5: B0 04
        EOR #$FF                   ; $CDC7: 49 FF
        ADC #$01                   ; $CDC9: 69 01
LCDCB:
        CLC                        ; $CDCB: 18
        ADC a:$03AE                ; $CDCC: 6D AE 03
        STA a:$0203,y              ; $CDCF: 99 03 02
        STA z:$06                  ; $CDD2: 85 06
        CMP a:$03AE                ; $CDD4: CD AE 03
        BCS LCDE2                  ; $CDD7: B0 09
        LDA a:$03AE                ; $CDD9: AD AE 03
        SEC                        ; $CDDC: 38
        SBC z:$06                  ; $CDDD: E5 06
        JMP a:$CDE6                ; $CDDF: 4C E6 CD
LCDE2:
        SEC                        ; $CDE2: 38
        SBC a:$03AE                ; $CDE3: ED AE 03
        CMP #$59                   ; $CDE6: C9 59
        BCC LCDEE                  ; $CDE8: 90 04
        LDA #$F8                   ; $CDEA: A9 F8
        BNE LCE03                  ; $CDEC: D0 15
LCDEE:
        LDA a:$03B9                ; $CDEE: AD B9 03
        CMP #$F8                   ; $CDF1: C9 F8
        BEQ LCE03                  ; $CDF3: F0 0E
        LDA z:$02                  ; $CDF5: A5 02
        LSR z:$05                  ; $CDF7: 46 05
        BCS LCDFF                  ; $CDF9: B0 04
        EOR #$FF                   ; $CDFB: 49 FF
        ADC #$01                   ; $CDFD: 69 01
LCDFF:
        CLC                        ; $CDFF: 18
        ADC a:$03B9                ; $CE00: 6D B9 03
LCE03:
        STA a:$0200,y              ; $CE03: 99 00 02
        STA z:$07                  ; $CE06: 85 07
        JSR a:$ECED                ; $CE08: 20 ED EC
        TYA                        ; $CE0B: 98
        PHA                        ; $CE0C: 48
        LDA a:$079F                ; $CE0D: AD 9F 07
        ORA a:$0747                ; $CE10: 0D 47 07
        BNE LCE85                  ; $CE13: D0 70
        STA z:$05                  ; $CE15: 85 05
        LDY z:$B5                  ; $CE17: A4 B5
        DEY                        ; $CE19: 88
        BNE LCE85                  ; $CE1A: D0 69
        LDY z:$CE                  ; $CE1C: A4 CE
        LDA a:$0754                ; $CE1E: AD 54 07
        BNE LCE28                  ; $CE21: D0 05
        LDA a:$0714                ; $CE23: AD 14 07
        BEQ LCE31                  ; $CE26: F0 09
LCE28:
        INC z:$05                  ; $CE28: E6 05
        INC z:$05                  ; $CE2A: E6 05
        TYA                        ; $CE2C: 98
        CLC                        ; $CE2D: 18
        ADC #$18                   ; $CE2E: 69 18
        TAY                        ; $CE30: A8
LCE31:
        TYA                        ; $CE31: 98
        SEC                        ; $CE32: 38
        SBC z:$07                  ; $CE33: E5 07
        BPL LCE3C                  ; $CE35: 10 05
        EOR #$FF                   ; $CE37: 49 FF
        CLC                        ; $CE39: 18
        ADC #$01                   ; $CE3A: 69 01
LCE3C:
        CMP #$08                   ; $CE3C: C9 08
        BCS LCE5C                  ; $CE3E: B0 1C
        LDA z:$06                  ; $CE40: A5 06
        CMP #$F0                   ; $CE42: C9 F0
        BCS LCE5C                  ; $CE44: B0 16
        LDA a:$0207                ; $CE46: AD 07 02
        CLC                        ; $CE49: 18
        ADC #$04                   ; $CE4A: 69 04
        STA z:$04                  ; $CE4C: 85 04
        SEC                        ; $CE4E: 38
        SBC z:$06                  ; $CE4F: E5 06
        BPL LCE58                  ; $CE51: 10 05
        EOR #$FF                   ; $CE53: 49 FF
        CLC                        ; $CE55: 18
        ADC #$01                   ; $CE56: 69 01
LCE58:
        CMP #$08                   ; $CE58: C9 08
        BCC LCE6F                  ; $CE5A: 90 13
LCE5C:
        LDA z:$05                  ; $CE5C: A5 05
        CMP #$02                   ; $CE5E: C9 02
        BEQ LCE85                  ; $CE60: F0 23
        LDY z:$05                  ; $CE62: A4 05
        LDA z:$CE                  ; $CE64: A5 CE
        CLC                        ; $CE66: 18
        ADC a:$CD3A,y              ; $CE67: 79 3A CD
        INC z:$05                  ; $CE6A: E6 05
        JMP a:$CE32                ; $CE6C: 4C 32 CE
LCE6F:
        LDX #$01                   ; $CE6F: A2 01
        LDA z:$04                  ; $CE71: A5 04
        CMP z:$06                  ; $CE73: C5 06
        BCS LCE78                  ; $CE75: B0 01
        INX                        ; $CE77: E8
LCE78:
        STX z:$46                  ; $CE78: 86 46
        LDX #$00                   ; $CE7A: A2 00
        LDA z:$00                  ; $CE7C: A5 00
        PHA                        ; $CE7E: 48
        JSR a:$D92C                ; $CE7F: 20 2C D9
        PLA                        ; $CE82: 68
        STA z:$00                  ; $CE83: 85 00
LCE85:
        PLA                        ; $CE85: 68
        CLC                        ; $CE86: 18
        ADC #$04                   ; $CE87: 69 04
        STA z:$06                  ; $CE89: 85 06
        LDX z:$08                  ; $CE8B: A6 08
        RTS                        ; $CE8D: 60
        PHA                        ; $CE8E: 48
        AND #$0F                   ; $CE8F: 29 0F
        CMP #$09                   ; $CE91: C9 09
        BCC LCE9A                  ; $CE93: 90 05
        EOR #$0F                   ; $CE95: 49 0F
        CLC                        ; $CE97: 18
        ADC #$01                   ; $CE98: 69 01
LCE9A:
        STA z:$01                  ; $CE9A: 85 01
        LDY z:$00                  ; $CE9C: A4 00
        LDA a:$CD2E,y              ; $CE9E: B9 2E CD
        CLC                        ; $CEA1: 18
        ADC z:$01                  ; $CEA2: 65 01
        TAY                        ; $CEA4: A8
        LDA a:$CCC7,y              ; $CEA5: B9 C7 CC
        STA z:$01                  ; $CEA8: 85 01
        PLA                        ; $CEAA: 68
        PHA                        ; $CEAB: 48
        CLC                        ; $CEAC: 18
        ADC #$08                   ; $CEAD: 69 08
        AND #$0F                   ; $CEAF: 29 0F
        CMP #$09                   ; $CEB1: C9 09
        BCC LCEBA                  ; $CEB3: 90 05
        EOR #$0F                   ; $CEB5: 49 0F
        CLC                        ; $CEB7: 18
        ADC #$01                   ; $CEB8: 69 01
LCEBA:
        STA z:$02                  ; $CEBA: 85 02
        LDY z:$00                  ; $CEBC: A4 00
        LDA a:$CD2E,y              ; $CEBE: B9 2E CD
        CLC                        ; $CEC1: 18
        ADC z:$02                  ; $CEC2: 65 02
        TAY                        ; $CEC4: A8
        LDA a:$CCC7,y              ; $CEC5: B9 C7 CC
        STA z:$02                  ; $CEC8: 85 02
        PLA                        ; $CECA: 68
        LSR a                      ; $CECB: 4A
        LSR a                      ; $CECC: 4A
        LSR a                      ; $CECD: 4A
        TAY                        ; $CECE: A8
        LDA a:$CD2A,y              ; $CECF: B9 2A CD
        STA z:$03                  ; $CED2: 85 03
        RTS                        ; $CED4: 60
        .byte $F8,$A0,$70,$BD,$00,$20,$20,$20,$00,$00,$B5,$1E,$29,$20,$F0,$08   ; $CED5
        .byte $A9,$00,$9D,$C5,$03,$4C,$92,$BF,$20,$02,$BF,$A0,$0D,$A9,$05,$20   ; $CEE5
        .byte $96,$BF,$BD,$34,$04,$4A,$4A,$4A,$4A,$A8,$B5,$CF,$38,$F9,$D5,$CE   ; $CEF5
        .byte $10,$05,$49,$FF,$18,$69,$01,$C9,$08,$B0,$0E,$BD,$34,$04,$18,$69   ; $CF05
        .byte $10,$9D,$34,$04,$4A,$4A,$4A,$4A,$A8,$B9,$DA,$CE,$9D,$C5,$03,$60   ; $CF15
        .byte $15,$30,$40,$B5,$1E,$29,$20,$F0,$03,$4C,$63,$BF,$B5,$1E,$F0,$0B   ; $CF25
        .byte $A9,$00,$95,$A0,$8D,$CB,$06,$A9,$10,$D0,$13,$A9,$12,$8D,$CB,$06   ; $CF35
        .byte $A0,$02,$B9,$25,$CF,$99,$01,$00,$88,$10,$F7,$20,$6C,$CF,$95,$58   ; $CF45
        .byte $A0,$01,$B5,$A0,$29,$01,$D0,$0A,$B5,$58,$49,$FF,$18,$69,$01,$95   ; $CF55
        .byte $58,$C8,$94,$46,$4C,$02,$BF   ; $CF65
        LDY #$00                   ; $CF6C: A0 00
        JSR a:$E143                ; $CF6E: 20 43 E1
        BPL LCF7D                  ; $CF71: 10 0A
        INY                        ; $CF73: C8
        LDA z:$00                  ; $CF74: A5 00
        EOR #$FF                   ; $CF76: 49 FF
        CLC                        ; $CF78: 18
        ADC #$01                   ; $CF79: 69 01
        STA z:$00                  ; $CF7B: 85 00
LCF7D:
        LDA z:$00                  ; $CF7D: A5 00
        CMP #$3C                   ; $CF7F: C9 3C
        BCC LCF9F                  ; $CF81: 90 1C
        LDA #$3C                   ; $CF83: A9 3C
        STA z:$00                  ; $CF85: 85 00
        LDA z:$16,x                ; $CF87: B5 16
        CMP #$11                   ; $CF89: C9 11
        BNE LCF9F                  ; $CF8B: D0 12
        TYA                        ; $CF8D: 98
        CMP z:$A0,x                ; $CF8E: D5 A0
        BEQ LCF9F                  ; $CF90: F0 0D
        LDA z:$A0,x                ; $CF92: B5 A0
        BEQ LCF9C                  ; $CF94: F0 06
        DEC z:$58,x                ; $CF96: D6 58
        LDA z:$58,x                ; $CF98: B5 58
        BNE LCFDC                  ; $CF9A: D0 40
LCF9C:
        TYA                        ; $CF9C: 98
        STA z:$A0,x                ; $CF9D: 95 A0
LCF9F:
        LDA z:$00                  ; $CF9F: A5 00
        AND #$3C                   ; $CFA1: 29 3C
        LSR a                      ; $CFA3: 4A
        LSR a                      ; $CFA4: 4A
        STA z:$00                  ; $CFA5: 85 00
        LDY #$00                   ; $CFA7: A0 00
        LDA z:$57                  ; $CFA9: A5 57
        BEQ LCFD1                  ; $CFAB: F0 24
        LDA a:$0775                ; $CFAD: AD 75 07
        BEQ LCFD1                  ; $CFB0: F0 1F
        INY                        ; $CFB2: C8
        LDA z:$57                  ; $CFB3: A5 57
        CMP #$19                   ; $CFB5: C9 19
        BCC LCFC1                  ; $CFB7: 90 08
        LDA a:$0775                ; $CFB9: AD 75 07
        CMP #$02                   ; $CFBC: C9 02
        BCC LCFC1                  ; $CFBE: 90 01
        INY                        ; $CFC0: C8
LCFC1:
        LDA z:$16,x                ; $CFC1: B5 16
        CMP #$12                   ; $CFC3: C9 12
        BNE LCFCB                  ; $CFC5: D0 04
        LDA z:$57                  ; $CFC7: A5 57
        BNE LCFD1                  ; $CFC9: D0 06
LCFCB:
        LDA z:$A0,x                ; $CFCB: B5 A0
        BNE LCFD1                  ; $CFCD: D0 02
        LDY #$00                   ; $CFCF: A0 00
LCFD1:
        LDA a:$0001,y              ; $CFD1: B9 01 00
        LDY z:$00                  ; $CFD4: A4 00
LCFD6:
        SEC                        ; $CFD6: 38
        SBC #$01                   ; $CFD7: E9 01
        DEY                        ; $CFD9: 88
        BPL LCFD6                  ; $CFDA: 10 FA
LCFDC:
        RTS                        ; $CFDC: 60
        .byte $1A,$58,$98,$96,$94,$92,$90,$8E,$8C,$8A,$88,$86,$84,$82,$80   ; $CFDD
        LDX a:$0368                ; $CFEC: AE 68 03
        LDA z:$16,x                ; $CFEF: B5 16
        CMP #$2D                   ; $CFF1: C9 2D
        BNE LD005                  ; $CFF3: D0 10
        STX z:$08                  ; $CFF5: 86 08
        LDA z:$1E,x                ; $CFF7: B5 1E
        BEQ LD015                  ; $CFF9: F0 1A
        AND #$40                   ; $CFFB: 29 40
        BEQ LD005                  ; $CFFD: F0 06
        LDA z:$CF,x                ; $CFFF: B5 CF
        CMP #$E0                   ; $D001: C9 E0
        BCC LD00F                  ; $D003: 90 0A
LD005:
        LDA #$80                   ; $D005: A9 80
        STA z:$FC                  ; $D007: 85 FC
        INC a:$0772                ; $D009: EE 72 07
        .byte $4C   ; $D00C
        ADC ($D0),y                ; $D00D: 71 D0
LD00F:
        JSR a:$BF8C                ; $D00F: 20 8C BF
        JMP a:$D17B                ; $D012: 4C 7B D1
LD015:
        DEC a:$0364                ; $D015: CE 64 03
        BNE LD05E                  ; $D018: D0 44
        LDA #$04                   ; $D01A: A9 04
        STA a:$0364                ; $D01C: 8D 64 03
        LDA a:$0363                ; $D01F: AD 63 03
        EOR #$01                   ; $D022: 49 01
        STA a:$0363                ; $D024: 8D 63 03
        LDA #$22                   ; $D027: A9 22
        STA z:$05                  ; $D029: 85 05
        LDY a:$0369                ; $D02B: AC 69 03
        LDA a:$CFDD,y              ; $D02E: B9 DD CF
        STA z:$04                  ; $D031: 85 04
        .byte $AC   ; $D033
        BRK                        ; $D034: 00
        .byte $03,$C8,$A2,$0C,$20,$CD,$8A,$A6,$08,$20,$8F,$8A,$A9,$08,$85,$FE   ; $D035
        .byte $A9,$01,$85,$FD,$EE,$69,$03,$AD,$69,$03,$C9,$0F,$D0,$0B,$20,$63   ; $D045
        .byte $C3,$A9,$40,$95,$1E,$A9,$80,$85,$FE   ; $D055
LD05E:
        JMP a:$D17B                ; $D05E: 4C 7B D1
        .byte $21,$41,$11,$31   ; $D061
        LDA z:$1E,x                ; $D065: B5 1E
        AND #$20                   ; $D067: 29 20
        BEQ LD07F                  ; $D069: F0 14
        LDA z:$CF,x                ; $D06B: B5 CF
        CMP #$E0                   ; $D06D: C9 E0
        BCC LD00F                  ; $D06F: 90 9E
        LDX #$04                   ; $D071: A2 04
LD073:
        JSR a:$C998                ; $D073: 20 98 C9
        DEX                        ; $D076: CA
        BPL LD073                  ; $D077: 10 FA
        STA a:$06CB                ; $D079: 8D CB 06
        LDX z:$08                  ; $D07C: A6 08
        RTS                        ; $D07E: 60
LD07F:
        LDA #$00                   ; $D07F: A9 00
        STA a:$06CB                ; $D081: 8D CB 06
        LDA a:$0747                ; $D084: AD 47 07
        BEQ LD08C                  ; $D087: F0 03
        JMP a:$D139                ; $D089: 4C 39 D1
LD08C:
        LDA a:$0363                ; $D08C: AD 63 03
        BPL LD094                  ; $D08F: 10 03
        JMP a:$D10F                ; $D091: 4C 0F D1
LD094:
        DEC a:$0364                ; $D094: CE 64 03
        BNE LD0A6                  ; $D097: D0 0D
        LDA #$20                   ; $D099: A9 20
        STA a:$0364                ; $D09B: 8D 64 03
        LDA a:$0363                ; $D09E: AD 63 03
        EOR #$01                   ; $D0A1: 49 01
        STA a:$0363                ; $D0A3: 8D 63 03
LD0A6:
        LDA z:$09                  ; $D0A6: A5 09
        AND #$0F                   ; $D0A8: 29 0F
        BNE LD0B0                  ; $D0AA: D0 04
        LDA #$02                   ; $D0AC: A9 02
        STA z:$46,x                ; $D0AE: 95 46
LD0B0:
        LDA a:$078A,x              ; $D0B0: BD 8A 07
        BEQ LD0D1                  ; $D0B3: F0 1C
        JSR a:$E143                ; $D0B5: 20 43 E1
        BPL LD0D1                  ; $D0B8: 10 17
        LDA #$01                   ; $D0BA: A9 01
        STA z:$46,x                ; $D0BC: 95 46
        LDA #$02                   ; $D0BE: A9 02
        STA a:$0365                ; $D0C0: 8D 65 03
        LDA #$20                   ; $D0C3: A9 20
        STA a:$078A,x              ; $D0C5: 9D 8A 07
        STA a:$0790                ; $D0C8: 8D 90 07
        LDA z:$87,x                ; $D0CB: B5 87
        CMP #$C8                   ; $D0CD: C9 C8
        BCS LD10F                  ; $D0CF: B0 3E
LD0D1:
        LDA z:$09                  ; $D0D1: A5 09
        AND #$03                   ; $D0D3: 29 03
        BNE LD10F                  ; $D0D5: D0 38
        LDA z:$87,x                ; $D0D7: B5 87
        CMP a:$0366                ; $D0D9: CD 66 03
        BNE LD0EA                  ; $D0DC: D0 0C
        LDA a:$07A7,x              ; $D0DE: BD A7 07
        AND #$03                   ; $D0E1: 29 03
        TAY                        ; $D0E3: A8
        LDA a:$D061,y              ; $D0E4: B9 61 D0
        STA a:$06DC                ; $D0E7: 8D DC 06
LD0EA:
        LDA z:$87,x                ; $D0EA: B5 87
        CLC                        ; $D0EC: 18
        ADC a:$0365                ; $D0ED: 6D 65 03
        STA z:$87,x                ; $D0F0: 95 87
        LDY z:$46,x                ; $D0F2: B4 46
        CPY #$01                   ; $D0F4: C0 01
        BEQ LD10F                  ; $D0F6: F0 17
        LDY #$FF                   ; $D0F8: A0 FF
        SEC                        ; $D0FA: 38
        SBC a:$0366                ; $D0FB: ED 66 03
        BPL LD107                  ; $D0FE: 10 07
        EOR #$FF                   ; $D100: 49 FF
        CLC                        ; $D102: 18
        ADC #$01                   ; $D103: 69 01
        LDY #$01                   ; $D105: A0 01
LD107:
        CMP a:$06DC                ; $D107: CD DC 06
        BCC LD10F                  ; $D10A: 90 03
        STY a:$0365                ; $D10C: 8C 65 03
LD10F:
        LDA a:$078A,x              ; $D10F: BD 8A 07
        BNE LD13C                  ; $D112: D0 28
        JSR a:$BF8C                ; $D114: 20 8C BF
        LDA a:$075F                ; $D117: AD 5F 07
        CMP #$05                   ; $D11A: C9 05
        BCC LD127                  ; $D11C: 90 09
        LDA z:$09                  ; $D11E: A5 09
        AND #$03                   ; $D120: 29 03
        BNE LD127                  ; $D122: D0 03
        JSR a:$BA94                ; $D124: 20 94 BA
LD127:
        LDA z:$CF,x                ; $D127: B5 CF
        CMP #$80                   ; $D129: C9 80
        BCC LD149                  ; $D12B: 90 1C
        LDA a:$07A7,x              ; $D12D: BD A7 07
        AND #$03                   ; $D130: 29 03
        TAY                        ; $D132: A8
        LDA a:$D061,y              ; $D133: B9 61 D0
        STA a:$078A,x              ; $D136: 9D 8A 07
        JMP a:$D149                ; $D139: 4C 49 D1
LD13C:
        CMP #$01                   ; $D13C: C9 01
        BNE LD149                  ; $D13E: D0 09
        DEC z:$CF,x                ; $D140: D6 CF
        JSR a:$C363                ; $D142: 20 63 C3
        LDA #$FE                   ; $D145: A9 FE
        STA z:$A0,x                ; $D147: 95 A0
LD149:
        LDA a:$075F                ; $D149: AD 5F 07
        CMP #$07                   ; $D14C: C9 07
        BEQ LD154                  ; $D14E: F0 04
        CMP #$05                   ; $D150: C9 05
        BCS LD17B                  ; $D152: B0 27
LD154:
        LDA a:$0790                ; $D154: AD 90 07
        BNE LD17B                  ; $D157: D0 22
        LDA #$20                   ; $D159: A9 20
        STA a:$0790                ; $D15B: 8D 90 07
        LDA a:$0363                ; $D15E: AD 63 03
        EOR #$80                   ; $D161: 49 80
        STA a:$0363                ; $D163: 8D 63 03
        BMI LD149                  ; $D166: 30 E1
        JSR a:$D1D9                ; $D168: 20 D9 D1
        LDY a:$06CC                ; $D16B: AC CC 06
        BEQ LD173                  ; $D16E: F0 03
        SEC                        ; $D170: 38
        SBC #$10                   ; $D171: E9 10
LD173:
        STA a:$0790                ; $D173: 8D 90 07
        LDA #$15                   ; $D176: A9 15
        STA a:$06CB                ; $D178: 8D CB 06
LD17B:
        JSR a:$D1BC                ; $D17B: 20 BC D1
        LDY #$10                   ; $D17E: A0 10
        LDA z:$46,x                ; $D180: B5 46
        LSR a                      ; $D182: 4A
        BCC LD187                  ; $D183: 90 02
        LDY #$F0                   ; $D185: A0 F0
LD187:
        TYA                        ; $D187: 98
        CLC                        ; $D188: 18
        ADC z:$87,x                ; $D189: 75 87
        LDY a:$06CF                ; $D18B: AC CF 06
        STA a:$0087,y              ; $D18E: 99 87 00
        LDA z:$CF,x                ; $D191: B5 CF
        CLC                        ; $D193: 18
        ADC #$08                   ; $D194: 69 08
        STA a:$00CF,y              ; $D196: 99 CF 00
        LDA z:$1E,x                ; $D199: B5 1E
        STA a:$001E,y              ; $D19B: 99 1E 00
        LDA z:$46,x                ; $D19E: B5 46
        STA a:$0046,y              ; $D1A0: 99 46 00
        LDA z:$08                  ; $D1A3: A5 08
        PHA                        ; $D1A5: 48
        LDX a:$06CF                ; $D1A6: AE CF 06
        STX z:$08                  ; $D1A9: 86 08
        LDA #$2D                   ; $D1AB: A9 2D
        STA z:$16,x                ; $D1AD: 95 16
        JSR a:$D1BC                ; $D1AF: 20 BC D1
        PLA                        ; $D1B2: 68
        STA z:$08                  ; $D1B3: 85 08
        TAX                        ; $D1B5: AA
        LDA #$00                   ; $D1B6: A9 00
        STA a:$036A                ; $D1B8: 8D 6A 03
LD1BB:
        RTS                        ; $D1BB: 60
        INC a:$036A                ; $D1BC: EE 6A 03
        JSR a:$C8D7                ; $D1BF: 20 D7 C8
        LDA z:$1E,x                ; $D1C2: B5 1E
        BNE LD1BB                  ; $D1C4: D0 F5
        LDA #$0A                   ; $D1C6: A9 0A
        STA a:$049A,x              ; $D1C8: 9D 9A 04
        JSR a:$E243                ; $D1CB: 20 43 E2
        JMP a:$D853                ; $D1CE: 4C 53 D8
        .byte $BF,$40,$BF,$BF,$BF,$40,$40,$BF   ; $D1D1
        LDY a:$0367                ; $D1D9: AC 67 03
        INC a:$0367                ; $D1DC: EE 67 03
        LDA a:$0367                ; $D1DF: AD 67 03
        AND #$07                   ; $D1E2: 29 07
        STA a:$0367                ; $D1E4: 8D 67 03
        LDA a:$D1D1,y              ; $D1E7: B9 D1 D1
LD1EA:
        RTS                        ; $D1EA: 60
        LDA a:$0747                ; $D1EB: AD 47 07
        BNE LD220                  ; $D1EE: D0 30
        LDA #$40                   ; $D1F0: A9 40
        LDY a:$06CC                ; $D1F2: AC CC 06
        BEQ LD1F9                  ; $D1F5: F0 02
        LDA #$60                   ; $D1F7: A9 60
LD1F9:
        STA z:$00                  ; $D1F9: 85 00
        LDA a:$0401,x              ; $D1FB: BD 01 04
        SEC                        ; $D1FE: 38
        SBC z:$00                  ; $D1FF: E5 00
        STA a:$0401,x              ; $D201: 9D 01 04
        LDA z:$87,x                ; $D204: B5 87
        SBC #$01                   ; $D206: E9 01
        STA z:$87,x                ; $D208: 95 87
        LDA z:$6E,x                ; $D20A: B5 6E
        SBC #$00                   ; $D20C: E9 00
        STA z:$6E,x                ; $D20E: 95 6E
        LDY a:$0417,x              ; $D210: BC 17 04
        LDA z:$CF,x                ; $D213: B5 CF
        CMP a:$C59D,y              ; $D215: D9 9D C5
        BEQ LD220                  ; $D218: F0 06
        CLC                        ; $D21A: 18
        ADC a:$0434,x              ; $D21B: 7D 34 04
        STA z:$CF,x                ; $D21E: 95 CF
LD220:
        JSR a:$F152                ; $D220: 20 52 F1
        LDA z:$1E,x                ; $D223: B5 1E
        BNE LD1EA                  ; $D225: D0 C3
        LDA #$51                   ; $D227: A9 51
        STA z:$00                  ; $D229: 85 00
        LDY #$02                   ; $D22B: A0 02
        LDA z:$09                  ; $D22D: A5 09
        AND #$02                   ; $D22F: 29 02
        BEQ LD235                  ; $D231: F0 02
        LDY #$82                   ; $D233: A0 82
LD235:
        STY z:$01                  ; $D235: 84 01
        LDY a:$06E5,x              ; $D237: BC E5 06
        LDX #$00                   ; $D23A: A2 00
LD23C:
        LDA a:$03B9                ; $D23C: AD B9 03
        STA a:$0200,y              ; $D23F: 99 00 02
        LDA z:$00                  ; $D242: A5 00
        STA a:$0201,y              ; $D244: 99 01 02
        INC z:$00                  ; $D247: E6 00
        LDA z:$01                  ; $D249: A5 01
        STA a:$0202,y              ; $D24B: 99 02 02
        LDA a:$03AE                ; $D24E: AD AE 03
        STA a:$0203,y              ; $D251: 99 03 02
        CLC                        ; $D254: 18
        ADC #$08                   ; $D255: 69 08
        STA a:$03AE                ; $D257: 8D AE 03
        INY                        ; $D25A: C8
        INY                        ; $D25B: C8
        INY                        ; $D25C: C8
        INY                        ; $D25D: C8
        INX                        ; $D25E: E8
        CPX #$03                   ; $D25F: E0 03
        BCC LD23C                  ; $D261: 90 D9
        LDX z:$08                  ; $D263: A6 08
        JSR a:$F1AF                ; $D265: 20 AF F1
        LDY a:$06E5,x              ; $D268: BC E5 06
        LDA a:$03D1                ; $D26B: AD D1 03
        LSR a                      ; $D26E: 4A
        PHA                        ; $D26F: 48
        BCC LD277                  ; $D270: 90 05
        LDA #$F8                   ; $D272: A9 F8
        STA a:$020C,y              ; $D274: 99 0C 02
LD277:
        PLA                        ; $D277: 68
        LSR a                      ; $D278: 4A
        PHA                        ; $D279: 48
        BCC LD281                  ; $D27A: 90 05
        LDA #$F8                   ; $D27C: A9 F8
        STA a:$0208,y              ; $D27E: 99 08 02
LD281:
        PLA                        ; $D281: 68
        LSR a                      ; $D282: 4A
        PHA                        ; $D283: 48
        BCC LD28B                  ; $D284: 90 05
        LDA #$F8                   ; $D286: A9 F8
        STA a:$0204,y              ; $D288: 99 04 02
LD28B:
        PLA                        ; $D28B: 68
        LSR a                      ; $D28C: 4A
        BCC LD294                  ; $D28D: 90 05
        LDA #$F8                   ; $D28F: A9 F8
        STA a:$0200,y              ; $D291: 99 00 02
LD294:
        RTS                        ; $D294: 60
        DEC z:$A0,x                ; $D295: D6 A0
        BNE LD2A5                  ; $D297: D0 0C
        LDA #$08                   ; $D299: A9 08
        STA z:$A0,x                ; $D29B: 95 A0
        INC z:$58,x                ; $D29D: F6 58
        LDA z:$58,x                ; $D29F: B5 58
        CMP #$03                   ; $D2A1: C9 03
        BCS LD2BD                  ; $D2A3: B0 18
LD2A5:
        JSR a:$F152                ; $D2A5: 20 52 F1
        LDA a:$03B9                ; $D2A8: AD B9 03
        STA a:$03BA                ; $D2AB: 8D BA 03
        LDA a:$03AE                ; $D2AE: AD AE 03
        STA a:$03AF                ; $D2B1: 8D AF 03
        LDY a:$06E5,x              ; $D2B4: BC E5 06
        LDA z:$58,x                ; $D2B7: B5 58
        JSR a:$ED17                ; $D2B9: 20 17 ED
        RTS                        ; $D2BC: 60
LD2BD:
        LDA #$00                   ; $D2BD: A9 00
        STA z:$0F,x                ; $D2BF: 95 0F
        LDA #$08                   ; $D2C1: A9 08
        STA z:$FE                  ; $D2C3: 85 FE
        LDA #$05                   ; $D2C5: A9 05
        STA a:$0138                ; $D2C7: 8D 38 01
        JMP a:$D336                ; $D2CA: 4C 36 D3
        .byte $00,$00,$08,$08,$00,$08,$00,$08,$54,$55,$56,$57   ; $D2CD
        LDA #$00                   ; $D2D9: A9 00
        STA a:$06CB                ; $D2DB: 8D CB 06
        LDA a:$0746                ; $D2DE: AD 46 07
        CMP #$05                   ; $D2E1: C9 05
        BCS LD311                  ; $D2E3: B0 2C
        JSR a:$8E04                ; $D2E5: 20 04 8E
        .byte $11,$D3,$F2,$D2,$12,$D3,$4E,$D3,$A2,$D3   ; $D2E8
        LDY #$05                   ; $D2F2: A0 05
        LDA a:$07FA                ; $D2F4: AD FA 07
        CMP #$01                   ; $D2F7: C9 01
        BEQ LD309                  ; $D2F9: F0 0E
        LDY #$03                   ; $D2FB: A0 03
        CMP #$03                   ; $D2FD: C9 03
        BEQ LD309                  ; $D2FF: F0 08
        LDY #$00                   ; $D301: A0 00
        CMP #$06                   ; $D303: C9 06
        BEQ LD309                  ; $D305: F0 02
        LDA #$FF                   ; $D307: A9 FF
LD309:
        STA a:$06D7                ; $D309: 8D D7 06
        STY z:$1E,x                ; $D30C: 94 1E
LD30E:
        INC a:$0746                ; $D30E: EE 46 07
LD311:
        RTS                        ; $D311: 60
        LDA a:$07F8                ; $D312: AD F8 07
        ORA a:$07F9                ; $D315: 0D F9 07
        ORA a:$07FA                ; $D318: 0D FA 07
        BEQ LD30E                  ; $D31B: F0 F1
        LDA z:$09                  ; $D31D: A5 09
        AND #$04                   ; $D31F: 29 04
        BEQ LD327                  ; $D321: F0 04
        LDA #$10                   ; $D323: A9 10
        STA z:$FE                  ; $D325: 85 FE
LD327:
        LDY #$23                   ; $D327: A0 23
        LDA #$FF                   ; $D329: A9 FF
        STA a:$0139                ; $D32B: 8D 39 01
        JSR a:$8F5F                ; $D32E: 20 5F 8F
        LDA #$05                   ; $D331: A9 05
        STA a:$0139                ; $D333: 8D 39 01
        LDY #$0B                   ; $D336: A0 0B
        LDA a:$0753                ; $D338: AD 53 07
        BEQ LD33F                  ; $D33B: F0 02
        LDY #$11                   ; $D33D: A0 11
LD33F:
        JSR a:$8F5F                ; $D33F: 20 5F 8F
        LDA a:$0753                ; $D342: AD 53 07
        ASL a                      ; $D345: 0A
        ASL a                      ; $D346: 0A
        ASL a                      ; $D347: 0A
        ASL a                      ; $D348: 0A
        ORA #$04                   ; $D349: 09 04
        JMP a:$BC36                ; $D34B: 4C 36 BC
        LDA z:$CF,x                ; $D34E: B5 CF
        CMP #$72                   ; $D350: C9 72
        BCC LD359                  ; $D352: 90 05
        DEC z:$CF,x                ; $D354: D6 CF
        JMP a:$D365                ; $D356: 4C 65 D3
LD359:
        LDA a:$06D7                ; $D359: AD D7 06
        BEQ LD396                  ; $D35C: F0 38
        BMI LD396                  ; $D35E: 30 36
        LDA #$16                   ; $D360: A9 16
        STA a:$06CB                ; $D362: 8D CB 06
        JSR a:$F152                ; $D365: 20 52 F1
        LDY a:$06E5,x              ; $D368: BC E5 06
        LDX #$03                   ; $D36B: A2 03
LD36D:
        LDA a:$03B9                ; $D36D: AD B9 03
        CLC                        ; $D370: 18
        ADC a:$D2CD,x              ; $D371: 7D CD D2
        STA a:$0200,y              ; $D374: 99 00 02
        LDA a:$D2D5,x              ; $D377: BD D5 D2
        STA a:$0201,y              ; $D37A: 99 01 02
        LDA #$22                   ; $D37D: A9 22
        STA a:$0202,y              ; $D37F: 99 02 02
        LDA a:$03AE                ; $D382: AD AE 03
        CLC                        ; $D385: 18
        ADC a:$D2D1,x              ; $D386: 7D D1 D2
        STA a:$0203,y              ; $D389: 99 03 02
        INY                        ; $D38C: C8
        INY                        ; $D38D: C8
        INY                        ; $D38E: C8
        INY                        ; $D38F: C8
        DEX                        ; $D390: CA
        BPL LD36D                  ; $D391: 10 DA
        LDX z:$08                  ; $D393: A6 08
        RTS                        ; $D395: 60
LD396:
        JSR a:$D365                ; $D396: 20 65 D3
        LDA #$06                   ; $D399: A9 06
        STA a:$0796,x              ; $D39B: 9D 96 07
LD39E:
        INC a:$0746                ; $D39E: EE 46 07
        RTS                        ; $D3A1: 60
        JSR a:$D365                ; $D3A2: 20 65 D3
        LDA a:$0796,x              ; $D3A5: BD 96 07
        BNE LD3AF                  ; $D3A8: D0 05
        LDA a:$07B1                ; $D3AA: AD B1 07
        BEQ LD39E                  ; $D3AD: F0 EF
LD3AF:
        RTS                        ; $D3AF: 60
        .byte $B5,$1E,$D0,$56,$BD,$8A,$07,$D0,$51,$B5,$A0,$D0,$23,$B5,$58,$30   ; $D3B0
        .byte $14,$20,$43,$E1,$10,$09,$A5,$00,$49,$FF,$18,$69,$01,$85,$00,$A5   ; $D3C0
        .byte $00,$C9,$21,$90,$35,$B5,$58,$49,$FF,$18,$69,$01,$95,$58,$F6,$A0   ; $D3D0
        .byte $BD,$34,$04,$B4,$58,$10,$03,$BD,$17,$04,$85,$00,$A5,$09,$4A,$90   ; $D3E0
        .byte $19,$AD,$47,$07,$D0,$14,$B5,$CF,$18,$75,$58,$95,$CF,$C5,$00,$D0   ; $D3F0
        .byte $09,$A9,$00,$95,$A0,$A9,$40,$9D,$8A,$07,$A9,$20,$9D,$C5,$03,$60   ; $D400
        STA z:$07                  ; $D410: 85 07
        LDA z:$34,x                ; $D412: B5 34
        BNE LD424                  ; $D414: D0 0E
        LDY #$18                   ; $D416: A0 18
        LDA z:$58,x                ; $D418: B5 58
        CLC                        ; $D41A: 18
        ADC z:$07                  ; $D41B: 65 07
        STA z:$58,x                ; $D41D: 95 58
        LDA z:$A0,x                ; $D41F: B5 A0
        ADC #$00                   ; $D421: 69 00
        RTS                        ; $D423: 60
LD424:
        LDY #$08                   ; $D424: A0 08
        LDA z:$58,x                ; $D426: B5 58
        SEC                        ; $D428: 38
        SBC z:$07                  ; $D429: E5 07
        STA z:$58,x                ; $D42B: 95 58
        LDA z:$A0,x                ; $D42D: B5 A0
        SBC #$00                   ; $D42F: E9 00
        RTS                        ; $D431: 60
        LDA z:$B6,x                ; $D432: B5 B6
        CMP #$03                   ; $D434: C9 03
        BNE LD43B                  ; $D436: D0 03
        JMP a:$C998                ; $D438: 4C 98 C9
LD43B:
        LDA z:$1E,x                ; $D43B: B5 1E
        BPL LD440                  ; $D43D: 10 01
        RTS                        ; $D43F: 60
LD440:
        TAY                        ; $D440: A8
        LDA a:$03A2,x              ; $D441: BD A2 03
        STA z:$00                  ; $D444: 85 00
        LDA z:$46,x                ; $D446: B5 46
        BEQ LD44D                  ; $D448: F0 03
        JMP a:$D5BB                ; $D44A: 4C BB D5
LD44D:
        LDA #$2D                   ; $D44D: A9 2D
        CMP z:$CF,x                ; $D44F: D5 CF
        BCC LD462                  ; $D451: 90 0F
        CPY z:$00                  ; $D453: C4 00
        BEQ LD45F                  ; $D455: F0 08
        CLC                        ; $D457: 18
        ADC #$02                   ; $D458: 69 02
        STA z:$CF,x                ; $D45A: 95 CF
        JMP a:$D5B1                ; $D45C: 4C B1 D5
LD45F:
        JMP a:$D598                ; $D45F: 4C 98 D5
LD462:
        CMP a:$00CF,y              ; $D462: D9 CF 00
        BCC LD474                  ; $D465: 90 0D
        CPX z:$00                  ; $D467: E4 00
        BEQ LD45F                  ; $D469: F0 F4
        CLC                        ; $D46B: 18
        ADC #$02                   ; $D46C: 69 02
        STA a:$00CF,y              ; $D46E: 99 CF 00
        JMP a:$D5B1                ; $D471: 4C B1 D5
LD474:
        LDA z:$CF,x                ; $D474: B5 CF
        PHA                        ; $D476: 48
        LDA a:$03A2,x              ; $D477: BD A2 03
        BPL LD494                  ; $D47A: 10 18
        LDA a:$0434,x              ; $D47C: BD 34 04
        CLC                        ; $D47F: 18
        ADC #$05                   ; $D480: 69 05
        STA z:$00                  ; $D482: 85 00
        LDA z:$A0,x                ; $D484: B5 A0
        ADC #$00                   ; $D486: 69 00
        BMI LD4A4                  ; $D488: 30 1A
        BNE LD498                  ; $D48A: D0 0C
        LDA z:$00                  ; $D48C: A5 00
        CMP #$0B                   ; $D48E: C9 0B
        BCC LD49E                  ; $D490: 90 0C
        BCS LD498                  ; $D492: B0 04
LD494:
        CMP z:$08                  ; $D494: C5 08
        BEQ LD4A4                  ; $D496: F0 0C
LD498:
        JSR a:$BFB7                ; $D498: 20 B7 BF
        JMP a:$D4A7                ; $D49B: 4C A7 D4
LD49E:
        JSR a:$D5B1                ; $D49E: 20 B1 D5
        JMP a:$D4A7                ; $D4A1: 4C A7 D4
LD4A4:
        JSR a:$BFB4                ; $D4A4: 20 B4 BF
        LDY z:$1E,x                ; $D4A7: B4 1E
        PLA                        ; $D4A9: 68
        SEC                        ; $D4AA: 38
        SBC z:$CF,x                ; $D4AB: F5 CF
        CLC                        ; $D4AD: 18
        ADC a:$00CF,y              ; $D4AE: 79 CF 00
        STA a:$00CF,y              ; $D4B1: 99 CF 00
        LDA a:$03A2,x              ; $D4B4: BD A2 03
        BMI LD4BD                  ; $D4B7: 30 04
        TAX                        ; $D4B9: AA
        JSR a:$DC21                ; $D4BA: 20 21 DC
LD4BD:
        LDY z:$08                  ; $D4BD: A4 08
        LDA a:$00A0,y              ; $D4BF: B9 A0 00
        ORA a:$0434,y              ; $D4C2: 19 34 04
        BEQ LD53E                  ; $D4C5: F0 77
        LDX a:$0300                ; $D4C7: AE 00 03
        CPX #$20                   ; $D4CA: E0 20
        BCS LD53E                  ; $D4CC: B0 70
        LDA a:$00A0,y              ; $D4CE: B9 A0 00
        PHA                        ; $D4D1: 48
        PHA                        ; $D4D2: 48
        JSR a:$D541                ; $D4D3: 20 41 D5
        LDA z:$01                  ; $D4D6: A5 01
        STA a:$0301,x              ; $D4D8: 9D 01 03
        LDA z:$00                  ; $D4DB: A5 00
        STA a:$0302,x              ; $D4DD: 9D 02 03
        LDA #$02                   ; $D4E0: A9 02
        STA a:$0303,x              ; $D4E2: 9D 03 03
        LDA a:$00A0,y              ; $D4E5: B9 A0 00
        BMI LD4F7                  ; $D4E8: 30 0D
        LDA #$A2                   ; $D4EA: A9 A2
        STA a:$0304,x              ; $D4EC: 9D 04 03
        LDA #$A3                   ; $D4EF: A9 A3
        STA a:$0305,x              ; $D4F1: 9D 05 03
        JMP a:$D4FF                ; $D4F4: 4C FF D4
LD4F7:
        LDA #$24                   ; $D4F7: A9 24
        STA a:$0304,x              ; $D4F9: 9D 04 03
        STA a:$0305,x              ; $D4FC: 9D 05 03
        LDA a:$001E,y              ; $D4FF: B9 1E 00
        TAY                        ; $D502: A8
        PLA                        ; $D503: 68
        EOR #$FF                   ; $D504: 49 FF
        JSR a:$D541                ; $D506: 20 41 D5
        LDA z:$01                  ; $D509: A5 01
        STA a:$0306,x              ; $D50B: 9D 06 03
        LDA z:$00                  ; $D50E: A5 00
        STA a:$0307,x              ; $D510: 9D 07 03
        LDA #$02                   ; $D513: A9 02
        STA a:$0308,x              ; $D515: 9D 08 03
        PLA                        ; $D518: 68
        BPL LD528                  ; $D519: 10 0D
        LDA #$A2                   ; $D51B: A9 A2
        STA a:$0309,x              ; $D51D: 9D 09 03
        LDA #$A3                   ; $D520: A9 A3
        STA a:$030A,x              ; $D522: 9D 0A 03
        JMP a:$D530                ; $D525: 4C 30 D5
LD528:
        LDA #$24                   ; $D528: A9 24
        STA a:$0309,x              ; $D52A: 9D 09 03
        STA a:$030A,x              ; $D52D: 9D 0A 03
        LDA #$00                   ; $D530: A9 00
        STA a:$030B,x              ; $D532: 9D 0B 03
        LDA a:$0300                ; $D535: AD 00 03
        CLC                        ; $D538: 18
        ADC #$0A                   ; $D539: 69 0A
        STA a:$0300                ; $D53B: 8D 00 03
LD53E:
        LDX z:$08                  ; $D53E: A6 08
        RTS                        ; $D540: 60
        PHA                        ; $D541: 48
        LDA a:$0087,y              ; $D542: B9 87 00
        CLC                        ; $D545: 18
        ADC #$08                   ; $D546: 69 08
        LDX a:$06CC                ; $D548: AE CC 06
        BNE LD550                  ; $D54B: D0 03
        CLC                        ; $D54D: 18
        ADC #$10                   ; $D54E: 69 10
LD550:
        PHA                        ; $D550: 48
        LDA a:$006E,y              ; $D551: B9 6E 00
        ADC #$00                   ; $D554: 69 00
        STA z:$02                  ; $D556: 85 02
        PLA                        ; $D558: 68
        AND #$F0                   ; $D559: 29 F0
        LSR a                      ; $D55B: 4A
        LSR a                      ; $D55C: 4A
        LSR a                      ; $D55D: 4A
        STA z:$00                  ; $D55E: 85 00
        LDX z:$CF,y                ; $D560: B6 CF
        PLA                        ; $D562: 68
        BPL LD56A                  ; $D563: 10 05
        TXA                        ; $D565: 8A
        CLC                        ; $D566: 18
        ADC #$08                   ; $D567: 69 08
        TAX                        ; $D569: AA
LD56A:
        TXA                        ; $D56A: 8A
        LDX a:$0300                ; $D56B: AE 00 03
        ASL a                      ; $D56E: 0A
        ROL a                      ; $D56F: 2A
        PHA                        ; $D570: 48
        ROL a                      ; $D571: 2A
        AND #$03                   ; $D572: 29 03
        ORA #$20                   ; $D574: 09 20
        STA z:$01                  ; $D576: 85 01
        LDA z:$02                  ; $D578: A5 02
        AND #$01                   ; $D57A: 29 01
        ASL a                      ; $D57C: 0A
        ASL a                      ; $D57D: 0A
        ORA z:$01                  ; $D57E: 05 01
        STA z:$01                  ; $D580: 85 01
        PLA                        ; $D582: 68
        AND #$E0                   ; $D583: 29 E0
        CLC                        ; $D585: 18
        ADC z:$00                  ; $D586: 65 00
        STA z:$00                  ; $D588: 85 00
        LDA a:$00CF,y              ; $D58A: B9 CF 00
        CMP #$E8                   ; $D58D: C9 E8
        BCC LD597                  ; $D58F: 90 06
        LDA z:$00                  ; $D591: A5 00
        AND #$BF                   ; $D593: 29 BF
        STA z:$00                  ; $D595: 85 00
LD597:
        RTS                        ; $D597: 60
        TYA                        ; $D598: 98
        TAX                        ; $D599: AA
        JSR a:$F1AF                ; $D59A: 20 AF F1
        LDA #$06                   ; $D59D: A9 06
        JSR a:$DA11                ; $D59F: 20 11 DA
        LDA a:$03AD                ; $D5A2: AD AD 03
        STA a:$0117,x              ; $D5A5: 9D 17 01
        LDA z:$CE                  ; $D5A8: A5 CE
        STA a:$011E,x              ; $D5AA: 9D 1E 01
        LDA #$01                   ; $D5AD: A9 01
        STA z:$46,x                ; $D5AF: 95 46
        JSR a:$C363                ; $D5B1: 20 63 C3
        STA a:$00A0,y              ; $D5B4: 99 A0 00
        STA a:$0434,y              ; $D5B7: 99 34 04
        RTS                        ; $D5BA: 60
        TYA                        ; $D5BB: 98
        PHA                        ; $D5BC: 48
        JSR a:$BF6B                ; $D5BD: 20 6B BF
        PLA                        ; $D5C0: 68
        TAX                        ; $D5C1: AA
        JSR a:$BF6B                ; $D5C2: 20 6B BF
        LDX z:$08                  ; $D5C5: A6 08
        LDA a:$03A2,x              ; $D5C7: BD A2 03
        BMI LD5D0                  ; $D5CA: 30 04
        TAX                        ; $D5CC: AA
        JSR a:$DC21                ; $D5CD: 20 21 DC
LD5D0:
        LDX z:$08                  ; $D5D0: A6 08
        RTS                        ; $D5D2: 60
        LDA z:$A0,x                ; $D5D3: B5 A0
        ORA a:$0434,x              ; $D5D5: 1D 34 04
        BNE LD5EF                  ; $D5D8: D0 15
        STA a:$0417,x              ; $D5DA: 9D 17 04
        LDA z:$CF,x                ; $D5DD: B5 CF
        CMP a:$0401,x              ; $D5DF: DD 01 04
        BCS LD5EF                  ; $D5E2: B0 0B
        LDA z:$09                  ; $D5E4: A5 09
        AND #$07                   ; $D5E6: 29 07
        BNE LD5EC                  ; $D5E8: D0 02
        INC z:$CF,x                ; $D5EA: F6 CF
LD5EC:
        JMP a:$D5FE                ; $D5EC: 4C FE D5
LD5EF:
        LDA z:$CF,x                ; $D5EF: B5 CF
        CMP z:$58,x                ; $D5F1: D5 58
        BCC LD5FB                  ; $D5F3: 90 06
        JSR a:$BFB7                ; $D5F5: 20 B7 BF
        JMP a:$D5FE                ; $D5F8: 4C FE D5
LD5FB:
        JSR a:$BFB4                ; $D5FB: 20 B4 BF
        LDA a:$03A2,x              ; $D5FE: BD A2 03
        BMI LD606                  ; $D601: 30 03
        JSR a:$DC21                ; $D603: 20 21 DC
LD606:
        RTS                        ; $D606: 60
        LDA #$0E                   ; $D607: A9 0E
        JSR a:$CB47                ; $D609: 20 47 CB
        JSR a:$CB66                ; $D60C: 20 66 CB
        LDA a:$03A2,x              ; $D60F: BD A2 03
        BMI LD630                  ; $D612: 30 1C
        LDA z:$86                  ; $D614: A5 86
        CLC                        ; $D616: 18
        ADC z:$00                  ; $D617: 65 00
        STA z:$86                  ; $D619: 85 86
        LDA z:$6D                  ; $D61B: A5 6D
        LDY z:$00                  ; $D61D: A4 00
        BMI LD626                  ; $D61F: 30 05
        ADC #$00                   ; $D621: 69 00
        JMP a:$D628                ; $D623: 4C 28 D6
LD626:
        SBC #$00                   ; $D626: E9 00
        STA z:$6D                  ; $D628: 85 6D
        STY a:$03A1                ; $D62A: 8C A1 03
        JSR a:$DC21                ; $D62D: 20 21 DC
LD630:
        RTS                        ; $D630: 60
        LDA a:$03A2,x              ; $D631: BD A2 03
        BMI LD63C                  ; $D634: 30 06
        JSR a:$BF88                ; $D636: 20 88 BF
        JSR a:$DC21                ; $D639: 20 21 DC
LD63C:
        RTS                        ; $D63C: 60
        JSR a:$BF02                ; $D63D: 20 02 BF
        STA z:$00                  ; $D640: 85 00
        LDA a:$03A2,x              ; $D642: BD A2 03
        BMI LD64E                  ; $D645: 30 07
        LDA #$10                   ; $D647: A9 10
        STA z:$58,x                ; $D649: 95 58
        JSR a:$D614                ; $D64B: 20 14 D6
LD64E:
        RTS                        ; $D64E: 60
        JSR a:$D65B                ; $D64F: 20 5B D6
        JMP a:$D5FE                ; $D652: 4C FE D5
        JSR a:$D65B                ; $D655: 20 5B D6
        JMP a:$D671                ; $D658: 4C 71 D6
        LDA a:$0747                ; $D65B: AD 47 07
        BNE LD679                  ; $D65E: D0 19
        LDA a:$0417,x              ; $D660: BD 17 04
        CLC                        ; $D663: 18
        ADC a:$0434,x              ; $D664: 7D 34 04
        STA a:$0417,x              ; $D667: 9D 17 04
        LDA z:$CF,x                ; $D66A: B5 CF
        ADC z:$A0,x                ; $D66C: 75 A0
        STA z:$CF,x                ; $D66E: 95 CF
        RTS                        ; $D670: 60
        LDA a:$03A2,x              ; $D671: BD A2 03
        BEQ LD679                  ; $D674: F0 03
        JSR a:$DC19                ; $D676: 20 19 DC
LD679:
        RTS                        ; $D679: 60
        LDA z:$16,x                ; $D67A: B5 16
        CMP #$14                   ; $D67C: C9 14
        BEQ LD6D5                  ; $D67E: F0 55
        LDA a:$071C                ; $D680: AD 1C 07
        LDY z:$16,x                ; $D683: B4 16
        CPY #$05                   ; $D685: C0 05
        BEQ LD68D                  ; $D687: F0 04
        CPY #$0D                   ; $D689: C0 0D
        BNE LD68F                  ; $D68B: D0 02
LD68D:
        ADC #$38                   ; $D68D: 69 38
LD68F:
        SBC #$48                   ; $D68F: E9 48
        STA z:$01                  ; $D691: 85 01
        LDA a:$071A                ; $D693: AD 1A 07
        SBC #$00                   ; $D696: E9 00
        STA z:$00                  ; $D698: 85 00
        LDA a:$071D                ; $D69A: AD 1D 07
        ADC #$48                   ; $D69D: 69 48
        STA z:$03                  ; $D69F: 85 03
        LDA a:$071B                ; $D6A1: AD 1B 07
        ADC #$00                   ; $D6A4: 69 00
        STA z:$02                  ; $D6A6: 85 02
        LDA z:$87,x                ; $D6A8: B5 87
        CMP z:$01                  ; $D6AA: C5 01
        LDA z:$6E,x                ; $D6AC: B5 6E
        SBC z:$00                  ; $D6AE: E5 00
        BMI LD6D2                  ; $D6B0: 30 20
        LDA z:$87,x                ; $D6B2: B5 87
        CMP z:$03                  ; $D6B4: C5 03
        LDA z:$6E,x                ; $D6B6: B5 6E
        SBC z:$02                  ; $D6B8: E5 02
        BMI LD6D5                  ; $D6BA: 30 19
        LDA z:$1E,x                ; $D6BC: B5 1E
        CMP #$05                   ; $D6BE: C9 05
        BEQ LD6D5                  ; $D6C0: F0 13
        CPY #$0D                   ; $D6C2: C0 0D
        BEQ LD6D5                  ; $D6C4: F0 0F
        CPY #$30                   ; $D6C6: C0 30
        BEQ LD6D5                  ; $D6C8: F0 0B
        CPY #$31                   ; $D6CA: C0 31
        BEQ LD6D5                  ; $D6CC: F0 07
        CPY #$32                   ; $D6CE: C0 32
        BEQ LD6D5                  ; $D6D0: F0 03
LD6D2:
        JSR a:$C998                ; $D6D2: 20 98 C9
LD6D5:
        RTS                        ; $D6D5: 60
        .byte $FF,$FF,$FF   ; $D6D6
        LDA z:$24,x                ; $D6D9: B5 24
        BEQ LD733                  ; $D6DB: F0 56
        ASL a                      ; $D6DD: 0A
        BCS LD733                  ; $D6DE: B0 53
        LDA z:$09                  ; $D6E0: A5 09
        LSR a                      ; $D6E2: 4A
        BCS LD733                  ; $D6E3: B0 4E
        TXA                        ; $D6E5: 8A
        ASL a                      ; $D6E6: 0A
        ASL a                      ; $D6E7: 0A
        CLC                        ; $D6E8: 18
        ADC #$1C                   ; $D6E9: 69 1C
        TAY                        ; $D6EB: A8
        LDX #$04                   ; $D6EC: A2 04
LD6EE:
        STX z:$01                  ; $D6EE: 86 01
        TYA                        ; $D6F0: 98
        PHA                        ; $D6F1: 48
        LDA z:$1E,x                ; $D6F2: B5 1E
        AND #$20                   ; $D6F4: 29 20
        BNE LD72C                  ; $D6F6: D0 34
        LDA z:$0F,x                ; $D6F8: B5 0F
        BEQ LD72C                  ; $D6FA: F0 30
        LDA z:$16,x                ; $D6FC: B5 16
        CMP #$24                   ; $D6FE: C9 24
        BCC LD706                  ; $D700: 90 04
        CMP #$2B                   ; $D702: C9 2B
        BCC LD72C                  ; $D704: 90 26
LD706:
        CMP #$06                   ; $D706: C9 06
        BNE LD710                  ; $D708: D0 06
        LDA z:$1E,x                ; $D70A: B5 1E
        CMP #$02                   ; $D70C: C9 02
        BCS LD72C                  ; $D70E: B0 1C
LD710:
        LDA a:$03D8,x              ; $D710: BD D8 03
        BNE LD72C                  ; $D713: D0 17
        TXA                        ; $D715: 8A
        ASL a                      ; $D716: 0A
        ASL a                      ; $D717: 0A
        CLC                        ; $D718: 18
        ADC #$04                   ; $D719: 69 04
        TAX                        ; $D71B: AA
        JSR a:$E327                ; $D71C: 20 27 E3
        LDX z:$08                  ; $D71F: A6 08
        BCC LD72C                  ; $D721: 90 09
        LDA #$80                   ; $D723: A9 80
        STA z:$24,x                ; $D725: 95 24
        LDX z:$01                  ; $D727: A6 01
        JSR a:$D73E                ; $D729: 20 3E D7
LD72C:
        PLA                        ; $D72C: 68
        TAY                        ; $D72D: A8
        LDX z:$01                  ; $D72E: A6 01
        DEX                        ; $D730: CA
        BPL LD6EE                  ; $D731: 10 BB
LD733:
        LDX z:$08                  ; $D733: A6 08
        RTS                        ; $D735: 60
        .byte $06,$00,$02,$12,$11,$07,$05,$2D   ; $D736
        JSR a:$F152                ; $D73E: 20 52 F1
        LDX z:$01                  ; $D741: A6 01
        LDA z:$0F,x                ; $D743: B5 0F
        BPL LD752                  ; $D745: 10 0B
        AND #$0F                   ; $D747: 29 0F
        TAX                        ; $D749: AA
        LDA z:$16,x                ; $D74A: B5 16
        CMP #$2D                   ; $D74C: C9 2D
        BEQ LD75C                  ; $D74E: F0 0C
        LDX z:$01                  ; $D750: A6 01
LD752:
        LDA z:$16,x                ; $D752: B5 16
        CMP #$02                   ; $D754: C9 02
        BEQ LD7C3                  ; $D756: F0 6B
        CMP #$2D                   ; $D758: C9 2D
        BNE LD789                  ; $D75A: D0 2D
LD75C:
        DEC a:$0483                ; $D75C: CE 83 04
        BNE LD7C3                  ; $D75F: D0 62
        JSR a:$C363                ; $D761: 20 63 C3
        STA z:$58,x                ; $D764: 95 58
        STA a:$06CB                ; $D766: 8D CB 06
        LDA #$FE                   ; $D769: A9 FE
        STA z:$A0,x                ; $D76B: 95 A0
        LDY a:$075F                ; $D76D: AC 5F 07
        LDA a:$D736,y              ; $D770: B9 36 D7
        STA z:$16,x                ; $D773: 95 16
        LDA #$20                   ; $D775: A9 20
        CPY #$03                   ; $D777: C0 03
        BCS LD77D                  ; $D779: B0 02
        ORA #$03                   ; $D77B: 09 03
LD77D:
        STA z:$1E,x                ; $D77D: 95 1E
        LDA #$80                   ; $D77F: A9 80
        STA z:$FE                  ; $D781: 85 FE
        LDX z:$01                  ; $D783: A6 01
        LDA #$09                   ; $D785: A9 09
        BNE LD7BC                  ; $D787: D0 33
LD789:
        CMP #$08                   ; $D789: C9 08
        BEQ LD7C3                  ; $D78B: F0 36
        CMP #$0C                   ; $D78D: C9 0C
        BEQ LD7C3                  ; $D78F: F0 32
        CMP #$15                   ; $D791: C9 15
        BCS LD7C3                  ; $D793: B0 2E
        LDA z:$16,x                ; $D795: B5 16
        CMP #$0D                   ; $D797: C9 0D
        BNE LD7A1                  ; $D799: D0 06
        LDA z:$CF,x                ; $D79B: B5 CF
        ADC #$18                   ; $D79D: 69 18
        STA z:$CF,x                ; $D79F: 95 CF
LD7A1:
        JSR a:$E01B                ; $D7A1: 20 1B E0
        LDA z:$1E,x                ; $D7A4: B5 1E
        AND #$1F                   ; $D7A6: 29 1F
        ORA #$20                   ; $D7A8: 09 20
        STA z:$1E,x                ; $D7AA: 95 1E
        LDA #$02                   ; $D7AC: A9 02
        LDY z:$16,x                ; $D7AE: B4 16
        CPY #$05                   ; $D7B0: C0 05
        BNE LD7B6                  ; $D7B2: D0 02
        LDA #$06                   ; $D7B4: A9 06
LD7B6:
        CPY #$06                   ; $D7B6: C0 06
        BNE LD7BC                  ; $D7B8: D0 02
        LDA #$01                   ; $D7BA: A9 01
LD7BC:
        JSR a:$DA11                ; $D7BC: 20 11 DA
        LDA #$08                   ; $D7BF: A9 08
        STA z:$FF                  ; $D7C1: 85 FF
LD7C3:
        RTS                        ; $D7C3: 60
        LDA z:$09                  ; $D7C4: A5 09
        LSR a                      ; $D7C6: 4A
        BCC LD7FF                  ; $D7C7: 90 36
        LDA a:$0747                ; $D7C9: AD 47 07
        ORA a:$03D6                ; $D7CC: 0D D6 03
        BNE LD7FF                  ; $D7CF: D0 2E
        TXA                        ; $D7D1: 8A
        ASL a                      ; $D7D2: 0A
        ASL a                      ; $D7D3: 0A
        CLC                        ; $D7D4: 18
        ADC #$24                   ; $D7D5: 69 24
        TAY                        ; $D7D7: A8
        JSR a:$E325                ; $D7D8: 20 25 E3
        LDX z:$08                  ; $D7DB: A6 08
        BCC LD7FA                  ; $D7DD: 90 1B
        LDA a:$06BE,x              ; $D7DF: BD BE 06
        BNE LD7FF                  ; $D7E2: D0 1B
        LDA #$01                   ; $D7E4: A9 01
        STA a:$06BE,x              ; $D7E6: 9D BE 06
        LDA z:$64,x                ; $D7E9: B5 64
        EOR #$FF                   ; $D7EB: 49 FF
        CLC                        ; $D7ED: 18
        ADC #$01                   ; $D7EE: 69 01
        STA z:$64,x                ; $D7F0: 95 64
        LDA a:$079F                ; $D7F2: AD 9F 07
        BNE LD7FF                  ; $D7F5: D0 08
        JMP a:$D92C                ; $D7F7: 4C 2C D9
LD7FA:
        LDA #$00                   ; $D7FA: A9 00
        STA a:$06BE,x              ; $D7FC: 9D BE 06
LD7FF:
        RTS                        ; $D7FF: 60
        JSR a:$C998                ; $D800: 20 98 C9
        LDA #$06                   ; $D803: A9 06
        JSR a:$DA11                ; $D805: 20 11 DA
        LDA #$20                   ; $D808: A9 20
        STA z:$FE                  ; $D80A: 85 FE
        LDA z:$39                  ; $D80C: A5 39
        CMP #$02                   ; $D80E: C9 02
        BCC LD820                  ; $D810: 90 0E
        CMP #$03                   ; $D812: C9 03
        BEQ LD83A                  ; $D814: F0 24
        LDA #$23                   ; $D816: A9 23
        STA a:$079F                ; $D818: 8D 9F 07
        LDA #$40                   ; $D81B: A9 40
        STA z:$FB                  ; $D81D: 85 FB
        RTS                        ; $D81F: 60
LD820:
        LDA a:$0756                ; $D820: AD 56 07
        BEQ LD840                  ; $D823: F0 1B
        CMP #$01                   ; $D825: C9 01
        BNE LD84C                  ; $D827: D0 23
        LDX z:$08                  ; $D829: A6 08
        LDA #$02                   ; $D82B: A9 02
        STA a:$0756                ; $D82D: 8D 56 07
        JSR a:$85F1                ; $D830: 20 F1 85
        LDX z:$08                  ; $D833: A6 08
        LDA #$0C                   ; $D835: A9 0C
        JMP a:$D847                ; $D837: 4C 47 D8
LD83A:
        LDA #$0B                   ; $D83A: A9 0B
        STA a:$0110,x              ; $D83C: 9D 10 01
        RTS                        ; $D83F: 60
LD840:
        LDA #$01                   ; $D840: A9 01
        STA a:$0756                ; $D842: 8D 56 07
        LDA #$09                   ; $D845: A9 09
        LDY #$00                   ; $D847: A0 00
        JSR a:$D948                ; $D849: 20 48 D9
LD84C:
        RTS                        ; $D84C: 60
        .byte $18,$E8,$30,$D0,$08,$F8   ; $D84D
        LDA z:$09                  ; $D853: A5 09
        LSR a                      ; $D855: 4A
        BCS LD84C                  ; $D856: B0 F4
        JSR a:$DC41                ; $D858: 20 41 DC
        BCS LD880                  ; $D85B: B0 23
        LDA a:$03D8,x              ; $D85D: BD D8 03
        BNE LD880                  ; $D860: D0 1E
        LDA z:$0E                  ; $D862: A5 0E
        CMP #$08                   ; $D864: C9 08
        BNE LD880                  ; $D866: D0 18
        LDA z:$1E,x                ; $D868: B5 1E
        AND #$20                   ; $D86A: 29 20
        BNE LD880                  ; $D86C: D0 12
        JSR a:$DC52                ; $D86E: 20 52 DC
        JSR a:$E325                ; $D871: 20 25 E3
        LDX z:$08                  ; $D874: A6 08
        BCS LD881                  ; $D876: B0 09
        LDA a:$0491,x              ; $D878: BD 91 04
        AND #$FE                   ; $D87B: 29 FE
        STA a:$0491,x              ; $D87D: 9D 91 04
LD880:
        RTS                        ; $D880: 60
LD881:
        LDY z:$16,x                ; $D881: B4 16
        CPY #$2E                   ; $D883: C0 2E
        BNE LD88A                  ; $D885: D0 03
        JMP a:$D800                ; $D887: 4C 00 D8
LD88A:
        LDA a:$079F                ; $D88A: AD 9F 07
        BEQ LD895                  ; $D88D: F0 06
        JMP a:$D795                ; $D88F: 4C 95 D7
        .byte $0A,$06,$04   ; $D892
LD895:
        LDA a:$0491,x              ; $D895: BD 91 04
        AND #$01                   ; $D898: 29 01
        ORA a:$03D8,x              ; $D89A: 1D D8 03
        BNE LD8F8                  ; $D89D: D0 59
        LDA #$01                   ; $D89F: A9 01
        ORA a:$0491,x              ; $D8A1: 1D 91 04
        STA a:$0491,x              ; $D8A4: 9D 91 04
        CPY #$12                   ; $D8A7: C0 12
        BEQ LD8F9                  ; $D8A9: F0 4E
        CPY #$0D                   ; $D8AB: C0 0D
        BEQ LD92C                  ; $D8AD: F0 7D
        CPY #$0C                   ; $D8AF: C0 0C
        BEQ LD92C                  ; $D8B1: F0 79
        CPY #$33                   ; $D8B3: C0 33
        BEQ LD8F9                  ; $D8B5: F0 42
        CPY #$15                   ; $D8B7: C0 15
        BCS LD92C                  ; $D8B9: B0 71
        LDA a:$074E                ; $D8BB: AD 4E 07
        BEQ LD92C                  ; $D8BE: F0 6C
        LDA z:$1E,x                ; $D8C0: B5 1E
        ASL a                      ; $D8C2: 0A
        BCS LD8F9                  ; $D8C3: B0 34
        LDA z:$1E,x                ; $D8C5: B5 1E
        AND #$07                   ; $D8C7: 29 07
        CMP #$02                   ; $D8C9: C9 02
        BCC LD8F9                  ; $D8CB: 90 2C
        LDA z:$16,x                ; $D8CD: B5 16
        CMP #$06                   ; $D8CF: C9 06
        BEQ LD8F8                  ; $D8D1: F0 25
        LDA #$08                   ; $D8D3: A9 08
        STA z:$FF                  ; $D8D5: 85 FF
        LDA z:$1E,x                ; $D8D7: B5 1E
        ORA #$80                   ; $D8D9: 09 80
        STA z:$1E,x                ; $D8DB: 95 1E
        JSR a:$DA05                ; $D8DD: 20 05 DA
        LDA a:$D84F,y              ; $D8E0: B9 4F D8
        STA z:$58,x                ; $D8E3: 95 58
        LDA #$03                   ; $D8E5: A9 03
        CLC                        ; $D8E7: 18
        ADC a:$0484                ; $D8E8: 6D 84 04
        LDY a:$0796,x              ; $D8EB: BC 96 07
        CPY #$03                   ; $D8EE: C0 03
        BCS LD8F5                  ; $D8F0: B0 03
        LDA a:$D892,y              ; $D8F2: B9 92 D8
LD8F5:
        JSR a:$DA11                ; $D8F5: 20 11 DA
LD8F8:
        RTS                        ; $D8F8: 60
LD8F9:
        LDA z:$9F                  ; $D8F9: A5 9F
        BMI LD8FF                  ; $D8FB: 30 02
        BNE LD969                  ; $D8FD: D0 6A
LD8FF:
        LDA z:$16,x                ; $D8FF: B5 16
        CMP #$07                   ; $D901: C9 07
        BCC LD90E                  ; $D903: 90 09
        LDA z:$CE                  ; $D905: A5 CE
        CLC                        ; $D907: 18
        ADC #$0C                   ; $D908: 69 0C
        CMP z:$CF,x                ; $D90A: D5 CF
        BCC LD969                  ; $D90C: 90 5B
LD90E:
        LDA a:$0791                ; $D90E: AD 91 07
        BNE LD969                  ; $D911: D0 56
        LDA a:$079E                ; $D913: AD 9E 07
        BNE LD955                  ; $D916: D0 3D
        LDA a:$03AD                ; $D918: AD AD 03
        CMP a:$03AE                ; $D91B: CD AE 03
        BCC LD923                  ; $D91E: 90 03
        JMP a:$D9F6                ; $D920: 4C F6 D9
LD923:
        LDA z:$46,x                ; $D923: B5 46
        CMP #$01                   ; $D925: C9 01
        BNE LD92C                  ; $D927: D0 03
        JMP a:$D9FF                ; $D929: 4C FF D9
LD92C:
        LDA a:$079E                ; $D92C: AD 9E 07
        BNE LD955                  ; $D92F: D0 24
        LDX a:$0756                ; $D931: AE 56 07
        BEQ LD958                  ; $D934: F0 22
        STA a:$0756                ; $D936: 8D 56 07
        LDA #$08                   ; $D939: A9 08
        STA a:$079E                ; $D93B: 8D 9E 07
        ASL a                      ; $D93E: 0A
        STA z:$FF                  ; $D93F: 85 FF
        JSR a:$85F1                ; $D941: 20 F1 85
        LDA #$0A                   ; $D944: A9 0A
LD946:
        LDY #$01                   ; $D946: A0 01
        STA z:$0E                  ; $D948: 85 0E
        STY z:$1D                  ; $D94A: 84 1D
        LDY #$FF                   ; $D94C: A0 FF
        STY a:$0747                ; $D94E: 8C 47 07
        INY                        ; $D951: C8
        STY a:$0775                ; $D952: 8C 75 07
LD955:
        LDX z:$08                  ; $D955: A6 08
        RTS                        ; $D957: 60
LD958:
        STX z:$57                  ; $D958: 86 57
        INX                        ; $D95A: E8
        STX z:$FC                  ; $D95B: 86 FC
        LDA #$FC                   ; $D95D: A9 FC
        STA z:$9F                  ; $D95F: 85 9F
        LDA #$0B                   ; $D961: A9 0B
        BNE LD946                  ; $D963: D0 E1
        .byte $02,$06,$05,$06   ; $D965
LD969:
        LDA z:$16,x                ; $D969: B5 16
        CMP #$12                   ; $D96B: C9 12
        BEQ LD92C                  ; $D96D: F0 BD
        LDA #$04                   ; $D96F: A9 04
        STA z:$FF                  ; $D971: 85 FF
        LDA z:$16,x                ; $D973: B5 16
        LDY #$00                   ; $D975: A0 00
        CMP #$14                   ; $D977: C9 14
        BEQ LD996                  ; $D979: F0 1B
        CMP #$08                   ; $D97B: C9 08
        BEQ LD996                  ; $D97D: F0 17
        CMP #$33                   ; $D97F: C9 33
        BEQ LD996                  ; $D981: F0 13
        CMP #$0C                   ; $D983: C9 0C
        BEQ LD996                  ; $D985: F0 0F
        INY                        ; $D987: C8
        CMP #$05                   ; $D988: C9 05
        BEQ LD996                  ; $D98A: F0 0A
        INY                        ; $D98C: C8
        CMP #$11                   ; $D98D: C9 11
        BEQ LD996                  ; $D98F: F0 05
        INY                        ; $D991: C8
        CMP #$07                   ; $D992: C9 07
        BNE LD9B3                  ; $D994: D0 1D
LD996:
        LDA a:$D965,y              ; $D996: B9 65 D9
        JSR a:$DA11                ; $D999: 20 11 DA
        LDA z:$46,x                ; $D99C: B5 46
        PHA                        ; $D99E: 48
        JSR a:$E02F                ; $D99F: 20 2F E0
        PLA                        ; $D9A2: 68
        STA z:$46,x                ; $D9A3: 95 46
        LDA #$20                   ; $D9A5: A9 20
        STA z:$1E,x                ; $D9A7: 95 1E
        JSR a:$C363                ; $D9A9: 20 63 C3
        STA z:$58,x                ; $D9AC: 95 58
        LDA #$FD                   ; $D9AE: A9 FD
        STA z:$9F                  ; $D9B0: 85 9F
        RTS                        ; $D9B2: 60
LD9B3:
        CMP #$09                   ; $D9B3: C9 09
        BCC LD9D4                  ; $D9B5: 90 1D
        AND #$01                   ; $D9B7: 29 01
        STA z:$16,x                ; $D9B9: 95 16
        LDY #$00                   ; $D9BB: A0 00
        STY z:$1E,x                ; $D9BD: 94 1E
        LDA #$03                   ; $D9BF: A9 03
        JSR a:$DA11                ; $D9C1: 20 11 DA
        JSR a:$C363                ; $D9C4: 20 63 C3
        JSR a:$DA05                ; $D9C7: 20 05 DA
        LDA a:$D851,y              ; $D9CA: B9 51 D8
        STA z:$58,x                ; $D9CD: 95 58
        JMP a:$D9F1                ; $D9CF: 4C F1 D9
        .byte $10,$0B   ; $D9D2
LD9D4:
        LDA #$04                   ; $D9D4: A9 04
        STA z:$1E,x                ; $D9D6: 95 1E
        INC a:$0484                ; $D9D8: EE 84 04
        LDA a:$0484                ; $D9DB: AD 84 04
        CLC                        ; $D9DE: 18
        ADC a:$0791                ; $D9DF: 6D 91 07
        JSR a:$DA11                ; $D9E2: 20 11 DA
        INC a:$0791                ; $D9E5: EE 91 07
        LDY a:$076A                ; $D9E8: AC 6A 07
        LDA a:$D9D2,y              ; $D9EB: B9 D2 D9
        STA a:$0796,x              ; $D9EE: 9D 96 07
        LDA #$FC                   ; $D9F1: A9 FC
        STA z:$9F                  ; $D9F3: 85 9F
        RTS                        ; $D9F5: 60
        LDA z:$46,x                ; $D9F6: B5 46
        CMP #$01                   ; $D9F8: C9 01
        BNE LD9FF                  ; $D9FA: D0 03
        JMP a:$D92C                ; $D9FC: 4C 2C D9
LD9FF:
        JSR a:$DB1C                ; $D9FF: 20 1C DB
        JMP a:$D92C                ; $DA02: 4C 2C D9
        LDY #$01                   ; $DA05: A0 01
        JSR a:$E143                ; $DA07: 20 43 E1
        BPL LDA0D                  ; $DA0A: 10 01
        INY                        ; $DA0C: C8
LDA0D:
        STY z:$46,x                ; $DA0D: 94 46
        DEY                        ; $DA0F: 88
        RTS                        ; $DA10: 60
        STA a:$0110,x              ; $DA11: 9D 10 01
        LDA #$30                   ; $DA14: A9 30
        STA a:$012C,x              ; $DA16: 9D 2C 01
        LDA z:$CF,x                ; $DA19: B5 CF
        STA a:$011E,x              ; $DA1B: 9D 1E 01
        LDA a:$03AE                ; $DA1E: AD AE 03
        STA a:$0117,x              ; $DA21: 9D 17 01
LDA24:
        RTS                        ; $DA24: 60
        .byte $80,$40,$20,$10,$08,$04,$02,$7F,$BF,$DF,$EF,$F7,$FB,$FD   ; $DA25
        LDA z:$09                  ; $DA33: A5 09
        LSR a                      ; $DA35: 4A
        BCC LDA24                  ; $DA36: 90 EC
        LDA a:$074E                ; $DA38: AD 4E 07
        BEQ LDA24                  ; $DA3B: F0 E7
        LDA z:$16,x                ; $DA3D: B5 16
        CMP #$15                   ; $DA3F: C9 15
        BCS LDAB1                  ; $DA41: B0 6E
        CMP #$11                   ; $DA43: C9 11
        BEQ LDAB1                  ; $DA45: F0 6A
        CMP #$0D                   ; $DA47: C9 0D
        BEQ LDAB1                  ; $DA49: F0 66
        LDA a:$03D8,x              ; $DA4B: BD D8 03
        BNE LDAB1                  ; $DA4E: D0 61
        JSR a:$DC52                ; $DA50: 20 52 DC
        DEX                        ; $DA53: CA
        BMI LDAB1                  ; $DA54: 30 5B
LDA56:
        STX z:$01                  ; $DA56: 86 01
        TYA                        ; $DA58: 98
        PHA                        ; $DA59: 48
        LDA z:$0F,x                ; $DA5A: B5 0F
        BEQ LDAAA                  ; $DA5C: F0 4C
        LDA z:$16,x                ; $DA5E: B5 16
        CMP #$15                   ; $DA60: C9 15
        BCS LDAAA                  ; $DA62: B0 46
        CMP #$11                   ; $DA64: C9 11
        BEQ LDAAA                  ; $DA66: F0 42
        CMP #$0D                   ; $DA68: C9 0D
        BEQ LDAAA                  ; $DA6A: F0 3E
        LDA a:$03D8,x              ; $DA6C: BD D8 03
        BNE LDAAA                  ; $DA6F: D0 39
        TXA                        ; $DA71: 8A
        ASL a                      ; $DA72: 0A
        ASL a                      ; $DA73: 0A
        CLC                        ; $DA74: 18
        ADC #$04                   ; $DA75: 69 04
        TAX                        ; $DA77: AA
        JSR a:$E327                ; $DA78: 20 27 E3
        LDX z:$08                  ; $DA7B: A6 08
        LDY z:$01                  ; $DA7D: A4 01
        BCC LDAA1                  ; $DA7F: 90 20
        LDA z:$1E,x                ; $DA81: B5 1E
        ORA a:$001E,y              ; $DA83: 19 1E 00
        AND #$80                   ; $DA86: 29 80
        BNE LDA9B                  ; $DA88: D0 11
        LDA a:$0491,y              ; $DA8A: B9 91 04
        AND a:$DA25,x              ; $DA8D: 3D 25 DA
        BNE LDAAA                  ; $DA90: D0 18
        LDA a:$0491,y              ; $DA92: B9 91 04
        ORA a:$DA25,x              ; $DA95: 1D 25 DA
        STA a:$0491,y              ; $DA98: 99 91 04
LDA9B:
        JSR a:$DAB4                ; $DA9B: 20 B4 DA
        JMP a:$DAAA                ; $DA9E: 4C AA DA
LDAA1:
        LDA a:$0491,y              ; $DAA1: B9 91 04
        AND a:$DA2C,x              ; $DAA4: 3D 2C DA
        STA a:$0491,y              ; $DAA7: 99 91 04
LDAAA:
        PLA                        ; $DAAA: 68
        TAY                        ; $DAAB: A8
        LDX z:$01                  ; $DAAC: A6 01
        DEX                        ; $DAAE: CA
        BPL LDA56                  ; $DAAF: 10 A5
LDAB1:
        LDX z:$08                  ; $DAB1: A6 08
        RTS                        ; $DAB3: 60
        LDA a:$001E,y              ; $DAB4: B9 1E 00
        ORA z:$1E,x                ; $DAB7: 15 1E
        AND #$20                   ; $DAB9: 29 20
        BNE LDAF0                  ; $DABB: D0 33
        LDA z:$1E,x                ; $DABD: B5 1E
        CMP #$06                   ; $DABF: C9 06
        BCC LDAF1                  ; $DAC1: 90 2E
        LDA z:$16,x                ; $DAC3: B5 16
        CMP #$05                   ; $DAC5: C9 05
        BEQ LDAF0                  ; $DAC7: F0 27
        LDA a:$001E,y              ; $DAC9: B9 1E 00
        ASL a                      ; $DACC: 0A
        BCC LDAD9                  ; $DACD: 90 0A
        LDA #$06                   ; $DACF: A9 06
        JSR a:$DA11                ; $DAD1: 20 11 DA
        JSR a:$D795                ; $DAD4: 20 95 D7
        LDY z:$01                  ; $DAD7: A4 01
LDAD9:
        TYA                        ; $DAD9: 98
        TAX                        ; $DADA: AA
        JSR a:$D795                ; $DADB: 20 95 D7
        LDX z:$08                  ; $DADE: A6 08
        LDA a:$0125,x              ; $DAE0: BD 25 01
        CLC                        ; $DAE3: 18
        ADC #$04                   ; $DAE4: 69 04
        LDX z:$01                  ; $DAE6: A6 01
        JSR a:$DA11                ; $DAE8: 20 11 DA
        LDX z:$08                  ; $DAEB: A6 08
        INC a:$0125,x              ; $DAED: FE 25 01
LDAF0:
        RTS                        ; $DAF0: 60
LDAF1:
        LDA a:$001E,y              ; $DAF1: B9 1E 00
        CMP #$06                   ; $DAF4: C9 06
        BCC LDB15                  ; $DAF6: 90 1D
        LDA a:$0016,y              ; $DAF8: B9 16 00
        CMP #$05                   ; $DAFB: C9 05
        BEQ LDAF0                  ; $DAFD: F0 F1
        JSR a:$D795                ; $DAFF: 20 95 D7
        LDY z:$01                  ; $DB02: A4 01
        LDA a:$0125,y              ; $DB04: B9 25 01
        CLC                        ; $DB07: 18
        ADC #$04                   ; $DB08: 69 04
        LDX z:$08                  ; $DB0A: A6 08
        JSR a:$DA11                ; $DB0C: 20 11 DA
        LDX z:$01                  ; $DB0F: A6 01
        INC a:$0125,x              ; $DB11: FE 25 01
        RTS                        ; $DB14: 60
LDB15:
        TYA                        ; $DB15: 98
        TAX                        ; $DB16: AA
        JSR a:$DB1C                ; $DB17: 20 1C DB
        LDX z:$08                  ; $DB1A: A6 08
        LDA z:$16,x                ; $DB1C: B5 16
        CMP #$0D                   ; $DB1E: C9 0D
        BEQ LDB44                  ; $DB20: F0 22
        CMP #$11                   ; $DB22: C9 11
        BEQ LDB44                  ; $DB24: F0 1E
        CMP #$05                   ; $DB26: C9 05
        BEQ LDB44                  ; $DB28: F0 1A
        CMP #$12                   ; $DB2A: C9 12
        BEQ LDB36                  ; $DB2C: F0 08
        CMP #$0E                   ; $DB2E: C9 0E
        BEQ LDB36                  ; $DB30: F0 04
        CMP #$07                   ; $DB32: C9 07
        BCS LDB44                  ; $DB34: B0 0E
LDB36:
        LDA z:$58,x                ; $DB36: B5 58
        EOR #$FF                   ; $DB38: 49 FF
        TAY                        ; $DB3A: A8
        INY                        ; $DB3B: C8
        STY z:$58,x                ; $DB3C: 94 58
        LDA z:$46,x                ; $DB3E: B5 46
        EOR #$03                   ; $DB40: 49 03
        STA z:$46,x                ; $DB42: 95 46
LDB44:
        RTS                        ; $DB44: 60
        LDA #$FF                   ; $DB45: A9 FF
        STA a:$03A2,x              ; $DB47: 9D A2 03
        LDA a:$0747                ; $DB4A: AD 47 07
        BNE LDB78                  ; $DB4D: D0 29
        LDA z:$1E,x                ; $DB4F: B5 1E
        BMI LDB78                  ; $DB51: 30 25
        LDA z:$16,x                ; $DB53: B5 16
        CMP #$24                   ; $DB55: C9 24
        BNE LDB5F                  ; $DB57: D0 06
        LDA z:$1E,x                ; $DB59: B5 1E
        TAX                        ; $DB5B: AA
        JSR a:$DB5F                ; $DB5C: 20 5F DB
LDB5F:
        JSR a:$DC41                ; $DB5F: 20 41 DC
        BCS LDB78                  ; $DB62: B0 14
        TXA                        ; $DB64: 8A
        JSR a:$DC54                ; $DB65: 20 54 DC
        LDA z:$CF,x                ; $DB68: B5 CF
        STA z:$00                  ; $DB6A: 85 00
        TXA                        ; $DB6C: 8A
        PHA                        ; $DB6D: 48
        JSR a:$E325                ; $DB6E: 20 25 E3
        PLA                        ; $DB71: 68
        TAX                        ; $DB72: AA
        BCC LDB78                  ; $DB73: 90 03
        JSR a:$DBBC                ; $DB75: 20 BC DB
LDB78:
        LDX z:$08                  ; $DB78: A6 08
        RTS                        ; $DB7A: 60
        LDA a:$0747                ; $DB7B: AD 47 07
        BNE LDBB7                  ; $DB7E: D0 37
        STA a:$03A2,x              ; $DB80: 9D A2 03
        JSR a:$DC41                ; $DB83: 20 41 DC
        BCS LDBB7                  ; $DB86: B0 2F
        LDA #$02                   ; $DB88: A9 02
        STA z:$00                  ; $DB8A: 85 00
LDB8C:
        LDX z:$08                  ; $DB8C: A6 08
        JSR a:$DC52                ; $DB8E: 20 52 DC
        AND #$02                   ; $DB91: 29 02
        BNE LDBB7                  ; $DB93: D0 22
        LDA a:$04AD,y              ; $DB95: B9 AD 04
        CMP #$20                   ; $DB98: C9 20
        BCC LDBA1                  ; $DB9A: 90 05
        JSR a:$E325                ; $DB9C: 20 25 E3
        BCS LDBBA                  ; $DB9F: B0 19
LDBA1:
        LDA a:$04AD,y              ; $DBA1: B9 AD 04
        CLC                        ; $DBA4: 18
        ADC #$80                   ; $DBA5: 69 80
        STA a:$04AD,y              ; $DBA7: 99 AD 04
        LDA a:$04AF,y              ; $DBAA: B9 AF 04
        CLC                        ; $DBAD: 18
        ADC #$80                   ; $DBAE: 69 80
        STA a:$04AF,y              ; $DBB0: 99 AF 04
        DEC z:$00                  ; $DBB3: C6 00
        BNE LDB8C                  ; $DBB5: D0 D5
LDBB7:
        LDX z:$08                  ; $DBB7: A6 08
        RTS                        ; $DBB9: 60
LDBBA:
        LDX z:$08                  ; $DBBA: A6 08
        LDA a:$04AF,y              ; $DBBC: B9 AF 04
        SEC                        ; $DBBF: 38
        SBC a:$04AD                ; $DBC0: ED AD 04
        CMP #$04                   ; $DBC3: C9 04
        BCS LDBCF                  ; $DBC5: B0 08
        LDA z:$9F                  ; $DBC7: A5 9F
        BPL LDBCF                  ; $DBC9: 10 04
        LDA #$01                   ; $DBCB: A9 01
        STA z:$9F                  ; $DBCD: 85 9F
LDBCF:
        LDA a:$04AF                ; $DBCF: AD AF 04
        SEC                        ; $DBD2: 38
        SBC a:$04AD,y              ; $DBD3: F9 AD 04
        CMP #$06                   ; $DBD6: C9 06
        BCS LDBF5                  ; $DBD8: B0 1B
        LDA z:$9F                  ; $DBDA: A5 9F
        BMI LDBF5                  ; $DBDC: 30 17
        LDA z:$00                  ; $DBDE: A5 00
        LDY z:$16,x                ; $DBE0: B4 16
        CPY #$2B                   ; $DBE2: C0 2B
        BEQ LDBEB                  ; $DBE4: F0 05
        CPY #$2C                   ; $DBE6: C0 2C
        BEQ LDBEB                  ; $DBE8: F0 01
        TXA                        ; $DBEA: 8A
LDBEB:
        LDX z:$08                  ; $DBEB: A6 08
        STA a:$03A2,x              ; $DBED: 9D A2 03
        LDA #$00                   ; $DBF0: A9 00
        STA z:$1D                  ; $DBF2: 85 1D
        RTS                        ; $DBF4: 60
LDBF5:
        LDA #$01                   ; $DBF5: A9 01
        STA z:$00                  ; $DBF7: 85 00
        LDA a:$04AE                ; $DBF9: AD AE 04
        SEC                        ; $DBFC: 38
        SBC a:$04AC,y              ; $DBFD: F9 AC 04
        CMP #$08                   ; $DC00: C9 08
        BCC LDC11                  ; $DC02: 90 0D
        INC z:$00                  ; $DC04: E6 00
        LDA a:$04AE,y              ; $DC06: B9 AE 04
        CLC                        ; $DC09: 18
        SBC a:$04AC                ; $DC0A: ED AC 04
        CMP #$09                   ; $DC0D: C9 09
        BCS LDC14                  ; $DC0F: B0 03
LDC11:
        JSR a:$DF4B                ; $DC11: 20 4B DF
LDC14:
        LDX z:$08                  ; $DC14: A6 08
        RTS                        ; $DC16: 60
        .byte $80,$00   ; $DC17
        TAY                        ; $DC19: A8
        LDA z:$CF,x                ; $DC1A: B5 CF
        CLC                        ; $DC1C: 18
        ADC a:$DC16,y              ; $DC1D: 79 16 DC
        BIT a:$CFB5                ; $DC20: 2C B5 CF
        LDY z:$0E                  ; $DC23: A4 0E
        CPY #$0B                   ; $DC25: C0 0B
        BEQ LDC40                  ; $DC27: F0 17
        LDY z:$B6,x                ; $DC29: B4 B6
        CPY #$01                   ; $DC2B: C0 01
        BNE LDC40                  ; $DC2D: D0 11
        SEC                        ; $DC2F: 38
        SBC #$20                   ; $DC30: E9 20
        STA z:$CE                  ; $DC32: 85 CE
        TYA                        ; $DC34: 98
        SBC #$00                   ; $DC35: E9 00
        STA z:$B5                  ; $DC37: 85 B5
        LDA #$00                   ; $DC39: A9 00
        STA z:$9F                  ; $DC3B: 85 9F
        STA a:$0433                ; $DC3D: 8D 33 04
LDC40:
        RTS                        ; $DC40: 60
        LDA a:$03D0                ; $DC41: AD D0 03
        CMP #$F0                   ; $DC44: C9 F0
        BCS LDC51                  ; $DC46: B0 09
        LDY z:$B5                  ; $DC48: A4 B5
        DEY                        ; $DC4A: 88
        BNE LDC51                  ; $DC4B: D0 04
        LDA z:$CE                  ; $DC4D: A5 CE
        CMP #$D0                   ; $DC4F: C9 D0
LDC51:
        RTS                        ; $DC51: 60
        LDA z:$08                  ; $DC52: A5 08
        ASL a                      ; $DC54: 0A
        ASL a                      ; $DC55: 0A
        CLC                        ; $DC56: 18
        ADC #$04                   ; $DC57: 69 04
        TAY                        ; $DC59: A8
        LDA a:$03D1                ; $DC5A: AD D1 03
        AND #$0F                   ; $DC5D: 29 0F
        CMP #$0F                   ; $DC5F: C9 0F
        RTS                        ; $DC61: 60
        .byte $20,$10   ; $DC62
        LDA a:$0716                ; $DC64: AD 16 07
        BNE LDC97                  ; $DC67: D0 2E
        LDA z:$0E                  ; $DC69: A5 0E
        CMP #$0B                   ; $DC6B: C9 0B
        BEQ LDC97                  ; $DC6D: F0 28
        CMP #$04                   ; $DC6F: C9 04
        BCC LDC97                  ; $DC71: 90 24
        LDA #$01                   ; $DC73: A9 01
        LDY a:$0704                ; $DC75: AC 04 07
        BNE LDC84                  ; $DC78: D0 0A
        LDA z:$1D                  ; $DC7A: A5 1D
        BEQ LDC82                  ; $DC7C: F0 04
        CMP #$03                   ; $DC7E: C9 03
        BNE LDC86                  ; $DC80: D0 04
LDC82:
        LDA #$02                   ; $DC82: A9 02
LDC84:
        STA z:$1D                  ; $DC84: 85 1D
LDC86:
        LDA z:$B5                  ; $DC86: A5 B5
        CMP #$01                   ; $DC88: C9 01
        BNE LDC97                  ; $DC8A: D0 0B
        LDA #$FF                   ; $DC8C: A9 FF
        STA a:$0490                ; $DC8E: 8D 90 04
        LDA z:$CE                  ; $DC91: A5 CE
        CMP #$CF                   ; $DC93: C9 CF
        BCC LDC98                  ; $DC95: 90 01
LDC97:
        RTS                        ; $DC97: 60
LDC98:
        LDY #$02                   ; $DC98: A0 02
        LDA a:$0714                ; $DC9A: AD 14 07
        BNE LDCAB                  ; $DC9D: D0 0C
        LDA a:$0754                ; $DC9F: AD 54 07
        BNE LDCAB                  ; $DCA2: D0 07
        DEY                        ; $DCA4: 88
        LDA a:$0704                ; $DCA5: AD 04 07
        BNE LDCAB                  ; $DCA8: D0 01
        DEY                        ; $DCAA: 88
LDCAB:
        LDA a:$E3AD,y              ; $DCAB: B9 AD E3
        STA z:$EB                  ; $DCAE: 85 EB
        TAY                        ; $DCB0: A8
        LDX a:$0754                ; $DCB1: AE 54 07
        LDA a:$0714                ; $DCB4: AD 14 07
        BEQ LDCBA                  ; $DCB7: F0 01
        INX                        ; $DCB9: E8
LDCBA:
        LDA z:$CE                  ; $DCBA: A5 CE
        CMP a:$DC62,x              ; $DCBC: DD 62 DC
        BCC LDCF6                  ; $DCBF: 90 35
        JSR a:$E3E9                ; $DCC1: 20 E9 E3
        BEQ LDCF6                  ; $DCC4: F0 30
        JSR a:$DFA1                ; $DCC6: 20 A1 DF
        BCS LDD1A                  ; $DCC9: B0 4F
        LDY z:$9F                  ; $DCCB: A4 9F
        BPL LDCF6                  ; $DCCD: 10 27
        LDY z:$04                  ; $DCCF: A4 04
        CPY #$04                   ; $DCD1: C0 04
        BCC LDCF6                  ; $DCD3: 90 21
        JSR a:$DF8F                ; $DCD5: 20 8F DF
        BCS LDCEA                  ; $DCD8: B0 10
        LDY a:$074E                ; $DCDA: AC 4E 07
        BEQ LDCF2                  ; $DCDD: F0 13
        LDY a:$0784                ; $DCDF: AC 84 07
        BNE LDCF2                  ; $DCE2: D0 0E
        JSR a:$BCED                ; $DCE4: 20 ED BC
        JMP a:$DCF6                ; $DCE7: 4C F6 DC
LDCEA:
        CMP #$26                   ; $DCEA: C9 26
        BEQ LDCF2                  ; $DCEC: F0 04
        LDA #$02                   ; $DCEE: A9 02
        STA z:$FF                  ; $DCF0: 85 FF
LDCF2:
        LDA #$01                   ; $DCF2: A9 01
        STA z:$9F                  ; $DCF4: 85 9F
LDCF6:
        LDY z:$EB                  ; $DCF6: A4 EB
        LDA z:$CE                  ; $DCF8: A5 CE
        CMP #$CF                   ; $DCFA: C9 CF
        BCS LDD5E                  ; $DCFC: B0 60
        JSR a:$E3E8                ; $DCFE: 20 E8 E3
        JSR a:$DFA1                ; $DD01: 20 A1 DF
        BCS LDD1A                  ; $DD04: B0 14
        PHA                        ; $DD06: 48
        JSR a:$E3E8                ; $DD07: 20 E8 E3
        STA z:$00                  ; $DD0A: 85 00
        PLA                        ; $DD0C: 68
        STA z:$01                  ; $DD0D: 85 01
        BNE LDD1D                  ; $DD0F: D0 0C
        LDA z:$00                  ; $DD11: A5 00
        BEQ LDD5E                  ; $DD13: F0 49
        JSR a:$DFA1                ; $DD15: 20 A1 DF
        BCC LDD1D                  ; $DD18: 90 03
LDD1A:
        JMP a:$DE05                ; $DD1A: 4C 05 DE
LDD1D:
        JSR a:$DF9A                ; $DD1D: 20 9A DF
        BCS LDD5E                  ; $DD20: B0 3C
        LDY z:$9F                  ; $DD22: A4 9F
        BMI LDD5E                  ; $DD24: 30 38
        CMP #$C5                   ; $DD26: C9 C5
        BNE LDD2D                  ; $DD28: D0 03
        JMP a:$DE0E                ; $DD2A: 4C 0E DE
LDD2D:
        JSR a:$DEBD                ; $DD2D: 20 BD DE
        BEQ LDD5E                  ; $DD30: F0 2C
        LDY a:$070E                ; $DD32: AC 0E 07
        BNE LDD5A                  ; $DD35: D0 23
        LDY z:$04                  ; $DD37: A4 04
        CPY #$05                   ; $DD39: C0 05
        BCC LDD44                  ; $DD3B: 90 07
        LDA z:$45                  ; $DD3D: A5 45
        STA z:$00                  ; $DD3F: 85 00
        JMP a:$DF4B                ; $DD41: 4C 4B DF
LDD44:
        JSR a:$DEC4                ; $DD44: 20 C4 DE
        LDA #$F0                   ; $DD47: A9 F0
        AND z:$CE                  ; $DD49: 25 CE
        STA z:$CE                  ; $DD4B: 85 CE
        JSR a:$DEE8                ; $DD4D: 20 E8 DE
        LDA #$00                   ; $DD50: A9 00
        STA z:$9F                  ; $DD52: 85 9F
        STA a:$0433                ; $DD54: 8D 33 04
        STA a:$0484                ; $DD57: 8D 84 04
LDD5A:
        LDA #$00                   ; $DD5A: A9 00
        STA z:$1D                  ; $DD5C: 85 1D
LDD5E:
        LDY z:$EB                  ; $DD5E: A4 EB
        INY                        ; $DD60: C8
        INY                        ; $DD61: C8
        LDA #$02                   ; $DD62: A9 02
        STA z:$00                  ; $DD64: 85 00
LDD66:
        INY                        ; $DD66: C8
        STY z:$EB                  ; $DD67: 84 EB
        LDA z:$CE                  ; $DD69: A5 CE
        CMP #$20                   ; $DD6B: C9 20
        BCC LDD85                  ; $DD6D: 90 16
        CMP #$E4                   ; $DD6F: C9 E4
        BCS LDD9B                  ; $DD71: B0 28
        JSR a:$E3EC                ; $DD73: 20 EC E3
        BEQ LDD85                  ; $DD76: F0 0D
        CMP #$1C                   ; $DD78: C9 1C
        BEQ LDD85                  ; $DD7A: F0 09
        CMP #$6B                   ; $DD7C: C9 6B
        BEQ LDD85                  ; $DD7E: F0 05
        JSR a:$DF9A                ; $DD80: 20 9A DF
        BCC LDD9C                  ; $DD83: 90 17
LDD85:
        LDY z:$EB                  ; $DD85: A4 EB
        INY                        ; $DD87: C8
        LDA z:$CE                  ; $DD88: A5 CE
        CMP #$08                   ; $DD8A: C9 08
        BCC LDD9B                  ; $DD8C: 90 0D
        CMP #$D0                   ; $DD8E: C9 D0
        BCS LDD9B                  ; $DD90: B0 09
        JSR a:$E3EC                ; $DD92: 20 EC E3
        BNE LDD9C                  ; $DD95: D0 05
        DEC z:$00                  ; $DD97: C6 00
        BNE LDD66                  ; $DD99: D0 CB
LDD9B:
        RTS                        ; $DD9B: 60
LDD9C:
        JSR a:$DEBD                ; $DD9C: 20 BD DE
        BEQ LDE02                  ; $DD9F: F0 61
        JSR a:$DF9A                ; $DDA1: 20 9A DF
        BCC LDDA9                  ; $DDA4: 90 03
        JMP a:$DE2E                ; $DDA6: 4C 2E DE
LDDA9:
        JSR a:$DFA1                ; $DDA9: 20 A1 DF
        BCS LDE05                  ; $DDAC: B0 57
        JSR a:$DEDD                ; $DDAE: 20 DD DE
        BCC LDDBB                  ; $DDB1: 90 08
        LDA a:$070E                ; $DDB3: AD 0E 07
        BNE LDE02                  ; $DDB6: D0 4A
        JMP a:$DDFF                ; $DDB8: 4C FF DD
LDDBB:
        LDY z:$1D                  ; $DDBB: A4 1D
        CPY #$00                   ; $DDBD: C0 00
        BNE LDDFF                  ; $DDBF: D0 3E
        LDY z:$33                  ; $DDC1: A4 33
        DEY                        ; $DDC3: 88
        BNE LDDFF                  ; $DDC4: D0 39
        CMP #$6C                   ; $DDC6: C9 6C
        BEQ LDDCE                  ; $DDC8: F0 04
        CMP #$1F                   ; $DDCA: C9 1F
        BNE LDDFF                  ; $DDCC: D0 31
LDDCE:
        LDA a:$03C4                ; $DDCE: AD C4 03
        BNE LDDD7                  ; $DDD1: D0 04
        LDY #$10                   ; $DDD3: A0 10
        STY z:$FF                  ; $DDD5: 84 FF
LDDD7:
        ORA #$20                   ; $DDD7: 09 20
        STA a:$03C4                ; $DDD9: 8D C4 03
        LDA z:$86                  ; $DDDC: A5 86
        AND #$0F                   ; $DDDE: 29 0F
        BEQ LDDF0                  ; $DDE0: F0 0E
        LDY #$00                   ; $DDE2: A0 00
        LDA a:$071A                ; $DDE4: AD 1A 07
        BEQ LDDEA                  ; $DDE7: F0 01
        INY                        ; $DDE9: C8
LDDEA:
        LDA a:$DE03,y              ; $DDEA: B9 03 DE
        STA a:$06DE                ; $DDED: 8D DE 06
LDDF0:
        LDA z:$0E                  ; $DDF0: A5 0E
        CMP #$07                   ; $DDF2: C9 07
        BEQ LDE02                  ; $DDF4: F0 0C
        CMP #$08                   ; $DDF6: C9 08
        BNE LDE02                  ; $DDF8: D0 08
        LDA #$02                   ; $DDFA: A9 02
        STA z:$0E                  ; $DDFC: 85 0E
        RTS                        ; $DDFE: 60
LDDFF:
        JSR a:$DF4B                ; $DDFF: 20 4B DF
LDE02:
        RTS                        ; $DE02: 60
        .byte $A0,$34   ; $DE03
LDE05:
        JSR a:$DE1C                ; $DE05: 20 1C DE
        INC a:$0748                ; $DE08: EE 48 07
        JMP a:$BBFE                ; $DE0B: 4C FE BB
        LDA #$00                   ; $DE0E: A9 00
        STA a:$0772                ; $DE10: 8D 72 07
        LDA #$02                   ; $DE13: A9 02
        STA a:$0770                ; $DE15: 8D 70 07
        LDA #$18                   ; $DE18: A9 18
        STA z:$57                  ; $DE1A: 85 57
        LDY z:$02                  ; $DE1C: A4 02
        LDA #$00                   ; $DE1E: A9 00
        STA ($06),y                ; $DE20: 91 06
        JMP a:$8A4D                ; $DE22: 4C 4D 8A
        .byte $F9,$07,$FF,$00,$18,$22,$50,$68,$90   ; $DE25
        LDY z:$04                  ; $DE2E: A4 04
        CPY #$06                   ; $DE30: C0 06
        BCC LDE38                  ; $DE32: 90 04
        CPY #$0A                   ; $DE34: C0 0A
        BCC LDE39                  ; $DE36: 90 01
LDE38:
        RTS                        ; $DE38: 60
LDE39:
        CMP #$24                   ; $DE39: C9 24
        BEQ LDE41                  ; $DE3B: F0 04
        CMP #$25                   ; $DE3D: C9 25
        BNE LDE7A                  ; $DE3F: D0 39
LDE41:
        LDA z:$0E                  ; $DE41: A5 0E
        CMP #$05                   ; $DE43: C9 05
        BEQ LDE88                  ; $DE45: F0 41
        LDA #$01                   ; $DE47: A9 01
        STA z:$33                  ; $DE49: 85 33
        INC a:$0723                ; $DE4B: EE 23 07
        LDA z:$0E                  ; $DE4E: A5 0E
        CMP #$04                   ; $DE50: C9 04
        BEQ LDE73                  ; $DE52: F0 1F
        LDA #$33                   ; $DE54: A9 33
        JSR a:$9716                ; $DE56: 20 16 97
        LDA #$80                   ; $DE59: A9 80
        STA z:$FC                  ; $DE5B: 85 FC
        LSR a                      ; $DE5D: 4A
        STA a:$0713                ; $DE5E: 8D 13 07
        LDX #$04                   ; $DE61: A2 04
        LDA z:$CE                  ; $DE63: A5 CE
        STA a:$070F                ; $DE65: 8D 0F 07
LDE68:
        CMP a:$DE29,x              ; $DE68: DD 29 DE
        BCS LDE70                  ; $DE6B: B0 03
        DEX                        ; $DE6D: CA
        BNE LDE68                  ; $DE6E: D0 F8
LDE70:
        STX a:$010F                ; $DE70: 8E 0F 01
LDE73:
        LDA #$04                   ; $DE73: A9 04
        STA z:$0E                  ; $DE75: 85 0E
        JMP a:$DE88                ; $DE77: 4C 88 DE
LDE7A:
        CMP #$26                   ; $DE7A: C9 26
        BNE LDE88                  ; $DE7C: D0 0A
        LDA z:$CE                  ; $DE7E: A5 CE
        CMP #$20                   ; $DE80: C9 20
        BCS LDE88                  ; $DE82: B0 04
        LDA #$01                   ; $DE84: A9 01
        STA z:$0E                  ; $DE86: 85 0E
LDE88:
        LDA #$03                   ; $DE88: A9 03
        STA z:$1D                  ; $DE8A: 85 1D
        LDA #$00                   ; $DE8C: A9 00
        STA z:$57                  ; $DE8E: 85 57
        STA a:$0705                ; $DE90: 8D 05 07
        LDA z:$86                  ; $DE93: A5 86
        SEC                        ; $DE95: 38
        SBC a:$071C                ; $DE96: ED 1C 07
        CMP #$10                   ; $DE99: C9 10
        BCS LDEA1                  ; $DE9B: B0 04
        LDA #$02                   ; $DE9D: A9 02
        STA z:$33                  ; $DE9F: 85 33
LDEA1:
        LDY z:$33                  ; $DEA1: A4 33
        LDA z:$06                  ; $DEA3: A5 06
        ASL a                      ; $DEA5: 0A
        ASL a                      ; $DEA6: 0A
        ASL a                      ; $DEA7: 0A
        ASL a                      ; $DEA8: 0A
        CLC                        ; $DEA9: 18
        ADC a:$DE24,y              ; $DEAA: 79 24 DE
        STA z:$86                  ; $DEAD: 85 86
        LDA z:$06                  ; $DEAF: A5 06
        BNE LDEBC                  ; $DEB1: D0 09
        LDA a:$071B                ; $DEB3: AD 1B 07
        CLC                        ; $DEB6: 18
        ADC a:$DE26,y              ; $DEB7: 79 26 DE
        STA z:$6D                  ; $DEBA: 85 6D
LDEBC:
        RTS                        ; $DEBC: 60
        CMP #$5F                   ; $DEBD: C9 5F
        BEQ LDEC3                  ; $DEBF: F0 02
        CMP #$60                   ; $DEC1: C9 60
LDEC3:
        RTS                        ; $DEC3: 60
        JSR a:$DEDD                ; $DEC4: 20 DD DE
        BCC LDEDC                  ; $DEC7: 90 13
        LDA #$70                   ; $DEC9: A9 70
        STA a:$0709                ; $DECB: 8D 09 07
        LDA #$F9                   ; $DECE: A9 F9
        STA a:$06DB                ; $DED0: 8D DB 06
        LDA #$03                   ; $DED3: A9 03
        STA a:$0786                ; $DED5: 8D 86 07
        LSR a                      ; $DED8: 4A
        STA a:$070E                ; $DED9: 8D 0E 07
LDEDC:
        RTS                        ; $DEDC: 60
        CMP #$67                   ; $DEDD: C9 67
        BEQ LDEE6                  ; $DEDF: F0 05
        CMP #$68                   ; $DEE1: C9 68
        CLC                        ; $DEE3: 18
        BNE LDEE7                  ; $DEE4: D0 01
LDEE6:
        SEC                        ; $DEE6: 38
LDEE7:
        RTS                        ; $DEE7: 60
        LDA z:$0B                  ; $DEE8: A5 0B
        AND #$04                   ; $DEEA: 29 04
        BEQ LDF4A                  ; $DEEC: F0 5C
        LDA z:$00                  ; $DEEE: A5 00
        CMP #$11                   ; $DEF0: C9 11
        BNE LDF4A                  ; $DEF2: D0 56
        LDA z:$01                  ; $DEF4: A5 01
        CMP #$10                   ; $DEF6: C9 10
        BNE LDF4A                  ; $DEF8: D0 50
        LDA #$30                   ; $DEFA: A9 30
        STA a:$06DE                ; $DEFC: 8D DE 06
        LDA #$03                   ; $DEFF: A9 03
        STA z:$0E                  ; $DF01: 85 0E
        LDA #$10                   ; $DF03: A9 10
        STA z:$FF                  ; $DF05: 85 FF
        LDA #$20                   ; $DF07: A9 20
        STA a:$03C4                ; $DF09: 8D C4 03
        LDA a:$06D6                ; $DF0C: AD D6 06
        BEQ LDF4A                  ; $DF0F: F0 39
        AND #$03                   ; $DF11: 29 03
        ASL a                      ; $DF13: 0A
        ASL a                      ; $DF14: 0A
        TAX                        ; $DF15: AA
        LDA z:$86                  ; $DF16: A5 86
        CMP #$60                   ; $DF18: C9 60
        BCC LDF22                  ; $DF1A: 90 06
        INX                        ; $DF1C: E8
        CMP #$A0                   ; $DF1D: C9 A0
        BCC LDF22                  ; $DF1F: 90 01
        INX                        ; $DF21: E8
LDF22:
        LDY a:$87F2,x              ; $DF22: BC F2 87
        DEY                        ; $DF25: 88
        STY a:$075F                ; $DF26: 8C 5F 07
        LDX a:$9CB4,y              ; $DF29: BE B4 9C
        LDA a:$9CBC,x              ; $DF2C: BD BC 9C
        STA a:$0750                ; $DF2F: 8D 50 07
        LDA #$80                   ; $DF32: A9 80
        STA z:$FC                  ; $DF34: 85 FC
        LDA #$00                   ; $DF36: A9 00
        STA a:$0751                ; $DF38: 8D 51 07
        STA a:$0760                ; $DF3B: 8D 60 07
        STA a:$075C                ; $DF3E: 8D 5C 07
        STA a:$0752                ; $DF41: 8D 52 07
        INC a:$075D                ; $DF44: EE 5D 07
        INC a:$0757                ; $DF47: EE 57 07
LDF4A:
        RTS                        ; $DF4A: 60
        LDA #$00                   ; $DF4B: A9 00
        LDY z:$57                  ; $DF4D: A4 57
        LDX z:$00                  ; $DF4F: A6 00
        DEX                        ; $DF51: CA
        BNE LDF5E                  ; $DF52: D0 0A
        INX                        ; $DF54: E8
        CPY #$00                   ; $DF55: C0 00
        BMI LDF81                  ; $DF57: 30 28
        LDA #$FF                   ; $DF59: A9 FF
        JMP a:$DF66                ; $DF5B: 4C 66 DF
LDF5E:
        LDX #$02                   ; $DF5E: A2 02
        CPY #$01                   ; $DF60: C0 01
        BPL LDF81                  ; $DF62: 10 1D
        LDA #$01                   ; $DF64: A9 01
        LDY #$10                   ; $DF66: A0 10
        STY a:$0785                ; $DF68: 8C 85 07
        LDY #$00                   ; $DF6B: A0 00
        STY z:$57                  ; $DF6D: 84 57
        CMP #$00                   ; $DF6F: C9 00
        BPL LDF74                  ; $DF71: 10 01
        DEY                        ; $DF73: 88
LDF74:
        STY z:$00                  ; $DF74: 84 00
        CLC                        ; $DF76: 18
        ADC z:$86                  ; $DF77: 65 86
        STA z:$86                  ; $DF79: 85 86
        LDA z:$6D                  ; $DF7B: A5 6D
        ADC z:$00                  ; $DF7D: 65 00
        STA z:$6D                  ; $DF7F: 85 6D
LDF81:
        TXA                        ; $DF81: 8A
        EOR #$FF                   ; $DF82: 49 FF
        AND a:$0490                ; $DF84: 2D 90 04
        STA a:$0490                ; $DF87: 8D 90 04
        RTS                        ; $DF8A: 60
        .byte $10,$61,$88,$C4   ; $DF8B
        JSR a:$DFB0                ; $DF8F: 20 B0 DF
        CMP a:$DF8B,x              ; $DF92: DD 8B DF
        RTS                        ; $DF95: 60
        .byte $24,$6D,$8A,$C6   ; $DF96
        JSR a:$DFB0                ; $DF9A: 20 B0 DF
        CMP a:$DF96,x              ; $DF9D: DD 96 DF
        RTS                        ; $DFA0: 60
        CMP #$C2                   ; $DFA1: C9 C2
        BEQ LDFAB                  ; $DFA3: F0 06
        CMP #$C3                   ; $DFA5: C9 C3
        BEQ LDFAB                  ; $DFA7: F0 02
        CLC                        ; $DFA9: 18
        RTS                        ; $DFAA: 60
LDFAB:
        LDA #$01                   ; $DFAB: A9 01
        STA z:$FE                  ; $DFAD: 85 FE
        RTS                        ; $DFAF: 60
        TAY                        ; $DFB0: A8
        AND #$C0                   ; $DFB1: 29 C0
        ASL a                      ; $DFB3: 0A
        ROL a                      ; $DFB4: 2A
        ROL a                      ; $DFB5: 2A
        TAX                        ; $DFB6: AA
        TYA                        ; $DFB7: 98
LDFB8:
        RTS                        ; $DFB8: 60
        .byte $01,$01,$02,$02,$02,$05,$10,$F0   ; $DFB9
        LDA z:$1E,x                ; $DFC1: B5 1E
        AND #$20                   ; $DFC3: 29 20
        BNE LDFB8                  ; $DFC5: D0 F1
        JSR a:$E15B                ; $DFC7: 20 5B E1
        BCC LDFB8                  ; $DFCA: 90 EC
        LDY z:$16,x                ; $DFCC: B4 16
        CPY #$12                   ; $DFCE: C0 12
        BNE LDFD8                  ; $DFD0: D0 06
        LDA z:$CF,x                ; $DFD2: B5 CF
        CMP #$25                   ; $DFD4: C9 25
        BCC LDFB8                  ; $DFD6: 90 E0
LDFD8:
        CPY #$0E                   ; $DFD8: C0 0E
        BNE LDFDF                  ; $DFDA: D0 03
        JMP a:$E163                ; $DFDC: 4C 63 E1
LDFDF:
        CPY #$05                   ; $DFDF: C0 05
        BNE LDFE6                  ; $DFE1: D0 03
        JMP a:$E185                ; $DFE3: 4C 85 E1
LDFE6:
        CPY #$12                   ; $DFE6: C0 12
        BEQ LDFF2                  ; $DFE8: F0 08
        CPY #$2E                   ; $DFEA: C0 2E
        BEQ LDFF2                  ; $DFEC: F0 04
        CPY #$07                   ; $DFEE: C0 07
        BCS LE066                  ; $DFF0: B0 74
LDFF2:
        JSR a:$E1AE                ; $DFF2: 20 AE E1
        BNE LDFFA                  ; $DFF5: D0 03
LDFF7:
        JMP a:$E0E2                ; $DFF7: 4C E2 E0
LDFFA:
        JSR a:$E1B5                ; $DFFA: 20 B5 E1
        BEQ LDFF7                  ; $DFFD: F0 F8
        CMP #$23                   ; $DFFF: C9 23
        BNE LE067                  ; $E001: D0 64
        LDY z:$02                  ; $E003: A4 02
        LDA #$00                   ; $E005: A9 00
        STA ($06),y                ; $E007: 91 06
        LDA z:$16,x                ; $E009: B5 16
        CMP #$15                   ; $E00B: C9 15
        BCS LE01B                  ; $E00D: B0 0C
        CMP #$06                   ; $E00F: C9 06
        BNE LE016                  ; $E011: D0 03
        JSR a:$E18E                ; $E013: 20 8E E1
LE016:
        LDA #$01                   ; $E016: A9 01
        JSR a:$DA11                ; $E018: 20 11 DA
LE01B:
        CMP #$09                   ; $E01B: C9 09
        BCC LE02F                  ; $E01D: 90 10
        CMP #$11                   ; $E01F: C9 11
        BCS LE02F                  ; $E021: B0 0C
        CMP #$0A                   ; $E023: C9 0A
        BCC LE02B                  ; $E025: 90 04
        CMP #$0D                   ; $E027: C9 0D
        BCC LE02F                  ; $E029: 90 04
LE02B:
        AND #$01                   ; $E02B: 29 01
        STA z:$16,x                ; $E02D: 95 16
LE02F:
        LDA z:$1E,x                ; $E02F: B5 1E
        AND #$F0                   ; $E031: 29 F0
        ORA #$02                   ; $E033: 09 02
        STA z:$1E,x                ; $E035: 95 1E
        DEC z:$CF,x                ; $E037: D6 CF
        DEC z:$CF,x                ; $E039: D6 CF
        LDA z:$16,x                ; $E03B: B5 16
        CMP #$07                   ; $E03D: C9 07
        BEQ LE048                  ; $E03F: F0 07
        LDA #$FD                   ; $E041: A9 FD
        LDY a:$074E                ; $E043: AC 4E 07
        BNE LE04A                  ; $E046: D0 02
LE048:
        LDA #$FF                   ; $E048: A9 FF
LE04A:
        STA z:$A0,x                ; $E04A: 95 A0
        LDY #$01                   ; $E04C: A0 01
        JSR a:$E143                ; $E04E: 20 43 E1
        BPL LE054                  ; $E051: 10 01
        INY                        ; $E053: C8
LE054:
        LDA z:$16,x                ; $E054: B5 16
        CMP #$33                   ; $E056: C9 33
        BEQ LE060                  ; $E058: F0 06
        CMP #$08                   ; $E05A: C9 08
        BEQ LE060                  ; $E05C: F0 02
        STY z:$46,x                ; $E05E: 94 46
LE060:
        DEY                        ; $E060: 88
        LDA a:$DFBF,y              ; $E061: B9 BF DF
        STA z:$58,x                ; $E064: 95 58
LE066:
        RTS                        ; $E066: 60
LE067:
        LDA z:$04                  ; $E067: A5 04
        SEC                        ; $E069: 38
        SBC #$08                   ; $E06A: E9 08
        CMP #$05                   ; $E06C: C9 05
        BCS LE0E2                  ; $E06E: B0 72
        LDA z:$1E,x                ; $E070: B5 1E
        AND #$40                   ; $E072: 29 40
        BNE LE0CD                  ; $E074: D0 57
        LDA z:$1E,x                ; $E076: B5 1E
        ASL a                      ; $E078: 0A
        BCC LE07E                  ; $E079: 90 03
LE07B:
        JMP a:$E0FE                ; $E07B: 4C FE E0
LE07E:
        LDA z:$1E,x                ; $E07E: B5 1E
        BEQ LE07B                  ; $E080: F0 F9
        CMP #$05                   ; $E082: C9 05
        BEQ LE0A5                  ; $E084: F0 1F
        CMP #$03                   ; $E086: C9 03
        BCS LE0A4                  ; $E088: B0 1A
        LDA z:$1E,x                ; $E08A: B5 1E
        CMP #$02                   ; $E08C: C9 02
        BNE LE0A5                  ; $E08E: D0 15
        LDA #$10                   ; $E090: A9 10
        LDY z:$16,x                ; $E092: B4 16
        CPY #$12                   ; $E094: C0 12
        BNE LE09A                  ; $E096: D0 02
        LDA #$00                   ; $E098: A9 00
LE09A:
        STA a:$0796,x              ; $E09A: 9D 96 07
        LDA #$03                   ; $E09D: A9 03
        STA z:$1E,x                ; $E09F: 95 1E
        JSR a:$E14F                ; $E0A1: 20 4F E1
LE0A4:
        RTS                        ; $E0A4: 60
LE0A5:
        LDA z:$16,x                ; $E0A5: B5 16
        CMP #$06                   ; $E0A7: C9 06
        BEQ LE0CD                  ; $E0A9: F0 22
        CMP #$12                   ; $E0AB: C9 12
        BNE LE0BD                  ; $E0AD: D0 0E
        LDA #$01                   ; $E0AF: A9 01
        STA z:$46,x                ; $E0B1: 95 46
        LDA #$08                   ; $E0B3: A9 08
        STA z:$58,x                ; $E0B5: 95 58
        LDA z:$09                  ; $E0B7: A5 09
        AND #$07                   ; $E0B9: 29 07
        BEQ LE0CD                  ; $E0BB: F0 10
LE0BD:
        LDY #$01                   ; $E0BD: A0 01
        JSR a:$E143                ; $E0BF: 20 43 E1
        BPL LE0C5                  ; $E0C2: 10 01
        INY                        ; $E0C4: C8
LE0C5:
        TYA                        ; $E0C5: 98
        CMP z:$46,x                ; $E0C6: D5 46
        BNE LE0CD                  ; $E0C8: D0 03
        JSR a:$E124                ; $E0CA: 20 24 E1
LE0CD:
        JSR a:$E14F                ; $E0CD: 20 4F E1
        LDA z:$1E,x                ; $E0D0: B5 1E
        AND #$80                   ; $E0D2: 29 80
        BNE LE0DB                  ; $E0D4: D0 05
        LDA #$00                   ; $E0D6: A9 00
        STA z:$1E,x                ; $E0D8: 95 1E
        RTS                        ; $E0DA: 60
LE0DB:
        LDA z:$1E,x                ; $E0DB: B5 1E
        AND #$BF                   ; $E0DD: 29 BF
        STA z:$1E,x                ; $E0DF: 95 1E
        RTS                        ; $E0E1: 60
LE0E2:
        LDA z:$16,x                ; $E0E2: B5 16
        CMP #$03                   ; $E0E4: C9 03
        BNE LE0EC                  ; $E0E6: D0 04
        LDA z:$1E,x                ; $E0E8: B5 1E
        BEQ LE124                  ; $E0EA: F0 38
LE0EC:
        LDA z:$1E,x                ; $E0EC: B5 1E
        TAY                        ; $E0EE: A8
        ASL a                      ; $E0EF: 0A
        BCC LE0F9                  ; $E0F0: 90 07
        LDA z:$1E,x                ; $E0F2: B5 1E
        ORA #$40                   ; $E0F4: 09 40
        JMP a:$E0FC                ; $E0F6: 4C FC E0
LE0F9:
        LDA a:$DFB9,y              ; $E0F9: B9 B9 DF
        STA z:$1E,x                ; $E0FC: 95 1E
        LDA z:$CF,x                ; $E0FE: B5 CF
        CMP #$20                   ; $E100: C9 20
        BCC LE123                  ; $E102: 90 1F
        LDY #$16                   ; $E104: A0 16
        LDA #$02                   ; $E106: A9 02
        STA z:$EB                  ; $E108: 85 EB
LE10A:
        LDA z:$EB                  ; $E10A: A5 EB
        CMP z:$46,x                ; $E10C: D5 46
        BNE LE11C                  ; $E10E: D0 0C
        LDA #$01                   ; $E110: A9 01
        JSR a:$E388                ; $E112: 20 88 E3
        BEQ LE11C                  ; $E115: F0 05
        JSR a:$E1B5                ; $E117: 20 B5 E1
        BNE LE124                  ; $E11A: D0 08
LE11C:
        DEC z:$EB                  ; $E11C: C6 EB
        INY                        ; $E11E: C8
        CPY #$18                   ; $E11F: C0 18
        BCC LE10A                  ; $E121: 90 E7
LE123:
        RTS                        ; $E123: 60
LE124:
        CPX #$05                   ; $E124: E0 05
        BEQ LE131                  ; $E126: F0 09
        LDA z:$1E,x                ; $E128: B5 1E
        ASL a                      ; $E12A: 0A
        BCC LE131                  ; $E12B: 90 04
        LDA #$02                   ; $E12D: A9 02
        STA z:$FF                  ; $E12F: 85 FF
LE131:
        LDA z:$16,x                ; $E131: B5 16
        CMP #$05                   ; $E133: C9 05
        BNE LE140                  ; $E135: D0 09
        LDA #$00                   ; $E137: A9 00
        STA z:$00                  ; $E139: 85 00
        LDY #$FA                   ; $E13B: A0 FA
        JMP a:$CA37                ; $E13D: 4C 37 CA
LE140:
        JMP a:$DB36                ; $E140: 4C 36 DB
        LDA z:$87,x                ; $E143: B5 87
        SEC                        ; $E145: 38
        SBC z:$86                  ; $E146: E5 86
        STA z:$00                  ; $E148: 85 00
        LDA z:$6E,x                ; $E14A: B5 6E
        SBC z:$6D                  ; $E14C: E5 6D
        RTS                        ; $E14E: 60
        JSR a:$C363                ; $E14F: 20 63 C3
        LDA z:$CF,x                ; $E152: B5 CF
        AND #$F0                   ; $E154: 29 F0
        ORA #$08                   ; $E156: 09 08
        STA z:$CF,x                ; $E158: 95 CF
        RTS                        ; $E15A: 60
        LDA z:$CF,x                ; $E15B: B5 CF
        CLC                        ; $E15D: 18
        ADC #$3E                   ; $E15E: 69 3E
        CMP #$44                   ; $E160: C9 44
        RTS                        ; $E162: 60
        JSR a:$E15B                ; $E163: 20 5B E1
        BCC LE182                  ; $E166: 90 1A
        LDA z:$A0,x                ; $E168: B5 A0
        CLC                        ; $E16A: 18
        ADC #$02                   ; $E16B: 69 02
        CMP #$03                   ; $E16D: C9 03
        BCC LE182                  ; $E16F: 90 11
        JSR a:$E1AE                ; $E171: 20 AE E1
        BEQ LE182                  ; $E174: F0 0C
        JSR a:$E1B5                ; $E176: 20 B5 E1
        BEQ LE182                  ; $E179: F0 07
        JSR a:$E14F                ; $E17B: 20 4F E1
        LDA #$FD                   ; $E17E: A9 FD
        STA z:$A0,x                ; $E180: 95 A0
LE182:
        JMP a:$E0FE                ; $E182: 4C FE E0
        JSR a:$E1AE                ; $E185: 20 AE E1
        BEQ LE1A7                  ; $E188: F0 1D
        CMP #$23                   ; $E18A: C9 23
        BNE LE196                  ; $E18C: D0 08
        JSR a:$D795                ; $E18E: 20 95 D7
        LDA #$FC                   ; $E191: A9 FC
        STA z:$A0,x                ; $E193: 95 A0
        RTS                        ; $E195: 60
LE196:
        LDA a:$078A,x              ; $E196: BD 8A 07
        BNE LE1A7                  ; $E199: D0 0C
        LDA z:$1E,x                ; $E19B: B5 1E
        AND #$88                   ; $E19D: 29 88
        STA z:$1E,x                ; $E19F: 95 1E
        JSR a:$E14F                ; $E1A1: 20 4F E1
        JMP a:$E0FE                ; $E1A4: 4C FE E0
LE1A7:
        LDA z:$1E,x                ; $E1A7: B5 1E
        ORA #$01                   ; $E1A9: 09 01
        STA z:$1E,x                ; $E1AB: 95 1E
        RTS                        ; $E1AD: 60
        LDA #$00                   ; $E1AE: A9 00
        LDY #$15                   ; $E1B0: A0 15
        JMP a:$E388                ; $E1B2: 4C 88 E3
        CMP #$26                   ; $E1B5: C9 26
        BEQ LE1C7                  ; $E1B7: F0 0E
        CMP #$C2                   ; $E1B9: C9 C2
        BEQ LE1C7                  ; $E1BB: F0 0A
        CMP #$C3                   ; $E1BD: C9 C3
        BEQ LE1C7                  ; $E1BF: F0 06
        CMP #$5F                   ; $E1C1: C9 5F
        BEQ LE1C7                  ; $E1C3: F0 02
        CMP #$60                   ; $E1C5: C9 60
LE1C7:
        RTS                        ; $E1C7: 60
        LDA z:$D5,x                ; $E1C8: B5 D5
        CMP #$18                   ; $E1CA: C9 18
        BCC LE1EF                  ; $E1CC: 90 21
        JSR a:$E39C                ; $E1CE: 20 9C E3
        BEQ LE1EF                  ; $E1D1: F0 1C
        JSR a:$E1B5                ; $E1D3: 20 B5 E1
        BEQ LE1EF                  ; $E1D6: F0 17
        LDA z:$A6,x                ; $E1D8: B5 A6
        BMI LE1F4                  ; $E1DA: 30 18
        LDA z:$3A,x                ; $E1DC: B5 3A
        BNE LE1F4                  ; $E1DE: D0 14
        LDA #$FD                   ; $E1E0: A9 FD
        STA z:$A6,x                ; $E1E2: 95 A6
        LDA #$01                   ; $E1E4: A9 01
        STA z:$3A,x                ; $E1E6: 95 3A
        LDA z:$D5,x                ; $E1E8: B5 D5
        AND #$F8                   ; $E1EA: 29 F8
        STA z:$D5,x                ; $E1EC: 95 D5
        RTS                        ; $E1EE: 60
LE1EF:
        LDA #$00                   ; $E1EF: A9 00
        STA z:$3A,x                ; $E1F1: 95 3A
        RTS                        ; $E1F3: 60
LE1F4:
        LDA #$80                   ; $E1F4: A9 80
        STA z:$24,x                ; $E1F6: 95 24
        LDA #$02                   ; $E1F8: A9 02
        STA z:$FF                  ; $E1FA: 85 FF
        RTS                        ; $E1FC: 60
        .byte $02,$08,$0E,$20,$03,$14,$0D,$20,$02,$14,$0E,$20,$02,$09,$0E,$15   ; $E1FD
        .byte $00,$00,$18,$06,$00,$00,$20,$0D,$00,$00,$30,$0D,$00,$00,$08,$08   ; $E20D
        .byte $06,$04,$0A,$08,$03,$0E,$0D,$14,$00,$02,$10,$15,$04,$04,$0C,$1C   ; $E21D
        TXA                        ; $E22D: 8A
        CLC                        ; $E22E: 18
        ADC #$07                   ; $E22F: 69 07
        TAX                        ; $E231: AA
        LDY #$02                   ; $E232: A0 02
        BNE LE23D                  ; $E234: D0 07
        TXA                        ; $E236: 8A
        CLC                        ; $E237: 18
        ADC #$09                   ; $E238: 69 09
        TAX                        ; $E23A: AA
        LDY #$06                   ; $E23B: A0 06
LE23D:
        JSR a:$E29C                ; $E23D: 20 9C E2
        JMP a:$E2DE                ; $E240: 4C DE E2
        LDY #$48                   ; $E243: A0 48
        STY z:$00                  ; $E245: 84 00
        LDY #$44                   ; $E247: A0 44
        JMP a:$E252                ; $E249: 4C 52 E2
        LDY #$08                   ; $E24C: A0 08
        STY z:$00                  ; $E24E: 84 00
        LDY #$04                   ; $E250: A0 04
        LDA z:$87,x                ; $E252: B5 87
        SEC                        ; $E254: 38
        SBC a:$071C                ; $E255: ED 1C 07
        STA z:$01                  ; $E258: 85 01
        LDA z:$6E,x                ; $E25A: B5 6E
        SBC a:$071A                ; $E25C: ED 1A 07
        BMI LE267                  ; $E25F: 30 06
        ORA z:$01                  ; $E261: 05 01
        BEQ LE267                  ; $E263: F0 02
        LDY z:$00                  ; $E265: A4 00
LE267:
        TYA                        ; $E267: 98
        AND a:$03D1                ; $E268: 2D D1 03
        STA a:$03D8,x              ; $E26B: 9D D8 03
        BNE LE289                  ; $E26E: D0 19
        JMP a:$E27C                ; $E270: 4C 7C E2
        INX                        ; $E273: E8
        JSR a:$F1F6                ; $E274: 20 F6 F1
        DEX                        ; $E277: CA
        CMP #$FE                   ; $E278: C9 FE
        BCS LE289                  ; $E27A: B0 0D
        TXA                        ; $E27C: 8A
        CLC                        ; $E27D: 18
        ADC #$01                   ; $E27E: 69 01
        TAX                        ; $E280: AA
        LDY #$01                   ; $E281: A0 01
        JSR a:$E29C                ; $E283: 20 9C E2
        JMP a:$E2DE                ; $E286: 4C DE E2
LE289:
        TXA                        ; $E289: 8A
        ASL a                      ; $E28A: 0A
        ASL a                      ; $E28B: 0A
        TAY                        ; $E28C: A8
        LDA #$FF                   ; $E28D: A9 FF
        STA a:$04B0,y              ; $E28F: 99 B0 04
        STA a:$04B1,y              ; $E292: 99 B1 04
        STA a:$04B2,y              ; $E295: 99 B2 04
        STA a:$04B3,y              ; $E298: 99 B3 04
        RTS                        ; $E29B: 60
        STX z:$00                  ; $E29C: 86 00
        LDA a:$03B8,y              ; $E29E: B9 B8 03
        STA z:$02                  ; $E2A1: 85 02
        LDA a:$03AD,y              ; $E2A3: B9 AD 03
        STA z:$01                  ; $E2A6: 85 01
        TXA                        ; $E2A8: 8A
        ASL a                      ; $E2A9: 0A
        ASL a                      ; $E2AA: 0A
        PHA                        ; $E2AB: 48
        TAY                        ; $E2AC: A8
        LDA a:$0499,x              ; $E2AD: BD 99 04
        ASL a                      ; $E2B0: 0A
        ASL a                      ; $E2B1: 0A
        TAX                        ; $E2B2: AA
        LDA z:$01                  ; $E2B3: A5 01
        CLC                        ; $E2B5: 18
        ADC a:$E1FD,x              ; $E2B6: 7D FD E1
        STA a:$04AC,y              ; $E2B9: 99 AC 04
        LDA z:$01                  ; $E2BC: A5 01
        CLC                        ; $E2BE: 18
        ADC a:$E1FF,x              ; $E2BF: 7D FF E1
        STA a:$04AE,y              ; $E2C2: 99 AE 04
        INX                        ; $E2C5: E8
        INY                        ; $E2C6: C8
        LDA z:$02                  ; $E2C7: A5 02
        CLC                        ; $E2C9: 18
        ADC a:$E1FD,x              ; $E2CA: 7D FD E1
        STA a:$04AC,y              ; $E2CD: 99 AC 04
        LDA z:$02                  ; $E2D0: A5 02
        CLC                        ; $E2D2: 18
        ADC a:$E1FF,x              ; $E2D3: 7D FF E1
        STA a:$04AE,y              ; $E2D6: 99 AE 04
        PLA                        ; $E2D9: 68
        TAY                        ; $E2DA: A8
        LDX z:$00                  ; $E2DB: A6 00
        RTS                        ; $E2DD: 60
        LDA a:$071C                ; $E2DE: AD 1C 07
        CLC                        ; $E2E1: 18
        ADC #$80                   ; $E2E2: 69 80
        STA z:$02                  ; $E2E4: 85 02
        LDA a:$071A                ; $E2E6: AD 1A 07
        ADC #$00                   ; $E2E9: 69 00
        STA z:$01                  ; $E2EB: 85 01
        LDA z:$86,x                ; $E2ED: B5 86
        CMP z:$02                  ; $E2EF: C5 02
        LDA z:$6D,x                ; $E2F1: B5 6D
        SBC z:$01                  ; $E2F3: E5 01
        BCC LE30C                  ; $E2F5: 90 15
        LDA a:$04AE,y              ; $E2F7: B9 AE 04
        BMI LE309                  ; $E2FA: 30 0D
        LDA #$FF                   ; $E2FC: A9 FF
        LDX a:$04AC,y              ; $E2FE: BE AC 04
        BMI LE306                  ; $E301: 30 03
        STA a:$04AC,y              ; $E303: 99 AC 04
LE306:
        STA a:$04AE,y              ; $E306: 99 AE 04
LE309:
        LDX z:$08                  ; $E309: A6 08
        RTS                        ; $E30B: 60
LE30C:
        LDA a:$04AC,y              ; $E30C: B9 AC 04
        BPL LE322                  ; $E30F: 10 11
        CMP #$A0                   ; $E311: C9 A0
        BCC LE322                  ; $E313: 90 0D
        LDA #$00                   ; $E315: A9 00
        LDX a:$04AE,y              ; $E317: BE AE 04
        BPL LE31F                  ; $E31A: 10 03
        STA a:$04AE,y              ; $E31C: 99 AE 04
LE31F:
        STA a:$04AC,y              ; $E31F: 99 AC 04
LE322:
        LDX z:$08                  ; $E322: A6 08
        RTS                        ; $E324: 60
        LDX #$00                   ; $E325: A2 00
        STY z:$06                  ; $E327: 84 06
        LDA #$01                   ; $E329: A9 01
        STA z:$07                  ; $E32B: 85 07
LE32D:
        LDA a:$04AC,y              ; $E32D: B9 AC 04
        CMP a:$04AC,x              ; $E330: DD AC 04
        BCS LE35F                  ; $E333: B0 2A
        CMP a:$04AE,x              ; $E335: DD AE 04
        BCC LE34C                  ; $E338: 90 12
        BEQ LE37E                  ; $E33A: F0 42
        LDA a:$04AE,y              ; $E33C: B9 AE 04
        CMP a:$04AC,y              ; $E33F: D9 AC 04
        BCC LE37E                  ; $E342: 90 3A
        CMP a:$04AC,x              ; $E344: DD AC 04
        BCS LE37E                  ; $E347: B0 35
        LDY z:$06                  ; $E349: A4 06
        RTS                        ; $E34B: 60
LE34C:
        LDA a:$04AE,x              ; $E34C: BD AE 04
        CMP a:$04AC,x              ; $E34F: DD AC 04
        BCC LE37E                  ; $E352: 90 2A
        LDA a:$04AE,y              ; $E354: B9 AE 04
        CMP a:$04AC,x              ; $E357: DD AC 04
        BCS LE37E                  ; $E35A: B0 22
        LDY z:$06                  ; $E35C: A4 06
        RTS                        ; $E35E: 60
LE35F:
        CMP a:$04AC,x              ; $E35F: DD AC 04
        BEQ LE37E                  ; $E362: F0 1A
        CMP a:$04AE,x              ; $E364: DD AE 04
        BCC LE37E                  ; $E367: 90 15
        BEQ LE37E                  ; $E369: F0 13
        CMP a:$04AE,y              ; $E36B: D9 AE 04
        BCC LE37A                  ; $E36E: 90 0A
        BEQ LE37A                  ; $E370: F0 08
        LDA a:$04AE,y              ; $E372: B9 AE 04
        CMP a:$04AC,x              ; $E375: DD AC 04
        BCS LE37E                  ; $E378: B0 04
LE37A:
        CLC                        ; $E37A: 18
        LDY z:$06                  ; $E37B: A4 06
        RTS                        ; $E37D: 60
LE37E:
        INX                        ; $E37E: E8
        INY                        ; $E37F: C8
        DEC z:$07                  ; $E380: C6 07
        BPL LE32D                  ; $E382: 10 A9
        SEC                        ; $E384: 38
        LDY z:$06                  ; $E385: A4 06
        RTS                        ; $E387: 60
        PHA                        ; $E388: 48
        TXA                        ; $E389: 8A
        CLC                        ; $E38A: 18
        ADC #$01                   ; $E38B: 69 01
        TAX                        ; $E38D: AA
        PLA                        ; $E38E: 68
        JMP a:$E3A5                ; $E38F: 4C A5 E3
        .byte $8A,$18,$69,$0D,$AA,$A0,$1B,$4C,$A3,$E3   ; $E392
        LDY #$1A                   ; $E39C: A0 1A
        TXA                        ; $E39E: 8A
        CLC                        ; $E39F: 18
        ADC #$07                   ; $E3A0: 69 07
        TAX                        ; $E3A2: AA
        LDA #$00                   ; $E3A3: A9 00
        JSR a:$E3F0                ; $E3A5: 20 F0 E3
        LDX z:$08                  ; $E3A8: A6 08
        CMP #$00                   ; $E3AA: C9 00
        RTS                        ; $E3AC: 60
        .byte $00,$07,$0E,$08,$03,$0C,$02,$02,$0D,$0D,$08,$03,$0C,$02,$02,$0D   ; $E3AD
        .byte $0D,$08,$03,$0C,$02,$02,$0D,$0D,$08,$00,$10,$04,$14,$04,$04,$04   ; $E3BD
        .byte $20,$20,$08,$18,$08,$18,$02,$20,$20,$08,$18,$08,$18,$12,$20,$20   ; $E3CD
        .byte $18,$18,$18,$18,$18,$14,$14,$06,$06,$08,$10   ; $E3DD
        INY                        ; $E3E8: C8
        LDA #$00                   ; $E3E9: A9 00
        .byte $2C   ; $E3EB
        LDA #$01                   ; $E3EC: A9 01
        LDX #$00                   ; $E3EE: A2 00
        PHA                        ; $E3F0: 48
        STY z:$04                  ; $E3F1: 84 04
        LDA a:$E3B0,y              ; $E3F3: B9 B0 E3
        CLC                        ; $E3F6: 18
        ADC z:$86,x                ; $E3F7: 75 86
        STA z:$05                  ; $E3F9: 85 05
        LDA z:$6D,x                ; $E3FB: B5 6D
        ADC #$00                   ; $E3FD: 69 00
        AND #$01                   ; $E3FF: 29 01
        LSR a                      ; $E401: 4A
        ORA z:$05                  ; $E402: 05 05
        ROR a                      ; $E404: 6A
        LSR a                      ; $E405: 4A
        LSR a                      ; $E406: 4A
        LSR a                      ; $E407: 4A
        JSR a:$9BE1                ; $E408: 20 E1 9B
        LDY z:$04                  ; $E40B: A4 04
        LDA z:$CE,x                ; $E40D: B5 CE
        CLC                        ; $E40F: 18
        ADC a:$E3CC,y              ; $E410: 79 CC E3
        AND #$F0                   ; $E413: 29 F0
        SEC                        ; $E415: 38
        SBC #$20                   ; $E416: E9 20
        STA z:$02                  ; $E418: 85 02
        TAY                        ; $E41A: A8
        LDA ($06),y                ; $E41B: B1 06
        STA z:$03                  ; $E41D: 85 03
        LDY z:$04                  ; $E41F: A4 04
        PLA                        ; $E421: 68
        BNE LE429                  ; $E422: D0 05
        LDA z:$CE,x                ; $E424: B5 CE
        JMP a:$E42B                ; $E426: 4C 2B E4
LE429:
        LDA z:$86,x                ; $E429: B5 86
        AND #$0F                   ; $E42B: 29 0F
        STA z:$04                  ; $E42D: 85 04
        LDA z:$03                  ; $E42F: A5 03
        RTS                        ; $E431: 60
        .byte $FF,$00,$30   ; $E432
        STY z:$00                  ; $E435: 84 00
        LDA a:$03B9                ; $E437: AD B9 03
        CLC                        ; $E43A: 18
        ADC a:$E433,y              ; $E43B: 79 33 E4
        LDX a:$039A,y              ; $E43E: BE 9A 03
        LDY a:$06E5,x              ; $E441: BC E5 06
        STY z:$02                  ; $E444: 84 02
        JSR a:$E4AE                ; $E446: 20 AE E4
        LDA a:$03AE                ; $E449: AD AE 03
        STA a:$0203,y              ; $E44C: 99 03 02
        STA a:$020B,y              ; $E44F: 99 0B 02
        STA a:$0213,y              ; $E452: 99 13 02
        CLC                        ; $E455: 18
        ADC #$06                   ; $E456: 69 06
        STA a:$0207,y              ; $E458: 99 07 02
        STA a:$020F,y              ; $E45B: 99 0F 02
        STA a:$0217,y              ; $E45E: 99 17 02
        LDA #$21                   ; $E461: A9 21
        STA a:$0202,y              ; $E463: 99 02 02
        STA a:$020A,y              ; $E466: 99 0A 02
        STA a:$0212,y              ; $E469: 99 12 02
        ORA #$40                   ; $E46C: 09 40
        STA a:$0206,y              ; $E46E: 99 06 02
        STA a:$020E,y              ; $E471: 99 0E 02
        STA a:$0216,y              ; $E474: 99 16 02
        LDX #$05                   ; $E477: A2 05
LE479:
        LDA #$E1                   ; $E479: A9 E1
        STA a:$0201,y              ; $E47B: 99 01 02
        INY                        ; $E47E: C8
        INY                        ; $E47F: C8
        INY                        ; $E480: C8
        INY                        ; $E481: C8
        DEX                        ; $E482: CA
        BPL LE479                  ; $E483: 10 F4
        LDY z:$02                  ; $E485: A4 02
        LDA z:$00                  ; $E487: A5 00
        BNE LE490                  ; $E489: D0 05
        LDA #$E0                   ; $E48B: A9 E0
        STA a:$0201,y              ; $E48D: 99 01 02
LE490:
        LDX #$00                   ; $E490: A2 00
LE492:
        LDA a:$039D                ; $E492: AD 9D 03
        SEC                        ; $E495: 38
        SBC a:$0200,y              ; $E496: F9 00 02
        CMP #$64                   ; $E499: C9 64
        BCC LE4A2                  ; $E49B: 90 05
        LDA #$F8                   ; $E49D: A9 F8
        STA a:$0200,y              ; $E49F: 99 00 02
LE4A2:
        INY                        ; $E4A2: C8
        INY                        ; $E4A3: C8
        INY                        ; $E4A4: C8
        INY                        ; $E4A5: C8
        INX                        ; $E4A6: E8
        CPX #$06                   ; $E4A7: E0 06
        BNE LE492                  ; $E4A9: D0 E7
        LDY z:$00                  ; $E4AB: A4 00
        RTS                        ; $E4AD: 60
        LDX #$06                   ; $E4AE: A2 06
LE4B0:
        STA a:$0200,y              ; $E4B0: 99 00 02
        CLC                        ; $E4B3: 18
        ADC #$08                   ; $E4B4: 69 08
        INY                        ; $E4B6: C8
        INY                        ; $E4B7: C8
        INY                        ; $E4B8: C8
        INY                        ; $E4B9: C8
        DEX                        ; $E4BA: CA
        BNE LE4B0                  ; $E4BB: D0 F3
        LDY z:$02                  ; $E4BD: A4 02
        RTS                        ; $E4BF: 60
        .byte $04,$00,$04,$00,$00,$04,$00,$04,$00,$08,$00,$08,$08,$00,$08,$00   ; $E4C0
        .byte $80,$82,$81,$83,$81,$83,$80,$82,$03,$03,$C3,$C3   ; $E4D0
        LDY a:$06F3,x              ; $E4DC: BC F3 06
        LDA a:$0747                ; $E4DF: AD 47 07
        BNE LE4EC                  ; $E4E2: D0 08
        LDA z:$2A,x                ; $E4E4: B5 2A
        AND #$7F                   ; $E4E6: 29 7F
        CMP #$01                   ; $E4E8: C9 01
        BEQ LE4F0                  ; $E4EA: F0 04
LE4EC:
        LDX #$00                   ; $E4EC: A2 00
        BEQ LE4F7                  ; $E4EE: F0 07
LE4F0:
        LDA z:$09                  ; $E4F0: A5 09
        LSR a                      ; $E4F2: 4A
        LSR a                      ; $E4F3: 4A
        AND #$03                   ; $E4F4: 29 03
        TAX                        ; $E4F6: AA
LE4F7:
        LDA a:$03BE                ; $E4F7: AD BE 03
        CLC                        ; $E4FA: 18
        ADC a:$E4C4,x              ; $E4FB: 7D C4 E4
        STA a:$0200,y              ; $E4FE: 99 00 02
        CLC                        ; $E501: 18
        ADC a:$E4CC,x              ; $E502: 7D CC E4
        STA a:$0204,y              ; $E505: 99 04 02
        LDA a:$03B3                ; $E508: AD B3 03
        CLC                        ; $E50B: 18
        ADC a:$E4C0,x              ; $E50C: 7D C0 E4
        STA a:$0203,y              ; $E50F: 99 03 02
        CLC                        ; $E512: 18
        ADC a:$E4C8,x              ; $E513: 7D C8 E4
        STA a:$0207,y              ; $E516: 99 07 02
        LDA a:$E4D0,x              ; $E519: BD D0 E4
        STA a:$0201,y              ; $E51C: 99 01 02
        LDA a:$E4D4,x              ; $E51F: BD D4 E4
        STA a:$0205,y              ; $E522: 99 05 02
        LDA a:$E4D8,x              ; $E525: BD D8 E4
        STA a:$0202,y              ; $E528: 99 02 02
        STA a:$0206,y              ; $E52B: 99 06 02
        LDX z:$08                  ; $E52E: A6 08
        LDA a:$03D6                ; $E530: AD D6 03
        AND #$FC                   ; $E533: 29 FC
        BEQ LE540                  ; $E535: F0 09
        LDA #$00                   ; $E537: A9 00
        STA z:$2A,x                ; $E539: 95 2A
        LDA #$F8                   ; $E53B: A9 F8
        JSR a:$E5C1                ; $E53D: 20 C1 E5
LE540:
        RTS                        ; $E540: 60
        .byte $F9,$50,$F7,$50,$FA,$FB,$F8,$FB,$F6,$FB   ; $E541
        LDY a:$06E5,x              ; $E54B: BC E5 06
        LDA a:$03AE                ; $E54E: AD AE 03
        STA a:$0203,y              ; $E551: 99 03 02
        CLC                        ; $E554: 18
        ADC #$08                   ; $E555: 69 08
        STA a:$0207,y              ; $E557: 99 07 02
        STA a:$020B,y              ; $E55A: 99 0B 02
        CLC                        ; $E55D: 18
        ADC #$0C                   ; $E55E: 69 0C
        STA z:$05                  ; $E560: 85 05
        LDA z:$CF,x                ; $E562: B5 CF
        JSR a:$E5C1                ; $E564: 20 C1 E5
        ADC #$08                   ; $E567: 69 08
        STA a:$0208,y              ; $E569: 99 08 02
        LDA a:$010D                ; $E56C: AD 0D 01
        STA z:$02                  ; $E56F: 85 02
        LDA #$01                   ; $E571: A9 01
        STA z:$03                  ; $E573: 85 03
        STA z:$04                  ; $E575: 85 04
        STA a:$0202,y              ; $E577: 99 02 02
        STA a:$0206,y              ; $E57A: 99 06 02
        STA a:$020A,y              ; $E57D: 99 0A 02
        LDA #$7E                   ; $E580: A9 7E
        STA a:$0201,y              ; $E582: 99 01 02
        STA a:$0209,y              ; $E585: 99 09 02
        LDA #$7F                   ; $E588: A9 7F
        STA a:$0205,y              ; $E58A: 99 05 02
        LDA a:$070F                ; $E58D: AD 0F 07
        BEQ LE5A7                  ; $E590: F0 15
        TYA                        ; $E592: 98
        CLC                        ; $E593: 18
        ADC #$0C                   ; $E594: 69 0C
        TAY                        ; $E596: A8
        LDA a:$010F                ; $E597: AD 0F 01
        ASL a                      ; $E59A: 0A
        TAX                        ; $E59B: AA
        LDA a:$E541,x              ; $E59C: BD 41 E5
        STA z:$00                  ; $E59F: 85 00
        LDA a:$E542,x              ; $E5A1: BD 42 E5
        JSR a:$EBB2                ; $E5A4: 20 B2 EB
LE5A7:
        LDX z:$08                  ; $E5A7: A6 08
        LDY a:$06E5,x              ; $E5A9: BC E5 06
        LDA a:$03D1                ; $E5AC: AD D1 03
        AND #$0E                   ; $E5AF: 29 0E
        BEQ LE5C7                  ; $E5B1: F0 14
        LDA #$F8                   ; $E5B3: A9 F8
        STA a:$0214,y              ; $E5B5: 99 14 02
        STA a:$0210,y              ; $E5B8: 99 10 02
        STA a:$020C,y              ; $E5BB: 99 0C 02
        STA a:$0208,y              ; $E5BE: 99 08 02
        STA a:$0204,y              ; $E5C1: 99 04 02
        STA a:$0200,y              ; $E5C4: 99 00 02
LE5C7:
        RTS                        ; $E5C7: 60
        LDY a:$06E5,x              ; $E5C8: BC E5 06
        STY z:$02                  ; $E5CB: 84 02
        INY                        ; $E5CD: C8
        INY                        ; $E5CE: C8
        INY                        ; $E5CF: C8
        LDA a:$03AE                ; $E5D0: AD AE 03
        JSR a:$E4AE                ; $E5D3: 20 AE E4
        LDX z:$08                  ; $E5D6: A6 08
        LDA z:$CF,x                ; $E5D8: B5 CF
        JSR a:$E5BB                ; $E5DA: 20 BB E5
        LDY a:$074E                ; $E5DD: AC 4E 07
        CPY #$03                   ; $E5E0: C0 03
        BEQ LE5E9                  ; $E5E2: F0 05
        LDY a:$06CC                ; $E5E4: AC CC 06
        BEQ LE5EB                  ; $E5E7: F0 02
LE5E9:
        LDA #$F8                   ; $E5E9: A9 F8
LE5EB:
        LDY a:$06E5,x              ; $E5EB: BC E5 06
        STA a:$0210,y              ; $E5EE: 99 10 02
        STA a:$0214,y              ; $E5F1: 99 14 02
        LDA #$5B                   ; $E5F4: A9 5B
        LDX a:$0743                ; $E5F6: AE 43 07
        BEQ LE5FD                  ; $E5F9: F0 02
        LDA #$75                   ; $E5FB: A9 75
LE5FD:
        LDX z:$08                  ; $E5FD: A6 08
        INY                        ; $E5FF: C8
        JSR a:$E5B5                ; $E600: 20 B5 E5
        LDA #$02                   ; $E603: A9 02
        INY                        ; $E605: C8
        JSR a:$E5B5                ; $E606: 20 B5 E5
        INX                        ; $E609: E8
        JSR a:$F1F6                ; $E60A: 20 F6 F1
        DEX                        ; $E60D: CA
        LDY a:$06E5,x              ; $E60E: BC E5 06
        ASL a                      ; $E611: 0A
        PHA                        ; $E612: 48
        BCC LE61A                  ; $E613: 90 05
        LDA #$F8                   ; $E615: A9 F8
        STA a:$0200,y              ; $E617: 99 00 02
LE61A:
        PLA                        ; $E61A: 68
        ASL a                      ; $E61B: 0A
        PHA                        ; $E61C: 48
        BCC LE624                  ; $E61D: 90 05
        LDA #$F8                   ; $E61F: A9 F8
        STA a:$0204,y              ; $E621: 99 04 02
LE624:
        PLA                        ; $E624: 68
        ASL a                      ; $E625: 0A
        PHA                        ; $E626: 48
        BCC LE62E                  ; $E627: 90 05
        LDA #$F8                   ; $E629: A9 F8
        STA a:$0208,y              ; $E62B: 99 08 02
LE62E:
        PLA                        ; $E62E: 68
        ASL a                      ; $E62F: 0A
        PHA                        ; $E630: 48
        BCC LE638                  ; $E631: 90 05
        LDA #$F8                   ; $E633: A9 F8
        STA a:$020C,y              ; $E635: 99 0C 02
LE638:
        PLA                        ; $E638: 68
        ASL a                      ; $E639: 0A
        PHA                        ; $E63A: 48
        BCC LE642                  ; $E63B: 90 05
        LDA #$F8                   ; $E63D: A9 F8
        STA a:$0210,y              ; $E63F: 99 10 02
LE642:
        PLA                        ; $E642: 68
        ASL a                      ; $E643: 0A
        BCC LE64B                  ; $E644: 90 05
        LDA #$F8                   ; $E646: A9 F8
        STA a:$0214,y              ; $E648: 99 14 02
LE64B:
        LDA a:$03D1                ; $E64B: AD D1 03
        ASL a                      ; $E64E: 0A
        BCC LE654                  ; $E64F: 90 03
        JSR a:$E5B3                ; $E651: 20 B3 E5
LE654:
        RTS                        ; $E654: 60
LE655:
        LDA z:$09                  ; $E655: A5 09
        LSR a                      ; $E657: 4A
        BCS LE65C                  ; $E658: B0 02
        DEC z:$DB,x                ; $E65A: D6 DB
LE65C:
        LDA z:$DB,x                ; $E65C: B5 DB
        JSR a:$E5C1                ; $E65E: 20 C1 E5
        LDA a:$03B3                ; $E661: AD B3 03
        STA a:$0203,y              ; $E664: 99 03 02
        CLC                        ; $E667: 18
        ADC #$08                   ; $E668: 69 08
        STA a:$0207,y              ; $E66A: 99 07 02
        LDA #$02                   ; $E66D: A9 02
        STA a:$0202,y              ; $E66F: 99 02 02
        STA a:$0206,y              ; $E672: 99 06 02
        LDA #$F7                   ; $E675: A9 F7
        STA a:$0201,y              ; $E677: 99 01 02
        LDA #$FB                   ; $E67A: A9 FB
        STA a:$0205,y              ; $E67C: 99 05 02
        JMP a:$E6BD                ; $E67F: 4C BD E6
        .byte $60,$61,$62,$63   ; $E682
        LDY a:$06F3,x              ; $E686: BC F3 06
        LDA z:$2A,x                ; $E689: B5 2A
        CMP #$02                   ; $E68B: C9 02
        BCS LE655                  ; $E68D: B0 C6
        LDA z:$DB,x                ; $E68F: B5 DB
        STA a:$0200,y              ; $E691: 99 00 02
        CLC                        ; $E694: 18
        ADC #$08                   ; $E695: 69 08
        STA a:$0204,y              ; $E697: 99 04 02
        LDA a:$03B3                ; $E69A: AD B3 03
        STA a:$0203,y              ; $E69D: 99 03 02
        STA a:$0207,y              ; $E6A0: 99 07 02
        LDA z:$09                  ; $E6A3: A5 09
        LSR a                      ; $E6A5: 4A
        AND #$03                   ; $E6A6: 29 03
        TAX                        ; $E6A8: AA
        LDA a:$E682,x              ; $E6A9: BD 82 E6
        INY                        ; $E6AC: C8
        JSR a:$E5C1                ; $E6AD: 20 C1 E5
        DEY                        ; $E6B0: 88
        LDA #$02                   ; $E6B1: A9 02
        STA a:$0202,y              ; $E6B3: 99 02 02
        LDA #$82                   ; $E6B6: A9 82
        STA a:$0206,y              ; $E6B8: 99 06 02
        LDX z:$08                  ; $E6BB: A6 08
        RTS                        ; $E6BD: 60
        .byte $76,$77,$78,$79,$D6,$D6,$D9,$D9,$8D,$8D,$E4,$E4,$76,$77,$78,$79   ; $E6BE
        .byte $02,$01,$02,$01   ; $E6CE
        LDY a:$06EA                ; $E6D2: AC EA 06
        LDA a:$03B9                ; $E6D5: AD B9 03
        CLC                        ; $E6D8: 18
        ADC #$08                   ; $E6D9: 69 08
        STA z:$02                  ; $E6DB: 85 02
        LDA a:$03AE                ; $E6DD: AD AE 03
        STA z:$05                  ; $E6E0: 85 05
        LDX z:$39                  ; $E6E2: A6 39
        LDA a:$E6CE,x              ; $E6E4: BD CE E6
        ORA a:$03CA                ; $E6E7: 0D CA 03
        STA z:$04                  ; $E6EA: 85 04
        TXA                        ; $E6EC: 8A
        PHA                        ; $E6ED: 48
        ASL a                      ; $E6EE: 0A
        ASL a                      ; $E6EF: 0A
        TAX                        ; $E6F0: AA
        LDA #$01                   ; $E6F1: A9 01
        STA z:$07                  ; $E6F3: 85 07
        STA z:$03                  ; $E6F5: 85 03
LE6F7:
        LDA a:$E6BE,x              ; $E6F7: BD BE E6
        STA z:$00                  ; $E6FA: 85 00
        LDA a:$E6BF,x              ; $E6FC: BD BF E6
        JSR a:$EBB2                ; $E6FF: 20 B2 EB
        DEC z:$07                  ; $E702: C6 07
        BPL LE6F7                  ; $E704: 10 F1
        LDY a:$06EA                ; $E706: AC EA 06
        PLA                        ; $E709: 68
        BEQ LE73B                  ; $E70A: F0 2F
        CMP #$03                   ; $E70C: C9 03
        BEQ LE73B                  ; $E70E: F0 2B
        STA z:$00                  ; $E710: 85 00
        LDA z:$09                  ; $E712: A5 09
        LSR a                      ; $E714: 4A
        AND #$03                   ; $E715: 29 03
        ORA a:$03CA                ; $E717: 0D CA 03
        STA a:$0202,y              ; $E71A: 99 02 02
        STA a:$0206,y              ; $E71D: 99 06 02
        LDX z:$00                  ; $E720: A6 00
        DEX                        ; $E722: CA
        BEQ LE72B                  ; $E723: F0 06
        STA a:$020A,y              ; $E725: 99 0A 02
        STA a:$020E,y              ; $E728: 99 0E 02
LE72B:
        LDA a:$0206,y              ; $E72B: B9 06 02
        ORA #$40                   ; $E72E: 09 40
        STA a:$0206,y              ; $E730: 99 06 02
        LDA a:$020E,y              ; $E733: B9 0E 02
        ORA #$40                   ; $E736: 09 40
        STA a:$020E,y              ; $E738: 99 0E 02
LE73B:
        JMP a:$EB64                ; $E73B: 4C 64 EB
        .byte $FC,$FC,$AA,$AB,$AC,$AD,$FC,$FC,$AE,$AF,$B0,$B1,$FC,$A5,$A6,$A7   ; $E73E
        .byte $A8,$A9,$FC,$A0,$A1,$A2,$A3,$A4,$69,$A5,$6A,$A7,$A8,$A9,$6B,$A0   ; $E74E
        .byte $6C,$A2,$A3,$A4,$FC,$FC,$96,$97,$98,$99,$FC,$FC,$9A,$9B,$9C,$9D   ; $E75E
        .byte $FC,$FC,$8F,$8E,$8E,$8F,$FC,$FC,$95,$94,$94,$95,$FC,$FC,$DC,$DC   ; $E76E
        .byte $DF,$DF,$DC,$DC,$DD,$DD,$DE,$DE,$FC,$FC,$B2,$B3,$B4,$B5,$FC,$FC   ; $E77E
        .byte $B6,$B3,$B7,$B5,$FC,$FC,$70,$71,$72,$73,$FC,$FC,$6E,$6E,$6F,$6F   ; $E78E
        .byte $FC,$FC,$6D,$6D,$6F,$6F,$FC,$FC,$6F,$6F,$6E,$6E,$FC,$FC,$6F,$6F   ; $E79E
        .byte $6D,$6D,$FC,$FC,$F4,$F4,$F5,$F5,$FC,$FC,$F4,$F4,$F5,$F5,$FC,$FC   ; $E7AE
        .byte $F5,$F5,$F4,$F4,$FC,$FC,$F5,$F5,$F4,$F4,$FC,$FC,$FC,$FC,$EF,$EF   ; $E7BE
        .byte $B9,$B8,$BB,$BA,$BC,$BC,$FC,$FC,$BD,$BD,$BC,$BC,$7A,$7B,$DA,$DB   ; $E7CE
        .byte $D8,$D8,$CD,$CD,$CE,$CE,$CF,$CF,$7D,$7C,$D1,$8C,$D3,$D2,$7D,$7C   ; $E7DE
        .byte $89,$88,$8B,$8A,$D5,$D4,$E3,$E2,$D3,$D2,$D5,$D4,$E3,$E2,$8B,$8A   ; $E7EE
        .byte $E5,$E5,$E6,$E6,$EB,$EB,$EC,$EC,$ED   ; $E7FE
        SBC a:$EEEE                ; $E807: ED EE EE
        .byte $FC,$FC,$D0,$D0,$D7,$D7,$BF,$BE,$C1,$C0,$C2,$FC,$C4,$C3,$C6,$C5   ; $E80A
        .byte $C8,$C7,$BF,$BE,$CA,$C9,$C2,$FC,$C4,$C3,$C6,$C5,$CC,$CB,$FC,$FC   ; $E81A
        .byte $E8,$E7,$EA,$E9,$F2,$F2,$F3,$F3,$F2,$F2,$F1,$F1,$F1,$F1,$FC,$FC   ; $E82A
        .byte $F0,$F0,$FC,$FC,$FC,$FC,$0C,$0C,$00,$0C,$0C,$A8,$54,$3C,$EA,$18   ; $E83A
        .byte $48,$48,$CC,$C0,$18,$18,$18,$90,$24,$FF,$48,$9C,$D2,$D8,$F0,$F6   ; $E84A
        .byte $FC,$01,$02,$03,$02,$01,$01,$03,$03,$03,$01,$01,$02,$02,$21,$01   ; $E85A
        .byte $02,$01,$01,$02,$FF,$02,$02,$01,$01,$02,$02,$02,$08,$18,$18,$19   ; $E86A
        .byte $1A,$19,$18   ; $E87A
        LDA z:$CF,x                ; $E87D: B5 CF
        STA z:$02                  ; $E87F: 85 02
        LDA a:$03AE                ; $E881: AD AE 03
        STA z:$05                  ; $E884: 85 05
        LDY a:$06E5,x              ; $E886: BC E5 06
        STY z:$EB                  ; $E889: 84 EB
        LDA #$00                   ; $E88B: A9 00
        STA a:$0109                ; $E88D: 8D 09 01
        LDA z:$46,x                ; $E890: B5 46
        STA z:$03                  ; $E892: 85 03
        LDA a:$03C5,x              ; $E894: BD C5 03
        STA z:$04                  ; $E897: 85 04
        LDA z:$16,x                ; $E899: B5 16
        CMP #$0D                   ; $E89B: C9 0D
        BNE LE8A9                  ; $E89D: D0 0A
        LDY z:$58,x                ; $E89F: B4 58
        BMI LE8A9                  ; $E8A1: 30 06
        LDY a:$078A,x              ; $E8A3: BC 8A 07
        BEQ LE8A9                  ; $E8A6: F0 01
        RTS                        ; $E8A8: 60
LE8A9:
        LDA z:$1E,x                ; $E8A9: B5 1E
        STA z:$ED                  ; $E8AB: 85 ED
        AND #$1F                   ; $E8AD: 29 1F
        TAY                        ; $E8AF: A8
        LDA z:$16,x                ; $E8B0: B5 16
        CMP #$35                   ; $E8B2: C9 35
        BNE LE8BE                  ; $E8B4: D0 08
        LDY #$00                   ; $E8B6: A0 00
        LDA #$01                   ; $E8B8: A9 01
        STA z:$03                  ; $E8BA: 85 03
        LDA #$15                   ; $E8BC: A9 15
LE8BE:
        CMP #$33                   ; $E8BE: C9 33
        BNE LE8D5                  ; $E8C0: D0 13
        DEC z:$02                  ; $E8C2: C6 02
        LDA #$03                   ; $E8C4: A9 03
        LDY a:$078A,x              ; $E8C6: BC 8A 07
        BEQ LE8CD                  ; $E8C9: F0 02
        ORA #$20                   ; $E8CB: 09 20
LE8CD:
        STA z:$04                  ; $E8CD: 85 04
        LDY #$00                   ; $E8CF: A0 00
        STY z:$ED                  ; $E8D1: 84 ED
        LDA #$08                   ; $E8D3: A9 08
LE8D5:
        CMP #$32                   ; $E8D5: C9 32
        BNE LE8E1                  ; $E8D7: D0 08
        LDY #$03                   ; $E8D9: A0 03
        LDX a:$070E                ; $E8DB: AE 0E 07
        LDA a:$E878,x              ; $E8DE: BD 78 E8
LE8E1:
        STA z:$EF                  ; $E8E1: 85 EF
        STY z:$EC                  ; $E8E3: 84 EC
        LDX z:$08                  ; $E8E5: A6 08
        CMP #$0C                   ; $E8E7: C9 0C
        BNE LE8F2                  ; $E8E9: D0 07
        LDA z:$A0,x                ; $E8EB: B5 A0
        BMI LE8F2                  ; $E8ED: 30 03
        INC a:$0109                ; $E8EF: EE 09 01
LE8F2:
        LDA a:$036A                ; $E8F2: AD 6A 03
        BEQ LE900                  ; $E8F5: F0 09
        LDY #$16                   ; $E8F7: A0 16
        CMP #$01                   ; $E8F9: C9 01
        BEQ LE8FE                  ; $E8FB: F0 01
        INY                        ; $E8FD: C8
LE8FE:
        STY z:$EF                  ; $E8FE: 84 EF
LE900:
        LDY z:$EF                  ; $E900: A4 EF
        CPY #$06                   ; $E902: C0 06
        BNE LE923                  ; $E904: D0 1D
        LDA z:$1E,x                ; $E906: B5 1E
        CMP #$02                   ; $E908: C9 02
        BCC LE910                  ; $E90A: 90 04
        LDX #$04                   ; $E90C: A2 04
        STX z:$EC                  ; $E90E: 86 EC
LE910:
        AND #$20                   ; $E910: 29 20
        ORA a:$0747                ; $E912: 0D 47 07
        BNE LE923                  ; $E915: D0 0C
        LDA z:$09                  ; $E917: A5 09
        AND #$08                   ; $E919: 29 08
        BNE LE923                  ; $E91B: D0 06
        LDA z:$03                  ; $E91D: A5 03
        EOR #$03                   ; $E91F: 49 03
        STA z:$03                  ; $E921: 85 03
LE923:
        LDA a:$E85B,y              ; $E923: B9 5B E8
        ORA z:$04                  ; $E926: 05 04
        STA z:$04                  ; $E928: 85 04
        LDA a:$E840,y              ; $E92A: B9 40 E8
        TAX                        ; $E92D: AA
        LDY z:$EC                  ; $E92E: A4 EC
        LDA a:$036A                ; $E930: AD 6A 03
        BEQ LE965                  ; $E933: F0 30
        CMP #$01                   ; $E935: C9 01
        BNE LE94C                  ; $E937: D0 13
        LDA a:$0363                ; $E939: AD 63 03
        BPL LE940                  ; $E93C: 10 02
        LDX #$DE                   ; $E93E: A2 DE
LE940:
        LDA z:$ED                  ; $E940: A5 ED
        AND #$20                   ; $E942: 29 20
        BEQ LE949                  ; $E944: F0 03
        STX a:$0109                ; $E946: 8E 09 01
LE949:
        JMP a:$EA4B                ; $E949: 4C 4B EA
LE94C:
        LDA a:$0363                ; $E94C: AD 63 03
        AND #$01                   ; $E94F: 29 01
        BEQ LE955                  ; $E951: F0 02
        LDX #$E4                   ; $E953: A2 E4
LE955:
        LDA z:$ED                  ; $E955: A5 ED
        AND #$20                   ; $E957: 29 20
        BEQ LE949                  ; $E959: F0 EE
        LDA z:$02                  ; $E95B: A5 02
        SEC                        ; $E95D: 38
        SBC #$10                   ; $E95E: E9 10
        STA z:$02                  ; $E960: 85 02
        JMP a:$E946                ; $E962: 4C 46 E9
LE965:
        CPX #$24                   ; $E965: E0 24
        BNE LE97A                  ; $E967: D0 11
        CPY #$05                   ; $E969: C0 05
        BNE LE977                  ; $E96B: D0 0A
        LDX #$30                   ; $E96D: A2 30
        LDA #$02                   ; $E96F: A9 02
        STA z:$03                  ; $E971: 85 03
        LDA #$05                   ; $E973: A9 05
        STA z:$EC                  ; $E975: 85 EC
LE977:
        JMP a:$E9CA                ; $E977: 4C CA E9
LE97A:
        CPX #$90                   ; $E97A: E0 90
        BNE LE990                  ; $E97C: D0 12
        LDA z:$ED                  ; $E97E: A5 ED
        AND #$20                   ; $E980: 29 20
        BNE LE98D                  ; $E982: D0 09
        LDA a:$078F                ; $E984: AD 8F 07
        CMP #$10                   ; $E987: C9 10
        BCS LE98D                  ; $E989: B0 02
        LDX #$96                   ; $E98B: A2 96
LE98D:
        JMP a:$EA37                ; $E98D: 4C 37 EA
LE990:
        LDA z:$EF                  ; $E990: A5 EF
        CMP #$04                   ; $E992: C9 04
        BCS LE9A6                  ; $E994: B0 10
        CPY #$02                   ; $E996: C0 02
        BCC LE9A6                  ; $E998: 90 0C
        LDX #$5A                   ; $E99A: A2 5A
        LDY z:$EF                  ; $E99C: A4 EF
        CPY #$02                   ; $E99E: C0 02
        BNE LE9A6                  ; $E9A0: D0 04
        LDX #$7E                   ; $E9A2: A2 7E
        INC z:$02                  ; $E9A4: E6 02
LE9A6:
        LDA z:$EC                  ; $E9A6: A5 EC
        CMP #$04                   ; $E9A8: C9 04
        BNE LE9CA                  ; $E9AA: D0 1E
        LDX #$72                   ; $E9AC: A2 72
        INC z:$02                  ; $E9AE: E6 02
        LDY z:$EF                  ; $E9B0: A4 EF
        CPY #$02                   ; $E9B2: C0 02
        BEQ LE9BA                  ; $E9B4: F0 04
        LDX #$66                   ; $E9B6: A2 66
        INC z:$02                  ; $E9B8: E6 02
LE9BA:
        CPY #$06                   ; $E9BA: C0 06
        BNE LE9CA                  ; $E9BC: D0 0C
        LDX #$54                   ; $E9BE: A2 54
        LDA z:$ED                  ; $E9C0: A5 ED
        AND #$20                   ; $E9C2: 29 20
        BNE LE9CA                  ; $E9C4: D0 04
        LDX #$8A                   ; $E9C6: A2 8A
        DEC z:$02                  ; $E9C8: C6 02
LE9CA:
        LDY z:$08                  ; $E9CA: A4 08
        LDA z:$EF                  ; $E9CC: A5 EF
        CMP #$05                   ; $E9CE: C9 05
        BNE LE9DE                  ; $E9D0: D0 0C
        LDA z:$ED                  ; $E9D2: A5 ED
        BEQ LE9FA                  ; $E9D4: F0 24
        AND #$08                   ; $E9D6: 29 08
        BEQ LEA37                  ; $E9D8: F0 5D
        LDX #$B4                   ; $E9DA: A2 B4
        BNE LE9FA                  ; $E9DC: D0 1C
LE9DE:
        CPX #$48                   ; $E9DE: E0 48
        BEQ LE9FA                  ; $E9E0: F0 18
        LDA a:$0796,y              ; $E9E2: B9 96 07
        CMP #$05                   ; $E9E5: C9 05
        BCS LEA37                  ; $E9E7: B0 4E
        CPX #$3C                   ; $E9E9: E0 3C
        BNE LE9FA                  ; $E9EB: D0 0D
        CMP #$01                   ; $E9ED: C9 01
        BEQ LEA37                  ; $E9EF: F0 46
        INC z:$02                  ; $E9F1: E6 02
        INC z:$02                  ; $E9F3: E6 02
        INC z:$02                  ; $E9F5: E6 02
        JMP a:$EA29                ; $E9F7: 4C 29 EA
LE9FA:
        LDA z:$EF                  ; $E9FA: A5 EF
        CMP #$06                   ; $E9FC: C9 06
        BEQ LEA37                  ; $E9FE: F0 37
        CMP #$08                   ; $EA00: C9 08
        BEQ LEA37                  ; $EA02: F0 33
        CMP #$0C                   ; $EA04: C9 0C
        BEQ LEA37                  ; $EA06: F0 2F
        CMP #$18                   ; $EA08: C9 18
        BCS LEA37                  ; $EA0A: B0 2B
        LDY #$00                   ; $EA0C: A0 00
        CMP #$15                   ; $EA0E: C9 15
        BNE LEA22                  ; $EA10: D0 10
        INY                        ; $EA12: C8
        LDA a:$075F                ; $EA13: AD 5F 07
        CMP #$07                   ; $EA16: C9 07
        BCS LEA37                  ; $EA18: B0 1D
        LDX #$A2                   ; $EA1A: A2 A2
        LDA #$03                   ; $EA1C: A9 03
        STA z:$EC                  ; $EA1E: 85 EC
        BNE LEA37                  ; $EA20: D0 15
LEA22:
        LDA z:$09                  ; $EA22: A5 09
        AND a:$E876,y              ; $EA24: 39 76 E8
        BNE LEA37                  ; $EA27: D0 0E
        LDA z:$ED                  ; $EA29: A5 ED
        AND #$A0                   ; $EA2B: 29 A0
        ORA a:$0747                ; $EA2D: 0D 47 07
        BNE LEA37                  ; $EA30: D0 05
        TXA                        ; $EA32: 8A
        CLC                        ; $EA33: 18
        ADC #$06                   ; $EA34: 69 06
        TAX                        ; $EA36: AA
LEA37:
        LDA z:$ED                  ; $EA37: A5 ED
        AND #$20                   ; $EA39: 29 20
        BEQ LEA4B                  ; $EA3B: F0 0E
        LDA z:$EF                  ; $EA3D: A5 EF
        CMP #$04                   ; $EA3F: C9 04
        BCC LEA4B                  ; $EA41: 90 08
        LDY #$01                   ; $EA43: A0 01
        STY a:$0109                ; $EA45: 8C 09 01
        DEY                        ; $EA48: 88
        STY z:$EC                  ; $EA49: 84 EC
LEA4B:
        LDY z:$EB                  ; $EA4B: A4 EB
        JSR a:$EBAA                ; $EA4D: 20 AA EB
        JSR a:$EBAA                ; $EA50: 20 AA EB
        JSR a:$EBAA                ; $EA53: 20 AA EB
        LDX z:$08                  ; $EA56: A6 08
        LDY a:$06E5,x              ; $EA58: BC E5 06
        LDA z:$EF                  ; $EA5B: A5 EF
        CMP #$08                   ; $EA5D: C9 08
        BNE LEA64                  ; $EA5F: D0 03
LEA61:
        JMP a:$EB64                ; $EA61: 4C 64 EB
LEA64:
        LDA a:$0109                ; $EA64: AD 09 01
        BEQ LEAA6                  ; $EA67: F0 3D
        LDA a:$0202,y              ; $EA69: B9 02 02
        ORA #$80                   ; $EA6C: 09 80
        INY                        ; $EA6E: C8
        INY                        ; $EA6F: C8
        JSR a:$E5B5                ; $EA70: 20 B5 E5
        DEY                        ; $EA73: 88
        DEY                        ; $EA74: 88
        TYA                        ; $EA75: 98
        TAX                        ; $EA76: AA
        LDA z:$EF                  ; $EA77: A5 EF
        CMP #$05                   ; $EA79: C9 05
        BEQ LEA8A                  ; $EA7B: F0 0D
        CMP #$11                   ; $EA7D: C9 11
        BEQ LEA8A                  ; $EA7F: F0 09
        CMP #$15                   ; $EA81: C9 15
        BCS LEA8A                  ; $EA83: B0 05
        TXA                        ; $EA85: 8A
        CLC                        ; $EA86: 18
        ADC #$08                   ; $EA87: 69 08
        TAX                        ; $EA89: AA
LEA8A:
        LDA a:$0201,x              ; $EA8A: BD 01 02
        PHA                        ; $EA8D: 48
        LDA a:$0205,x              ; $EA8E: BD 05 02
        PHA                        ; $EA91: 48
        LDA a:$0211,y              ; $EA92: B9 11 02
        STA a:$0201,x              ; $EA95: 9D 01 02
        LDA a:$0215,y              ; $EA98: B9 15 02
        STA a:$0205,x              ; $EA9B: 9D 05 02
        PLA                        ; $EA9E: 68
        STA a:$0215,y              ; $EA9F: 99 15 02
        PLA                        ; $EAA2: 68
        STA a:$0211,y              ; $EAA3: 99 11 02
LEAA6:
        LDA a:$036A                ; $EAA6: AD 6A 03
        BNE LEA61                  ; $EAA9: D0 B6
        LDA z:$EF                  ; $EAAB: A5 EF
        LDX z:$EC                  ; $EAAD: A6 EC
        CMP #$05                   ; $EAAF: C9 05
        BNE LEAB6                  ; $EAB1: D0 03
        JMP a:$EB64                ; $EAB3: 4C 64 EB
LEAB6:
        CMP #$07                   ; $EAB6: C9 07
        BEQ LEAD7                  ; $EAB8: F0 1D
        CMP #$0D                   ; $EABA: C9 0D
        BEQ LEAD7                  ; $EABC: F0 19
        CMP #$0C                   ; $EABE: C9 0C
        BEQ LEAD7                  ; $EAC0: F0 15
        CMP #$12                   ; $EAC2: C9 12
        BNE LEACA                  ; $EAC4: D0 04
        CPX #$05                   ; $EAC6: E0 05
        BNE LEB12                  ; $EAC8: D0 48
LEACA:
        CMP #$15                   ; $EACA: C9 15
        BNE LEAD3                  ; $EACC: D0 05
        LDA #$42                   ; $EACE: A9 42
        STA a:$0216,y              ; $EAD0: 99 16 02
LEAD3:
        CPX #$02                   ; $EAD3: E0 02
        BCC LEB12                  ; $EAD5: 90 3B
LEAD7:
        LDA a:$036A                ; $EAD7: AD 6A 03
        BNE LEB12                  ; $EADA: D0 36
        LDA a:$0202,y              ; $EADC: B9 02 02
        AND #$A3                   ; $EADF: 29 A3
        STA a:$0202,y              ; $EAE1: 99 02 02
        STA a:$020A,y              ; $EAE4: 99 0A 02
        STA a:$0212,y              ; $EAE7: 99 12 02
        ORA #$40                   ; $EAEA: 09 40
        CPX #$05                   ; $EAEC: E0 05
        BNE LEAF2                  ; $EAEE: D0 02
        ORA #$80                   ; $EAF0: 09 80
LEAF2:
        STA a:$0206,y              ; $EAF2: 99 06 02
        STA a:$020E,y              ; $EAF5: 99 0E 02
        STA a:$0216,y              ; $EAF8: 99 16 02
        CPX #$04                   ; $EAFB: E0 04
        BNE LEB12                  ; $EAFD: D0 13
        LDA a:$020A,y              ; $EAFF: B9 0A 02
        ORA #$80                   ; $EB02: 09 80
        STA a:$020A,y              ; $EB04: 99 0A 02
        STA a:$0212,y              ; $EB07: 99 12 02
        ORA #$40                   ; $EB0A: 09 40
        STA a:$020E,y              ; $EB0C: 99 0E 02
        STA a:$0216,y              ; $EB0F: 99 16 02
LEB12:
        LDA z:$EF                  ; $EB12: A5 EF
        CMP #$11                   ; $EB14: C9 11
        BNE LEB4E                  ; $EB16: D0 36
        LDA a:$0109                ; $EB18: AD 09 01
        BNE LEB3E                  ; $EB1B: D0 21
        LDA a:$0212,y              ; $EB1D: B9 12 02
        AND #$81                   ; $EB20: 29 81
        STA a:$0212,y              ; $EB22: 99 12 02
        LDA a:$0216,y              ; $EB25: B9 16 02
        ORA #$41                   ; $EB28: 09 41
        STA a:$0216,y              ; $EB2A: 99 16 02
        LDX a:$078F                ; $EB2D: AE 8F 07
        CPX #$10                   ; $EB30: E0 10
        BCS LEB64                  ; $EB32: B0 30
        STA a:$020E,y              ; $EB34: 99 0E 02
        AND #$81                   ; $EB37: 29 81
        STA a:$020A,y              ; $EB39: 99 0A 02
        BCC LEB64                  ; $EB3C: 90 26
LEB3E:
        LDA a:$0202,y              ; $EB3E: B9 02 02
        AND #$81                   ; $EB41: 29 81
        STA a:$0202,y              ; $EB43: 99 02 02
        LDA a:$0206,y              ; $EB46: B9 06 02
        ORA #$41                   ; $EB49: 09 41
        STA a:$0206,y              ; $EB4B: 99 06 02
LEB4E:
        LDA z:$EF                  ; $EB4E: A5 EF
        CMP #$18                   ; $EB50: C9 18
        BCC LEB64                  ; $EB52: 90 10
        LDA #$82                   ; $EB54: A9 82
        STA a:$020A,y              ; $EB56: 99 0A 02
        STA a:$0212,y              ; $EB59: 99 12 02
        ORA #$40                   ; $EB5C: 09 40
        STA a:$020E,y              ; $EB5E: 99 0E 02
        STA a:$0216,y              ; $EB61: 99 16 02
LEB64:
        LDX z:$08                  ; $EB64: A6 08
        LDA a:$03D1                ; $EB66: AD D1 03
        LSR a                      ; $EB69: 4A
        LSR a                      ; $EB6A: 4A
        LSR a                      ; $EB6B: 4A
        PHA                        ; $EB6C: 48
        BCC LEB74                  ; $EB6D: 90 05
        LDA #$04                   ; $EB6F: A9 04
        JSR a:$EBC1                ; $EB71: 20 C1 EB
LEB74:
        PLA                        ; $EB74: 68
        LSR a                      ; $EB75: 4A
        PHA                        ; $EB76: 48
        BCC LEB7E                  ; $EB77: 90 05
        LDA #$00                   ; $EB79: A9 00
        JSR a:$EBC1                ; $EB7B: 20 C1 EB
LEB7E:
        PLA                        ; $EB7E: 68
        LSR a                      ; $EB7F: 4A
        LSR a                      ; $EB80: 4A
        PHA                        ; $EB81: 48
        BCC LEB89                  ; $EB82: 90 05
        LDA #$10                   ; $EB84: A9 10
        JSR a:$EBB7                ; $EB86: 20 B7 EB
LEB89:
        PLA                        ; $EB89: 68
        LSR a                      ; $EB8A: 4A
        PHA                        ; $EB8B: 48
        BCC LEB93                  ; $EB8C: 90 05
        LDA #$08                   ; $EB8E: A9 08
        JSR a:$EBB7                ; $EB90: 20 B7 EB
LEB93:
        PLA                        ; $EB93: 68
        LSR a                      ; $EB94: 4A
        BCC LEBA9                  ; $EB95: 90 12
        JSR a:$EBB7                ; $EB97: 20 B7 EB
        LDA z:$16,x                ; $EB9A: B5 16
        CMP #$0C                   ; $EB9C: C9 0C
        BEQ LEBA9                  ; $EB9E: F0 09
        LDA z:$B6,x                ; $EBA0: B5 B6
        CMP #$02                   ; $EBA2: C9 02
        BNE LEBA9                  ; $EBA4: D0 03
        JSR a:$C998                ; $EBA6: 20 98 C9
LEBA9:
        RTS                        ; $EBA9: 60
        LDA a:$E73E,x              ; $EBAA: BD 3E E7
        STA z:$00                  ; $EBAD: 85 00
        LDA a:$E73F,x              ; $EBAF: BD 3F E7
        STA z:$01                  ; $EBB2: 85 01
        JMP a:$F282                ; $EBB4: 4C 82 F2
        CLC                        ; $EBB7: 18
        ADC a:$06E5,x              ; $EBB8: 7D E5 06
        TAY                        ; $EBBB: A8
        LDA #$F8                   ; $EBBC: A9 F8
        JMP a:$E5C1                ; $EBBE: 4C C1 E5
        CLC                        ; $EBC1: 18
        ADC a:$06E5,x              ; $EBC2: 7D E5 06
        TAY                        ; $EBC5: A8
        JSR a:$EC4A                ; $EBC6: 20 4A EC
        STA a:$0210,y              ; $EBC9: 99 10 02
        RTS                        ; $EBCC: 60
        .byte $85,$85,$86,$86   ; $EBCD
        LDA a:$03BC                ; $EBD1: AD BC 03
        STA z:$02                  ; $EBD4: 85 02
        LDA a:$03B1                ; $EBD6: AD B1 03
        STA z:$05                  ; $EBD9: 85 05
        LDA #$03                   ; $EBDB: A9 03
        STA z:$04                  ; $EBDD: 85 04
        LSR a                      ; $EBDF: 4A
        STA z:$03                  ; $EBE0: 85 03
        LDY a:$06EC,x              ; $EBE2: BC EC 06
        LDX #$00                   ; $EBE5: A2 00
LEBE7:
        LDA a:$EBCD,x              ; $EBE7: BD CD EB
        STA z:$00                  ; $EBEA: 85 00
        LDA a:$EBCE,x              ; $EBEC: BD CE EB
        JSR a:$EBB2                ; $EBEF: 20 B2 EB
        CPX #$04                   ; $EBF2: E0 04
        BNE LEBE7                  ; $EBF4: D0 F1
        LDX z:$08                  ; $EBF6: A6 08
        LDY a:$06EC,x              ; $EBF8: BC EC 06
        LDA a:$074E                ; $EBFB: AD 4E 07
        CMP #$01                   ; $EBFE: C9 01
        BEQ LEC0A                  ; $EC00: F0 08
        LDA #$86                   ; $EC02: A9 86
        STA a:$0201,y              ; $EC04: 99 01 02
        STA a:$0205,y              ; $EC07: 99 05 02
LEC0A:
        LDA a:$03E8,x              ; $EC0A: BD E8 03
        CMP #$C4                   ; $EC0D: C9 C4
        BNE LEC35                  ; $EC0F: D0 24
        LDA #$87                   ; $EC11: A9 87
        INY                        ; $EC13: C8
        JSR a:$E5BB                ; $EC14: 20 BB E5
        DEY                        ; $EC17: 88
        LDA #$03                   ; $EC18: A9 03
        LDX a:$074E                ; $EC1A: AE 4E 07
        DEX                        ; $EC1D: CA
        BEQ LEC21                  ; $EC1E: F0 01
        LSR a                      ; $EC20: 4A
LEC21:
        LDX z:$08                  ; $EC21: A6 08
        STA a:$0202,y              ; $EC23: 99 02 02
        ORA #$40                   ; $EC26: 09 40
        STA a:$0206,y              ; $EC28: 99 06 02
        ORA #$80                   ; $EC2B: 09 80
        STA a:$020E,y              ; $EC2D: 99 0E 02
        AND #$83                   ; $EC30: 29 83
        STA a:$020A,y              ; $EC32: 99 0A 02
LEC35:
        LDA a:$03D4                ; $EC35: AD D4 03
        PHA                        ; $EC38: 48
        AND #$04                   ; $EC39: 29 04
        BEQ LEC45                  ; $EC3B: F0 08
        LDA #$F8                   ; $EC3D: A9 F8
        STA a:$0204,y              ; $EC3F: 99 04 02
        STA a:$020C,y              ; $EC42: 99 0C 02
LEC45:
        PLA                        ; $EC45: 68
        AND #$08                   ; $EC46: 29 08
        BEQ LEC52                  ; $EC48: F0 08
        LDA #$F8                   ; $EC4A: A9 F8
        STA a:$0200,y              ; $EC4C: 99 00 02
        STA a:$0208,y              ; $EC4F: 99 08 02
LEC52:
        RTS                        ; $EC52: 60
        LDA #$02                   ; $EC53: A9 02
        STA z:$00                  ; $EC55: 85 00
        LDA #$75                   ; $EC57: A9 75
        LDY z:$0E                  ; $EC59: A4 0E
        CPY #$05                   ; $EC5B: C0 05
        BEQ LEC65                  ; $EC5D: F0 06
        LDA #$03                   ; $EC5F: A9 03
        STA z:$00                  ; $EC61: 85 00
        LDA #$84                   ; $EC63: A9 84
LEC65:
        LDY a:$06EC,x              ; $EC65: BC EC 06
        INY                        ; $EC68: C8
        JSR a:$E5BB                ; $EC69: 20 BB E5
        LDA z:$09                  ; $EC6C: A5 09
        ASL a                      ; $EC6E: 0A
        ASL a                      ; $EC6F: 0A
        ASL a                      ; $EC70: 0A
        ASL a                      ; $EC71: 0A
        AND #$C0                   ; $EC72: 29 C0
        ORA z:$00                  ; $EC74: 05 00
        INY                        ; $EC76: C8
        JSR a:$E5BB                ; $EC77: 20 BB E5
        DEY                        ; $EC7A: 88
        DEY                        ; $EC7B: 88
        LDA a:$03BC                ; $EC7C: AD BC 03
        JSR a:$E5C1                ; $EC7F: 20 C1 E5
        LDA a:$03B1                ; $EC82: AD B1 03
        STA a:$0203,y              ; $EC85: 99 03 02
        LDA a:$03F1,x              ; $EC88: BD F1 03
        SEC                        ; $EC8B: 38
        SBC a:$071C                ; $EC8C: ED 1C 07
        STA z:$00                  ; $EC8F: 85 00
        SEC                        ; $EC91: 38
        SBC a:$03B1                ; $EC92: ED B1 03
        ADC z:$00                  ; $EC95: 65 00
        ADC #$06                   ; $EC97: 69 06
        STA a:$0207,y              ; $EC99: 99 07 02
        LDA a:$03BD                ; $EC9C: AD BD 03
        STA a:$0208,y              ; $EC9F: 99 08 02
        STA a:$020C,y              ; $ECA2: 99 0C 02
        LDA a:$03B2                ; $ECA5: AD B2 03
        STA a:$020B,y              ; $ECA8: 99 0B 02
        LDA z:$00                  ; $ECAB: A5 00
        SEC                        ; $ECAD: 38
        SBC a:$03B2                ; $ECAE: ED B2 03
        ADC z:$00                  ; $ECB1: 65 00
        ADC #$06                   ; $ECB3: 69 06
        STA a:$020F,y              ; $ECB5: 99 0F 02
        LDA a:$03D4                ; $ECB8: AD D4 03
        JSR a:$EC46                ; $ECBB: 20 46 EC
        LDA a:$03D4                ; $ECBE: AD D4 03
        ASL a                      ; $ECC1: 0A
        BCC LECC9                  ; $ECC2: 90 05
        LDA #$F8                   ; $ECC4: A9 F8
        JSR a:$E5C1                ; $ECC6: 20 C1 E5
LECC9:
        LDA z:$00                  ; $ECC9: A5 00
        BPL LECDD                  ; $ECCB: 10 10
        LDA a:$0203,y              ; $ECCD: B9 03 02
        CMP a:$0207,y              ; $ECD0: D9 07 02
        BCC LECDD                  ; $ECD3: 90 08
        LDA #$F8                   ; $ECD5: A9 F8
        STA a:$0204,y              ; $ECD7: 99 04 02
        STA a:$020C,y              ; $ECDA: 99 0C 02
LECDD:
        RTS                        ; $ECDD: 60
        LDY a:$06F1,x              ; $ECDE: BC F1 06
        LDA a:$03BA                ; $ECE1: AD BA 03
        STA a:$0200,y              ; $ECE4: 99 00 02
        LDA a:$03AF                ; $ECE7: AD AF 03
        STA a:$0203,y              ; $ECEA: 99 03 02
        LDA z:$09                  ; $ECED: A5 09
        LSR a                      ; $ECEF: 4A
        LSR a                      ; $ECF0: 4A
        PHA                        ; $ECF1: 48
        AND #$01                   ; $ECF2: 29 01
        EOR #$64                   ; $ECF4: 49 64
        STA a:$0201,y              ; $ECF6: 99 01 02
        PLA                        ; $ECF9: 68
        LSR a                      ; $ECFA: 4A
        LSR a                      ; $ECFB: 4A
        LDA #$02                   ; $ECFC: A9 02
        BCC LED02                  ; $ECFE: 90 02
        ORA #$C0                   ; $ED00: 09 C0
LED02:
        STA a:$0202,y              ; $ED02: 99 02 02
        RTS                        ; $ED05: 60
        .byte $68,$67,$66   ; $ED06
        LDY a:$06EC,x              ; $ED09: BC EC 06
        LDA z:$24,x                ; $ED0C: B5 24
        INC z:$24,x                ; $ED0E: F6 24
        LSR a                      ; $ED10: 4A
        AND #$07                   ; $ED11: 29 07
        CMP #$03                   ; $ED13: C9 03
        BCS LED61                  ; $ED15: B0 4A
        TAX                        ; $ED17: AA
        LDA a:$ED06,x              ; $ED18: BD 06 ED
        INY                        ; $ED1B: C8
        JSR a:$E5BB                ; $ED1C: 20 BB E5
        DEY                        ; $ED1F: 88
        LDX z:$08                  ; $ED20: A6 08
        LDA a:$03BA                ; $ED22: AD BA 03
        SEC                        ; $ED25: 38
        SBC #$04                   ; $ED26: E9 04
        STA a:$0200,y              ; $ED28: 99 00 02
        STA a:$0208,y              ; $ED2B: 99 08 02
        CLC                        ; $ED2E: 18
        ADC #$08                   ; $ED2F: 69 08
        STA a:$0204,y              ; $ED31: 99 04 02
        STA a:$020C,y              ; $ED34: 99 0C 02
        LDA a:$03AF                ; $ED37: AD AF 03
        SEC                        ; $ED3A: 38
        SBC #$04                   ; $ED3B: E9 04
        STA a:$0203,y              ; $ED3D: 99 03 02
        STA a:$0207,y              ; $ED40: 99 07 02
        CLC                        ; $ED43: 18
        ADC #$08                   ; $ED44: 69 08
        STA a:$020B,y              ; $ED46: 99 0B 02
        STA a:$020F,y              ; $ED49: 99 0F 02
        LDA #$02                   ; $ED4C: A9 02
        STA a:$0202,y              ; $ED4E: 99 02 02
        LDA #$82                   ; $ED51: A9 82
        STA a:$0206,y              ; $ED53: 99 06 02
        LDA #$42                   ; $ED56: A9 42
        STA a:$020A,y              ; $ED58: 99 0A 02
        LDA #$C2                   ; $ED5B: A9 C2
        STA a:$020E,y              ; $ED5D: 99 0E 02
        RTS                        ; $ED60: 60
LED61:
        LDA #$00                   ; $ED61: A9 00
        STA z:$24,x                ; $ED63: 95 24
        RTS                        ; $ED65: 60
        LDY a:$06E5,x              ; $ED66: BC E5 06
        LDA #$5B                   ; $ED69: A9 5B
        INY                        ; $ED6B: C8
        JSR a:$E5B5                ; $ED6C: 20 B5 E5
        INY                        ; $ED6F: C8
        LDA #$02                   ; $ED70: A9 02
        JSR a:$E5B5                ; $ED72: 20 B5 E5
        DEY                        ; $ED75: 88
        DEY                        ; $ED76: 88
        LDA a:$03AE                ; $ED77: AD AE 03
        STA a:$0203,y              ; $ED7A: 99 03 02
        STA a:$020F,y              ; $ED7D: 99 0F 02
        CLC                        ; $ED80: 18
        ADC #$08                   ; $ED81: 69 08
        STA a:$0207,y              ; $ED83: 99 07 02
        STA a:$0213,y              ; $ED86: 99 13 02
        CLC                        ; $ED89: 18
        ADC #$08                   ; $ED8A: 69 08
        STA a:$020B,y              ; $ED8C: 99 0B 02
        STA a:$0217,y              ; $ED8F: 99 17 02
        LDA z:$CF,x                ; $ED92: B5 CF
        TAX                        ; $ED94: AA
        PHA                        ; $ED95: 48
        CPX #$20                   ; $ED96: E0 20
        BCS LED9C                  ; $ED98: B0 02
        LDA #$F8                   ; $ED9A: A9 F8
LED9C:
        JSR a:$E5BE                ; $ED9C: 20 BE E5
        PLA                        ; $ED9F: 68
        CLC                        ; $EDA0: 18
        ADC #$80                   ; $EDA1: 69 80
        TAX                        ; $EDA3: AA
        CPX #$20                   ; $EDA4: E0 20
        BCS LEDAA                  ; $EDA6: B0 02
        LDA #$F8                   ; $EDA8: A9 F8
LEDAA:
        STA a:$020C,y              ; $EDAA: 99 0C 02
        STA a:$0210,y              ; $EDAD: 99 10 02
        STA a:$0214,y              ; $EDB0: 99 14 02
        LDA a:$03D1                ; $EDB3: AD D1 03
        PHA                        ; $EDB6: 48
        AND #$08                   ; $EDB7: 29 08
        BEQ LEDC3                  ; $EDB9: F0 08
        LDA #$F8                   ; $EDBB: A9 F8
        STA a:$0200,y              ; $EDBD: 99 00 02
        STA a:$020C,y              ; $EDC0: 99 0C 02
LEDC3:
        PLA                        ; $EDC3: 68
        PHA                        ; $EDC4: 48
        AND #$04                   ; $EDC5: 29 04
        BEQ LEDD1                  ; $EDC7: F0 08
        LDA #$F8                   ; $EDC9: A9 F8
        STA a:$0204,y              ; $EDCB: 99 04 02
        STA a:$0210,y              ; $EDCE: 99 10 02
LEDD1:
        PLA                        ; $EDD1: 68
        AND #$02                   ; $EDD2: 29 02
        BEQ LEDDE                  ; $EDD4: F0 08
        LDA #$F8                   ; $EDD6: A9 F8
        STA a:$0208,y              ; $EDD8: 99 08 02
        STA a:$0214,y              ; $EDDB: 99 14 02
LEDDE:
        LDX z:$08                  ; $EDDE: A6 08
        RTS                        ; $EDE0: 60
        LDY z:$B5                  ; $EDE1: A4 B5
        DEY                        ; $EDE3: 88
        BNE LEE06                  ; $EDE4: D0 20
        LDA a:$03D3                ; $EDE6: AD D3 03
        AND #$08                   ; $EDE9: 29 08
        BNE LEE06                  ; $EDEB: D0 19
        LDY a:$06EE,x              ; $EDED: BC EE 06
        LDA a:$03B0                ; $EDF0: AD B0 03
        STA a:$0203,y              ; $EDF3: 99 03 02
        LDA a:$03BB                ; $EDF6: AD BB 03
        STA a:$0200,y              ; $EDF9: 99 00 02
        LDA #$74                   ; $EDFC: A9 74
        STA a:$0201,y              ; $EDFE: 99 01 02
        LDA #$02                   ; $EE01: A9 02
        STA a:$0202,y              ; $EE03: 99 02 02
LEE06:
        RTS                        ; $EE06: 60
        JSR a:$C828                ; $EE07: 20 28 C8
        CLC                        ; $EE0A: 18
        BRK                        ; $EE0B: 00
        .byte $40,$50,$58,$80,$88,$B8,$78,$60,$A0,$B0,$B8,$00,$01,$02,$03,$04   ; $EE0C
        .byte $05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$14   ; $EE1C
        .byte $15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24   ; $EE2C
        .byte $25,$26,$27,$08,$09,$28,$29,$2A,$2B,$2C,$2D,$08,$09,$0A,$0B,$0C   ; $EE3C
        .byte $30,$2C,$2D,$08,$09,$0A,$0B,$2E,$2F,$2C,$2D,$08,$09,$28,$29,$2A   ; $EE4C
        .byte $2B,$5C,$5D,$08,$09,$0A,$0B,$0C,$0D,$5E,$5F,$FC,$FC,$08,$09,$58   ; $EE5C
        .byte $59,$5A,$5A,$08,$09,$28,$29,$2A,$2B,$0E,$0F,$FC,$FC,$FC,$FC,$32   ; $EE6C
        .byte $33,$34,$35,$FC,$FC,$FC,$FC,$36,$37,$38,$39,$FC,$FC,$FC,$FC,$3A   ; $EE7C
        .byte $37,$3B,$3C,$FC,$FC,$FC,$FC,$3D,$3E,$3F,$40,$FC,$FC,$FC,$FC,$32   ; $EE8C
        .byte $41,$42,$43,$FC,$FC,$FC,$FC,$32,$33,$44,$45,$FC,$FC,$FC,$FC,$32   ; $EE9C
        .byte $33,$44,$47,$FC,$FC,$FC,$FC,$32,$33   ; $EEAC
        PHA                        ; $EEB5: 48
        EOR #$FC                   ; $EEB6: 49 FC
        .byte $FC,$FC,$FC,$32,$33,$90,$91,$FC,$FC,$FC,$FC,$3A,$37,$92,$93,$FC   ; $EEB8
        .byte $FC,$FC,$FC,$9E,$9E,$9F,$9F,$FC,$FC,$FC,$FC,$3A,$37,$4F,$4F,$FC   ; $EEC8
        .byte $FC,$00,$01,$4C,$4D,$4E,$4E,$00,$01,$4C,$4D,$4A,$4A,$4B,$4B,$31   ; $EED8
        .byte $46   ; $EEE8
        LDA a:$079E                ; $EEE9: AD 9E 07
        BEQ LEEF3                  ; $EEEC: F0 05
        LDA z:$09                  ; $EEEE: A5 09
        LSR a                      ; $EEF0: 4A
        BCS LEF33                  ; $EEF1: B0 40
LEEF3:
        LDA z:$0E                  ; $EEF3: A5 0E
        CMP #$0B                   ; $EEF5: C9 0B
        BEQ LEF40                  ; $EEF7: F0 47
        LDA a:$070B                ; $EEF9: AD 0B 07
        BNE LEF3A                  ; $EEFC: D0 3C
        LDY a:$0704                ; $EEFE: AC 04 07
        BEQ LEF34                  ; $EF01: F0 31
        LDA z:$1D                  ; $EF03: A5 1D
        CMP #$00                   ; $EF05: C9 00
        BEQ LEF34                  ; $EF07: F0 2B
        JSR a:$EF34                ; $EF09: 20 34 EF
        LDA z:$09                  ; $EF0C: A5 09
        AND #$04                   ; $EF0E: 29 04
        BNE LEF33                  ; $EF10: D0 21
        TAX                        ; $EF12: AA
        LDY a:$06E4                ; $EF13: AC E4 06
        LDA z:$33                  ; $EF16: A5 33
        LSR a                      ; $EF18: 4A
        BCS LEF1F                  ; $EF19: B0 04
        INY                        ; $EF1B: C8
        INY                        ; $EF1C: C8
        INY                        ; $EF1D: C8
        INY                        ; $EF1E: C8
LEF1F:
        LDA a:$0754                ; $EF1F: AD 54 07
        BEQ LEF2D                  ; $EF22: F0 09
        LDA a:$0219,y              ; $EF24: B9 19 02
        CMP a:$EEB5                ; $EF27: CD B5 EE
        BEQ LEF33                  ; $EF2A: F0 07
        INX                        ; $EF2C: E8
LEF2D:
        LDA a:$EEE7,x              ; $EF2D: BD E7 EE
        STA a:$0219,y              ; $EF30: 99 19 02
LEF33:
        RTS                        ; $EF33: 60
LEF34:
        JSR a:$EFEC                ; $EF34: 20 EC EF
        JMP a:$EF45                ; $EF37: 4C 45 EF
LEF3A:
        JSR a:$F0B0                ; $EF3A: 20 B0 F0
        JMP a:$EF45                ; $EF3D: 4C 45 EF
LEF40:
        LDY #$0E                   ; $EF40: A0 0E
        LDA a:$EE07,y              ; $EF42: B9 07 EE
        STA a:$06D5                ; $EF45: 8D D5 06
        LDA #$04                   ; $EF48: A9 04
        JSR a:$EFBE                ; $EF4A: 20 BE EF
        JSR a:$F0E9                ; $EF4D: 20 E9 F0
        LDA a:$0711                ; $EF50: AD 11 07
        BEQ LEF7A                  ; $EF53: F0 25
        LDY #$00                   ; $EF55: A0 00
        LDA a:$0781                ; $EF57: AD 81 07
        CMP a:$0711                ; $EF5A: CD 11 07
        STY a:$0711                ; $EF5D: 8C 11 07
        BCS LEF7A                  ; $EF60: B0 18
        STA a:$0711                ; $EF62: 8D 11 07
        LDY #$07                   ; $EF65: A0 07
        LDA a:$EE07,y              ; $EF67: B9 07 EE
        STA a:$06D5                ; $EF6A: 8D D5 06
        LDY #$04                   ; $EF6D: A0 04
        LDA z:$57                  ; $EF6F: A5 57
        ORA z:$0C                  ; $EF71: 05 0C
        BEQ LEF76                  ; $EF73: F0 01
        DEY                        ; $EF75: 88
LEF76:
        TYA                        ; $EF76: 98
        JSR a:$EFBE                ; $EF77: 20 BE EF
LEF7A:
        LDA a:$03D0                ; $EF7A: AD D0 03
        LSR a                      ; $EF7D: 4A
        LSR a                      ; $EF7E: 4A
        LSR a                      ; $EF7F: 4A
        LSR a                      ; $EF80: 4A
        STA z:$00                  ; $EF81: 85 00
        LDX #$03                   ; $EF83: A2 03
        LDA a:$06E4                ; $EF85: AD E4 06
        CLC                        ; $EF88: 18
        ADC #$18                   ; $EF89: 69 18
        TAY                        ; $EF8B: A8
LEF8C:
        LDA #$F8                   ; $EF8C: A9 F8
        LSR z:$00                  ; $EF8E: 46 00
        BCC LEF95                  ; $EF90: 90 03
        JSR a:$E5C1                ; $EF92: 20 C1 E5
LEF95:
        TYA                        ; $EF95: 98
        SEC                        ; $EF96: 38
        SBC #$08                   ; $EF97: E9 08
        TAY                        ; $EF99: A8
        DEX                        ; $EF9A: CA
        BPL LEF8C                  ; $EF9B: 10 EF
        RTS                        ; $EF9D: 60
        .byte $58,$01,$00,$60,$FF,$04   ; $EF9E
        LDX #$05                   ; $EFA4: A2 05
LEFA6:
        LDA a:$EF9E,x              ; $EFA6: BD 9E EF
        STA z:$02,x                ; $EFA9: 95 02
        DEX                        ; $EFAB: CA
        BPL LEFA6                  ; $EFAC: 10 F8
        LDX #$B8                   ; $EFAE: A2 B8
        LDY #$04                   ; $EFB0: A0 04
        JSR a:$EFDC                ; $EFB2: 20 DC EF
        LDA a:$0226                ; $EFB5: AD 26 02
        ORA #$40                   ; $EFB8: 09 40
        STA a:$0222                ; $EFBA: 8D 22 02
        RTS                        ; $EFBD: 60
        STA z:$07                  ; $EFBE: 85 07
        LDA a:$03AD                ; $EFC0: AD AD 03
        STA a:$0755                ; $EFC3: 8D 55 07
        STA z:$05                  ; $EFC6: 85 05
        LDA a:$03B8                ; $EFC8: AD B8 03
        STA z:$02                  ; $EFCB: 85 02
        LDA z:$33                  ; $EFCD: A5 33
        STA z:$03                  ; $EFCF: 85 03
        LDA a:$03C4                ; $EFD1: AD C4 03
        STA z:$04                  ; $EFD4: 85 04
        LDX a:$06D5                ; $EFD6: AE D5 06
        LDY a:$06E4                ; $EFD9: AC E4 06
LEFDC:
        LDA a:$EE17,x              ; $EFDC: BD 17 EE
        STA z:$00                  ; $EFDF: 85 00
        LDA a:$EE18,x              ; $EFE1: BD 18 EE
        JSR a:$EBB2                ; $EFE4: 20 B2 EB
        DEC z:$07                  ; $EFE7: C6 07
        BNE LEFDC                  ; $EFE9: D0 F1
        RTS                        ; $EFEB: 60
        LDA z:$1D                  ; $EFEC: A5 1D
        CMP #$03                   ; $EFEE: C9 03
        BEQ LF044                  ; $EFF0: F0 52
        CMP #$02                   ; $EFF2: C9 02
        BEQ LF034                  ; $EFF4: F0 3E
        CMP #$01                   ; $EFF6: C9 01
        BNE LF00B                  ; $EFF8: D0 11
        LDA a:$0704                ; $EFFA: AD 04 07
        BNE LF050                  ; $EFFD: D0 51
        LDY #$06                   ; $EFFF: A0 06
        LDA a:$0714                ; $F001: AD 14 07
        BNE LF028                  ; $F004: D0 22
        .byte $A0   ; $F006
        BRK                        ; $F007: 00
        .byte $4C,$28,$F0   ; $F008
LF00B:
        LDY #$06                   ; $F00B: A0 06
        LDA a:$0714                ; $F00D: AD 14 07
        BNE LF028                  ; $F010: D0 16
        LDY #$02                   ; $F012: A0 02
        LDA z:$57                  ; $F014: A5 57
        ORA z:$0C                  ; $F016: 05 0C
        BEQ LF028                  ; $F018: F0 0E
        LDA a:$0700                ; $F01A: AD 00 07
        CMP #$09                   ; $F01D: C9 09
        BCC LF03C                  ; $F01F: 90 1B
        LDA z:$45                  ; $F021: A5 45
        AND z:$33                  ; $F023: 25 33
        BNE LF03C                  ; $F025: D0 15
        INY                        ; $F027: C8
LF028:
        JSR a:$F091                ; $F028: 20 91 F0
        LDA #$00                   ; $F02B: A9 00
        STA a:$070D                ; $F02D: 8D 0D 07
        LDA a:$EE07,y              ; $F030: B9 07 EE
        RTS                        ; $F033: 60
LF034:
        LDY #$04                   ; $F034: A0 04
        JSR a:$F091                ; $F036: 20 91 F0
        JMP a:$F062                ; $F039: 4C 62 F0
LF03C:
        LDY #$04                   ; $F03C: A0 04
        JSR a:$F091                ; $F03E: 20 91 F0
        JMP a:$F068                ; $F041: 4C 68 F0
LF044:
        LDY #$05                   ; $F044: A0 05
        LDA z:$9F                  ; $F046: A5 9F
        BEQ LF028                  ; $F048: F0 DE
        JSR a:$F091                ; $F04A: 20 91 F0
        JMP a:$F06D                ; $F04D: 4C 6D F0
LF050:
        LDY #$01                   ; $F050: A0 01
        JSR a:$F091                ; $F052: 20 91 F0
        LDA a:$0782                ; $F055: AD 82 07
        ORA a:$070D                ; $F058: 0D 0D 07
        BNE LF068                  ; $F05B: D0 0B
        LDA z:$0A                  ; $F05D: A5 0A
        ASL a                      ; $F05F: 0A
        BCS LF068                  ; $F060: B0 06
        LDA a:$070D                ; $F062: AD 0D 07
        JMP a:$F0D0                ; $F065: 4C D0 F0
LF068:
        LDA #$03                   ; $F068: A9 03
        JMP a:$F06F                ; $F06A: 4C 6F F0
        LDA #$02                   ; $F06D: A9 02
        STA z:$00                  ; $F06F: 85 00
        JSR a:$F062                ; $F071: 20 62 F0
        PHA                        ; $F074: 48
        LDA a:$0781                ; $F075: AD 81 07
        BNE LF08F                  ; $F078: D0 15
        LDA a:$070C                ; $F07A: AD 0C 07
        STA a:$0781                ; $F07D: 8D 81 07
        LDA a:$070D                ; $F080: AD 0D 07
        CLC                        ; $F083: 18
        ADC #$01                   ; $F084: 69 01
        CMP z:$00                  ; $F086: C5 00
        BCC LF08C                  ; $F088: 90 02
        LDA #$00                   ; $F08A: A9 00
LF08C:
        STA a:$070D                ; $F08C: 8D 0D 07
LF08F:
        PLA                        ; $F08F: 68
        RTS                        ; $F090: 60
        LDA a:$0754                ; $F091: AD 54 07
        BEQ LF09B                  ; $F094: F0 05
        TYA                        ; $F096: 98
        CLC                        ; $F097: 18
        ADC #$08                   ; $F098: 69 08
        TAY                        ; $F09A: A8
LF09B:
        RTS                        ; $F09B: 60
        .byte $00,$01,$00,$01,$00,$01,$02,$00,$01,$02,$02,$00,$02,$00,$02,$00   ; $F09C
        .byte $02,$00,$02,$00   ; $F0AC
        LDY a:$070D                ; $F0B0: AC 0D 07
        LDA z:$09                  ; $F0B3: A5 09
        AND #$03                   ; $F0B5: 29 03
        BNE LF0C6                  ; $F0B7: D0 0D
        INY                        ; $F0B9: C8
        CPY #$0A                   ; $F0BA: C0 0A
        .byte $90   ; $F0BC
        ORA z:$A0                  ; $F0BD: 05 A0
        BRK                        ; $F0BF: 00
        .byte $8C,$0B,$07,$8C,$0D,$07   ; $F0C0
LF0C6:
        LDA a:$0754                ; $F0C6: AD 54 07
        BNE LF0D7                  ; $F0C9: D0 0C
        LDA a:$F09C,y              ; $F0CB: B9 9C F0
        LDY #$0F                   ; $F0CE: A0 0F
        ASL a                      ; $F0D0: 0A
        ASL a                      ; $F0D1: 0A
        ASL a                      ; $F0D2: 0A
        ADC a:$EE07,y              ; $F0D3: 79 07 EE
        RTS                        ; $F0D6: 60
LF0D7:
        TYA                        ; $F0D7: 98
        CLC                        ; $F0D8: 18
        ADC #$0A                   ; $F0D9: 69 0A
        TAX                        ; $F0DB: AA
        LDY #$09                   ; $F0DC: A0 09
        LDA a:$F09C,x              ; $F0DE: BD 9C F0
        BNE LF0E5                  ; $F0E1: D0 02
        LDY #$01                   ; $F0E3: A0 01
LF0E5:
        LDA a:$EE07,y              ; $F0E5: B9 07 EE
        RTS                        ; $F0E8: 60
        LDY a:$06E4                ; $F0E9: AC E4 06
        LDA z:$0E                  ; $F0EC: A5 0E
        CMP #$0B                   ; $F0EE: C9 0B
        BEQ LF105                  ; $F0F0: F0 13
        LDA a:$06D5                ; $F0F2: AD D5 06
        CMP #$50                   ; $F0F5: C9 50
        BEQ LF117                  ; $F0F7: F0 1E
        CMP #$B8                   ; $F0F9: C9 B8
        BEQ LF117                  ; $F0FB: F0 1A
        CMP #$C0                   ; $F0FD: C9 C0
        BEQ LF117                  ; $F0FF: F0 16
        CMP #$C8                   ; $F101: C9 C8
        BNE LF129                  ; $F103: D0 24
LF105:
        LDA a:$0212,y              ; $F105: B9 12 02
        AND #$3F                   ; $F108: 29 3F
        STA a:$0212,y              ; $F10A: 99 12 02
        LDA a:$0216,y              ; $F10D: B9 16 02
        AND #$3F                   ; $F110: 29 3F
        ORA #$40                   ; $F112: 09 40
        STA a:$0216,y              ; $F114: 99 16 02
LF117:
        LDA a:$021A,y              ; $F117: B9 1A 02
        AND #$3F                   ; $F11A: 29 3F
        STA a:$021A,y              ; $F11C: 99 1A 02
        LDA a:$021E,y              ; $F11F: B9 1E 02
        AND #$3F                   ; $F122: 29 3F
        ORA #$40                   ; $F124: 09 40
        STA a:$021E,y              ; $F126: 99 1E 02
LF129:
        RTS                        ; $F129: 60
        LDX #$00                   ; $F12A: A2 00
        LDY #$00                   ; $F12C: A0 00
        JMP a:$F142                ; $F12E: 4C 42 F1
        LDY #$01                   ; $F131: A0 01
        JSR a:$F1A8                ; $F133: 20 A8 F1
        LDY #$03                   ; $F136: A0 03
        JMP a:$F142                ; $F138: 4C 42 F1
        LDY #$00                   ; $F13B: A0 00
        JSR a:$F1A8                ; $F13D: 20 A8 F1
        LDY #$02                   ; $F140: A0 02
        JSR a:$F171                ; $F142: 20 71 F1
        LDX z:$08                  ; $F145: A6 08
        RTS                        ; $F147: 60
        LDY #$02                   ; $F148: A0 02
        JSR a:$F1A8                ; $F14A: 20 A8 F1
        LDY #$06                   ; $F14D: A0 06
        JMP a:$F142                ; $F14F: 4C 42 F1
        LDA #$01                   ; $F152: A9 01
        LDY #$01                   ; $F154: A0 01
        JMP a:$F165                ; $F156: 4C 65 F1
        LDA #$09                   ; $F159: A9 09
        LDY #$04                   ; $F15B: A0 04
        JSR a:$F165                ; $F15D: 20 65 F1
        INX                        ; $F160: E8
        INX                        ; $F161: E8
        LDA #$09                   ; $F162: A9 09
        INY                        ; $F164: C8
        STX z:$00                  ; $F165: 86 00
        CLC                        ; $F167: 18
        ADC z:$00                  ; $F168: 65 00
        TAX                        ; $F16A: AA
        JSR a:$F171                ; $F16B: 20 71 F1
        LDX z:$08                  ; $F16E: A6 08
        RTS                        ; $F170: 60
        LDA z:$CE,x                ; $F171: B5 CE
        STA a:$03B8,y              ; $F173: 99 B8 03
        LDA z:$86,x                ; $F176: B5 86
        SEC                        ; $F178: 38
        SBC a:$071C                ; $F179: ED 1C 07
        STA a:$03AD,y              ; $F17C: 99 AD 03
        RTS                        ; $F17F: 60
        LDX #$00                   ; $F180: A2 00
        LDY #$00                   ; $F182: A0 00
        JMP a:$F1C0                ; $F184: 4C C0 F1
        LDY #$00                   ; $F187: A0 00
        JSR a:$F1A8                ; $F189: 20 A8 F1
        LDY #$02                   ; $F18C: A0 02
        JMP a:$F1C0                ; $F18E: 4C C0 F1
        LDY #$01                   ; $F191: A0 01
        JSR a:$F1A8                ; $F193: 20 A8 F1
        LDY #$03                   ; $F196: A0 03
        JMP a:$F1C0                ; $F198: 4C C0 F1
        LDY #$02                   ; $F19B: A0 02
        JSR a:$F1A8                ; $F19D: 20 A8 F1
        LDY #$06                   ; $F1A0: A0 06
        JMP a:$F1C0                ; $F1A2: 4C C0 F1
        .byte $07,$16,$0D   ; $F1A5
        TXA                        ; $F1A8: 8A
        CLC                        ; $F1A9: 18
        ADC a:$F1A5,y              ; $F1AA: 79 A5 F1
        TAX                        ; $F1AD: AA
        RTS                        ; $F1AE: 60
        LDA #$01                   ; $F1AF: A9 01
        LDY #$01                   ; $F1B1: A0 01
        JMP a:$F1BA                ; $F1B3: 4C BA F1
        LDA #$09                   ; $F1B6: A9 09
        LDY #$04                   ; $F1B8: A0 04
        STX z:$00                  ; $F1BA: 86 00
        CLC                        ; $F1BC: 18
        ADC z:$00                  ; $F1BD: 65 00
        TAX                        ; $F1BF: AA
        TYA                        ; $F1C0: 98
        PHA                        ; $F1C1: 48
        JSR a:$F1D7                ; $F1C2: 20 D7 F1
        ASL a                      ; $F1C5: 0A
        ASL a                      ; $F1C6: 0A
        ASL a                      ; $F1C7: 0A
        ASL a                      ; $F1C8: 0A
        ORA z:$00                  ; $F1C9: 05 00
        STA z:$00                  ; $F1CB: 85 00
        PLA                        ; $F1CD: 68
        TAY                        ; $F1CE: A8
        LDA z:$00                  ; $F1CF: A5 00
        STA a:$03D0,y              ; $F1D1: 99 D0 03
        LDX z:$08                  ; $F1D4: A6 08
        RTS                        ; $F1D6: 60
        JSR a:$F1F6                ; $F1D7: 20 F6 F1
        LSR a                      ; $F1DA: 4A
        LSR a                      ; $F1DB: 4A
        LSR a                      ; $F1DC: 4A
        LSR a                      ; $F1DD: 4A
        STA z:$00                  ; $F1DE: 85 00
        JMP a:$F239                ; $F1E0: 4C 39 F2
        .byte $7F,$3F,$1F,$0F,$07,$03,$01,$00,$80,$C0,$E0,$F0,$F8,$FC,$FE,$FF   ; $F1E3
        .byte $07,$0F,$07   ; $F1F3
        STX z:$04                  ; $F1F6: 86 04
        LDY #$01                   ; $F1F8: A0 01
LF1FA:
        LDA a:$071C,y              ; $F1FA: B9 1C 07
        SEC                        ; $F1FD: 38
        SBC z:$86,x                ; $F1FE: F5 86
        STA z:$07                  ; $F200: 85 07
        LDA a:$071A,y              ; $F202: B9 1A 07
        SBC z:$6D,x                ; $F205: F5 6D
        LDX a:$F1F3,y              ; $F207: BE F3 F1
        CMP #$00                   ; $F20A: C9 00
        BMI LF21E                  ; $F20C: 30 10
        LDX a:$F1F4,y              ; $F20E: BE F4 F1
        CMP #$01                   ; $F211: C9 01
        BPL LF21E                  ; $F213: 10 09
        LDA #$38                   ; $F215: A9 38
        STA z:$06                  ; $F217: 85 06
        LDA #$08                   ; $F219: A9 08
        JSR a:$F26D                ; $F21B: 20 6D F2
LF21E:
        LDA a:$F1E3,x              ; $F21E: BD E3 F1
        LDX z:$04                  ; $F221: A6 04
        CMP #$00                   ; $F223: C9 00
        BNE LF22A                  ; $F225: D0 03
        DEY                        ; $F227: 88
        BPL LF1FA                  ; $F228: 10 D0
LF22A:
        RTS                        ; $F22A: 60
        .byte $00,$08,$0C,$0E,$0F,$07,$03,$01,$00,$04,$00,$04,$FF,$00   ; $F22B
        STX z:$04                  ; $F239: 86 04
        LDY #$01                   ; $F23B: A0 01
LF23D:
        LDA a:$F237,y              ; $F23D: B9 37 F2
        SEC                        ; $F240: 38
        SBC z:$CE,x                ; $F241: F5 CE
        STA z:$07                  ; $F243: 85 07
        LDA #$01                   ; $F245: A9 01
        SBC z:$B5,x                ; $F247: F5 B5
        LDX a:$F234,y              ; $F249: BE 34 F2
        CMP #$00                   ; $F24C: C9 00
        BMI LF260                  ; $F24E: 30 10
        LDX a:$F235,y              ; $F250: BE 35 F2
        CMP #$01                   ; $F253: C9 01
        BPL LF260                  ; $F255: 10 09
        LDA #$20                   ; $F257: A9 20
        STA z:$06                  ; $F259: 85 06
        LDA #$04                   ; $F25B: A9 04
        JSR a:$F26D                ; $F25D: 20 6D F2
LF260:
        LDA a:$F22B,x              ; $F260: BD 2B F2
        LDX z:$04                  ; $F263: A6 04
        CMP #$00                   ; $F265: C9 00
        BNE LF26C                  ; $F267: D0 03
        DEY                        ; $F269: 88
        BPL LF23D                  ; $F26A: 10 D1
LF26C:
        RTS                        ; $F26C: 60
        STA z:$05                  ; $F26D: 85 05
        LDA z:$07                  ; $F26F: A5 07
        CMP z:$06                  ; $F271: C5 06
        BCS LF281                  ; $F273: B0 0C
        LSR a                      ; $F275: 4A
        LSR a                      ; $F276: 4A
        LSR a                      ; $F277: 4A
        AND #$07                   ; $F278: 29 07
        CPY #$01                   ; $F27A: C0 01
        BCS LF280                  ; $F27C: B0 02
        ADC z:$05                  ; $F27E: 65 05
LF280:
        TAX                        ; $F280: AA
LF281:
        RTS                        ; $F281: 60
        LDA z:$03                  ; $F282: A5 03
        LSR a                      ; $F284: 4A
        LSR a                      ; $F285: 4A
        LDA z:$00                  ; $F286: A5 00
        BCC LF296                  ; $F288: 90 0C
        STA a:$0205,y              ; $F28A: 99 05 02
        LDA z:$01                  ; $F28D: A5 01
        STA a:$0201,y              ; $F28F: 99 01 02
        LDA #$40                   ; $F292: A9 40
        BNE LF2A0                  ; $F294: D0 0A
LF296:
        STA a:$0201,y              ; $F296: 99 01 02
        LDA z:$01                  ; $F299: A5 01
        STA a:$0205,y              ; $F29B: 99 05 02
        LDA #$00                   ; $F29E: A9 00
LF2A0:
        ORA z:$04                  ; $F2A0: 05 04
        STA a:$0202,y              ; $F2A2: 99 02 02
        STA a:$0206,y              ; $F2A5: 99 06 02
        LDA z:$02                  ; $F2A8: A5 02
        STA a:$0200,y              ; $F2AA: 99 00 02
        STA a:$0204,y              ; $F2AD: 99 04 02
        LDA z:$05                  ; $F2B0: A5 05
        STA a:$0203,y              ; $F2B2: 99 03 02
        CLC                        ; $F2B5: 18
        ADC #$08                   ; $F2B6: 69 08
        STA a:$0207,y              ; $F2B8: 99 07 02
        LDA z:$02                  ; $F2BB: A5 02
        CLC                        ; $F2BD: 18
        ADC #$08                   ; $F2BE: 69 08
        STA z:$02                  ; $F2C0: 85 02
        TYA                        ; $F2C2: 98
        CLC                        ; $F2C3: 18
        ADC #$08                   ; $F2C4: 69 08
        TAY                        ; $F2C6: A8
        INX                        ; $F2C7: E8
        INX                        ; $F2C8: E8
        RTS                        ; $F2C9: 60
        .byte $FF,$FF,$FF,$FF,$FF,$FF   ; $F2CA
        LDA a:$0770                ; $F2D0: AD 70 07
        BNE LF2D9                  ; $F2D3: D0 04
        STA a:$4015                ; $F2D5: 8D 15 40
        RTS                        ; $F2D8: 60
LF2D9:
        LDA #$FF                   ; $F2D9: A9 FF
        STA a:$4017                ; $F2DB: 8D 17 40
        LDA #$0F                   ; $F2DE: A9 0F
        STA a:$4015                ; $F2E0: 8D 15 40
        LDA a:$07C6                ; $F2E3: AD C6 07
        BNE LF2EE                  ; $F2E6: D0 06
        LDA z:$FA                  ; $F2E8: A5 FA
        CMP #$01                   ; $F2EA: C9 01
        BNE LF34B                  ; $F2EC: D0 5D
LF2EE:
        LDA a:$07B2                ; $F2EE: AD B2 07
        BNE LF316                  ; $F2F1: D0 23
        LDA z:$FA                  ; $F2F3: A5 FA
        BEQ LF35D                  ; $F2F5: F0 66
        STA a:$07B2                ; $F2F7: 8D B2 07
        STA a:$07C6                ; $F2FA: 8D C6 07
        LDA #$00                   ; $F2FD: A9 00
        STA a:$4015                ; $F2FF: 8D 15 40
        STA z:$F1                  ; $F302: 85 F1
        STA z:$F2                  ; $F304: 85 F2
        STA z:$F3                  ; $F306: 85 F3
        LDA #$0F                   ; $F308: A9 0F
        STA a:$4015                ; $F30A: 8D 15 40
        LDA #$2A                   ; $F30D: A9 2A
        STA a:$07BB                ; $F30F: 8D BB 07
LF312:
        LDA #$44                   ; $F312: A9 44
        BNE LF327                  ; $F314: D0 11
LF316:
        LDA a:$07BB                ; $F316: AD BB 07
        CMP #$24                   ; $F319: C9 24
        BEQ LF325                  ; $F31B: F0 08
        CMP #$1E                   ; $F31D: C9 1E
        BEQ LF312                  ; $F31F: F0 F1
        CMP #$18                   ; $F321: C9 18
        BNE LF32E                  ; $F323: D0 09
LF325:
        LDA #$64                   ; $F325: A9 64
LF327:
        LDX #$84                   ; $F327: A2 84
        LDY #$7F                   ; $F329: A0 7F
        JSR a:$F388                ; $F32B: 20 88 F3
LF32E:
        DEC a:$07BB                ; $F32E: CE BB 07
        BNE LF35D                  ; $F331: D0 2A
        LDA #$00                   ; $F333: A9 00
        STA a:$4015                ; $F335: 8D 15 40
        LDA a:$07B2                ; $F338: AD B2 07
        CMP #$02                   ; $F33B: C9 02
        BNE LF344                  ; $F33D: D0 05
        LDA #$00                   ; $F33F: A9 00
        STA a:$07C6                ; $F341: 8D C6 07
LF344:
        LDA #$00                   ; $F344: A9 00
        STA a:$07B2                ; $F346: 8D B2 07
        BEQ LF35D                  ; $F349: F0 12
LF34B:
        JSR a:$F41B                ; $F34B: 20 1B F4
        JSR a:$F57C                ; $F34E: 20 7C F5
        JSR a:$F667                ; $F351: 20 67 F6
        JSR a:$F694                ; $F354: 20 94 F6
        LDA #$00                   ; $F357: A9 00
        STA z:$FB                  ; $F359: 85 FB
        STA z:$FC                  ; $F35B: 85 FC
LF35D:
        LDA #$00                   ; $F35D: A9 00
        STA z:$FF                  ; $F35F: 85 FF
        STA z:$FE                  ; $F361: 85 FE
        STA z:$FD                  ; $F363: 85 FD
        STA z:$FA                  ; $F365: 85 FA
        LDY a:$07C0                ; $F367: AC C0 07
        LDA z:$F4                  ; $F36A: A5 F4
        AND #$03                   ; $F36C: 29 03
        BEQ LF377                  ; $F36E: F0 07
        INC a:$07C0                ; $F370: EE C0 07
        CPY #$30                   ; $F373: C0 30
        BCC LF37D                  ; $F375: 90 06
LF377:
        TYA                        ; $F377: 98
        BEQ LF37D                  ; $F378: F0 03
        DEC a:$07C0                ; $F37A: CE C0 07
LF37D:
        STY a:$4011                ; $F37D: 8C 11 40
        RTS                        ; $F380: 60
        STY a:$4001                ; $F381: 8C 01 40
        STX a:$4000                ; $F384: 8E 00 40
        RTS                        ; $F387: 60
        JSR a:$F381                ; $F388: 20 81 F3
        LDX #$00                   ; $F38B: A2 00
LF38D:
        TAY                        ; $F38D: A8
        LDA a:$FF01,y              ; $F38E: B9 01 FF
        BEQ LF39E                  ; $F391: F0 0B
        STA a:$4002,x              ; $F393: 9D 02 40
        LDA a:$FF00,y              ; $F396: B9 00 FF
        ORA #$08                   ; $F399: 09 08
        STA a:$4003,x              ; $F39B: 9D 03 40
LF39E:
        RTS                        ; $F39E: 60
        STX a:$4004                ; $F39F: 8E 04 40
        STY a:$4005                ; $F3A2: 8C 05 40
        RTS                        ; $F3A5: 60
        JSR a:$F39F                ; $F3A6: 20 9F F3
        LDX #$04                   ; $F3A9: A2 04
        BNE LF38D                  ; $F3AB: D0 E0
        LDX #$08                   ; $F3AD: A2 08
        BNE LF38D                  ; $F3AF: D0 DC
        .byte $9F,$9B,$98,$96,$95,$94,$92,$90,$90,$9A,$97,$95,$93,$92   ; $F3B1
LF3BF:
        LDA #$40                   ; $F3BF: A9 40
        STA a:$07BB                ; $F3C1: 8D BB 07
        LDA #$62                   ; $F3C4: A9 62
        JSR a:$F38B                ; $F3C6: 20 8B F3
        LDX #$99                   ; $F3C9: A2 99
        BNE LF3F2                  ; $F3CB: D0 25
LF3CD:
        LDA #$26                   ; $F3CD: A9 26
        BNE LF3D3                  ; $F3CF: D0 02
LF3D1:
        LDA #$18                   ; $F3D1: A9 18
LF3D3:
        LDX #$82                   ; $F3D3: A2 82
        LDY #$A7                   ; $F3D5: A0 A7
        JSR a:$F388                ; $F3D7: 20 88 F3
        LDA #$28                   ; $F3DA: A9 28
        STA a:$07BB                ; $F3DC: 8D BB 07
LF3DF:
        LDA a:$07BB                ; $F3DF: AD BB 07
        CMP #$25                   ; $F3E2: C9 25
        BNE LF3EC                  ; $F3E4: D0 06
        LDX #$5F                   ; $F3E6: A2 5F
        LDY #$F6                   ; $F3E8: A0 F6
        BNE LF3F4                  ; $F3EA: D0 08
LF3EC:
        CMP #$20                   ; $F3EC: C9 20
        BNE LF419                  ; $F3EE: D0 29
        LDX #$48                   ; $F3F0: A2 48
LF3F2:
        LDY #$BC                   ; $F3F2: A0 BC
LF3F4:
        JSR a:$F381                ; $F3F4: 20 81 F3
        BNE LF419                  ; $F3F7: D0 20
LF3F9:
        LDA #$05                   ; $F3F9: A9 05
        LDY #$99                   ; $F3FB: A0 99
        BNE LF403                  ; $F3FD: D0 04
LF3FF:
        LDA #$0A                   ; $F3FF: A9 0A
        LDY #$93                   ; $F401: A0 93
LF403:
        LDX #$9E                   ; $F403: A2 9E
        STA a:$07BB                ; $F405: 8D BB 07
        LDA #$0C                   ; $F408: A9 0C
        JSR a:$F388                ; $F40A: 20 88 F3
LF40D:
        LDA a:$07BB                ; $F40D: AD BB 07
        CMP #$06                   ; $F410: C9 06
        BNE LF419                  ; $F412: D0 05
        LDA #$BB                   ; $F414: A9 BB
        STA a:$4001                ; $F416: 8D 01 40
LF419:
        BNE LF47B                  ; $F419: D0 60
        LDY z:$FF                  ; $F41B: A4 FF
        BEQ LF43F                  ; $F41D: F0 20
        STY z:$F1                  ; $F41F: 84 F1
        BMI LF3CD                  ; $F421: 30 AA
        LSR z:$FF                  ; $F423: 46 FF
        BCS LF3D1                  ; $F425: B0 AA
        LSR z:$FF                  ; $F427: 46 FF
        BCS LF3FF                  ; $F429: B0 D4
        LSR z:$FF                  ; $F42B: 46 FF
        BCS LF45B                  ; $F42D: B0 2C
        LSR z:$FF                  ; $F42F: 46 FF
        BCS LF47D                  ; $F431: B0 4A
        LSR z:$FF                  ; $F433: 46 FF
        BCS LF4B6                  ; $F435: B0 7F
        LSR z:$FF                  ; $F437: 46 FF
        BCS LF3F9                  ; $F439: B0 BE
        LSR z:$FF                  ; $F43B: 46 FF
        BCS LF3BF                  ; $F43D: B0 80
LF43F:
        LDA z:$F1                  ; $F43F: A5 F1
        BEQ LF45A                  ; $F441: F0 17
        BMI LF3DF                  ; $F443: 30 9A
        LSR a                      ; $F445: 4A
        BCS LF3DF                  ; $F446: B0 97
        LSR a                      ; $F448: 4A
        BCS LF40D                  ; $F449: B0 C2
        LSR a                      ; $F44B: 4A
        BCS LF469                  ; $F44C: B0 1B
        LSR a                      ; $F44E: 4A
        BCS LF48D                  ; $F44F: B0 3C
        LSR a                      ; $F451: 4A
        BCS LF4BB                  ; $F452: B0 67
        LSR a                      ; $F454: 4A
        BCS LF40D                  ; $F455: B0 B6
        LSR a                      ; $F457: 4A
        BCS LF4A2                  ; $F458: B0 48
LF45A:
        RTS                        ; $F45A: 60
LF45B:
        LDA #$0E                   ; $F45B: A9 0E
        STA a:$07BB                ; $F45D: 8D BB 07
        LDY #$9C                   ; $F460: A0 9C
        LDX #$9E                   ; $F462: A2 9E
        LDA #$26                   ; $F464: A9 26
        JSR a:$F388                ; $F466: 20 88 F3
LF469:
        LDY a:$07BB                ; $F469: AC BB 07
        LDA a:$F3B0,y              ; $F46C: B9 B0 F3
        STA a:$4000                ; $F46F: 8D 00 40
        CPY #$06                   ; $F472: C0 06
        BNE LF47B                  ; $F474: D0 05
        LDA #$9E                   ; $F476: A9 9E
        STA a:$4002                ; $F478: 8D 02 40
LF47B:
        BNE LF4A2                  ; $F47B: D0 25
LF47D:
        LDA #$0E                   ; $F47D: A9 0E
        LDY #$CB                   ; $F47F: A0 CB
        LDX #$9F                   ; $F481: A2 9F
        STA a:$07BB                ; $F483: 8D BB 07
        LDA #$28                   ; $F486: A9 28
        JSR a:$F388                ; $F488: 20 88 F3
        BNE LF4A2                  ; $F48B: D0 15
LF48D:
        LDY a:$07BB                ; $F48D: AC BB 07
        CPY #$08                   ; $F490: C0 08
        BNE LF49D                  ; $F492: D0 09
        LDA #$A0                   ; $F494: A9 A0
        STA a:$4002                ; $F496: 8D 02 40
        LDA #$9F                   ; $F499: A9 9F
        BNE LF49F                  ; $F49B: D0 02
LF49D:
        LDA #$90                   ; $F49D: A9 90
LF49F:
        STA a:$4000                ; $F49F: 8D 00 40
LF4A2:
        DEC a:$07BB                ; $F4A2: CE BB 07
        BNE LF4B5                  ; $F4A5: D0 0E
        LDX #$00                   ; $F4A7: A2 00
        STX z:$F1                  ; $F4A9: 86 F1
        LDX #$0E                   ; $F4AB: A2 0E
        STX a:$4015                ; $F4AD: 8E 15 40
        LDX #$0F                   ; $F4B0: A2 0F
        STX a:$4015                ; $F4B2: 8E 15 40
LF4B5:
        RTS                        ; $F4B5: 60
LF4B6:
        LDA #$2F                   ; $F4B6: A9 2F
        STA a:$07BB                ; $F4B8: 8D BB 07
LF4BB:
        LDA a:$07BB                ; $F4BB: AD BB 07
        LSR a                      ; $F4BE: 4A
        BCS LF4D1                  ; $F4BF: B0 10
        LSR a                      ; $F4C1: 4A
        BCS LF4D1                  ; $F4C2: B0 0D
        AND #$02                   ; $F4C4: 29 02
        BEQ LF4D1                  ; $F4C6: F0 09
        LDY #$91                   ; $F4C8: A0 91
        LDX #$9A                   ; $F4CA: A2 9A
        LDA #$44                   ; $F4CC: A9 44
        JSR a:$F388                ; $F4CE: 20 88 F3
LF4D1:
        JMP a:$F4A2                ; $F4D1: 4C A2 F4
        .byte $58,$02,$54,$56,$4E,$44,$4C,$52,$4C,$48,$3E,$36,$3E,$36,$30,$28   ; $F4D4
        .byte $4A,$50,$4A,$64,$3C,$32,$3C,$32,$2C,$24,$3A,$64,$3A,$34,$2C,$22   ; $F4E4
        .byte $2C,$22,$1C,$14,$14,$04,$22,$24,$16,$04,$24,$26,$18,$04,$26,$28   ; $F4F4
        .byte $1A,$04,$28,$2A,$1C,$04,$2A,$2C,$1E,$04,$2C,$2E,$20,$04,$2E,$30   ; $F504
        .byte $22,$04,$30,$32   ; $F514
LF518:
        LDA #$35                   ; $F518: A9 35
        LDX #$8D                   ; $F51A: A2 8D
        BNE LF522                  ; $F51C: D0 04
LF51E:
        LDA #$06                   ; $F51E: A9 06
        LDX #$98                   ; $F520: A2 98
LF522:
        STA a:$07BD                ; $F522: 8D BD 07
        LDY #$7F                   ; $F525: A0 7F
        LDA #$42                   ; $F527: A9 42
        JSR a:$F3A6                ; $F529: 20 A6 F3
        LDA a:$07BD                ; $F52C: AD BD 07
        CMP #$30                   ; $F52F: C9 30
        BNE LF538                  ; $F531: D0 05
        LDA #$54                   ; $F533: A9 54
        STA a:$4006                ; $F535: 8D 06 40
LF538:
        BNE LF568                  ; $F538: D0 2E
LF53A:
        LDA #$20                   ; $F53A: A9 20
        STA a:$07BD                ; $F53C: 8D BD 07
        LDY #$94                   ; $F53F: A0 94
        LDA #$5E                   ; $F541: A9 5E
        BNE LF550                  ; $F543: D0 0B
LF545:
        LDA a:$07BD                ; $F545: AD BD 07
        CMP #$18                   ; $F548: C9 18
        BNE LF568                  ; $F54A: D0 1C
        LDY #$93                   ; $F54C: A0 93
        LDA #$18                   ; $F54E: A9 18
LF550:
        BNE LF5D1                  ; $F550: D0 7F
LF552:
        LDA #$36                   ; $F552: A9 36
        STA a:$07BD                ; $F554: 8D BD 07
LF557:
        LDA a:$07BD                ; $F557: AD BD 07
        LSR a                      ; $F55A: 4A
        BCS LF568                  ; $F55B: B0 0B
        TAY                        ; $F55D: A8
        LDA a:$F4D9,y              ; $F55E: B9 D9 F4
        LDX #$5D                   ; $F561: A2 5D
        LDY #$7F                   ; $F563: A0 7F
LF565:
        JSR a:$F3A6                ; $F565: 20 A6 F3
LF568:
        DEC a:$07BD                ; $F568: CE BD 07
        BNE LF57B                  ; $F56B: D0 0E
        LDX #$00                   ; $F56D: A2 00
        STX z:$F2                  ; $F56F: 86 F2
        LDX #$0D                   ; $F571: A2 0D
        STX a:$4015                ; $F573: 8E 15 40
        LDX #$0F                   ; $F576: A2 0F
        STX a:$4015                ; $F578: 8E 15 40
LF57B:
        RTS                        ; $F57B: 60
        LDA z:$F2                  ; $F57C: A5 F2
        AND #$40                   ; $F57E: 29 40
        BNE LF5E7                  ; $F580: D0 65
        LDY z:$FE                  ; $F582: A4 FE
        BEQ LF5A6                  ; $F584: F0 20
        STY z:$F2                  ; $F586: 84 F2
        BMI LF5C8                  ; $F588: 30 3E
        LSR z:$FE                  ; $F58A: 46 FE
        BCS LF518                  ; $F58C: B0 8A
        LSR z:$FE                  ; $F58E: 46 FE
        BCS LF5FC                  ; $F590: B0 6A
        LSR z:$FE                  ; $F592: 46 FE
        BCS LF600                  ; $F594: B0 6A
        LSR z:$FE                  ; $F596: 46 FE
        BCS LF53A                  ; $F598: B0 A0
        LSR z:$FE                  ; $F59A: 46 FE
        BCS LF51E                  ; $F59C: B0 80
        LSR z:$FE                  ; $F59E: 46 FE
        BCS LF552                  ; $F5A0: B0 B0
        LSR z:$FE                  ; $F5A2: 46 FE
        BCS LF5E2                  ; $F5A4: B0 3C
LF5A6:
        LDA z:$F2                  ; $F5A6: A5 F2
        BEQ LF5C1                  ; $F5A8: F0 17
        BMI LF5D3                  ; $F5AA: 30 27
        LSR a                      ; $F5AC: 4A
        BCS LF5C2                  ; $F5AD: B0 13
        LSR a                      ; $F5AF: 4A
        BCS LF60F                  ; $F5B0: B0 5D
        LSR a                      ; $F5B2: 4A
        BCS LF60F                  ; $F5B3: B0 5A
        LSR a                      ; $F5B5: 4A
        BCS LF545                  ; $F5B6: B0 8D
        LSR a                      ; $F5B8: 4A
        BCS LF5C2                  ; $F5B9: B0 07
        LSR a                      ; $F5BB: 4A
        BCS LF557                  ; $F5BC: B0 99
        LSR a                      ; $F5BE: 4A
        BCS LF5E7                  ; $F5BF: B0 26
LF5C1:
        RTS                        ; $F5C1: 60
LF5C2:
        JMP a:$F52C                ; $F5C2: 4C 2C F5
LF5C5:
        JMP a:$F568                ; $F5C5: 4C 68 F5
LF5C8:
        LDA #$38                   ; $F5C8: A9 38
        STA a:$07BD                ; $F5CA: 8D BD 07
        LDY #$C4                   ; $F5CD: A0 C4
        LDA #$18                   ; $F5CF: A9 18
LF5D1:
        BNE LF5DE                  ; $F5D1: D0 0B
LF5D3:
        LDA a:$07BD                ; $F5D3: AD BD 07
        CMP #$08                   ; $F5D6: C9 08
        BNE LF568                  ; $F5D8: D0 8E
        LDY #$A4                   ; $F5DA: A0 A4
        LDA #$5A                   ; $F5DC: A9 5A
LF5DE:
        LDX #$9F                   ; $F5DE: A2 9F
LF5E0:
        BNE LF565                  ; $F5E0: D0 83
LF5E2:
        LDA #$30                   ; $F5E2: A9 30
        STA a:$07BD                ; $F5E4: 8D BD 07
LF5E7:
        LDA a:$07BD                ; $F5E7: AD BD 07
        LDX #$03                   ; $F5EA: A2 03
LF5EC:
        LSR a                      ; $F5EC: 4A
        BCS LF5C5                  ; $F5ED: B0 D6
        DEX                        ; $F5EF: CA
        BNE LF5EC                  ; $F5F0: D0 FA
        TAY                        ; $F5F2: A8
        LDA a:$F4D3,y              ; $F5F3: B9 D3 F4
        LDX #$82                   ; $F5F6: A2 82
        LDY #$7F                   ; $F5F8: A0 7F
        BNE LF5E0                  ; $F5FA: D0 E4
LF5FC:
        LDA #$10                   ; $F5FC: A9 10
        BNE LF602                  ; $F5FE: D0 02
LF600:
        LDA #$20                   ; $F600: A9 20
LF602:
        STA a:$07BD                ; $F602: 8D BD 07
        LDA #$7F                   ; $F605: A9 7F
        STA a:$4005                ; $F607: 8D 05 40
        LDA #$00                   ; $F60A: A9 00
        STA a:$07BE                ; $F60C: 8D BE 07
LF60F:
        INC a:$07BE                ; $F60F: EE BE 07
        LDA a:$07BE                ; $F612: AD BE 07
        LSR a                      ; $F615: 4A
        TAY                        ; $F616: A8
        CPY a:$07BD                ; $F617: CC BD 07
        BEQ LF628                  ; $F61A: F0 0C
        LDA #$9D                   ; $F61C: A9 9D
        STA a:$4004                ; $F61E: 8D 04 40
        LDA a:$F4F8,y              ; $F621: B9 F8 F4
        JSR a:$F3A9                ; $F624: 20 A9 F3
        RTS                        ; $F627: 60
LF628:
        JMP a:$F56D                ; $F628: 4C 6D F5
        .byte $01,$0E,$0E,$0D,$0B,$06,$0C,$0F,$0A,$09,$03,$0D,$08,$0D,$06,$0C   ; $F62B
LF63B:
        LDA #$20                   ; $F63B: A9 20
        STA a:$07BF                ; $F63D: 8D BF 07
LF640:
        LDA a:$07BF                ; $F640: AD BF 07
        LSR a                      ; $F643: 4A
        BCC LF658                  ; $F644: 90 12
        TAY                        ; $F646: A8
        LDX a:$F62B,y              ; $F647: BE 2B F6
        LDA a:$FFEA,y              ; $F64A: B9 EA FF
LF64D:
        STA a:$400C                ; $F64D: 8D 0C 40
        STX a:$400E                ; $F650: 8E 0E 40
        LDA #$18                   ; $F653: A9 18
        STA a:$400F                ; $F655: 8D 0F 40
LF658:
        DEC a:$07BF                ; $F658: CE BF 07
        BNE LF666                  ; $F65B: D0 09
        LDA #$F0                   ; $F65D: A9 F0
        STA a:$400C                ; $F65F: 8D 0C 40
        LDA #$00                   ; $F662: A9 00
        STA z:$F3                  ; $F664: 85 F3
LF666:
        RTS                        ; $F666: 60
        LDY z:$FD                  ; $F667: A4 FD
        BEQ LF675                  ; $F669: F0 0A
        STY z:$F3                  ; $F66B: 84 F3
        LSR z:$FD                  ; $F66D: 46 FD
        BCS LF63B                  ; $F66F: B0 CA
        LSR z:$FD                  ; $F671: 46 FD
        BCS LF680                  ; $F673: B0 0B
LF675:
        LDA z:$F3                  ; $F675: A5 F3
        BEQ LF67F                  ; $F677: F0 06
        LSR a                      ; $F679: 4A
        BCS LF640                  ; $F67A: B0 C4
        LSR a                      ; $F67C: 4A
        BCS LF685                  ; $F67D: B0 06
LF67F:
        RTS                        ; $F67F: 60
LF680:
        LDA #$40                   ; $F680: A9 40
        STA a:$07BF                ; $F682: 8D BF 07
LF685:
        LDA a:$07BF                ; $F685: AD BF 07
        LSR a                      ; $F688: 4A
        TAY                        ; $F689: A8
        LDX #$0F                   ; $F68A: A2 0F
        LDA a:$FFC9,y              ; $F68C: B9 C9 FF
        BNE LF64D                  ; $F68F: D0 BC
LF691:
        JMP a:$F73A                ; $F691: 4C 3A F7
        LDA z:$FC                  ; $F694: A5 FC
        BNE LF6A4                  ; $F696: D0 0C
        LDA z:$FB                  ; $F698: A5 FB
        BNE LF6C8                  ; $F69A: D0 2C
        LDA a:$07B1                ; $F69C: AD B1 07
        ORA z:$F4                  ; $F69F: 05 F4
        BNE LF691                  ; $F6A1: D0 EE
        RTS                        ; $F6A3: 60
LF6A4:
        STA a:$07B1                ; $F6A4: 8D B1 07
        CMP #$01                   ; $F6A7: C9 01
        BNE LF6B1                  ; $F6A9: D0 06
        JSR a:$F4A7                ; $F6AB: 20 A7 F4
        JSR a:$F571                ; $F6AE: 20 71 F5
LF6B1:
        LDX z:$F4                  ; $F6B1: A6 F4
        STX a:$07C5                ; $F6B3: 8E C5 07
        LDY #$00                   ; $F6B6: A0 00
        STY a:$07C4                ; $F6B8: 8C C4 07
        STY z:$F4                  ; $F6BB: 84 F4
        CMP #$40                   ; $F6BD: C9 40
        BNE LF6F1                  ; $F6BF: D0 30
        LDX #$08                   ; $F6C1: A2 08
        STX a:$07C4                ; $F6C3: 8E C4 07
        BNE LF6F1                  ; $F6C6: D0 29
LF6C8:
        CMP #$04                   ; $F6C8: C9 04
        BNE LF6CF                  ; $F6CA: D0 03
        JSR a:$F4A7                ; $F6CC: 20 A7 F4
LF6CF:
        LDY #$10                   ; $F6CF: A0 10
LF6D1:
        STY a:$07C7                ; $F6D1: 8C C7 07
        LDY #$00                   ; $F6D4: A0 00
        STY a:$07B1                ; $F6D6: 8C B1 07
        STA z:$F4                  ; $F6D9: 85 F4
        CMP #$01                   ; $F6DB: C9 01
        BNE LF6ED                  ; $F6DD: D0 0E
        INC a:$07C7                ; $F6DF: EE C7 07
        LDY a:$07C7                ; $F6E2: AC C7 07
        CPY #$32                   ; $F6E5: C0 32
        BNE LF6F5                  ; $F6E7: D0 0C
        LDY #$11                   ; $F6E9: A0 11
        BNE LF6D1                  ; $F6EB: D0 E4
LF6ED:
        LDY #$08                   ; $F6ED: A0 08
        STY z:$F7                  ; $F6EF: 84 F7
LF6F1:
        INY                        ; $F6F1: C8
        LSR a                      ; $F6F2: 4A
        BCC LF6F1                  ; $F6F3: 90 FC
LF6F5:
        LDA a:$F90C,y              ; $F6F5: B9 0C F9
        TAY                        ; $F6F8: A8
        LDA a:$F90D,y              ; $F6F9: B9 0D F9
        STA z:$F0                  ; $F6FC: 85 F0
        LDA a:$F90E,y              ; $F6FE: B9 0E F9
        STA z:$F5                  ; $F701: 85 F5
        LDA a:$F90F,y              ; $F703: B9 0F F9
        STA z:$F6                  ; $F706: 85 F6
        LDA a:$F910,y              ; $F708: B9 10 F9
        STA z:$F9                  ; $F70B: 85 F9
        LDA a:$F911,y              ; $F70D: B9 11 F9
        STA z:$F8                  ; $F710: 85 F8
        LDA a:$F912,y              ; $F712: B9 12 F9
        STA a:$07B0                ; $F715: 8D B0 07
        STA a:$07C1                ; $F718: 8D C1 07
        LDA #$01                   ; $F71B: A9 01
        STA a:$07B4                ; $F71D: 8D B4 07
        STA a:$07B6                ; $F720: 8D B6 07
        STA a:$07B9                ; $F723: 8D B9 07
        STA a:$07BA                ; $F726: 8D BA 07
        LDA #$00                   ; $F729: A9 00
        STA z:$F7                  ; $F72B: 85 F7
        STA a:$07CA                ; $F72D: 8D CA 07
        LDA #$0B                   ; $F730: A9 0B
        STA a:$4015                ; $F732: 8D 15 40
        LDA #$0F                   ; $F735: A9 0F
        STA a:$4015                ; $F737: 8D 15 40
        DEC a:$07B4                ; $F73A: CE B4 07
        BNE LF79E                  ; $F73D: D0 5F
        LDY z:$F7                  ; $F73F: A4 F7
        INC z:$F7                  ; $F741: E6 F7
        LDA ($F5),y                ; $F743: B1 F5
        BEQ LF74B                  ; $F745: F0 04
        BPL LF786                  ; $F747: 10 3D
        BNE LF77A                  ; $F749: D0 2F
LF74B:
        LDA a:$07B1                ; $F74B: AD B1 07
        CMP #$40                   ; $F74E: C9 40
        BNE LF757                  ; $F750: D0 05
        LDA a:$07C5                ; $F752: AD C5 07
        BNE LF774                  ; $F755: D0 1D
LF757:
        AND #$04                   ; $F757: 29 04
        BNE LF777                  ; $F759: D0 1C
        LDA z:$F4                  ; $F75B: A5 F4
        AND #$5F                   ; $F75D: 29 5F
        BNE LF774                  ; $F75F: D0 13
        LDA #$00                   ; $F761: A9 00
        STA z:$F4                  ; $F763: 85 F4
        STA a:$07B1                ; $F765: 8D B1 07
        STA a:$4008                ; $F768: 8D 08 40
        LDA #$90                   ; $F76B: A9 90
        STA a:$4000                ; $F76D: 8D 00 40
        STA a:$4004                ; $F770: 8D 04 40
        RTS                        ; $F773: 60
LF774:
        JMP a:$F6D4                ; $F774: 4C D4 F6
LF777:
        JMP a:$F6A4                ; $F777: 4C A4 F6
LF77A:
        JSR a:$F8CB                ; $F77A: 20 CB F8
        STA a:$07B3                ; $F77D: 8D B3 07
        LDY z:$F7                  ; $F780: A4 F7
        INC z:$F7                  ; $F782: E6 F7
        LDA ($F5),y                ; $F784: B1 F5
LF786:
        LDX z:$F2                  ; $F786: A6 F2
        BNE LF798                  ; $F788: D0 0E
        JSR a:$F3A9                ; $F78A: 20 A9 F3
        BEQ LF792                  ; $F78D: F0 03
        JSR a:$F8D8                ; $F78F: 20 D8 F8
LF792:
        STA a:$07B5                ; $F792: 8D B5 07
        JSR a:$F39F                ; $F795: 20 9F F3
LF798:
        LDA a:$07B3                ; $F798: AD B3 07
        STA a:$07B4                ; $F79B: 8D B4 07
LF79E:
        LDA z:$F2                  ; $F79E: A5 F2
        BNE LF7BC                  ; $F7A0: D0 1A
        LDA a:$07B1                ; $F7A2: AD B1 07
        AND #$91                   ; $F7A5: 29 91
        BNE LF7BC                  ; $F7A7: D0 13
        LDY a:$07B5                ; $F7A9: AC B5 07
        BEQ LF7B1                  ; $F7AC: F0 03
        DEC a:$07B5                ; $F7AE: CE B5 07
LF7B1:
        JSR a:$F8F4                ; $F7B1: 20 F4 F8
        STA a:$4004                ; $F7B4: 8D 04 40
        LDX #$7F                   ; $F7B7: A2 7F
        STX a:$4005                ; $F7B9: 8E 05 40
LF7BC:
        LDY z:$F8                  ; $F7BC: A4 F8
        BEQ LF81A                  ; $F7BE: F0 5A
        DEC a:$07B6                ; $F7C0: CE B6 07
        BNE LF7F7                  ; $F7C3: D0 32
LF7C5:
        LDY z:$F8                  ; $F7C5: A4 F8
        INC z:$F8                  ; $F7C7: E6 F8
        LDA ($F5),y                ; $F7C9: B1 F5
        BNE LF7DC                  ; $F7CB: D0 0F
        LDA #$83                   ; $F7CD: A9 83
        STA a:$4000                ; $F7CF: 8D 00 40
        LDA #$94                   ; $F7D2: A9 94
        STA a:$4001                ; $F7D4: 8D 01 40
        STA a:$07CA                ; $F7D7: 8D CA 07
        BNE LF7C5                  ; $F7DA: D0 E9
LF7DC:
        JSR a:$F8C5                ; $F7DC: 20 C5 F8
        STA a:$07B6                ; $F7DF: 8D B6 07
        LDY z:$F1                  ; $F7E2: A4 F1
        BNE LF81A                  ; $F7E4: D0 34
        TXA                        ; $F7E6: 8A
        AND #$3E                   ; $F7E7: 29 3E
        JSR a:$F38B                ; $F7E9: 20 8B F3
        BEQ LF7F1                  ; $F7EC: F0 03
        JSR a:$F8D8                ; $F7EE: 20 D8 F8
LF7F1:
        STA a:$07B7                ; $F7F1: 8D B7 07
        JSR a:$F381                ; $F7F4: 20 81 F3
LF7F7:
        LDA z:$F1                  ; $F7F7: A5 F1
        BNE LF81A                  ; $F7F9: D0 1F
        LDA a:$07B1                ; $F7FB: AD B1 07
        AND #$91                   ; $F7FE: 29 91
        BNE LF810                  ; $F800: D0 0E
        LDY a:$07B7                ; $F802: AC B7 07
        BEQ LF80A                  ; $F805: F0 03
        DEC a:$07B7                ; $F807: CE B7 07
LF80A:
        JSR a:$F8F4                ; $F80A: 20 F4 F8
        STA a:$4000                ; $F80D: 8D 00 40
LF810:
        LDA a:$07CA                ; $F810: AD CA 07
        BNE LF817                  ; $F813: D0 02
        LDA #$7F                   ; $F815: A9 7F
LF817:
        STA a:$4001                ; $F817: 8D 01 40
LF81A:
        LDA z:$F9                  ; $F81A: A5 F9
        DEC a:$07B9                ; $F81C: CE B9 07
        BNE LF86D                  ; $F81F: D0 4C
        LDY z:$F9                  ; $F821: A4 F9
        INC z:$F9                  ; $F823: E6 F9
        LDA ($F5),y                ; $F825: B1 F5
        BEQ LF86A                  ; $F827: F0 41
        BPL LF83E                  ; $F829: 10 13
        JSR a:$F8CB                ; $F82B: 20 CB F8
        STA a:$07B8                ; $F82E: 8D B8 07
        LDA #$1F                   ; $F831: A9 1F
        STA a:$4008                ; $F833: 8D 08 40
        LDY z:$F9                  ; $F836: A4 F9
        INC z:$F9                  ; $F838: E6 F9
        LDA ($F5),y                ; $F83A: B1 F5
        BEQ LF86A                  ; $F83C: F0 2C
LF83E:
        JSR a:$F3AD                ; $F83E: 20 AD F3
        LDX a:$07B8                ; $F841: AE B8 07
        STX a:$07B9                ; $F844: 8E B9 07
        LDA a:$07B1                ; $F847: AD B1 07
        AND #$6E                   ; $F84A: 29 6E
        BNE LF854                  ; $F84C: D0 06
        LDA z:$F4                  ; $F84E: A5 F4
        AND #$0A                   ; $F850: 29 0A
        BEQ LF86D                  ; $F852: F0 19
LF854:
        TXA                        ; $F854: 8A
        CMP #$12                   ; $F855: C9 12
        BCS LF868                  ; $F857: B0 0F
        LDA a:$07B1                ; $F859: AD B1 07
        AND #$08                   ; $F85C: 29 08
        BEQ LF864                  ; $F85E: F0 04
        LDA #$0F                   ; $F860: A9 0F
        BNE LF86A                  ; $F862: D0 06
LF864:
        LDA #$1F                   ; $F864: A9 1F
        BNE LF86A                  ; $F866: D0 02
LF868:
        LDA #$FF                   ; $F868: A9 FF
LF86A:
        STA a:$4008                ; $F86A: 8D 08 40
LF86D:
        LDA z:$F4                  ; $F86D: A5 F4
        AND #$F3                   ; $F86F: 29 F3
        BEQ LF8C4                  ; $F871: F0 51
        DEC a:$07BA                ; $F873: CE BA 07
        BNE LF8C4                  ; $F876: D0 4C
LF878:
        LDY a:$07B0                ; $F878: AC B0 07
        INC a:$07B0                ; $F87B: EE B0 07
        LDA ($F5),y                ; $F87E: B1 F5
        BNE LF88A                  ; $F880: D0 08
        LDA a:$07C1                ; $F882: AD C1 07
        STA a:$07B0                ; $F885: 8D B0 07
        BNE LF878                  ; $F888: D0 EE
LF88A:
        JSR a:$F8C5                ; $F88A: 20 C5 F8
        STA a:$07BA                ; $F88D: 8D BA 07
        TXA                        ; $F890: 8A
        AND #$3E                   ; $F891: 29 3E
        BEQ LF8B9                  ; $F893: F0 24
        CMP #$30                   ; $F895: C9 30
        BEQ LF8B1                  ; $F897: F0 18
        CMP #$20                   ; $F899: C9 20
        BEQ LF8A9                  ; $F89B: F0 0C
        AND #$10                   ; $F89D: 29 10
        BEQ LF8B9                  ; $F89F: F0 18
        LDA #$1C                   ; $F8A1: A9 1C
        LDX #$03                   ; $F8A3: A2 03
        LDY #$18                   ; $F8A5: A0 18
        BNE LF8BB                  ; $F8A7: D0 12
LF8A9:
        LDA #$1C                   ; $F8A9: A9 1C
        LDX #$0C                   ; $F8AB: A2 0C
        LDY #$18                   ; $F8AD: A0 18
        BNE LF8BB                  ; $F8AF: D0 0A
LF8B1:
        LDA #$1C                   ; $F8B1: A9 1C
        LDX #$03                   ; $F8B3: A2 03
        LDY #$58                   ; $F8B5: A0 58
        BNE LF8BB                  ; $F8B7: D0 02
LF8B9:
        LDA #$10                   ; $F8B9: A9 10
LF8BB:
        STA a:$400C                ; $F8BB: 8D 0C 40
        STX a:$400E                ; $F8BE: 8E 0E 40
        STY a:$400F                ; $F8C1: 8C 0F 40
LF8C4:
        RTS                        ; $F8C4: 60
        TAX                        ; $F8C5: AA
        ROR a                      ; $F8C6: 6A
        TXA                        ; $F8C7: 8A
        ROL a                      ; $F8C8: 2A
        ROL a                      ; $F8C9: 2A
        ROL a                      ; $F8CA: 2A
        AND #$07                   ; $F8CB: 29 07
        CLC                        ; $F8CD: 18
        ADC z:$F0                  ; $F8CE: 65 F0
        ADC a:$07C4                ; $F8D0: 6D C4 07
        TAY                        ; $F8D3: A8
        LDA a:$FF66,y              ; $F8D4: B9 66 FF
        RTS                        ; $F8D7: 60
        LDA a:$07B1                ; $F8D8: AD B1 07
        AND #$08                   ; $F8DB: 29 08
        BEQ LF8E3                  ; $F8DD: F0 04
        LDA #$04                   ; $F8DF: A9 04
        BNE LF8EF                  ; $F8E1: D0 0C
LF8E3:
        LDA z:$F4                  ; $F8E3: A5 F4
        AND #$7D                   ; $F8E5: 29 7D
        BEQ LF8ED                  ; $F8E7: F0 04
        LDA #$08                   ; $F8E9: A9 08
        BNE LF8EF                  ; $F8EB: D0 02
LF8ED:
        LDA #$28                   ; $F8ED: A9 28
LF8EF:
        LDX #$82                   ; $F8EF: A2 82
        LDY #$7F                   ; $F8F1: A0 7F
        RTS                        ; $F8F3: 60
        LDA a:$07B1                ; $F8F4: AD B1 07
        AND #$08                   ; $F8F7: 29 08
        BEQ LF8FF                  ; $F8F9: F0 04
        LDA a:$FF96,y              ; $F8FB: B9 96 FF
        RTS                        ; $F8FE: 60
LF8FF:
        LDA z:$F4                  ; $F8FF: A5 F4
        AND #$7D                   ; $F901: 29 7D
        BEQ LF909                  ; $F903: F0 04
        LDA a:$FF9A,y              ; $F905: B9 9A FF
        RTS                        ; $F908: 60
LF909:
        LDA a:$FFA2,y              ; $F909: B9 A2 FF
        RTS                        ; $F90C: 60
        .byte $A5,$59,$54,$64,$59,$3C,$31,$4B,$69,$5E,$46,$4F,$36,$8D,$36,$4B   ; $F90D
        .byte $8D,$69,$69,$6F,$75,$6F,$7B,$6F,$75,$6F,$7B,$81,$87,$81,$8D,$69   ; $F91D
        .byte $69,$93,$99,$93,$9F,$93,$99,$93,$9F,$81,$87,$81,$8D,$93,$99,$93   ; $F92D
        .byte $9F,$08,$72,$FC,$27,$18,$20,$B8,$F9,$2E,$1A,$40,$20,$B0,$FC,$3D   ; $F93D
        .byte $21,$20,$C4,$FC,$3F,$1D,$18,$11,$FD,$00,$00,$08,$1C,$FA,$00,$00   ; $F94D
        .byte $A4,$FB,$93,$62,$10,$C8,$FE,$24,$14,$18,$45,$FC,$1E,$14,$08,$52   ; $F95D
        .byte $FD,$A0,$70,$68,$08,$51,$FE,$4C,$24,$18,$01,$FA,$2D,$1C,$B8,$18   ; $F96D
        .byte $49,$FA,$20,$12,$70,$18,$75,$FA,$1B,$10,$44,$18,$9D,$FA,$11,$0A   ; $F97D
        .byte $1C,$18,$C2,$FA,$2D,$10,$58,$18,$DB,$FA,$14,$0D,$3F,$18,$F9,$FA   ; $F98D
        .byte $15,$0D,$21,$18,$25,$FB,$18,$10,$7A,$18,$4B,$FB,$19,$0F,$54,$18   ; $F99D
        .byte $74,$FB,$1E,$12,$2B,$18,$72,$FB,$1E,$0F,$2D,$84,$2C,$2C,$2C,$82   ; $F9AD
        .byte $04,$2C,$04,$85,$2C,$84,$2C,$2C,$2A,$2A,$2A,$82,$04,$2A,$04,$85   ; $F9BD
        .byte $2A,$84,$2A,$2A,$00,$1F,$1F,$1F,$98,$1F,$1F,$98,$9E,$98,$1F,$1D   ; $F9CD
        .byte $1D,$1D,$94,$1D,$1D,$94,$9C,$94,$1D,$86,$18,$85,$26,$30,$84,$04   ; $F9DD
        .byte $26,$30,$86,$14,$85,$22,$2C,$84,$04,$22,$2C,$21,$D0,$C4,$D0,$31   ; $F9ED
        .byte $D0,$C4,$D0,$00,$85,$2C,$22,$1C,$84,$26,$2A,$82,$28,$26,$04,$87   ; $F9FD
        .byte $22,$34,$3A,$82,$40,$04,$36,$84,$3A,$34,$82,$2C,$30,$85,$2A,$00   ; $FA0D
        .byte $5D,$55,$4D,$15,$19,$96,$15,$D5,$E3,$EB,$2D,$A6,$2B,$27,$9C,$9E   ; $FA1D
        .byte $59,$85,$22,$1C,$14,$84,$1E,$22,$82,$20,$1E,$04,$87,$1C,$2C,$34   ; $FA2D
        .byte $82,$36,$04,$30,$34,$04,$2C,$04,$26,$2A,$85,$22,$84,$04,$82,$3A   ; $FA3D
        .byte $38,$36,$32,$04,$34,$04,$24,$26,$2C,$04,$26,$2C,$30,$00,$05,$B4   ; $FA4D
        .byte $B2,$B0,$2B,$AC,$84,$9C,$9E,$A2,$84,$94,$9C,$9E,$85,$14,$22,$84   ; $FA5D
        .byte $2C,$85,$1E,$82,$2C,$84,$2C,$1E,$84,$04,$82,$3A,$38,$36,$32,$04   ; $FA6D
        .byte $34,$04,$64,$04,$64,$86,$64,$00,$05,$B4,$B2,$B0,$2B,$AC,$84,$37   ; $FA7D
        .byte $B6,$B6,$45,$85,$14,$1C,$82,$22,$84,$2C,$4E,$82,$4E,$84,$4E,$22   ; $FA8D
        .byte $84,$04,$85,$32,$85,$30,$86,$2C,$04,$00,$05,$A4,$05,$9E,$05,$9D   ; $FA9D
        STA z:$84                  ; $FAAD: 85 84
        .byte $14,$85,$24,$28,$2C,$82,$22,$84,$22,$14,$21,$D0,$C4,$D0,$31,$D0   ; $FAAF
        .byte $C4,$D0,$00,$82,$2C,$84,$2C,$2C,$82,$2C,$30,$04,$34,$2C,$04,$26   ; $FABF
        .byte $86,$22,$00,$A4,$25,$25,$A4,$29,$A2,$1D,$9C,$95,$82,$2C,$2C,$04   ; $FACF
        .byte $2C,$04,$2C,$30,$85,$34,$04,$04,$00,$A4,$25,$25,$A4,$A8,$63,$04   ; $FADF
        .byte $85,$0E,$1A,$84,$24,$85,$22,$14,$84,$0C,$82,$34,$84,$34,$34,$82   ; $FAEF
        .byte $2C,$84,$34,$86,$3A,$04,$00,$A0,$21,$21,$A0,$21,$2B,$05,$A3,$82   ; $FAFF
        .byte $18,$84,$18,$18,$82,$18,$18,$04,$86,$3A,$22,$31,$90,$31,$90,$31   ; $FB0F
        .byte $71,$31,$90,$90,$90,$00,$82,$34,$84,$2C,$85,$22,$84,$24,$82,$26   ; $FB1F
        .byte $36,$04,$36,$86,$26,$00,$AC,$27,$5D,$1D,$9E,$2D,$AC,$9F,$85,$14   ; $FB2F
        .byte $82,$20,$84,$22,$2C,$1E,$1E,$82,$2C,$2C,$1E,$04,$87,$2A,$40,$40   ; $FB3F
        .byte $40,$3A,$36,$82,$34,$2C,$04,$26,$86,$22,$00,$E3,$F7,$F7,$F7,$F5   ; $FB4F
        .byte $F1,$AC,$27,$9E,$9D,$85,$18,$82,$1E,$84,$22,$2A,$22,$22,$82,$2C   ; $FB5F
        .byte $2C,$22,$04,$86,$04,$82,$2A,$36,$04,$36,$87,$36,$34,$30,$86,$2C   ; $FB6F
        .byte $04,$00,$00,$68,$6A,$6C,$45,$A2,$31,$B0,$F1,$ED,$EB,$A2,$1D,$9C   ; $FB7F
        .byte $95,$86,$04,$85,$22,$82,$22,$87,$22,$26,$2A,$84,$2C,$22,$86,$14   ; $FB8F
        .byte $51,$90,$31,$11,$00,$80,$22,$28,$22,$26,$22,$24,$22,$26,$22,$28   ; $FB9F
        .byte $22,$2A,$22,$28,$22,$26,$22,$28,$22,$26,$22,$24,$22,$26,$22,$28   ; $FBAF
        .byte $22,$2A,$22,$28,$22,$26,$20,$26,$20,$24,$20,$26,$20,$28,$20,$26   ; $FBBF
        .byte $20,$28,$20,$26,$20,$24,$20,$26,$20,$24,$20,$26,$20,$28,$20,$26   ; $FBCF
        .byte $20,$28,$20,$26,$20,$24,$28,$30,$28,$32,$28,$30,$28,$2E,$28,$30   ; $FBDF
        .byte $28,$2E,$28,$2C,$28,$2E,$28,$30,$28,$32,$28,$30,$28,$2E,$28,$30   ; $FBEF
        .byte $28,$2E,$28,$2C,$28,$2E,$00,$04,$70,$6E,$6C,$6E,$70,$72,$70,$6E   ; $FBFF
        .byte $70,$6E,$6C,$6E,$70,$72,$70,$6E,$6E,$6C,$6E,$70,$6E,$70,$6E,$6C   ; $FC0F
        .byte $6E,$6C,$6E,$70,$6E,$70,$6E,$6C,$76,$78,$76,$74,$76,$74,$72,$74   ; $FC1F
        .byte $76,$78,$76,$74,$76,$74,$72,$74,$84,$1A,$83,$18,$20,$84,$1E,$83   ; $FC2F
        .byte $1C,$28,$26,$1C,$1A,$1C,$82,$2C,$04,$04,$22,$04,$04,$84,$1C,$87   ; $FC3F
        .byte $26,$2A,$26,$84,$24,$28,$24,$80,$22,$00,$9C,$05,$94,$05,$0D,$9F   ; $FC4F
        .byte $1E,$9C,$98,$9D,$82,$22,$04,$04,$1C,$04,$04,$84,$14,$86,$1E,$80   ; $FC5F
        .byte $16,$80,$14,$81,$1C,$30,$04,$30,$30,$04,$1E,$32,$04,$32,$32,$04   ; $FC6F
        .byte $20,$34,$04,$34,$34,$04   ; $FC7F
        ROL z:$04,x                ; $FC85: 36 04
        STY z:$36                  ; $FC87: 84 36
        BRK                        ; $FC89: 00
        .byte $46,$A4,$64   ; $FC8A
        LDY z:$48                  ; $FC8D: A4 48
        LDX z:$66                  ; $FC8F: A6 66
        LDX z:$4A                  ; $FC91: A6 4A
        TAY                        ; $FC93: A8
        PLA                        ; $FC94: 68
        TAY                        ; $FC95: A8
        ROR a                      ; $FC96: 6A
        .byte $44,$2B,$81,$2A,$42,$04,$42,$42,$04,$2C,$64,$04,$64,$64,$04,$2E   ; $FC97
        .byte $46,$04,$46,$46,$04,$22,$04,$84,$22,$87,$04,$06,$0C,$14,$1C,$22   ; $FCA7
        .byte $86,$2C,$22,$87,$04,$60,$0E,$14,$1A,$24,$86,$2C,$24,$87,$04,$08   ; $FCB7
        .byte $10,$18,$1E,$28,$86,$30,$30,$80,$64,$00,$CD,$D5,$DD,$E3,$ED,$F5   ; $FCC7
        .byte $BB,$B5,$CF,$D5,$DB,$E5,$ED,$F3,$BD,$B3,$D1,$D9,$DF,$E9,$F1,$F7   ; $FCD7
        .byte $BF,$FF,$FF,$FF,$34,$00,$86,$04,$87,$14,$1C,$22,$86,$34,$84,$2C   ; $FCE7
        .byte $04,$04,$04,$87,$14,$1A,$24,$86,$32,$84,$2C,$04,$86,$04,$87,$18   ; $FCF7
        .byte $1E,$28,$86,$36,$87,$30   ; $FD07
        BMI LFD3F                  ; $FD0D: 30 30
        .byte $80,$2C,$82,$14,$2C,$62,$26,$10,$28,$80,$04,$82,$14,$2C,$62,$26   ; $FD0F
        .byte $10,$28,$80,$04,$82,$08,$1E,$5E,$18,$60,$1A,$80,$04,$82,$08,$1E   ; $FD1F
        .byte $5E,$18,$60,$1A,$86,$04,$83,$1A,$18,$16,$84,$14,$1A,$18,$0E,$0C   ; $FD2F
LFD3F:
        ASL z:$83,x                ; $FD3F: 16 83
        .byte $14,$20,$1E,$1C,$28,$26,$87,$24,$1A,$12,$10,$62,$0E,$80,$04,$04   ; $FD41
        .byte $00,$82,$18,$1C,$20,$22,$26,$28,$81,$2A,$2A,$2A,$04,$2A,$04,$83   ; $FD51
        .byte $2A,$82,$22,$86,$34,$32,$34,$81,$04,$22,$26,$2A,$2C,$30,$86,$34   ; $FD61
        .byte $83,$32,$82,$36,$84,$34,$85,$04,$81,$22,$86,$30,$2E,$30,$81,$04   ; $FD71
        .byte $22,$26,$2A,$2C,$2E,$86,$30,$83,$22,$82,$36,$84,$34,$85,$04,$81   ; $FD81
        .byte $22,$86,$3A,$3A,$3A,$82,$3A,$81,$40,$82,$04,$81,$3A,$86,$36,$36   ; $FD91
        .byte $36,$82,$36,$81,$3A,$82,$04,$81,$36,$86,$34,$82,$26,$2A,$36,$81   ; $FDA1
        .byte $34,$34,$85,$34,$81,$2A,$86,$2C,$00,$84,$90,$B0,$84,$50,$50,$B0   ; $FDB1
        .byte $00,$98,$96,$94,$92,$94,$96,$58,$58,$58,$44,$5C,$44,$9F,$A3,$A1   ; $FDC1
        .byte $A3,$85,$A3,$E0,$A6,$23,$C4,$9F,$9D,$9F,$85,$9F,$D2,$A6,$23,$C4   ; $FDD1
        .byte $B5,$B1,$AF,$85,$B1,$AF,$AD,$85,$95,$9E,$A2,$AA,$6A,$6A,$6B,$5E   ; $FDE1
        .byte $9D,$84,$04,$04,$82,$22,$86,$22,$82,$14,$22,$2C,$12,$22,$2A,$14   ; $FDF1
        .byte $22,$2C,$1C,$22,$2C,$14,$22,$2C,$12,$22,$2A,$14,$22,$2C,$1C,$22   ; $FE01
        .byte $2C,$18,$22,$2A,$16,$20,$28,$18,$22,$2A,$12,$22,$2A,$18,$22,$2A   ; $FE11
        .byte $12,$22,$2A,$14,$22,$2C,$0C,$22,$2C,$14,$22,$34,$12,$22,$30,$10   ; $FE21
        .byte $22,$2E,$16,$22,$34,$18,$26,$36,$16,$26,$36,$14,$26,$36,$12,$22   ; $FE31
        .byte $36,$5C,$22,$34,$0C,$22,$22,$81,$1E,$1E,$85,$1E,$81,$12,$86,$14   ; $FE41
        .byte $81,$2C,$22,$1C,$2C,$22,$1C,$85,$2C,$04,$81,$2E,$24,$1E,$2E,$24   ; $FE51
        .byte $1E,$85,$2E,$04,$81,$32,$28,$22,$32,$28,$22,$85,$32,$87,$36,$36   ; $FE61
        .byte $36,$84,$3A,$00,$5C,$54,$4C,$5C,$54,$4C,$5C,$1C,$1C,$5C,$5C,$5C   ; $FE71
        .byte $5C,$5E,$56,$4E,$5E,$56,$4E,$5E,$1E,$1E,$5E,$5E,$5E,$5E,$62,$5A   ; $FE81
        .byte $50,$62,$5A,$50,$62,$22,$22,$62,$E7,$E7,$E7,$2B,$86,$14,$81,$14   ; $FE91
        .byte $80,$14,$14,$81,$14,$14,$14,$14,$86,$16,$81,$16,$80,$16,$16,$81   ; $FEA1
        .byte $16,$16,$16,$16,$81,$28,$22,$1A,$28,$22,$1A,$28,$80,$28,$28,$81   ; $FEB1
        .byte $28,$87,$2C,$2C,$2C,$84,$30,$83,$04,$84,$0C,$83,$62,$10,$84,$12   ; $FEC1
        .byte $83,$1C,$22,$1E,$22,$26,$18,$1E,$04,$1C,$00,$E3,$E1,$E3,$1D,$DE   ; $FED1
        .byte $E0,$23,$EC,$75,$74,$F0,$F4,$F6,$EA,$31,$2D,$83,$12,$14,$04,$18   ; $FEE1
        .byte $1A,$1C,$14,$26,$22,$1E,$1C,$18,$1E,$22,$0C,$14,$FF,$FF,$FF,$00   ; $FEF1
        .byte $88,$00,$2F,$00,$00,$02,$A6,$02,$80,$02,$5C,$02,$3A,$02,$1A,$01   ; $FF01
        .byte $DF,$01,$C4,$01,$AB,$01,$93,$01,$7C,$01,$67,$01,$53,$01,$40,$01   ; $FF11
        .byte $2E,$01,$1D,$01,$0D,$00,$FE,$00,$EF,$00,$E2,$00,$D5,$00,$C9,$00   ; $FF21
        .byte $BE,$00,$B3,$00,$A9,$00,$A0,$00,$97,$00,$8E,$00,$86,$00,$77,$00   ; $FF31
        .byte $7E,$00,$71,$00,$54,$00,$64,$00,$5F,$00,$59,$00,$50,$00,$47,$00   ; $FF41
        .byte $43,$00,$3B,$00,$35,$00,$2A,$00,$23,$04,$75,$03,$57,$02,$F9,$02   ; $FF51
        .byte $CF,$01,$FC,$00,$6A,$05,$0A,$14,$28,$50,$1E,$3C,$02,$04,$08,$10   ; $FF61
        .byte $20,$40,$18,$30,$0C,$03,$06,$0C,$18,$30,$12,$24,$08,$36,$03,$09   ; $FF71
        .byte $06,$12,$1B,$24,$0C,$24,$02,$06,$04,$0C,$12,$18   ; $FF81
        PHP                        ; $FF8D: 08
        .byte $12,$01,$03,$02,$06,$09,$0C,$04,$98,$99,$9A,$9B,$90,$94,$94,$95   ; $FF8E
        .byte $95,$96,$97,$98,$90,$91,$92,$92,$93,$93,$93,$94,$94,$94,$94,$94   ; $FF9E
        .byte $94,$95,$95,$95,$95,$95,$95,$96,$96,$96,$96,$96,$96,$96,$96,$96   ; $FFAE
        .byte $96,$96,$96,$96,$96,$96,$96,$96,$95,$95,$94,$93,$15,$16,$16,$17   ; $FFBE
        .byte $17,$18,$19,$19,$1A,$1A,$1C,$1D,$1D,$1E,$1E,$1F,$1F,$1F,$1F,$1E   ; $FFCE
        .byte $1D,$1C,$1E,$1F,$1F,$1E,$1D,$1C,$1A,$18,$16,$14,$15,$16,$16,$17   ; $FFDE
        .byte $17,$18   ; $FFEE
        ORA a:$1A19,y              ; $FFF0: 19 19 1A
        .byte $1A,$1C,$1D,$1D,$1E,$1E,$1F,$82,$80,$00,$80,$F0,$FF   ; $FFF3
