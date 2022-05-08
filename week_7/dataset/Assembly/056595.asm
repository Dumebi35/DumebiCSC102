; Input and display only letters A-Z from the keyboard 
; until the Enter key is pressed.
; In this implementation we accept only capital letters.
.model small
.stack 100h
.code

extrn ClrScr:proc

main proc
    mov  ax,@data            ; init data segment
    mov  ds,ax
;    call ClrScr
L1: mov  ah,10h              ; wait for a keystroke
    int  16h
    cmp  al,0Dh              ; Enter key pressed?
    je   Quit
    cmp  al,'A'
    jb	 quit
    cmp  al,'z'
    ja	 quit
    cmp  al,'['
    jae  cont
    jmp disp
cont:
    cmp al, 60h
    jbe	quit
    
     
disp:
    mov  ah,2                ; Display the character
    mov  dl,al
    int  21h
    jmp  l1      
Quit:
    mov  ax,4c00h            ; end program
    int  21h

main endp

end main
