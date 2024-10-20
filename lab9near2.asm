COD1 SEGMENT PARA 'CODE' ; segment code definition
PUBLIC PROCED1
PUBLIC
ASSUME CS: COD1
PROCED1 PROC NEAR ; procedure definition

;The instructions of the called procedure
 RETN ; coming back to the procedure,

PROCED1 ENDP ; end procedure
COD1 ENDS ; end segment
 END ; end of second module