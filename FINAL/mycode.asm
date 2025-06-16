.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "ENTER A HEX NUMBER: $"
MSG2 DB "BINARY NUMBER: $"
ONE  DB ?
ZERO DB ?
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
    JE NEXT_LINE
    CMP AL, 39H
    JG LETTER
    AND AL, 0FH
    JMP SHIFT

LETTER:
    SUB AL, 37H

SHIFT:
    SHL BX, 4
    OR BL, AL
    JMP INPUT

NEXT_LINE:
    MOV CX, 16
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

; --- MODIFIED SECTION BEGINS ---

OUTPUT:
    SHL BX, 1        ; Shift MSB into Carry Flag
    JNC IS_ZERO      ; If Carry is 0, jump to the zero-handling block

IS_ONE:              ; This block runs if Carry was 1
    MOV DL, '1'
    INC ONE
    JMP DO_PRINT     ; Jump to the common print logic

IS_ZERO:             ; This block runs if Carry was 0
    MOV DL, '0'
    INC ZERO
    ; Falls through to the common print logic

DO_PRINT:
    MOV AH, 02H
    INT 21H
    LOOP OUTPUT

; --- END OF PRIMARY MODIFICATION ---

    ; Newline before printing counts
    MOV AH, 02H
    MOV DL, 0AH
    INT 21H
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H

    ; Print the count of Zeros
    MOV AH, 02H
    MOV DL, 'Z'      ; Print 'Z'
    INT 21H
    MOV DL, ':'      ; Print separator
    INT 21H

    MOV AL, ZERO     ; Load the count of zeros into AL
    AAM              ; Divide AL by 10. Result: AH = tens digit, AL = ones digit
    ADD AX, 3030H    ; Convert both digits to ASCII characters

    MOV DL, AH       ; Move tens digit for printing
    MOV AH, 02H
    INT 21H

    MOV DL, AL       ; Move ones digit for printing
    MOV AH, 02H
    INT 21H

    ; Print a space between the two counts
    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    ; Print the count of Ones
    MOV AH, 02H
    MOV DL, 'O'      ; Print 'O'
    INT 21H
    MOV DL, ':'      ; Print separator
    INT 21H

    MOV AL, ONE      ; Load the count of ones into AL
    AAM              ; Divide AL by 10. Result: AH = tens digit, AL = ones digit
    ADD AX, 3030H    ; Convert both digits to ASCII characters

    MOV DL, AH       ; Move tens digit for printing
    MOV AH, 02H
    INT 21H

    MOV DL, AL       ; Move ones digit for printing
    MOV AH, 02H
    INT 21H

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN