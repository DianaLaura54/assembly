DATA SEGMENT PARA PUBLIC 'DATA'
SIR DB "Ana are mere$"
DATA ENDS
CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE, DS:DATA
START PROC FAR
PUSH DS 
XOR AX,AX
PUSH AX
MOV AX,DATA
MOV DS, AX
XOR SI,SI
NEXT:  ;loop

  MOV AL, SIR[SI] 
  CMP AL, 61H 
  JNL NOTLESS ;daca litera e mica , deci e > 61 hexa merge la lable-ul notless
  JMP INCREASE ;daca nu, se duce la increase

  NOTLESS:

    CMP AL, 7AH
    JLE NOTGREATER ;verific daca litera e mai < decat z
    JMP INCREASE   ;daca nu e , merge la increase

     NOTGREATER:

        SUB AL, 20H ; daca e litera mica, o transform in litera mare
        MOV SIR[SI], AL ;si o pun iar in sir


   INCREASE:
   
   INC SI 

LOOP NEXT
MOV AH,09H
MOV DX,	OFFSET SIR
INT 21H
RET
START ENDP
CODE ENDS
END START