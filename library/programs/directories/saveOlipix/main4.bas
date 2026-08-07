100 REMark ----------------------------------------
110 REMark p_start      : initialise le QL
120 REMark p_titre      : affiche le titre RPUFOS
130 REMark f_menu       : affiche le menu, renvoie le choix
140 REMark p_how_to     : affiche l'explication
150 REMark p_screen     : dessine l'ecran du jeu
160 REMark p_beep_ding  : fait ding
170 REMark p_beep_echec : fait beep echec
180 REMark f_letter$    : retourne la lettre choisie
190 REMark p_load_font  : charge la fonte rpufos
200 REMark ----------------------------------------
210 REMark START
220 REMark ----------------------------------------
230 C=3 : REMark channel du jeu
240 p_start C : p_load_font C : p_titre C : REMark Intialisation
250 :
260 : REMark boucle principal
270 : REMark Repeat boucle
280 :
290 :
300 m=f_menu(C)
310 REMark IF c=1: p_how_to: k$=f_letter$: p_beep_ding: GO TO 320
320 :
330 :
340 CSIZE #0,3,1: AT #0,1,1: PRINT #0,"  Tu as choisi l'option" ! m ! "!":
350 p_beep_ding: dummy=KEYROW(0): PAUSE
360 CSIZE #0,1,0
370 :
380 :
390 :
400 :
410 :
420 :
430 :
440 :
450 p_screen 3 : PAUSE
460 :
470 :
480 STOP
490 REMark ----------------------------------------
500 REMark Delete lines et merge
510 REMark ----------------------------------------
520 DLINE 10000 TO
530 ON C GO TO 540, 550, 560, 570
540 REMark MERGE "": GOTO 590
550 REMark MERGE "": GOTO 590
560 REMark MERGE "": GOTO 590
570 REMark MERGE "": GOTO 590
580 RETurn 
590 :
600 :
610 :
620 STOP
630 REMark ----------------------------------------
640 REMark Titre
650 REMark ----------------------------------------
660 DEFine PROCedure p_titre (ch)
670   PAPER #ch,0: INK #ch,4: CLS #ch
680   CSIZE #ch,3,1: AT #ch,1,12 : PRINT #ch,"RPUFOS"
690   CSIZE #ch,2,0: AT #ch,5,9  : PRINT #ch,"Retro Programmers United"
700   CSIZE #ch,2,0: AT #ch,6,11 : PRINT #ch,"For Obscure Systems"
710   CSIZE #ch,3,1: AT #ch,5,9  : PRINT #ch,"Game Jam 2026"
720   CSIZE #ch,1,1: AT #ch,7,17 : PRINT #ch,"Le mot que tu ne connais pas"
730   CSIZE #ch,1,1: AT #ch,8,22 : PRINT #ch,"Un jeu gros pixels"
740   CSIZE #ch,2,0: AT #ch,20,11: PRINT #ch,"Tabasse une touche..."
750   dummy=KEYROW(0): PAUSE: p_beep_ding: CLS #ch
760 END DEFine p_titre
770 :
780 :
790 REMark ----------------------------------------
800 REMark Menu pour les mots
810 REMark   ch: chanel
820 REMark ----------------------------------------
830 DEFine FuNction f_menu (ch)
840   LOCal k, k$, x
850   PAPER #ch,0: INK #ch,4: CLS #ch
860   CSIZE #ch,3,1: AT #ch,1,1: PRINT #ch,"Fait ton choix humain !"
870   RESTORE 970
880   k$="": x=1: CSIZE #ch,2,1
890   READ m$
900   IF m$<>"END": AT #ch,x+2,4: PRINT #ch,x ! "-" ! m$: x=x+1: GO TO 890
910   x=x-1
920   dummy=KEYROW(0): k$=INKEY$(-1)
930   REMark print #0,"touche ";k$
940   IF k$<"1" OR k$>CHR$(48+x): p_beep_echec: GO TO 920
950   k=k$-"0": REMark k=CODE(k$)-48
960   p_beep_ding
970   DATA "Quo vadis ?","Vehiculux","Animalux","Dinosaurux","Empirus Gaulux","END"
980   RETurn k
990 END DEFine f_menu
1000 :
1010 :
1020 REMark ----------------------------------------
1030 REMark Rate
1040 REMark ----------------------------------------
1050 DEFine PROCedure p_beep_echec
1060   BEEP 2000, 80, 80, 0, 0, 0, 4, 0: BEEP 3000, 150, 150, 0, 0, 0, 6, 0
1070 END DEFine p_beep_echec
1080 :
1090 :
1100 REMark ----------------------------------------
1110 REMark Beep beep
1120 REMark ----------------------------------------
1130 DEFine PROCedure p_beep_ding
1140   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
1150 END DEFine p_beep_ding
1160 :
1170 :
1180 REMark ----------------------------------------
1190 REMark Explications du jeu
1200 REMark   ch: channel
1210 REMark ----------------------------------------
1220 DEFine PROCedure p_how_to (ch)
1230   PAPER #ch,0: INK #ch,4: CLS #ch
1240   CSIZE #ch,3,1: AT #ch,1,12: PRINT #ch,"HOW TO"
1250   CSIZE #ch,0,0: AT #ch,5,1: PRINT #ch,"Humain ta mission est de sauvez Olipix de la tr";CHR$(144);"s tr";CHR$(144);"s mechante IA qui veut"
1260   PRINT #ch," reprogrammer son cerveau (en mode 8 bits neurones)."
1270   PRINT #ch,\" Elle analyse le tien pour choisir un mot  que tu connais pas."
1280   PRINT #ch,\" Balance lui les lettres pour..."
1290   CSIZE #ch,3,1: AT #ch,6,9: PRINT #ch,"...l'an";CHR$(131);"antir."
1300   CSIZE #ch,0,0: AT #ch,17,1: PRINT #ch,"Oui, oui, car il parait que les IA c'est vachement beaucoup tr";CHR$(144);"s m";CHR$(131);"chante pour"
1310   PRINT #ch," les  humains."
1320   CSIZE #ch,3,1: AT #ch,11,11: PRINT #ch,"Lance une lettre..."
1330   dummy=KEYROW(0): REMark PAUSE
1340 END DEFine p_how_to
1350 :
1360 :
1370 :
1380 REMark ----------------------------------------
1390 REMark Renvois la lettre A-Z si tabassee
1400 REMark ----------------------------------------
1410 DEFine FuNction f_letter$
1420   LOCal l$, C
1430   dummy=KEYROW(0): l$=INKEY$(-1)
1440   IF l$="": GO TO 1430 : REMark need avoid goto
1450   C=CODE(l$)
1460   REMark Convertion a-z vers A-Z
1470   IF C>=97 AND C<=122: C=C-32
1480   REMark Refaire si pas A-Z
1490   IF C<65 OR C>90: ECHEC: GO TO 1430
1500   l$=CHR$(C)
1510   dummy=KEYROW(0): RETurn l$
1520 END DEFine f_letter$
1530 :
1540 :
1550 REMark ----------------------------------------
1560 REMark Ecran de jeu
1570 REMark ----------------------------------------
1580 DEFine PROCedure p_screen (ch)
1590   PAPER #ch,0: INK #ch,3 : CLS #ch
1600   CSIZE #ch,1,0 : CHAR_INC #ch,8,9 : OVER #ch,1 :
1610   AT #ch, 4,0 : PRINT #ch,FILL$(CHR$(197),64);
1620   AT #ch,21,0 : PRINT #ch,FILL$(CHR$(197),64);
1630 : x0=5: y0=1 : INK #ch,7
1640 : REPeat loop
1650 :   AT #ch,x0,y0: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0: PRINT #ch,CHR$(206)
1660 :   AT #ch,x0,y0+61: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0+61: PRINT #ch,CHR$(206)
1670 :   x0=x0+2
1680 :   IF x0=21 THEN EXIT loop
1690 : END REPeat loop
1700 : AT #ch,3,0: PRINT #ch,CHR$(245)&CHR$(246);
1710 : AT #ch,0,0: PRINT #ch,CHR$(247)&CHR$(248);
1720 : AT #ch,3,60: PRINT #ch,CHR$(249)&CHR$(250)&CHR$(251); : REMark bug sur 251!
1730 :
1740 : CSIZE #ch,3,1
1750 : CURSOR #ch,90,10: PRINT #ch,"Trouve le mot inconnu": REMark position x,y
1760 : CSIZE #ch,1,0
1770 :
1780 : CHAR_INC #ch,8,10 : OVER #ch,0 :
1790 END DEFine p_screen
1800 :
1810 REMark ----------------------------------------
1820 REMark Initialise window game
1830 REMark   ch: channel for the game
1840 REMark ----------------------------------------
1850 DEFine PROCedure p_start (ch)
1860   MODE 4
1870   OPEN #ch,scr_
1880   WINDOW #ch,512,256, 0,0: SCALE #3,256, 0,0
1890   CSIZE #ch, 1,0 : REMark basic size for font
1900   PAPER #ch,0 : CLS #ch
1910 END DEFine p_start
1920 :
1930 REMark ----------------------------------------
1940 REMark load font
1950 REMark   ch: channel for the font
1960 REMark ----------------------------------------
1970 DEFine PROCedure p_load_font (ch)
1980   LOCal fst, lst, num, base
1990   fst = 192 : lst = 246
2000   num = ((lst-fst+1)*9)+2
2010   base = ALCHP(num)
2020   CLS #0: PRINT #0,"Loading font..."
2030   LBYTES "rpufos.fnt", base
2040   CHAR_USE #ch, 0, base
2045   print #0,"Font loaded..."
2050 END DEFine p_load_font
2060 :
2070 REMark ---------------------------
2080 REMark REMark reset default values
2090 REMark ch: channel
2100 REMark ---------------------------
2110 DEFine PROCedure p_std_char (ch)
2120   CHAR_INC #ch,8,10 : OVER #ch,0:
2130 END DEFine p_std_char
2140 :
2150 REMark -----------------
2160 REMark set char size
2170 REMark ch: channel
2180 REMark x:  x size
2190 REMark y:  y size
2200 REMark o:  over (1 or 0)
2210 REMark -----------------
2220 DEFine PROCedure p_set_char (ch, cx, cy, o)
2230   CHAR_INC #ch,cx,cy : OVER #ch,o :
2240 END DEFine p_set_char
2250 :
2260 REMark 
2270 REMark 
2280 REMark 
2290 DEFine PROCedure p_show_word (ch,word$)
2300   LOCal i
2310 : CSIZE #ch,3,1
2320 : CURSOR #ch,50,10
2330 : PRINT #ch,word$
2340 :
2350 :
2360 :CSIZE #ch,1,0
2370 END DEFine p_show_word
