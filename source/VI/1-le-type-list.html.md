---
title: Le type list
prev: '/V/3-autres-bonnes-pratiques'
next: '/VI/2-quiz'
illus: liste.jpg
---

Un type avec lequel on travaille assez souvent quand on écrit des programmes est le type « liste ».
Les ordinateurs sont très doués pour répéter plein de fois la même opération sur une série de données,
et les listes nous permettent justement de représenter ces séries de données !

Jusqu’à maintenant, on a vu qu’on pouvait le définir nous-même avec un type somme récursif (qui est soit
une liste vide, soit un élément suivi d’une autre liste). Mais OCaml fournit un type similaire par défaut : le type `list`.

Ce type a une petite particularité : il prend un paramètre. En effet, on ne l’a pas encore vu, mais il est possible
de paramétrer un type par un autre type. Ainsi le type `list` s’appelle en réalité le type `'a list` : `'a` est un
paramètre de type.

Concrètement, on remplacera `'a` par un « vrai » type la plupart du temps. Par exemple, le type d’une liste d’entiers
sera `int list`. Plus tard, on verra comment utiliser les types paramétrés plus en détails.

Comme la liste ne peut être paramétrée que par un seul type, on ne peut pas mélanger des valeurs de différents
types dans une liste, comme on pouvait le faire en Python.

## Créer des listes

Il existe deux syntaxes pour créer des listes.

La première ressemble à celle qu’on utilisait avec nos propres types de liste, parce qu’on a
un constructeur pour la liste vide, et un pour le cas récursif. La liste vide s’écrit `[]`, et
l’opérateur `::` ajoute un élément à une liste. On peut ainsi créer de petites listes de nombres :

```ocaml
let liste_vide : float list = []
let petite_liste : float list = 12.5 :: []
let moyenne_liste : float list = 1.7 :: 8.6 :: 88.56 :: []
```

La deuxième syntaxe ressemble plus à ce qu’on a en Python : on écrit les éléments entre crochets,
mais séparés par des point-virgules et pas des virgules :

```ocaml
let liste_vide : float list = []
let petite_liste : float list = [ 12.5 ]
let moyenne_liste : float list = [ 1.7 ; 8.6 ; 88.56 ]
```

## Manipuler des listes

Les listes d’OCaml se comportent donc comme un type récursif avec deux constructeurs : on peut
le manipuler avec le même genre de fonctions récursives et de pattern-matching :

```ocaml
(* Multiplie tous les éléments d’une liste par deux *)
let rec fois_deux (l : int list) : int list =
  match l with
  | [] -> []
  | element :: suite -> (element * 2) :: (fois_deux suite)
```

La déconstruction (donc le « pattern » à utiliser dans le `match`) fonctionne de la même façon que la construction,
comme on le voit avec le deuxième cas ici. Comme pour nos propres types de liste, `element` est un élément de la liste,
et `suite` est de type `int list`.

OCaml fournit en plus un opérateur pour concaténer (« additionner ») deux listes ensemble : `@`.

```ocaml
let grosse_liste = moyenne_liste @ petite_liste
(* grosse_liste vaut [ 1.7 ; 8.6 ; 88.56 ; 12.5 ] *)
```

Pour résumer, il n’y a rien de très nouveau avec ce type, à part des syntaxes différentes de celles vues avant.
