.ORG	0X0000
    
    .def regaux	=r16
    
    ;enable port D 1 to input
    ;enable transistor pull-up
    LDI	regaux, 0B11111101
    OUT DDRD, regaux    
    LDI	regaux, 0B00000010
    OUT PORTD, regaux        
    NOP
        
LOOP:
    SBIC PIND, PD1 
    RJMP OFF_LED
    RJMP ON_LED
    
OFF_LED:
    CBI PORTD, 7 
    RJMP LOOP
    
ON_LED:
    SBI PORTD, 7
    RJMP LOOP