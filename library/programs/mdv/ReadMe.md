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

Mais c'est beaucoup mieux quand on fait un microdrive.


### Les appels "mdv_"

Non vérifier sur machine physique, testé sur QemuLator.\
Pour les commandes de type save, load, ... , il ne semble pas nécessaire de préciser le suffixe "mdv...".

```basic
lrun monProg_bas
```

cette action charge et lance automatiquement le programme.\
Le nom ne doit pas contenir de ".".

```basic
lrun "monProg.bas"
```

Là on peut utiliser le ".".


___

Pour plus de détails voir [MicroDrive.md](library/programs/MicroDrive.md)

___
