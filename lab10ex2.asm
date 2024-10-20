
DATA SEGMENT PARA PUBLIC 'DATA' 
  x_start	dw	20
  x_end		dw	50
  y_start	dw	20
  y_end		dw	50
  colour 	db   7
  var1		db  10
DATA ENDS 

STCK SEGMENT PARA STACK 'stack' use16
	DB 64 DUP ('my_stack')	
STCK ENDS

CODE SEGMENT PARA PUBLIC 'CODE' 
ASSUME CS:CODE, DS:DATA 
START  PROC FAR 
	PUSH DS 
	XOR AX,AX 
	PUSH AX 
	MOV AX,DATA 
	MOV DS,AX 

	MOV AH, 00H 
	MOV AL, 4
	INT 10H

LOOPDOWN:
	mov al,colour	
	mov ah,0ch
	mov cx, x_start	
	drawhoriz:
		mov dx, y_end 
		int 10h
		mov dx, y_start 
		int 10h
		inc cx		
		cmp cx, x_end	
		jne drawhoriz
	drawvert:	
		mov cx, x_start	 
		int 10h
		mov cx, x_end	
		int 10h
		inc dx	
		cmp dx, y_end			
		jne drawvert
	
	ADD x_start, 10
	ADD x_end, 10
	ADD y_start, 10
	ADD y_end, 10
	INC colour
	DEC var1
	CMP var1, 0
	JNE LOOPDOWN
	
    RET   
START  ENDP 
CODE ENDS 
END  START 