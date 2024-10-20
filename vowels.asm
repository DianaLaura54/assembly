data segment para public 'data'
text db 20,?,20 dup(?)
mess1 db "introduce the text:$"
mess2 db 0ah,0dh,"the number of vowels:$"
nr db ?
number db 2 dup(?), '$'
data ends
print macro message
mov ah,09h
mov dx,offset message
int 21h
endm
read macro message
mov ah,0ah
mov dx,offset message
int 21h
endm
code segment para public 'code'
assume ds:data,cs:code
start proc far
push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax
print mess1
read text
mov ax,0
mov dx,0
mov cl,text[1]
mov si,2

loop1:
mov al,text[si]
inc dl
inc si
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
cmp dl,cl
je next

jmp loop1

found:
inc dh
cmp dl,cl
je next

jmp loop1

next:
mov nr,dh
print mess2
mov bl,10
mov di,1
mov ah,0
mov al,nr
loop3:
div bl
mov number[di],ah
add number[di],'0'
dec di
mov ah,0
cmp al,0
jne loop3
print number
mov ah,4ch
int 21h

start endp
code ends
end start









