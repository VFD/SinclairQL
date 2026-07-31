100 :
110 REMark ------------------------------
120 REMark Drawing RPUFOS logo
130 REMark On channel c with color p
140 REMark ------------------------------
150 :
160 REMark INPUT #0,"x0 ";x0: INPUT #0,"y0 ";y0: INPUT #0,"ink ";p
170 :
180 MODE 4
190 WINDOW 512,256,0,0: CLS: REMark SCALE #1,200,0,0
195 p_screen_reset
300 :
790 SCALE 60,0,0
800 p_rpufos_logo 1, 23, 10, 4
900 :
910 lx=10: ly=35: REMark 10,15 mode 8
920 AT lx+0,ly : PRINT"Retro"
930 AT lx+1,ly : PRINT"Programmers"
940 AT lx+2,ly : PRINT"United for"
950 AT lx+3,ly : PRINT"Obscure"
960 AT lx+4,ly : PRINT"Systems"
997 :
998 STOP
999 :
2000 REMark --------
2010 REMark loop test
2020 REMark --------
2030 DEFine PROCedure p_test
2040 MODE 4: WINDOW 512,256,0,0: CLS
2050 x=0: y=0
2060 FOR i=500 TO 100 STEP -100
2070   SCALE i,0,0
2080   p_rpufos_logo 1, x, y, 7
2090   x=x+10 : y=y+10
2100 END FOR i
2110 END DEFine p_test
8000 REMark -------------------------------------
8010 REMark Drawing RPUFOS logo with color
8020 REMark  ch     : channel
8030 REMark  x0, y0 : origin x,y (starting point)
8040 REMark  c      : pen color
8050 REMark -------------------------------------
8060 :
8070 DEFine PROCedure p_rpufos_logo (ch, x0, y0, c)
8080   :
8090   REMark PRINT #0,"channel ";c ! "ink ";c
8100   INK #ch,c
8110   :
8120   REMark left down, blue
8130   POINT #ch,x0+2,y0
8140   LINE_R #ch TO 10,0 TO 2,2 TO 15,0 TO -2,2 TO 0,5
8150   LINE_R #ch TO -13,0 TO -4,4 TO -6,0 TO -2,-2 TO -1,0
8160   LINE_R #ch TO -1,-1 TO 0,-1 TO 1,-1 TO -1,-1 TO 0,-1
8170   LINE_R #ch TO 1,-1 TO -1,-1 TO 0,-1 TO 1,-1 TO 0,-1 TO 1,-1
8180   REMark thumb
8190   POINT #ch,x0+1,y0+11 : LINE_R #ch TO 6,0
8200   :
8210   REMark left up, red
8220   POINT #ch,x0,y0+38
8230   LINE_R #ch TO 0,-10 TO 2,-2 TO 0,-15 TO 2,2 TO 5,0
8240   LINE_R #ch TO 0,13 TO 4,4 TO 0,6 TO -2,2 TO 0,1
8250   LINE_R #ch TO -1,1 TO -1,0 TO -1,-1 TO -1,1 TO -1,0
8260   LINE_R #ch TO -1,-1 TO -1,1 TO -1,0 TO -1,-1 TO -1,0 TO -1,-1
8270   REMark thumb
8280   POINT #ch,x0+11,y0+39 : LINE_R #ch TO  0,-6
8290   :
8300   REMark right up, yellow
8310   POINT #ch,x0+38,y0+40
8320   LINE_R #ch TO -10,0 TO -2,-2 TO -15,0 TO 2,-2 TO 0,-5
8330   LINE_R #ch TO 13,0 TO 4,-4 TO 6,0 TO 2,2 TO 1,0
8340   LINE_R #ch TO 1,1 TO 0,1 TO -1,1 TO 1,1 TO 0,1
8350   LINE_R #ch TO -1,1 TO 1,1 TO 0,1 TO -1,1 TO 0,1 TO -1,1
8360   REMark thumb
8370   POINT #ch,x0+39,y0+29 : LINE_R #ch TO -6,0
8380   :
8390   REMark right down, magenta
8400   POINT #ch,x0+40,y0+2
8410   LINE_R #ch TO 0,10 TO -2,2 TO 0,15 TO -2,-2 TO -5,0
8420   LINE_R #ch TO 0,-13 TO -4,-4 TO 0,-6 TO 2,-2 TO 0,-1
8430   LINE_R #ch TO 1,-1 TO 1,0 TO 1,1 TO 1,-1 TO 1,0
8440   LINE_R #ch TO 1,1 TO 1,-1 TO 1,0 TO 1,1 TO 1,0 TO 1,1
8450   REMark thumb
8460   POINT #ch,x0+29,y0+1 : LINE_R #ch TO  0,6
8470   :
8480 END DEFine p_rpufos_logo
9000 REMark --------------
9010 REMark Reset channels
9020 REMark --------------
9030 DEFine PROCedure p_screen_reset
9040   BORDER #0,0: PAPER #0,0 :INK #0,4: CLS #0
9050   BORDER #1,0: PAPER #1,0 :INK #1,4: CLS #1
9060   BORDER #2,0: PAPER #2,0 :INK #2,4: CLS #2
9070 END DEFine p_screen_reset
30000 REMark 
31000 REMark 
32000 REMark 
