; Use the PUSH and POP instructions to display a list of 16-bit 
; integers in reverse order on the console.
; Uses indirect addressing with a loop.

.model small
.stack 100h
.data
aList dw 100h,200h,300h,400h,500h
COUNT = ($ - aList) / (type aList)
.code
extrn clrscr:proc, writeint:proc, crlf:proc 
main proc
    mov  ax,@data            ; init data segment
    mov  ds,ax
    call ClrScr
    mov  cx,COUNT
    mov  si,offset aList
; Push the numbers.
L1: mov  ax,[si]
    push ax
    add  si,type aList    
    loop L1
  ; Pop and display the numbers.
    mov  cx,COUNT
L2: pop  ax                  ; pop from stack
    mov  bx,16               ; display in hexadecimal
    call Writeint
    call Crlf
    loop L2
    mov  ax,4c00h            ; end program
    int  21h
main endp
end main

