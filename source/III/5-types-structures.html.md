---
title: 'Bonus : les types structurés'
description: "OCaml permet de définir des structures avec différents champs, comme en C, Java ou en Rust."
---

Cette façon de créer des types n’est pas au programme du cours original, mais peut tout de même s’avérer utile.

Les types structurés sont assez similaires aux types produits, car on groupe plusieurs valeurs ensemble.
La différence est qu’on donne un nom à chaque valeur, pour pouvoir les identifier plus facilement.
On utilise toujours le mot-clé `type`, suivi du nom qu’on veut lui donner, et un égal.
Ensuite, on ouvre des accolades, et on commence à définir les différentes valeurs (appelés « champs »), en donnant leur nom et leur type
séparés par des `:`. On sépare chaque valeur par des point-virgules.

Voici un exemple, avec la modélisation d’un contact (dans une application de messagerie par exemple) :

```ocaml
type contact = {
  nom : string;
  prenom : string;
  age : int;
  telephone : int * int * int * int * int; (* 5 nombres séparés sont plus lisibles qu’un seul *)
  email : string;
}
```

Pour construire des valeurs de ce type, on ouvre des accolades, et on écrit une égalité entre
un nom de champ et une valeur. On doit fournir tous les noms qu’on a donnés lors de la définition du type.
Voici un exemple :

```ocaml
let manon = {
  nom : "Sélon" ;
  prenom : "Manon" ;
  age : 18 ;
  telephone : (06, 06, 66, 66, 06) ; (* C’est un faux, n’essayez pas de l’appeler, merci. *)
  email : "manon.selon@gmail.com" ;
}
```

On peut aussi déconstruire les valeurs d’un type structuré, de cette façon :

```ocaml
let { nom, prenom, age  } = manon
(* On a maintenant trois nouvelles constantes : nom, prenom et age *)
```

Remarquez qu’on n’est pas obligé de donner tous les champs qu’on veut récupérer lors de la destructuration.
On peut aussi utiliser d’autres noms avec cette syntaxe :

```ocaml
let { nom = nom_de_manon ; age = age_de_manon } = manon
(* On a deux nouvelles constantes : nom_de_manon et age_de_manon *)
```

Et comme on peut déconstruire ces valeurs, on peut aussi matcher dessus :

```ocaml
let sappelle_manon (cont : contact) : bool =
  match cont witt
  | { prenom = "Manon" } -> true
  | _ -> false
```

On peut également lire la valeur d’un champ individuel avec `VALEUR.CHAMP` :

```ocaml
let nom_complet (cont : contact) : string =
  cont.prenom ^ " " ^ cont.nom
```
