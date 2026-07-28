30000 REMark -------------------------------------
30010 REMark Drawing RPUFOS logo with color
30020 REMark  c      : channel
30030 REMark  x0, y0 : origin x,y (starting point)
30040 REMark  p      : pen color
30050 REMark -------------------------------------
30060 :
30070 DEFine PROCedure p_rpufos_logo (c, x0, y0, p)
30080   :
30090   REMark PRINT #0,"channel ";c ! "ink ";p
30100   INK #c,p
30110   :
30120   REMark left down, blue
30130   POINT #c,x0+2,y0
30140   LINE_R #c TO 10,0 TO 2,2 TO 15,0 TO -2,2 TO 0,5
30150   LINE_R #c TO -13,0 TO -4,4 TO -6,0 TO -2,-2 TO -1,0
30160   LINE_R #c TO -1,-1 TO 0,-1 TO 1,-1 TO -1,-1 TO 0,-1
30170   LINE_R #c TO 1,-1 TO -1,-1 TO 0,-1 TO 1,-1 TO 0,-1 TO 1,-1
30180   REMark thumb
30190   POINT #c,x0+1,y0+11 : LINE_R #c TO 6,0
30200   :
30210   REMark left up, red
30220   POINT #c,x0,y0+38
30230   LINE_R #c TO 0,-10 TO 2,-2 TO 0,-15 TO 2,2 TO 5,0
30240   LINE_R #c TO 0,13 TO 4,4 TO 0,6 TO -2,2 TO 0,1
30250   LINE_R #c TO -1,1 TO -1,0 TO -1,-1 TO -1,1 TO -1,0
30260   LINE_R #c TO -1,-1 TO -1,1 TO -1,0 TO -1,-1 TO -1,0 TO -1,-1
30270   REMark thumb
30280   POINT #c,x0+11,y0+39 : LINE_R #c TO  0,-6
30290   :
30300   REMark right up, yellow
30310   POINT #c,x0+38,y0+40
30320   LINE_R #c TO -10,0 TO -2,-2 TO -15,0 TO 2,-2 TO 0,-5
30330   LINE_R #c TO 13,0 TO 4,-4 TO 6,0 TO 2,2 TO 1,0
30340   LINE_R #c TO 1,1 TO 0,1 TO -1,1 TO 1,1 TO 0,1
30350   LINE_R #c TO -1,1 TO 1,1 TO 0,1 TO -1,1 TO 0,1 TO -1,1
30360   REMark thumb
30370   POINT #c,x0+39,y0+29 : LINE_R #c TO -6,0
30380   :
30390   REMark right down, magenta
30400   POINT #c,x0+40,y0+2
30410   LINE_R #c TO 0,10 TO -2,2 TO 0,15 TO -2,-2 TO -5,0
30420   LINE_R #c TO 0,-13 TO -4,-4 TO 0,-6 TO 2,-2 TO 0,-1
30430   LINE_R #c TO 1,-1 TO 1,0 TO 1,1 TO 1,-1 TO 1,0
30440   LINE_R #c TO 1,1 TO 1,-1 TO 1,0 TO 1,1 TO 1,0 TO 1,1
30450   REMark thumb
30460   POINT #c,x0+29,y0+1 : LINE_R #c TO  0,6
30470   :
30480 END DEFine p_rpufos_logo
