# Programmes pour le Sinclair QL

___
## Introduction

Réaliser dans le cadre des sessions RPUFOS (Retro Programmers United For Obscure Systems) de Juin 2026 à octobre 2026.\
Vous trouverez ici tout un tas de choses que j'ai réalisé.\
Il n'y aura rien d'autre, il y a sufisament de site parlant du QL.

J'ai utiliser [QemuLator](https://www.terdina.net/ql/q-emulator.html) en version de base - uQLX pour la version *nix.

___
## Base de travail

Les émulateurs peuvent utiliser les répertoires comme des MicroDrive ou des floppy disk.\
Il est donc possible de travailler directement sur les fichiers depuis le système hôte quel qu'il soit (*nix, Apple, Windows).

J'ai fait des tests avec [QemuLator](https://www.terdina.net/ql/q-emulator.html), sQLux, ...\
Au final (je suis sous Windows) j'ai choisi la version de base de [QemuLator](https://www.terdina.net/ql/q-emulator.html), je verais plus tard si je bascule sur la version complète.\
Donc pour tout ce projet je considère cet émulateur comme acquis.

### Structure de mes répertoires :

Je travail directement sur disque depuis QemuLator et je monte le répertoire en microdrive ou floppy selon le cas.\
Je finalise aussi via des fichier type ".mdv" qui emule le microdrive. Ce qui permet de tester plus avant pour un passage sur machine réèlle.\
Je n'ai pas encore prévue de faire des "RAW" ou des floppies (on verra si j'ai le temps).

Ci-après un "TreeView-beta" via [Mermaid](https://mermaid.ai/) :

```mermaid
---
config:
    treeView:
        lineThickness: 3
    themeVariables:
        treeView:
            labelFontSize: '14px'
            labelColor: '#FF0000'
            lineColor: '#0000FF'
---

treeView-beta
    📂 QLprojects/
        📁 directories/						## Directory for projects
            📁 memory :::highlight				## Memory game like SIMON
                📄 BOOT 								## Boot program (to do)
                📄 memory8.bas						## Main program
                📄 p_rpufos_logo.bas						## procedure to draw RPUFOS logo
            📁 rpufos :::highlight				## Utilities
                📄 BOOT 								## Boot program (to do)
                📄 p_rpufos_logo.bas						## procedure to draw RPUFOS logo (main version to deploy)
                📄 ...						## to do
            📁 ...								## other project
        💾 flp/								## floppy drive projects
            📁 ...								## other project
            📁 ...								## other project
		🖭 mdv/								## microdrive projects
            🖭 saveOlipix.mdv :::highlight		## my project for RPUFOS session
                📄 BOOT 								## Boot program
                📄 main_bas							## Main program 💀
                📝 ...								## Other file
            🖭 ...          			        ## other project
		🖭 mdvraw/							## microdrive projects
			🖭 ...          			        ## other project
		📁 qlpack          			        ## QLpack project
			📁 ...          			        ## other project
		📁 qlx          			        ## QLx (HD drive) project
			📁 ...          			        ## other project

```

Pour vous graphe ou autre je vous recommande fortement (Mermaid)[https://mermaid.ai/].\
Je vous authorise à reprendre mon code ci-dessus.

___
## Les Listings

Ils sont réparties selon des critères obscures...

- mdv : Microdrive (en principe max 128ko)
- flp : Floppy disk (720Ko à 1.4Mo selon dispositif)
- ... : etc.


To be continued...

___
