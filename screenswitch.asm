.var music = LoadSid("joy.sid")
.pc = music.location "Music"
.fill music.size, music.getData(i)

.import source "bankswitcher.asm"
.var debug = false
.var indicator = true

.pc = $0801 "Program Start"
:BasicUpstart($0900)

.pc = $0900 "Main interrupt"

		jsr init
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
		lda #$00
		sta $d020
		sta $d021

        lda #$00
        sta bankselect + 1

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

//TODO : load directly add address
// set4000:
//         lda $7f40,x
//         sta $4000,x
//         lda $8040,x
//         sta $4100,x
//         lda $8140,x
//         sta $4200,x
//         lda $8240,x
//         sta $4300,x
//         inx
//         bne set4000 

// set8000:
//         lda $bf40,x
//         sta $8000,x
//         lda $c040,x
//         sta $8100,x
//         lda $c140,x
//         sta $8200,x
//         lda $c240,x
//         sta $8300,x
//         inx
//         bne set8000 
        rts

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

