---
title: Installer OCaml
description: "Cette annexe explique comment installer OCaml sous Mac OS X, Windows et Linux (Ubuntu, Debian, Fedora, etc)."
---

Selon votre système d’exploitation, l’installation d’OCaml ne se passera pas de la même façon.

## Windows

Un installateur [est disponible ici](https://github.com/fdopen/opam-repository-mingw/releases/download/0.0.0.2/OCaml64.exe).
Téléchargez-le et exécutez-le.

## Linux

### Debian, Ubuntu, Linux Mint, elementary OS, etc.

Utilisez la commande `sudo apt install -y ocaml`, entrez votre mot de passe et validez.

### Fedore, CentOS, RHEL

Utilisez la commande `sudo dnf install ocaml`, entrez votre mot de passe et validez.

### Autres distributions

Vous pouvez vous référer à [la documentation officielle](https://ocaml.org/docs/install.html).

## Mac OS X

Il vous faudra l’installateur d’application [Homebrew], que vous pouvez obtenir avec cette commande :

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Ensuite, faites :

```
brew install ocaml && brew install opam
```

Et OCaml sera installé.

## Lancer son code

Pour lancer du code, vous avez deux options. Dans tous les cas, il vous faudra un terminal (sous Windows, utilisez « Powershell »).

La première option est la commande `ocaml fichier.ml` (où `fichier.ml` est le nom du fichier avec votre code).

La seconde est la commande `ocaml`, qui ouvre un terminal interactif où on peut taper du OCaml (un peu comme IDLE pour Python).
Vous pouvez l’utiliser directement, ou charger des fichiers en tapant `#use "fichier.ml";;` (où `fichier.ml` est le nom de votre fichier de code).
Votre fichier sera alors chargé, et vous pourrez lancer de manière interactive ses fonctions.

Petite astuce : si vous voulez une version améliorée du terminal interactif OCaml (coloration et suggestions automatiques),
vous pouvez installer `utop` avec la commande `opam install utop`, et le lancer avec `utop`.
