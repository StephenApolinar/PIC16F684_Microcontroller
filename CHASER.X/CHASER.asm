; File CHASER.ASM
; Blinks LEDs on outputs (Port B) in a rotating pattern.
; Reverses direction if port A, Bit 0, is high.
	
; PIC16F84A Configuration Bit Settings
; Assembly source line config statements
    #include "p16f84a.inc"

; CONFIG
; __config 0xFFF1
    __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _CP_OFF

; Give names to 2 memory locations (registers)
J	equ	H'1F'	; J = address hex 1F
K	equ	H'1E'	; K = address hex 1E

; Program
	org	0	; start at address 0
	; Set Port B to output and initialize it.
	movlw	B'00000000'	; w := binary 00000000
	tris	PORTB		; copy w to port B control reg
	movlw	B'00000001'	; w := binary 00000001
	movwf	PORTB		; copy w to port B itself
	bcf	STATUS, C	; clear the carry bit

; Main loop.  Check Port A, Bit 0, and rotate either left 
; or right through the carry register.
mloop:
	btfss	PORTA, 0	; skip next instruction if bit = 1
	goto	m1
	rlf	PORTB, f	; rotate port B bits to left
	goto	m2
m1:
	rrf	PORTB, f	; rotate port B bits to right
m2:

; Waste some time by executing nested loops
	movlw	D'50'		; w := 50 decimal
	movwf	J		; J := w
jloop:	movwf	K		; K := w
kloop:	decfsz	K, f		; K := K - 1, skip next if zero
	goto	kloop
	decfsz	J,f		; J := J-1, skip next if zero
	goto	jloop
	goto	mloop		; do it all again
	end			; program ends here