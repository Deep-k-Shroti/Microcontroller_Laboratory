ORG 8100H
MOV TMOD,#20H ; the timer mode :timer 1,mode 2(auto reload)
MOV TH1,#-3 ; baud rate = 9600 bps
MOV SCON,#50H ;8-bit, 1 stop, Receiver interrupt enabled
SETB TR1 ;start timer 1
HERE: JNB RI,HERE ;wait until value is received
MOV A,SBUF ;save received value in A
MOV DPTR, #9001H
MOVX @DPTR,A ;send value to memory
SJMP HERE ;continue receiving data
END