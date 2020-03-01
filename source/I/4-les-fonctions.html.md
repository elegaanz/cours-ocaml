---
title: Les fonctions
illus: math.jpg
next: '/I/5-quizz'
prev: '/I/3-plus-de-types'
---

Comme nous l'avons dit un peu plus tôt, les fonctions sont au centre du langage OCaml.
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
- ce « corps » de la fonction ne contient qu'une seule expression, pas une suite d'instructions ;
- cette unique instruction est toujours le résultat retourné par la fonction.

Cette syntaxe minimaliste peut sembler un peu étrange au premier abord, mais on s'y habitue rapidement,
et elle s'avère très pratique quand on commence à faire du OCaml à un niveau un peu plus avancé (c.f. la section bonus).

Si on tape cette commande dans l'interpréteur OCaml, on peut obtenir le type de la fonction :

```ocaml
f
```

On voit donc que cette fonction a un type elle aussi : `int -> int -> int`.
Ce qu'il faut savoir sur cette notation, c'est que les premiers types sont ceux des arguments,
et le dernier celui de la valeur de retour. Ici, les deux arguments `x` et `y` sont bien des `int`, et leur
addition est bien un `int` aussi. Si vous voulez comprendre pourquoi cette notation qui semble peut intuitive
a été choisie, vous pouvez lire la section bonus.

Une bonne pratique (c'est même demandé lors des examens à l'UGA), est de noter explicitement le type de ses fonctions.
Pour celà, on utilise la syntaxe `(argument : type)` à la place de juste `argument`. Et pour la valeur de retour,
on indique son type avec `: type` juste avant le `=`.

```ocaml
let f (x : int) (y : int) : int = x + y
```

Cette notation est plus longue, mais elle a l'avantage de rendre explicite les types des différentes expressions.
Ainsi, il est plus simple de raisonner sur cette fonction, car on voit clairement quelles valeurs les arguments
et la valeur retournée peuvent prendre.

### Petite astuce : les définitions multiples

Vous pouvez aussi définir plusieurs fonctions à la fois, en séparant leur déclarations par un
`and` (qui n'a rien à voir avec un `&&`, attention) :

```ocaml
let identite x = x and carre x = x * x and cube x = x * x * x
```

Mais avec cette syntaxe, on ne peut pas utiliser les fonctions qu'on a défini juste avant dans les définitions de la même ligne.
Par exemple, on n'aurait pas pu écrire :

```ocaml
let carre x = x * x and cube x = (carre x) * x
```

Car la fonction `carre` n'existe pas encore vraiment quand on l'utilise dans la définition de `cube`.

## Appeler une fonction

Maintenant que nous avons une première fonction (n'hésitez pas à en créer d'autres d'ailleurs), voyons comment l'appeler.

```ocaml
f 1 2
```

Et voilà ! Normalement, l'interpréteur vous a bien répondu avec un `3`. Si vous avez besoin de passer des expressions
plus complexes en arguments, vous pouvez les entourer de parenthèses :

```ocaml
f (4 * 3) 7 (* Donne 19 *)
```

## Et les variables ?

Le concept de variable n'existe pas réellement en OCaml[^refs]. Cependant, on peut avoir des constantes, avec des fonctions sans
arguments :

```ocaml
let pi = 3.1415
```

De plus, on peut définir des fonctions uniquement de façon locale, en les limitant à une expression. Pour celà, après la déclaration
de la fonction, on ajoute le mot-clé `in`, et une expression dans laquelle on pourra utiliser la fonction qu'on vient de définir.

```ocaml
let cube x = x * x * x in (cube 2) + (cube 3)

(* Sans définir cube auparavant, on aurait dû écrire : *)
(2 * 2 * 2) + (3 * 3 * 3)
```

En général, on met un retour à la ligne après un `in` pour rendre le code plus lisible.
Il est donc possible d'imbriquer les `let` et les `let/in` :

```ocaml
(* Cette fonction donne la norme d'un vecteur 2D, à partir de ses coordonées *)
let norme (x : float) (y : float) : float =
  let carre a = a * a in
  let x_carre = carre x in
  let y_carre = carre y in
  sqrt (x_carre + y_carre) (* sqrt est une fonction de base d'OCaml *)
```

## Bonus : curryfication

On va maintenant essayer de comprendre la notation `int -> int -> int` qu'on a vu tout à l'heure, quand on
voulu voir le type de la fonction `f`. Pour cela, voyons le type des fonctions suivantes :

```ocaml
let sans_argument = 0 (* int *)

let un_argument x = x (* int -> int *)

let deux_arguments x y = x + y (* int -> int -> int *)
```

Rien de bien nouveau. Mais maintenant, remarquez qu'on pourrait aussi noter le type de `deux_arguments` de cette façon :

```ocaml
let deux_arguments x y = x + y (* int -> (int -> int) *)
```

Cette notation et celle d'avant sont équivalentes. Mais celle-ci met en avant quelque chose de très important :
`deux_arguments` prend en réalité un seul argument de type `int`, et renvoie une valeur de type `int -> int`.
C'est donc une fonction qui renvoie une fonction !

![Functions, functions everywhere](/images/functions-everywhere.jpg)

Ce concept, qu'on appelle *curryfication*, nous permet d'écrire :

```ocaml
let ajouter x y = x + y
ajouter 1 2 (* Donne bien 3 *)

let ajouter_deux = ajouter 2 (* Remarquez qu'on ne donne qu'un argument à "ajouter" *)
ajouter_deux 5 (* Donne bien 7 *)
```

L'intéret peut sembler assez limité, mais cette abstraction est très puissante et très utile dès qu'on commence à réaliser de vrais programmes.

Si vous avez du mal avec le concept de fonctions retournant des fonctions, voici un équivalent au code
ci-dessus en Python (cet exemple marche totalement d'ailleurs, ce n'est pas une syntaxe hypothétique) :

```python
def ajouter(x):
    def ajouter_bis(y): # Cette fonction est « cachée » en OCaml, mais bien présente
        # Ici, on peut utiliser les arguments x et y !
        return x + y

    return ajouter_bis # "ajouter" renvoie une fonction ! On appelle pas "ajouter_bis", il n'y a pas de parenthèses

ajouter(1)(2) # C'est là qu'on voit que la syntaxe d'OCaml est plus adaptée, en Python c'est… étrange

ajouter_deux = ajouter(2) # ajouter_deux est une fonction
ajouter_deux(5)
```

Si vous n'avez pas totalement compris cette dernière partie, ce n'est pas très grave. La curryfication n'est pas simple à
saisir du premier coup, même si elle peut aider à mieux comprendre le fonctionnement d'OCaml.

[^refs]: En réalité, le concept de *référence* y correspond à peu près, mais on évite de l'utiliser, et nous n'en parlerons pas dans ce cours.
