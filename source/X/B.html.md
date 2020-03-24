---
title: Configurer son éditeur pour OCaml
description: "Cette annexe explique comment configurer son éditeur de code (VS Code, Atom, Sublime text, Emacs, Vim) pour écrire du OCaml."
illus: editor.webp
---

On suppose que vous avez déjà un éditeur de code installé, et que vous voulez juste
y ajouter le support d’Ocaml.

## Visual Studio Code

Ouvrez un terminal et faites :

```bash
opam install merlin

# Puis
opam install ocp-indent
```

Ces commandes prendront un peu de temps. Ensuite, ouvrez Visual Studio Code, faites `Ctrl`+`P`, copiez cette commande :

```
ext install hackwaly.ocaml
```

et validez.

Astuce : si vous mettez `#!/usr/bin/env ocaml` sur la toute première ligne de votre fichier, vous pourrez le lancer directement depuis Visual Studio Code.

## Atom

Ouvrez un terminal et faites :

```bash
opam install merlin

# Puis
opam install ocp-indent
```

Dans Atom, allez dans les paramètres, puis dans l’onglet « Packages » et installer les paquets :

- `language-ocaml-fix` si vous voulez juste la coloration ;
- `atom-ide-ui` et `ide-reason` en plus si vous voulez des suggestions et de rapports d’erreurs.

## Sublime Text

La coloration est normalement disponible directement. Des suggestions de code peuvent être ajoutées avec [cette extension](https://packagecontrol.io/packages/OCaml%20Autocompletion).

## Vim ou Neovim

Les paquets suivants sont recommandés (exemple avec Vim-Plug, adaptez la configuration à un autre gestionnaire de paquets si besoin).

```vim
Plug 'vim-syntastic/syntastic'
Plug 'jpalardy/vim-slime'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
```

Ensuite, pour exécuter du code OCaml en direct, ouvrez un terminal avec `ocaml` ou `utop` :

```bash
:edit term://ocaml
# ou
:edit term://utop
```

Récupérez l’identifiant de ce terminal avec :

```
:echo b:terminal_job_id
```

Mettez votre curseur sur une expression OCaml, et faites `Ctrl`+`C`+`C` (appuyez deux fois sur `C` sans lâcher `Ctrl`).
Si on vous demande une ID, entrez l’identifiant du terminal et validez : votre code a été exécuté dans l’interpréteur.

## Emacs

Le mode Tuareg est recommandé. Voici [sa documentation officielle](https://github.com/ocaml/tuareg#install) pour l’installation.
