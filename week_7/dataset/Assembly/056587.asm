; Create a loop that inputs lowercase letters. Convert
; each character to uppercase and display it. Halt 
; when Ctrl-Break is pressed. (Hint: run this in the 
; debugger.)

.model small
.stack 100h
.data
string db "Enter lowercase letters: $"

.code
main proc
    mov     ax,@data    ; init data segment 
    mov     ds,ax       

clear_window:
    mov     ah,7        ; scroll window down
    mov     al,0        ; clear entire window
    mov     cx,0        ; row 0, column 0
    mov     dx,184fh    ; to row 24, column 79 
    mov     bh,70h      ; reverse video
    int     10h         

set_cursor:
    mov     ah,2        ; set cursor position
    mov     dx,0913h    ; row 9, column 19
    mov     bh,0        ; video page 0
    int     10h         

display_prompt:
    mov     ah,9        ; display a string
    mov     dx,offset string
    int     21h        

input_character:
    mov     ah,8        ; input char, no echo
    int     21h         ; char is in AL

convert_character:
    sub     al,32d      ; convert AL to uppercase

display_character:
    mov     ah,2        ; display character
    mov     dl,al       ; character is in DL
    int     21h        

wait_for_key:
    mov     ah,8             ; get character, no echo
    int     21h        
    jmp     input_character  ; get another character

Exit:
    mov     ax,4c00h         ; end program
    int     21h
main  endp
end main

