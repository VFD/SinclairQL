100 :
110 REMark ------------------------------
120 REMark Drawing RPUFOS logo
130 REMark On channel c with color p
140 REMark ------------------------------
150 :
160 REMark INPUT #0,"x0 ";x0: INPUT #0,"y0 ";y0: INPUT #0,"ink ";p
170 :
180 MODE 4: SCALE #1,75,0,0
190 :
800 p_rpufos_logo 1, 10, 10, 0
997 :
998 STOP
999 :
9000 REMark -------------------------------------
9010 REMark Drawing RPUFOS logo with color
9020 REMark  c      : channel
9030 REMark  x0, y0 : origin x,y (starting point)
9040 REMark  p      : pen color
9050 REMark -------------------------------------
9060 :
9070 DEFine PROCedure p_rpufos_logo (c, x0, y0, p)
9080   :
9090   PRINT #0,"channel ";c ! "ink ";p
9100   INK #c,p
9110   :
9120   REMark left down, blue
9130   POINT #c,x0+2,y0
9140   LINE_R #c TO 10,0 TO 2,2 TO 15,0 TO -2,2 TO 0,5
9150   LINE_R #c TO -13,0 TO -4,4 TO -6,0 TO -2,-2 TO -1,0
9160   LINE_R #c TO -1,-1 TO 0,-1 TO 1,-1 TO -1,-1 TO 0,-1
9170   LINE_R #c TO 1,-1 TO -1,-1 TO 0,-1 TO 1,-1 TO 0,-1 TO 1,-1
9180   REMark thumb
9190   POINT #c,x0+1,y0+11 : LINE_R #c TO 6,0
9200   :
9210   REMark left up, red
9220   POINT #c,x0,y0+38
9230   LINE_R #c TO 0,-10 TO 2,-2 TO 0,-15 TO 2,2 TO 5,0
9240   LINE_R #c TO 0,13 TO 4,4 TO 0,6 TO -2,2 TO 0,1
9250   LINE_R #c TO -1,1 TO -1,0 TO -1,-1 TO -1,1 TO -1,0
9260   LINE_R #c TO -1,-1 TO -1,1 TO -1,0 TO -1,-1 TO -1,0 TO -1,-1
9270   REMark thumb
9280   POINT #c,x0+11,y0+39 : LINE_R #c TO  0,-6
9290   :
9300   REMark right up, yellow
9310   POINT #c,x0+38,y0+40
9320   LINE_R #c TO -10,0 TO -2,-2 TO -15,0 TO 2,-2 TO 0,-5
9330   LINE_R #c TO 13,0 TO 4,-4 TO 6,0 TO 2,2 TO 1,0
9340   LINE_R #c TO 1,1 TO 0,1 TO -1,1 TO 1,1 TO 0,1
9350   LINE_R #c TO -1,1 TO 1,1 TO 0,1 TO -1,1 TO 0,1 TO -1,1
9360   REMark thumb
9370   POINT #c,x0+39,y0+29 : LINE_R #c TO -6,0
9380   :
9390   REMark right down, magenta
9400   POINT #c,x0+40,y0+2
9410   LINE_R #c TO 0,10 TO -2,2 TO 0,15 TO -2,-2 TO -5,0
9420   LINE_R #c TO 0,-13 TO -4,-4 TO 0,-6 TO 2,-2 TO 0,-1
9430   LINE_R #c TO 1,-1 TO 1,0 TO 1,1 TO 1,-1 TO 1,0
9440   LINE_R #c TO 1,1 TO 1,-1 TO 1,0 TO 1,1 TO 1,0 TO 1,1
9450   REMark thumb
9460   POINT #c,x0+29,y0+1 : LINE_R #c TO  0,6
9470   :
9480 END DEFine p_rpufos_logo
