data segment para public 'data'
string1 db "anate testtest harvest $"
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
mov dh,0
cmp al,'t'
je found
inc si
inc dl
cmp dl,cl
je write
jmp find

found:
inc dh
inc dl
cmp dl,cl
je write
inc si
mov al,string1[si]
cmp al,'e'
je found2
cmp al,'e'
jne find

found2:
inc dh
inc dl
cmp dl,cl
je write
inc si
mov al,string1[si]
cmp al,'s'
je found3
cmp al,'s'
jne find

found3:
inc dh
inc dl
cmp dl,cl
je write
inc si
mov al,string1[si]
cmp al,'t'
je found4
cmp al,'t'
jne find


found4:
cmp dh,4
je addnr
cmp dl,cl
je write
cmp dh,4
jne find


addnr:
inc nr
inc si
cmp dl,cl
je write
jmp find


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