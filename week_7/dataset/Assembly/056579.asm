

.model small
.stack 100h
.data

keyboardarea label byte
maxkeys db 32
charsinput db ?
buffer db 32 dup(0)
.code
main proc
    mov  ax,@data
    mov  ds,ax

    mov ah,0ah
    mov dx,offset keyboardarea
    int 21h

    mov  ax,4C00h
    int  21h
main endp

end main