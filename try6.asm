data segment para public 'data'
string1 db "ana test $"
len db $-string1
nr db 0
number db 2 dup(?),'$'
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
mov ch,0
mov cl,len
mov si,1
mov dl,0
mov dh,0
find:
mov al,string1[si]
cmp al,'t'
je found
je write
found:
inc dl



yes:
inc nr




write:
mov bl,10
mov di,1
mov al,nr
mov ah,0
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
 