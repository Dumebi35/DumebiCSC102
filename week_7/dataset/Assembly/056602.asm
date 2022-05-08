;title  Display ASCII binary (DISPBIN.ASM)

;  This program displays a binary number entered from
;  the keyboard as an ASCII character
;---------------------------------------------------------------------------
.model small
.stack 100h
.data
msg1    db      'Enter a one-byte binary number',13,10,'$'
msg2    db      13,10,'You must enter only ones and zeros',13,10,'$' 
msg3    db      13,10,'The number you entered is the ASCII character: ','$'
number  db      0b

.code 
main proc

	mov ax,@data
	mov ds,ax

 	call    enter           ;proc to accept byte from k/b
	mov     ax,4C00h        ; return to DOS
	int     21h
main endp
;----------------------------------------------------------        
enter proc

;  enter a one-byte binary number

start:  mov     cx,8            ;counter for no. of bits entered
	mov number,0		;initialize number
	mov     dx, offset msg1 
	mov     ah,9h           ;to display msg1
	int     21h             ;display msg1
again:  mov     ah,8            ;input a character, no echo
	int     21h             ;places character in al
	mov     dl,al           ;place char in dl
	mov     ah,2            ;to display character
	int     21h             ;display char
	cmp     dl,'0'          ;compare to '0'
	je      zero            ;if '0' go on
	cmp     dl,'1'          ;compare to '1'
	je      one             ;if '1' go on
	mov     dx,offset msg2  ;if not '0' or '1'print an error msg    
	mov     ah,9
	int     21h             ;display error msg
	jmp     start           ;try again
zero:   mov     bl,0b           ;place '0' in bl
	jmp     continu
one:    mov     bl,1b           ;place '1' in bl
continu: push    cx              ;save cx
	dec     cl              ;shift left cl-1 places
	shl     bl,cl           ;shift left
	add     number,bl       ;add into number
	pop     cx              ;retrieve cx    
	loop    again           ;read next bit
	mov     dx,offset msg3
	mov     ah,9h
	int     21h             ;print output msg
	mov     ah,2
	mov     dl,number
	int     21h             ;display variable 'number'
				;lower case ASCII: 61-7A, upper: 41-5A 
	ret
enter endp      
end main