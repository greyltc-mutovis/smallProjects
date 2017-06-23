EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:pspice
LIBS:pulse-to-dc-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 0 #GND01
U 1 1 5947CF07
P 9750 6150
F 0 "#GND01" H 9750 6050 50  0001 C CNN
F 1 "0" H 9750 6237 50  0000 C CNN
F 2 "" H 9750 6150 50  0001 C CNN
F 3 "" H 9750 6150 50  0001 C CNN
	1    9750 6150
	1    0    0    -1  
$EndComp
$Comp
L CAP C2
U 1 1 5947CFF0
P 3700 2150
F 0 "C2" H 3878 2196 50  0000 L CNN
F 1 "40p" H 3878 2105 50  0000 L CNN
F 2 "" H 3700 2150 50  0001 C CNN
F 3 "" H 3700 2150 50  0001 C CNN
	1    3700 2150
	0    1    -1   0   
$EndComp
$Comp
L R R2
U 1 1 5947D0C6
P 3700 1150
F 0 "R2" H 3770 1196 50  0000 L CNN
F 1 "1G" H 3770 1105 50  0000 L CNN
F 2 "" V 3630 1150 50  0001 C CNN
F 3 "" H 3700 1150 50  0001 C CNN
	1    3700 1150
	0    1    -1   0   
$EndComp
$Comp
L DIODE D1
U 1 1 5947D178
P 3750 4100
F 0 "D1" V 3796 3972 50  0000 R CNN
F 1 "DIODE" V 3705 3972 50  0000 R CNN
F 2 "" H 3750 4100 50  0001 C CNN
F 3 "" H 3750 4100 50  0001 C CNN
F 4 "D" H 3750 4100 60  0001 C CNN "Spice_Primitive"
F 5 "DIODE" H 3750 4100 60  0001 C CNN "Spice_Model"
F 6 "Y" H 3750 4100 60  0001 C CNN "Spice_Netlist_Enabled"
	1    3750 4100
	-1   0    0    1   
$EndComp
$Comp
L ISOURCE I2
U 1 1 5947D206
P 3800 5150
F 0 "I2" H 3372 5104 50  0000 R CNN
F 1 "ISOURCE" H 3372 5195 50  0000 R CNN
F 2 "" H 3800 5150 50  0001 C CNN
F 3 "" H 3800 5150 50  0001 C CNN
F 4 "I" H 3800 5150 60  0001 C CNN "Spice_Primitive"
F 5 "dc 0 pulse(0 1.25m 0 0 0 1.5n 50u)" H 3800 5150 60  0001 C CNN "Spice_Model"
F 6 "Y" H 3800 5150 60  0001 C CNN "Spice_Netlist_Enabled"
	1    3800 5150
	0    -1   1    0   
$EndComp
$Comp
L ISOURCE I1
U 1 1 5947D2A3
P 3800 3300
F 0 "I1" H 3372 3254 50  0000 R CNN
F 1 "1n" H 3372 3345 50  0000 R CNN
F 2 "" H 3800 3300 50  0001 C CNN
F 3 "" H 3800 3300 50  0001 C CNN
F 4 "I" H 3800 3300 60  0001 C CNN "Spice_Primitive"
F 5 "dc 1n" H 3800 3300 60  0001 C CNN "Spice_Model"
F 6 "Y" H 3800 3300 60  0001 C CNN "Spice_Netlist_Enabled"
	1    3800 3300
	0    -1   1    0   
$EndComp
$Comp
L R R3
U 1 1 5947D61F
P 5200 3300
F 0 "R3" V 4993 3300 50  0000 C CNN
F 1 "0.1" V 5084 3300 50  0000 C CNN
F 2 "" V 5130 3300 50  0001 C CNN
F 3 "" H 5200 3300 50  0001 C CNN
	1    5200 3300
	0    -1   1    0   
$EndComp
Text GLabel 10200 3300 2    60   Input ~ 0
Vout
Text Notes 5350 3560 2    60   ~ 0
R_series
Text Notes 3500 1360 0    60   ~ 0
R_shunt
Text Notes 3500 3660 0    60   ~ 0
Dark Current
Text Notes 3200 2460 0    60   ~ 0
Junction Capacitance
Text Notes 4000 5510 2    60   ~ 0
Photocurrent
Text Notes 2850 3050 2    60   ~ 0
Internal RC Filter\nFor Bias Voltage Source
Text Notes 10100 3050 2    60   ~ 0
Lockin AUX In
Text Notes 8150 2900 2    60   ~ 0
Our Filter
Text Notes 7600 1550 0    60   ~ 0
.tran 1u 1\n*.tran 2n 100m\n.model DIODE D\n.control\nrun\nwrite rawspice.raw\n*wrdata Vout.ascii Vout\n.endc
Text Notes 7600 700  0    60   ~ 0
to be appended onto ngspice netlist:
Text Notes 7600 2150 0    60   ~ 0
now the netlist can be simulated in ngspice batch mode with\nngspice -b ${NETLIST_FILE_NAME}.cir\ncreating rawspice.raw which can be inspected with:\nngnutmeg rawspice.raw\nthen plot Vout by issuing\nplot Vout
Text Notes 9950 4400 1    60   ~ 0
Input Impedance
Text Notes 2400 900  0    60   ~ 0
THORLABS DET36A
$Comp
L VSOURCE V1
U 1 1 594A7F58
P 1250 5000
F 0 "V1" H 1678 5046 50  0000 L CNN
F 1 "VSOURCE" H 1678 4955 50  0000 L CNN
F 2 "" H 1250 5000 50  0001 C CNN
F 3 "" H 1250 5000 50  0001 C CNN
F 4 "V" H 1250 5000 60  0001 C CNN "Spice_Primitive"
F 5 "dc 10" H 1250 5000 60  0001 C CNN "Spice_Model"
F 6 "Y" H 1250 5000 60  0001 C CNN "Spice_Netlist_Enabled"
	1    1250 5000
	1    0    0    -1  
$EndComp
$Comp
L CAP C1
U 1 1 594A8508
P 2450 4450
F 0 "C1" H 2628 4496 50  0000 L CNN
F 1 "0.1u" H 2628 4405 50  0000 L CNN
F 2 "" H 2450 4450 50  0001 C CNN
F 3 "" H 2450 4450 50  0001 C CNN
	1    2450 4450
	1    0    0    1   
$EndComp
$Comp
L R R1
U 1 1 594A8581
P 2100 3300
F 0 "R1" H 2170 3346 50  0000 L CNN
F 1 "1k" H 2170 3255 50  0000 L CNN
F 2 "" V 2030 3300 50  0001 C CNN
F 3 "" H 2100 3300 50  0001 C CNN
	1    2100 3300
	0    1    -1   0   
$EndComp
Text Notes 750  4400 3    60   ~ 0
10V Bias Voltage Source
$Comp
L R R5
U 1 1 594A9D92
P 9750 3950
F 0 "R5" H 9680 3904 50  0000 R CNN
F 1 "1MEG" H 9680 3995 50  0000 R CNN
F 2 "" V 9680 3950 50  0001 C CNN
F 3 "" H 9750 3950 50  0001 C CNN
	1    9750 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 5150 4500 5150
Wire Wire Line
	4600 2150 3950 2150
Connection ~ 4600 3300
Wire Wire Line
	4600 4100 3950 4100
Connection ~ 4600 4100
Wire Wire Line
	2900 5150 3100 5150
Wire Wire Line
	2900 2150 3450 2150
Connection ~ 2900 3300
Wire Wire Line
	2900 4100 3550 4100
Connection ~ 2900 4100
Wire Wire Line
	4600 1150 3850 1150
Connection ~ 4600 2150
Connection ~ 2900 2150
Connection ~ 4600 1150
Connection ~ 2900 1150
Wire Wire Line
	9750 4100 9750 6150
Wire Wire Line
	9750 3300 9750 3800
Connection ~ 9750 3300
Wire Notes Line
	9450 3100 10500 3100
Wire Notes Line
	10500 3100 10500 5100
Wire Notes Line
	10500 5100 9450 5100
Wire Notes Line
	9450 5100 9450 3100
Wire Wire Line
	8300 3300 8300 3750
Connection ~ 8300 3300
Wire Wire Line
	8300 5850 8300 4250
Wire Notes Line
	7700 2950 7700 5200
Wire Notes Line
	7700 5200 8750 5200
Wire Notes Line
	8750 5200 8750 2950
Wire Notes Line
	8750 2950 7700 2950
Wire Notes Line
	7550 750  11000 750 
Wire Notes Line
	11000 750  11000 1550
Wire Notes Line
	11000 1550 7550 1550
Wire Notes Line
	7550 1550 7550 750 
Wire Wire Line
	2900 1150 2900 5150
Wire Wire Line
	4600 1150 4600 5150
Wire Wire Line
	2900 1150 3550 1150
Wire Notes Line
	5500 950  5500 6500
Connection ~ 8300 5850
Wire Wire Line
	4500 3300 5050 3300
Wire Notes Line
	5500 950  500  950 
Wire Notes Line
	500  950  500  6500
Wire Notes Line
	500  6500 5500 6500
Wire Wire Line
	2450 4200 2450 3300
Connection ~ 2450 3300
Wire Wire Line
	2450 4700 2450 5850
Connection ~ 2450 5850
Wire Wire Line
	2250 3300 3100 3300
Wire Notes Line
	1950 3100 1950 4700
Wire Notes Line
	1950 4700 2850 4700
Wire Notes Line
	2850 4700 2850 3100
Wire Notes Line
	2850 3100 1950 3100
Wire Wire Line
	1950 3300 1250 3300
Wire Wire Line
	1250 3300 1250 4300
Wire Wire Line
	1250 5700 1250 5850
Wire Wire Line
	1250 5850 9750 5850
Connection ~ 9750 5850
$Comp
L CAP C3
U 1 1 594C0352
P 8300 4000
F 0 "C3" H 8478 4046 50  0000 L CNN
F 1 "1u" H 8478 3955 50  0000 L CNN
F 2 "" H 8300 4000 50  0001 C CNN
F 3 "" H 8300 4000 50  0001 C CNN
	1    8300 4000
	1    0    0    1   
$EndComp
$Comp
L R R4
U 1 1 594C03EC
P 8000 3300
F 0 "R4" H 8070 3346 50  0000 L CNN
F 1 "1k" H 8070 3255 50  0000 L CNN
F 2 "" V 7930 3300 50  0001 C CNN
F 3 "" H 8000 3300 50  0001 C CNN
	1    8000 3300
	0    1    -1   0   
$EndComp
Wire Wire Line
	5350 3300 7850 3300
Wire Wire Line
	8150 3300 10200 3300
Connection ~ 5500 5850
Connection ~ 5500 3300
$EndSCHEMATC
