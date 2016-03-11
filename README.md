# Microcontroller_Laboratory

##Microcontroller Laboratory Spring 2015.

This repository contains all the Micro-controller Lab Assignments. Microco9ntroler used is 8051.

##Microcontroller_Laboratory Directory includes <br />
Experiments.pdf
Hardware_addresses_and_connector_details.pdf <br />
microvision-51-initialization.pdf <br />
/Assignment1 <br />
/Assignment2 <br />
/Assignment3 <br />
/Assignment4 <br />
/Assignment5 <br />
/Assignment6 <br />
/Assignment7 <br />
/Assignment8 <br />
Each Experiment directory includes the experiment source codes(.A51).  <br />

##The list of experiments:
1. Familiarization with 8051 Kit.  <br />
	 __Statement of the experiment:__  Study about the kit components and its interface with the PC. Write the following programs in the assembly language of 8051.  <br />
	1. Find the second largest of an array of 100 numbers stored in external memory from location 9000H onwards. The number be stored at location 9500H. Show the
	   contents of memory locations before and after running the program to establish correctness of it.  <br />
	2. Compute the LCM of two numbers. Assume the numbers to be stored at location 9000H and 9001H. Store the result at 9002H.  <br />
	3. Check whether a NULL-terminated string stored from location 9000H is a palindrome or not. If the string is a palindrome, store 1 at location 9500H, else
	   clear the location.	 <br />

2. Traffic Light Controller.  <br />
	__Statement of the experiment:__ Design a traffic light controller system that has four LEDs – RED, YELLOW, GREEN, ADVANCE GREEN. The sequence in which the LEDs are turned on is as follows:  <br />
	RED for 1 min, YELLOW for 15 seconds, GREEN for 1 min, ADVANCE GREEN for the last 10seconds of GREEN. Interface a light-dependent resistor (LDR) with it. Whenever the LDR is covered, the
	controller goes to manual mode and all lights start blinking. The system returns to its normal condition as Soon as the LDR is uncovered.

	Points to note:  <br />
	* Learn about port programming of 8051.
	* Use 8051 ports to drive the LEDs.
	* If necessary, interface drivers for better glow.
	* Ensure that LEDs are connected via series resistors.
	* Learn about LDR interfacing.
	* You should show the two parts of the experiment separately to the TA and get evaluated.

3. Real-time clock/date display.  <br />
	__Statement of the experiment:__ Design a digital clock display using Common Cathode 7-segment display 	modules and a mode switch. The clock, normally displays the time in hh-mm-ss format.  <br />
	It updates the time automatically using the timer interrupt of the micro-controller. On pressing the mode switch, the display changes to date in dd-mm-yy format. On pressing the button once more,
	the display returns to show time. <br />

	Points to note:  <br />
	* The interfacing of display modules and switch be done through 8255 ports. Learn about 8255 programming.
	* For the kit, look into the manual and find out the port addresses.
	* Make the display circuit as shown in the figure.
	* Identify the patterns to be output to the ports for displaying digits.
	* The time values are to be stored at location 9000H for hour, 9001H for minute and 9002H for second in a 24-hour format. Similarly the date values are to be stored at location
	9003H for day, 9004H for month and 9005H for hour.
	* The program should have an interrupt service routine that updates the time after every 1 second. Time updation may necessitate date updation as well. Learn about installation of ISR properly.
	* Main program, after initialization of ISR, should work in a loop, looking for the pressing of switch. The display mode is selected accordingly. It then displays either the date or the time.

	![alt tag](https://cloud.githubusercontent.com/assets/12825395/13695230/a367617e-e782-11e5-9a26-a6cbfb4b5453.png)

4. Waveform generation using DAC. <br />
	__Statement of the experiment:__ Interface a DAC0808 chip with micro-controller and generate different waveforms, such as, (i) sinusoidal, (ii) triangular, (iii) saw-tooth. Calculate the maximum frequency and
	amplitude that you could achieve in each case. <br />

5. ADC interfacing. <br />
	__Statement of the experiment:__ Design a temperature monitoring and control system. It uses a temperature sensor whose output is fed to the ADC. The ADC sends the digital output to the
	micro-controller. There are two cutoff temperatures – higher(55 0 C) and lower(45 0 C). A heating coil and a fan is interfaced with the micro-controller. The heating coil is turned on. If the temperature is more than
	the higher cutoff, a relay is triggered to turn on a fan working at 12V, the coil is turned off. Again when the temperature comes down to the lower preset value, the fan is turned off and the coil is turned on. <br />
	Points to note: <br />
	* Study the circuit shown in the figure for the interface.
	* Identify the ADC count values corresponding to the two cutoffs. These values are to be used by the program to check the temperature values.
	* You first do the ADC interfacing portion. Show that, varying the input via pot, the count value is changing. You can interface eight LEDs to show the value read from the ADC.

	![alt tag](https://cloud.githubusercontent.com/assets/12825395/13695231/a368415c-e782-11e5-8524-9b203071bb44.png)

6. Stepper motor interfacing. <br />
	__Statement of the experiment:__ Interface a stepper motor with the micro-controller. The system will have two switches. Initially, the motor is at zero speed. With every press of the first switch, the speed will
 	increase by a fixed amount. After eight such presses, it returns to zero speed. The other switch will toggle the direction of rotation of the motor. <br />

7. Serial communication between kits <br />
	__Statement of the experiment:__ Interface two kits using UART interface of 8051.Experiment: LCD display interfacing <br />

8. LCD display interfacing <br />
    __Statement of the experiment:__ Interface an LCD display with the micro-controller through 8255 port (J3). Display your name and Roll no. in the 1 st line and Hall address in the 2 nd line. Make it a scrolling display. <br />

##Setup
download the directory <br />
copy the ".A51" code to your project.
