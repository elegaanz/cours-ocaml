---
title: Polymorphisme
description: "Le polymorphisme permet de créer des types paramétrés par d'autres types. Ce chapitre explique comment l'utiliser en OCaml."
---

Vous avez sans doute remarqué que certains types qu'on créait se ressemblaient beaucoup.
Par exemple, on a créé des types de listes comme ceux-ci :

```ocaml
type liste_int =
  | FinListeInt
  | Int of int * liste_int

type liste_string =
  | FinListeString
  | String of string * liste_string
```

La seule différence ici est le type des éléments de la séquence (`int` dans un cas, `string` dans l'autre).
Il existe beaucoup de fonctions qui pourraient être réutilisés entre ces deux types, comme la fonction
qui donne la taille d'une liste, comme cette fonction ne dépend pas du type contenu dans la liste.

Pour éviter de nous répéter dans ce genre de cas, OCaml nous propose une solution : le **polymorphisme**.

## Types génériques

L'idée est de créer un **type générique**, paramétré par un ou plusieurs autres types, un peu comme un fonction
est paramétrée par des valeurs. Au lieu d'écrire de « vrais » types lorsqu'on définit notre type générique,
on écrit un nom de type commençant par une apostrophe (par convention, on leur donne juste des noms de lettres : `'a`, `'b`, etc).
On précise aussi que ce type est paramétré en indiquant le nom des types paramètres avant son nom :

```ocaml
type 'a liste =
  | Fin
  | Element of 'a * liste
```

Dans cet exemple, on a rajouté un `'a` entre `type` et `liste`, et on a remplacé ce qui était tout à l'heure
`int` ou `string` par un `'a`.

Maintenant, on peut remplacer `'a` par n'importe quel type « réel ». Par exemple, si on veut une liste
de `int`, on utilisera le type `int liste`, pour une liste de `string` ça sera `string liste`, etc.

```ocaml
(* Fait la somme des éléments d'une liste *)
let rec somme (l : int liste) : int =
  match l with
  | Fin -> 0
  | Element(x, suite) -> x + (somme suite)

(* Concatène tous les strings d'une liste ensemble *)
let rec concat (l : string liste) : string =
  match l with
  | Fin -> ""
  | Element(x, suite) -> x ^ (concat suite)
```

## Fonctions polymorphes

Les fonctions peuvent également manipuler des types génériques directement. Si on n'a pas besoin d'un type
précis, on peut ainsi écrire des fonctions génériques. Pour reprendre notre exemple de liste générique,
calculer sa taille ne dépend pas du type des éléments qu'elle contient. On peut donc directement
écrire une fonction qui prend une `'a liste` en paramètre :

```ocaml
let rec taille (l : 'a liste) : int =
  | Fin -> 0
  | Element(_, suite) -> 1 + (taille suite)
```

## Plusieurs types en paramètres

On peut aussi préciser plusieurs types en paramètres, avec des parenthèses et des virgules.
Par exemple, on peut créer un type générique qui sert à indiquer si une opération a réussi ou non :

```ocaml
type ('a, 'b) resultat =
  | Succes of 'a
  | Echec of 'b

(* Un exemple d'utilisation : récupérer un message dans une discussion,
 * ce qui peut échouer pour plusieurs raisons *)

type erreur =
  | PasDeConnexion (* Quand on a oublié d'activer la 4G *)
  | PasLeDroit (* Si la discussion est privée par exemple *)

type message = string

(* Cette fonction donne soit un Succes avec un message,
 * soit un Echec avec une erreur. *)
let recuperer_message : (message, erreur) resultat = (* On fait le nécéssaire pour récupérer le message… *)

let afficher_message =
  match recuperer_message with
  | Succes(msg) -> "Nouveau message : " ^ msg
  | Echec(err) -> match err with
    | PasDeConnexion -> "Erreur : pas de connexion"
    | PasLeDroit -> "Erreur : vous ne pouvez pas lire cette discussion"
```
