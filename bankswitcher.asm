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





