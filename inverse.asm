data segment para public 'data'
m1 db "sirul este:$"
m2 db "inversul:$"
sir db "ana are mere$"
len db $-sir
inverse db 7 dup(?)
data ends
print macro message
mov ah,09hp
mov dx,offset message
int 21h
endm
code segment para public 'code
assume cs:code,ds:data
start proc far
push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax
print m1
print sir
mov cl,len
mov ch,0
dec cx
mov si,0
mov di,cx
mov bl,'$'
mov inverse[di],bl
dec di
loop1:
mov al,sir[si]
mov inverse[di],al
dec di
inc si
loop loop1
MOV AH,02H
MOV DL,10
INT 21H
print m2
print inverse
mov ah,4ch
int 21h
start endp
code ends
end start