; example 2 SNES code

.p816
.smart

.include "regs.asm"
.include "variables.asm"
.include "macros.asm"
.include "init.asm"





.segment "CODE"

; enters here in forced blank
Main:
.a16 ; the setting from init code
.i16
	phk
	plb
	

	
; DMA from BG_Palette to CGRAM
	A8
	stz CGADD ; $2121 cgram address = zero

	stz $4300 ; transfer mode 0 = 1 register write once
	lda #$22  ; $2122
	sta $4301 ; destination, cgram data
	ldx #.loword(BG_Palette)
	stx $4302 ; source
	lda #^BG_Palette
	sta $4304 ; bank
	ldx #256 ; BG Palette has 128 colors, 2 bytes each
	stx $4305 ; length
	lda #1
	sta MDMAEN ; $420b start dma, channel 0
	
	
; do it again with the same DMA settings.	
; you will have to reset the source and length, though
; the palette address will auto-increment on each write
	ldx #.loword(BG_Palette)
	stx $4302 ; source
	lda #^BG_Palette
	sta $4304 ; bank
	ldx #256  ; Sprite Palette has 128 colors, 2 bytes each
	stx $4305 ; length
	lda #1
	sta MDMAEN ; $420b start dma, channel 0

	
	lda #FULL_BRIGHT ; $0f = turn the screen on, full brighness
	sta INIDISP ; $2100
	
; note, nothing is active on the main screen,
; so only the main background color will show.
; $212c is the main screen register		

	

Infinite_Loop:	
	
	;code goes here

	jmp Infinite_Loop
	
	
	

	
	

.include "header.asm"	


.segment "RODATA1"

BG_Palette:
.incbin "default.pal"





