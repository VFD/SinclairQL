# Jouer avec le BEEP


## Introduction

Des sons tirés des jeux Logi'Stick sur X07.\
Adaptable sur le QL.

Je n'ai pas regarder les chips son de ces deux machines, le résultat est similaire.

Cela peut donner des idées pour faire des procédures de sons.


## Sons extraits pour réutilisation

### Des "poc"

```basic
BEEP 5,5
```
```basic
BEEP 10,10
```

```basic
BEEP 90,10
```

```basic
BEEP 150,30
```

```basic
BEEP 500,20
```

```basic
BEEP 800,20
```

```basic
BEEP 30,1
```

### Divers

```basic
1000 RESTORE 1020
1010 FOR I=0 TO 9: READ A,B: BEEP A,B: NEXT I
1020 DATA 333,4,333,4,333,3,248,9,248,5,220,9,220,9,164,12,195,6,245,11
```

```basic
1000 FOR i=1 TO 48: BEEP i,1: NEXT i
```


```basic
1000 FOR i=999 TO 4000 STEP 99: BEEP i,2: NEXT i
```

```basic
1000 BEEP 333,6: BEEP 333,6: BEEP 333,5: BEEP 248,11: BEEP 248,7: BEEP 220,11: BEEP 220,11
1010 BEEP 164,20: BEEP 195,11: BEEP 245,9
```

```basic
1000 FOR i=1 TO 50 STEP 2: BEEP i,2: NEXT i
```

```basic
1000 FOR i=1 TO 100 STEP 5: BEEP i,2: NEXT i
```


```basic
1000 FOR i=1 TO 50: BEEP 50,2: NEXT i
```

```basic
1000 BEEP 10,16: BEEP 20,16: BEEP 30,16: BEEP 5,16: BEEP 15,16: BEEP 25,16
```


```basic
1000 FOR i=5 TO 14
1010 BEEP i,5: BEEP i*10,5: BEEP 250,5
1020 PAUSE
1030 NEXT i
```

```basic
1000 FOR i=100 TO 500 STEP 10: BEEP i,3: NEXT i
```

Extrait de Memory (type jeu SIMON).\
Était utilisée dans le cadre du déplacement.

Mise en forme de procédure, pour l'exemple.

```basic
1000 REMark -------------------------
1010 REMark 
1020 REMark -------------------------
1030 DEFine PROcedure p_SON
1040   LOCAL i,j,k,x(30)
1050   FOR i=1 TO 30: x(i)=RND(1 TO 4): NEXT i
1060   FOR j=1 TO 30
1070     FOR k=1 TO j
1080       BEEP x(k)*10,5
1090     NEXT k
1100     REMark ----------
1110     REMark gestion
1120     REMark ----------
1180   NEXT j
1190 END DEFine p_SON
```











___