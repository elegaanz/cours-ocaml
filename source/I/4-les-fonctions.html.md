---
title: Les fonctions
illus: math.jpg
description: "Les fonctions sont un des éléments de base d'OCaml. Dans ce chapitre, nous allons apprendre comment les créer et les appeler."
---

Comme nous l’avons dit un peu plus tôt, les fonctions sont au centre du langage OCaml.
Ça tombe bien, nous allons voir comment en créer, et comment en appeler.

## Créer une fonction

En OCaml, on utilise le mot-clé `let` pour définir une fonction :

```ocaml
let f x y = x + y
```

Pour mieux voir à quoi ce code correspond, voici un équivalent en Python :

```python
def f(x, y):
    return x + y
```

On remarque plusieurs différences :

- les arguments ne sont pas listés entre parenthèses, mais directement après le nom de la fonction ;
- ils ne sont pas non plus séparés par des virgules, juste des espaces entre leurs noms ;
- le « corps » de la fonction commence avec un signe `=` ;
- ce « corps » de la fonction ne contient qu’une seule expression, pas une suite d’instructions ;
- cette unique instruction est toujours le résultat retourné par la fonction.

Cette syntaxe minimaliste peut sembler un peu étrange au premier abord, mais on s’y habitue rapidement,
et elle s’avère très pratique quand on commence à faire du OCaml à un niveau un peu plus avancé (c.f. la section bonus).

Si on tape cette commande dans l’interpréteur OCaml, on peut obtenir le type de la fonction :

```ocaml
f
```

On voit donc que cette fonction a un type elle aussi : `int -> int -> int`.
Ce qu’il faut savoir sur cette notation, c’est que les premiers types sont ceux des arguments,
et le dernier celui de la valeur de retour. Ici, les deux arguments `x` et `y` sont bien des `int`, et leur
addition est bien un `int` aussi. Si vous voulez comprendre pourquoi cette notation qui semble peu intuitive
a été choisie, on en reparlera [dans le chapitre sur la curryfication](/VII/2-curryfication).

Une bonne pratique (c’est même demandé lors des examens à l’UGA), est de noter explicitement le type de ses fonctions.
Pour cela, on utilise la syntaxe `(argument : type)` à la place de juste `argument`. Et pour la valeur de retour,
on indique son type avec `: type` juste avant le `=`.

```ocaml
let f (x : int) (y : int) : int = x + y
```

Cette notation est plus longue, mais elle a l’avantage de rendre explicite les types des différentes expressions.
Ainsi, il est plus simple de raisonner sur cette fonction, car on voit clairement quelles valeurs les arguments
et la valeur retournée peuvent prendre.

### Petite astuce : les définitions multiples

Vous pouvez aussi définir plusieurs fonctions à la fois, en séparant leurs déclarations par un
`and` (qui n’a rien à voir avec un `&&`, attention) :

```ocaml
let identite x = x and carre x = x * x and cube x = x * x * x
```

Mais avec cette syntaxe, on ne peut pas utiliser les fonctions qu’on a définies juste avant dans les définitions de la même ligne.
Par exemple, on n’aurait pas pu écrire :

```ocaml
let carre x = x * x and cube x = (carre x) * x
```

Car la fonction `carre` n’existe pas encore vraiment quand on l’utilise dans la définition de `cube`.

## Appeler une fonction

Maintenant que nous avons une première fonction (n’hésitez pas à en créer d’autres d’ailleurs), voyons comment l’appeler.

```ocaml
f 1 2
```

Et voilà ! Normalement, l’interpréteur vous a bien répondu avec un `3`. Si vous avez besoin de passer des expressions
plus complexes en arguments, vous pouvez les entourer de parenthèses :

```ocaml
f (4 * 3) 7 (* Donne 19 *)
```

## Et les variables ?

Le concept de variable n’existe pas réellement en OCaml[^refs]. Cependant, on peut avoir des constantes, avec des fonctions sans
arguments :

```ocaml
let pi = 3.1415
```

De plus, on peut définir des fonctions uniquement de façon locale, en les limitant à une expression. Pour celà, après la déclaration
de la fonction, on ajoute le mot-clé `in`, et une expression dans laquelle on pourra utiliser la fonction qu’on vient de définir.

```ocaml
let cube x = x * x * x in (cube 2) + (cube 3)

(* Sans définir cube auparavant, on aurait dû écrire : *)
(2 * 2 * 2) + (3 * 3 * 3)
```

En général, on met un retour à la ligne après un `in` pour rendre le code plus lisible.
Il est donc possible d’imbriquer les `let` et les `let/in` :

```ocaml
(* Cette fonction donne la norme d’un vecteur 2D, à partir de ses coordonnées *)
let norme (x : float) (y : float) : float =
  let carre a = a * a in
  let x_carre = carre x in
  let y_carre = carre y in
  sqrt (x_carre + y_carre) (* sqrt est une fonction de base d’OCaml *)
```

[^refs]: En réalité, le concept de *référence* y correspond à peu près, mais on évite de l’utiliser, et nous n’en parlerons pas dans ce cours.
