data segment para public 'data'
mess1 DB "Introduce the number n: $"
nr DB 2,?,2 DUP(?)
number DB ?
result DB ?
theResult DB 2 DUP(?),'$'
mess2 DB 0Ah,0Dh,"The result is: $"
data ends

print macro message
		mov ah,09h
		mov dx,offset message
		int 21h
endm

read macro nr
		mov ah,0Ah
		mov dx,offset nr
        int 21h
endm

;compute from string to number
convert macro nr,number
LOCAL change

	mov dx,0
	mov si,2
	mov ax,0
	mul bl
	mov ch,0
	mov cl,nr[1]
	
	change: mul bl
	        mov al,nr[si]
			sub al,'0'
			dec si
			loop change

	
endm

code segment para public 'code'
assume cs:code, ds:data
start proc far
		push ds
		mov ax,0
		push ax
		
		mov ax,data
		mov ds,ax
		
		;print the message
		print mess1
		
		;read the number
		read nr
		
		;convert the number to a real number
		convert nr,number
		
	   ; compute the sum in dx
	   mov dx,0
	   mov number,al
	   mov bl,number
	   
	   mul bl      ; al*number
	   add dx,ax
	   mul bl      ;al*number*number
	   add dx,ax    
	   add dx,9
	   mov result,dl
	   
	   ;make result printable
	   
	   mov al,result
	   mov ah,0
	   mov di,1   ; for theResult
	   mov bl,10
	   
	   loop1:  div bl
	           mov theResult[di],ah    ;ah stores the quotient
			   add theResult[di],'0'
			   dec di
			   mov ah,0  				; for the next iteration
			   cmp al,0
			   jne loop1
	   
	    ;print a message
	    print mess2
		
		;print the result
		print theResult
		
ret
start endp
code ends
end start