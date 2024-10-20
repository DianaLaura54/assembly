data segment para public 'data'
sir db "ana are mere$"
len db $-sir
total db  2 dup(?),'$'
nr db ?
data ends
print macro nr
mov ah,09h
mov dx,offset nr
int 21h
endm
code segment para public 'code'
start proc far
assume cs:code,ds:data
push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax
mov si,0
mov dl,0
mov cl,len
mov ch,0
dec cx
count:
mov al,sir[si]
cmp al,'a'
je found
cmp al,'e'
je found
cmp al,'i'
je found
cmp al,'o'
je found
cmp al,'u'
je found
cmp si,cx
je exit
inc si
jmp count
found:
inc dl
cmp si,cx
je exit
inc si
jmp count

exit:
mov nr,dl
mov di,1
mov al,nr
mov bl,10
loop1:
div bl
mov total[di],ah
add total[di],'0'
dec di
mov ah,0
cmp al,0
jne loop1
print total

start endp
code ends
end start

