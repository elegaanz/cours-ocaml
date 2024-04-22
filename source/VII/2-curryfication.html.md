---
title: Curryfication
description: "En OCaml, les fonctions peuvent être appliquées partiellement, on n’est pas obligé de donner tous les arguments d’un coup. Ce processus s’appelle la curryfication."
illus: curry.webp
---

Pour bien comprendre comment l’ordre supérieur fonctionne, et pour pouvoir l’utiliser à plein potentiel,
nous allons descendre dans les entrailles d’OCaml, et chercher à comprendre comment les fonctions sont
réellement représentées (ne vous inquiétez pas, tout va bien se passer).

Commençons avec quelques fonctions simples :

```ocaml
let a = 12 (* Cette fonction est de type int *)
let b x = x + 12 (* Cette fonction est de type int -> int *)
let c x y = x + y (* Cette fonction est de type int -> int -> int *)
```

Jusque-là tout va bien, rien de nouveau. Maintenant, remarquez qu’on peut ajouter des parenthèses
au type de la fonction `c`, et l’écrire comme ceci sans qu’il change : `int -> (int -> int)`.

Ce qu’on met en évidence ici, c’est que `c` n’a qu’un argument de type `int`, et n’a qu’une valeur de retour
de type `int -> int`. `c` renvoie une fonction !

![Functions, functions everywhere](/images/functions-everywhere.jpg)

Cette transformation d’une fonction qui en apparence a un type `int -> int -> int` en une fonction de type
`int -> (int -> int)` est faite de manière transparente par OCaml pour nous. Ce processus s’appelle la curryfication,
et apporte l’avantage de pouvoir faire des applications partielles.

## Applications partielles

Si `c` est de type `int -> (int -> int)`, on devrait pouvoir lui donner un seul argument et elle devrait pouvoir
renvoyer une valeur de type `int -> int` sans souci. Essayons :

```ocaml
let d = c 10
```

Ça fonctionne : `d` est bien de type `int -> int` ! C’est la même fonction que `c`, mais avec `x` valant
forcément `10`. Le seul paramètre à donner est `y`. Par exemple `d 5` donnera `15` (10 + 5).

On n'est donc pas obligé de donner tous les arguments d’une fonction à la fois : on peut l’appliquer partiellement !

Si vous voulez, voici le code équivalent en Python :

```python
def c(x):
  def c_prime(y): # Cette fonction est « cachée » en OCaml, mais on doit l’écrire à la main en Python
    return x + y # Ici on peut utiliser à la fois x et y

  return c_prime

# On peut appeler c directement avec deux arguments, même si la syntaxe de Python devient peu pratique :
c(10)(5)

# Ou on peut l’appliquer partiellement :
d = c(10)
d(5)
```

Ça veut aussi dire qu’on peut écrire des fonctions qui en apparence ne prennent pas d’arguments mais qui
en ont, car elles retournent une autre fonction :

```ocaml
let addition x y = x + y
let ajouter_deux = addition 2
```

Si on regarde avant le `=` de `ajouter_deux`, on pourrait penser qu’elle n’attend aucun argument.
Or si on veut un vrai résultat, et pas juste une fonction, il faudra bien lui en donner un,
`addition 2` étant une application partielle.

## Bonus : les opérateurs sont des fonctions

Si vous encadrez un opérateur avec des parenthèses, OCaml vous donne la fonction qui se cache derrière cet
opérateur. Ainsi `(+)` est de type `int -> int -> int` (à deux entiers, on associe leur somme). Cette fonctionnalité
peut être pratique dans certains cas, par exemple pour construire une calculatrice :

```ocaml
(* On imagine que a et b sont des entiers saisis par l’utilisateur, et op une opération *)
let calculatrice (a : string) (op : string) (b : string) : int =
  let a = int_of_string a in
  let b = int_of_string b in
  let f = match op with
    | "+" -> ( + )
    | "-" -> ( - )
    | "*" -> ( * )
    | "/" -> ( / )
    | _ -> ( mod )
  in
  f a b

calculatrice "12" "*" "2" (* Donne bien 24 *)
```
