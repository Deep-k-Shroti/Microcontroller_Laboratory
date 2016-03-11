TIME_REAPEAT EQU 4
	ORG 8300H
	DB 31,28,31,30,31,30,31,31,30,31,30,31 ;storing the number of days in a different months
	ORG 8400H
	DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH ;storing corresponding values for displaying digits 0-9 in 7 segment LED
	ORG 0FFF0H
	LJMP TIMER0 ;timer0 interrupt
	ORG 8100H ;main program starts here
	MOV DPTR,#9000H ;storing initial time as 23:55:00 and initial date as 31/12/2011
	MOV A,#23 ;For Hours
	MOVX @DPTR,A ;Copied Hours to external Memory
	INC DPTR ;Increment in External Memory
	MOV A,#59 ;For Minutes
	MOVX @DPTR,A ;Copied Minutes to external Memory
	INC DPTR ;Increment in External Memory
	MOV A,#40 ; for Seconds
	MOVX @DPTR,A ;Copied Seconds to external Memory
	INC DPTR ;Increment in External Memory
	MOV A,#31 ;For date
	MOVX @DPTR,A ;Copied Dates to external Memory
	INC DPTR ;Increment in External Memory

	MOV A,#12 ;For Months
	MOVX @DPTR,A ;Copied Months to external Memory
	INC DPTR ;Increment in External Memory
	MOV A,#11 ; For Years
	MOVX @DPTR,A ;Copied Years to external Memory
	MOV DPTR,#0E803H
	MOV A,#85H	; setting PORTA and B of 8255 as output and PORTC as input
	MOVX @DPTR,A
	MOV TMOD,#00000001B ;we will use timer0 in mode 1
	MOV TL0,#0DCH ;TL0=0DCH ,THE LOW BYTE
	MOV TH0,#0BH ;TL0=0BH ,THE HIGH BYTE
	CLR TF0 ;Clear Time
	MOV IE,#82H ;we will use timer interrupt 0
	SETB TR0 ;starting timer
	LOOP_1:
	MOV DPTR,#9000H ;Move external Memory to 9000H
	MOVX A,@DPTR ;Reading hours
	MOV B,#0AH ;Register B=10 in decimal
	DIV AB ;dividing by 10 to get the 2 digits
	MOV 30H,A ;storing 10's digit of seconds
	MOV 31H,B ;storing unit's digit of seconds
	INC DPTR ;Increment in External Memory


	MOVX A,@DPTR ;doing same for minutes, seconds, days, months and years...
MOV B,#0AH ;Register B=10 in decimal
DIV AB ;Divide A by B for Units & Ten’s Digit
MOV 32H,A ;storing 10's digit of Minutes
MOV 33H,B ;storing unit's digit of Minutes
INC DPTR ;Increment in External Memory
MOVX A,@DPTR ;Assign Accumulator by External Memory data
MOV B,#0AH ;Register B=10 in decimal
DIV AB ;Divide A by B for Units & Ten’s Digit
MOV 34H,A ;storing 10's digit of Hours
MOV 35H,B ;storing unit's digit of Hours
MOV DPTR,#9003H ;Move DPTR to 9003H
MOVX A,@DPTR ;Assign Accumulator by External Memory data
MOV B,#0AH ;Register B=10 in decimal
DIV AB ;Divide A by B for Units & Ten’s Digit
MOV 36H,A ;storing 10's digit of Days
MOV 37H,B ;storing unit's digit of Days
INC DPTR ;Increase in External Memory Address
MOVX A,@DPTR ;Assign Accumulator by External Memory data
MOV B,#0AH ;Register B=10 in decimal
DIV AB ;Divide A by B for Units & Ten’s Digit
MOV 38H,A ;storing 10's digit of Months
MOV 39H,B ;storing unit's digit of Months
INC DPTR ;Increase in External Memory Address
MOVX A,@DPTR ;Assign Accumulator by External Memory data
MOV B,#0AH ;Register B=10 in decimal
DIV AB ;Divide A by B for Units & Ten’s Digit
MOV 3AH,A ;storing 10's digit of Years
MOV 3BH,B ;storing unit's digit of Years


MOV DPTR,#0E802H ;
MOVX A,@DPTR ;
MOV DPTR,#9010H ;
MOVX @DPTR,A
JB ACC.3,LOOP_2 ;Mode change for Display of Date or Time
ACALL DISPLAY_TIME ;calling function to display date
SJMP LOOP_1 ;Calling the LOOP_1
LOOP_2:ACALL DISPLAY_DATE ;calling function to display time
SJMP LOOP_1 ;Calling the LOOP_1
TIMER0: ;routine to handle timer0 interrupt
CLR TR0 ;stopping timer0
PUSH 82H ;saving registers to stack
PUSH 83H ;saving registers to stack
PUSH 0E0H ;saving registers to stack
PUSH 01H ;saving registers to stack
PUSH 02H ;saving registers to stack
PUSH 03H ;saving registers to stack
MOV R1,TIME_REAPEAT
INC R1 ;INCREMENT
CJNE R1,#16,LOOP_4;if 1s is not over, go to LOOP_4, else...
MOV R1,#0
MOV TIME_REAPEAT,#0 ;
MOV DPTR,#9002H ;reading seconds
MOVX A,@DPTR ;Copy External Memory data to Accumulator
INC A ;Incrementing seconds
CJNE A,#60,LOOP_3;if 60s is not over, go to LOOP_3, else...
CLR A ;setting seconds as 0
MOVX @DPTR,A ;Copy External Memory data to Accumulator
MOV DPTR,#9001H
MOVX A,@DPTR ;Copy External Memory data to Accumulator
INC A ;incrementing minutes
CJNE A,#60,LOOP_3 ;if 60mins is not over, go to LOOP_3, else...
CLR A ;Set minutes as 0
MOVX @DPTR,A ;Copy External Memory data to Accumulator
MOV DPTR, #9000H
MOVX A,@DPTR ;reading hours
INC A ;incrementing hours
CJNE A,#24,LOOP_3 ;if 24hrs is not over, go to LOOP_3, else...
CLR A
MOVX @DPTR,A ;set hours as 0
MOV DPTR,#9003H ;read day
MOVX A,@DPTR ;Copy External Memory data to Accumulator
INC A ;incrementing days
MOV R2,A
INC DPTR ;Increment in External Memory Address
MOVX A,@DPTR ;reading months
MOV DPTR,#82FFH
MOVC A,@A+DPTR ;reading the number of valid days of that month
INC A ;1 day more than the number of valid days would be invalid
MOV DPTR,#9003H ;Move External Memory to 9003H
MOV 3,2
MOV 2,A
MOV A,3
CJNE A,2,LOOP_3 ;if number of days is not equal to the one more than the number of valid days for that month, go to LOOP_3, else...
MOV A,#01
MOVX @DPTR,A ;setting days as 1
MOV DPTR,#9004H ;reading month
MOVX A,@DPTR
INC A ;incrementing month
CJNE A,#13,LOOP_3 ;if months not equal to 13, which is invalid, go to LOOP_3
MOV A,#01
MOVX @DPTR,A ;setting months as 1
INC DPTR
MOVX A,@DPTR ;reading year


INC A ;incrementing years
LOOP_3:MOVX @DPTR,A ;updating the entity...
LOOP_4:
MOV TIME_REAPEAT,R1 ;updating TIME_REAPEAT
POP 03H ;restoring saved registers from the stack
POP 02H ;restoring saved registers from the stack
POP 01H ;restoring saved registers from the stack
POP 0E0H ;restoring saved registers from the stack
POP 83H ;restoring saved registers from the stack
POP 82H ;restoring saved registers from the stack
MOV TL0,#0DCH ;TL0=0DCH ,THE LOW BYTE
MOV TH0,#0BH ;TH0=0BH ,THE HIGH BYTE
SETB TR0 ;starting timer0 again
RETI ;returning from interrupt service routine
DISPLAY_TIME: ;routine to display time in HH:MM:SS format
MOV DPTR,#0E801H
MOV A,#11111110B
MOVX @DPTR,A ;only last 7 segment display made active
MOV DPTR,#8400H
MOV A,35H ;obtaining the unit's digit of seconds
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A ;writing that value
ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H ;doing the same for all the digits of minutes and hours...
MOV A,#11111101B
MOVX @DPTR,A ;only 7 segment display made active
MOV DPTR,#8400H
MOV A,34H ;obtaining the unit's digit of Minutes
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A ;writing that value
ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H
MOV A,#11111011B
MOVX @DPTR,A ;only 7 segment display made active
MOV DPTR,#8400H
MOV A,33H ;obtaining the unit's digit of Hours
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A ;writing that value


ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H
MOV A,#11110111B ;only 7 segment display made active
MOVX @DPTR,A ;Copy data from Accumulator to External Memory
MOV DPTR,#8400H ;Specify External Memory at 8400H
MOV A,32H
MOVC A,@A+DPTR ;Copy data to Accumulator from External Memory with Accumulator Sums
MOV DPTR,#0E800H ;Specify External Memory at E800H
MOVX @DPTR,A ;Copy data from Accumulator to External Memory with Accumulator Sums
ACALL DISP_DELAY ;Calling Delay
MOV DPTR,#0E801H ;Specify External Memory at E801H
MOV A,#11101111B ;only 7 segment display made active
MOVX @DPTR,A ;Copy data from Accumulator to External Memory
MOV DPTR,#8400H ;Specify External Memory at 8400H
MOV A,31H
MOVC A,@A+DPTR ;Copy data from Accumulator to External Memory with Accumulator Sums
MOV DPTR,#0E800H
MOVX @DPTR,A ;Copy data from Accumulator to External Memory
ACALL DISP_DELAY ;Calling Delay
MOV DPTR,#0E801H
MOV A,#11011111B ;only 7 segment display made active
MOVX @DPTR,A ;Copy data from Accumulator to External Memory
MOV DPTR,#8400H ;Specify External Memory at 8400H
MOV A,30H
MOVC A,@A+DPTR ;Copy data from Accumulator to External Memory with Accumulator Sums
MOV DPTR,#0E800H ;Specify External Memory at E800H
MOVX @DPTR,A ;Copy data from Accumulator to External Memory
ACALL DISP_DELAY ;Calling Delay
RET
DISPLAY_DATE:
;routine to display the date in DD:MM:YY format, in the same way as time
MOV DPTR,#0E801H
MOV A,#11111110B
MOVX @DPTR,A ;only last 7 segment display made active
MOV DPTR,#8400H
MOV A,3BH ;obtaining the unit's digit of Days
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A ;writing that value
ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H
MOV A,#11111101B ;only last 7 segment display made active
MOVX @DPTR,A
MOV DPTR,#8400H
MOV A,3AH ;obtaining the unit's digit of Months
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A ;writing that value
ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H
MOV A,#11111011B ;only last 7 segment display made active
MOVX @DPTR,A
MOV DPTR,#8400H
MOV A,39H ;obtaining the unit's digit of Years
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A ;writing that value
ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H
MOV A,#11110111B
MOVX @DPTR,A
MOV DPTR,#8400H
MOV A,38H
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A
ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H
MOV A,#11101111B
MOVX @DPTR,A
MOV DPTR,#8400H
MOV A,37H
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A
ACALL DISP_DELAY ;calling a small delay
MOV DPTR,#0E801H
MOV A,#11011111B
MOVX @DPTR,A
MOV DPTR,#8400H
MOV A,36H
MOVC A,@A+DPTR ;obtaining the value to be written to 8255 to display that digit
MOV DPTR,#0E800H
MOVX @DPTR,A
ACALL DISP_DELAY
RET
DISP_DELAY:
MOV R7,#100 ;delay OF 100 cycles...
RPT:DJNZ R7,RPT ;Decrease the Value of R7 by 1 ,Decrement and Jump if Not Zero
RET
END ;End of Program