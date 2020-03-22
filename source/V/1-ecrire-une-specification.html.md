---
title: Écrire une spécification
description: "Comprendre où on va avant de coder est important. Écrire une spécification peut aider à bien concevoir son programme en avance."
---

Quand on commence à réaliser des fonctions un peu complexe, il peut être difficile
d’écrire du code correct du premier coup. On sort alors généralement un papier et un crayon
et on commence à faire des schémas ou à écrire des exemples pour mieux comprendre comment
fonctionnera notre code.

De même, il peut parfois être complexe de comprendre du premier coup d’œil ce que fait une
fonction, quand on lit du code.

Pour éviter ces problèmes, on va souvent passer par une étape de **spécification**, qui
consiste à réfléchir et à écrire de manière explicite le fonctionnement de notre code.
Ensuite, on passera à **l’implémentation**, c’est-à-dire le code en lui-même. Ainsi,
on sait où on va quand on écrit notre code plutôt que de tâtonner, et on évite ainsi
beaucoup d’erreurs de raisonnement.

Concrètement, une spécification est un commentaire qu’on place juste avant le code d’une fonction
(ou qui peut être en dehors du code, notamment en examen si on vous demande juste une spécification).
Ce commentaire contient :

- Le **nom** de la fonction ;
- Son **profil**, qui correspond aux ensembles de départ et d’arrivée, en termes mathématiques (on écrira ℝ et pas `float` par exemple) ;
- Si besoin, une **signature**, qui est similaire au profil mais en terme OCaml (c’est littéralement le type de la fonction).
  Si elle est similaire au profil, pas besoin de la mettre ;
- Une **description** (aussi appelée *sémantique*), qui explique avec des mots ce que fait cette fonction ;
- Si c’est une fonction récursive, ses **équations récursives** (on va revenir dessus un peu plus bas) ;
- De préférence, des **exemples pertinents** d’utilisation ;

Voici un exemple concret avec une fonction qui donnerait le maximum de deux éléments :

```ocaml
(* maximum : ℕ → ℕ → ℕ
 *           int -> int -> int
 *
 * Renvoie le maximum de deux entiers.
 *
 * maximum 2 3 = 3
 * maximum 5 5 = 5
 *)
```

Pour rendre les différentes parties plus explicites, on met souvent des titres devant :

```ocaml
(* SPÉCIFICATION : maximum
 * PROFIL :        ℕ → ℕ → ℕ
 * SIGNATURE :     int -> int -> int
 *
 * SÉMANTIQUE :    Renvoie le maximum de deux entiers.
 *
 * EXEMPLES :
 *
 *   maximum 2 3 = 3
 *   maximum 5 5 = 5
 *)
```

Ici, écrire à la fois le profil est la signature fait du sens, car on n’écrit pas les ensembles ℕ et `int` de la
même façon en « mathématiques » et en OCaml. Mais si on avait le code suivant :

```ocaml
type seq =
  | Fin
  | Element of int * seq

let rec foix_deux (s : seq) : seq =
  match s with
  | Fin -> Fin
  | Element(x, suite) -> Element(x * 2, fois_deux suite)
```

On pourrait écrire ce commentaire au-dessus de `foix_deux` pour la spécifier, sans distinction entre profil et signature :

```ocaml
(* SPÉCIFICATION : premier
 * PROFIL :        seq → seq
 *
 * SÉMANTIQUE :    Multiplie tous les éléments d’une séquence par deux.
 *
 * EXEMPLES :
 *
 *   foix_deux (Element(1, Element(5, Fin))) = (Element(2, Element(10, Fin)))
 *)
```

## Les équations récursives

Quand on écrit des fonctions récursives, une étape supplémentaire est ajoutée à la spécification :
l’écriture d’équations récursives. Il s’agit simplement d’équations qui ressemblent plus ou moins
à celles qu’on pourrait trouver en mathématiques, et qui disent comment se comporte notre fonction récursive
dans les différents cas. Concrètement, c’est une autre façon d’écrire les différents cas du `match` ou du `if`/`else`
qu’on mettra dans notre code. Mais contrairement au match, l’ordre des différents cas n’a pas d’importance, car
on précisera à chaque fois dans quel cas on se trouve s’il y a ambiguïté.

Voici un exemple (sans le reste de la spécification, uniquement les équations récursives)
avec une fonction qui calcule la somme d’une séquence d’entiers (avec le même type `seq` qu’au-dessus) :

```ocaml
(* …
 *
 * ÉQUATIONS RÉCURSIVES :
 *   somme(Fin) = 0
 *   somme(Element(x, suite)) = x + somme(suite)
 * …
 *)
let rec somme (s : seq) : int =
  match s with
  | Nil -> 0
  | Element(x, suite) -> x + (somme suite)
```

La « syntaxe » des équations récursives n’est pas la même que celle d’OCaml : on essaie de se rapprocher de l’écriture
dont on a l’habitude en mathématiques.

Voici un autre exemple avec la somme des entiers entre 0 et *n*, pour montrer comment éviter les ambiguïtés entre deux cas :

```ocaml
(* …
 *
 * ÉQUATIONS RECURSIVES :
 *   somme(0) = 0
 *   somme(x) = x + somme(x - 1), pour x ≠ 0
 * …
 *)
let rec somme (x : int) : int =
  match x with
  | 0 -> 0
  | autre -> autre + (somme (autre - 1))
```
