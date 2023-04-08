.pc = $1700 "Introtexter"

.var fadelength = $1d

introtexter:
    nop
    ldx #$00
loadfadeincol:
    lda introfadercolors
introfadein:
    sta $d800,x
    inx
    cpx #$28
    bne introfadein

    inc loadfadeincol + 1
    lda loadfadeincol + 1
    cmp #fadelength
    beq fadeinnextline
    rts

fadeinnextline:
    lda #$00
    sta loadfadeincol + 1

    inc linesdone
    lda linesdone
    cmp #25
    beq stopfadein

stopfadenext:
    nop

    ldx linesdone
    lda colorlinelobyte,x
    sta introfadein + 1
    lda colorlinehibyte,x
    sta introfadein + 2
    rts

stopfadein:
    lda #$60
    sta introtexter
    sta stopfadenext

    lda #$ea
    sta spaceroutine
    rts

linesdone:
    .byte $00

//------- PRESS SPACE ROUTINE ---------------

.var spaceframedelay = $02

spaceroutine:
    rts

spacecheckdelay:
    lda #spaceframedelay
    beq checkspace

    dec spacecheckdelay + 1
    rts

checkspace:
    lda #spaceframedelay
    sta spacecheckdelay + 1

    lda $dc01
    cmp #$ef
    beq spaceispressed
    rts

spaceispressed:
    lda #$ea
    sta setgraphicsinit
    rts

setgraphicsinit:
    rts

    lda #$60
    sta setgraphicsinit
    lda #$ea
    sta setgraphicsinit2
    
    jsr graphicsinit

    rts

setgraphicsinit2:
    rts

    lda #$60
    sta setgraphicsinit2
    lda #$ea
    sta switchinterrupttomain
    
    jsr graphicsinit2

    rts


switchinterrupttomain:
    rts

    lda #$60
    sta switchinterrupttomain

	lda #<irq
	sta irq1_lo+1
	lda #>irq
	sta irq1_hi+1
    rts

.pc = $4e00 "Introfader colors"
introfadercolors:
.byte $06, $06, $06, $06, $06, $06
.byte $04, $04, $04, $04, $04, $04
.byte $0e, $0e, $0e, $0e
.byte $0f, $0f, $0f
.byte $01, $01
.byte $0f, $0f, $0f
.byte $0e, $0e, $0e, $0e, $0e, $0e

.fill $e2, $0e

.pc = $4f00 "Colorlines"
colorlinelobyte:
.byte $00, $28, $50, $78, $a0, $c8, $f0
.byte $18, $40, $68, $90, $b8, $e0
.byte $08, $30, $58, $80, $a8, $d0, $f8
.byte $20, $48, $70, $98, $c0, $e8

colorlinehibyte:
.byte $d8, $d8, $d8, $d8, $d8, $d8, $d8
.byte $d9, $d9, $d9, $d9, $d9, $d9
.byte $da, $da, $da, $da, $da, $da, $da
.byte $db, $db, $db, $db, $db, $db