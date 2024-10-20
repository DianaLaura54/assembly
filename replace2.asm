data segment para public 'data' 
text db 30,?,30 dup(?),'$'
char1 db ?
char2 db ?
message1 db "introduce the text:$"
message2 db 0ah,0dh,"the new text is:$"
mess1 db 0ah,0dh,"first character:$"
mess2 db 0ah,0dh,"second character:$"
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
readchar macro char
mov ah,01h

int 21h
mov char,al


endm
printchar macro char
mov ah,02h
mov dl,offset char
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
print message1
read text
print mess1
readchar char1
print mess2
readchar char2
mov ch,0
mov cl,text[1]
mov si,2
mov bl,char2

loop1:
mov al,text[si]
cmp al,char1
jne not_found
mov text[si],bl
inc si
loop loop1

not_found:
cmp cx,0
je next
inc si
loop loop1

next:
print message2

mov ch,0
mov cl,text[1]
mov si,2

printme:
mov bl,text[si]
printchar bl
inc si
loop printme

mov ah,4ch
int 21h
start endp
code ends
end start