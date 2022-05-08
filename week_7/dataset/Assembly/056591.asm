; Write three short procedures that set the cursor size to
; (1) a solid block, (2) top line, and (3) normal size.
; 
; Note: On a VGA display, the cursor can either be on top, on
; bottom, or a solid block. Therefore, the mid-height cursor
; mentioned in the Exercise 14 is not possible. This error
; was corrected in the second printing.
.model small
.stack 100h
.data
solidMsg  db "Solid cursor: ",0
topMsg    db "Top-line cursor: ",0
normalMsg db "Normal cursor: ",0
.code
include library.inc
main proc
    mov   ax,@data
    mov   ds,ax
    call  solid_cursor
    call  top_cursor
    call  default_cursor
    mov   ax,4C00h
    int   21h
main endp

solid_cursor proc
    mov   dx,offset solidMsg
    call  Writestring
    mov  ah,1
    mov  ch,0
    mov  cl,7
    int  10h     
    call  getch
    call  Crlf
    ret
solid_cursor endp

top_cursor proc
    mov   dx,offset topMsg
    call  Writestring
    mov   ah,1
    mov   ch,0
    mov   cl,1
    int   10h     
    call  getch
    call  Crlf
    ret
top_cursor endp

default_cursor proc
    mov   dx,offset normalMsg
    call  Writestring
    mov  ah,1
    mov  ch,6
    mov  cl,7
    int  10h     
    call  getch
    call  Crlf
    ret
default_cursor endp

getch proc
    mov   ah,1           ; wait for keystroke
    int   21h
    ret
getch endp
end  main

