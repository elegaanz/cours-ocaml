---
title: Le module List
description: "En plus du type list, OCaml fournit un module nommé List pour manipuler de manière efficace des séries de données."
---

Pour manipuler les listes de manière efficace, OCaml nous fournit un module `List` pour manipuler des listes de manière efficace.
Je vais présenter ici les fonctions les plus importantes de ce module. Certaines sont similaires à celles qui ont été réalisées
dans les exercices du chapitre précédent.

## Fonctions de base

### length

```ocaml
List.lenght : 'a list -> int
```

Cette fonction prend une liste en paramètre, et renvoie sa taille.

### hd

```ocaml
List.hd : 'a list -> 'a
```

Donne le premier élément de la liste (`hd` signifie « head », « tête »). Cette fonction plantera si
la liste est vide, donc vérifiez toujours sa taille avant.

### tl

```ocaml
List.tl : 'a list -> 'a
```

Donne le dernier élément de la liste (`tl` signifie « tail », « queue »). Cette fonction aussi plante
avec la liste vide.

### nth

```ocaml
List.nth : 'a list -> int -> 'a
```

Donne le n-ième élément d'une liste. Si `n` est plus grand que la taille de la liste, on aura une erreur au moment
de l'exécution.

### sort

```ocaml
List.sort : ('a -> 'a -> int) -> 'a list -> 'a list
```

Trie une liste suivant une fonction de comparaison donnée en premier argument. En général, on utilisera la fonction
prédéfinie `compare`. Attention, il se peut que cette fonction soit interdite en examen.

### init

```ocaml
List.init : int -> (int -> 'a) -> 'a list
```

Un peu plus complexe cette fois. Cette fonction initialise une liste. Le premier argument est le nombre d'élément de la liste.
Le second est une fonction qui à un indice associe une valeur. Et la valeur retournée est la liste générée.

Voici un exemple :

```ocaml
let carre x = x * x
let ma_liste = List.init 5 carre
(* ma_liste vaut [ 0 ; 1 ; 4 ; 9 ; 16 ] *)
```

## Fonctions d'itérations

### map

```ocaml
List.map : ('a -> 'b) -> 'a list -> 'b list
```

Associe à tout élément d'une liste de type `'a` un élément de type `'b`.
Le premier paramètre est la fonction qui fait cette association, le second est la liste de départ,
et la valeur retournée est la liste obtenue.

Un exemple, avec une fonction qui transforme une liste de caractères en la liste de leur codes ASCII :

```ocaml
List.map int_of_char [ 'a' ; 'b' ; 'Z' ]
(* Donne [ 97 ; 98 ; 90 ] *)
```

### filter

```ocaml
List.filter ('a -> bool) -> 'a list -> 'a list
```

Filtre une liste en fonction d'un prédicat. La première fonction va être appliquée à tous les élements
de la liste, et si elle renvoie `true` l'élement en question sera gardé. Voici un exemple pour ne garder que
les élements pairs d'une liste :

```ocaml
List.filter (fun x -> (x mod 2) = 0) [ 1; 2; 3; 10; 11; 19; 38 ]
```

### find

```ocaml
List.find ('a -> bool) -> 'a list -> 'a
```

Donne le premier élément correspondant à un prédicat. Si on veut trouver le premier élément d'une
liste supérieur à 10, on peut par exemple faire :

```ocaml
List.find (fun x -> x > 10) [ 1; 5; 15; 12; 5; ]

(* ou, si on veut laisser le choix de la liste, on peut faire une application partielle : *)
let plus_que_dix = List.find (fun x -> x > 10)
plus_que_dix [ 5; 12 ]
plus_que_dix [ 87 ; 50 ; 1 ]
```

### fold_left

```ocaml
List.fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
```

Celle-ci est sans doute la plus complexe à comprendre. Observons ses paramètres :

- On a d'abord une fonction qui à un `'a` et à un `'b` associe un `'a` ;
- On a ensuite un `'a` ;
- Et enfin une liste de `'b`.

Cette fonction fait ce qu'on appelle un « pli » (d'où le nom « fold »). Elle prend tous les éléments de la
liste et les compacte en un seul. Elle utilise pour cela la fonction qu'on lui donne.

Elle commence par appeler cette fonction avec le second argument (de type `'a`), et le premier élément de la liste
(de type `'b`). Cette fonction renvoie un `'a`, qui va venir remplacer l'original. Notre fonction est alors de nouveau
appelée, mais avec le nouveau `'a`, et l'élément suivant dans la liste. Le `'a` est à nouveau remplacé. Et ça recommence,
jusqu'à atteindre la fin de la liste.

Au final, cette fonction permet de faire des choses équivalentes aux accumulateurs en Python. Par exemple, le code suivant :

```python
def somme(liste):
  somme = 0 # La valeur par défaut
  for x in liste:
    somme += x
  return somme
```

Peut être écrit de cette façon en OCaml :

```ocaml
let somme liste = List.fold_left (fun somme x -> somme + x) 0 liste

(* On peut même se passer de "liste", si on utilise la magie de l'application partielle : *)
let somme = List.fold_left (fun somme x -> somme + x) 0

(* Et si on se rappelle que + est aussi une fonction, on peut même écrire directement : *)
let somme = List.fold_left (+) 0
```

Il existe aussi un équivalent à `fold_left` mais qui parcourt la liste de la fin vers le début, et qui s'appelle sans trop de surprise `fold_right`.

Il existe d'autres fonctions, je n'ai listé que les plus importantes. Vous pouvez toutes
les retrouver [dans la documentation officielle](https://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html).
