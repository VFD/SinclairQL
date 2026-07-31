100 :
110 REMark ------------------------------
120 REMark Drawing RPUFOS logo
130 REMark Beta 1, miss channel)
140 REMark ------------------------------
150 :
160 REMark INPUT #0,"x0 ";x0: INPUT #0,"y0 ";y0: INPUT #0,"ink ";p
170 :
180 MODE 8
190 :
800 p_rpufos_logo 1, 10, 10, 7
997 :
998 STOP
999 :
1000 REMark ----------
1010 REMark Drawing RPUFOS logo with color
1020 REMark  c: channel
1030 REMark  x0: origin x ; y0: origin y
1040 REMark bug mode 4, ink
1050 :
1060 DEFine PROCedure p_rpufos_logo (c, x0, y0, p)
1070   :
1080   PRINT #0,"channel ";c ! "ink ";p
1090   INK #c,p
1100   :
1110   REMark left down, blue
1120   POINT x0+2,y0
1130   LINE_R TO 10,0 TO 2,2 TO 15,0 TO -2,2 TO 0,5
1140   LINE_R TO -13,0 TO -4,4 TO -6,0 TO -2,-2 TO -1,0
1150   LINE_R TO -1,-1 TO 0,-1 TO 1,-1 TO -1,-1 TO 0,-1
1160   LINE_R TO 1,-1 TO -1,-1 TO 0,-1 TO 1,-1 TO 0,-1 TO 1,-1
1170   REMark thumb
1180   POINT x0+1,y0+11 : LINE_R TO  6,0
1190   :
1200   REMark left up, red
1210   POINT x0,y0+38
1220   LINE_R TO 0,-10 TO 2,-2 TO 0,-15 TO 2,2 TO 5,0
1230   LINE_R TO 0,13 TO 4,4 TO 0,6 TO -2,2 TO 0,1
1240   LINE_R TO -1,1 TO -1,0 TO -1,-1 TO -1,1 TO -1,0
1250   LINE_R TO -1,-1 TO -1,1 TO -1,0 TO -1,-1 TO -1,0 TO -1,-1
1260   REMark thumb
1270   POINT x0+11,y0+39 : LINE_R TO  0,-6
1280   :
1290   REMark right up, yellow
1300   POINT x0+38,y0+40
1310   LINE_R TO -10,0 TO -2,-2 TO -15,0 TO 2,-2 TO 0,-5
1320   LINE_R TO 13,0 TO 4,-4 TO 6,0 TO 2,2 TO 1,0
1330   LINE_R TO 1,1 TO 0,1 TO -1,1 TO 1,1 TO 0,1
1340   LINE_R TO -1,1 TO 1,1 TO 0,1 TO -1,1 TO 0,1 TO -1,1
1350   REMark thumb
1360   POINT x0+39,y0+29 : LINE_R TO -6,0
1370   :
1380   REMark right down, magenta
1390   POINT x0+40,y0+2
1400   LINE_R TO 0,10 TO -2,2 TO 0,15 TO -2,-2 TO -5,0
1410   LINE_R TO 0,-13 TO -4,-4 TO 0,-6 TO 2,-2 TO 0,-1
1420   LINE_R TO 1,-1 TO 1,0 TO 1,1 TO 1,-1 TO 1,0
1430   LINE_R TO 1,1 TO 1,-1 TO 1,0 TO 1,1 TO 1,0 TO 1,1
1440   REMark thumb
1450   POINT x0+29,y0+1 : LINE_R TO  0,6
1460   :
1470 END DEFine p_rpufos_logo
