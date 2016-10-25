DATA SEGMENT
	ERROR	DB 0DH,0AH,'input error',0DH,0AH,'$'
	CHAR_A  DB 'a'
	CHAR_Z  DB 'z'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

IOLOOP:
	MOV AH, 8
	INT 21H

	MOV AH, CHAR_A
	CMP AL, AH
	JB IOFIN	;�ж������ַ��Ƿ�С��'a',����������������
	JZ IS_A
	MOV AH, CHAR_Z
	CMP AL, AH	
	JA IOFIN	;�ж������ַ��Ƿ����'z',����������������
    JZ IS_Z      
    
    ;������ַ�����a��z
    MOV AH, 2   
	MOV DL, AL
	DEC DL
	INT 21H
	INC DL
	INT 21H
	INC DL
	INT 21H		;��������ַ�

	JMP IOLOOP
    
IS_A:
    MOV AH, 2
    MOV DL, 'z'
    INT 21H
    MOV DL, 'a'
    INT 21H
    MOV DL, 'b'
    INT 21H
    
    JMP IOLOOP 

IS_Z:
	MOV AH, 2
    MOV DL, 'y'
    INT 21H
    MOV DL, 'z'
    INT 21H
    MOV DL, 'a'
    INT 21H
    
    JMP IOLOOP

IOFIN:    
    MOV AH, 9
    MOV DX, OFFSET ERROR
    INT 21H     ;��ʾ������Ϣ
    
	MOV AH, 04CH
	INT 21H
CODE ENDS
	END START