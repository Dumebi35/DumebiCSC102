;C11_PE3 get disk free space using get_diskfreespace from library
.model small
.386
.stack 100h
.data
msg1	db	"Enter drive letter (A, B, C, or D): $",0dh,0ah
msg2	db	"Free disk space in bytes is:  $ "
kboard	db	2, 0, 2 dup(0)
xtable   db     '0123456789ABCDEF'      ; translate table
.code
main proc

extrn crlf:proc, clrscr:proc, Get_DiskFreespace:proc

	mov ax,@data
	mov ds,ax
	mov dx,offset msg1		;opening message
	mov ah,9
	int 21h
	mov ah,0ah
	mov dx,offset kboard		;accept K/B input
	int 21h
	cmp kboard+2,'A'			;determine which drive to access
	je dr_a
	cmp kboard+2,'B'
	je dr_b
	cmp kboard+2,'C'
	je dr_c
	cmp kboard+2,'D'
	jmp dr_d
dr_a:	mov al, 0	
	jmp callp
dr_b:	mov al,1
	jmp callp
dr_c:	mov al,2
	jmp callp
dr_d:	mov al,3	
callp: call get_diskfreespace		;get disk free space
						;returns space in dx:ax
	push ax
	movzx eax,dx			;place high order part in eax
	shl eax,16				;shift to high 16 bits
	pop cx
	movzx ebx,cx			;move low order part into cx
	add eax,ebx				;add into eax to get 32-bit number
	call crlf
	push eax				;save integer to be written
	mov dx,offset msg2		;output message
	mov ah,9
	int 21h
	pop eax				;restore integer to be written
	mov ebx,10				;radix for output
	call w32intex			;call 32-bit write int proc

	mov ax,4c00h
	int 21h
main endp

W32intex proc
;writes a 32-bit unsigned integer to screen
     mov   di,0400h			;initialize di reg
     pusha					;push all regs onto stack
     mov cx,0				;initialize cx
L3:  mov   edx,0       			; clear dividend to zero
     div   ebx         			; divide AX by the radix
     xchg  eax,edx	  	        ; exchange quotient, remainder
     push  ebx              
     mov   ebx,offset xtable		; translate table
     xlat                  		; look up ASCII digit
     pop   ebx              
     dec   di              		; back up in buffer
     mov   [di],al         		; move digit into buffer
     xchg  eax,edx           		; swap quotient into AX

     inc   cx              		; increment digit count
     or    eax,eax          		; quotient = 0?
     jnz   L3              		; no: divide again

; Display the buffer using CX as a counter.

L4:  mov   ah,2              		; function: display character
     mov   dl,[di]          		; character to be displayed 
     int   21h               		; call DOS
     inc   di                		; point to next character
     loop   L4
     call crlf

     popa					;pop all regs from stack
     ret
w32intex endp

end main
