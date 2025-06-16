.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "ENTER A BINARY NUMBER: $"
MSG2 DB "HEX NUMBER IS: $"
.CODE MAIN
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
    JE NEXT_LEVEL
    
    AND AL, 0FH
    SHL BX, 1
    OR BL, AL
    JMP INPUT
    
    NEXT_LEVEL:
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    
    LEA DX, MSG2
    MOV AH, 09H
    INT 21H
    
    MOV CX, 4
    
    OUTPUT:
    MOV AX, BX
    SHR AX, 12
    CMP AL, 9
    JG LETTER_HEX   
    ADD AL, '0'
    JMP PRINT
    
    LETTER_HEX:
    ADD AL, 55
    
    PRINT:
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    SHL BX, 4
    LOOP OUTPUT
    
    
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN