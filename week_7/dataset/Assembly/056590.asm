; Use INT 10h to draw a single-line box on the screen,
; with the upper left corner at row 5, column 10 and the 
; lower right corner at row 20, column 70.

.model small
.stack 100h

ulrow = 5
ulcol = 10
lrrow = 20
lrcol = 70
bwidth = (lrcol - ulcol) - 2
bheight =(lrrow - ulrow) - 2

ulcorner = 0DAh
urcorner = 0BFh
llcorner = 0C0h
lrcorner = 0D9h
hbar     = 0C4h
vbar     = 0B3h
crlf   EQU  <0Dh,0Ah>

.data
top  db ulcorner
     db bwidth dup (hbar)      ; horizontal line
     db urcorner,crlf,'$'

bottom  db llcorner
        db bwidth dup (hbar)   ; horizontal line
        db lrcorner,crlf,'$'

side db vbar, bwidth dup(' '), vbar, crlf, '$'
row  db  ulrow
col  db  ulcol

.code
main proc
    mov   ax,@data
    mov   ds,ax

    call  DrawBox

    mov   ah,1         ; wait for keystroke
    int   21h
    mov   ax,4C00h     ; end program
    int   21h
main endp

; Draw the complete box.

DrawBox proc
  ; Draw the top of the box.

    call  locate          ; position the cursor
    mov   ah,9            ; function: display string
    mov   dx,offset top
    int   21h
    inc   row
    
    ; Draw the sides of the box.

    mov   cx,bheight      ; set loop count for box sides

L1: call  locate 
    mov   ah,9            ; display string
    mov   dx,offset side
    int   21h
    inc   row
    loop  L1

    ; Draw the bottom of the box.

    call  locate
    mov   ah,9            ; display string
    mov   dx,offset bottom
    int   21h
    ret
DrawBox endp

; Locate the cursor at <row>, <col>.

locate proc
    push  ax
    push  bx
    push  dx
    mov   ah,2
    mov   bh,0
    mov   dh,row
    mov   dl,col
    int   10h
    pop   dx
    pop   bx
    pop   ax
    ret
locate endp
end  main

