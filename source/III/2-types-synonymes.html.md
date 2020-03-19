---
title: Les types synonymes
prev: '/III/1-theorie'
next: '/III/3-types-produits'
---

La première façon de créer nos propres types est  de créer des types synonymes.
L’idée est juste de créer un « alias » pour un type qui existe déjà.
La syntaxe est :

```ocaml
type NOM = TYPE
```

Où `NOM` est le nom de notre alias, et `TYPE` le type. Les noms de types en OCaml
sont toujours en minuscule, avec des `_` si on a besoin de séparer des mots (on
écrit `mon_type` et pas `monType`). Vous pourrez ensuite utiliser les mêmes fonctions
et les mêmes opérateurs qu’avec le type original, et vous pourrez utiliser les deux types
de manière interchangeable.

L’intérêt peut sembler limité, mais créer des types synonymes permet de rendre
votre code plus clair : plutôt que d’utiliser les mêmes types partout, vous pouvez
leur donner un sens. Comparez ces deux exemples :

```ocaml
(* Sans types synonymes *)

let v (d : float) (t : float) : float = d /. t
(* On a une fonction du type float -> float -> float *)
```

```ocaml
(* On commence par définir nos types synonymes *)
type vitesse = float
type temps = float
type distance = float

(* Puis on les utilise dans notre fonction *)
let v (d : distance) (t : temps) : vitesse = d /. t
(* Le type de cette fonction est distance -> temps -> vitesse, ce qui est beaucoup plus clair *)
```

![Meme Spiderman](/images/spiderman.jpg)

Avec des types synonymes, on a donc moins de chance de se tromper et d’intervertir des valeurs.

Mais ce n’est clairement pas la façon de créer des nouveaux types la plus intéressante,
ni la plus utile dans la réalité.
