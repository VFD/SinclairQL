# Programmer en superBASIC

___
## Introduction

TO DO.

à remanier.

### Note préalable

On voit baucoup de programme avec comme nom "nom_bas".\
Plusieurs test montrent que la structure du nom n'a pas vraiement d'importnce, le QL apparement reconnait le type de fichier.\
Ceci implique qu'on peut juste utiliser "nom" sans rien d'autre.\

Il est possible de faire le développement directement dans le répertoire avec Notepad++ par exemple, puis de faire un "lrun prog" dans l'émulateur.

Toujours pas trouver une méthode de "soft Reset" pour remettre la machine en état comme après un boot.

<p align="center">────────────────────</p>

### Trucs et astuces sur le superBASIC

#### Le superBASIC est procédural
On peut définir des fonctions et des procédures qui prennent en compte des paramètres.\
De plus le mot clé LOCAL permet de définir des variables locales qui n'interfèrent pas avec le reste du programme.\
Ceci est très utile dans le cas de boucle où on utilise souvent i.

Autre point important, les fonctions et procédures sont directement exploitable dès le chargement du programme par load.

<p align="center">────────────────────</p>

#### RESTORE N
RESTORE accepte en paramètre une variable N.\
C'est très rare dans les BASICs de l'époque et c'est très utile.\
Voir le programme "to do" qui l'utilise pour utiliser une séquence DATA aléatoirement.\
La formule de maths sera expliquée.

```basic
4030 DEFine FuNction PICKWORD$
4040   LOCal i, n, idx, w, s, e, p
4050   s = 5000
4060   e = 5010
4070   p = 10
4080   w = 6
4090   n = RND(0 TO (e - s) / p) * p + s
4100   idx = RND(1 TO w)
4110   RESTORE n
4120   FOR i = 1 TO idx
4130     READ w$
4140   END FOR i
4150   RETurn w$
4160 END DEFine PICKWORD
4970 REMark ----------------------------------------
4980 REMark DATA to choose bellow
4990 REMark ----------------------------------------
```

- s: première ligne de DATA
- e: dernière ligne de DATA
- p: pas d'incrément des ligne (en général 10)
- n: tirage d'un nombre entre s et e par incrément de p

<p align="center">────────────────────</p>

#### La map clavier

Il est possible de détecter l'appuis d'une touche avec KEYROW(n).\
Avec 0<n<7.\
Certaine docs préconise de ne pas utiliser. C'est à voir selon les cas.\
Le problème étant que ça détecte la touche et non le caractère associé.

<p align="center">────────────────────</p>

### Les graphismes sur QL

C'est à s'arracher les cheveux.\
L'origine "0,0" est en bas à gauche.\
Il y a un paramètre SCALE pour que le QL recalcule les pixels par rapport à la base 150x100.\
Ceci quel que soit le mode choisi (MODE 4 ou MODE 8 pour un QL de base).

Exemple :

```basic
100 MODE 8
110 WINDOW #3,512,256,0,0
120 SCALE #3,256,0,0
```

Permettra de travailler sur une fenêtre en Mode 8 512x256 (largeur, hauteur) pixels.\
Le QL recalculera la position des pixels à allumer.\
Ce qui peut impliquer des dérives d'affichage.

<p align="center">────────────────────</p>

#### Les couleurs

TO DO

PAPER a

INK a,b,c

Avec:
- a : Encre
- b : 
- c : trame 

<p align="center">────────────────────</p>

#### Mode 4

- 0 — noir
- 2 — rouge
- 4 — vert
- 7 — blanc

<p align="center">────────────────────</p>

#### Mode 8

- 0 — noir
- 1 — bleu
- 2 — rouge
- 3 — magenta
- 4 — vert
- 5 — cyan
- 6 — jaune
- 7 — blanc

___
## Mes listings

### introduction

C'est du vrac. sauf pour ma production pour la session qui est en premier.\

<p align="center">────────────────────</p>

### Un Pendu tout simple

L'idée est très simple.\
Le principe est surtout de faire une sorte de démo avec le superBASIC.\
Utiliser ses possibilités de MERGE, DLINE, RESTORE entre autre.

L'intérêt est de pouvoir utiliser une base de données en DATA à la demande puis une fois la sélection faite, charger un autre programme par MERGE.

On peut donc définir different type de données, dans le cadre du pendu, on peut donc demander au joueur de choisir sa série.

<p align="center">────────────────────</p>

### prog

TO DO