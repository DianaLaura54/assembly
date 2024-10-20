; determine the number of even numbers in a declared array

DATA SEGMENT PARA PUBLIC 'DATA'
array DB 2,3,5,4,4,4,3,3,7,8,9,10,1,2,2,2,2,8,20  
len DB $-array     ; len is 7 because last number represents the total number of elements in the array
nr DB 2 DUP(?)
total DB 2 DUP(?),'$'
message DB 'The number of even elements is: $'
DATA ENDS 

CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE,DS:DATA
START:
      PUSH DS
	  MOV AX,0
	  PUSH AX
	  
	  MOV AX,DATA
	  MOV DS,AX
	  
	  ;print the message
	  MOV AH,09H
	  MOV DX,OFFSET message
	  int 21h
	  
	  ;compute nr
	  MOV CH,0
	  MOV CL,len
	  DEC CX
	  
	  MOV AX,0 
	  MOV SI,0
	  MOV BL,2
	  MOV DL,0
	  
	  ITERATIONS: MOV AL,array[SI]
				  DIV BL
				  CMP AH,0
				  JNE not_even
				  CMP AH,0
				  JE yes_even
				  
	 
	  not_even: INC SI
	            MOV AX,0
	            LOOP ITERATIONS 
				
	  yes_even: INC SI
	            INC DL
				MOV AX,0
				LOOP ITERATIONS
	  
MOV nr,DL

; prepare nr to be written
MOV AL,nr
MOV AH,0
MOV BL,10
MOV DI,1   ;FROM RIGHT TO LEFT

loop1: DIV BL
       MOV total[DI],AH
	   ADD total[DI],'0'
	   MOV AH,0
	   DEC DI
	   CMP AL,0
	   JNE loop1

;print the sum
MOV AH, 09H
MOV DX,OFFSET total
int 21h
	  
	  MOV AH,4CH
	  INT 21H
	  
CODE ENDS
END START