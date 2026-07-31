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
