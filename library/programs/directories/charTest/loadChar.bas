100 REMark === Reserve memory for the font ===
110 REMark  values must match the build
120 fst = 192
130 lst = 194
140 num = ((lst-fst+1)*9)+2
150 base = ALCHP(num)
160 REMark === Load the font file into memory ===
170 LBYTES "myfont_raw", base
180 REMark === Install the font as upper font for window #1 ===
190 CHAR_USE #1, 0, base
200 REMark === Set character spacing for 8x8 fonts ===
210 REMark CHAR_INC #1, 8, 8
220 MODE 4
230 CLS #1: CSIZE #1,1,0; : REMark CHAR_INC #1,8,10
240 REMark === Display all characters from 32 to 255 ===
250 FOR c = 192 TO 255
260   PRINT #1, CHR$(c)!;
270 END FOR c
280 REMark === End: remove the font if needed ===
290 REMark CHAR_USE #1,0,0
300 REMark RECHP base
310 :
320 STOP
330 :
340 CLS#1 : REMark Wall demo
350 CHAR_INC #1,8,9 : OVER 1 : REMark Transparent mode, no y space
360 FOR i=1 TO 20: PRINT CHR$(196);: END FOR i: PRINT \
370 FOR i=1 TO 20: PRINT CHR$(196);: END FOR i
380 CHAR_INC #1,8,10 : OVER 0: REMark reset default
390 :
400 STOP
410 :
420 CLS#1 : REMark chain demo
430 CHAR_INC #1,8,9 : OVER 1 : REMark Transparent mode, no y space
440 x0=1: y0=1
450 AT #1,0,0: PRINT CHR$(196);CHR$(196);CHR$(196);CHR$(196);: REMark to attach the chain...
460 REPeat loop
470   AT #1,x0,y0: PRINT CHR$(204)
480   AT #1,x0+1,y0: PRINT CHR$(205)
490   x0=x0+2
500   IF x0=15 THEN EXIT loop
510 END REPeat loop
520 CHAR_INC #1,8,10 : OVER 0: REMark reset default
530 :
540 STOP
550 :
560 CLS#1 : REMark Candle demo
570 CHAR_INC #1,8,10: CSIZE #1,3,1
580 FOR i=1 TO 20:
590   AT #1,1,1: PRINT CHR$(207);:
600   PAUSE 5
610   AT #1,1,1: PRINT CHR$(208);:
620   PAUSE 5
630 END FOR i
640 CSIZE #1,1,0
650 STOP
