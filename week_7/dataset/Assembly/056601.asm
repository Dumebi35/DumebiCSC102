title Disk I/O Library Procedures
;(disks.asm)

; The source code for Get_Diskfreespace and Get_Disksize
; will not be on the student disk, because they are 
; solutions to Chapter 11 exercises.

public Get_Diskfreespace, Get_Disksize, \
       Get_Commandtail, Get_Deviceparms

.model small
.286
.code

; Get_Diskfreespace -------------------------------
;
; Returns the amount of free space on a selected 
; drive. Input: AL = drive (0=A, 1=B, 2=C). 
; Output: DX:AX = free space. 
;
; Last update: 5/3/98
; -------------------------------------------------

Get_Diskfreespace proc  
     push  bx
     push  cx
     inc   al      ; A = 1, B = 2, etc.
     mov   ah,36h  ; DOS: Get Disk Free Space
     mov   dl,al   ; select the drive
     int   21h
     mul   cx      ; AX = bytes/cluster
     mul   bx      ; DX:AX = available bytes
     pop   cx
     pop   bx
     ret
Get_Diskfreespace endp

; Get_Disksize --------------------------------
;
; Returns the size (in bytes) of a specified
; disk drive. Input parameters: AL = drive #
; (0=A, 1=B, 2=C, etc.). Output: DX:AX = space.
;
; Last update: 5/3/98
;------------------------------------------------

Get_Disksize proc  
     push  bx
     push  cx
     inc   al      ; adjust drive number
     mov   dl,al   ; drive number
     mov   ah,36h  ; Get Disk Free Space
     int   21h
     push  dx      ; save clusters/drive
     mul   cx      ; AX = bytes/cluster
     pop   dx
     mul   dx      ; DX:AX = bytes/drive
     pop   cx
     pop   bx
     ret
Get_Disksize endp


; Get_Commandtail ---------------------------------
;
; Gets a copy of the DOS command tail at PSP:80h. 
; Input parameters: BX = the PSP segment and DS:SI 
; points to a buffer to hold a copy of the command 
; tail.
;
; Last update: 4/5/98
;--------------------------------------------------

Get_Commandtail proc
     pusha
     mov   es,bx         ; BX = PSP segment
     mov   si,dx         ; DX points to buffer
     mov   di,81h        ; point to command tail
     mov   cx,0
     mov   cl,es:[di-1]  ; CX = length of tail
     cmp   cx,0          ; quit if length = 0
     je    C2
     mov   al,20h        ; compare using a space
     repz  scasb         ; find first nonspace
     jz    C2            ; quit if all spaces
     dec   di            ; back up one position
     inc   cx            ; adjust count

C1:  mov   al,es:[di]    ; copy rest of tail
     mov   [si],al
     inc   si
     inc   di
     loop  C1
     clc           ; CF=0 means tail found
     jmp   C3

C2:  stc           ; set carry: no command tail
C3:  popa
     ret
Get_Commandtail endp

; Get_Deviceparms ---------------------------------------
;
; Get the Device BPB table for a disk drive, found in 
; its device driver. Input parmeters: BL = drive number
; (0 = default drive, 1 = A, 2 = B, etc.). Output: AX 
; points to a ParameterStruc (structure) where DOS has 
; stored the device information.
;
; Last update: 4/5/98
;---------------------------------------------------------

include disks.inc   ; ParameterStruc

.data
parms ParameterStruc <>

.code
Get_Deviceparms proc 
     push cx
     push dx
     mov  ah,44h     ; major function: IOCTLDevice
     mov  al,0Dh     ; subfunction: Generic IO Control
     mov  ch,8       ; category: disk
     mov  cl,60h     ; option: Get Device Parameters
     mov  dx,offset parms ; device parameter table
     int  21h        ; call DOS
     mov  ax,dx      ; AX = pointer to parms table
     pop  dx         ; restore all changed registers
     pop  cx
     ret
Get_Deviceparms endp

end


