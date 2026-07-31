100 REMark ------------------------------
110 REMark         A simple BOOT
111 REMark       to manage them all
112 REMark ------------------------------
120 :
130 prog$ = "prog_bas": REMark Put right name here
140 :
150 REMark --- Try each available drive ---
160 drv$ = "mdv1_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
170 drv$ = "mdv2_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
180 drv$ = "flp1_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
190 drv$ = "flp2_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
200 PRINT "Program not found!" : STOP
210 :
300 REMark --- Configure and launch ---
310 CLOSE #ch         : REMark close the FOP_IN
320 DATA_USE drv$     : REMark env var set
330 PROG_USE drv$     : REMark env var set
340 LRUN drv$ & prog$ : REMark Launch the prog
350 :
500 REMark ------------------------------
510 REMark Delete after use "DLINE 500 TO"
520 REMark On a standard QL You have mdv 1 and 2
530 REMark may be flp 1 and 2, rarely HDD
540 REMark ------------------------------
550 REMark DATA_USE and PROG_USE
560 REMark are env var for the QL
570 REMark 
580 REMark PROG_USE
590 REMark For MERGE, FNT, ....
600 REMark When need to load
610 REMark 
620 REMark DATA_USE
630 REMark For data
640 REMark 
650 REMark ------------------------------
