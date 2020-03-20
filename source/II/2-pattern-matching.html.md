---
title: Le pattern-matching
illus: 'match.png'
---

En plus du `if`/`else` OCaml nous propose une autre façon, beaucoup plus puissante de
créer des conditions : le pattern-matching. L’idée générale est d’associer un cas à une valeur,
en décrivant tous les cas possibles, un peu comme un `if`/`else`. Là où le pattern matching devient intéressant
est qu’il permet justement de reconnaître des patterns, et pas de simples égalités.

La différence entre un « pattern » et une égalité classique peut sembler floue pour l’instant, mais dès que
nous aurons vu comment créer nos propres types vous comprendrez très bien la différence.

La syntaxe du pattern-matching en OCaml utilise les mots-clés `match` et `with` :

```ocaml
match x with
| cas1 -> resultat1
| cas2 -> resultat2
```

Où `x` est la valeur à tester. Si cette valeur correspond à un des cas listé, alors on renverra le résultat associé à ce cas.
Les cas proposés doivent donc avoir le même type que `x`, et les différents résultats possibles doivent aussi avoir un seul type.
On peut reprendre notre exemple des départements de toute à l’heure :

```ocaml
let numero_departement = 38
let nom_departement =
  match numero_departement with
  | 1 -> "Ain"
  | 19 -> "Correze"
  | 38 -> "Isere"
```

Ici, OCaml va tester tous les patterns qu’on lui propose (dans l’ordre), et dès qu’il en trouve un qui correspond à la valeur
testée (ici `numero_departement`), il nous donnera le résultat correspondant. Donc dans notre exemple, on aura `nom_departement`
qui vaudra `"Isere"`.

Maintenant, imaginez le même exemple qu’au-dessus, mais avec un numéro de département qui vaille `35` à la place de `38`.
Que va-t-il se passer ? OCaml nous affiche une erreur, mais quand on lance notre programme, pas au moment de la
compilation (on appelle ces erreurs des *exceptions*) :

```
Exception: Match_failure
```

Et en effet, il vous a normalement prévenu que certains cas n’étaient pas couvert par le `match` que nous avons
écrit (avec un `Warning: this pattern-matching is not exhaustive`). Pour éviter ce genre de soucis, on utilise
généralement un *cas de base*, qui va forcément « matcher » si aucun autre pattern n’a fonctionné avant.
Par convention, on le note juste `_`.

```ocaml
(* J’en ai fait une fonction pour plus de clarté *)
let nom_departement num =
  match num with
  | 1 -> "Ain"
  | 19 -> "Correze"
  | 38 -> "Isere"
  | _ -> "Inconnu"
```

Si on veut récupérer la valeur sur laquelle on essaie de matcher,
un identificateur fonctionne aussi, et « créera » une nouvelle constante avec la valeur qu’on matchait :

```ocaml
let nom_departement num =
  match num with
  | 1 -> "Ain"
  | 19 -> "Correze"
  | 38 -> "Isere"
  | autre -> "Le département numéro " ^ (string_of_int autre)
```

Ici, `nom_departement 35` donnera `"Le département numéro 35"`.

On peut aussi associer plusieurs cas avec un même résultat, en les séparant par un `|` :

```ocaml
let region num =
  match num with
  | 1 | 15 | 38 | 63 | 69 -> "Auvergne Rhone-Alpes"
  | 19 | 24 | 33 | 40 | 64 -> "Nouvelle Aquitaine"
  | _ -> "Région inconnue"
```

## Bonus : le mot clé `function`

Si vous écrivez une fonction qui n’a qu’un seul argument et que vous voulez juste faire un match sur cet argument,
vous pouvez utiliser le mot-clé `function` qui permettra de raccourcir un peu votre code :

```ocaml
let f = function
  | cas1 -> resultat1
  | cas2 -> resultat2
```

Ce code est équivalent à :

```ocaml
let f x =
  match x with
  | cas1 -> resultat1
  | cas2 -> resultat2
```

## Deuxième bonus : les gardes

Il existe aussi une syntaxe permettant de « combiner » un if à un pattern, avec le mot-clé `when`,
suivi d’une expression booléenne :

```ocaml
(* Une fonction pour savoir quand passe le prochain tram, en minutes
 * (les nombres sont un peu pris au hasard, ne vous fiez pas à cette fonction quand vous attendez un tram)
 *)
let attente jour heure =
  match jour with
  | "Lundi" | "Mardi" | "Mercredi" | "Dimanche" when heure < 21 -> 5 (* 5 minutes en journée *)
  | "Lundi" | "Mardi" | "Mercredi" | "Dimanche" -> 20 (* 20 minutes en soirée *)
  | _ -> 5 (* Les autres jours les trams circulent tout le temps, même le soir *)
```
