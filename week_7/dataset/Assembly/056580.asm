;accepts drive letter and sets to default of user's choice
.model small
.stack 100h
.data
msg1	db	"Enter drive letter (A, B, C, or D): $"

.code
main proc
	mov ax,@data
	mov ds,ax
	mov dx,offset msg1		;opening message
	mov ah,9
	int 21h
	mov ah,1
	int 21h				;accept drive letter
	cmp al,'A'				;determine which drive to access
	je dr_a
	cmp al,'B'
	je dr_b
	cmp al,'C'
	je dr_c
	cmp al,'D'
dr_a:	mov dl, 0	
	jmp set_dr
dr_b:	mov dl,1
	jmp set_dr
dr_c:	mov dl,2
	jmp set_dr
dr_d:	mov dl,3	
set_dr:	mov ah,0eh
	int 21h
	
	mov ax,4c00h
	int 21h

main endp

end main