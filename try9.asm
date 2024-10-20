data segment para public 'data'
SIR DB 2,3,5,4,4,4,3,3,7,8,9,10,1,2,2,2,2,8,20
SIR2 DB 5,6,3,6,10,2,1
SIR3 DB ?
LGSIR Db $-SIR 
max DB 0
total db 2 dup(?),'$'
data ends
code segment para public 'code'
print macro nr
mov ah,09h
mov dx,offset nr
int 21h
endm
assume cs:code,ds:data
start proc far
push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax
mov si,0
mov ch,0
mov cl,lgsir
mov dl,0
maxim:
mov al,sir[si]
cmp al,max
jg assign
inc si
inc dl
cmp dl,cl
je write
jmp maxim
assign:
mov max,al
inc si
inc dl
cmp dl,cl
je write
jmp maxim
write:
mov bl,10
mov al,max
mov di,1
mov ah,0

loop1:
div bl
mov total[di],ah
add total[di],'0'
mov ah,0
dec di
cmp al,0
jne loop1
print total


mov ah,4ch
int 21h
start endp
code ends
end start
 
 