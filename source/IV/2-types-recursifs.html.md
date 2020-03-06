---
title: Les types récursifs
prev: '/IV/1-fonctions-recursives'
next: '/IV/3-quizz'
---

Un type récursif, un peu comme une fonction récursive, est un type qui se contient
lui-même dans sa définition. Ce sont donc des types sommes, dont un (ou plusieurs)
constructeur a une donnée associée du même type. Et là aussi, on définit un cas de base
non récursif.

On peut ainsi construire des listes d'éléments : le cas de base est la liste vide,
et le cas récursif est un élément suivie d'une autre liste.

Voici un exemple avec une liste d'entier :

```ocaml
type liste_entier =
  | Vide
  | Element of int * liste_entier

(* La liste [1, 2, 3] peut s'écrire : *)
let ma_liste =
  Element(
    1,
    Element(
      2,
      Element(
        3,
        Vide
      )
    )
  )
```

Mais on peut imaginer un exemple plus complexe, comme par exemple une liste qui contient soit
un `int` soit un `float` :

```ocaml
type liste_nombres =
  | Vide
  | ElementEntier of int * liste_nombres
  | ElementReel of float * liste_nombres
```

Les types récursifs peuvent être parcourus avec une fonction récursive qui fait un `match` sur les contructeurs :

```ocaml
let somme_elements (liste : liste_entier) : int =
  match liste with
  | Vide -> 0
  | Element(x, reste) -> x + (somme_elements reste)
```

Il n'y a pas grand chose de plus à dire sur les types récursifs. Le mieux pour bien les comprendre est de faire des
exercices où on les manipule.
