DATA SEGMENT
	A DW 0
	B DW 0
DATA ENDS

STACK SEGMENT STACK
	DW 10H DUP(0)
STACK ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
      
	MOV AX, A
	AND AX, 1
	MOV BX, B
	AND BX, 1
	MOV CX, 0	;??¼????????

	CMP AX, 0
	JZ NEXT
	INC CX
NEXT:	
	CMP BX, 0
	JZ EXECUTE
	INC CX 		
EXECUTE:
	CMP CX, 0
	JZ FINISH
	CMP CX, 1
	JZ ONE
TWO:
	INC A
	INC B
	JMP FINISH
ONE:
	CMP AX, 1
	JZ FINISH
	MOV BX, B
	MOV AX, A
	MOV A, BX
	MOV B, AX
FINISH:
	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START