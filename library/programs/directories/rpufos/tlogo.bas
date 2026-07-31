100 REMark --------------------------
110 REMark Test merging logo and show
120 REMark --------------------------
130 PRINT #0,"Merge"
140 MERGE "p_rpufos_logo.bas"
150 PRINT #0,"INIT"
160 p_init
170 PRINT #0,"draw"
180 :p_put_logo 8, 74,81, 4, 128: REMark full screen mode 8 f=128 xmax=190
190 :p_put_logo 8, 29,54, 6, 128
200 :p_put_logo 8, 74,27, 1, 128
210 :p_put_logo 8, 119,54, 2, 128
220 :

300 BLOCK #3,44,30,232,40 ,7: REMark x,y, posx, posy, color
310 BLOCK #3,44,30,232,146,7  : REMark Down  = blue
320 BLOCK #3,44,30,111,93 ,7  : REMark Left  = yellow
330 BLOCK #3,44,30,355,93 ,7  : REMark Right = red


2000 REMark -------------------------------------------------
2010 REMark put logo on channel, x0,y0 color and scale factor
2020 REMark -------------------------------------------------
2030 DEFine PROCedure p_put_logo (ch, x0, y0, c, f)
2040   OPEN #ch,scr_
2050   REMark PRINT #0,"Open channel " ! ch
2060   REMark 
2070   WINDOW #ch, 512,256,0,0: REMark full screen
2080   REMark to match Y
2090   SCALE #ch,f,0,0
2100   p_rpufos_logo #ch, x0, y0, c
2110  CLOSE #ch
2120  REMark PRINT #0,"close channel"
2130 END DEFine p_put_logo
3000 REMark ----------------------------
3010 REMark Init Game, We use channel #3
3020 REMark ----------------------------
3030 DEFine PROCedure p_init
3040   MODE 8
3050   OPEN #3, scr_
3060   WINDOW #3,512,256,0,0
3070   PAPER #0,0: CLS #3
3080   INK #3,7: CSIZE #3,3,1: AT #3,5,13: PRINT #3,"RPUFOS"
3090 END DEFine

