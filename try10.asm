data segment para public 'data'
array  db 1,2,3,4,5,6,7
count  dw 7
data ends

code segment para public 'code'

assume cs:code,ds:data
start proc far
push ds
xor ax,ax
push ax
mov ax,data
mov ds,ax






    mov cx,count      
    dec cx               ; outer loop iteration count

nextscan:                ; do {    // outer loop
    mov bx,cx
    mov si,0 

nextcomp:

    mov al,array[si]
    mov dl,array[si+1]
    cmp al,dl

    jnc noswap 

    mov array[si],dl
    mov array[si+1],al 

noswap: 
    inc si
    dec bx
    jnz nextcomp

    loop nextscan       ; } while(--cx);



;;; this  loop to display  elements on the screen

    mov cx,7
    mov si,0

print:

    Mov al,array[si]  
    Add al,30h
    Mov ah,0eh
    Int  10h 
    MOV AH,2
    Mov DL , ' '
    INT 21H
    inc si
    Loop print

   


mov ah,4ch
int 21h
start endp
code ends
end start