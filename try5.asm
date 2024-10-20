; Compute the number of positive and negative numbers

DATA SEGMENT PARA PUBLIC 'DATA'
array DB -3,1,-5,6,-7,9,10,4
len DB $-array
p DB 0
n DB 0
mess1 DB "NO OF POSITIVE NUMBERS: $"
mess2 DB 0AH,0DH,"NO OF NEGATIVE NUMBERS: $"
pos DB 2 DUP(?),'$'
negat DB 2 DUP(?),'$'
DATA ENDS

;define a macro which prints the string received as parameter

print macro msg
  mov ah,09h
  lea dx,msg
  int 21h
endm

;define a macro that prepares a number to be displayed

prepare macro built,nr
LOCAL iterate
MOV BL,10
MOV DI,1 
MOV AL,nr
MOV AH,0

iterate:
       DIV BL
       MOV built[DI],AH ; ah has the rest
	   ADD built[DI],'0' ; trans to ascii
	   DEC DI
	   MOV AH,0  ; prepare for next iteration
	   CMP AL,0 
	   JNE iterate
endm

CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME DS:DATA,CS:CODE

START:  PUSH DS
        MOV AX,0
		PUSH AX
		
		MOV AX,DATA
		MOV DS,AX
		
	    MOV CH,0
		MOV CL,len
		MOV SI,0
		
		MOV BH,0  ; BH for positive count BL for negative count
		
		LOOP2:  MOV AL,array[SI]
		        INC SI
		        CMP AL,0
				JGE nr_pos
				CMP AL,0
				JL nr_neg
				
		nr_pos: INC BH
		        CMP CX,1
				JE next      ; end of array
		        LOOP LOOP2
				
		nr_neg: INC BL
		        CMP CX,1
				JE next      ; end of array
		        LOOP LOOP2
				
	    next: 
				;save the computed values
				MOV p,BH
				MOV n,BL
					
				;print message1
		        print mess1
				
				;transform nr
				prepare pos,p
				
				;print the number of positive
				print pos
				
				;print message2
		        print mess2
				
				;transform nr
				prepare negat,n
				
				;print the number of positive
				print negat
				
				MOV AH,4Ch
				INT 21H
	
CODE ENDS
END START