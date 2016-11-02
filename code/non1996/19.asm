DATA SEGMENT            
    MAX_LEN DW 100
	INPUT_BUF DB 100 DUP(0)
DATA ENDS

STACK SEGMENT STACK
	DW 100 DUP(0)
STACK ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA, SS:STACK
START:
	MOV AX, DATA
	MOV DS, AX
	MOV AX, STACK
	MOV SS, AX

	MOV BX, OFFSET INPUT_BUF
	CALL GET_STRING			;�����ַ���

	CALL COUNT_ALPHA		;����

	CALL OUTPUT_NUM			;����ӳ���
			
	MOV AH, 04CH
	INT 21H

;-------------------------------------------------
;	����ӳ���
;	���: (DX)Ҫ�������
;	����: ��
;-------------------------------------------------
OUTPUT_NUM PROC NEAR
	PUSH AX
	PUSH BX
	PUSH DX

	MOV AX, DX
	MOV BL, 0AH
OUTLOOP:    
	DIV BL
	MOV DL, AH
	ADD DL, '0'
	MOV AH, 02H
	INT 21H
	CMP AL, 0
	JZ OUTLOOP		;�������

	POP DX
	POP BX
	POP AX
	RET
OUTPUT_NUM ENDP	

;-------------------------------------------------
;	�����ӳ���
;	���: (BX)�ַ�����ַ
;	����: (DX)�������ַ���
;-------------------------------------------------
COUNT_ALPHA PROC NEAR
	PUSH BX

	MOV DX, 0	
	CMP [BX], '$'	;�ж��ַ��������Ƿ�Ϊ0
	JZ FINISH		
COUNTER:
	CMP [BX], '0'
	JB NOT_NUM
	CMP [BX], '9'
	JA NOT_NUM		
	INC DX
NOT_NUM:	
	INC BX
	CMP [BX], '$'	
	JNZ COUNTER

FINISH:	
	POP BX
	RET
COUNT_ALPHA ENDP

;-------------------------------------------------
;	�����ַ����ӳ���
;	���: (BX)�ַ�����ַ
;	����: ��
;-------------------------------------------------
GET_STRING PROC NEAR
	PUSH AX
	PUSH BX
	PUSH CX

	MOV CX, WORD PTR MAX_LEN - 1	;��ʼ��ѭ�����������ַ����������롮$��
LOOPIN:	
	MOV AH, 1
	INT 21H

	CMP AL, '$' 
	JZ LOOPEND		;�ж��Ƿ�����'$'

	MOV [BX], AL
	INC BX			;��������ַ������ڴ�
	LOOP LOOPIN

LOOPEND: 
    MOV [BX], '$'   ;���ַ���ĩβ�Ӹ�'$'
    
	MOV AH, 02H
	MOV DL, 0DH
	INT 21H
	MOV DL, 0AH
	INT 21H			;��ʾ�س�����
	
	POP CX
	POP BX
	POP AX
	RET
GET_STRING ENDP

CODE ENDS
	END START