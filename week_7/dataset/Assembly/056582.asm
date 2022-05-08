; This program creates a directory called \TEMP and
; then gives it a hidden attribute.
; DOS will not allow you to set a file attribute to
; both directory (10h) and hidden (02h) but you can make an existing
; directory hidden
.MODEL  SMALL
.STACK  100h
.DATA
pathname	db	'a:\TEMP',0
.CODE
main proc
	mov	ax,@data
  	mov	ds,ax				;set DS to point to data segment
  	mov	ah,39h			;serv. 39h creates a directory
  	mov	dx,offset pathname	;name of directory
  	int	21h				;create directory
  	mov 	ah,43h			;serv. 43h sets attribute
  	mov	al,1				;indicates set attrib.
  	mov 	cx,02h			;hidden attrib.
  	int	21h				;set attrib.
  	mov	ax,4c00h			;normal termination
  	int	21h
main endp
end main

