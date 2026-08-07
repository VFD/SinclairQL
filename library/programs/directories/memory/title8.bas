150 MODE 8
160 OPEN #4,scr_512x200a0x0
170 PAPER #4,0: INK #4,7: CLS #4
180 WINDOW #0,512,56,0,200
190 PAPER #0,0: INK #0,7: CLS #0
200 p_TITLE
210 :
220 PAUSE
1000 REMark ----------
1010 REMark TITLE page
1020 REMark ----------
1030 DEFine PROCedure p_TITLE
1050   PAPER #4,0: INK #4,4: CLS #4
1060   CSIZE #4,3,1: AT #4,1,13 : PRINT #4,"RPUFOS": REMark 32w 2h
1070   CSIZE #4,2,0: AT #4,4,9  : PRINT #4,"Retro Programmers United": REMark 42w 1h
1080   CSIZE #4,2,0: AT #4,5,11 : PRINT #4,"For Obscure Systems"
1090   CSIZE #4,3,1: AT #4,4,9  : PRINT #4,"Game Jam 2026"
1100   CSIZE #4,2,1: AT #4,6,18 : PRINT #4,"Memory": REMark 42w 2h
1110   CSIZE #4,3,0: AT #4,14,5 : PRINT #4,"A four big pixels game"
1120   CSIZE #4,3,0: AT #4,15,9 : PRINT #4,"with beep beep": REMark 32w 1h
1130   PAUSE 50: CSIZE #4,2,1: AT #4,9,28: PRINT #4,"Press a key...";
1140   dummy=KEYROW(0): PAUSE: DING: CLS #4
1150 END DEFine p_TITLE
1500 :
1900 REMark ---------
1910 REMark Beep beep
1920 REMark ---------
1930 DEFine PROCedure DING
1940   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
1950 END DEFine DING
