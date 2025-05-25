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
    ADD BL, '0'
    MOV DL, BL
    MOV AH, 02H
    INT 21H
    JMP EXIT
     
     
    
EXIT:
    MOV AH, 4CH
    INT 21H 
    
    
    
MAIN ENDP
END MAIN