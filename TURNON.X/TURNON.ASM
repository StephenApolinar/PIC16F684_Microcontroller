; File TURNON.ASM
; Assembly code for PIC16F84 microcontroller

; Turns on an LED connected to B0
; Uses crystal oscillator, about 3.63 MHz

; CPU configuration
; (It's a 16F84, crystal oscillator, 
; watchdog timer off, power-up timer on.)

; PIC16F84A Configuration Bit Settings
; Assembly source line config statements
#include "p16f84a.inc"

; CONFIG
; __config 0xFFF1
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _CP_OFF


; Program

		org		0		; start at address 0

		; At startup, all ports are inputs.
		; Set Port B to all outputs.

		movlw	B'00000000'		; w := binary 00000000
		tris	PORTB			; copy w to port B control reg

		; Put a 1 in the lowest bit of port B.

		movlw	B'00000001'		; w := binary 00000001
		movwf	PORTB			; copy w to port B itself
		; Stop by going into an endless loop

fin:	goto	fin
		end						; program ends here	
