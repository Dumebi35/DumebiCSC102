.model small
.stack 100h

.data
wordArray dw 1000,2000,3000
sum       dw ?

.code
extrn clrscr:proc, writeint:proc, crlf:proc 

main proc
    mov  ax,@data             ; init data segment
    mov  ds,ax
    call ClrScr

    mov  sum,0
    mov  cx,3                 ; loop counter
    mov  bx,offset wordArray
    
L1: mov  ax,[bx]        ; get an integer
    push bx
    mov  bx,10          ; display the integer
    call Writeint
    call Crlf
    pop  bx
    add  sum,ax            ; add it to the sum
    add  bx,type wordArray ; point to next value
    loop L1
    
    mov  ax,sum
    mov  bx,10          ; display the sum
    call Writeint
    call Crlf

    mov  ax,4c00h            ; end program
    int  21h
main endp
end main

