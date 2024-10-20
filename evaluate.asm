; compute n*3 + n*2 +9 

data segment para public 'data'

nr DB 2,?,2 DUP(?)
new_nr DB 0
result DB 0
theResult DB 3 DUP(?),'$'
mess1 DB "Introduce the number n: $"
mess2 DB 0Ah,0Dh,"The result is: $"
;0ah is equivalent to 10 in decimal and to linefeed ('\n') 
;in ASCII which moves the cursor to the next row of the screen 
;but maintaining the same column. 0dh is quivalent to 13 in 
;decimal and to carriage return ('\r') in ASCII which moves the cursor to 
;the beginning of the current row. 
;A combination of the two thus moves the cursor to the beginning of
;the next row of the screen.


data ends

print macro message
	mov ah,09h
	mov dx,offset message
	int 21h
endm

read macro number
	mov ah,0Ah
	mov dx,offset number
	int 21h
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
		
		;read number
		read nr
		
		;transform the string to a real number
		mov ch,0
	mov cl,nr[1]
	mov si,2
	mov bl,10
	mov ax,0
	iterations: mul bl
				mov dl,nr[si]
				sub dl,'0'
				add al,dl
				inc si
				loop iterations
	mov new_nr,al
		
	;compute the result
      	
		mov bl,9    ; the sum is 9
        mov bh,0   ; compute the sum in BX
		
		mov ah,0
		mov al,new_nr
		shl ax,1             ;multiply by 2
		add bx,ax 			; add to bl 2*n
		add al,new_nr
		add bx,ax          ; add to bl 3*n
		
       ;save the result
	   mov result,bl
	   
	   ;prepare result to be written
	   mov di,2
	   mov ah,0
	   mov al,result
	   mov bl,10
	   
	   loooop: div bl
	           mov theResult[di],ah
			   add theResult[di],'0'
			   dec di
			   mov ah,0 ;for the next iterations
			   cmp al,0
			   jne loooop
		
		;print message
		print mess2
		
		;print the result
		print theResult
		
ret
start endp
code ends
end start
