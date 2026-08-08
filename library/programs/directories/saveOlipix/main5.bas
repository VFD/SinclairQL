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
230 cha=3 : REMark channel du jeu
240 p_start cha : p_load_font cha : p_titre cha : REMark Intialisation
250 :
260 dummy=KEYROW(0): RANDOMISE DATE
270 :
280 :
290 :
300 :
310    REPeat menu
320      m=f_menu(cha)
330      IF m=1: p_how_to 3 : k$=f_letter$: p_beep_ding: NEXT menu
340      IF m>1 AND m<6: EXIT menu
350    END REPeat menu
360 :
370    CSIZE #0,3,1: AT #0,1,1: PRINT #0,"  Tu as choisi l'option" ! m ! "!": CSIZE #0,1,0
380    p_beep_ding: dummy=KEYROW(0): PAUSE 50 : CLS #0
390    CLS #cha
400 :
410 : PRINT #0,"J'analyse ton cerveau..."
420    PAPER #2,0: INK #2,0: CLS #2
430 :  DLINE 30000 TO  : REMark bug display on #2
440 :  INK #2,4
450 :
460 : PRINT #0,"Je cherche le mot que tu ne connais pas..."
470  SELect ON m
480    =2: PRINT #0,f_ahah$     : MERGE "vehicles.bas"
490    =3: PRINT #0,f_ahah$     : MERGE "animals.bas"
500    =4: PRINT #0,f_ahah$     : MERGE "jurrassic.bas"
510    =5: PRINT #0,f_ahah$     : MERGE "france.bas"
520    = REMAINDER : PRINT #0,"SYNTAXE ERROR... AI failed": STOP
530  END SELect 
540 : REMark test mot$ = "", retry
550 remark mot$ = f_pickword$ : 
551 : 
552 : repeat mot
553 :   mot$ = f_pickword$
554 :   if mot$ <> "" : exit mot
555 : end repeat mot
556 : 
557 : mot2$ = f_hide_word$ (mot$)
558 : 
559 : 
560 :
570 p_screen 3 : PAUSE 50
580 :
590 : CSIZE #cha,3,1: INK #cha,7
600 : AT #cha,3,(32-LEN(mot$))/2 : PRINT #cha,mot2$
610 : REMark PRINT #0,"le mot...";!mot$:PRINT
620 :
630 : cpt = 0 : k = 0
640 :REPeat cherche
650 :  k$ = f_letter$
660 :  FOR i=1 TO LEN(mot$)
670 :    IF mot$(i) = k$ : mot2$(i) = k$ : k = 1
680 :  END FOR i
690 :  AT #cha,3,(32-LEN(mot$))/2 : PRINT #cha,mot2$
700 :  IF k = 0 : cpt = cpt + 1
710 :  k = 0
720 :  AT #0,0,0: PRINT #0,k$!cpt
730 :  PAUSE 10 : dummy=KEYROW(0)
740 :
750 :  IF cpt = 11 : v=0 : EXIT cherche
760 :  IF mot$ = mot2$ : v = 1 : EXIT cherche
770 END REPeat cherche
780 :
790 : CLS #0:
800 : IF v = 0 THEN 
801 :    CSIZE #0,3,1: AT #0,0,(32-LEN(mot$))/2 : PRINT #0,mot$
802 :    pause
810 :    PRINT #0,"Vous perdez, Olipix est"\"reprogramme en 8 bits."
820 : ELSE 
830 :   CSIZE #0,3,1: PRINT #0," Vous Gagnez, Olipix est libre."
840 : END IF 
850 :
860 :
870 :PAUSE
880 :
890   REPeat again
900     CLS #0: PRINT #0,"    Veux tu rejouer (O,N) ?"
910     r$ = f_letter$
920     IF r$ = "N" : p_reset cha : STOP
930     IF r$ = "O" : EXIT again
940   END REPeat again
950 :
960 IF  r$="O" : GO TO 260 : REMark PB with repeat and when
970 :
980 REMark 
990 :
1000 :
1010 :
1020 STOP
1030 REMark ----------------------------------------
1040 REMark Titre
1050 REMark ----------------------------------------
1060 DEFine PROCedure p_titre (ch)
1070   PAPER #ch,0: INK #ch,4: CLS #ch
1080   CSIZE #ch,3,1: AT #ch,1,12 : PRINT #ch,"RPUFOS"
1090   CSIZE #ch,2,0: AT #ch,5,9  : PRINT #ch,"Retro Programmers United"
1100   CSIZE #ch,2,0: AT #ch,6,11 : PRINT #ch,"For Obscure Systems"
1110   CSIZE #ch,3,1: AT #ch,5,9  : PRINT #ch,"Game Jam 2026"
1120   CSIZE #ch,1,1: AT #ch,7,17 : PRINT #ch,"Le mot que tu ne connais pas"
1130   CSIZE #ch,1,1: AT #ch,8,22 : PRINT #ch,"Un jeu gros pixels"
1140   CSIZE #ch,2,0: AT #ch,20,11: PRINT #ch,"Tabasse une touche..."
1150   dummy=KEYROW(0): PAUSE: p_beep_ding: CLS #ch
1160 END DEFine p_titre
1170 :
1180 :
1190 REMark ----------------------------------------
1200 REMark Menu pour les mots
1210 REMark   ch: chanel
1220 REMark ----------------------------------------
1230 DEFine FuNction f_menu (ch)
1240   LOCal k, k$, x
1250   PAPER #ch,0: INK #ch,4: CLS #ch
1260   CSIZE #ch,3,1: AT #ch,1,1: PRINT #ch,"Fait ton choix humain !"
1270   RESTORE 1370
1280   k$="": x=1: CSIZE #ch,2,1
1290   READ m$
1300   IF m$<>"END": AT #ch,x+2,4: PRINT #ch,x ! "-" ! m$: x=x+1: GO TO 1290
1310   x=x-1
1320   dummy=KEYROW(0): k$=INKEY$(-1)
1330   REMark print #0,"touche ";k$
1340   IF k$<"1" OR k$>CHR$(48+x): p_beep_echec: GO TO 1320
1350   k=k$-"0": REMark k=CODE(k$)-48
1360   p_beep_ding
1370   DATA "Quo vadis ?","Vehiculux","Animalux","Dinosaurux","Empirus Gaulux","END"
1380   RETurn k
1390 END DEFine f_menu
1400 :
1410 :
1420 REMark ----------------------------------------
1430 REMark Beep Failed
1440 REMark ----------------------------------------
1450 DEFine PROCedure p_beep_echec
1460   BEEP 2000, 80, 80, 0, 0, 0, 4, 0: BEEP 3000, 150, 150, 0, 0, 0, 6, 0
1470 END DEFine p_beep_echec
1480 :
1490 :
1500 REMark ----------------------------------------
1510 REMark Beep beep
1520 REMark ----------------------------------------
1530 DEFine PROCedure p_beep_ding
1540   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
1550 END DEFine p_beep_ding
1560 :
1570 :
1580 REMark ----------------------------------------
1590 REMark Explications du jeu (char bug because of font)
1600 REMark   ch: channel
1610 REMark ----------------------------------------
1620 DEFine PROCedure p_how_to (ch)
1630   PAPER #ch,0: INK #ch,4: CLS #ch
1640   CSIZE #ch,3,1: AT #ch,1,12: PRINT #ch,"HOW TO"
1650   CSIZE #ch,0,0: AT #ch,5,1: PRINT #ch,"Humain ta mission est de sauvez Olipix de la tr";CHR$(144);"s tr";CHR$(144);"s mechante IA qui veut"
1660   PRINT #ch," reprogrammer son cerveau (en mode 8 bits neurones)."
1670   PRINT #ch,\" Elle analyse le tien pour choisir un mot  que tu connais pas."
1680   PRINT #ch,\" Balance lui les lettres pour..."
1690   CSIZE #ch,3,1: AT #ch,6,9: PRINT #ch,"...l'an";CHR$(131);"antir."
1700   CSIZE #ch,0,0: AT #ch,17,1: PRINT #ch,"Oui, oui, car il parait que les IA c'est vachement beaucoup tr";CHR$(144);"s m";CHR$(131);"chante pour"
1710   PRINT #ch," les  humains."
1720   CSIZE #ch,3,1: AT #ch,11,11: PRINT #ch,"Lance une lettre..."
1730   dummy=KEYROW(0): REMark PAUSE
1740 END DEFine p_how_to
1750 :
1760 :
1770 :
1780 REMark ----------------------------------------
1790 REMark Renvois la lettre A-Z si tabassee
1800 REMark ----------------------------------------
1810 DEFine FuNction f_letter$
1820   LOCal l$, C
1830   :
1840   dummy=KEYROW(0): l$=INKEY$(-1)
1850   IF l$="": GO TO 1830 : REMark need avoid goto
1860   C=CODE(l$)
1870   REMark Convertion a-z vers A-Z
1880   IF C>=97 AND C<=122: C=C-32
1890   REMark Refaire si pas A-Z
1900   IF C<65 OR C>90: p_beep_echec: GO TO 1830: REMark need avoid goto
1910   :
1920   l$=CHR$(C)
1930   dummy=KEYROW(0): RETurn l$
1940 END DEFine f_letter$
1950 :
1960 :
1970 REMark ----------------------------------------
1980 REMark Ecran de jeu
1990 REMark ----------------------------------------
2000 DEFine PROCedure p_screen (ch)
2010   PAPER #ch,0: INK #ch,3 : CLS #ch
2020   CSIZE #ch,1,0 : CHAR_INC #ch,8,9 : OVER #ch,1 :
2030   AT #ch, 4,0 : PRINT #ch,FILL$(CHR$(197),64);
2040   AT #ch,21,0 : PRINT #ch,FILL$(CHR$(197),64);
2050 : x0=5: y0=1 : INK #ch,7
2060 : REPeat loop
2070 :   AT #ch,x0,y0: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0: PRINT #ch,CHR$(206)
2080 :   AT #ch,x0,y0+61: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0+61: PRINT #ch,CHR$(206)
2090 :   x0=x0+2
2100 :   IF x0=21 THEN EXIT loop
2110 : END REPeat loop
2120 : AT #ch,3,1: PRINT #ch,CHR$(245)&CHR$(246);
2130 : AT #ch,0,0: PRINT #ch,CHR$(247)&CHR$(248);
2140 : AT #ch,3,60: PRINT #ch,CHR$(249)&CHR$(250)&CHR$(251);
2150 :
2160 : CSIZE #ch,3,1
2170 : CURSOR #ch,90,10: PRINT #ch,"Trouve le mot inconnu": REMark position x,y
2180 : CSIZE #ch,1,0
2190 :
2200 : CHAR_INC #ch,8,10 : OVER #ch,0 :
2210 END DEFine p_screen
2220 :
2230 REMark ----------------------------------------
2240 REMark Initialise window game
2250 REMark   ch: channel for the game
2260 REMark ----------------------------------------
2270 DEFine PROCedure p_start (ch)
2280   MODE 4
2290   OPEN #ch,scr_
2300   WINDOW #ch,512,256, 0,0: SCALE #ch,256, 0,0
2310   CSIZE #ch, 1,0 : REMark basic size for font 8x9
2320   PAPER #ch,0 : CLS #ch
2330 END DEFine p_start
2340 :
2350 REMark ----------------------------------------
2360 REMark load font
2370 REMark   ch: channel for the font
2380 REMark ----------------------------------------
2390 DEFine PROCedure p_load_font (ch)
2400   LOCal fst, lst, num, base
2410   fst = 192 : lst = 255      : REMark need improvment
2420   num = ((lst-fst+1)*9)+2    : PRINT #0,"size: ";num
2430   base = ALCHP(num)
2440   CLS #0: PRINT #0,"Loading font..."
2450   LBYTES "rpufos.fnt", base
2460   CHAR_USE #ch, 0, base      : REMark used as secondary
2470   PRINT #0,"Font loaded..."
2480 END DEFine p_load_font
2490 :
2500 REMark ---------------------------
2510 REMark REMark reset default values
2520 REMark ch: channel
2530 REMark ---------------------------
2540 DEFine PROCedure p_std_char (ch)
2550   CHAR_INC #ch,8,10 : OVER #ch,0:
2560 END DEFine p_std_char
2570 :
2580 REMark -----------------
2590 REMark set char size
2600 REMark ch: channel
2610 REMark x:  x size
2620 REMark y:  y size
2630 REMark o:  over (1 or 0)
2640 REMark -----------------
2650 DEFine PROCedure p_set_char (ch, cx, cy, o)
2660   CHAR_INC #ch,cx,cy : OVER #ch,o :
2670 END DEFine p_set_char
2680 :
2690 REMark ----------------------------------------
2700 REMark 
2710 REMark ----------------------------------------
2720 DEFine PROCedure p_show_word (ch,word$)
2730   LOCal i
2740 : CSIZE #ch,3,1
2750 : CURSOR #ch,50,10
2760 : PRINT #ch,word$
2770 :
2780 :
2790 :CSIZE #ch,1,0
2800 END DEFine p_show_word
2810 :
2820 REMark ----------------------------------------
2830 REMark RESET
2840 REMark ----------------------------------------
2850 DEFine PROCedure p_reset (ch)
2860   CLOSE #ch
2870   :
2880   :
2890   :
2900   :
2910   CLS #0: CLS #1: CLS #2
2920 END DEFine p_reset
2930 REMark ----------------------------------------
2940 REMark replace with "_"
2950 REMark ----------------------------------------
2960 DEFine FuNction f_hide_word$ (word$)
2970   LOCal i, w$
2980   w$ = ""
2990   FOR i=1 TO LEN(word$)
3000     IF word$(i) = " " THEN 
3010       w$ = w$ & " "
3020     ELSE 
3030       w$= w$ & "_"
3040     END IF 
3050   END FOR i
3060   RETurn w$
3070 END DEFine f_build_word$
3080 :
3090 :
3100 REMark ----------------------------------------
3110 REMark ah ah
3120 REMark ----------------------------------------
3130 define FuNction f_ahah$
3140   local i,j, m$
3150   RANDOMISE date : y = RND(1 TO 4)
3160   restore 3180
3170   for i = 1 to y : read m$ : next i
3180   return m$
3190 DATA "Ah! Ah!","mmmmm......",":-) nice ...","ouh ! ouh ! "
3200 end define f_ahah$
3210 :
30000 : REMark if not exist the program bug
