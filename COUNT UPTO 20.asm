               .MODEL SMALL
.STACK 100H
.DATA
.CODE MAIN
MAIN PROC
    
    MOV CL, 0
    
    COUNT:
    MOV AH, 01H
    INT 21H
    
    CMP AL, 0DH
    JE DISPLAY
    
    CMP CL, 20
    JE DISPLAY
    
    INC CL
    JMP COUNT
    
    DISPLAY:
    MOV BL, CL
    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H 
    
    ; Convert to decimal for 0-20
    MOV AX, BX
    XOR DX, DX
    MOV BX, 10
    DIV BX
    PUSH DX          ; Remainder (ones place)
    OR AL, AL        ; Check if quotient (tens place) is 0
    JZ ONES
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02H
    INT 21H
ONES:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
    JMP EXIT
     
EXIT:
    MOV AH, 4CH
    INT 21H 
    
MAIN ENDP
END MAIN