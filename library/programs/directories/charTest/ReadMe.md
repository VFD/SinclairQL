# Test évaluation du jeu de caractère du QL

___
## Introduction

Ensemble de petit programme pour voir comment utiliser les caractères du QL.\
Autant dire que de base c'est pas top.


___
## les programmes

### char.bas

Ce petit programme affiche le jeu de caractères du QL.\
Depuis l'espace (no 32) jusqu'au dernier (255).

```basic
lrun "char.bas"
```

Le constat c'est que du 192 au 255 c'est les mêmes.



To be continued...


### buildChar.bas

Tentative de creation d'une font.\
ça à l'air de le faire mais avec csize 1,0 et 1,1.

Voir ma doc dans document.

Pour le moment OK en mode 4. Le Mode 8 c'est encore autre chose.

### loadChar.bas

Charge la font issue de buildChar et affiche.

Inclu quelques demos qui utilise le CHAR_INC pour supprimer la ligne séparatrice entre 2 ligne de texte.

Note : la fonction OVER permet l'affichage en transparence.


### zx81

Font type ZX81.\
Pour base de travail.



___
