
title finite state machine example
;string must begin with 'x' and end with 'z'
;any number of letters 'a' through 'y' may intervene
;there may be 0 intervening letters
;continues to accept chars until 'z' or invalid char entered 
.model small
.stack 100h
.data

msg1 		db 0dh,0ah,"Invalid string",'$'
msg2 		db 0dh,0ah,"Valid string",'$'

.code
main proc
	    mov  ax,@data
	    mov ds,ax
	   
statea:	    
	    call get_char
	    cmp al,'x'
	    jne invalid		;invalid if 1st char not 'x'
	    
stateb:	    
	    call get_char
	    cmp al,'z'
	    je statec
	    cmp al,61h		;char below 'a'?
	    jb invalid
	    cmp al,79h		;char above 'y'?
	    ja invalid
	    jmp stateb  		;generate next char   
	    
statec:	    
	    mov  ah,9
	    mov  dx,offset msg2
	    int  21h
	    jmp quit
invalid:
	    mov ah,9
	    mov dx,offset msg1    
	    int 21h
	    
quit:
	    mov  ax,4C00h
	    int  21h

get_char proc
	    mov ah,1
	    int 21h			;places char in AL
	    ret
get_char endp	    

main endp

end main
