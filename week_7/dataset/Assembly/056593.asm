; This program inputs a string from the keyboard and 
; redisplays it on the screen. Demonstrates DOS 
; functions 0Ah and 9.
.model small
.stack 100h
.data
stringSize   db  80            ; size of input area
keysTyped    db  ?             ; number of chars input
inputString  db  80 dup(0)   ; input chars stored here
crlf         db  0Dh,0Ah,"$"
.code
main proc
    mov   ax,@data
    mov   ds,ax
    mov   ah,0Ah               ; DOS function: input string
    mov   dx,offset stringSize
    int   21h
    mov   ah,9                 ; go to next screen line
    mov   dx,offset crlf
    int   21h

; The string contains a carriage return, but we 
; need to insert an additional linefeed character so 
; it can be displayed correctly. 
  
    mov   ax,0
    mov   al,keysTyped
    mov   si,ax
    mov   inputString[si+1],0Ah  ; linefeed character
; Echo the string to the console.
    mov   ah,9                   ; output $-terminated string
    mov   dx,offset inputString
    int   21h
    mov   ax,4C00h               ; end program
    int   21h
main endp
end  main

