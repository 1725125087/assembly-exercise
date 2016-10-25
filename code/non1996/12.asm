DATA SEGMENT
	MAX_LEN DB 100
	STRING1	DB 100 DUP(0)
	STRING2 DB 100 DUP(0)
	
	NO_MATCH DB 'NO MATCH', 0DH, 0AH, '$'
	MATCH DB 'MATCH', 0DH, 0AH, '$'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

	MOV BX, OFFSET STRING1
	CALL GET_STRING	
	MOV BX, OFFSET STRING2
	CALL GET_STRING		;��ȡ�����ַ���

	MOV SI, OFFSET STRING1
	MOV DI, OFFSET STRING2
	CALL CMP_STRING		;�Ƚ��ַ���
	
	MOV AH, 4CH
	INT 21H

;-------------------------------------------------
;	�����ַ����ӳ������Ϊ�ַ�����ַ, ��BX�洢
;-------------------------------------------------
GET_STRING PROC NEAR
	PUSH AX
	PUSH BX
	PUSH CX

	MOV CX, WORD PTR MAX_LEN - 1	;��ʼ��ѭ�����������ַ����������롮$��
LOOPIN:	
	MOV AH, 1
	INT 21H

	CMP AL, 0DH
	JZ LOOPEND		;�ж��Ƿ�����س�

	MOV [BX], AL
	INC BX			;��������ַ������ڴ�
	LOOP LOOPIN

LOOPEND:
	MOV AH, 02H
	MOV DL, 0DH
	INT 21H
	MOV DL, 0AH
	INT 21H			;��ʾ�س�����
	MOV [BX], BYTE PTR '$'		;���ַ���ĩβ����'$'	
	
	POP CX
	POP BX
	POP AX

	RET
GET_STRING ENDP

;-------------------------------------------------
;	�Ƚ��ַ����ӳ������Ϊ�ַ�����ַ, ��SI, ��DI�洢
;-------------------------------------------------
CMP_STRING PROC NEAR
	PUSH SI
	PUSH DI
	PUSH CX
	PUSH DX
	
CMP_LOOP:
    MOV CL, [SI]
	CMP CL, [DI]
	JNZ NEQUAL		;�Ƚ�ÿ���ַ�
	
	CMP CL, '$'		
	JZ EQUAL		;�ж��Ƿ��ַ���ĩβ

	INC SI
	INC DI			
	
	JMP CMP_LOOP
	
EQUAL:
	MOV AH, 09H
	MOV DX, OFFSET MATCH
	INT 21H
	JMP FINISH

NEQUAL:
	MOV AH, 09H
	MOV DX, OFFSET NO_MATCH
	INT 21H	
	JMP FINISH

FINISH:	
	POP DX
	POP CX
	POP DI
	POP SI
	RET
CMP_STRING ENDP

CODE ENDS
	END START