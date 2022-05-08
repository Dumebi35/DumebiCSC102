; Use INT 10h to display the first 15 letters of the 
; alphabet, Give each character a diffrent color.
.model small
.stack 100h
LOOP_COUNT = 15
.data
char    db 'A'
row     db  5
col     db  5
color   db  1
.code
main proc
    mov   ax,@data      ; init data segment
    mov   ds,ax
    mov   cx,LOOP_COUNT
L1:
    push  cx            ; save loop counter
  ; Set the cursor position.
    mov   ah,2          ; BIOS function
    mov   bh,0          ; video page 0
    mov   dh,row        ; set row and column
    mov   dl,col
    int   10h
  ; Display a character and its attribute (color).
    mov   ah,9          ; BIOS function
    mov   al,char       ; get the character
    mov   bh,0          ; video page 0
    mov   bl,color      ; video attribute
    mov   cx,1          ; character count for INT 10h
    int   10h
  ; Increment the color, character, and attribute.
    inc   col
    inc   char
    inc   color
    pop   cx            ; restore loop counter
    loop  L1            ; repeat the loop
    mov   ax,4C00h      ; end program
    int   21h
main endp
end  main

