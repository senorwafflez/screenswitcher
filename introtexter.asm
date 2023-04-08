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

colorlinehibyte:
.byte $d8, $d8, $d8, $d8, $d8, $d8, $d8