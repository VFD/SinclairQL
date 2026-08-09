100 REMark ----------------------------------------
110 REMark drawing pixart
120 REMark   ch: channel
130 REMark   x0: top left x
140 REMark   y0: top left y
150 REMark   sc: block scale (odd bug in mode 8)
160 REMark   rl: restore line for data
170 REMark ----------------------------------------
180 DEFine PROCedure p_draw_pixart (ch, x0, y0, sc, rl)
190   LOCal x, y, bit$
200   x=0 : y=0
210   RESTORE rl
220   REPeat drawing
230     READ bit$
240     IF bit$ = "END" : EXIT drawing
250     FOR x = 1 TO LEN(bit$)
260       IF bit$(x) <> " " THEN 
270         BLOCK #ch, sc,sc, x0+x*sc, y0-y*sc, HEX(bit$(x)) : REMark 0$-7$ = 0-7 = color
280       END IF 
290     END FOR x
300     y = y - 1
310   END REPeat drawing
320 END DEFine p_draw_pixart
330 :
340 : 
350 :
360 : 
1000 REMark ----------------------------------------
1010 REMark DEMO
1020 REMark ----------------------------------------
1030 MODE 4 : REMark MODE 8 Failed if sc is odd
1040 ch = 3
1050 OPEN #ch,scr_
1060 WINDOW #ch,512,256, 0,0: SCALE #ch,256, 0,0
1070 PAPER #ch,0 : INK #ch,7 : CLS #ch
1080 : CSIZE #ch,1,0
1090 :
1100 : p_draw_pixart #ch, 10,10, 1, 3030 : REMark MODE 8 Failed...
1110 : p_draw_pixart #ch, 10,50, 2, 3030
1120 : REMark p_draw_pixart #ch, 10,100, 3, 3030 : REMark MODE 8 Failed...
1130 : REMark p_draw_pixart #ch, 100,10, 5, 3030 : REMark MODE 8 Failed...
1140 : REMark p_draw_pixart #ch, 200,10, 6, 3030
1150 : REMark p_draw_pixart #ch, 350,10, 8, 3030
1160 :
1170 : p_draw_pixart #ch, 100,10, 1, 4030
1180 : p_draw_pixart #ch, 100,50, 2, 4030
1190 :
1200 : p_draw_pixart #ch, 0,0, 1, 4230
1210 :
1220 : p_draw_pixart #ch, 100,100, 1, 4430
1230 : p_draw_pixart #ch, 350,206, 6, 4430
1240 :
1250 : p_draw_pixart #ch, 30,7, 1, 4630
1260 : p_draw_pixart #ch, 44,44, 2, 4630
1270 :
1280 :
1290 :
1300 :

1980 CLOSE #ch
1990 :
3000 REMark ----------------------------------------
3010 REMark Man from 
3020 REMark ----------------------------------------
3030 DATA "      7 7777"
3040 DATA "       777777"
3050 DATA "      777777"
3060 DATA "      77  7 7"
3070 DATA "      777 7"
3080 DATA "       77777"
3090 DATA "     22  77"
3100 DATA "      22   2"
3110 DATA "   22 22442  2"
3120 DATA "  222 22442  22"
3130 DATA "  22  22442  22"
3140 DATA "      22442"
3150 DATA "777  222442  77"
3160 DATA "  7  2244442  7"
3170 DATA "     22    2"
3180 DATA "    22      2"
3190 DATA "   2"
3200 DATA ""
3210 DATA "      7    77"
3220 DATA "     777   7777"
3230 DATA "END"
3240 :
3250 :
3260 :
4000 REMark ----------------------------------------
4010 REMark spider, red eye, green line
4020 REMark ----------------------------------------
4030 DATA "   777"
4040 DATA " 777777"
4050 DATA "77747777"
4060 DATA "7777477 7777"
4070 DATA " 77777777272"
4080 DATA "   7 7777777"
4090 DATA "  7   77 7  7"
4100 DATA " 7   7 7  7  7"
4110 DATA "7   7  7  7   7"
4120 DATA "END"
4130 :
4200 REMark ----------------------------------------
4210 REMark Web for top left corner
4220 REMark ----------------------------------------
4230 DATA " 7 7 7 7 7 7 7 7"
4240 DATA "7 7 7 7 7 7 7 7"
4250 DATA " 7 7 7  7  7 7"
4260 DATA "7 7 77  7   7"
4270 DATA " 7 7 7      7"
4280 DATA "7 7  7      7"
4290 DATA "77"
4300 DATA "7"
4310 DATA "7"
4320 DATA "END"

4400 REMark ----------------------------------------
4410 REMark Skeleton down
4420 REMark ----------------------------------------
4430 DATA "  777"
4450 DATA " 77777"
4460 DATA "7777777"
4470 DATA "7 7  777    7 7 7"
4480 DATA "7 7  777 7   7 7 7"
4490 DATA "77 77777 7   7 7 77"
4500 DATA "77777777 7   7 7 7 7"
4510 DATA "7 7 7     7 7 7 7 77777"
4520 DATA "END"
4530 :


4600 REMark ----------------------------------------
4610 REMark Man from
4620 REMark ----------------------------------------
4630 DATA "         77777"
4640 DATA "       77777777"
4650 DATA "      77777777"
4660 DATA "      77  77 77"
4670 DATA "     7777 77 77"
4680 DATA "     7777777777"
4690 DATA "     77777  777"
4700 DATA "      77777777"
4710 DATA "       777777"
4720 DATA "         777  2"
4730 DATA "       22   222"
4740 DATA "   2 2222  2222 2"
4750 DATA "   22 222   22 22"
4760 DATA "  222  2 2  22  22"
4770 DATA "   2   222  222 2"
4780 DATA "777    2 2   22  777"
4790 DATA " 7     2222  22   7"
4800 DATA "      22 2   22"
4810 DATA "      2222  222"
4820 DATA "     22 2   2222"
4830 DATA "   22222      222"
4840 DATA "        77  77"
4850 DATA "       7777 7777"
4860 DATA "END"

9999 :
