Title  Chapt 7 (7.8.1) Ex 4: Room Schedule
; Using a room schedule record, query a bit-mapped field
; called roomstatus. Extract the individual subfields
; from roomstatus.
; -------------- Field Format------------------
;   Bit
; Position          Usage
;   0-1        Type of room (0,1,2,3)
;   2-7        Number of seats (0-63)
;   8-12       Department ID  (0-31)
;   13         Overhead Projector (0,1)
;   14         Blackboard (0,1)
;   15         P.A. System (0,1)
.Model small
.Stack 100h
.data
     RoomStatus     dw    0110011101011101b
     RoomType       db    ?
     NumSeats       db    ?
     DeptID         db    ?
     Projector      db    ?
     BlackBoard     db    ?
     PASystem       db    ?

     typeCheck      db    03h          ; to AND the room status
     SeatsOffset    db    02h          ; Seats begins 2 bits from beginning
     SeatCheck      dw    3Fh          ; To AND the number of seats
     DeptOffset     db    06h          ; Department ID begins 8 bits from 
      ;beginning
     DeptCheck      dw    07h          ; to AND the Department ID
     ProjectorOffs  db    05h          ; 13 bits to the projector position
     ProjectorCheck dw    01h          ; Value to test projector
     BlackBOffset   db    01h
     BlackboardCk   dw    01h
.Code
Main     Proc
    mov     ax, @data                  ; initialize the data segment so the 
      ;program
    mov     ds, ax                     ; can find the variables
    mov     ax, RoomStatus             ; Load the Room status info into ax
ExtractType:
    push    ax                         ; Save the ax register for next step
    and     al, TypeCheck              ; Extract the room type
    mov     Roomtype, al               ; and save the result in the variable
    pop     ax                         ; restore ax to original value

ExtractSeats:
    mov      cl, SeatsOffset           ; cx contains number of bits from bit 0
    shr      ax, cl                    ; move the seats information into al
    push     ax                        ; save ax for the next step
    and      ax, SeatCheck             ; AND al with 00111111b to clear high 
      ;bits
    mov      NumSeats, al              ; place the value into NumSeats
    pop      ax                        ; restore ax to it's original value
ExtractDept:
    mov      cl, DeptOffset            ; cx contains the number of bits from 0 
      ;the department begins
    shr      ax, cl                    ; move the department ID into al
    push     ax
    and      ax, DeptCheck             ; AND al with 00000111b to extract Dept 
      ;ID
    mov      DeptID, al                ; store the value of Dept ID in the 
      ;variable
    pop      ax
ExtractProjector:
    mov      cl, ProjectorOffs         ; bits from start of string to Projector 
;position
    shr      ax, cl                    ; move projector into position
    push     ax                        ; save ax for the next step
    and      ax, ProjectorCheck        ; extract the projector bit
    mov      Projector, al             ; and save the value
    pop      ax                        ; restore ax
ExtractBlackBoard:
    shr     ax, 1                      ; move the blackboard value into 
;position
    push    ax
    and     ax, Blackboardck           ; Extract the blackboard value
    mov     Blackboard, al             ; and save in the variable
    pop     ax
ExtractPA:
    shr     ax, 1                      ; move the PA bit into position
    mov     PASystem, al               ; and store it in the variable
Exit:
    mov   ax, 4C00h         ;load the terminate function
    Int   21h               ;and end the program
Main     Endp
End Main

