data segment para public 'data'
array db 1,2,3,5,7,8
len db $-array
total db 2 dup(?), '$'
nr db 2 dup(?)
mess1 db "The number of odd numbers is: $"
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
mov dx,0
mov bx,0
loop1:
mov al,array[si]
inc dl
call check_even
cmp bl,0
je is_even
cmp dl,len
je next
inc si
loop loop1
is_even:
inc bh
cmp dl,len
je next
inc si
loop loop1
next:
mov bl,10
mov di,1
mov al,bh
mov ch,0
mov cl,len

mov ah,0
scriu:
div bl
mov total[di],ah
add total[di],'0'
dec di
mov ah,0
cmp al,0
jne scriu
print mess1
print total
jmp exit
check_even proc
push ax
mov dh,2
div dh
mov bl,ah
pop ax
RET
check_even endp


exit:mov ah,4ch
int 21h


start endp
code ends
end start