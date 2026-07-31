100 REMark -------------------------
110 REMark   RPUFOS GAME JAM 2026
120 REMark     for Sinclair QL
130 REMark -------------------------
140 REMark     MEMORY  (Simon)
150 REMark 
160 REMark 
170 REMark 
180 REMark -------------------------
190 REMark -------------------------
200 REMark to improve
210 REMark -------------------------
220 MODE 8
230 OPEN #3,scr_512x256a0x0: REMark superposition
240 PAPER #3,0: INK #3,7: CLS #3: REMark clear
250 PAPER #0,0: INK #0,7: CLS #0: REMark clear
260 :
270 DIM seq(30):
280 :
290 p_TITLE
300 :
310 :MERGE p_rpufos_logo:
320 :
330 :CSIZE #3,2,1: AT #3,9,28: PRINT #3,"Press a key...";
340 :dummy=KEYROW(0): PAUSE: p_DING: CLS #3
370 :
375 :
380 :
385 :
390 init_game
400 :
410 REMark --------------
420 REMark Main game loop
430 REMark --------------
440 : target = 30
450 CSIZE #3,3,1: AT #3,1,29: PRINT #3,target;
460 FOR round = 1 TO 30
470   CSIZE #3,3,1: AT #3,1,7 : PRINT #3,round;: CSIZE #3,1,0
480   delay = 300 - (round * 8)
490   IF delay < 50 THEN delay = 50
500   add_to_sequence round
510   play_sequence round, delay
520   BLOCK #3,10,10,435,165 ,5
530   ok = get_player_input(round)
540   BLOCK #3,10,10,435,165 ,0
550   IF ok = 0 THEN 
560     game_over
570     EXIT round
580   END IF 
590 END FOR round
600 :
610 IF ok = 1 THEN victory
620 replay = ask_replay
630 IF replay = 1: GO TO 390
640 CLS #0: CLS #3
650 CSIZE #3,3,1: AT #3,5,11 : PRINT #3,"Goodbye!":
660 PAUSE 100
670 CLOSE #3: STOP
680 :
690 :
700 REMark ------------
710 REMark TITLE SCREEN
720 REMark ------------
730 DEFine PROCedure p_TITLE
740   PAPER #3,0: INK #3,4: CLS #3
750   CSIZE #3,3,1: AT #3,1,13 : PRINT #3,"RPUFOS": REMark 32w 2h
760   CSIZE #3,2,0: AT #3,4,9  : PRINT #3,"Retro Programmers United": REMark 42w 1h
770   CSIZE #3,2,0: AT #3,5,11 : PRINT #3,"For Obscure Systems"
780   CSIZE #3,3,1: AT #3,4,9  : PRINT #3,"Game Jam 2026"
790   CSIZE #3,2,1: AT #3,6,18 : PRINT #3,"Memory": REMark 42w 2h
800   CSIZE #3,3,0: AT #3,14,5 : PRINT #3,"A four big pixels game"
810   CSIZE #3,3,0: AT #3,15,9 : PRINT #3,"with beep beep": REMark 32w 1h
820   PAUSE 50: CSIZE #3,2,1: AT #3,9,28: PRINT #3,"Loading...";
830   REMark dummy=KEYROW(0): PAUSE: p_DING: CLS #3
840 END DEFine p_TITLE
850 :
860 REMark ---------------
870 REMark INITIALISE GAME
880 REMark ---------------
890 DEFine PROCedure init_game
900   CLS #3: CLS #0
910   RANDOMISE DATE
920   draw_board
930   AT #0,2,0 : PRINT #0,"  Use cursor keys to repeat the sequence"
940 END DEFine init_game
950 :
960 REMark ---------
970 REMark THE BOARD
980 REMark ---------
990 DEFine PROCedure draw_board
1000   LOCal i
1010   : INK #3,7: CSIZE #3,3,1: AT #3,5,13: PRINT #3,"RPUFOS"
1020   REMark full screen mode 8 f=128 xmax=190 
1030   p_put_logo 8,  74,81, 4, 128: REMark  green
1040   p_put_logo 8,  29,54, 6, 128: REMark  blue
1050   p_put_logo 8,  74,27, 1, 128: REMark  yellow
1060   p_put_logo 8, 119,54, 2, 128: REMark  red
1070   :
1080   CURSOR #3,0,0: INK #3,7: PAPER #3,0: CSIZE #3,3,1: AT #3,1,1: PRINT #3,"Round";
1090   AT #3,1,22: PRINT #3,"Target";: REMark AT #3,1,25: PRINT #3,"Player";
1100   AT #3,8,1: PRINT #3,"Me";: AT #3,8,28: PRINT #3,"You";: CSIZE #3,1,0
1110 END DEFine draw_board
1120 :
1130 :
1140 REMark ------------------------------
1150 REMark ADD RANDOM ELEMENT TO SEQUENCE
1160 REMark ------------------------------
1170 DEFine PROCedure add_to_sequence(r)
1180   seq(r) = RND(1 TO 4)
1190 END DEFine add_to_sequence
1200 :
1210 :
1220 REMark ----------------------------
1230 REMark PLAY SEQUENCE (MACHINE TURN)
1240 REMark ----------------------------
1250 DEFine PROCedure play_sequence(r, d)
1260   LOCal k, w
1270   BLOCK #3,10,10,55,165 ,5
1280   PAUSE 75
1290   FOR k = 1 TO r
1300     light_on seq(k)
1310     snd seq(k), 8
1320     PAUSE d / 10
1330     light_off seq(k)
1340     PAUSE 5
1350   END FOR k
1360   BLOCK #3,10,10,55,165 ,0
1370 END DEFine play_sequence
1380 :
1390 :
1400 REMark --------------------------------
1410 REMark GET PLAYER INPUT
1420 REMark Returns 1 if correct, 0 if wrong
1430 REMark --------------------------------
1440 DEFine FuNction get_player_input(r)
1450   LOCal i, k$, g
1460   FOR i = 1 TO r
1470     REPeat loop
1480       k$ = INKEY$(#0,-1)
1490       g = key_to_dir(k$)
1500       IF g > 0 THEN EXIT loop
1510     END REPeat loop
1520     light_on g
1530     snd g, 5
1540     PAUSE 5
1550     light_off g
1560     IF g <> seq(i) THEN 
1570       RETurn 0
1580     END IF 
1590   END FOR i
1600   RETurn 1
1610 END DEFine get_player_input
1620 :
1630 :
1640 REMark -----------------------------
1650 REMark CONVERT KEYPRESS TO DIRECTION
1660 REMark 1=Up, 2=Down, 3=Left, 4=Right
1670 REMark -----------------------------
1680 DEFine FuNction key_to_dir(k$)
1690   LOCal c
1700   c = CODE(k$)
1710   SELect ON c
1720     = 208 : RETurn 1 : REMark Cursor UP
1730     = 216 : RETurn 2 : REMark Cursor DOWN
1740     = 192 : RETurn 3 : REMark Cursor LEFT
1750     = 200 : RETurn 4 : REMark Cursor RIGHT
1760     = REMAINDER : RETurn 0
1770   END SELect 
1780 END DEFine key_to_dir
1790 :
1800 :
1810 REMark -----------------
1820 REMark LIGHT ON A SQUARE
1830 REMark -----------------
1840 DEFine PROCedure light_on(direction)
1850   SELect ON direction
1860     = 1 : BLOCK #3,44,30,232,40 ,4  : REMark Up    = green
1870     = 2 : BLOCK #3,44,30,232,146,1  : REMark Down  = blue
1880     = 3 : BLOCK #3,44,30,111,93 ,6  : REMark Left  = yellow
1890     = 4 : BLOCK #3,44,30,355,93 ,2  : REMark Right = red
1900   END SELect 
1910 END DEFine light_on
1920 :
1930 :
1940 REMark --------------------------
1950 REMark LIGHT OFF A SQUARE (ERASE)
1960 REMark --------------------------
1970 DEFine PROCedure light_off(direction)
1980   SELect ON direction
1990     = 1 : BLOCK #3,44,30,232,40 ,0
2000     = 2 : BLOCK #3,44,30,232,146,0
2010     = 3 : BLOCK #3,44,30,111,93 ,0
2020     = 4 : BLOCK #3,44,30,355,93 ,0
2030   END SELect 
2040 END DEFine light_off
2050 :
2060 :
2070 REMark ----------
2080 REMark PLAY SOUND
2090 REMark ----------
2100 DEFine PROCedure snd(in, dur)
2110   LOCal x
2120   x=in: REMark need improvment, generate a bug with BEEP
2130   SELect ON x
2140     = 1 : BEEP dur*500,73,0,0,0,0,0,0
2150     = 2 : BEEP dur*500,53,0,0,0,0,0,0
2160     = 3 : BEEP dur*500,33,0,0,0,0,0,0
2170     = 4 : BEEP dur*500,93,0,0,0,0,0,0
2180   END SELect 
2190 END DEFine snd
2200 :
2210 :
2220 REMark ---------
2230 REMark GAME OVER
2240 REMark ---------
2250 DEFine PROCedure game_over
2260   BEEP 20000,20,0,0,0,0,0,0
2270   CLS #0
2280   INK #0,2: CSIZE #0,3,1: AT #0,0,13: PRINT #0,"WRONG!": PAUSE 100: CLS #0
2290   INK #0,7: CSIZE #0,2,0: PRINT #0,"You reached round ";round-1
2300   AT #0,3,14: PRINT #0,"Press any key";
2310   PAUSE
2320 END DEFine game_over
2330 :
2340 :
2350 REMark -------
2360 REMark VICTORY
2370 REMark -------
2380 DEFine PROCedure victory
2390   LOCal i
2400   FOR i = 1 TO 10
2410     BEEP 2000, i*10, 0,0,0,0,0,0
2420   END FOR i
2430   CLS #0
2440   AT #0,0,0 : PRINT #0,"PERFECT! You completed all 30 rounds!"
2450   AT #0,3,14 : PRINT #0,"Press any key";
2460   PAUSE
2470 END DEFine victory
2480 :
2490 :
2500 REMark ----------
2510 REMark ASK REPLAY
2520 REMark ----------
2530 DEFine FuNction ask_replay
2540   LOCal k$
2550   CLS #0
2560   AT #0,1,1 : PRINT #0,"Play again? (Y/N)"
2570   REPeat wait
2580     k$ = INKEY$(#0,-1)
2590     IF k$ == "Y" OR k$ == "y" THEN 
2600       RETurn 1
2610     ELSE IF k$ == "N" OR k$ == "n" THEN 
2620       RETurn 0
2630     END IF 
2640   END REPeat wait
2650 END DEFine ask_replay
2660 :
2670 REMark ---------
2680 REMark Beep beep
2690 REMark ---------
2700 DEFine PROCedure p_DING
2710   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
2720 END DEFine p_DING
