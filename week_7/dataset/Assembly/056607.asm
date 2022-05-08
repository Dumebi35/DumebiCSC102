;turn off num lk
.model small
.stack 100h
.code
	mov ax,@data
	mov ds,ax
main proc	
	push ds
	mov ax,40h		
	mov ds,ax			;set seg to 40
	mov bx,17h			;set offset
	AND byte ptr [bx],11011111b	;clear bit 5
	pop ds
	mov ax,4c00h
	int 21h
main endp
end main	
