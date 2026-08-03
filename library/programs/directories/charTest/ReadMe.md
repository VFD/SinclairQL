# Test évaluation du jeu de caractère du QL

___
## Introduction

Ensemble de petit programme pour voir comment utiliser les caractères du QL.\
Autant dire que de base c'est pas top.


___
## les programmes



<p align="center">────────────────────</p>

### showChar.bas

Ce petit programme affiche le jeu de caractères du QL.\
Depuis l'espace (no 32) jusqu'au dernier (255).

```basic
lrun "showChar.bas"
```

Le constat c'est que du 192 au 255 c'est les mêmes. Une grille.\
C'est le comportement normal sur le QL.\
Ces caractères peuvent être redéfinis, mais cela nécessite des choses.

Voir [Explication de texte sur les caractères redéfinissables](../../../documents/Fonts.md).

<p align="center">────────────────────</p>

### buildChar.bas

Tentative de creation d'une font directement sur QL (mais rien n'empêche de créer une application, JavaScript ?).\
Ça à l'air de le faire mais avec csize 1,0 et 1,1 et MODE 4 uniquement.

Le Mode 8 c'est encore autre chose.\
Faire en matrice 5x9 ?

<p align="center">────────────────────</p>

### loadChar.bas

Charge la font issue de **buildChar.bas** et affiche la font.\
Inclut quelques tests à lancer avec GOTO (QDos).

Demos qui utilise le **CHAR_INC** pour supprimer la ligne séparatrice entre 2 ligne de texte.

Note :
- **CHAR_INC** vient avec le **TOOLKIT II**.
- la fonction **OVER** permet l'affichage en transparence.
- les deux programmes fonctionne sur **QemuLator** avec **MINERVA**.

___
## zx81

Font type ZX81.\
Pour base de travail.

M'a permis de tester les Binaires de type **font**.


__
## UDG_bas

Fonction ASM pour charger les caractères.\
à tester car alors pas besoin du toolkit II ?

___
