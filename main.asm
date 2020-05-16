; example 2 SNES code

.p816
.smart

.include "defines.asm"
.include "macros.asm"
.include "init.asm"





.segment "CODE"

; enters here in forced blank
main:
.a16 ; just a standardized setting from init code
.i16
	phk
	plb
	

	
; DMA from Palette_Copy to CGRAM
	A8
	stz pal_addr ; $2121 cg address = zero

	stz $4300 ; transfer mode 0 = 1 register write once
	lda #$22  ; $2122
	sta $4301 ; destination, pal data
	ldx #.loword(BG_Palette)
	stx $4302 ; source
	lda #^BG_Palette
	sta $4304 ; bank
	ldx #256 ; BG_Palette only has 128 colors
	stx $4305 ; length
	lda #1
	sta $420b ; start dma, channel 0
	
	
; do it again with the same DMA settings.	
; you will have to reset the source and length, though
; the palette address will auto-increment on each write
	ldx #.loword(BG_Palette)
	stx $4302 ; source
	lda #^BG_Palette
	sta $4304 ; bank
	ldx #256  ; BG_Palette only has 128 colors
	stx $4305 ; length
	lda #1
	sta $420b ; start dma, channel 0

	
	lda #FULL_BRIGHT ; $0f = turn the screen on, full brighness
	sta fb_bright ; $2100


InfiniteLoop:	
	jmp InfiniteLoop
	
	

.include "header.asm"	


.segment "RODATA1"

BG_Palette:
.incbin "default.pal"





