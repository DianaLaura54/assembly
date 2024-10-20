data segment para public 'data'
array db 5,6,7,3,2,9
len db $-array
nr db ?
total db 2 dup(?),'$'
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
mov si,0
mov bl,2
mov ax,0
mov dl,0
mov cl,len
mov ch,0
dec cx
count:
mov al,array[si]
div bl
cmp ah,0
jne not_even
cmp ah,0
je nr_even
not_even:
cmp si,cx
je next
inc si
mov ax,0
jmp count
nr_even:
inc dl
cmp si,cx
je next
inc si
mov ax,0
jmp count
next:
mov nr,dl
mov al,nr
mov ah,0
mov di,1
mov bl,10
loop1:
div bl
mov total[di],ah
add total[di],'0'
inc di
mov ah,0
cmp al,0
jne loop1

print total

 mov ah,4ch
 int 21h



start endp
code ends
end start