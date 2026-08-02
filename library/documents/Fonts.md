# Les Fontes sous sinclair QL

___
## Introductions

Ce document sert à comprendre le mécanisme des fontes sous sinclair QL.\
C'est très particulier...


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

Il faut le TOOLKIT II.


NDR : TO DO



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

On peut transformer un fichier QL font en bloc de ligne DATA.



___