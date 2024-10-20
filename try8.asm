data segment para public 'data'
array db 1,2,3,4
nr dw $-array
number db 2 dup(?),'$'
dap db ?
data ends
print macro nr
mov ah,09h
mov dx,offset nr
int 21h
endm
code segment para public 'code'

assume cs:code,ds:data
start proc far
push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax
mov di,2
mov si,1
mov cx,nr

try:
mov al,array[si]
cmp al,array[di]
jg change
inc di
cmp si,cx
je write
cmp di,cx
je assign

jmp try

change:
mov dl,array[di]
mov bl,array[si]
mov array[di],bl
mov array[si],dl
inc di
cmp si,cx
je write
jmp try
assign:
inc si
mov dx,si
inc dx
mov di,dx
cmp si,cx
je write
jmp try



write:

mov bl,10
mov di,1
mov ah,0
mov al,10
loop1:
div bl
mov number[di],ah
add number[di],'0'
mov ah,0
dec di
cmp al,0
jne loop1

print number



mov ah,4ch
int 21h
start endp
code ends
end start
 