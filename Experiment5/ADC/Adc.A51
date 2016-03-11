
        ORG 8100H   
       
       
        MOV TMOD,#10H
       
        MOV DPTR,#0E803H       // SETTING CONT REG C AS OUTPUT
        MOV A,#83H
        MOVX @DPTR,A
       
        MOV DPTR,#0E801H       // initialize B
        MOV A,#0FFH
        MOVX @DPTR,A

L2:        MOV DPTR,#0E802H       // initialize C
        MOV A,#0FFH
        MOVX @DPTR,A
       
        MOV DPTR,#0E802H       // START CONV
        MOVX A,@DPTR
        ANL A,#0EFH
        MOVX @DPTR,A
       
       
L1:        MOV DPTR,#0E802H       // EOC CHECK
        MOVX A,@DPTR
        ANL A,#02H
        JNZ L1
       
        ;MOV DPTR,#0E802H       // OUTPUT ENABLE
        ;MOVX A,@DPTR
        ;ANL A,#0DFH
        ;MOVX @DPTR,A
       
        MOV DPTR,#0E801H       // LATCHING DATA
        MOVX A,@DPTR
        MOV R7,A
       
        CJNE A,#150,JMP1
JMP1:    JC JMP2
        MOV DPTR,#0E802H       //COFF
        MOVX A,@DPTR
        ANL A, #0BFH
        MOVX @DPTR,A
        SJMP JMP3
       
JMP2:    MOV DPTR,#0E802H
        MOVX A,@DPTR            //CON
        ORL A, #40H
        MOVX @DPTR,A
       
JMP3:    MOV DPTR,#0E800H       // DISPLAYING DATA
        MOV A,R7
        MOVX @DPTR,A
       
        ACALL DELAY
        SJMP L2
       
DELAY:    MOV TH1,#00H            //70 MS DELAY
        MOV TL1,#00H
        SETB TR1
AGAIN3:    JNB TF1,AGAIN3
        CLR TR1
        CLR TF1
        RET
       
        END