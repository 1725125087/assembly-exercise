DATA SEGMENT 
	MEM DW 25 DUP(1, 0, 2, 0)
	TEMP DW 100 DUP(0)
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
;---------------------------------�����з���ֵ������ʱ����
	MOV DX, 0	;����������¼�ж��ٸ�����ֵ
	MOV BX, OFFSET MEM
	MOV SI, OFFSET TEMP
	MOV CX, 100	
FIND_NZ:			
	CMP [BX], 0
	JZ ZERO
	
	MOV AX, [BX]
	MOV [SI], AX
	ADD SI, 2
ZERO:
	ADD BX, 2
LOOP FIND_NZ

;---------------------------------����ʱ���鿽����ԭ����
	MOV BX, OFFSET MEM
	MOV SI, OFFSET TEMP
	MOV CX, 100
CPY:				;����ʱ���鿽����ԭ����
	MOV AX, [SI]
	MOV [BX], AX
	ADD BX, 2
	ADD SI, 2
	CMP [SI], 0
LOOP CPY
	
	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START