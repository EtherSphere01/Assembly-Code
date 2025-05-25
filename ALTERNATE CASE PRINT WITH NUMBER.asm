.MODEL SMALL
.STACK 100H
.DATA
LOW DB 0AH, 0DH,"LOWER CASE IS: $" 
HIGH DB 0AH, 0DH,"HIGHER CASE ID: $" 
DIG DB 0AH, 0DH, "THIS IS A DIGIT: $"
.CODE MAIN
MAIN PROC
     MOV AX, @DATA
     MOV DS, AX
     
     INPUT:
     MOV AH, 01H
     INT 21H
     MOV BL, AL
     
     CHECK_HIGHER1: 
     CMP BL, 41H
     JGE CHECK_HIGHER2
     JMP CHECK_LOWER1
     
     CHECK_HIGHER2:
     CMP BL, 5AH
     JLE DISPLAY_LOWER
     JMP CHECK_LOWER1
     
     CHECK_LOWER1:
     CMP BL, 61H
     JGE CHECK_LOWER2
     JMP DIGIT_CHECK1
     
     CHECK_LOWER2:
     CMP BL, 7AH
     JLE DISPLAY_HIGHER
     JMP DIGIT_CHECK1
     
     DIGIT_CHECK1:
     SUB BL, '0'
     CMP BL, 0
     JGE DIGIT_CHECK2
     JMP EXIT
     
     DIGIT_CHECK2:
     CMP BL, 9
     JLE DISPLAY_DIGIT
     JMP EXIT 
     
     DISPLAY_LOWER:
     ADD BL, 20H
     LEA DX, LOW
     MOV AH, 09H
     INT 21H
     
     MOV DL, BL
     MOV AH, 02H
     INT 21H
     JMP EXIT
     
     DISPLAY_HIGHER:
     SUB BL, 20H
     LEA DX, HIGH
     MOV AH, 09H
     INT 21H
     
     MOV DL, BL
     MOV AH, 02H
     INT 21H
     JMP EXIT 
     
     DISPLAY_DIGIT:
     ADD BL, '0'  
     LEA DX, DIG
     MOV AH, 09H
     INT 21H
     
     MOV DL, BL
     MOV AH, 02H
     INT 21H
     JMP EXIT
     
     
    
EXIT:
    MOV AH, 4CH
    INT 21H 
    
    
    
MAIN ENDP
END MAIN