.model small
.stack 100h

.data
ThreeBytes db 10h,20h,30h
TheSum     db ?

.code
main proc
    mov  ax,@data            ; init data segment
    mov  ds,ax

    mov  al,ThreeBytes
    add  al,ThreeBytes+1
    add  al,ThreeBytes+2
    mov  TheSum,al

    mov  ax,4c00h            ; end program
    int  21h
main endp
end main

