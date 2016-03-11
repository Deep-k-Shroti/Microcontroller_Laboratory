ORG 8100H
   
    MOV TMOD,#10H
   
   
    MOV A,#80H
    MOV DPTR,#0E803H
    MOVX @DPTR,A
   
    MOV DPTR,#0E801H
    MOV A,#00H
    MOVX @DPTR,A
   
    MOV R0,#38H         //INIT
    ACALL CMD
    MOV R0,#0FH
    ACALL CMD
    MOV R0,#01H
    ACALL CMD
   
    MOV R1,#0
L2:    MOV A,R1
    MOV DPTR,#8300H
    MOVC A,@A+DPTR
    MOV R0,A
    ACALL DISP
    INC R1
    CJNE R1,#0DH,L2
   
    MOV R0,#0C0H
    ACALL CMD   
   
    MOV R1,#0
L3:    MOV A,R1
    MOV DPTR,#8320H
    MOVC A,@A+DPTR
    MOV R0,A
    ACALL DISP
    INC R1
    CJNE R1,#0CH,L3
   
L1:    MOV R0,#18H
    ACALL CMD
    ACALL BIG
    SJMP L1

CMD: MOV DPTR,#0E800H
    MOV A,R0
    MOVX @DPTR,A
    MOV DPTR,#0E801H
    MOV A,#04H
    MOVX @DPTR,A
    MOV A,#00H
    MOVX @DPTR,A
    ACALL DELAY
    RET

DISP:MOV DPTR,#0E800H
    MOV A,R0
    MOVX @DPTR,A
    MOV DPTR,#0E801H
    MOV A,#05H
    MOVX @DPTR,A
    MOV A,#01H
    MOVX @DPTR,A
    ACALL DELAY
    RET
   
DELAY:    MOV TH1,#0F0H            //7 MS DELAY
        MOV TL1,#00H
        SETB TR1
AGAIN3:    JNB TF1,AGAIN3
        CLR TR1
        CLR TF1
        RET
       
BIG:    MOV R5,#3D
TEMP:    MOV TH1,#00H            //2S DELAY
        MOV TL1,#00H
        SETB TR1
AGAIN2:    JNB TF1,AGAIN2
        CLR TR1
        CLR TF1
        DJNZ R5, TEMP
        RET       

ORG 8300H
    DB "VED 12EC10061"
ORG 8320H
    DB "D229 RP HALL"

       
   
       
        END