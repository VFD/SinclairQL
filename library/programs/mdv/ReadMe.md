# Programmes pour le Sinclair QL

___
## Introduction

Enssemble des programmes que j'ai fait pour le Sinclair QL.\
Contient de nombreux tests pour évaluer le potentiel de la machine.\
Un gros casse-tête c'est les modes graphiques.

NB : Pour QemuLator, lors du mount, il n'est pas necessire que le répertoire s'appel "mdv...", n'importe quel nom convient.\
C'est selon vos méthodes de travail.

___
## Aide sur les microdrive

### le fichier "BOOT"

Ce fichier contient (ou non) un programme en superBASIC.\
Il permet de faire le démarrage de votre programme.\
Par exemple si besoin d'un binaire avec le programe, c'est là que ça se passe.

L'idée général de BOOT c'est de lancer automatiquement votre programme, ce n'est donc pas obligatoire de l'utiliser.

### Les appels "mdv_"

Non vérifier sur machine physique, sur QemuLator.\
Pour les commandes de type save, load, ... , il ne semble pas nécessaire de préciser le suffixe "mdv...".


___
## Programmer en superBASIC

### Note préalable

On voit baucoup de programme avec comme nom "nom_bas".\
Plusiers test montrent que la structure du nom n'a pas vraiement d'importnce, le QL apparement reconnait le type de fichier.\
Ceci implique qu'on peut juste utiliser "nom" sans rien d'autre.\

Il est possible de faire le développement directement dans le répertoire avec Notepad++ par exemple, puis de faire un "lrun prog" dans l'émulateur.

Toujours pas trouver une méthode de "soft Reset" pour remettre la machine en état comme après un boot.

#### Trucs et astuces sur le superBASIC

Le superBASIC est procédural.\
On peut définir des fonctions et des procédures qui prennent en compte des paramètres.\
De plus le mot clé LOCAL permet de définir des variables locales qui n'interfèrent pas avec le reste du programme.\
Ceci est très utile dans le cas de boucle où on utilise souvent i.

RESTORE N\
RESTORE accepte en paramètre un variable N.\
C'est très rare dans les BASICs de l'époque et c'est très utile.\

#### Les graphismes sur QL

C'est à s'arracher les cheveux.\
L'origine "0,0" est en bas à gauche.\
Il y a un paramètre SCALE pour que le QL recalcule les pixels par rapport à la base 150x100.\
Ceci quel que soit le mode choisi (MODE 4 ou MODE 8 pour un QL de base).

___
## Mes listings

### introduction

C'est du vrac. sauf pour ma production pour la session qui est en premier.\


#### prog

TO DO

#### prog

TO DO



___
