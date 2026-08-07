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
310 :
320 :
330 :
340    REPeat menu
350      m=f_menu(cha)
360      IF m=1: p_how_to 3 : k$=f_letter$: p_beep_ding: NEXT menu
370      IF m>1 AND m<6: EXIT menu
380    END REPeat menu
390 :
400    CSIZE #0,3,1: AT #0,1,1: PRINT #0,"  Tu as choisi l'option" ! m ! "!": CSIZE #0,1,0
410    p_beep_ding: dummy=KEYROW(0): PAUSE 50 : CLS #0
420    CLS #cha
430 :
440 : PRINT #0,"J'analyse ton cerveau..."
450    PAPER #2,0: INK #2,0: CLS #2
460 :  DLINE 30000 TO  : REMark bug display on #2
470 :  INK #2,4
480 :
490 : PRINT #0,"Je cherche le mot que tu ne connais pas..."
500  SELect ON m
510    =2: PRINT #0,"Ah! Ah! Ah! "     : MERGE "vehicles.bas"
520    =3: PRINT #0,"mmmmm......."     : MERGE "animals.bas"
530    =4: PRINT #0,":-) nice ..."     : MERGE "jurrassic.bas"
540    =5: PRINT #0,"ouh ! ouh ! "     : MERGE "france.bas"
550    = REMAINDER : PRINT #0,"SYNTAXE ERROR... AI failed": STOP
560  END SELect 
570 :
580 mot$ = f_pickword$ : mot2$ = f_hide_word$ (mot$)
590 :
600 p_screen 3 : PAUSE 50
610 :
620 : CSIZE #cha,3,1: INK #cha,7
630 : AT #cha,3,(32-LEN(mot$))/2 : PRINT #cha,mot2$
640 :PRINT #0,"le mot...";!mot$:PRINT
650 :
655 : cpt = 0 : k = 0
660 :repeat cherche
670 :  k$ = f_letter$
680 :  FOR i=1 TO LEN(mot$)
690 :    if mot$(i) = k$ : mot2$(i) = k$ : k = 1
695 :  end for i
700 :  AT #cha,3,(32-LEN(mot$))/2 : PRINT #cha,mot2$
705 :  if k = 0 : cpt = cpt + 1
707 :  k = 0
710 :  AT #0,0,0: print #0,k$!cpt
711 :  pause 10 : dummy=KEYROW(0)
712 :  
713 :  if cpt = 11 : v=0 : exit cherche
715 :  if mot$ = mot2$ : v = 1 : exit cherche
720 end repeat cherche
725 :
730 : cls #0: 
731 : IF v = 0 then
732 :   csize #0,3,1: print #0,"Vous perdez, Olipix est"\"reprogrammer en 8 bits."
733 : else
734 :   csize #0,3,1: print #0,"Vous Gagnez, Olipix est libre."
735 : end if
736 :
737 : 
738 :pause
739 :
740   REPeat again
750     CLS #0: PRINT #0,"Veux tu rejouer (O,N) ?"
760     r$ = f_letter$
770     IF r$ = "N" : p_reset cha : STOP
780     IF r$ = "O" : EXIT again
790   END REPeat again
800 :
810 IF  r$="O" : GO TO 260 : REMark PB with repeat and when
820 :
830 REMark 
840 :
850 :
860 :
870 STOP
880 REMark ----------------------------------------
890 REMark Titre
900 REMark ----------------------------------------
910 DEFine PROCedure p_titre (ch)
920   PAPER #ch,0: INK #ch,4: CLS #ch
930   CSIZE #ch,3,1: AT #ch,1,12 : PRINT #ch,"RPUFOS"
940   CSIZE #ch,2,0: AT #ch,5,9  : PRINT #ch,"Retro Programmers United"
950   CSIZE #ch,2,0: AT #ch,6,11 : PRINT #ch,"For Obscure Systems"
960   CSIZE #ch,3,1: AT #ch,5,9  : PRINT #ch,"Game Jam 2026"
970   CSIZE #ch,1,1: AT #ch,7,17 : PRINT #ch,"Le mot que tu ne connais pas"
980   CSIZE #ch,1,1: AT #ch,8,22 : PRINT #ch,"Un jeu gros pixels"
990   CSIZE #ch,2,0: AT #ch,20,11: PRINT #ch,"Tabasse une touche..."
1000   dummy=KEYROW(0): PAUSE: p_beep_ding: CLS #ch
1010 END DEFine p_titre
1020 :
1030 :
1040 REMark ----------------------------------------
1050 REMark Menu pour les mots
1060 REMark   ch: chanel
1070 REMark ----------------------------------------
1080 DEFine FuNction f_menu (ch)
1090   LOCal k, k$, x
1100   PAPER #ch,0: INK #ch,4: CLS #ch
1110   CSIZE #ch,3,1: AT #ch,1,1: PRINT #ch,"Fait ton choix humain !"
1120   RESTORE 1220
1130   k$="": x=1: CSIZE #ch,2,1
1140   READ m$
1150   IF m$<>"END": AT #ch,x+2,4: PRINT #ch,x ! "-" ! m$: x=x+1: GO TO 1140
1160   x=x-1
1170   dummy=KEYROW(0): k$=INKEY$(-1)
1180   REMark print #0,"touche ";k$
1190   IF k$<"1" OR k$>CHR$(48+x): p_beep_echec: GO TO 1170
1200   k=k$-"0": REMark k=CODE(k$)-48
1210   p_beep_ding
1220   DATA "Quo vadis ?","Vehiculux","Animalux","Dinosaurux","Empirus Gaulux","END"
1230   RETurn k
1240 END DEFine f_menu
1250 :
1260 :
1270 REMark ----------------------------------------
1280 REMark Beep Failed
1290 REMark ----------------------------------------
1300 DEFine PROCedure p_beep_echec
1310   BEEP 2000, 80, 80, 0, 0, 0, 4, 0: BEEP 3000, 150, 150, 0, 0, 0, 6, 0
1320 END DEFine p_beep_echec
1330 :
1340 :
1350 REMark ----------------------------------------
1360 REMark Beep beep
1370 REMark ----------------------------------------
1380 DEFine PROCedure p_beep_ding
1390   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
1400 END DEFine p_beep_ding
1410 :
1420 :
1430 REMark ----------------------------------------
1440 REMark Explications du jeu
1450 REMark   ch: channel
1460 REMark ----------------------------------------
1470 DEFine PROCedure p_how_to (ch)
1480   PAPER #ch,0: INK #ch,4: CLS #ch
1490   CSIZE #ch,3,1: AT #ch,1,12: PRINT #ch,"HOW TO"
1500   CSIZE #ch,0,0: AT #ch,5,1: PRINT #ch,"Humain ta mission est de sauvez Olipix de la tr";CHR$(144);"s tr";CHR$(144);"s mechante IA qui veut"
1510   PRINT #ch," reprogrammer son cerveau (en mode 8 bits neurones)."
1520   PRINT #ch,\" Elle analyse le tien pour choisir un mot  que tu connais pas."
1530   PRINT #ch,\" Balance lui les lettres pour..."
1540   CSIZE #ch,3,1: AT #ch,6,9: PRINT #ch,"...l'an";CHR$(131);"antir."
1550   CSIZE #ch,0,0: AT #ch,17,1: PRINT #ch,"Oui, oui, car il parait que les IA c'est vachement beaucoup tr";CHR$(144);"s m";CHR$(131);"chante pour"
1560   PRINT #ch," les  humains."
1570   CSIZE #ch,3,1: AT #ch,11,11: PRINT #ch,"Lance une lettre..."
1580   dummy=KEYROW(0): REMark PAUSE
1590 END DEFine p_how_to
1600 :
1610 :
1620 :
1630 REMark ----------------------------------------
1640 REMark Renvois la lettre A-Z si tabassee
1650 REMark ----------------------------------------
1660 DEFine FuNction f_letter$
1670   LOCal l$, C
1680   :
1690   dummy=KEYROW(0): l$=INKEY$(-1)
1700   IF l$="": GO TO 1680 : REMark need avoid goto
1710   C=CODE(l$)
1720   REMark Convertion a-z vers A-Z
1730   IF C>=97 AND C<=122: C=C-32
1740   REMark Refaire si pas A-Z
1750   IF C<65 OR C>90: p_beep_echec: GO TO 1680
1760   :
1770   l$=CHR$(C)
1780   dummy=KEYROW(0): RETurn l$
1790 END DEFine f_letter$
1800 :
1810 :
1820 REMark ----------------------------------------
1830 REMark Ecran de jeu
1840 REMark ----------------------------------------
1850 DEFine PROCedure p_screen (ch)
1860   PAPER #ch,0: INK #ch,3 : CLS #ch
1870   CSIZE #ch,1,0 : CHAR_INC #ch,8,9 : OVER #ch,1 :
1880   AT #ch, 4,0 : PRINT #ch,FILL$(CHR$(197),64);
1890   AT #ch,21,0 : PRINT #ch,FILL$(CHR$(197),64);
1900 : x0=5: y0=1 : INK #ch,7
1910 : REPeat loop
1920 :   AT #ch,x0,y0: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0: PRINT #ch,CHR$(206)
1930 :   AT #ch,x0,y0+61: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0+61: PRINT #ch,CHR$(206)
1940 :   x0=x0+2
1950 :   IF x0=21 THEN EXIT loop
1960 : END REPeat loop
1970 : AT #ch,3,1: PRINT #ch,CHR$(245)&CHR$(246);
1980 : AT #ch,0,0: PRINT #ch,CHR$(247)&CHR$(248);
1990 : AT #ch,3,60: PRINT #ch,CHR$(249)&CHR$(250)&CHR$(251);
2000 :
2010 : CSIZE #ch,3,1
2020 : CURSOR #ch,90,10: PRINT #ch,"Trouve le mot inconnu": REMark position x,y
2030 : CSIZE #ch,1,0
2040 :
2050 : CHAR_INC #ch,8,10 : OVER #ch,0 :
2060 END DEFine p_screen
2070 :
2080 REMark ----------------------------------------
2090 REMark Initialise window game
2100 REMark   ch: channel for the game
2110 REMark ----------------------------------------
2120 DEFine PROCedure p_start (ch)
2130   MODE 4
2140   OPEN #ch,scr_
2150   WINDOW #ch,512,256, 0,0: SCALE #3,256, 0,0
2160   CSIZE #ch, 1,0 : REMark basic size for font 8x9
2170   PAPER #ch,0 : CLS #ch
2180 END DEFine p_start
2190 :
2200 REMark ----------------------------------------
2210 REMark load font
2220 REMark   ch: channel for the font
2230 REMark ----------------------------------------
2240 DEFine PROCedure p_load_font (ch)
2250   LOCal fst, lst, num, base
2260   fst = 192 : lst = 255      : REMark need improvment
2270   num = ((lst-fst+1)*9)+2    : PRINT #0,"size: ";num
2280   base = ALCHP(num)
2290   CLS #0: PRINT #0,"Loading font..."
2300   LBYTES "rpufos.fnt", base
2310   CHAR_USE #ch, 0, base      : REMark used as secondary
2320   PRINT #0,"Font loaded..."
2330 END DEFine p_load_font
2340 :
2350 REMark ---------------------------
2360 REMark REMark reset default values
2370 REMark ch: channel
2380 REMark ---------------------------
2390 DEFine PROCedure p_std_char (ch)
2400   CHAR_INC #ch,8,10 : OVER #ch,0:
2410 END DEFine p_std_char
2420 :
2430 REMark -----------------
2440 REMark set char size
2450 REMark ch: channel
2460 REMark x:  x size
2470 REMark y:  y size
2480 REMark o:  over (1 or 0)
2490 REMark -----------------
2500 DEFine PROCedure p_set_char (ch, cx, cy, o)
2510   CHAR_INC #ch,cx,cy : OVER #ch,o :
2520 END DEFine p_set_char
2530 :
2540 REMark ----------------------------------------
2550 REMark 
2560 REMark ----------------------------------------
2570 DEFine PROCedure p_show_word (ch,word$)
2580   LOCal i
2590 : CSIZE #ch,3,1
2600 : CURSOR #ch,50,10
2610 : PRINT #ch,word$
2620 :
2630 :
2640 :CSIZE #ch,1,0
2650 END DEFine p_show_word
2655 :
2660 REMark ----------------------------------------
2700 REMark RESET
2710 REMark ----------------------------------------
2720 DEFine PROCedure p_reset (ch)
2730   CLOSE #ch
2740   :
2750   :
2760   :
2770   :
2780   CLS #0: CLS #1: CLS #2
2790 END DEFine p_reset
2800 REMark ----------------------------------------
2810 REMark replace with "_"
2820 REMark ----------------------------------------
2830 define function f_hide_word$ (word$)
2835   LOCal i, w$
2837   w$ = ""
2840   FOR i=1 TO LEN(word$)
2850     IF word$(i) = " " THEN
2852       w$ = w$ & " "
2855     ELSE
2857       w$= w$ & "_"
2860     END IF 
2890   END FOR i
2895   RETurn w$
2900 END DEFine f_build_word$
30000 :
