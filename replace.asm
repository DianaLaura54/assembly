; Read a string and 2 other characters and replace char1 with char2

data segment para public 'data'
text DB 30,?,30 DUP(?),'$'
char1 DB ?
char2 DB ?
message1 DB "Introduce the text: $"
message2 DB 0Ah,0Dh,"The new text is: $"
mess1 DB 0Ah,0Dh,"Input the first character: $"
mess2 DB 0AH,0Dh,"Input the second character: $"
data ends

print macro message
	mov ah,09h
	mov dx,offset message
	int 21h
endm

readChar macro char
    mov ah,01h
	int 21h
	mov char,al
endm

readString macro text
	mov ah,0Ah
	lea dx,text
	int 21h
endm

printChar macro char
	mov ah,02H
	mov dl,offset char
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
		
		;print message1
		print message1
		
		;read string
		readString text
		
		;print mess1
		print mess1
		
		;read char1
		readChar char1
		
		;print mess2
		print mess2
		
		;read char2
		readChar char2
		
		mov ch,0
		mov cl,text[1]
		mov si,2
		mov bl,char2
		
		find_char: mov al,text[si]
		           cmp al,char1
				   jne not_found
				   mov text[si],bl
				   inc si
				   loop find_char
				   
				   
		 not_found:    cmp cx,0
		               je next
		               inc si
		               loop find_char
		
		next: ;print message
		      print message2
			  
			  ;print the text
			  mov ch,0
			  mov cl,text[1]
			  mov si,2
			  
			  printCharByChar: 	mov bl,text[si]
								printChar bl
								inc si
								loop printCharByChar
			  
			  
ret
start endp
code ends
end start