---
title: Arbres binaires
description: "Les arbres binaires sont une catégorie particulière d’arbre qui permettent l’implémentation de certains algorithmes particuliers."
illus: bintree.jpg
---

Les arbres binaires sont un type d’arbre un peu particulier : chaque nœud a au plus deux enfants.
Cela leur donne certaines propriétés pratiques que nous allons étudier plus tard.

Commençons par définir un arbre binaire générique :

```ocaml
type 'a arbre_bin =
  | Fin
  | Noeud of 'a * arbre_bin * arbre_bin
```

Remarquez qu’ici on n’utilise pas des feuilles avec des valeurs, mais juste un
constructeur constant `Fin`. De cette manière on n’est pas obligé d’avoir deux
embranchements à chaque fois, on peut en avoir zéro (fin de la branche), un (la branche continue dans une seule direction)
ou deux (l’arbre se sépare).

Ce type est doublement récursif, donc on peut utiliser des fonctions récursives pour le
manipuler. Par exemple, cette fonction donne la profondeur d’un arbre binaire :

```ocaml
let rec prof (arb : 'a arbre_bin) : int =
  match arb with
  | Fin -> 0
  | Noeud(_, enfant1, enfant2) ->
    (* On utilise la fonction standard max *)
    1 + (max (prof enfant1) (prof enfant2))
```

On peut aussi écrire une fonction qui fait la somme des éléments d’un arbre binaire d’entiers :

```ocaml
let rec somme (arb : int arbre_bin) : int =
  match arb with
  | Fin -> 0
  | Noeud(x, enfant1, enfant2) -> x + (somme enfant1) + (somme enfant2)
```

Et on peut aussi faire un peu d’ordre supérieur et faire une fonction comme `List.map`,
qui transforme un arbre binaire contenant des `'a` en arbre de `'b` avec une fonction donnée :

```ocaml
let rec transforme (f : 'a -> 'b) (arb : 'a arbre_bin) : 'b arbre_bin =
  match arb with
  | Fin -> Fin
  | Noeud(x, enfant1, enfant2) ->
    Noeud(f x, transforme f enfant1, transforme f enfant2)
```

Bref, on peut faire à peu près tout ce qu’on faisait avec des listes avant,
simplement nos fonctions sont maintenant doublement récursives puisque nos types
le sont aussi.

## Recherche dans un arbre binaire

Les arbres binaires permettent notamment d’écrire des algorithmes de recherche bien plus performants
que ceux qu’on peut avoir avec les listes.

Si vous voulez savoir si un élément appartient ou non à une liste, vous êtes obligés de parcourir
toute la liste jusqu’à trouver (ou non cet élément). Dans le pire des cas, c’est-à-dire lorsque l’élément n’est
pas présent, pour une liste de *n* éléments, il faudra *n* appels à votre fonction récursive de recherche.

```ocaml
(* Pour mieux visualiser, voici cette fonction *)
let appartient (x : 'a) (l : 'a l) : bool =
  match l with
  | [] -> false
  | elem :: suite -> (elem = x) || (appartient x suite)
```

Avec un arbre binaire, on peut classer les éléments pour faciliter la recherche.
Prenons un nœud avec une valeur quelconque `x`. Sur son enfant « de gauche », on mettra
un nœud avec une valeur plus petite que `x`, et sur son enfant « de droite » un nœud
avec une valeur plus grande que `x`. Ainsi, nos éléments sont bien ordonnés dans
l’arbre et c’est plus facile de les retrouver. Un arbre binaire classé de cette façon
s’appelle un **arbre de recherche binaire**.

Avec ce genre d’arbres, la fonction `appartient` fait seulement *E(log(n) + 1)* appels récursifs
(où *log* est le logarithme en base 2 vu qu’on a un arbre binaire, *E* la fonction partie entière,
et *n* la taille de l’arbre).

Écrivons cette fonction :

```ocaml
let rec appartient (x : 'a) (arb : 'a arbre_bin) : bool =
  match arb with
  | Fin -> false
  | Noeud(elt, gauche, droite) ->
    if x = elt then
      true
    else if x < elt then
      appartient x gauche
    else
      appartient x droite
```

On voit bien qu’à chaque nœud on peut maintenant diviser le problème en deux : selon
la valeur recherchée, on va soit à gauche soit à droite !

Cependant, pour que cet algorithme fonctionne il faut s’assurer que notre arbre reste
correctement ordonné. Il va donc falloir écrire une fonction d’insertion particulière,
qui place la valeur à ajouter au bon endroit. Voici un exemple de cette fonction :

```ocaml
let rec inserer (x : 'a) (arb : 'a arbre_bin) : 'a arbre_bin =
  match arb with
  | Fin -> Noeud(x, Fin, Fin)
  | Noeud(elt, gauche, droite) ->
    if elt = x then (* L'élément est déjà dans l'arbre *)
      Noeud(elt, gauche, droite) (* On renvoie donc le même arbre (on considère donc que les éléments sont uniques) *)
    else if x < elt then
      Noeud(elt, inserer x gauche, droite) (* On insère à gauche *)
    else
      Noeud(elt, gauche, inserer x droite) (* On insère à droite *)
```

Si la recherche et l’insertion dans un arbre binaire ne vous semble pas clair, je vous conseille
de prendre une feuille de papier, de dessiner un petit arbre binaire avec des entiers que vous choisissez
au hasard, et d’essayer de faire une recherche et une insertion « à la main », en faisant l’algorithme dans
votre tête.

## Démontrer les propriétés des arbres binaires

Pour prouver des propriétés des arbres binaires, on utilise le plus souvent
une généralisation de la démonstration par récurrence : **l’induction structurelle**.
Elle fonctionne un peu comme une double récurrence :

- On montre que la propriété est vraie pour un arbre vide ;
- Puis on suppose qu’elle est vraie pour deux sous-arbres `x` et `y`,
  et on montre alors qu’elle est aussi vraie pour l’arbre `Noeud(valeur, x, y)`
  (où `valeur` est une valeur quelconque).

On peut par exemple utiliser cette technique pour montrer que la recherche ne demande bien que
*E(log(n) + 1)* appels récursifs.

Pour l’initialisation, on va devoir « tricher », et partir d’un arbre avec un élément,
car *log(0)* n’est pas défini (mais c’est évident que la recherche dans l’arbre vide ne demande aucun
appel récursif à `appartient`, on est immédiatement dans le cas de base).

Pour *n = 1* donc, on est dans le pattern `Noeud(elt, gauche, droite)`, avec `gauche = droite = Fin`.
On est dans le second cas du pattern-matching de la fonction `appartient` : dans le pire des cas, c’est-à-dire
si `elt` ne correspond pas à l’élément recherché, on aura un appel récursif à faire et on arrivera alors
à la fin de l’arbre. On a donc un appel récursif en tout, et *1 = E(0 + 1) = E(log(1) + 1)*.

Maintenant, passons à l’hérédité. On suppose qu’on a deux arbres appelés `gauche` et `droite` de même taille
`taille`. La recherche dans ces arbres demande *E(log(taille) + 1)* appels récursifs.

Alors, la recherche dans l’arbre `Noeud(elt, gauche, droite)` demande, dans le pire des cas (si `elt` n’est pas l’élément
recherché), *E(log(taille) + 1) + 1* (le *+ 1* est pour l’appel qu’on va faire pour chercher dans un des deux enfants),
soit *E(log(taille) + 2)*.

Donc la propriété est bien vérifiée quelle que soit la taille de l’arbre.
