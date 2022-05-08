title  Display ASCII binary (BIN.ASM)

;  This program displays a binary number as a string 
;  of digits.
.model small
.stack 100h
.code
main proc
        mov ax,@data
        mov ds,ax

        mov   al,6Ch         ; AL = 01101100b
        mov   cx,8           ; number of bits in AL
   
L1:     shl   al,1           ; shift al left into Carry flag
        mov   dl,'0'         ; choose '0' as default digit
        jnc   L2             ; if no carry, then jump to L2
        mov   dl,'1'         ; else move '1' to DL
          
L2:     push  ax             ; save AX
        mov   ah,2           ; display DL
        int   21h
        pop   ax             ; restore AX
        loop  L1             ; shift another bit to left

        mov   ax,4C00h       ; return to DOS
        int   21h

main endp
end main
