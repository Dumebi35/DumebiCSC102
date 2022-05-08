title 2 dimensional array

.model small
.stack 100h
.data
	array db 1h, 2h, 3h, 4h, 5h, 6h, 7h, 8h
	rowsize = 4
.code
extrn writeint:proc, crlf:proc
main proc
    mov  ax,@data
    mov  ds,ax

    mov bx,offset array
    mov si,0
    mov ax,0
    mov cx,rowsize   
l1: 
    add al,[bx+si]	;sum 1st row in al
    inc si
    loop l1  
    push bx
    mov bx,16
    call writeint  
    call crlf    
    pop bx
    add bx,rowsize
 
    mov si,0
    mov dl,0
    mov cx,rowsize
l2:
    add dl,[bx+si]	;sum 2nd row in dl
    inc si
    loop l2        
    mov ax,0
    mov al,dl
    mov bx,10
    call writeint

    mov  ax,4C00h
    int  21h
main endp

end main
