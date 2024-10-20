COD3 SEGMENT PARA 'CODE' ; code segmentdefinition
PUBLIC PROCED2 ; procedure declaration
 PUBLIC
ASSUME CS: COD3
PROCED2 PROC FAR ; procedure definition
; The instructions of the called procedure

RETF ; back to the procedure which made the call
PROCED2 ENDP ; end procedure
COD3 ENDS ; end segment
 END ; end of second module
-------------------------------------------------------------------- end of second file 