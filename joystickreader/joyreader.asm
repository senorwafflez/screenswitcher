.pc = $0a00

	sei
		lda #$7f
		sta $dc0d
		lda #$81
		sta $d01a

		lda #<irq
		sta $fffe
		lda #>irq
		sta $ffff

		lda #<nmi
		sta $fffa
		lda #>nmi
		sta $fffb

		lda #$1b
		sta $d011
		sta $d012
		sta $d019

		lda #$35
        sta $01
        lda #$00
//        jsr music.init
        cli

		jmp *

nmi:
		rti

irq:	pha
		txa
		pha
		tya
		pha

		lda #$ff
		sta $d019

ddoo:
 //       .byte %00000011
   // .byte %00000010
   // .byte %00000001
        lda #%00000011
		sta $dd00

		lda #$06
		sta $d021
		lda #$00
		sta $d020

		lda #$08
		sta $d016

do18:	
    // .byte %00011000
    // .byte %00001000
    // .byte %00001000
		lda #$14
		sta $d018
		lda #$00
		sta $d015
		lda #$1b
		sta $d011


        lda #$06
        sta $d020
		lda #$ff
		sta $d012
		lda #<irq2
		sta $fffe
		lda #>irq2
		sta $ffff

		pla
		tay
		pla
		tax
		pla
		rti


irq2:	
		pha
		txa
		pha
		tya
		pha

		lda #$ff
		sta $d019
		lda #$00
		sta $d020

		// lda #$14
		// sta $d018
		// lda #$08
		// sta $d016

        inc $d020
        jsr joyreader
        dec $d020

		lda #$02
		sta $d020

	//	dec iloop+1

		lda #$2e
		sta $d012
		lda #<irq
		sta $fffe
		lda #>irq
		sta $ffff

		pla
		tay
		pla
		tax
		pla
		rti

joyreader:
lda $dc00
cmp #$7f
bne storevalue
rts

storevalue:
ldx #$00
sta $0900,x
sta $0400,x
inc storevalue + 1
rts