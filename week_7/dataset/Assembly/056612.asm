;page 95  sum of an integer array

.model small
.stack 100h
.data
intarray dw 200h,100h,300h,600h

.code
extrn clrscr:proc, writeint:proc
main proc
	mov ax,0		;zero accumulator
	mov di,offset intarray	;address of intarray start
	mov cx,4		;number of integers
read_int:
	add ax,[di]		;add integer to accum
	add di,2		;point to next integer
        loop read_int           ;repeat until cx=0

        call clrscr
        mov bx,10               ;radix of number to write
        call writeint

        mov ax,4c00h
        int 21h

main endp
end main
