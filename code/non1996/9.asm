DATA SEGMENT
	LTOH	DB -32
	CHAR_A  DB 'a'
	CHAR_Z  DB 'z'
	
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

IOLOOP:
	CALL LOWER_IN
	CALL LOW_TO_UP
	CALL OUTPUT	;��������ӳ������
	JMP IOLOOP

;FINAL:
	MOV AH, 04CH
	INT 21H

		
;---------����Сд�ַ����ӳ���,�����,����ΪAX,����������
LOWER_IN PROC NEAR
LOOP_IN:
	MOV AH, 8
	INT 21H		;�����ַ���������
	
	MOV AH, CHAR_A
	CMP AL, AH
	JB LOOP_IN	;�ж������ַ��Ƿ�С��'a'
	MOV AH, CHAR_Z
	CMP AL, AH	
	JA LOOP_IN	;�ж������ַ��Ƿ����'z'
	
	RET
LOWER_IN ENDP
;----------------------------------------------------------

;--------------------Сдת��Ϊ��д���ӳ���,���ΪAX,�޳���
LOW_TO_UP PROC NEAR
	ADD AL, LTOH
    
    RET
LOW_TO_UP ENDP
;----------------------------------------------------------

;--------------------------��ʾ�ַ����ӳ���,���ΪAX,�޳���
OUTPUT PROC NEAR
    PUSH DX
    MOV DL, AL
	MOV AH, 2
	INT 21H
	POP DX
	
	RET
OUTPUT ENDP
;----------------------------------------------------------

CODE ENDS
	END START