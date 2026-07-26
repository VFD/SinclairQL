# Aide MicroDrive

___
## Introduction

Comme j'utilise QemuLator, je me base sur celui-ci pour traiter les microdrive.\
Soit les fichiers standard ".mdv" soit le nouveau ".qlpack".

Je n'ai pas encore testé ce dernier.

Ceci explique pourquoi ce fichier est au niveau du répertoire "programme" et non en dessous.

___
## Manipulation des microdrives

Quelques infos pour manipuler les microdrives.

<p align="center">────────────────────</p>

### Création de fichier .mdv

Pas évident à faire.\
J'ai donc créée avec mon amie IA un script PowerShell (5.1 mini) pour créer un "BLANK.mdv".

Le script prend des paramètres pour le nom du fichier et son nommage interne sur QL.\
C'est AS IS, sans plus, mais ça rend le service pour avoir un mdv.

Le PowerShell est fourni, il est dans le [répertoire mdv](/library/programs/mdv).

Utilisation :

```powershell
.\New-BlankMdvImage.ps1 -OutputPath "D:\QL\rpufos.mdv" -MediumName "rpufos"
```

La commande crée un fichier "rpufos.mdv" dans le répertoire spécifié nommé "rpufos".\
Le MediumName c'est 10 caractères max.

On verra si je fais plus tard un JavaScript explorateur/créateur/manipulateur de microdrive.


<p align="center">────────────────────</p>

### Formater un mdv

Sur le QL:

```basic
format mdv2_nom_volume
```

C'est obligatoire une fois le BLANK créée ou copié.

Le numéro correspond au numéro de microdrive (de 1 à 8).\
Selon où vous l'avez placé.

```basic
dir mdv2_
```

Pour voir le contenu.\
Vous devriez alors avoir le message :

```
nom_volume
253/255 sectors
```



<p align="center">────────────────────</p>

### Copier un fichier

Sur le QL :

```basic
copy "nom.bas" to mdv2_nom_bas
```

Sous condition d'avoir monter le directory en 1 et le blank microdrive en 2.\
Par défaut prend le slot 1.


<p align="center">────────────────────</p>

### Le fichier BOOT

Ce BOOT permet de lancer automatiquement le programme.\
On check sur quel drive on est, puis on lance.

Au passage, on SET les variables DATA_USE et PROG_USE.

À adapter à son cas d'usage.\
Ici on test les microdrive 1 et 2 puis les floppies 1 et 2.\
Il est plutôt rare d'avoir plus sur un vrai QL.


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


<p align="center">────────────────────</p>

### Les microdrives vierge fournis

Ils sont dans le répertoire "_blank".

#### blank.mdv

Ce fichier est totalement vierge.\
Il est nécessaire de le formater via la commande vu précédement.

#### boot.mdv

Ce microdrive est formaté et contient le fichier BOOT décrit précédement.\
Reste à le renommer.\
Car je n'ai toujours pas réussi à faire un rename sans écraser les données.


___