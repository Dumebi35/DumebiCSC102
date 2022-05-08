; Note: subtracting 32 will convert a character to 
; uppercase 

.model small
.stack 100h
.data
aString db "this is a string containing lowercase letters"
strSize = ($ - aString)

.code
main proc
    mov  ax,@data            ; init data segment
    mov  ds,ax

    mov  si,offset aString
    mov  cx,strSize
L1: sub  [si],32
    inc  si
    Loop L1

    mov  ax,4c00h            ; end program
    int  21h
main endp
end main

