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
341 p_beep_ding: dummy=KEYROW(0): PAUSE
342 csize #0,1,0
343 :
344 :
345 :
346 :
347 :
348 :
349 :

350 :
360 p_screen 3 : PAUSE
370 :
380 :
390 STOP
400 REMark ----------------------------------------
410 REMark Delete lines et merge
420 REMark ----------------------------------------
430 DLINE 10000 TO
440 ON C GO TO 450, 460, 470, 480
450 REMark MERGE "": GOTO 590
460 REMark MERGE "": GOTO 590
470 REMark MERGE "": GOTO 590
480 REMark MERGE "": GOTO 590
490 RETurn 
500 :
510 :
520 :
530 STOP
540 REMark ----------------------------------------
550 REMark Titre
560 REMark ----------------------------------------
570 DEFine PROCedure p_titre (ch)
580   PAPER #ch,0: INK #ch,4: CLS #ch
590   CSIZE #ch,3,1: AT #ch,1,12 : PRINT #ch,"RPUFOS"
600   CSIZE #ch,2,0: AT #ch,5,9  : PRINT #ch,"Retro Programmers United"
610   CSIZE #ch,2,0: AT #ch,6,11 : PRINT #ch,"For Obscure Systems"
620   CSIZE #ch,3,1: AT #ch,5,9  : PRINT #ch,"Game Jam 2026"
630   CSIZE #ch,1,1: AT #ch,7,17 : PRINT #ch,"Le mot que tu ne connais pas"
640   CSIZE #ch,1,1: AT #ch,8,22 : PRINT #ch,"Un jeu gros pixels"
650   CSIZE #ch,2,0: AT #ch,20,11: PRINT #ch,"Tabasse une touche..."
660   dummy=KEYROW(0): PAUSE: p_beep_ding: CLS #ch
670 END DEFine p_titre
680 :
690 :
700 REMark ----------------------------------------
710 REMark Menu pour les mots
720 REMark   ch: chanel
730 REMark ----------------------------------------
740 DEFine FuNction f_menu (ch)
750   LOCal k, k$, x
760   PAPER #ch,0: INK #ch,4: CLS #ch
770   CSIZE #ch,3,1: AT #ch,1,1: PRINT #ch,"Fait ton choix humain !"
780   RESTORE 880
790   k$="": x=1: CSIZE #ch,2,1
800   READ m$
810   IF m$<>"END": AT #ch,x+2,4: PRINT #ch,x ! "-" ! m$: x=x+1: GO TO 800
820   x=x-1
830   dummy=KEYROW(0): k$=INKEY$(-1)
840   REMark print #0,"touche ";k$
850   IF k$<"1" OR k$>CHR$(48+x): p_beep_echec: GO TO 830
860   k=k$-"0": REMark k=CODE(k$)-48
870   p_beep_ding
880   DATA "Quo vadis ?","Vehiculux","Animalux","Dinosaurux","Empirus Gaulux","END"
890   RETurn k
900 END DEFine f_menu
910 :
920 :
930 REMark ----------------------------------------
940 REMark Rate
950 REMark ----------------------------------------
960 DEFine PROCedure p_beep_echec
970   BEEP 2000, 80, 80, 0, 0, 0, 4, 0: BEEP 3000, 150, 150, 0, 0, 0, 6, 0
980 END DEFine p_beep_echec
990 :
1000 :
1010 REMark ----------------------------------------
1020 REMark Beep beep
1030 REMark ----------------------------------------
1040 DEFine PROCedure p_beep_ding
1050   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
1060 END DEFine p_beep_ding
1070 :
1080 :
1090 REMark ----------------------------------------
1100 REMark Explications du jeu
1110 REMark   ch: channel
1120 REMark ----------------------------------------
1130 DEFine PROCedure p_how_to (ch)
1140   PAPER #ch,0: INK #ch,4: CLS #ch
1150   CSIZE #ch,3,1: AT #ch,1,12: PRINT #ch,"HOW TO"
1160   CSIZE #ch,0,0: AT #ch,5,1: PRINT #ch,"Humain ta mission est de sauvez Olipix de la tr";CHR$(144);"s tr";CHR$(144);"s mechante IA qui veut"
1170   PRINT #ch," reprogrammer son cerveau (en mode 8 bits neurones)."
1180   PRINT #ch,\" Elle analyse le tien pour choisir un mot  que tu connais pas."
1190   PRINT #ch,\" Balance lui les lettres pour..."
1200   CSIZE #ch,3,1: AT #ch,6,9: PRINT #ch,"...l'an";CHR$(131);"antir."
1210   CSIZE #ch,0,0: AT #ch,17,1: PRINT #ch,"Oui, oui, car il parait que les IA c'est vachement beaucoup tr";CHR$(144);"s m";CHR$(131);"chante pour"
1220   PRINT #ch," les  humains."
1230   CSIZE #ch,3,1: AT #ch,11,11: PRINT #ch,"Lance une lettre..."
1240   dummy=KEYROW(0): REMark PAUSE
1250 END DEFine p_how_to
1260 :
1270 :
1280 :
1290 REMark ----------------------------------------
1300 REMark Renvois la lettre A-Z si tabassee
1310 REMark ----------------------------------------
1320 DEFine FuNction f_letter$
1330   LOCal l$, C
1340   dummy=KEYROW(0): l$=INKEY$(-1)
1350   IF l$="": GO TO 1340 : REMark need avoid goto
1360   C=CODE(l$)
1370   REMark Convertion a-z vers A-Z
1380   IF C>=97 AND C<=122: C=C-32
1390   REMark Refaire si pas A-Z
1400   IF C<65 OR C>90: ECHEC: GO TO 1340
1410   l$=CHR$(C)
1420   dummy=KEYROW(0): RETurn l$
1430 END DEFine f_letter$
1440 :
1450 :
1460 REMark ----------------------------------------
1470 REMark Ecran de jeu - to do
1480 REMark ----------------------------------------
1490 DEFine PROCedure p_screen (ch)
1500   PAPER #ch,0: INK #ch,3 : CLS #ch
1510   CSIZE #ch,1,0 : CHAR_INC #ch,8,9 : OVER #ch,1 :
1520   AT #ch, 4,0 : PRINT #ch,FILL$(CHR$(197),64);
1530   AT #ch,21,0 : PRINT #ch,FILL$(CHR$(197),64);
1540 : x0=5: y0=1 : INK #ch,7
1550 : REPeat loop
1560 :   AT #ch,x0,y0: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0: PRINT #ch,CHR$(206)
1570 :   AT #ch,x0,y0+61: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0+61: PRINT #ch,CHR$(206)
1580 :   x0=x0+2
1590 :   IF x0=21 THEN EXIT loop
1600 : END REPeat loop
1610 : AT #ch,3,0: PRINT #ch,CHR$(245)&CHR$(246);
1620 : AT #ch,0,0: print #ch,chr$(247)&chr$(248);
1625 : AT #ch,3,60: print #ch,chr$(249)&chr$(250)&chr$(251);
1627 :
1630 : csize #ch,3,1
1631 : cursor #ch,60,10: print #ch,"Trouve le mot inconnu"
1632 : csize #ch,1,0
1633 : 
1640 : CHAR_INC #ch,8,10 : OVER #ch,0 :
1650 END DEFine p_screen
1660 :
1670 REMark ----------------------------------------
1680 REMark Initialise window game
1690 REMark   ch: channel for the game
1700 REMark ----------------------------------------
1710 DEFine PROCedure p_start (ch)
1720   MODE 4
1730   OPEN #ch,scr_
1740   WINDOW #ch,512,256, 0,0: SCALE #3,256, 0,0
1750   CSIZE #ch, 1,0 : REMark basic size for font
1760   PAPER #ch,0 : CLS #ch
1770 END DEFine p_start
1775 :
1780 REMark ----------------------------------------
1790 REMark load font
1800 REMark   ch: channel for the font
1810 REMark ----------------------------------------
1820 DEFine PROCedure p_load_font (ch)
1830   LOCal fst, lst, num, base
1840   fst = 192 : lst = 246
1850   num = ((lst-fst+1)*9)+2
1860   base = ALCHP(num)
1870   CLS #0: PRINT #0,"Loading font..."
1880   LBYTES "rpufos.fnt", base
1890   CHAR_USE #ch, 0, base
1900 END DEFine p_load_font
1904 :
1910 REMark ---------------------------
1920 REMark REMark reset default values
1930 REMark ch: channel
1940 REMark ---------------------------
1950 DEFine PROCedure p_std_char (ch)
1960   CHAR_INC #ch,8,10 : OVER #ch,0:
1970 END DEFine p_std_char
1980 :
1990 REMark -----------------
2000 REMark set char size
2010 REMark ch: channel
2020 REMark x:  x size
2030 REMark y:  y size
2040 REMark o:  over (1 or 0)
2050 REMark -----------------
2060 DEFine PROCedure p_set_char (ch, cx, cy, o)
2070   CHAR_INC #ch,cx,cy : OVER #ch,o :
2080 end define p_set_char
2090 :
2100 REMark
2110 REMark
2120 REMark
2130 define procedure p_show_word (ch,word$)
2140   local i
2150 : csize #ch,3,1
2160 : cursor #ch,50,50
2170 :print #ch,word$
2180 :
2190 :
2200 :csize #ch,1,0
2210 end define p_show_word

