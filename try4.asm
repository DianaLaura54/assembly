data segment para public 'data'
mess1 db "introduce the number:$"
nr db 2,?,2 dup(?)
number db ?
result db ?
total db 2 dup(?), '$'
mess2 db 0ah,0dh,"the text is:$"
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
convert macro nr,number
mov dx,0
mov si,2
mov ax,0
mul bl
mov ch,0
mov cl,nr[1]
change:
mul bl
mov al,nr[si]
sub al,'0'
dec si
loop change
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
read nr
convert nr,number
mov dx,0
mov number,al
mov bl,number
mul bl
add dx,ax
mul bl
add dx,ax
add dx,9
mov result,dl
mov al,result
mov ah,0
mov di,1
mov bl,10
loop1:
div bl
mov total[di],ah
add total[di],'0'
dec di
mov ah,0
cmp al,0
jne loop1
print mess2
print total

mov ah,4ch
int 21h
start endp
code ends
end start
 