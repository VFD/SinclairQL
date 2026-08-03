100 REMark === Reserve memory for the font ===
110 REMark  values must match the build
120 fst = 192
130 lst = 225
140 num = ((lst-fst+1)*9)+2
150 base = ALCHP(num)
160 REMark === Load the font file into memory ===
170 LBYTES "rpufos.fnt", base
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
360 FOR i=1 TO 20: PRINT CHR$(197);: END FOR i: PRINT \
370 FOR i=1 TO 20: PRINT CHR$(197);: END FOR i
380 CHAR_INC #1,8,10 : OVER 0: REMark reset default
390 :
400 STOP
410 :
420 CLS#1 : REMark chain demo
430 CHAR_INC #1,8,9 : OVER 1 : REMark Transparent mode, no y space
440 x0=1: y0=1
450 AT #1,0,0: PRINT FILL$(CHR$(197)&CHR$(197),25): REMark to attach the chain...
460 REPeat loop
470   AT #1,x0,y0: PRINT CHR$(205)
480   AT #1,x0+1,y0: PRINT CHR$(206)
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
590   AT #1,1,1: PRINT CHR$(208);:
600   PAUSE 5
610   AT #1,1,1: PRINT CHR$(209);:
620   PAUSE 5
630 END FOR i
640 CSIZE #1,1,0
645 :
650 STOP
660 :
670 CLS#1: REMark demo arrow
680 CHAR_INC #1,8,9 : OVER 1 : REMark Transparent mode, no y space
690 PRINT CHR$(222);CHR$(223)\CHR$(224);CHR$(225)\
700 CHAR_INC #1,8,10 : OVER 0: REMark reset default
710 :
720 STOP
730 :
8000 : REMark ---------------------------
8010 : REMark REMark reset default values
8020 : REMark ch: channel
8030 : REMark ---------------------------
8040 DEFine PROCedure p_std_char (ch)
8050   CHAR_INC #ch,8,10 : OVER 0:
8060 END DEFine p_std_char
8070 : REMark -----------------
8080 : REMark set char size
8090 : REMark ch: channel
8100 : REMark x:  x size
8110 : REMark y:  y size
8120 : REMark o:  over (1 or 0)
8130 : REMark -----------------
8140 DEFine PROCedure p_set_char (ch, x, y, o)
8150   CHAR_INC #1,x,y : OVER o :
8160 END DEFine p_set_char
8200 :
8210 :
8230 :
8240 DEFine FuNction p_repeat$(c$, n)
8250  LOCal t$, i
8260  DIM t$(n)
8270  FOR i = 1 TO n: t$(i) = c$ : END FOR i
8280  RETurn t$
8290 END DEFine p_repeat$
