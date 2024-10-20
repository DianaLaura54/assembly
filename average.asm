data segment public 'data'
array db 2,2,3
len db $-array
mess1 db 'the sum is:', '$'
sum db 2 dup(?)
result db 2 dup(?),'$'
data ends
print macro message
mov ah,09h
mov dx,offset message
int 21h
endm
code segment public 'code'
assume ds:data,cs:code
start proc far
push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax
xor cx,cx
mov cl,len
mov ax,0
mov si,0
mov sum,0
calculate:
mov al,array[si]
add sum,al
inc si
loop calculate
mov al,sum
div len
mov sum,al
print mess1
mov bl,10
mov al,sum
mov ah,0
mov di,1
afisare:
div bl
mov result[di],ah
add result[di],'0'
mov ah,0
dec di
cmp al,0
jne afisare
print result
mov ah,4ch
int 21h
start endp

code ends
end start
