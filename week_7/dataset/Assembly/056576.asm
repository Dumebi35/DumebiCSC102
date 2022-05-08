;smallest of three numbers
.model small
.stack 100h

.data
msg1	db  "Enter 1st number: ","$"
msg2	db  "Enter 2nd number: ","$"
msg3	db  "Enter 3rd number: ","$"
msg4	db  "The smallest number is: $"
small	db  ?
.code
extrn readint:proc, writeint:proc, crlf:proc

main proc
        mov ax,@data
        mov ds,ax
;        mov al,10
        mov ah,9
        mov dx,offset msg1
        int 21h
        call readint
        call crlf
        mov bl,al
        mov ah,9
        mov dx,offset msg2
        int 21h
        call readint
        call crlf
        mov cl,al
        mov ah,9
        mov dx,offset msg3
        int 21h
        call readint
        call crlf
        mov dl,al
;        mov bl,4
;        mov cl,6        
	mov small,bl		;assume bl is smallest
	cmp small,cl		;if small <= cl then
	jbe L1			;jump to L1 (jmp if op1<=op2)
	mov small,cl		;else move cl to small
L1:
	cmp small,dl		;if small <= dl then
	jbe L2			;jump to L2 (jmp if op1<=op2)
	mov small,dl		;else move dl to small
L2:
	mov ah,9
	mov dx,offset msg4
	int 21h
	mov ax,0
	mov al,small
	mov bx,10
        call writeint
	
	mov ax,4c00h	
	int 21h
main endp
end main

