.pc = $0f00 "Bank switcher"
.var delayswitch = $04

bankswitcher:
    lda #$04
    beq switchbank

    dec bankswitcher + 1 
    rts

switchbank:
    lda #delayswitch
    sta bankswitcher + 1

bankselect:
    ldx selectorList
    lda bankValues,x
    sta ddoo + 1
    lda charValues,x
    sta do18 + 1

    inc bankselect + 1
    lda bankselect + 1
    cmp #$00
    beq loopdone
 banknotreset:   
    rts

loopdone:
    inc bordercolor
    rts

bankValues:
    .byte %00000011
    .byte %00000010
    .byte %00000001

charValues:
    //.byte $14, $14, $18
    .byte %00011000
    .byte %00001000
    .byte %00001000

fadeout:
    ldx #$00
setfadecol:
    lda fadecolors
setfadecol2:    
    sta $0400,x
    sta $4400,x
    sta $8400,x
    sta $0428,x
    sta $4428,x
    sta $8428,x
    sta $0450,x
    sta $4450,x
    sta $8440,x
    sta $0478,x
    sta $4478,x
    sta $8478,x
    sta $04a0,x
    sta $44a0,x
    sta $84a0,x
    sta $04c8,x
    sta $44c8,x
    sta $84c8,x
    sta $04f0,x
    sta $44f0,x
    sta $84f0,x
    inx
    cpx #$14
    bne setfadecol2

    inc setfadecol + 1
    rts

.pc = $4800 "Selector List"
selectorList:
.byte $02, $00, $00, $01, $02, $01, $00, $01, $02, $02, $01, $02, $02, $02, $01, $02
.byte $00, $01, $01, $00, $00, $01, $00, $02, $02, $01, $02, $00, $02, $02, $01, $02
.byte $00, $02, $02, $01, $02, $02, $02, $00, $01, $00, $01, $02, $01, $01, $02, $02
.byte $00, $01, $01, $01, $02, $00, $02, $01, $02, $02, $02, $00, $00, $01, $02, $01
.byte $00, $01, $02, $01, $02, $01, $00, $00, $00, $01, $01, $02, $00, $01, $00, $01
.byte $00, $00, $01, $02, $02, $00, $00, $01, $01, $01, $02, $02, $02, $00, $02, $02
.byte $02, $02, $01, $00, $01, $02, $02, $00, $01, $02, $01, $01, $01, $02, $00, $02
.byte $00, $00, $01, $01, $02, $00, $01, $02, $02, $02, $00, $01, $02, $00, $01, $02
.byte $00, $02, $00, $01, $02, $02, $00, $02, $02, $00, $02, $02, $02, $00, $02, $00
.byte $02, $00, $02, $02, $02, $01, $01, $02, $00, $00, $02, $01, $00, $02, $02, $02
.byte $01, $01, $00, $01, $02, $00, $00, $02, $02, $01, $00, $01, $02, $02, $02, $00
.byte $01, $01, $01, $02, $02, $02, $02, $02, $00, $01, $02, $02, $00, $02, $02, $01
.byte $02, $01, $02, $02, $02, $01, $02, $01, $01, $01, $02, $02, $00, $00, $02, $02
.byte $02, $01, $00, $02, $00, $02, $02, $00, $01, $02, $00, $01, $00, $01, $01, $01
.byte $00, $01, $00, $02, $00, $01, $02, $01, $00, $00, $02, $00, $01, $01, $02, $00
.byte $02, $02, $02, $00, $01, $02, $00, $01, $02, $02, $01, $02, $02, $02, $02, $00


.pc = $4900 "Fade colors"
fadecolors:
.byte $e0, $e0, $e0, $e0, $e0, $e0, $e0, $e0
.byte $40, $40, $40, $40, $40, $40, $40, $40
.byte $60, $60, $60, $60, $60, $60, $60, $60

.fill $ff, $60


