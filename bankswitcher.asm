.pc = $0f00 "Bank switcher"
.var delayswitch = $11

bankswitcher:
    lda #$10
    beq switchbank

    dec bankswitcher + 1 
    rts

switchbank:
    lda #delayswitch
    sta bankswitcher + 1

bankselect:
    ldx #$00
    lda bankValues,x
    sta ddoo + 1
    lda charValues,x
    sta do18 + 1

    inc bankselect + 1
    lda bankselect + 1
    cmp #$03
    bne banknotreset

    lda #$00
    sta bankselect + 1

 banknotreset:   
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