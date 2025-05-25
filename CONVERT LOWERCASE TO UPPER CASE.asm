.MODEL SMALL
.STACK 100H
.DATA 
MSG1 DB "HELLO WORLD$"
.CODE MAIN  
MAIN PROC
        USER_INPUT:
        MOV AH, 01H
        INT 21H
        
        COMPARE1:
        CMP AL, 61H
        JGE COMPARE2
        JMP EXIT
        
        COMPARE2:
        CMP AL, 7AH
        JLE DISPLAY 
        JMP EXIT
        
        DISPLAY:
        SUB AL, 20H 
        MOV AH, 02H 
        MOV DL, 0AH
        INT 21H 
        MOV AH, 02H 
        MOV DL, 0DH
        INT 21H
        MOV AH, 02H
        MOV DL, AL
        INT 21H
       
        
        EXIT:
        MOV AH, 4CH
        INT 21H 
        
        
    
    MAIN ENDP
END MAIN