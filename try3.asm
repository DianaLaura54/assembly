data segment para public 'data'
text db 30,?,30 dup(?),'$'
char1 db ?
char2 db ?
mess1 db "the text:$"
mess2 db 0ah,0dh,"the next now:$"
message1 db 0ah,0dh,"the first char:$"
message2 db 0ah,0dh,"the second char:$"
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
read2 macro char
mov ah,01h
int 21h
mov char,al
endm
print2 macro char
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
print mess1
read text
print message1
read2 char1
print message2
read2 char2
mov ch,0
mov cl,text[1]
mov si,2
mov bl,char2
replace:
mov al,text[si]
cmp al,char1
jne not_found
mov text[si],bl
inc si
loop replace
not_found:
cmp cl,0
je next
inc si
loop replace
next:
print mess2
mov ch,0
mov cl,text[1]
mov si,2
printt:
mov bl,text[si]
print2 bl
inc si
loop printt


mov ah,4ch
int 21h
start endp
code ends
end start
