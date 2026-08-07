30000 REMark ----------------------------------------
30010 REMark Random choose a word in the DATA
30020 REMark ----------------------------------------
30030 DEFine FuNction f_pickword$
30040   LOCal i, n, idx, w, s, e, p
30050   s = 5000
30060   e = 5010
30070   p = 10
30080   w = 6
30090   n = RND(0 TO (e - s) / p) * p + s
30100   idx = RND(1 TO w)
30110   RESTORE n
30120   FOR i = 1 TO idx
30130     READ w$
30140   END FOR i
30150   RETurn w$
30160 END DEFine f_pickword$
30170 REMark ----------------------------------------
30180 REMark Here your words 6 per ligne
30190 REMark ----------------------------------------
30200 DATA "HELLO", "WORLD", "RPUFOS", "TOTO", "TITI", "TATA"
30210 DATA "OLIPIX", "OLIVIER", "VINCENT", "VOITURE", "CAMION", "AVION"
30220 REMark Copy this file and put Words
