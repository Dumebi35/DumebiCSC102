title  Multiword Addition Example        (MULTIADD.ASM)

; Demonstrates a procedure that will add multiword 
; operands together and store the sum in memory.
; double precision arithmetic
.model small
.stack 100h
.data

val1	dw	0A406h,0A2B2h	;defines double words with--
val2	dw	8700h,8010h	;least sig word in lower mem loc
result   dw    	0, 0, 0 	; stored as 2B06h,22C3h,0001h
.code
main proc
        mov ax,@data
        mov ds,ax

	mov   si,offset val1
    	mov   di,offset val2
    	mov   bx,offset result
    	mov   cx,2               ; add 2 words

; Add any two multiword operands together.  When the 
; procedure is called, SI and DI point to the two operands, 
; BX points to the destination operand, and CX contains the 
; number of words to be added.  No registers are changed.

    push  ax		;save register contents of
    push  bx		;registers that will be
    push  cx		;used in this procedure
    push  si
    push  di
    clc                ; clear the Carry flag

L1:
    mov   ax,[si]      ; get the first operand
    adc   ax,[di]      ; add the second operand
    pushf              ; save the Carry flag
    mov   [bx],ax      ; store the result
    add   si,2         ; advance all 3 pointers
    add   di,2
    add   bx,2
    popf               ; restore the Carry flag
    loop  L1           ; repeat for count passed in CX

    adc   word ptr [bx],0   ; add any leftover carry
    pop   di		;restore registers
    pop   si
    pop   cx
    pop   bx
    pop   ax

    mov   ax,4C00h           ; return to DOS
    int   21h

main endp

end main