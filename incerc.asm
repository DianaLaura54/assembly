DATA SEGMENT PARA PUBLIC 'DATA' 
VECTOR DW 5,3,7,8,9,4
Len equ $-VECTOR
VAR DW 1
DATA ENDS
CODE SEGMENT PARA PUBLIC 'CODE' 
ASSUME CS:CODE, DS:DATA 
START  PROC FAR 
	PUSH DS 
	XOR AX,AX 
	PUSH AX 
	MOV AX,DATA 
	MOV DS,AX 
	MOV SI,0
inmultire:
mov ax,vector[si]
mov dh,2
div dh
mov bl,ah
cmp bl,1
je is_odd
cmp dl,Len
inc si
inc si
loop inmultire
is_odd:
mov ax,var
mul vector[si]
mov var,ax
loop inmultire

				
MOV DX,	OFFSET Len
MOV AH,4CH
INT 21H
			
	
    	RET 
START  ENDP 
CODE ENDS 
END  START 