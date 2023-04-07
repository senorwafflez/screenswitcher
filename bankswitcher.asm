.pc = $4800 "Bank switcher"

bankswitcher:
    lda #$80
    beq switchbank

    dec bankswitcher + 1 
    rts

switchbank:
    lda #$81
    sta bankswitcher + 1

bankselect:
    ldx #$00
    lda bankValues,x
    sta ddoo + 1

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
    .byte %00000001
    .byte %00000000

charValues:
    .byte $14, $14, $14