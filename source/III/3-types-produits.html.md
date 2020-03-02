---
title: Les types produits
prev: '/III/2-types-produits'
next: '/III/4-types-sommes'
---

Nous allons maintenant voir un autre type de types (🤔️) : les types produits.
On les appelle aussi n-uplets ou tuples (c'est ce nom qu'on utilise en Python).
L'idée est juste de grouper plusieurs valeurs de types différents ensembles.
On les appelle types produits par analogie avec les produits d'ensembles en maths.

Pour définir un type produit, on note les types des différentes valeurs à grouper,
séparés par des `*`. Par exemple, si on veut modéliser une heure de la journée
par trois `int` (un pour l'heure, un pour les minutes, un pour les secondes), on
écrira :

```ocaml
int * int * int
```

Et en général, on définit un synonyme pour ces types, pour pouvoir les réutiliser
facilement :

```ocaml
type temps = int * int * int
```

Pour créer des valeurs de ce type, on les groupe entre parenthèses et on les sépare par des virgules (comme en Python) :

```ocaml
type temps = int * int * int

(* Cette constante est bien de type temps, ou int * int * int, les deux étant équivalents *)
let fin_des_cours = (16, 45, 0)
```

En plus de construire des valeurs de ce type, vous pouvez aussi les « déconstruire » (ou les « exploser », selon votre
niveau de délicatesse). Pour celà, on fait un `let` « multiple », avec les différents éléments du tuple à
récupérer :

```ocaml
(* fin_des_cours est de type int * int * int *)
let (heures, minutes, secondes) = fin_des_cours
(* heures, minutes et secondes sont trois nouvelles constantes, de type int *)
```

Remarquez aussi que les parenthèses sont en réalité optionelles quand on construit ou déconstruit
ces types, mais on les met en général pour plus de clarté, et moins d'ambiguïté, aussi bien pour nous
que pour le compilateur OCaml.

La déconstruction peut aussi être utilisée directement dans les arguments d'une fonction :

```
let ajouter_une_heure (heure, minutes, secondes : temps) = (heure + 1, minutes, secondes)
```

On peut aussi utiliser la déconstruction pour les cas d'un pattern-matching :

```ocaml
let repas (heure : temps) : string =
  match heure with
  | (7, _, _) | (8, _, _) -> "Petit déjeuner"
  | (12, 0, 0) -> "Déjeuner"
  | (16, 30, 0) -> "Goûter"
  | (19, 30, 0) -> "Dîner"
  | (h, _, _) -> (string_of_int h) ^ " heures ? C'est pas l'heure de manger !"
```

Et les comparaisons fonctionnent aussi, on peut donc utiliser des `if` avec une valeur de type produit :

```ocaml
(* Un couple nom + mot de passe *)
type identifiants = string * string

let message_secret id =
  if id = ("Philippe Poutou", "jaimelescrepes") then
    "Bonjour camarade Poutou !"
  else
    "Nom ou mot de passe incorrect."
```
