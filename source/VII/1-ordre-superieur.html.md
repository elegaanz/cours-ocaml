---
title: Ordre supérieur
description: "OCaml est un langage d'ordre supérieur : des fonctions peuvent prendre en paramètre d'autres fonctions, et retourner des fonctions."
---

Depuis le début de ce cours, on manipule des fonctions. On va maintenant passer au niveau
au-dessus avec l'ordre supérieur, en manipulant des fonctions de fonctions.
Ça peut faire peur, ou sembler incompréhensible, mais
ne vous inquiétez pas, il n'y a rien de très compliqué en réalité.

Un langage est dit d'ordre supérieur si on peut utiliser des fonctions comme arguments d'autres
fonctions et si une fonction peut en renvoyer une autre. Et c'est le cas d'OCaml !

Prenons un exemple simple : la composition d'une fonction avec elle même
Petit rappel : le type d'une fonction qui prend des `a`, `b`, et `c` comme
arguments et renvoie un `d` s'écrit `a -> b -> c -> d`. Admettons qu'on veuille
composer une fonction de type `int -> int`. On peut alors écrire :

```ocaml
let composition (f : int -> int) (x : int) : int = f (f x)
```

`composition` est une fonction d'ordre supérieur : elle prend une autre fonction
comme premier argument. On peut l'utiliser de cette façon par exemple :

```ocaml
let ajoute_deux (x : int) : int = x + 2

composition ajoute_deux 4 (* ajoute_deux (ajoute_deux 4) = 2 + 2 + 4 = 8 *)
```

Attention, ici `4` n'est pas l'argument de `ajoute_deux`, mais bien celui de `composition`.
Pour vous aidez à comprendre l'exemple ci-dessus, voici l'équivalent en Python :

```python
def composition(f):
  return f(f(x))

def ajoute_deux(x):
  return x + 2

composition(ajoute_deux, 4) # On appelle pas ajoute_deux, on donne juste son nom
```

L'ordre supérieur devient assez intéressant quand on manipule des listes : on peut appliquer une
fonction à tous les éléments d'une liste par exemple. Ou filtrer une liste en se basant sur une fonction
donnée.

Mais comme il a été dit plus haut, l'ordre supérieur permet aussi de renvoyer des fonctions.
Voici un exemple :

```ocaml
let bonjour (nom : string) : string = "Bonjour " ^ nom
let hello (nom : string) : string = "Hello " ^ nom
(* bonjour et hello sont de types string -> string *)

(* Saluer renvoie une fonction de type string -> string *)
let saluer (langue : string) : (string -> string) =
  match langue with
  | "francais" -> bonjour (* On renvoie juste la fonction, on ne l'appelle pas avec des arguments *)
  | _ -> hello

let saluer_en_anglais = saluer "anglais" (* La fonction hello sera renvoyée *)
saluer_en_anglais "Jeanne" (* donne "Hello Jeanne" *)
```

Ici aussi, je vous met l'équivalent en Python pour vous aidez à comprendre :

```python
def bonjour(nom):
  return "Bonjour " + nom

def hello(nom):
  return "Hello " + nom

def saluer(langue):
  if langue == "francais":
    return bonjour # On retourne bien la fonction, on ne l'appelle pas
  else:
    return hello

saluer_en_anglais = saluer("anglais")
saluer_en_anglais("Jeanne")
```

## Toujours plus de fun

Pour créer des fonctions « à la volée », c'est-à-dire sans avoir à leur donner un nom en avance, on peut utiliser
le mot-clé `fun` qui crée une fonction anonyme, sans nom. On écrit juste `fun`, le nom des arguments de la fonction,
puis une flèche (`->`) et le corps de la fonction. Voici le même exemple qu'au dessus, sauf que cette fois, on
ne définit pas `bonjour` et `hello` en avance :

```ocaml
let saluer langue =
  match langue with
  | "francais" -> (fun nom -> "Bonjour " ^ nom)
  | _ -> (fun nom -> "Hello " ^ nom)
```

Peut-être que tout n'est pas encore très clair pour vous, mais si besoin la prochaine page et les exercices à la
fin du chapitre vous aiderons.
