10 REMark -------------------------
20 REMark   RPUFOS GAME JAM 2026
30 REMark     for Sinclair QL
40 REMark -------------------------
50 REMark     MEMORY  (Simon)
60 REMark 
70 REMark 
80 REMark 
90 REMark -------------------------
140 REMark -------------------------
141 REMark to improve
142 REMark -------------------------
150 MODE 8
160 OPEN #3,scr_512x200a0x0: REMark to improve
170 PAPER #3,0: INK #3,7: CLS #3
190 PAPER #0,0: INK #0,7: CLS #0
200 :
210 DIM seq(30): 
230 :
240 p_TITLE
250 init_game
255 :
260 REMark --------------
261 REMark Main game loop
262 REMark --------------
270 : target = 30
275 CSIZE #3,3,1: AT #3,9,2: PRINT #3,target;
280 FOR round = 1 TO 30
285   CSIZE #3,3,1: AT #3,3,2 : PRINT #3,round;: CSIZE #3,1,0
290   delay = 300 - (round * 8)
300   IF delay < 50 THEN delay = 50
310   add_to_sequence round
320   play_sequence round, delay
325   BLOCK #3,10,10,435,105 ,5
330   ok = get_player_input(round)
335   BLOCK #3,10,10,435,105 ,0
340   IF ok = 0 THEN 
350     game_over
360     EXIT round
370   END IF 
380 END FOR round
390 :
400 IF ok = 1 THEN victory
410 replay = ask_replay
415 IF replay = 1: GO TO 250
418 CLS #0: CLS #3
420 CSIZE #3,3,1: AT #3,5,11 : PRINT #3,"Goodbye!":
425 PAUSE 100
430 CLOSE #3: STOP
440 :
450 :
460 REMark ------------
470 REMark TITLE SCREEN
480 REMark ------------
490 DEFine PROCedure p_TITLE
500   PAPER #3,0: INK #3,4: CLS #3
505   CSIZE #3,3,1: AT #3,1,13 : PRINT #3,"RPUFOS": REMark 32w 2h
510   CSIZE #3,2,0: AT #3,4,9  : PRINT #3,"Retro Programmers United": REMark 42w 1h
515   CSIZE #3,2,0: AT #3,5,11 : PRINT #3,"For Obscure Systems"
520   CSIZE #3,3,1: AT #3,4,9  : PRINT #3,"Game Jam 2026"
525   CSIZE #3,2,1: AT #3,6,18 : PRINT #3,"Memory": REMark 42w 2h
530   CSIZE #3,3,0: AT #3,14,5 : PRINT #3,"A four big pixels game"
535   CSIZE #3,3,0: AT #3,15,9 : PRINT #3,"with beep beep": REMark 32w 1h
540   PAUSE 50: CSIZE #3,2,1: AT #3,9,28: PRINT #3,"Press a key...";
545   dummy=KEYROW(0): PAUSE: p_DING: CLS #3
550 END DEFine p_TITLE
590 :
600 REMark ---------------
610 REMark INITIALISE GAME
620 REMark ---------------
630 DEFine PROCedure init_game
640   CLS #3: CLS #0
645   RANDOMISE DATE
650   draw_board
660   AT #0,2,0 : PRINT #0,"  Use cursor keys to repeat the sequence"
670 END DEFine init_game
690 :
700 REMark ---------
710 REMark THE BOARD
720 REMark ---------
730 DEFine PROCedure draw_board
740   LOCal i
750   INK #3,7: CIRCLE #3,95,50,45: CIRCLE #3,95,50,5
760   INK #3,4: LINE #3,83,90 TO 107,90 TO 107,66 TO 83,66 TO 83,90   : REMark Up square green
770   INK #3,1: LINE #3,83,34 TO 107,34 TO 107,10 TO 83,10 TO 83,34   : REMark Down square blue
780   INK #3,6: LINE #3,55,37 TO 79,37 TO 79,61 TO 55,61 TO 55,37     : REMark Left square yellow
790   INK #3,2: LINE #3,111,37 TO 135,37 TO 135,61 TO 111,61 TO 111,37: REMark Right square red
800   INK #3,5: CIRCLE #3,95,50,46: CIRCLE #3,95,50,6
810   INK #3,0: CURSOR 20,20
820   CURSOR #3,0,0: INK #3,7: PAPER #3,0: CSIZE #3,3,1: AT #3,1,1: PRINT #3,"Round";
830   AT #3,7,1: PRINT #3,"Target";: AT #3,1,25: PRINT #3,"Player";
840   AT #3,3,28: PRINT #3,"Me";: AT #3,5,28: PRINT #3,"You";: CSIZE #3,1,0
850 END DEFine draw_board
860 :
870 :
880 REMark ------------------------------
890 REMark ADD RANDOM ELEMENT TO SEQUENCE
900 REMark ------------------------------
910 DEFine PROCedure add_to_sequence(r)
920   seq(r) = RND(1 TO 4)
930 END DEFine add_to_sequence
940 :
950 :
960 REMark ----------------------------
970 REMark PLAY SEQUENCE (MACHINE TURN)
980 REMark ----------------------------
990 DEFine PROCedure play_sequence(r, d)
1000   LOCal k, w
1005   BLOCK #3,10,10,435,65 ,5
1010   PAUSE 75
1020   FOR k = 1 TO r
1030     light_on seq(k)
1040     snd seq(k), 8
1050     PAUSE d / 10
1060     light_off seq(k)
1070     PAUSE 5
1080   END FOR k
1085   BLOCK #3,10,10,435,65 ,0
1090 END DEFine play_sequence
1100 :
1110 :
1120 REMark --------------------------------
1130 REMark GET PLAYER INPUT
1140 REMark Returns 1 if correct, 0 if wrong
1150 REMark --------------------------------
1160 DEFine FuNction get_player_input(r)
1170   LOCal i, k$, g
1180   FOR i = 1 TO r
1190     REPeat loop
1200       k$ = INKEY$(#0,-1)
1210       g = key_to_dir(k$)
1220       IF g > 0 THEN EXIT loop
1230     END REPeat loop
1240     light_on g
1250     snd g, 5
1260     PAUSE 5
1270     light_off g
1280     IF g <> seq(i) THEN 
1290       RETurn 0
1300     END IF 
1310   END FOR i
1320   RETurn 1
1330 END DEFine get_player_input
1340 :
1350 :
1360 REMark -----------------------------
1370 REMark CONVERT KEYPRESS TO DIRECTION
1380 REMark 1=Up, 2=Down, 3=Left, 4=Right
1390 REMark -----------------------------
1400 DEFine FuNction key_to_dir(k$)
1410   LOCal c
1420   c = CODE(k$)
1430   SELect ON c
1440     = 208 : RETurn 1 : REMark Cursor UP
1450     = 216 : RETurn 2 : REMark Cursor DOWN
1460     = 192 : RETurn 3 : REMark Cursor LEFT
1470     = 200 : RETurn 4 : REMark Cursor RIGHT
1480     = REMAINDER : RETurn 0
1490   END SELect 
1500 END DEFine key_to_dir
1510 :
1520 :
1530 REMark -----------------
1540 REMark LIGHT ON A SQUARE
1550 REMark -----------------
1560 DEFine PROCedure light_on(direction)
1570   SELect ON direction
1580     = 1 : BLOCK #3,60,44,226,22 ,4  : REMark Up    = green
1590     = 2 : BLOCK #3,60,44,226,134,1  : REMark Down  = blue
1600     = 3 : BLOCK #3,60,44,152,80 ,6  : REMark Left  = yellow
1610     = 4 : BLOCK #3,60,44,302,80 ,2  : REMark Right = red
1620   END SELect 
1630 END DEFine light_on
1640 :
1650 :
1660 REMark --------------------------
1670 REMark LIGHT OFF A SQUARE (ERASE)
1680 REMark --------------------------
1690 DEFine PROCedure light_off(direction)
1700   SELect ON direction
1710     = 1 : BLOCK #3,60,44,226,22 ,0
1720     = 2 : BLOCK #3,60,44,226,134,0
1730     = 3 : BLOCK #3,60,44,152,80 ,0
1740     = 4 : BLOCK #3,60,44,302,80 ,0
1750   END SELect 
1760 END DEFine light_off
1770 :
1780 :
1790 REMark ----------
1800 REMark PLAY SOUND
1810 REMark ----------
1820 DEFine PROCedure snd(in, dur)
1830   LOCal x
1840   x=in: REMark need improvment, generate a bug with BEEP
1850   SELect ON x
1860     = 1 : BEEP dur*500,73,0,0,0,0,0,0
1870     = 2 : BEEP dur*500,53,0,0,0,0,0,0
1880     = 3 : BEEP dur*500,33,0,0,0,0,0,0
1890     = 4 : BEEP dur*500,93,0,0,0,0,0,0
1900   END SELect 
1910 END DEFine snd
1920 :
1930 :
1940 REMark ---------
1950 REMark GAME OVER
1960 REMark ---------
1970 DEFine PROCedure game_over
1980   BEEP 20000,20,0,0,0,0,0,0
1990   CLS #0
2000   INK #0,2: CSIZE #0,3,1: AT #0,0,13: PRINT #0,"WRONG!": PAUSE 100: CLS #0
2010   INK #0,7: CSIZE #0,2,0: PRINT #0,"You reached round ";round-1
2020   AT #0,3,14: PRINT #0,"Press any key";
2030   PAUSE
2040 END DEFine game_over
2050 :
2060 :
2070 REMark -------
2080 REMark VICTORY
2090 REMark -------
2100 DEFine PROCedure victory
2110   LOCal i
2120   FOR i = 1 TO 10
2130     BEEP 2000, i*10, 0,0,0,0,0,0
2140   END FOR i
2150   CLS #0
2160   AT #0,0,0 : PRINT #0,"PERFECT! You completed all 30 rounds!"
2170   AT #0,3,14 : PRINT #0,"Press any key";
2180   PAUSE
2190 END DEFine victory
2200 :
2210 :
2220 REMark ----------
2230 REMark ASK REPLAY
2240 REMark ----------
2250 DEFine FuNction ask_replay
2260   LOCal k$
2270   CLS #0
2280   AT #0,1,1 : PRINT #0,"Play again? (Y/N)"
2290   REPeat wait
2300     k$ = INKEY$(#0,-1)
2310     IF k$ == "Y" OR k$ == "y" THEN 
2320       RETURN 1
2470     ELSE IF k$ == "N" OR k$ == "n" THEN 
2480       RETURN 0
2490     END IF 
2500   END REPeat wait
2540 END DEFine ask_replay
2550 :
2600 REMark ---------
2610 REMark Beep beep
2620 REMark ---------
2630 DEFine PROCedure p_DING
2640   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
2650 END DEFine p_DING
