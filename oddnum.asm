; Determine the number of odd numbers in a declared array
data segment para public 'data'
array DB 1,2,3,4,5,6,7,9,11
len DB $-array
mess1 DB "The number of odd numbers is: $"
nr DB 2 DUP(?) ; maximum 99 numbers
total DB 2 DUP(?),'$'
data ends

print macro message
	mov ah,09h
	mov dx,offset message
	int 21h
endm

code segment para public 'code'
assume ds:data,cs:code

start proc far
	mov ax,data
		mov ds,ax 
		
		mov si,0
		mov ax,0
		mov bx,0   ; use bh for total
		mov dx,0   ; to count them all
		
		
		loop1: mov al,array[si]
	           inc dl
		       call check_odd
			   cmp bl,1
			   je is_odd
			   cmp dl,len
			   je next
			   inc si
               loop loop1
			   
		is_odd: inc bh
		        cmp dl,len
				je next
		        inc si
		        loop loop1
		
		next: 	;prepare nr to be written
		        MOV BL,10
				MOV DI,1 
				MOV AL,bh  ;bh is the number of odd numbers
				MOV AH,0
				mov ch,0
				mov cl,len
				

				LOOP3: 	DIV BL
						MOV total[DI],AH ; ah has the rest
						ADD total[DI],'0' ; trans to ascii
						DEC DI
						MOV AH,0  ; prepare for next iteration
						CMP AL,0 
						JNE LOOP3
		     
			    ;print message
				print mess1
								
				;print the result
				print total
			
			    jmp exit
				check_odd PROC
					push ax
					mov dh,2
					div dh
					mov bl,ah
					pop ax
					RET
				check_odd endp
				

		
		exit:        mov ah,4ch
				    int 21h
					
	start endp
code ends
end start