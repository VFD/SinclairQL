# Ensemble de programmes utiles

## Introduction

Ici ce trouve plusieurs programme pour se faciliter la vie dans le développement en superBASIC.\
Voir ci-dessous les listings.

## Les listings



### p_rpufos_logo

Cette procédure permet de dessiner le logo au trait.\
Il n'y a pas de remplissage (FILL) car le FILL du QL ne sait pas faire avec les formes complexes concave.\
Je n'ai pas encore trouver de moyen pour faire corectement le FILL.

La procédure utilise 4 paramètres :

- c  : canal d'envois. Selon vos définition de fenêtre (de base c'est 1)
- x0 : coordonnées bas gauche du dessin sur X
- y0 : coordonnées bas gauche du dessin sur Y
- p  : couleur du stylo dans les référence des MODE 4 et 8.

Voir aussi dans l'aide de programmation l'utilisation du SCALE qui est très particulière.

### p_screen_reset

Met tout l'écran en noir.\
Passe le stylo en vert (comme dans l'ancien temps des bon vieux moniteur).

La ligne 32080, définie la fenêtre principale (ch #1) sans empiéter sur la console (#0).\
La ligne 32090 prend tout l'écran.






___
