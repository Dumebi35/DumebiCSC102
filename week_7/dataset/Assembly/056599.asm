;convert hex 8-bit number to binary and display on screen  (CONVERT.ASM)
.model small
.stack 100h

.data
msg1	db	"Enter first hex character: $"
msg2	db	10,13,"Enter second hex character: $"
msg3	db	10,13,"The binary equivalent is: $"
.code
main proc 
	mov ax,@data
	mov ds,ax

	mov   dx,offset msg1
	mov   ah,9h
	int   21h		;display msg1
 	mov   ah,1   		;input first hex character, w/ echo
    	int   21h    		;places character in al
   	mov   dl,al		;place char in dl to convert
    	call  hexconv		;convert ASCII value to hex char
	mov   bl,dl		;place char in bl
	mov   cl,4		;set up to shift left 4 times
	shl   bl,cl		;shift lower 4 bits to higher 4 bits
	mov   dx,offset msg2
	mov   ah,9h
	int   21h		;display msg2
	mov   ah,1
	int   21h		;input 2nd hex char
	mov   dl,al		;place char in dl to convert
    	call  hexconv  		;convert ASCII value to hex char
	add   bl,dl		;add into 1st char to form 1 byte
	mov   dx,offset msg3
	mov   ah,9
	int   21h		;display msg3
	mov   cx,8		;set loop counter
next:	mov   dl,0		;initialize dl
	rcl   bl,1		;rotate CF left one position
	adc   dl,30h		;yields ASCII 0 or 1
	mov   ah,2		;set up int to display
	int   21h		;display 1 or 0
	loop  next		;get next bit
	mov   ax,4c00h
	int   21h		;end
main endp	
;convert ASCII value to hex char
hexconv proc 	
	cmp   dl,39h
	jle   upto_9		;dl is ASCII 30h -39h	
	cmp   dl,46h		;ASCII 'F'
	jle   continu		;upper case letters
	sub   dl,20h		;else convert to upper case
continu: cmp  dl,41h
	je    A1
	cmp   dl,42h
	je    B1
	cmp   dl,43h
	je    C1
	cmp   dl,44h
	je    D1
	cmp   dl,45h
	je    E1
	mov   dl,0Fh
	jmp   done
upto_9:	sub   dl,30h
	jmp   done
A1:	mov   dl,0Ah
	jmp   done	
B1:	mov   dl,0Bh   	
	jmp   done
C1:	mov   dl,0Ch
	jmp   done	
D1:	mov   dl,0Dh
	jmp   done	
E1:	mov   dl,0Eh			
done:	ret
hexconv endp
end main
	
