

	ORG 8100H
	MOV R6,#100
	MOV R3,#00
	MOV R2,#00
	MOV DPTR,#9000H
	MOV A, #01
	MOV R7, #10
VAL:MOVX @DPTR, A
	INC A
	INC DPTR
	DJNZ R7, VAL 
	MOV DPTR,#9000H
	
TOP:
	MOVX A,@DPTR
	CJNE A,3,SECH
SECH:
	JNC UPDH
	CJNE A,2,THDH
THDH:
	JNC UPDS
FIN:
	INC DPTR
	DJNZ R6,TOP
	SJMP RES
UPDH:

	MOV 2,3
	MOV 3,A
	SJMP FIN
UPDS:
	MOV 2,A
	SJMP FIN
RES:
	MOV DPTR,#9500H
	MOV A,R2
	MOVX @DPTR,A
HERE:SJMP HERE
	END