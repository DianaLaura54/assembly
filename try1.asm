data segment para public 'data'
array DB 2,3,5,4,4,4,3,3,7,8,9,10,1,2,2,2,2,8,20 
len db $-array
message db 'the nr of even elements is:$'
nr db 2 dup(?)
total db 2 dup(?),'$'
data ends
print macro message
mov ah,09h
mov dx,offset message
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
mov ch,0
mov cl,len
mov dl,0
mov bl,2
mov si,0
try:
mov al,array[si]
div bl
cmp ah,0
jne not_even
cmp ah,0
je yes_even
not_even:
inc si
mov ax,0
loop try
yes_even:
inc si
inc dl
mov ax,0
loop try
mov nr,dl
mov al,nr
mov bl,10
mov ah,0
mov di,1
write:
div bl
mov total[di],ah
add total[di],'0'
mov ah,0
dec di
cmp al,0
jne write
print message
print total


mov ah,4ch
int 21h
start endp
code ends
end start
