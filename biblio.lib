STACK SEGMENT PARA 'STACK'
 DB 64 DUP ('STACK')
STACK ENDS
DATA SEGMENT PARA `DATA`
TAMP DB 2000 DUP (' ')
DATA ENDS

COD1 SEGMENT PARA 'CODE' ;code segment definition
PROCED PROC FAR ;procedure with proced name
 ASSUME CS:COD1, ES: DATA, DS:DATA, SS:STACK
EXTRN INTIRP:NEAR ;extern declaration for INTIRP
 ;procedure
 PUSH DS ;saves ds
 SUB AX, AX ;0 in ax
 PUSH AX ;puts 0 on the stack
 MOV AX, DATA ;puts seg data in ax
 MOV DS,AX
;main program
 MOV AX, 100 ;parameter in ax
 CALL INTIRP ;intirp procedure call
 RET ;gives the control to dos
PROCED ENDP ;procedure end
COD1 ENDS ;code segment end
 END PROCED ;end program
;End of first source file ___________ _____ ______
;Start of second sourse file______________________________
;called procedure
COD1 SEGMENT PARA 'CODE' ;defines code segment
 PUBLIC INTIRP ;public declaration for INTIRP
 ;procedure
 ASSUME CS:COD1
INTIRP PROC NEAR ;intirp procedure name
 PUSH DX ;saves dx şi cx registers
PUSH CX ;
MOV DX, AX ;loads a delay in dx
P1: MOV CX, 0FF00H ;loads 0FF00h in cx
 ;counts
P1: DEC CX ;delays decrementing cx
 JNZ P2 ;if cx!=0 continue
 DEC DX ;if cx=0 decrements dx
 JNZ P1 ;if dx!=0 loads again cx
 POP CX ;if dx=0 restore cx and
 POP DX ;dx
 RET ;return to the main procedure
WORKING WITH MACROS AND LIBRARIES
 101
INTIRP ENDP ;procedure end
COD1 ENDS
END