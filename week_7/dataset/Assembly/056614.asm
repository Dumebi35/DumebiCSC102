;title  Uppercase Display Program            (UPCASE.ASM)

; This program converts each character input from the
; keyboard to uppercase.  The program ends when 
; ENTER is pressed. 
.model small
.stack 100h
.code
main proc


A1: 
    mov   ah,8      ; input a character, no echo
    int   21h	    ; places character in al
    cmp   al,0Dh    ; ENTER pressed?
    je    A3        ; yes: quit
    cmp   al,'a'    ; character < 'a'? (checks against ASCII val)
    jb    A2        ; yes: display it
    cmp   al,'z'    ; character > 'z'? (checks against ASCII val)
    ja    A2        ; yes: display it
    sub   al,32     ; no: subtract 32 from ASCII code

A2: 
    mov   ah,2      ; function: display character 
    mov   dl,al     ; (must be in DL)
    int   21h       ; call DOS
    jmp   A1        ; get another character

A3: 
    mov   ax,4C00h  ; return to DOS
    int   21h
main endp
end main

