.MODEL SMALL
.STACK 100H 
.DATA
MSG1 DB "ENTER A BINARY NUMBER: $"
.CODE MAIN

DISPLAY PROC
    MOV CX, 16 
    
    UNTILL:
    ROL BX, 1
    JC SET_ONE
    JMP SET_ZERO  
    
    SET_ONE:
    MOV DL, '1'
    JMP SHOW_RESULT
    
    SET_ZERO:
    MOV DL, '0'
    JMP SHOW_RESULT
    
    SHOW_RESULT:
    MOV AH, 02H
    INT 21H
    LOOP UNTILL
    RET
    DISPLAY ENDP


MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    XOR BX, BX  
    
    INPUT:    
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JE NEXT
    AND AL, 0FH
    SHL BX, 1
    OR BL, AL
    JMP INPUT
    
    NEXT:
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    
    SHOW_OUTPUT:
    CALL DISPLAY
    JMP EXIT
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN