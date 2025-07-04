.MODEL SMALL
.STACK 100H
.DATA
MSG DB "LOWER CASE IS: $"
.CODE MAIN
MAIN PROC
    MOV AX, @DATA    
    MOV DS, AX

INPUT:
    MOV AH, 01H     
    INT 21H
    MOV BL, AL
    
CHECK1:
    CMP BL, 41H
    JGE CHECK2
    JMP EXIT
    
CHECK2:
    CMP BL, 5AH
    JLE DISPLAY
    JMP EXIT
    
DISPLAY:
    MOV AH, 02H
    MOV DL, 0AH
    INT 21H  
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    
    LEA DX, MSG
    MOV AH, 09H
    INT 21H
    
    ADD BL, 20H
    MOV DL, BL 
    MOV AH, 02H
    INT 21H  
    
EXIT:
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN