; The secret to getting this program to work is to use
; a 16-bit accumulator. The original program neglected
; to set AL to zero, so we remember to set AX to zero
; in the current program.

.model small
.stack 100h

.data
aList  db  6Fh,0B4h,1Fh
sum    dw  0               ; changed to a 16-bit variable

.code
extrn clrscr:proc, writeint:proc, crlf:proc

main proc
    mov  ax,@data             ; init data segment
    mov  ds,ax
    call ClrScr

    mov  bx,offset aList
    mov  si,2
    mov  ax,0                 ; clear the accumulator
    mov  dh,0
    mov  dl,[bx]
    add  ax,dx                ; use 16-bit accumulator
    mov  dl,[bx+1]
    add  ax,dx      
    mov  dl,[bx+si]
    add  ax,dx      
    mov  sum,ax    
   
    mov  bx,16       ; display the sum in hexadecimal (optional)
    call Writeint
    call Crlf
 
    mov  ax,4c00h            ; end program
    int  21h
main endp
end main

