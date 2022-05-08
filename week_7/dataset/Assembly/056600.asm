;extracting bit strings from the the date field
.model small
.stack 100h
.data
day	db	?
month	db	?
year	dw	?
.code
main proc
       mov 	ax,@data
       mov 	ds,ax
;get day
	mov	dx,126Ah	;0001 0010 0110 1010b 
				;example date Mar 10,1989 
	mov 	al,dl		;make a copy of dl
	and	al,00011111b	;clear bits 5-7
	mov 	day,al		;save as variable 'day'
;get month
	mov 	ax,dx		;make a copy of dx
	mov	cl,5		;shift count
	shr	ax,cl		;shift rught 5 bits
	and	al,00001111b	;clear bits 4-7
	mov	month,al	;save as variable 'month'
;get year
	mov	al,dh		;make a copy of dh
	shr	al,1		;shift right 1 position
	mov 	ah,0		;set ah=0
	add	ax,1980		;to get actual year add '1980'
	mov	year,ax		; save in var. 'year'

;display values	in registers
	mov	bl,day
	mov	cl,month
	mov	dx,year
	
        mov 	ax,4c00h
        int 	21h
main endp


end main