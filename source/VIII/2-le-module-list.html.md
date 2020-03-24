---
title: Le module List
description: "En plus du type list, OCaml fournit un module nommé List pour manipuler de manière efficace des séries de données."
---

Pour manipuler les listes de manière efficace, OCaml nous fournit un module `List`.
Je vais présenter ici les fonctions les plus importantes de ce module. Certaines sont similaires à celles qui ont été réalisées
dans les exercices du chapitre précédent.

Pour chaque fonction, j'utiliserais la présentation suivante :

> ### nom de la fonction
>
> ```ocaml
> List.nom_de_la_fonction : type -> de -> la -> fonction
> ```
>
> Description.
>
> ```ocaml
> (* Exemples *)
> ```

Pour utiliser ces fonctions, vous pouvez soit écrire leur nom complet, de la forme
`List.nom`, soit ajouter l'instruction `open List` au début de votre code pour importer
toutes le module, et donc écrire seuleument leur nom.

Attention aussi, `List` avec une majuscule est bien le nom du module, pas la variable
qui correspond à votre liste. On passe toujours la liste à manipuler en paramètre de la fonction.

Enfin, dernier conseil avant de se lancer dans cette énumération de fonctions pas toujours passionnantes :
pour chaque fonction, essayez de bien comprendre comment elle marche, et de l'utiliser vous-même au moins une fois.
C'est comme ça que vous les maîtriserez le plus facilement (c'est valable pour le reste de ce cours d'ailleurs, et pour
beaucoup d'autres cours en général).

## Fonctions de base

### length

```ocaml
List.lenght : 'a list -> int
```

Cette fonction prend une liste en paramètre, et renvoie sa taille.

```ocaml
List.length [ 'a' ; 'b' ; 'c' ] (* Donne 3 *)
```

### hd

```ocaml
List.hd : 'a list -> 'a
```

Donne le premier élément de la liste (`hd` signifie « head », « tête »). Cette fonction plantera si
la liste est vide, donc vérifiez toujours sa taille avant.

```ocaml
List.hd [ 42 ; 3 ; 87 ] (* Donne 42 *)
```

### tl

```ocaml
List.tl : 'a list -> 'a
```

Donne le dernier élément de la liste (`tl` signifie « tail », « queue »). Cette fonction aussi plante
avec la liste vide.

```ocaml
List.tl [ 42 ; 3 ; 87 ] (* Donne 87 *)
```

### nth

```ocaml
List.nth : 'a list -> int -> 'a
```

Donne le n-ième élément d'une liste. Si `n` est plus grand que la taille de la liste, on aura une erreur au moment
de l'exécution.

```ocaml
List.nth [ 1 ; 2 ; 10 ; 0 ] 2 (* Donne 10 *)
```

### sort

```ocaml
List.sort : ('a -> 'a -> int) -> 'a list -> 'a list
```

Trie une liste suivant une fonction de comparaison donnée en premier argument. En général, on utilisera la fonction
prédéfinie `compare`. Attention, il se peut que cette fonction soit interdite en examen.

```
List.sort compare [ 12 ; 7 ; 33 ] (* Donne [ 7 ; 12 ; 33 ] *)
```

### init

```ocaml
List.init : int -> (int -> 'a) -> 'a list
```

Un peu plus complexe cette fois. Cette fonction initialise une liste avec les valeurs données par une fonction.
Le premier argument est le nombre d'élément de la liste.
Le second est une fonction qui à un indice associe une valeur. Et la valeur retournée est la liste générée.

Voici un exemple :

```ocaml
let carre x = x * x
let ma_liste = List.init 5 carre
(* ma_liste vaut [ 0 ; 1 ; 4 ; 9 ; 16 ] *)

(* On peut aussi utiliser le mot-clé fun pour faire la même chose en une seule ligne *)
List.init 5 (fun x -> x * x)
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

Ou encore, une transformation qui double tous les nombres d'une liste :

```ocaml
let double x = x *. 2.0

List.map double [ 3.0 ; 7.2 ; 1.8 ]
(* Donne [ 6.0 ; 14.4 ; 3.6 ] *)

(* Là aussi, on peut utiliser fun si on veut : *)
List.map (fun x -> x *. 2.0) [ 3.0 ; 7.2 ; 1.8 ]
```

### filter

```ocaml
List.filter ('a -> bool) -> 'a list -> 'a list
```

Filtre une liste en fonction d'une condition. La première fonction va être appliquée à tous les élements
de la liste, et si elle renvoie `true` l'élement en question sera gardé. Voici un exemple pour ne garder que
les élements pairs d'une liste :

```ocaml
let est_pair x = (x mod 2) = 0
List.filter est_pair [ 1 ; 2 ; 3 ; 10 ; 11 ; 19 ; 38 ]

(* Ou, avec fun : *)
List.filter (fun x -> (x mod 2) = 0) [ 1 ; 2 ; 3 ; 10 ; 11 ; 19 ; 38 ]
```

### find

```ocaml
List.find ('a -> bool) -> 'a list -> 'a
```

Donne le premier élément correspondant à une condition. Si on veut trouver le premier élément d'une
liste supérieur à 10, on peut par exemple faire :

```ocaml
let sup_a_dix x = x > 10
List.find sup_a_dix [ 1 ; 5 ; 15 ; 12 ; 5 ] (* Donne 15 *)

(* La même chose avec fun : *)
List.find (fun x -> x > 10) [ 1 ; 5 ; 15 ; 12 ; 5 ]

(* ou, si on veut laisser le choix de la liste, on peut faire une application partielle : *)
let plus_que_dix = List.find (fun x -> x > 10) (* Il « manque » un argument à List.find *)

plus_que_dix [ 5; 12 ] (* Donne 12 *)
plus_que_dix [ 87 ; 50 ; 1 ] (* Donne 87 *)
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
let addition x y = x + y
let somme liste = List.fold_left addition 0 liste

(* La même chose avec fun : *)
let somme liste = List.fold_left (fun somme x -> somme + x) 0 liste

(* On peut même se passer de « liste », si on utilise la magie de l'application partielle : *)
let somme = List.fold_left (fun somme x -> somme + x) 0

(* Et si on se rappelle que + est aussi une fonction, on peut même écrire directement : *)
let somme = List.fold_left (+) 0

somme [ 3 ; 4 ; 10 ] (* Donne 3 + 4 + 10 = 17 *)
```

Il existe aussi un équivalent à `fold_left` mais qui parcourt la liste de la fin vers le début, et qui s'appelle sans trop de surprise `fold_right`.

Il existe d'autres fonctions, je n'ai listé que les plus importantes. Vous pouvez toutes
les retrouver [dans la documentation officielle](https://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html).
