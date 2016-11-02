DATA SEGMENT	
	INBUF DB 4 DUP(0)
	MENU DB 'input your num', 0dh, 0ah, '$'
	ERROR_INPUT DB 'input error!', 0dh, 0ah, '$'
	ENTER DB 0DH, 0AH, '$' 
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
    
    MOV BX, OFFSET INBUF   
    CALL INPUT_HEX		;�����ַ�����ָ���ڴ�ռ�
	
	MOV CX, 4
	MOV BX, OFFSET INBUF
	
OUTPUT:					;�������ǰ4λ���
	MOV AL, [BX]

	CMP AL, '0'
	JB ERROR
	CMP AL, '9'
	JB DECI
	CMP AL, 'A'
	JB ERROR
	CMP AL, 'F'
	JA ERROR
	JMP ALPH				;�ж������Ƿ�Ϸ�
DECI:
	SUB AL, '0'
	CALL OUTPUT_HEX		;����Ϊ����0С��9��ʮ��������
	JMP GETNEXT
ALPH:	
	SUB AL, 'A'
	ADD AL, 10			;����Ϊ����AС��F��ʮ��������
	CALL OUTPUT_HEX
GETNEXT:
    INC BX
LOOP OUTPUT
    JMP FINISH

ERROR:	
	MOV AH, 09H
	MOV DX, OFFSET ERROR_INPUT
	INT 21H				;���������������ʾ

FINISH:	
	MOV AH, 04CH			;�������
	INT 21H
		
;-------------------------------------------------------------------
;	�Ӽ��̻�ȡ4λʮ��������
;	��ڣ�(BX)���滺��ĵ�ַ
;	���ڣ���
;-------------------------------------------------------------------
INPUT_HEX PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
             
    MOV AH, 09H
    MOV DX, OFFSET MENU         
             
    MOV CX, 4
INPUT_LOOP:
    MOV AH, 01H
    INT 21H
    
    MOV [BX], AL
    INC BX
LOOP INPUT_LOOP 

    MOV AH, 09H
	MOV DX, OFFSET ENTER
	INT 21H         ;���� 
	
	POP DX
    POP CX
    POP BX
    POP AX
    
    RET            
INPUT_HEX ENDP
;-------------------------------------------------------------------
;-------------------------------------------------------------------

;-------------------------------------------------------------------
;	��һ��ʮ����������2�������
;	��ڣ���DL��
;	���ڣ���
;-------------------------------------------------------------------
OUTPUT_HEX PROC NEAR
	PUSH AX
	PUSH DX
	PUSH CX	         
	         
	MOV CX, 4	
LOOPOUT:
	MOV DL, AL
	AND DL, 08H		
	CMP DL, 00H
	JZ ZERO			;�ж����λ��0����1

	MOV DL, '1'
	JMP NEXTLOOP
ZERO:
	MOV DL, '0'
NEXTLOOP:	
	MOV AH, 02H 
	PUSH AX
	INT 21H			;ÿ�ν����λ���
	POP AX          ;��AX��ջ��Ϊϵͳ���û�ı�AL��ֵ
	SHL AL, 1		;AL����
LOOP LOOPOUT	

	POP CX
	POP DX
	POP AX
	RET
OUTPUT_HEX ENDP
;-------------------------------------------------------------------
;-------------------------------------------------------------------

CODE ENDS
	END START 