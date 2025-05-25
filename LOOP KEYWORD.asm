.MODEL SMALL
.STACK 100H
.DATA
.CODE MAIN
MAIN PROC
    
    MOV CX, 5
     
    COUNT:
    MOV DL, 'A'
    MOV AH, 02H  
    INT 21H
    LOOP COUNT
     
     
    
EXIT:
    MOV AH, 4CH
    INT 21H 
    
    
    
MAIN ENDP
END MAIN