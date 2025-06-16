.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "ENTER A HEX NUMBER: $"
MSG2 DB "BINARY NUMBER: $"  
ONE DB ?
ZERO DB ?
.CODE MAIN
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H
    
    
    XOR BL, BL
    
    INPUT:
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JE NEXT_LINE
    CMP AL, 39H
    JG LETTER
    AND AL, 0FH
    JMP SHIFT
    
    LETTER:
    SUB AL, 37H
    
    SHIFT:
    SHL BL, 4
    OR BL, AL
    JMP INPUT
    
    NEXT_LINE:
    MOV CX, 8
    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H 
    
    MOV ONE, 0
    MOV ZERO, 0
    
    OUTPUT:
    SHL BL, 1
    JC SET_ONE
    JMP SET_ZERO
    
    SET_ONE:
    MOV DL, '1'
    INC ONE
    JMP PRINT
    
    SET_ZERO:
    MOV DL, '0'
    INC ZERO
    JMP PRINT
    
    PRINT:
    MOV AH, 02H
    INT 21H
    LOOP OUTPUT
    
    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    
    MOV AH, 02H
    MOV DL, "Z"
    INT 21H
    MOV AH, 02H
    MOV DL, ZERO
    ADD DL, '0'
    INT 21H 
    
    MOV AH, 02H
    MOV DL, "O"
    INT 21H
    MOV AH, 02H
    MOV DL, ONE
    ADD DL, '0'
    INT 21H
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN