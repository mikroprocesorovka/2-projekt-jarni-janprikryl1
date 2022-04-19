   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.12.6 - 16 Dec 2021
   3                     ; Generator (Limited) V4.5.4 - 16 Dec 2021
  44                     ; 12 void init_keypad(void)
  44                     ; 13 {
  46                     	switch	.text
  47  0000               _init_keypad:
  51                     ; 15     GPIO_Init(R1_PORT, R1_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
  53  0000 4b90          	push	#144
  54  0002 4b02          	push	#2
  55  0004 ae500a        	ldw	x,#20490
  56  0007 cd0000        	call	_GPIO_Init
  58  000a 85            	popw	x
  59                     ; 16     GPIO_Init(R2_PORT, R2_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
  61  000b 4b90          	push	#144
  62  000d 4b01          	push	#1
  63  000f ae5014        	ldw	x,#20500
  64  0012 cd0000        	call	_GPIO_Init
  66  0015 85            	popw	x
  67                     ; 17     GPIO_Init(R3_PORT, R3_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
  69  0016 4b90          	push	#144
  70  0018 4b20          	push	#32
  71  001a ae500f        	ldw	x,#20495
  72  001d cd0000        	call	_GPIO_Init
  74  0020 85            	popw	x
  75                     ; 18     GPIO_Init(R4_PORT, R4_PIN, GPIO_MODE_OUT_OD_HIZ_SLOW);
  77  0021 4b90          	push	#144
  78  0023 4b40          	push	#64
  79  0025 ae500f        	ldw	x,#20495
  80  0028 cd0000        	call	_GPIO_Init
  82  002b 85            	popw	x
  83                     ; 20     GPIO_Init(C1_PORT, C1_PIN, GPIO_MODE_IN_PU_NO_IT);
  85  002c 4b40          	push	#64
  86  002e 4b01          	push	#1
  87  0030 ae501e        	ldw	x,#20510
  88  0033 cd0000        	call	_GPIO_Init
  90  0036 85            	popw	x
  91                     ; 21     GPIO_Init(C2_PORT, C2_PIN, GPIO_MODE_IN_PU_NO_IT);
  93  0037 4b40          	push	#64
  94  0039 4b04          	push	#4
  95  003b ae500a        	ldw	x,#20490
  96  003e cd0000        	call	_GPIO_Init
  98  0041 85            	popw	x
  99                     ; 22     GPIO_Init(C3_PORT, C3_PIN, GPIO_MODE_IN_PU_NO_IT);
 101  0042 4b40          	push	#64
 102  0044 4b08          	push	#8
 103  0046 ae500a        	ldw	x,#20490
 104  0049 cd0000        	call	_GPIO_Init
 106  004c 85            	popw	x
 107                     ; 24 }
 110  004d 81            	ret
 147                     ; 26 uint8_t check_keypad(void)
 147                     ; 27 {
 148                     	switch	.text
 149  004e               _check_keypad:
 151  004e 88            	push	a
 152       00000001      OFST:	set	1
 155                     ; 28     uint8_t bagr = 0xFF;
 157  004f a6ff          	ld	a,#255
 158  0051 6b01          	ld	(OFST+0,sp),a
 160                     ; 31     ROW_ON(R1);
 162  0053 4b02          	push	#2
 163  0055 ae500a        	ldw	x,#20490
 164  0058 cd0000        	call	_GPIO_WriteLow
 166  005b 84            	pop	a
 167                     ; 32     if (COLUMN_GET(C1)) {
 170  005c 4b01          	push	#1
 171  005e ae501e        	ldw	x,#20510
 172  0061 cd0000        	call	_GPIO_ReadInputPin
 174  0064 5b01          	addw	sp,#1
 175  0066 4d            	tnz	a
 176  0067 2604          	jrne	L73
 177                     ; 33         bagr = 0x1;
 179  0069 a601          	ld	a,#1
 180  006b 6b01          	ld	(OFST+0,sp),a
 182  006d               L73:
 183                     ; 35     if (COLUMN_GET(C2)) {
 185  006d 4b04          	push	#4
 186  006f ae500a        	ldw	x,#20490
 187  0072 cd0000        	call	_GPIO_ReadInputPin
 189  0075 5b01          	addw	sp,#1
 190  0077 4d            	tnz	a
 191  0078 2604          	jrne	L14
 192                     ; 36         bagr = 0x2;
 194  007a a602          	ld	a,#2
 195  007c 6b01          	ld	(OFST+0,sp),a
 197  007e               L14:
 198                     ; 38     if (COLUMN_GET(C3)) {
 200  007e 4b08          	push	#8
 201  0080 ae500a        	ldw	x,#20490
 202  0083 cd0000        	call	_GPIO_ReadInputPin
 204  0086 5b01          	addw	sp,#1
 205  0088 4d            	tnz	a
 206  0089 2604          	jrne	L34
 207                     ; 39         bagr = 0x3;
 209  008b a603          	ld	a,#3
 210  008d 6b01          	ld	(OFST+0,sp),a
 212  008f               L34:
 213                     ; 44     ROW_OFF(R1);
 215  008f 4b02          	push	#2
 216  0091 ae500a        	ldw	x,#20490
 217  0094 cd0000        	call	_GPIO_WriteHigh
 219  0097 84            	pop	a
 220                     ; 47     ROW_ON(R2);
 223  0098 4b01          	push	#1
 224  009a ae5014        	ldw	x,#20500
 225  009d cd0000        	call	_GPIO_WriteLow
 227  00a0 84            	pop	a
 228                     ; 48     if (COLUMN_GET(C1)) {
 231  00a1 4b01          	push	#1
 232  00a3 ae501e        	ldw	x,#20510
 233  00a6 cd0000        	call	_GPIO_ReadInputPin
 235  00a9 5b01          	addw	sp,#1
 236  00ab 4d            	tnz	a
 237  00ac 2604          	jrne	L54
 238                     ; 49         bagr = 0x4;
 240  00ae a604          	ld	a,#4
 241  00b0 6b01          	ld	(OFST+0,sp),a
 243  00b2               L54:
 244                     ; 51     if (COLUMN_GET(C2)) {
 246  00b2 4b04          	push	#4
 247  00b4 ae500a        	ldw	x,#20490
 248  00b7 cd0000        	call	_GPIO_ReadInputPin
 250  00ba 5b01          	addw	sp,#1
 251  00bc 4d            	tnz	a
 252  00bd 2604          	jrne	L74
 253                     ; 52         bagr = 0x5;
 255  00bf a605          	ld	a,#5
 256  00c1 6b01          	ld	(OFST+0,sp),a
 258  00c3               L74:
 259                     ; 54     if (COLUMN_GET(C3)) {
 261  00c3 4b08          	push	#8
 262  00c5 ae500a        	ldw	x,#20490
 263  00c8 cd0000        	call	_GPIO_ReadInputPin
 265  00cb 5b01          	addw	sp,#1
 266  00cd 4d            	tnz	a
 267  00ce 2604          	jrne	L15
 268                     ; 55         bagr = 0x6;
 270  00d0 a606          	ld	a,#6
 271  00d2 6b01          	ld	(OFST+0,sp),a
 273  00d4               L15:
 274                     ; 60     ROW_OFF(R2);
 276  00d4 4b01          	push	#1
 277  00d6 ae5014        	ldw	x,#20500
 278  00d9 cd0000        	call	_GPIO_WriteHigh
 280  00dc 84            	pop	a
 281                     ; 62     ROW_ON(R3);
 284  00dd 4b20          	push	#32
 285  00df ae500f        	ldw	x,#20495
 286  00e2 cd0000        	call	_GPIO_WriteLow
 288  00e5 84            	pop	a
 289                     ; 63     if (COLUMN_GET(C1)) {
 292  00e6 4b01          	push	#1
 293  00e8 ae501e        	ldw	x,#20510
 294  00eb cd0000        	call	_GPIO_ReadInputPin
 296  00ee 5b01          	addw	sp,#1
 297  00f0 4d            	tnz	a
 298  00f1 2604          	jrne	L35
 299                     ; 64         bagr = 0x7;
 301  00f3 a607          	ld	a,#7
 302  00f5 6b01          	ld	(OFST+0,sp),a
 304  00f7               L35:
 305                     ; 66     if (COLUMN_GET(C2)) {
 307  00f7 4b04          	push	#4
 308  00f9 ae500a        	ldw	x,#20490
 309  00fc cd0000        	call	_GPIO_ReadInputPin
 311  00ff 5b01          	addw	sp,#1
 312  0101 4d            	tnz	a
 313  0102 2604          	jrne	L55
 314                     ; 67         bagr = 0x8;
 316  0104 a608          	ld	a,#8
 317  0106 6b01          	ld	(OFST+0,sp),a
 319  0108               L55:
 320                     ; 69     if (COLUMN_GET(C3)) {
 322  0108 4b08          	push	#8
 323  010a ae500a        	ldw	x,#20490
 324  010d cd0000        	call	_GPIO_ReadInputPin
 326  0110 5b01          	addw	sp,#1
 327  0112 4d            	tnz	a
 328  0113 2604          	jrne	L75
 329                     ; 70         bagr = 0x9;
 331  0115 a609          	ld	a,#9
 332  0117 6b01          	ld	(OFST+0,sp),a
 334  0119               L75:
 335                     ; 75     ROW_OFF(R3);
 337  0119 4b20          	push	#32
 338  011b ae500f        	ldw	x,#20495
 339  011e cd0000        	call	_GPIO_WriteHigh
 341  0121 84            	pop	a
 342                     ; 77     ROW_ON(R4);
 345  0122 4b40          	push	#64
 346  0124 ae500f        	ldw	x,#20495
 347  0127 cd0000        	call	_GPIO_WriteLow
 349  012a 84            	pop	a
 350                     ; 78     if (COLUMN_GET(C1)) {
 353  012b 4b01          	push	#1
 354  012d ae501e        	ldw	x,#20510
 355  0130 cd0000        	call	_GPIO_ReadInputPin
 357  0133 5b01          	addw	sp,#1
 358  0135 4d            	tnz	a
 359  0136 2604          	jrne	L16
 360                     ; 79         bagr = 0xA;
 362  0138 a60a          	ld	a,#10
 363  013a 6b01          	ld	(OFST+0,sp),a
 365  013c               L16:
 366                     ; 81     if (COLUMN_GET(C2)) {
 368  013c 4b04          	push	#4
 369  013e ae500a        	ldw	x,#20490
 370  0141 cd0000        	call	_GPIO_ReadInputPin
 372  0144 5b01          	addw	sp,#1
 373  0146 4d            	tnz	a
 374  0147 2602          	jrne	L36
 375                     ; 82         bagr = 0;
 377  0149 0f01          	clr	(OFST+0,sp)
 379  014b               L36:
 380                     ; 84     if (COLUMN_GET(C3)) {
 382  014b 4b08          	push	#8
 383  014d ae500a        	ldw	x,#20490
 384  0150 cd0000        	call	_GPIO_ReadInputPin
 386  0153 5b01          	addw	sp,#1
 387  0155 4d            	tnz	a
 388  0156 2604          	jrne	L56
 389                     ; 85         bagr = 0xB;
 391  0158 a60b          	ld	a,#11
 392  015a 6b01          	ld	(OFST+0,sp),a
 394  015c               L56:
 395                     ; 90     ROW_OFF(R4);
 397  015c 4b40          	push	#64
 398  015e ae500f        	ldw	x,#20495
 399  0161 cd0000        	call	_GPIO_WriteHigh
 401  0164 84            	pop	a
 402                     ; 92     return bagr;
 405  0165 7b01          	ld	a,(OFST+0,sp)
 408  0167 5b01          	addw	sp,#1
 409  0169 81            	ret
 422                     	xdef	_check_keypad
 423                     	xdef	_init_keypad
 424                     	xref	_GPIO_ReadInputPin
 425                     	xref	_GPIO_WriteLow
 426                     	xref	_GPIO_WriteHigh
 427                     	xref	_GPIO_Init
 446                     	end
