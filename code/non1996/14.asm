DATA SEGMENT
	ARRAY DW -10,-9,-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8,9,10
	NEGA_ARRAY DW 20 DUP(0)
	POSI_ARRAY DW 20 DUP(0)

	NEGA_ARRAY_LEN DB '00', 0DH, 0AH, '$'
	POSI_ARRAY_LEN DB '00', 0DH, 0AH, '$'
DATA ENDS

CODE SEGMENT
	ASSUME CS: CODE, DS: DATA
START:
	MOV AX, DATA
	MOV DS, AX

	MOV CL, 20

	MOV SI, OFFSET NEGA_ARRAY	;����
	MOV DI, OFFSET POSI_ARRAY	;����
	MOV BX, OFFSET NEGA_ARRAY	;
	MOV DX, OFFSET POSI_ARRAY	;�����׵�ַ

	MOV BP, OFFSET ARRAY
	
LOOP_SELECT:
	MOV AX, [BP]
	CMP AX, 0
	JL NAGETIVE

	MOV [DI], AX
	ADD DI, 2
	JMP NEXTLOOP
NAGETIVE:
	MOV [SI], AX
	ADD SI, 2
NEXTLOOP:
	ADD BP, 2
LOOP LOOP_SELECT	

					
	MOV AX, SI			;���㸺����ĳ���
	SUB AX, BX
	SHR AX, 1
	MOV BP, OFFSET NEGA_ARRAY_LEN
	CALL OUTPUT_LEN
	
	MOV AX, DI			;���������鳤��
	SUB AX, DX
	SHR AX, 1
	MOV BP, OFFSET POSI_ARRAY_LEN		
	CALL OUTPUT_LEN

	MOV AH, 4CH
	INT 21H

;-------------------------------------------------
;	�����鳤����ʮ�������
;	���(AX),��¼���鳤��. (BP),��¼���ȴ�ŵ�ַ���±�
;	����(��)
;-------------------------------------------------
OUTPUT_LEN PROC NEAR
	PUSH AX
	PUSH BX
	PUSH DX
       
    MOV BL, 10
	DIV BL
	ADD AH, '0'
	MOV [BP + 1], AH	;�õ���λ��ascii��
	
	MOV AH, 00H
	DIV BL
	ADD AH, '0'		;�õ���λ��ascii��
	MOV [BP], AH
	
	MOV AH, 9
	MOV DX, BP
	INT 21H			;�������

	POP DX
	POP BX
	POP AX
	RET
OUTPUT_LEN ENDP	

CODE ENDS
	END START