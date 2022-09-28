.ORG 0X0000

    LDI	    R20, 0B11111111
    OUT	    DDRD, R20

    LDI	    dd8u, 5
    LDI	    dv8u, 2

    RCALL   div8u

    LDI	    R20,0

    CPSE    drem8u, R20
    RJMP    ODD
    RJMP    EVEN
    
LOOP:
    RJMP    LOOP
    
ODD:
    SBI	    PORTD, 7
    RJMP    LOOP
    
EVEN:
    SBI	    PORTD, 4
    RJMP    LOOP

    
;***************************************************************************
;*
;* "div8u" - 8/8 Bit Unsigned Division
;*
;* This subroutine divides the two register variables "dd8u" (dividend) and
;* "dv8u" (divisor). The result is placed in "dres8u" and the remainder in
;* "drem8u".
;*
;* Number of words	:14
;* Number of cycles	:97
;* Low registers used	:1 (drem8u)
;* High registers used  :3 (dres8u/dd8u,dv8u,dcnt8u)
;*
;***************************************************************************

;***** Subroutine Register Variables

.def	drem8u	=r15		;remainder
.def	dres8u	=r19		;result
.def	dd8u	=r16		;dividend
.def	dv8u	=r17		;divisor
.def	dcnt8u	=r18		;loop counter

;***** Code

div8u:	sub	drem8u,drem8u	;clear remainder and carry
	ldi	dcnt8u,9	;init loop counter
d8u_1:	rol	dd8u		;shift left dividend
	dec	dcnt8u		;decrement counter
	brne	d8u_2		;if done
	ret			;    return
d8u_2:	rol	drem8u		;shift dividend into remainder
	sub	drem8u,dv8u	;remainder = remainder - divisor
	brcc	d8u_3		;if result negative
	add	drem8u,dv8u	;    restore remainder
	clc			;    clear carry to be shifted into result
	rjmp	d8u_1		;else
d8u_3:	sec			;    set carry to be shifted into result
	rjmp	d8u_1
	

