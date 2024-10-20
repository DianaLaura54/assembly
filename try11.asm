
data segment para public 'data'

array db 1,2,7,4,5
array2 db 6,7,6,9,2
array3 db 0,0,0,0,0
total db 2 dup(?),'$'
len db $-array
nr db 10
data ends


code segment para public 'code'
start proc far
assume ds:data,cs:code

push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax
mov cl,len
mov si,0
mov ch,0

find:
mov dl,array[si]
mov bl,array2[si]
cmp dl,bl
jg create

mov array3[si],bl
cmp si,cx
je next
inc si
jmp find

create:
mov array3[si],dl
cmp si,cx
je next
inc si
jmp find



next:

mov cx,5
    mov si,0

print:

    Mov al,array3[si]
    Add al,30h
    Mov ah,0eh
    Int  10h 
    MOV AH,2
    Mov DL , ' '
    INT 21H
 inc si
 loop print

	  
	  MOV AH,4CH
	  INT 21H
start endp
code ends
end start
