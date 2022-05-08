title READINT Procedure

.model small
.stack 100h
public readint
.code
extrn Readstring:proc, Writesint:proc, Crlf:proc

main proc
     mov ax,@data
     mov ds,ax
     call Readint     ; read number into AX
     call Crlf
     call Writesint   ; display the number in AX
     mov ax,4c00h
     int 21h
main endp

; New version of Strlen that returns the length
; of a string. Input: DS:DX points to the string.
; Output: AX = the length.

Strlen proc
     push  si  
     mov   si,dx
     dec   si

T1:
     inc   si
     cmp   byte ptr [si],0  ; null byte?
     jne   T1

     sub   si,dx
     mov   ax,si

     pop   si
     ret
Strlen endp

; The Readint procedure reads a signed integer from
; standard input. Leading spaces are ignored.
; Input: none. Output: AX contains the number. 
; Calls the Readstring and Strlen procedures.

Readint proc
    push  bx
    push  cx
    push  dx
    push  si

    mov   dx,offset inputarea   ; input the string
    mov   si,dx           ; save offset in SI
    call  Readstring
    call  Strlen          ; returns length in AX
    mov   cx,ax           ; save length in CX
    cmp   cx,0            ; greater than zero?
    jne   L1              ; yes: continue
    mov   ax,0            ; no: set return value
    jmp   L7              ; and exit

    ; Skip over any leading spaces.

L1: mov   al,[si]         ; get a character from buffer
    cmp   al,' '          ; space character found?
    jne   L2              ; no: check for a sign
    inc   si              ; yes: point to next char
    loop  L1             
    jcxz  L7              ; quit if all spaces

    ; Check for a leading sign.

L2: mov   sign,1          ; assume number is positive
    cmp   al,'-'          ; minus sign found?
    jne   L3              ; no: look for plus sign
    mov   sign,-1         ; yes: sign is negative
    dec   cx              ; subtract from counter
    inc   si              ; point to next char
    jmp   L4        
L3: cmp   al,'+'          ; plus sign found?
    jne   L4              ; no: must be a digit
    inc   si              ; yes: skip over the sign
    dec   cx              ; subtract from counter

    ; Start to convert the number.

L4: mov   ax,0            ; clear accumulator
    mov   bx,10           ; BX is the divisor

    ; Repeat loop for each digit.

L5: mov   dl,[si]         ; get character from buffer
    cmp   dl,'0'          ; character < '0'?
    jl    L7              ; yes: resolve sign and exit
    cmp   dl,'9'          ; character > '9'?
    jg    L7              ; yes: resolve sign and exit
    and   dx,000Fh        ; no: convert to binary
    push  dx              ; save the digit
    mul   bx              ; DX:AX = AX * BX
    pop   dx              ; restore the digit
    jc    L6              ; quit if result too large
    add   ax,dx           ; add new digit to AX
    jc    L6              ; quit if result too large
    inc   si              ; point to next digit
    loop  L5              ; repeat, decrement counter
    jmp   L7              ; process the sign

    ; Overflow must have occured.

L6: mov   dx,offset overflow_msg
    mov   ah,9
    int   21h
    mov   ax,0            ; set result to zero

L7: mul   sign            ; AX = AX * sign
    pop   si
    pop   dx
    pop   cx
    pop   bx
    ret
readint endp

.data
sign          dw  ?          
inputarea     db  10,0,10 dup(' ')    ; up to 9 digits
overflow_msg  db  ' <integer overflow> $'
end main
