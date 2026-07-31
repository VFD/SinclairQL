30000 REMark -------------------------------------
30010 REMark Drawing RPUFOS logo with color
30020 REMark  ch     : channel
30030 REMark  x0, y0 : origin x,y (starting point)
30040 REMark  c      : pen color
30050 REMark -------------------------------------
30060 :
30070 DEFine PROCedure p_rpufos_logo (ch, x0, y0, c)
30080   :
30090   REMark PRINT #0,"channel ";ch ! "ink ";c
30100   INK #ch,c
30110   :
30120   REMark left down, blue
30130   POINT #ch,x0+2,y0
30140   LINE_R #ch TO 10,0 TO 2,2 TO 15,0 TO -2,2 TO 0,5
30150   LINE_R #ch TO -13,0 TO -4,4 TO -6,0 TO -2,-2 TO -1,0
30160   LINE_R #ch TO -1,-1 TO 0,-1 TO 1,-1 TO -1,-1 TO 0,-1
30170   LINE_R #ch TO 1,-1 TO -1,-1 TO 0,-1 TO 1,-1 TO 0,-1 TO 1,-1
30180   REMark thumb
30190   POINT #ch,x0+1,y0+11 : LINE_R #ch TO 6,0
30200   :
30210   REMark left up, red
30220   POINT #ch,x0,y0+38
30230   LINE_R #ch TO 0,-10 TO 2,-2 TO 0,-15 TO 2,2 TO 5,0
30240   LINE_R #ch TO 0,13 TO 4,4 TO 0,6 TO -2,2 TO 0,1
30250   LINE_R #ch TO -1,1 TO -1,0 TO -1,-1 TO -1,1 TO -1,0
30260   LINE_R #ch TO -1,-1 TO -1,1 TO -1,0 TO -1,-1 TO -1,0 TO -1,-1
30270   REMark thumb
30280   POINT #ch,x0+11,y0+39 : LINE_R #ch TO  0,-6
30290   :
30300   REMark right up, yellow
30310   POINT #ch,x0+38,y0+40
30320   LINE_R #ch TO -10,0 TO -2,-2 TO -15,0 TO 2,-2 TO 0,-5
30330   LINE_R #ch TO 13,0 TO 4,-4 TO 6,0 TO 2,2 TO 1,0
30340   LINE_R #ch TO 1,1 TO 0,1 TO -1,1 TO 1,1 TO 0,1
30350   LINE_R #ch TO -1,1 TO 1,1 TO 0,1 TO -1,1 TO 0,1 TO -1,1
30360   REMark thumb
30370   POINT #ch,x0+39,y0+29 : LINE_R #ch TO -6,0
30380   :
30390   REMark right down, magenta
30400   POINT #ch,x0+40,y0+2
30410   LINE_R #ch TO 0,10 TO -2,2 TO 0,15 TO -2,-2 TO -5,0
30420   LINE_R #ch TO 0,-13 TO -4,-4 TO 0,-6 TO 2,-2 TO 0,-1
30430   LINE_R #ch TO 1,-1 TO 1,0 TO 1,1 TO 1,-1 TO 1,0
30440   LINE_R #ch TO 1,1 TO 1,-1 TO 1,0 TO 1,1 TO 1,0 TO 1,1
30450   REMark thumb
30460   POINT #ch,x0+29,y0+1 : LINE_R #ch TO  0,6
30470   :
30480 END DEFine p_rpufos_logo
30490 :
30500 REMark -------------------------------------------------
30510 REMark put logo on channel, x0,y0 color and scale factor
30520 REMark -------------------------------------------------
30530 DEFine PROCedure p_put_logo (ch, x0, y0, c, f)
30540   OPEN #ch,scr_
30550   REMark PRINT #0,"Open channel " ! ch
30560   REMark 
30570   WINDOW #ch, 512,256,0,0: REMark full screen
30580   REMark to match Y
30590   SCALE #ch,f,0,0
30600   p_rpufos_logo #ch, x0, y0, c
30610  CLOSE #ch
30620  REMark PRINT #0,"close channel"
30630 END DEFine p_put_logo
30640 REMark ----------------------------
30650 REMark Init Game, We use channel #3
30660 REMark ----------------------------
30670 DEFine PROCedure p_init
30680   MODE 8
30690   OPEN #3, scr_
30700   WINDOW #3,512,256,0,0
30710   PAPER #0,0: CLS #3
30720   INK #3,7: CSIZE #3,3,1: AT #3,5,13: PRINT #3,"RPUFOS"
30730 END DEFine 
