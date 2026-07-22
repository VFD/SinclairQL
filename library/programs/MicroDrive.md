# Aide MicroDrive

___
## Introduction

Comme j'utilise QemuLator, je e base sur celui-ci pour traiter les microdrive.

___
## Manipulation des microdrives


### Création de fichier .mdv

Pas évident à faire.\
J'ai donc créée avec mon amie IA un script PowerShell (5.1 mini) pour créer un BLANK.mdv.

Le script prend des paramètres pour le nom du fichier et son nommage interne sur QL.\
C'est AS IS, sans plus, mais ça rend le service pour avoir un mdv.

Le PowerShell est fourni.

### Formater un mdv

Sur le QL:

```
FORMAT mdv1_nom_volume
```

Le numero correspond au numéro de microdrive (de 1 à 8).


### Copier de - vers

Sur le QL :


```
To do
```

### Le fichier BOOT

Ce BOOT permet de lancer automatiquement le programme.\
On check sur quel drive on est, puis on lance.

Au passage, on SET les variables DATA_USE et PROG_USE.

À adapter à son cas d'usage.

```basic
100 REMark --- Universal BOOT ---
110 REMark Detects which drive holds the main program
120 :
130 prog$ = "prog_bas": REMark Put right name here
140 :
150 REMark --- Try each available drive ---
160 drv$ = "mdv1_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
170 drv$ = "mdv2_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
180 drv$ = "flp1_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
190 drv$ = "flp2_" : ch = FOP_IN(drv$ & prog$) : IF ch > 0 : GOTO 300
200 PRINT "Program not found!" : STOP
210 :
300 REMark --- Configure and launch ---
310 CLOSE#ch
320 DATA_USE drv$     : REMark env var set
330 PROG_USE drv$     : REMark env var set
340 LRUN drv$ & prog$ : REMark Launch the prog
```


___