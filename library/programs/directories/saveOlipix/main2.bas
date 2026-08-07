180 REMark ----------------------------------------
190 REMark p_start      : initialise le QL
200 REMark p_titre      : affiche le titre RPUFOS
210 REMark f_menu       : affiche le menu, renvoie le choix
220 REMark p_how_to     : affiche l'explication
230 REMark p_screen     : dessine l'ecran du jeu
240 REMark p_beep_ding  : fait ding
250 REMark p_beep_echec : fait beep echec
260 REMark f_letter$    : retourne la lettre choisi
270 REMark p_load_font  : charge la fonte rpufos
280 REMark ----------------------------------------
290 REMark START
300 REMark ----------------------------------------
305 C=3 : REMark channel du jeu
310 p_start C : p_load_font C : p_titre C
315 :
316 :
317 :
318 :
319 :
320 c=f_menu(C)
330 REMark IF c=1: p_how_to: k$=f_letter$: p_beep_ding: GO TO 320
340 :
350 :
360 CLS #4: CSIZE #4,3,1: AT #4,1,1: PRINT #4,"Tu as choisi l'option" ! c ! "!": p_beep_ding: dummy=KEYROW(0): PAUSE
370 :
380 p_screen: PAUSE
390 :
400 :
410 STOP
420 REMark ----------------------------------------
430 REMark Delete lines et merge
440 REMark ----------------------------------------
450 DLINE 10000 TO
460 ON c GO TO 470, 480, 490, 500
470 REMark MERGE "": GOTO 590
480 REMark MERGE "": GOTO 590
490 REMark MERGE "": GOTO 590
500 REMark MERGE "": GOTO 590
510 RETurn 
520 :
530 :
540 :
550 STOP
560 REMark ----------------------------------------
570 REMark Titre
580 REMark ----------------------------------------
590 DEFine PROCedure p_titre (ch)
600   PAPER #ch,0: INK #ch,4: CLS #ch
610   CSIZE #ch,3,1: AT #ch,1,12 : PRINT #ch,"RPUFOS"
620   CSIZE #ch,2,0: AT #ch,5,9  : PRINT #ch,"Retro Programmers United"
630   CSIZE #ch,2,0: AT #ch,6,11 : PRINT #ch,"For Obscure Systems"
640   CSIZE #ch,3,1: AT #ch,5,9  : PRINT #ch,"Game Jam 2026"
650   CSIZE #ch,1,1: AT #ch,7,17 : PRINT #ch,"Le mot que tu ne connais pas"
660   CSIZE #ch,1,1: AT #ch,8,22 : PRINT #ch,"Un jeu gros pixels"
670   CSIZE #ch,2,0: AT #ch,20,11: PRINT #ch,"Tabasse une touche..."
680   dummy=KEYROW(0): PAUSE: p_beep_ding: CLS #ch
690 END DEFine p_titre
700 :
710 :
720 REMark ----------------------------------------
730 REMark Menu pour les mots
740 REMark   ch: chanel
750 REMark ----------------------------------------
760 DEFine FuNction f_menu (ch)
770   LOCal k, k$, x
780   PAPER #ch,0: INK #ch,4: CLS #ch
790   CSIZE #ch,3,1: AT #ch,1,1: PRINT #ch,"Fait ton choix humain !"
800   RESTORE 890
810   k$="": x=1: CSIZE #ch,2,1
820   READ m$
830   IF m$<>"END": AT #ch,x+2,4: PRINT #ch,x ! "-" ! m$: x=x+1: GO TO 820
840   x=x-1
850   dummy=KEYROW(0): k$=INKEY$(-1)
855   REMark print #0,"touche ";k$
860   IF k$<"1" OR k$>CHR$(48+x): p_beep_echec: GO TO 850
870   k=k$-"0": REMark k=CODE(k$)-48
880   p_beep_ding
890   DATA "Quo vadis ?","Vehiculux","Animalux","Dinosaurux","Empirus Gaulux","END"
900   RETurn k
910 END DEFine f_menu
920 :
930 :
940 REMark ----------------------------------------
950 REMark Rate
960 REMark ----------------------------------------
970 DEFine PROCedure p_beep_echec
980   BEEP 2000, 80, 80, 0, 0, 0, 4, 0: BEEP 3000, 150, 150, 0, 0, 0, 6, 0
990 END DEFine p_beep_echec
1000 :
1010 :
1020 REMark ----------------------------------------
1030 REMark Beep beep
1040 REMark ----------------------------------------
1050 DEFine PROCedure p_beep_ding
1060   BEEP 3000, 10, 10, 0, 0, 0, 0, 0: BEEP 3000, 5, 5, 0, 0, 0, 0, 0: BEEP 5000, 1, 1, 0, 0, 0, 0, 0
1070 END DEFine p_beep_ding
1080 :
1090 :
1100 REMark ----------------------------------------
1110 REMark Explications du jeu
1120 REMark   ch: channel
1130 REMark ----------------------------------------
1140 DEFine PROCedure p_how_to (ch)
1150   PAPER #ch,0: INK #ch,4: CLS #ch
1160   CSIZE #ch,3,1: AT #ch,1,12: PRINT #ch,"HOW TO"
1170   CSIZE #ch,0,0: AT #ch,5,1: PRINT #ch,"Humain ta mission est de sauvez Olipix de la tr";CHR$(144);"s tr";CHR$(144);"s mechante IA qui veut"
1180   PRINT #ch," reprogrammer son cerveau (en mode 8 bits neurones)."
1190   PRINT #ch,\" Elle analyse le tien pour choisir un mot  que tu connais pas."
1200   PRINT #ch,\" Balance lui les lettres pour..."
1210   CSIZE #ch,3,1: AT #ch,6,9: PRINT #ch,"...l'an";CHR$(131);"antir."
1220   CSIZE #ch,0,0: AT #ch,17,1: PRINT #ch,"Oui, oui, car il parait que les IA c'est vachement beaucoup tr";CHR$(144);"s m";CHR$(131);"chante pour"
1230   PRINT #ch," les  humains."
1240   CSIZE #ch,3,1: AT #ch,11,11: PRINT #ch,"Lance une lettre..."
1250   dummy=KEYROW(0): REMark PAUSE
1260 END DEFine p_how_to
1270 :
1280 :
1290 :
1300 REMark ----------------------------------------
1310 REMark Renvois la lettre A-Z si tabassee
1320 REMark ----------------------------------------
1330 DEFine FuNction f_letter$
1340   LOCal l$, c
1350   dummy=KEYROW(0): l$=INKEY$(-1)
1360   IF l$="": GO TO 1350 : REMark need avoid goto
1370   c=CODE(l$)
1380   REMark Convertion a-z vers A-Z
1390   IF c>=97 AND c<=122: c=c-32
1400   REMark Refaire si pas A-Z
1410   IF c<65 OR c>90: ECHEC: GO TO 1350
1420   l$=CHR$(c)
1430   dummy=KEYROW(0): RETurn l$
1440 END DEFine f_letter$
1450 :
1460 :
1470 REMark ----------------------------------------
1480 REMark Ecran de jeu - to do
1490 REMark ----------------------------------------
1500 DEFine PROCedure p_screen (ch)
1502   local x0, y0
1505   PAPER #ch,0: INK #ch,3 : CLS #ch
1510   CSIZE #ch,1,0 : CHAR_INC #ch,8,9 : OVER #ch,1 :
1520   at #ch, 4,0 : print #ch,fill$(chr$(197),64);
1530   at #ch,21,0 : print #ch,fill$(chr$(197),64);
1531   x0=5: y0=1 : INK #ch,7
1532   REPeat loop
1533     AT #ch,x0,y0: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0: PRINT #ch,CHR$(206)
1534     AT #ch,x0,y0+61: PRINT #ch,CHR$(205) : AT #ch,x0+1,y0+61: PRINT #ch,CHR$(206)
1536     x0=x0+2
1537     IF x0=19 THEN EXIT loop
1538   END REPeat loop
1539   AT #ch,3,0: print #ch,chr$(245);chr$(246); : REMark spider
1540 :
1550 :
1560   CHAR_INC #ch,8,10 : OVER #ch,0 :
1570 END DEFine p_screen
1575 :
1580 REMark ----------------------------------------
1590 REMark Initialise window game
1600 REMark   ch: channel for the game
1610 REMark ----------------------------------------
1620 DEFine PROCedure p_start (ch)
1630   MODE 4
1640   OPEN #ch,scr_
1650   WINDOW #ch,512,256, 0,0: SCALE #3,256, 0,0
1660   CSIZE #ch, 1,0 : REMark basic size for font
1670   PAPER #ch,0 : CLS #ch
1680 END DEFine p_start
1690 REMark ----------------------------------------
1700 REMark load font
1710 REMark   ch: channel for the font
1720 REMark ----------------------------------------
1730 DEFine PROCedure p_load_font (ch)
1740   LOCal fst, lst, num, base
1750   fst = 192 : lst = 246
1760   num = ((lst-fst+1)*9)+2
1770   base = ALCHP(num)
1780   CLS #0: PRINT #0,"Loading font..."
1790   LBYTES "rpufos.fnt", base
1800   CHAR_USE #ch, 0, base
1810 END DEFine p_load_font


8000 REMark ---------------------------
8010 REMark REMark reset default values
8020 REMark ch: channel
8030 REMark ---------------------------
8040 DEFine PROCedure p_std_char (ch)
8050   CHAR_INC #ch,8,10 : OVER #ch,0:
8060 END DEFine p_std_char
8065 :
8070 REMark -----------------
8080 REMark set char size
8090 REMark ch: channel
8100 REMark x:  x size
8110 REMark y:  y size
8120 REMark o:  over (1 or 0)
8130 REMark -----------------
8140 DEFine PROCedure p_set_char (ch, cx, cy, o)
8150   CHAR_INC #ch,cx,cy : OVER #ch,o :
8160 END DEFine p_set_char