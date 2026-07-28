# Programmer en superBASIC

___
## Introduction

Ensemble de notes concernant la programmation en superBASIC pour le sinclair QL.\
J'ai mis des exemples utiles dans le répertoire "directories", on peut les merger via la commande "MERGE".


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

```basic
to do
```

Si i est déjà utilisé dans le programme, ce i n'interfère pas.

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

#### la base pour comprendre

C'est à s'arracher les cheveux.\
L'origine "0,0" est en bas à gauche de la fenêtre.\
Il y a un paramètre SCALE pour que le QL recalcule les pixels par rapport à la base 100.\
Ceci quel que soit le mode choisi (MODE 4 ou MODE 8 pour un QL de base).

Comprendre que basiquement l'écran fait toujours 512x256 pixels. Oui c'est bizzare...\
Quand on définie une fenêtre, la position est par rapport à en haut à gauche.\

Donc :

```basic
100 MODE 8
110 WINDOW #3,150,100,10,10
```
Créer une fenêtre sur le canal 3.\
Dimension x: 150 (largeur). \
Dimension y: 100 (hauteur).\
Position 10,10 depuis en haut à gauche.

Tout ça fait des confusions et peut impliquer des dérives d'affichage.

Si on ne précise pas de canal, c'est la fenêtre principale qui est modifiée, en clair, le canal #1.\
Une fonction appelée sans numéro de canal, c'est pour la fenêtre #1.

CLS c'est pareil que CLS #1. PAPER 3 c'est pareil que PAPER #1,3.

#### Et le SCALE dans ce boxon ?

Le SCALE de base c'est 100. La hauteur de la fenêtre vaut 100 de base quoi que vous ayez définie.\
Par exemple 512x200, alors un POINT 0,0 c'est en bas à gauche et POINT 0,100 c'est en haut à gauche.\
Ce malgré que ce soit 200 la valeur.

Que se passe t-il sur X ?

Si 200 vaut 100\
alors 512 vaut ?

512 x 100 / 200 = 256 ?  Non Non !

La largeur est 190 pixels. on travail sur du 100x190 pixels.

J'ai modifié le code source de SCALE d'une doc pour en faire le programme d_scale.bas.\
On se base sur l'écran de base du QL soit 512x256.\
Vous donnez la dimension de votre fenêtre et un SCALE.\
Vous obtiendrez le X max affichable.\
Le Y max étant toujours la valeur du SCALE.

NDR :
- La formule c'est pas moi
- il faudrait prendre en compte la position de l'origine de SCALE (qui est actuellement 0,0)

##### l'origine des fenêtres

Les x,y de SCALE donne l'origine de l'axe en bas à gauche de la fenêtre.\
10,10 implique que le coin bas, gauche à pour coordonnées 10,10.



<p align="center">────────────────────</p>

#### Les couleurs

Tableau des couleurs :

| Value | MODE 8 colour | MODE 4 colour |
|-------|---------------|---------------|
| 0     | black         | black |
| 1     | blue          | black (should be avoided) |
| 2     | red           | red |
| 3     | magenta       | red (should be avoided) |
| 4     | green         | green |
| 5     | cyan          | green (should be avoided) |
| 6     | yellow        | white (should be avoided) |
| 7     | white         | white |

<p align="center">────────────────────</p>

PAPER a

INK [#ch,] c1 [ [,c2] [, pattern] ]

Avec:
- #ch : canal (channel)
- c1 : Encre 1
- c2 : Encre 2
- pattern : trame utilise nécessairement c1 et c2

Sans pattern, c1 et c2 font un mixte des 2.

TO DO: un programme exemple.

Valeurs de pattern :

|Value | Pattern |
|------|---------|
| 0    | Dots |
| 1    | Horizontal stripes |
| 2    | Vertical stripes |
| 3    | Checkerboard |



<p align="center">────────────────────</p>


#### Problèmes sur LINE et LINE_R

Il y a un soucis dans la doc concernant ces 2 fonctions.\
L'écriture avec le channel.

il faut :

LINE [#chan] [, x,y] [TO x1,y1] *[[;xi,yi] [TO xj,yj] ]*

```basic
LINE #1 TO 100,100
```

Il y a un problème avec cette foutue ","...

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
