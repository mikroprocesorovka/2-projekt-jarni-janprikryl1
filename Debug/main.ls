   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
  55                     ; 10 void assert_failed(u8* file, u32 line)
  55                     ; 11 { 
  57                     	switch	.text
  58  0000               _assert_failed:
  62  0000               L72:
  63  0000 20fe          	jra	L72
 117                     ; 51 char putchar (char c)
 117                     ; 52 {
 118                     	switch	.text
 119  0002               _putchar:
 121  0002 88            	push	a
 122       00000000      OFST:	set	0
 125                     ; 54   UART1_SendData8(c);
 127  0003 cd0000        	call	_UART1_SendData8
 130  0006               L56:
 131                     ; 56   while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 133  0006 ae0080        	ldw	x,#128
 134  0009 cd0000        	call	_UART1_GetFlagStatus
 136  000c 4d            	tnz	a
 137  000d 27f7          	jreq	L56
 138                     ; 58   return (c);
 140  000f 7b01          	ld	a,(OFST+1,sp)
 143  0011 5b01          	addw	sp,#1
 144  0013 81            	ret
 180                     ; 61 char getchar (void) //funkce cte(prijï¿½mï¿½ data) vstup z UART
 180                     ; 62 {
 181                     	switch	.text
 182  0014               _getchar:
 184  0014 89            	pushw	x
 185       00000002      OFST:	set	2
 188                     ; 63   int c = 0;
 191  0015               L111:
 192                     ; 65   while (UART1_GetFlagStatus(UART1_FLAG_RXNE) == RESET);
 194  0015 ae0020        	ldw	x,#32
 195  0018 cd0000        	call	_UART1_GetFlagStatus
 197  001b 4d            	tnz	a
 198  001c 27f7          	jreq	L111
 199                     ; 66 	c = UART1_ReceiveData8();
 201  001e cd0000        	call	_UART1_ReceiveData8
 203  0021 5f            	clrw	x
 204  0022 97            	ld	xl,a
 205  0023 1f01          	ldw	(OFST-1,sp),x
 207                     ; 67   return (c);
 209  0025 7b02          	ld	a,(OFST+0,sp)
 212  0027 85            	popw	x
 213  0028 81            	ret
 238                     ; 72 void init_uart1(void)
 238                     ; 73 {
 239                     	switch	.text
 240  0029               _init_uart1:
 244                     ; 74     UART1_DeInit();         // smazat starou konfiguraci
 246  0029 cd0000        	call	_UART1_DeInit
 248                     ; 75 		UART1_Init((uint32_t)115200, //Nova konfigurace
 248                     ; 76 									UART1_WORDLENGTH_8D, 
 248                     ; 77 									UART1_STOPBITS_1, 
 248                     ; 78 									UART1_PARITY_NO,
 248                     ; 79 									UART1_SYNCMODE_CLOCK_DISABLE, 
 248                     ; 80 									UART1_MODE_TXRX_ENABLE);
 250  002c 4b0c          	push	#12
 251  002e 4b80          	push	#128
 252  0030 4b00          	push	#0
 253  0032 4b00          	push	#0
 254  0034 4b00          	push	#0
 255  0036 aec200        	ldw	x,#49664
 256  0039 89            	pushw	x
 257  003a ae0001        	ldw	x,#1
 258  003d 89            	pushw	x
 259  003e cd0000        	call	_UART1_Init
 261  0041 5b09          	addw	sp,#9
 262                     ; 81 }
 265  0043 81            	ret
 319                     ; 83 void max7219(uint8_t address, uint8_t data)
 319                     ; 84 {
 320                     	switch	.text
 321  0044               _max7219:
 323  0044 89            	pushw	x
 324  0045 89            	pushw	x
 325       00000002      OFST:	set	2
 328                     ; 86 		CLR(CS);
 330  0046 4b08          	push	#8
 331  0048 ae501e        	ldw	x,#20510
 332  004b cd0000        	call	_GPIO_WriteLow
 334  004e 84            	pop	a
 335                     ; 90 		mask = 1<<7;
 337  004f ae0080        	ldw	x,#128
 338  0052 1f01          	ldw	(OFST-1,sp),x
 340  0054               L351:
 341                     ; 92 		 CLR(CLK);
 343  0054 4b04          	push	#4
 344  0056 ae501e        	ldw	x,#20510
 345  0059 cd0000        	call	_GPIO_WriteLow
 347  005c 84            	pop	a
 348                     ; 93 		 if(address & mask){
 350  005d 7b03          	ld	a,(OFST+1,sp)
 351  005f 5f            	clrw	x
 352  0060 97            	ld	xl,a
 353  0061 01            	rrwa	x,a
 354  0062 1402          	and	a,(OFST+0,sp)
 355  0064 01            	rrwa	x,a
 356  0065 1401          	and	a,(OFST-1,sp)
 357  0067 01            	rrwa	x,a
 358  0068 a30000        	cpw	x,#0
 359  006b 270b          	jreq	L161
 360                     ; 94 					 SET(DIN);
 362  006d 4b08          	push	#8
 363  006f ae5014        	ldw	x,#20500
 364  0072 cd0000        	call	_GPIO_WriteHigh
 366  0075 84            	pop	a
 368  0076 2009          	jra	L361
 369  0078               L161:
 370                     ; 96 					 CLR(DIN);
 372  0078 4b08          	push	#8
 373  007a ae5014        	ldw	x,#20500
 374  007d cd0000        	call	_GPIO_WriteLow
 376  0080 84            	pop	a
 377  0081               L361:
 378                     ; 98 				SET(CLK);
 380  0081 4b04          	push	#4
 381  0083 ae501e        	ldw	x,#20510
 382  0086 cd0000        	call	_GPIO_WriteHigh
 384  0089 84            	pop	a
 385                     ; 99 				mask >>=1;
 387  008a 0401          	srl	(OFST-1,sp)
 388  008c 0602          	rrc	(OFST+0,sp)
 390                     ; 100 				CLR(CLK);
 392  008e 4b04          	push	#4
 393  0090 ae501e        	ldw	x,#20510
 394  0093 cd0000        	call	_GPIO_WriteLow
 396  0096 84            	pop	a
 397                     ; 91 		while(mask){
 399  0097 1e01          	ldw	x,(OFST-1,sp)
 400  0099 26b9          	jrne	L351
 401                     ; 105 		mask = 1<<7;
 403  009b ae0080        	ldw	x,#128
 404  009e 1f01          	ldw	(OFST-1,sp),x
 406  00a0               L561:
 407                     ; 107 		 CLR(CLK);
 409  00a0 4b04          	push	#4
 410  00a2 ae501e        	ldw	x,#20510
 411  00a5 cd0000        	call	_GPIO_WriteLow
 413  00a8 84            	pop	a
 414                     ; 108 		 if(data & mask){
 416  00a9 7b04          	ld	a,(OFST+2,sp)
 417  00ab 5f            	clrw	x
 418  00ac 97            	ld	xl,a
 419  00ad 01            	rrwa	x,a
 420  00ae 1402          	and	a,(OFST+0,sp)
 421  00b0 01            	rrwa	x,a
 422  00b1 1401          	and	a,(OFST-1,sp)
 423  00b3 01            	rrwa	x,a
 424  00b4 a30000        	cpw	x,#0
 425  00b7 270b          	jreq	L371
 426                     ; 109 					 SET(DIN);
 428  00b9 4b08          	push	#8
 429  00bb ae5014        	ldw	x,#20500
 430  00be cd0000        	call	_GPIO_WriteHigh
 432  00c1 84            	pop	a
 434  00c2 2009          	jra	L571
 435  00c4               L371:
 436                     ; 111 					 CLR(DIN);
 438  00c4 4b08          	push	#8
 439  00c6 ae5014        	ldw	x,#20500
 440  00c9 cd0000        	call	_GPIO_WriteLow
 442  00cc 84            	pop	a
 443  00cd               L571:
 444                     ; 113 				SET(CLK);
 446  00cd 4b04          	push	#4
 447  00cf ae501e        	ldw	x,#20510
 448  00d2 cd0000        	call	_GPIO_WriteHigh
 450  00d5 84            	pop	a
 451                     ; 114 				mask >>=1;
 453  00d6 0401          	srl	(OFST-1,sp)
 454  00d8 0602          	rrc	(OFST+0,sp)
 456                     ; 115 				CLR(CLK);
 458  00da 4b04          	push	#4
 459  00dc ae501e        	ldw	x,#20510
 460  00df cd0000        	call	_GPIO_WriteLow
 462  00e2 84            	pop	a
 463                     ; 106 		while(mask){
 465  00e3 1e01          	ldw	x,(OFST-1,sp)
 466  00e5 26b9          	jrne	L561
 467                     ; 118 			SET(CS);
 469  00e7 4b08          	push	#8
 470  00e9 ae501e        	ldw	x,#20510
 471  00ec cd0000        	call	_GPIO_WriteHigh
 473  00ef 84            	pop	a
 474                     ; 119 }
 477  00f0 5b04          	addw	sp,#4
 478  00f2 81            	ret
 502                     ; 122 void nic(void) { //Vypsání prázdných míst
 503                     	switch	.text
 504  00f3               _nic:
 508                     ; 123 	max7219(1, 15);
 510  00f3 ae010f        	ldw	x,#271
 511  00f6 cd0044        	call	_max7219
 513                     ; 124 	max7219(2, 15);
 515  00f9 ae020f        	ldw	x,#527
 516  00fc cd0044        	call	_max7219
 518                     ; 125 	max7219(3, 15);
 520  00ff ae030f        	ldw	x,#783
 521  0102 cd0044        	call	_max7219
 523                     ; 126 	max7219(4, 15);
 525  0105 ae040f        	ldw	x,#1039
 526  0108 cd0044        	call	_max7219
 528                     ; 127 	max7219(5, 15);
 530  010b ae050f        	ldw	x,#1295
 531  010e cd0044        	call	_max7219
 533                     ; 128 	max7219(6, 15);
 535  0111 ae060f        	ldw	x,#1551
 536  0114 cd0044        	call	_max7219
 538                     ; 129 	max7219(7, 15);
 540  0117 ae070f        	ldw	x,#1807
 541  011a cd0044        	call	_max7219
 543                     ; 130 	max7219(8, 15);
 545  011d ae080f        	ldw	x,#2063
 546  0120 cd0044        	call	_max7219
 548                     ; 131 }
 551  0123 81            	ret
 581                     ; 133 void setup(void)
 581                     ; 134 {
 582                     	switch	.text
 583  0124               _setup:
 587                     ; 135     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);      // taktovat MCU na 16MHz
 589  0124 4f            	clr	a
 590  0125 cd0000        	call	_CLK_HSIPrescalerConfig
 592                     ; 137     init_milis(); //Initializace milis
 594  0128 cd0000        	call	_init_milis
 596                     ; 138     init_uart1(); //Povoleni komunikace s PC
 598  012b cd0029        	call	_init_uart1
 600                     ; 139 		init_keypad(); //Initializace klávesnice
 602  012e cd0000        	call	_init_keypad
 604                     ; 142 		GPIO_Init(CLK_PORT, CLK_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
 606  0131 4bc0          	push	#192
 607  0133 4b04          	push	#4
 608  0135 ae501e        	ldw	x,#20510
 609  0138 cd0000        	call	_GPIO_Init
 611  013b 85            	popw	x
 612                     ; 143 		GPIO_Init(CS_PORT, CS_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
 614  013c 4bc0          	push	#192
 615  013e 4b08          	push	#8
 616  0140 ae501e        	ldw	x,#20510
 617  0143 cd0000        	call	_GPIO_Init
 619  0146 85            	popw	x
 620                     ; 144 		GPIO_Init(DIN_PORT, DIN_PIN, GPIO_MODE_OUT_PP_LOW_SLOW);
 622  0147 4bc0          	push	#192
 623  0149 4b08          	push	#8
 624  014b ae5014        	ldw	x,#20500
 625  014e cd0000        	call	_GPIO_Init
 627  0151 85            	popw	x
 628                     ; 145 		max7219(DECODE_MODE, DECODE_ALL); // zapnout znakovou sadu na v?ech cifr?ch
 630  0152 ae09ff        	ldw	x,#2559
 631  0155 cd0044        	call	_max7219
 633                     ; 146 		max7219(SCAN_LIMIT, 7); // velikost displeje 8 cifer (poc?t?no od nuly, proto je argument c?slo 7)
 635  0158 ae0b07        	ldw	x,#2823
 636  015b cd0044        	call	_max7219
 638                     ; 147 		max7219(INTENSITY, 3); // vol?me ze zac?tku n?zk? jas (vysok? jas mu?e m?t velkou spotrebu - a? 0.25A !)
 640  015e ae0a03        	ldw	x,#2563
 641  0161 cd0044        	call	_max7219
 643                     ; 148 		max7219(DISPLAY_TEST, DISPLAY_TEST_OFF); // Funkci "test" nechceme m?t zapnutou
 645  0164 ae0f00        	ldw	x,#3840
 646  0167 cd0044        	call	_max7219
 648                     ; 149 		max7219(SHUTDOWN, DISPLAY_ON); // zapneme displej
 650  016a ae0c01        	ldw	x,#3073
 651  016d cd0044        	call	_max7219
 653                     ; 150 		nic();
 655  0170 ad81          	call	_nic
 657                     ; 151 }
 660  0172 81            	ret
 738                     .const:	section	.text
 739  0000               L42:
 740  0000 00000038      	dc.l	56
 741                     ; 154 int main(void)
 741                     ; 155 {
 742                     	switch	.text
 743  0173               _main:
 745  0173 5209          	subw	sp,#9
 746       00000009      OFST:	set	9
 749                     ; 156     uint8_t key_now = 0xFF;
 751                     ; 157     uint8_t key_last = 0xFF;
 753  0175 a6ff          	ld	a,#255
 754  0177 6b03          	ld	(OFST-6,sp),a
 756                     ; 158     uint32_t mtime_key = 0;
 758  0179 ae0000        	ldw	x,#0
 759  017c 1f06          	ldw	(OFST-3,sp),x
 760  017e ae0000        	ldw	x,#0
 761  0181 1f04          	ldw	(OFST-5,sp),x
 763                     ; 160 		uint8_t pozice = 8;
 765  0183 a608          	ld	a,#8
 766  0185 6b09          	ld	(OFST+0,sp),a
 768                     ; 162     setup();
 770  0187 ad9b          	call	_setup
 772                     ; 163     printf("Dobry den,\n\r");
 774  0189 ae00f6        	ldw	x,#L552
 775  018c cd0000        	call	_printf
 777                     ; 164 		printf("vitejte v programu poznamkovy blok.\n\r");
 779  018f ae00d0        	ldw	x,#L752
 780  0192 cd0000        	call	_printf
 782                     ; 165 		printf("Tlacitky klavesnice muzete vypisovat postupne na jednotlive segmenty cisla.\n\r");
 784  0195 ae0082        	ldw	x,#L162
 785  0198 cd0000        	call	_printf
 787                     ; 166 		printf("Tlacitkem * napisete prazdne misto, tlacitkem # napisete vsude prazdna mista a kurzor posunete na zacatek.\r\n");
 789  019b ae0015        	ldw	x,#L362
 790  019e cd0000        	call	_printf
 792  01a1               L562:
 793                     ; 169         if (milis() - mtime_key > 55) {// detekce stisknuté klávesy
 795  01a1 cd0000        	call	_milis
 797  01a4 cd0000        	call	c_uitolx
 799  01a7 96            	ldw	x,sp
 800  01a8 1c0004        	addw	x,#OFST-5
 801  01ab cd0000        	call	c_lsub
 803  01ae ae0000        	ldw	x,#L42
 804  01b1 cd0000        	call	c_lcmp
 806  01b4 25eb          	jrult	L562
 807                     ; 170            mtime_key = milis();
 809  01b6 cd0000        	call	_milis
 811  01b9 cd0000        	call	c_uitolx
 813  01bc 96            	ldw	x,sp
 814  01bd 1c0004        	addw	x,#OFST-5
 815  01c0 cd0000        	call	c_rtol
 818                     ; 171            key_now = check_keypad();
 820  01c3 cd0000        	call	_check_keypad
 822  01c6 6b08          	ld	(OFST-1,sp),a
 824                     ; 172            if (key_last == 0xFF && key_now != 0xFF) {
 826  01c8 7b03          	ld	a,(OFST-6,sp)
 827  01ca a1ff          	cp	a,#255
 828  01cc 2653          	jrne	L372
 830  01ce 7b08          	ld	a,(OFST-1,sp)
 831  01d0 a1ff          	cp	a,#255
 832  01d2 274d          	jreq	L372
 833                     ; 174 								sprintf(x, "%x", key_now);
 835  01d4 7b08          	ld	a,(OFST-1,sp)
 836  01d6 88            	push	a
 837  01d7 ae0012        	ldw	x,#L572
 838  01da 89            	pushw	x
 839  01db 96            	ldw	x,sp
 840  01dc 1c0004        	addw	x,#OFST-5
 841  01df cd0000        	call	_sprintf
 843  01e2 5b03          	addw	sp,#3
 844                     ; 175 								printf("Klavesa: %c\n\r", x[0]);
 846  01e4 7b01          	ld	a,(OFST-8,sp)
 847  01e6 88            	push	a
 848  01e7 ae0004        	ldw	x,#L772
 849  01ea cd0000        	call	_printf
 851  01ed 84            	pop	a
 852                     ; 176 								if (x[0] == 'a') {
 854  01ee 7b01          	ld	a,(OFST-8,sp)
 855  01f0 a161          	cp	a,#97
 856  01f2 260b          	jrne	L103
 857                     ; 177 										max7219(pozice, 15);
 859  01f4 7b09          	ld	a,(OFST+0,sp)
 860  01f6 ae000f        	ldw	x,#15
 861  01f9 95            	ld	xh,a
 862  01fa cd0044        	call	_max7219
 865  01fd 2018          	jra	L303
 866  01ff               L103:
 867                     ; 179 								else if (x[0] == 'b') {
 869  01ff 7b01          	ld	a,(OFST-8,sp)
 870  0201 a162          	cp	a,#98
 871  0203 2609          	jrne	L503
 872                     ; 180 									nic();
 874  0205 cd00f3        	call	_nic
 876                     ; 181 									pozice = 9;
 878  0208 a609          	ld	a,#9
 879  020a 6b09          	ld	(OFST+0,sp),a
 882  020c 2009          	jra	L303
 883  020e               L503:
 884                     ; 184 									max7219(pozice, x[0]);
 886  020e 7b01          	ld	a,(OFST-8,sp)
 887  0210 97            	ld	xl,a
 888  0211 7b09          	ld	a,(OFST+0,sp)
 889  0213 95            	ld	xh,a
 890  0214 cd0044        	call	_max7219
 892  0217               L303:
 893                     ; 186 								pozice = pozice - 1;
 895  0217 0a09          	dec	(OFST+0,sp)
 897                     ; 187 								if(pozice == 0) {
 899  0219 0d09          	tnz	(OFST+0,sp)
 900  021b 2604          	jrne	L372
 901                     ; 188 									pozice = 8;
 903  021d a608          	ld	a,#8
 904  021f 6b09          	ld	(OFST+0,sp),a
 906  0221               L372:
 907                     ; 191             key_last = key_now;
 909  0221 7b08          	ld	a,(OFST-1,sp)
 910  0223 6b03          	ld	(OFST-6,sp),a
 912  0225 aca101a1      	jpf	L562
 925                     	xdef	_main
 926                     	xdef	_setup
 927                     	xdef	_nic
 928                     	xdef	_max7219
 929                     	xdef	_init_uart1
 930                     	xref	_check_keypad
 931                     	xref	_init_keypad
 932                     	xref	_init_milis
 933                     	xref	_milis
 934                     	xref	_sprintf
 935                     	xdef	_putchar
 936                     	xref	_printf
 937                     	xdef	_getchar
 938                     	xdef	_assert_failed
 939                     	xref	_UART1_GetFlagStatus
 940                     	xref	_UART1_SendData8
 941                     	xref	_UART1_ReceiveData8
 942                     	xref	_UART1_Init
 943                     	xref	_UART1_DeInit
 944                     	xref	_GPIO_WriteLow
 945                     	xref	_GPIO_WriteHigh
 946                     	xref	_GPIO_Init
 947                     	xref	_CLK_HSIPrescalerConfig
 948                     	switch	.const
 949  0004               L772:
 950  0004 4b6c61766573  	dc.b	"Klavesa: %c",10
 951  0010 0d00          	dc.b	13,0
 952  0012               L572:
 953  0012 257800        	dc.b	"%x",0
 954  0015               L362:
 955  0015 546c61636974  	dc.b	"Tlacitkem * napise"
 956  0027 746520707261  	dc.b	"te prazdne misto, "
 957  0039 746c61636974  	dc.b	"tlacitkem # napise"
 958  004b 746520767375  	dc.b	"te vsude prazdna m"
 959  005d 697374612061  	dc.b	"ista a kurzor posu"
 960  006f 6e657465206e  	dc.b	"nete na zacatek.",13
 961  0080 0a00          	dc.b	10,0
 962  0082               L162:
 963  0082 546c61636974  	dc.b	"Tlacitky klavesnic"
 964  0094 65206d757a65  	dc.b	"e muzete vypisovat"
 965  00a6 20706f737475  	dc.b	" postupne na jedno"
 966  00b8 746c69766520  	dc.b	"tlive segmenty cis"
 967  00ca 6c612e0a      	dc.b	"la.",10
 968  00ce 0d00          	dc.b	13,0
 969  00d0               L752:
 970  00d0 766974656a74  	dc.b	"vitejte v programu"
 971  00e2 20706f7a6e61  	dc.b	" poznamkovy blok.",10
 972  00f4 0d00          	dc.b	13,0
 973  00f6               L552:
 974  00f6 446f62727920  	dc.b	"Dobry den,",10
 975  0101 0d00          	dc.b	13,0
 995                     	xref	c_rtol
 996                     	xref	c_lcmp
 997                     	xref	c_lsub
 998                     	xref	c_uitolx
 999                     	end
