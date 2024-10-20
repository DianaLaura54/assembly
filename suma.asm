data segment para public 'data'
array db 20 dup(?)
mess1 db "how many numbers(max 20):$"
nr db 3,?, 3 dup(?)
number db 2 dup(?)
number2 db ?
mess2 db 0ah,0dh,"introduce a number:$"
mess3 db 0ah,0dh, "the average is:$"
total db 3,?,3 dup(?)
sum db 0
data ends

print macro message
mov ah,09h
mov dx,offset message
int 21h
endm

read macro nr
mov ah,0ah
mov dx,offset nr
int 21h
endm

convert macro nr,nr2 
mov si,3
mov cl,nr[1]
mov ch,0
mov bl,10
mov ah,0
mov al,nr[si]
dec si
mov dx,0
loop2:
mul bl
sub al,'0'
add dl,al
dec si
loop loop2
mov nr2,dl

endm

convert2 macro nr,nr2
mov bl,10
mov al,nr
mul bl
sub al,'0'
mov nr2,al
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
mov ch,0
mov cl,number
mov si,1
dec cx

loop1:
print mess2
read number2 
convert2 number2,array[si]
add sum,array[si]
inc si
loop loop1


mov al,sum
div number
mov di,2
mov ah,0
mov bl,10

loop3:
div bl
mov total[di],al
add total[di],'0'
mov ah,0
dec di
cmp al,0
jne loop3
print mess3
print total

mov ah,4ch
int 21h
start endp
code ends
start end
