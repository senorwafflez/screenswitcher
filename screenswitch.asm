.var music = LoadSid("joy.sid")
.pc = music.location "Music"
.fill music.size, music.getData(i)

.import source "bankswitcher.asm"
.import source "introtexter.asm"

.var debug = false
.var indicator = true

.pc = $0801 "Program Start"
:BasicUpstart($0900)

.pc = $0900 "Main interrupt"

		jsr graphicsinit
		sei
		lda #$7f
		sta $dc0d
		lda #$81
		sta $d01a

		lda #<introirq
		sta $fffe
		lda #>introirq
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
        jsr music.init
        cli

iloop:	
        lda #$00
		beq wait

		lda #$00
		sta iloop+1

wait:
		jmp iloop

nmi:
		rti

irq:	pha

tajmat:
		jsr stabilize_raster

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

                ldy #$05
                dey
                bne * - 1
                nop

		lda #$0e
		sta $d020

		lda #$08
		sta $d016

do18:	
		lda #%00011000
		sta $d018
		lda #$00
		sta $d015
		lda #$3b
		sta $d011


      //  lda #$06
     //   sta $d020

        .if (debug)
        {
                inc $d020
        }

        jsr music.play

        .if (debug)
        {
                dec $d020
        }


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
		// lda #$00
		// sta $d020

		// lda #$14
		// sta $d018
		// lda #$08
		// sta $d016

        .if (debug)
        {
                inc $d020
        }

        jsr bankswitcher
    //    jsr fadeout
        
        .if (debug)
        {
                dec $d020
        }

	//	lda #$02
	//	sta $d020
.if (indicator)
    {
        split1:
        lda $d012
        cmp #$08
        bne split1


        lda bordercolor
        sta $d020

        split2:
        lda $d012
        cmp #$18
        bne split2

        lda #$0e
        sta $d020

    }
		dec iloop+1

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

bordercolor:
        .byte $00
//-------------------INTRO IRQ ----------
introirq:	pha

		jsr stabilize_raster

		txa
		pha
		tya
		pha

		lda #$ff
		sta $d019

                lda #%00000011
		sta $dd00

                ldy #$05
                dey
                bne * - 1
                nop

		lda #$0e
		sta $d020
                nop
                bit $ea

                lda #$06
		sta $d021

		lda #$08
		sta $d016

		lda #$14
		sta $d018
		lda #$00
		sta $d015
		lda #$1b
		sta $d011


      //  lda #$06
     //   sta $d020

        .if (debug)
        {
                inc $d020
        }

        jsr music.play

        .if (debug)
        {
                dec $d020
        }

introsplit1:
                lda $d012
                cmp #$f0
                bne introsplit1

                .if (debug) {
                        lda #$02
                        sta $d020
                        inc $d020
                }

                jsr introtexter

                .if (debug) {
                        dec $d020
                }

		lda #$32
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
//-------------------STABILIZE CODE -----

stabilize_raster:      
        ldx #$ff
        ldy #$00
        stx $dc00
        sty $dc02
        stx $dc03
        stx $dc01
        sty $dc01
        stx $dc01
        lda $d013
        stx $dc02
        sty $dc03
        stx $dc01

        ldx #$7f
        stx $dc00
        lsr 
        lsr 
        lsr 
        sta timeout+1
        bcc timing
timing: clv
timeout:
        bvc timeout
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
         
        nop
        nop
        nop
        nop
        nop
        
        lda $d012 
        and #%00000111 
        tax
        lda delay,x         
        tax
        dex
        bne *-1
stabilizer_raster_000:        
        rts

delay: .byte 1,1,1,1,$10,$10,1,1

init:
	lda #$36
	sta $01
	lda #$93
	jsr $ffd2
        lda #$0e
        sta $d020
        lda #$06
        sta $d021

        lda #$00
        sta bankselect + 1

        ldx #$00
        lda #$00
setinitialcolor:
        sta $d800,x
        sta $d900,x
        sta $da00,x
        sta $db00,x
        inx
        bne setinitialcolor

        ldx #$00
setinitialtext:
        lda introtext,x
        sta $0400,x
        lda introtext + $100,x
        sta $0500,x
        lda introtext + $200,x
        sta $0600,x
        lda introtext + $300,x
        sta $0700,x
        inx
        bne setinitialtext
        rts
graphicsinit:
        ldx #$00
set0400:
        lda $4400,x
        sta $0400,x
        lda $4500,x
        sta $0500,x
        lda $4600,x
        sta $0600,x
        lda $4700,x
        sta $0700,x
        inx
        bne set0400 

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

.pc = $2000 "Picture 1 Chars"
.import c64 "love1char.prg"

.pc = $4400 "Picture 1 Screen"
.import c64 "love1screen.prg"

.pc = $4000 "Picture 2 Screen"
.import c64 "love2screen.prg"

.pc = $6000 "Picture 2 Chars"
.import c64 "love2char.prg"

.pc = $8000 "Picture 3 Screen"
.import c64 "love3screen.prg"

.pc = $a000 "Picture 3 Chars"
.import c64 "love3char.prg"

.pc = $4900 "Introtext"
introtext:
.import c64 "triggerwarning2.prg"



