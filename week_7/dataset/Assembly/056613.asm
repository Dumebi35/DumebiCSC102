;toggle CAPS LOCK on or off
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
	xor byte ptr [bx],01000000b	 	;reverse bit 6
	pop ds
	mov ax,4c00h
	int 21h
main endp
end main	
