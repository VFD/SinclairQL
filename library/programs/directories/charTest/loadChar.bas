100 REMark === Reserve memory for the font ===
110 REMark  values must match the build
120 fst = 192
130 lst = 251
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
260   PRINT #1, c;":";CHR$(c)!!;
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
720 STOP
730 :
740 CLS #1:
750 PRINT FILL$(CHR$(227),60)
760 PRINT FILL$(CHR$(228),60)
765 CHAR_INC #1,8,9 : OVER 1 : REMark Transparent mode, no y space
770 PRINT FILL$(CHR$(229),60)
780 PRINT FILL$(CHR$(230),60)
790 PRINT FILL$(CHR$(231),60)
800 PRINT FILL$(CHR$(232),60)
805 CHAR_INC #1,8,8 : OVER 1 : REMark Transparent mode, no y space
810 PRINT FILL$(CHR$(233),60)
820 PRINT FILL$(CHR$(234),60)
830 PRINT FILL$(CHR$(235),60)
890 CHAR_INC #1,8,10
1000 REMark ---------------------
1010 REMark Demo Tableau
1020 REMark ---------------------
1030 DEFine PROCedure p_tableau (ch)
1040   LOCal i
1050   CHAR_INC #ch,8,9: OVER #ch,1
1060   AT #ch, 0,1: PRINT #ch,FILL$(CHR$(220),12)
1065   AT #ch, 2,1: PRINT #ch,FILL$(CHR$(220),12)
1070   AT #ch,11,1: PRINT #ch,FILL$(CHR$(220),12)
1080   FOR i=1 TO 10
1090     AT #ch,i, 0: PRINT #ch,CHR$(217)
1100     AT #ch,i,13: PRINT #ch,CHR$(217)
1110   END FOR i
1120   AT #ch,  0,0 : PRINT #ch,CHR$(219): AT #ch,  0,13: PRINT #ch,CHR$(221)
1130   AT #ch,  2,0 : PRINT #ch,CHR$(214): AT #ch,  2,13: PRINT #ch,CHR$(212)
1140   AT #ch, 11,0 : PRINT #ch,CHR$(216): AT #ch, 11,13: PRINT #ch,CHR$(218)
1150   AT #ch,  1,1 : PRINT #ch,"Hello"
1190 p_std_char (ch): REMark reset default
1200 END DEFine p_tableau
1500 REMark ---------------------
1510 REMark demo arrow (4x4 char)
1520 REMark  ch:  channel
1530 REMark  x0:  pos x
1540 REMark  y0:  pos y
1550 REMark  use also line x0+1
1560 REMark ---------------------
1570 DEFine PROCedure p_arrow (ch, x, y)
1580   CHAR_INC #ch,8,9 : OVER #ch,1 : REMark Transparent mode, no y space
1590   AT #ch,x  ,y : PRINT #ch,CHR$(222);CHR$(223)
1600   AT #ch,x+1,y : PRINT #ch,CHR$(224);CHR$(225)
1610   p_std_char (ch): REMark reset default
1620 END DEFine p_arrow
1700 REMark ---------
1710 REMark Show char
1720 REMark ---------
1722 DEFine PROCedure p_show_char (ch, first, last)
1725   LOCal c, row, col
1742   CHAR_USE #ch, 0, base
1747   CSIZE #ch,1,0
1750   row=2: col=0
1760   FOR c=first TO last
1770     AT #ch,row,col
1780     REMark Print code number (3 digits) + character
1790     IF c<100 THEN PRINT #ch," ";
1800     PRINT #ch,c;" ";CHR$(c);"  ";
1810     REMark Move to next row
1820     row=row+1
1830     REMark Switch to next column when reaching bottom
1840     IF row>19 THEN row=2: col=col+7
1850   NEXT c
1860 END DEFine p_show_char
1870 :
1880 :
1890 :


1900 REMark ----------
1910 REMark Demo chain
1920 REMark ----------
1930 Define procedure p_chain (ch)
1940   CLS #ch : REMark chain demo
1950   CHAR_INC #ch,8,9 : OVER #ch,1 : REMark Transparent mode, no y space
1960   x0=1: y0=1
1970   AT #ch,0,0: PRINT #ch,FILL$(CHR$(197)&CHR$(197),25): REMark to attach the chain...
1980   REPeat loop
1990     AT #ch,x0  ,y0: PRINT #ch,CHR$(205)
2000     AT #ch,x0+1,y0: PRINT #ch,CHR$(206)
2010     x0=x0+2
2020     IF x0=15 THEN EXIT loop
2030   END REPeat loop
2040   CHAR_INC #ch,8,10 : OVER #ch,0: REMark reset default
2050 end define p_chain
2060 :

7997 :
7998 STOP
7999 :
8000 REMark ---------------------------
8010 REMark REMark reset default values
8020 REMark ch: channel
8030 REMark ---------------------------
8040 DEFine PROCedure p_std_char (ch)
8050   CHAR_INC #ch,8,10 : OVER #ch,0:
8060 END DEFine p_std_char
8065 :
8070 REMark -----------------
8080 REMark set char size
8090 REMark ch: channel
8100 REMark x:  x size
8110 REMark y:  y size
8120 REMark o:  over (1 or 0)
8130 REMark -----------------
8140 DEFine PROCedure p_set_char (ch, cx, cy, o)
8150   CHAR_INC #ch,cx,cy : OVER #ch,o :
8160 END DEFine p_set_char
8200 :
8210 REMark define work
8230 :
8240 define procedure p_work_area (ch, lx, ly, x0, y0)
8250   open #ch, scr_
8260   window #ch, lx, ly, x0, y0
8270   scale #ch, ly, 0,0
8280   :
8290 end define p_work_area
8300 :
8310 p_work_area #3, 512,200, 0,0
8320 p_show_char #3, 127, 255
8330 :

