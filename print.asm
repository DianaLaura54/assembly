data segment para public 'data'
m1 db 'the numbers:$'
total DB 10 DUP(?),'$'
data ends
print macro message
mov ah,09h
mov dx,offset message
int 21h
endm
code segment para public 'code'
assume cs:code,ds:data
start proc far
 PUSH DS
	  MOV AX,0
	  PUSH AX
	  
	  MOV AX,DATA
	  MOV DS,AX
print m1
	MOV bl,0
	
		MOV CL,10
		
mov di,0
L1:     
        MOV total[di],bl
        ADD total[di],'0'
       inc di
		INC bl
		LOOP L1
print total

mov ah,4ch
int 21h
start endp
code ends
end start