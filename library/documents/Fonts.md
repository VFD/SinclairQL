# Les Fontes sous sinclair QL

___
## Introductions

Ce document sert à comprendre le mécanisme des fontes sous sinclair QL.\
C'est très particulier...

Dans ldes docs on trouve 8x10, mais apparement j'ai du 8x9. C'est encore à vérifier.

___
### Strucure d'un caractère

Chaque caractère est sur une matrice de 8x9.\
Selon le mode CSIZE, le QL utilisera une certaine partie.\
D'où le fait que le glyphe peut être tronqué à l'affichage.

La base c'est 5 colonnes.

Pour dessiner un police de caraactères compatible toutes taille :\
Utiliser une matrice 5x9.

Toutes tailles signifie :

- Mode 4 ou 8
- CSIZE 0
- CSIZE 1
- CSIZE 2
- CSIZE 3
- Compatible Minerva
- Compatible QL standard

___
### CSIZE

Effet de csize sur la fonte.

| CSIZE (L,H) | Largeur    | Hauteur   | Effet visuel                    | Matrice | Bits lus     |
|-------------|------------|-----------|---------------------------------|---------|--------------|
| 0,0         | 6 colonnes | 9 lignes  | Normal                          | 6x9     | 0–5          |
| 0,1         | 6 colonnes | 18 lignes | Double hauteur                  | 6x18    | 0–5          |
| 1,0         | 8 colonnes | 9 lignes  | Double largeur                  | 8x9     | 0–7          |
| 1,1         | 8 colonnes | 18 lignes | Double largeur + double hauteur | 8x18    | 0–7          |
| 2,0         | 5 colonnes | 9 lignes  | Mode spécial (largeur réduite)  | 5x9     | 1–5          |
| 2,1         | 5 colonnes | 18 lignes | Mode spécial + double hauteur   | 5x18    | 1–5          |
| 3,0         | 5 colonnes | 9 lignes  | Mode spécial (largeur réduite)  | 5x9     | 1–5          |
| 3,1         | 5 colonnes | 18 lignes | Mode spécial + double hauteur   | 5x18    | 1–5          |


Matrice : represente l'effet visuel.\
Basé sur le pattern défini.

Exemple :

La base du design, matrice de 8x9.

Ci-dessous avec CSIZE.
- Avec comme valeur 0, on perd à l'affichage les bits 7,8.\
- Avec comme valeur 1, on affiche tout.
- Avec comme valeur 2,3, on perd à l'affichage les bits 1,7,8.\


```
0121345678
0121345678
0121345678
0121345678
0121345678
0121345678
0121345678
0121345678
0121345678
```


NDR :
- On part d'en haut à gauche pour dessiner
- La 2ème valeur de CSIZE sert à doubler la hauteur.

En conclusion, pour se créer une fonte personelle.

- Utiliser les bits 0 à 5 (6x9) pour uniquement CSIZE 0,0 ou 0,1.
- Utiliser les bits 1 à 5 (5x9) si vous voulez utiliser tous les modes d'affichage.
- Utiliser CSIZE 1,0 ou 1,1, uniquement pour une fonte en 8x9.


___
### Chargement d'une fonte

- Il faut le TOOLKIT II.
- Une font est attachée à une fenètre, elle n'interfère pas avec les autres fenètres.



NDR : TO DO

Code à améliorer et commenter.

```basic
100 REMark === Reserve memory for the font ===
110 REMark  values must match the build
120 fst = 192
130 lst = 194
140 num = ((lst-fst+1)*9)+2
150 base = ALCHP(num)
160 REMark === Load the font file into memory ===
170 LBYTES "myfont_raw", base
180 REMark === Install the font as upper font for window #1 ===
190 CHAR_USE #1, 0, base
200 REMark === Set character spacing for 8x8 fonts ===
210 REMark CHAR_INC #1, 8, 8
220 CSIZE #1,1,0
230 REMark === Display all characters from 32 to 255 ===
240 FOR c = 32 TO 255
250   PRINT #1, CHR$(c);
260 END FOR c
270 REMark === End: remove the font if needed ===
280 REMark CHAR_USE #1,0,0
290 REMark RECHP base

```






___
### Designer la partie étendue uniquement

Principe, les caractères "libres" vont de 192 à 255.\
Par caractère libre s'entend ceux non definis par le QL qui si on les affiches sont une grille.\
Soit 64 caractères.

Vous devez prendre en compte l'effet du CSIZE décrit ci-dessus.\
Vous chargez à partir du 192, cela n'affectera pas le reste.


___
### Le binaire d'une fonte

- Octet 1 : Début de rematricage, si 192 alors C0
- Octet 2 : Nombre de caractère
- Octets suivants : Par 9, chaque ligne du caractère.

Bref c'est tout simple.

Autre départ souvent vu, 127 ($7F).

___
### Via bloc DATA

On peut transformer un fichier QL font en bloc de ligne DATA.\
Et inversement.\
Mise en mémoire et sauvegarde brut (RAW).

La font est prète.




## En Tests

```basic
:
: REMARK CSIZE 1,0 ou CSIZE 1,1
:
DATA 00, 10, 10, 7C, 10, 10, 38, 44, FE  : REMark Tombe
DATA 00, 7C, 82, FE, 82, 92, 82, 82, FE  : REMark Coffre 1
DATA FE, 44, 44, 28, 10, 28, 44, 7C, FE  : REMark sablier
DATA 00, 02, FF, FF, 68, 78, 60, 60, 00  : REMark gun to right
DATA ED, ED, 00, BB, BB, 00, D7, D7, 00  : REMark motif type brique
DATA 3C, 42, 3C, 42, 91, A1, 81, 7E, 00  : REMark fiole 1
DATA 7C, 28, 28, 6C, C6, 82, FE, DE, 7C  : REMark fiole 2
DATA 04, 2E, 1D, 97, 9E, 8C, 5E, 5E, 3F  : REMark chat
DATA 00, 12, 33, BF, AD, 9E, 4C, 5E, 3F  : REMark chat 2
DATA 00, 88, F8, A8, FA, 72, 71, 79, 7E  : REMark chat 3
DATA FC, 8A, 8E, 82, 82, 82, 82, 82, FE  : REMark Paper
DATA FC, 8A, AE, 82, BA, 82, BA, 82, FE  : REMark Paper Text
DATA C6, C6, BE, F6, 6C, 60, 6C, 6C, 6C  : REMark chaine, haut - A
DATA 6C, 60, 6C, B6, F6, C6, C6, C6, C6  : REMark chaine, bas - B
:
: REMark compatible tous CSIZE
:
DATA 00, 44, 44, 28, 10, 10, 38, 7C, 00  : REMark coupe
DATA 08, 10, 28, 38, 10, 38, 38, 38, 38  : REMark bougie 1
DATA 20, 10, 28, 38, 10, 38, 38, 38, 38  : REMark bougie 2
:
: REMark
:
```


Bougie : alterner à la même position pour effet de flamme qui bouge.
Chaine : en vertical, ABABAB...


___