DATA SEGMENT
	ARRAY DW 80H DUP(-1), 80H DUP(3)
	ARRAY_END DB 0                        
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

	MOV CX, OFFSET ARRAY_END	
	MOV AX, 0		;��͵ĵ���
	MOV DX, 0		;��͵ĸ���
	MOV SI, OFFSET ARRAY
;--------------------------------------------------���
SUM:        
    CMP [SI], 0
    JL NEGA
    
	ADD AX, [SI]	
	ADC DX, 0
    JMP CONTINUE
NEGA:
    MOV BX, [SI]
    NEG BX
    SUB AX, BX
    SBB DX, 0

CONTINUE:	
	ADD SI, 2
	CMP SI, CX
	JNZ SUM	

;--------------------------------------------------��ƽ����axΪƽ��ֵ
AVERAGE:
	MOV CX, 0100H
	DIV CX

;--------------------------------------------------����С��ƽ��ֵ����������
	MOV SI, OFFSET ARRAY
	MOV CX, OFFSET ARRAY_END
	MOV BX, 0
COUNT:
	CMP [SI], AX
	JAE LARGER
	INC BX
LARGER:	
	ADD SI, 2
	CMP SI, CX
	JNZ COUNT
		
	MOV AH, 04CH
	INT 21H
CODE ENDS
	END START
