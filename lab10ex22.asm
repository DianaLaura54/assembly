;------------------------------------------------- 
; DATA section 
; data definitions 
;------------------------------------------------- 
DATA SEGMENT PARA PUBLIC 'DATA' 

DATA ENDS 
;------------------------------------------------- 
; STACK section 
;------------------------------------------------- 
STCK SEGMENT PARA STACK 'stack' use16
	DB 64 DUP ('my_stack')	; reserve 256 bytes for stack
STCK ENDS
;------------------------------------------------- 
; CODE section 
;------------------------------------------------- 
CODE SEGMENT PARA PUBLIC 'CODE' 
ASSUME CS:CODE, DS:DATA 
START  PROC FAR 
	PUSH DS 
	XOR AX,AX 
	PUSH AX 
	MOV AX,DATA 
	MOV DS,AX 
;------------------------------------------------- 
;... ... the main program's instructions 
;------------------------------------------------- 
    RET   ; FAR return to DOS 
START  ENDP 
CODE ENDS 
END  START 