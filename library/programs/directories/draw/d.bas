5 REMark === RPUFOS Logo Test Program ===
10 MODE 8
15 OPEN #3,scr_512x200a0x0:
20 PAPER #3,0: CLS #3
25 PAPER #1,0: INK #1,7: CLS #1
30 PRINT #1,"test draw"
40 p_rpufos 3,0,0
50 :
60 CLOSE #3
9999 STOP
1000 REMark ---------------------------
1010 REMark RPUFOS Logo - Relative draw
1030 REMark Parameters:
1035 REMark   c     = channel number
1037 REMark   x0,y0 = start position
1038 REMark   f     = fill (0,1) to do
1040 REMark ---------------------------
1045 DEFine PROCedure p_rpufos(c,x0,y0)
1050   REMark Draw hand shape on channel c at position x0,y0
1055   REMark Shape is 28 wide x 14 high (1 char = 1 pixel)
1060   REMark White background, black lines (MODE 8)
1065   PAPER #c,7: INK #c,0: CLS #c
1067   :
1070   REMark --- Outer contour (clockwise from top-left) ---
1075   POINT #c,x0+4,y0+13: LINE_R #c TO 6,0 TO 4,-4
1080   LINE_R #c TO 11,0 TO 0,-5
1085   LINE_R #c TO 2,-2 TO -13,0
1090   LINE_R #c TO -2,-2 TO -10,0
1095   LINE_R #c TO -1,1 TO 0,1 TO -1,1 TO 0,1 TO 1,1
1100   LINE_R #c TO -1,1 TO 0,1 TO 1,1 TO -1,1 TO 0,1
1105   LINE_R #c TO 2,2 TO 1,0 TO 1,1
1107   REMark --- Interior line (bottom of thumb, line 3) ---
1108   POINT #c,x0+1,y0+11: LINE_R #c TO 6,0
1110   :
1200   REMark --- Hand 2 (top-left) : hand1 rotated -90 degrees ---
1205   REMark --- (dx,dy) -> (dy,-dx) applied to all vectors ---
1210   POINT #3,x0+13,y0+34: LINE_R #3 TO 0,-6 TO -4,-4
1215   LINE_R #3 TO 0,-11 TO -5,0
1220   LINE_R #3 TO -1,-1 TO -1,-1 TO 0,13
1225   LINE_R #3 TO -1,1 TO -1,1 TO 0,10
1230   LINE_R #3 TO 1,1 TO 1,0 TO 1,1 TO 1,0 TO 1,-1
1235   LINE_R #3 TO 1,1 TO 1,0 TO 1,-1 TO 1,1 TO 1,0
1240   LINE_R #3 TO 1,-1 TO 1,-1 TO 0,-1 TO 1,-1
1245   REMark --- Interior line (rotated) ---
1250   POINT #3,x0+10,y0+34: LINE_R #3 TO 0,-6
1260  :
1300 REMark --- Hand 3 : hand1 rotated 180 degrees ---
1305 REMark --- (dx,dy) -> (-dx,-dy) applied to all vectors ---
1310 POINT #c,x0+34,y0+25: LINE_R #c TO -6,0 TO -4,4
1315 LINE_R #c TO -11,0 TO 0,5
1320 LINE_R #c TO -1,1 TO -1,1 TO 13,0
1325 LINE_R #c TO 1,1 TO 1,1 TO 10,0
1330 LINE_R #c TO 1,-1 TO 0,-1 TO 1,-1 TO 0,-1 TO -1,-1
1335 LINE_R #c TO 1,-1 TO 0,-1 TO -1,-1 TO 1,-1 TO 0,-1
1340 LINE_R #c TO -1,-1 TO -1,-1 TO -1,0 TO -1,-1
1345 REMark --- Interior line (rotated 180) ---
1350 POINT #c,x0+37,y0+29: LINE_R #c TO -6,0
1360 :
1400 REMark --- Hand 4 (bottom-right) : hand1 rotated +90 deg ---
1405 REMark --- (dx,dy) -> (-dy,dx) applied to all vectors ---
1410 REMark --- Fingers point down, forearm goes up ---
1415 REMark --- This is hand2 rotated 180 deg ---
1420 POINT #3,x0+37,y0+1: LINE_R #3 TO -2,-1 TO -1,0 TO -1,1 TO -1,-1 TO -1,0 TO -1,1 TO -1,-1 TO -1,0 TO -1,1
1425 LINE_R #3 TO -1,1 TO 0,1 TO -1,1 TO 0,3 TO 0,1 TO -1,1 TO 5,5 TO 0,10
1430 LINE_R #3 TO -1,1 TO 6,0 TO 1,1 TO 1,0
1435 LINE_R #3 TO 0,-1 TO 0,-11 TO 2,-2 TO 0,-10 TO -1,-1
1440 REMark --- Interior line (rotated) ---
1445 POINT #3,x0+27,y0+22: LINE_R #3 TO 0,3


9999 END DEFine p_rpufos





