; Read a text file from standard input and count the ; number of words and characters. Use INT 21h ; Function 6.; This is a fairly easy program to write, compared to later 
; exercises in this chapter. This solution program assumes
; that words are separated by a single space. If the file
; contains consecutive spaces, each space would be counted
; as a word. As a bonus exercise, ask students to 
; include logic that skips consecutive spaces.

; If students use INT 21h function 6, the program is 
; almost impossible to debug with an interactive debugger. 
; Students might want to temporarily use Function 1 and 
; designate a special key such as Ctrl-Z to signal end 
; of input.

.model small
.stack 100h
.data
charCount dw  0              ; character count
wordCount dw  0              ; word count

charMsg db "Number of characters: ",0
wordMsg db "Number of words:      ",0

.code
include library.inc

main proc
    mov  ax,@data            ; init data segment
    mov  ds,ax
    call ClrScr

L1: mov  ah,6                ; DOS function 6
    mov  dl,0FFh             ; input a character
    int  21h                 ; AL = character
    jz   L8                  ; ZF = 1 if no more data
    inc  charCount           ; increment character count
    cmp  al,' '              ; space (end of word) ?
    jne  L2                  ; no
    inc  wordCount           ; yes - increment count
L2:
    jmp  L1

L8:
    inc  wordCount           ; count the last word

  ; Display the results.

    mov  bx,10               ; decimal radix
    mov  dx,offset charMsg   ; "Number of characters: "
    call Writestring    
    mov  ax,charCount
    call Writeint
    call Crlf
    
    mov  dx,offset wordMsg   ; "Number of words: "
    call Writestring    
    mov  ax,wordCount
    call Writeint
    call Crlf
        
    mov  ax,4c00h            ; end program
    int  21h
main endp
end main


