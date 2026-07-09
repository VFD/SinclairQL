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
Je n'ai pas encore prévue de faire des "RAW".

Ci-après Mermaid avec "TreeView-beta" :

```mermaid
---
config:
    treeView:
        rowIndent: 40
        lineThickness: 3
    themeVariables:
        treeView:
            labelFontSize: '14px'
            labelColor: '#FF0000'
            lineColor: '#0000FF'
---

treeView-beta
    QLprojects/
        mdv/ ## microdrive project
            pendu :::highlight ## my project for RPUFOS session
            ... ## other
        flp/ ## floppy drive project
            ...
            ...
```

___
## Les Listings

Ils sont réparties selon des critères obscures...

- mdv : Microdrive (en principe max 128ko)
- flp : Floppy disk (720Ko à 1.4Mo selon dispositif)

To be continued...

___
