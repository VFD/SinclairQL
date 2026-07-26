10 REMark ----------------------------------------
20 REMark   RPUFOS GAME JAM 2026 on Sinclair QL
30 REMark ----------------------------------------
40 REMark Un petit jeu de pendu tout simple pour
50 REMark montrer le fonctionnement du SuperBasic
60 REMark ----------------------------------------
70 REMark Utilise :
80 REMark DLINE, MERGE, RESTORE n
90 REMark ----------------------------------------
100 REMark ----------------------------------------
110 REMark Jeu du pendu revisite
120 REMark ----------------------------------------
130 INIT
140 c=MENU
150 IF c=1: HOWTO: k$=LETTER$: DING: GO TO 140
160 :
170 :
200 CLS #4: CSIZE #4,3,1: AT #4,1,1: PRINT #4,"Tu as choisi l'option" ! c ! "!": DING: dummy=KEYROW(0): PAUSE
205 :
210 ECRAN: PAUSE
220 :
230 :
499 STOP
500 REMark ----------------------------------------
510 REMark Delete lines et merge
520 REMark ----------------------------------------
530 DLINE 10000 TO
540 ON c GOTO 550, 560, 570, 580
550 REMark MERGE "": GOTO 590
560 REMark MERGE "": GOTO 590
570 REMark MERGE "": GOTO 590
580 REMark MERGE "": GOTO 590
590 RETURN
700 :
800 :
900 :
999 STOP
1000 REMark ----------------------------------------
1010 REMark Initialisation
1020 REMark ----------------------------------------
1030 DEFine PROCedure INIT
1040   MODE 4: OPEN #4,con_512x256a0x0
1050   PAPER #4,0: INK #4,4: CLS #4
1060   CSIZE #4,3,1: AT #4,1,12 : PRINT #4,"RPUFOS"
1070   CSIZE #4,2,0: AT #4,5,9  : PRINT #4,"Retro Programmers United"
1080   CSIZE #4,2,0: AT #4,6,11 : PRINT #4,"For Obscure Systems"
1090   CSIZE #4,3,1: AT #4,5,9  : PRINT #4,"Game Jam 2026"
1100   CSIZE #4,1,1: AT #4,7,17 : PRINT #4,"Le mot que tu ne connais pas"
1110   CSIZE #4,1,1: AT #4,8,22 : PRINT #4,"Un jeu gros pixels"
1120   CSIZE #4,2,0: AT #4,20,11: PRINT #4,"Tabasse une touche..."
1130   dummy=KEYROW(0): PAUSE: DING: CLS #4
1140 END DEFine INIT
1180 :
1190 :
1200 REMark ----------------------------------------
1210 REMark Menu pour le choix des mots
1220 REMark ----------------------------------------
1230 DEFine FuNction MENU
1240   LOCAL k, k$, x
1250   PAPER #4,0: INK #4,4: CLS #4
1260   CSIZE #4,3,1: AT #4,1,1: PRINT #4,"Fait ton choix humain !"
1270   RESTORE 1500
1280   k$="": x=1: CSIZE #4,2,1
1290   READ m$
1300   IF m$<>"END": AT #4,x+2,4: PRINT #4,x ! "-" ! m$: x=x+1: GO TO 1290
1310   x=x-1
1320   dummy=KEYROW(0): k$=INKEY$(-1)
1330   IF k$<"1" OR k$>CHR$(48+x): ECHEC: GO TO 1320 
1340   k=k$-"0": REMark k=CODE(k$)-48
1490   DING
1500   DATA "Quo vadis ?","Vehiculux","Animalux","Dinosaurux","Empirus Gaulux","END"
1598   RETurn k
1599 END DEFine MENU
1780 :
1790 :
1800 REMark ----------------------------------------
1810 REMark Rate
1820 REMark ----------------------------------------
1830 DEFine PROCedure ECHEC
1840   BEEP 2000, 80, 80, 0, 0, 0, 4, 0: BEEP 3000, 150, 150, 0, 0, 0, 6, 0
1850 END DEFine ECHEC
1880 :
1890 :
1900 REMark ----------------------------------------
1910 REMark Beep beep
1920 REMark ----------------------------------------
1930 DEFine PROCedure DING
1940   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
1950 END DEFine DING
1980 :
1990 :
2000 REMark ----------------------------------------
2010 REMark Explications du jeu
2030 REMark ----------------------------------------
2040 DEFine PROCedure HOWTO
2050   PAPER #4,0: INK #4,4: CLS #4
2060   CSIZE #4,3,1: AT #4,1,12: PRINT #4,"HOW TO"
2070   CSIZE #4,0,0: AT #4,5,1: PRINT #4,"Humain ta mission est de sauvez Olipix de la tr";CHR$(144);"s tr";CHR$(144);"s mechante IA qui veut"
2080   PRINT #4," reprogrammer son cerveau (en mode 8 bits neurones)."
2090   PRINT #4,\" Elle analyse le tien pour choisir un mot  que tu connais pas."
2100   PRINT #4,\" Balance lui les lettres pour..."
2110   CSIZE #4,3,1: AT #4,6,9: PRINT #4,"...l'an";CHR$(131);"antir."
2120   CSIZE #4,0,0: AT #4,17,1: PRINT #4,"Oui, oui, car il parait que les IA c'est vachement beaucoup tr";CHR$(144);"s m";CHR$(131);"chante pour"
2130   PRINT #4," les  humains."
2140   CSIZE #4,3,1: AT #4,11,11: PRINT #4,"Lance une lettre..."
2150   dummy=KEYROW(0): REMark PAUSE
2160 END DEFine HOWTO
2170 :
2180 :
2190 :
2200 REMark ----------------------------------------
2210 REMark Renvois la lettre A-Z si tabassee
2220 REMark ----------------------------------------
2230 DEFine FuNction LETTER$
2240   LOCAL l$, c
2250   dummy=KEYROW(0): l$=INKEY$(-1)
2260   IF l$="": GO TO 2250
2270   c=CODE(l$)
2280   REMark Convertion a-z vers A-Z 
2290   IF c>=97 AND c<=122: c=c-32
2300   REMark Refaire si pas A-Z
2310   IF c<65 OR c>90: ECHEC: GO TO 2250
2320   l$=CHR$(c)
2330   dummy=KEYROW(0): RETurn l$
2340 END DEFine LETTER$
2380 :
2390 :
2400 REMark ----------------------------------------
2410 REMark Ecran de jeu - to do
2420 REMark ----------------------------------------
2430 DEFine PROCedure ECRAN
2440   CLS#4
2450   CSIZE #4,3,1: AT #4,1,10: PRINT #4,"The Game": DING
2600 :
2699 END DEFine ECRAN
3000 :
3010 :
3020 :
