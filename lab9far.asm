
STAC SEGMENT PARA STACK 'stack' ;stack segment definition
 db 64 dup ('MY_STACK')
STAC ENDS
DATE SEGMENT PARA PUBLIC 'DATA' ; data segment definition
 ;… data definition
DATE ENDS
COD2 SEGMENT PARA PUBLIC 'CODE' ; code segment definition
EXTRN PROCED2:FAR
PRPRINC2 PROC FAR ; main procedure definition
ASSUME CS: COD2, DS: DATE, SS:STAC, ES:NOTHING


 PUSH DS ; prepare stack
 SUB AX, AX ; to return
 PUSH AX ; to DOS
 MOV AX, DATE ; load register
 MOV DS, AX ; DS with data segment
; The main procedure’s instructions
 CALL PROCED2 ; procedure call
; Other instructions
 RET ; coming back to DOS
PRPRINC2 ENDP ; end procedure
COD2 ENDS ; end segment
 END PRPRINC2 ; end of the first module
------------------------------------------------------------------------------- end of first file