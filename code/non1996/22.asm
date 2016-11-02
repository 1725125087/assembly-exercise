DATA SEGMENT        
;	TABLE DW 30 DUP(-10), 70 DUP(10)
;    TABLE DW 1, 2, 2, 3, 3, 3
    TABLE DW 100H DUP(0)
	LEN DW ($ - TABLE) / 2
	MAX_APPEAR DW 0
	MAX_NUM DW 0
DATA ENDS


CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX


	MOV AX, 0		        ;ax��¼��ǰ��
	MOV BX, 0		        ;bx��¼�������ֵĴ���

	MOV CX, LEN		        ;
	MOV DX, OFFSET LEN		        ;ѭ��������

	MOV SI, OFFSET TABLE	;���ѭ���±�
	MOV DI, OFFSET TABLE	;�ڲ�ѭ���±�

LOOP_FIRST:
	
	MOV AX, [SI]
    MOV DI, SI
	LOOP_SECOND:		    ;�ڲ�ѭ��Ѱ�Һ͵�ǰ����ͬ������ÿ�ҵ�һ����������1
		CMP AX, [DI]
		JNZ NEQUAL
		INC BX
		
		ADD DI, 2
		CMP DI, DX		
	JNZ LOOP_SECOND;LOOP_SECOND
	
NEQUAL:
    
	CMP BX, MAX_NUM         ;�Աȵ�ǰ���ĳ��ִ����Ƿ����֮ǰ�����ִ���
	JNA NEXTLOOPF           ;�������滻
	MOV MAX_APPEAR, AX
	MOV MAX_NUM, BX	
NEXTLOOPF:		
	MOV SI, DI	
	MOV BX, 0		        ;Ϊ�´�ѭ��׼��
	   
	CMP SI, DX   
    JNZ LOOP_FIRST;LOOP_FISRT
    
    MOV AX, MAX_APPEAR
    MOV CX, MAX_NUM

	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START