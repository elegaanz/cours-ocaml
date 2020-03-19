---
title: Autres bonnes pratiques
prev: '/V/2-realiser-une-mesure'
next: '/VI/1-le-type-list'
---

Il existe quelques autres astuces pour rendre son code le plus clair et le plus solide possible,
en plus des spécifications et des mesures.

## Les commentaires « d’ensemble »

On définit parfois des types synonymes qui sont en réalité trop « larges » pour ce qu’on veut réellement.
Par exemple, on pourrait modéliser le numéro d’un jour dans un mois (entre 1 et 31 donc) avec `int`, et écrire :

```ocaml
type jour_dans_mois = int
```

Comme le type `int` peut représenter des valeurs qui ne nous intéressent pas (`518` par exemple), on précise
généralement à côté à quel sous-ensemble on se limitera :

```ocaml
type jour_dans_mois = int (* 1 - 31 *)
```

## Écrire des tests

OCaml fournit une fonction appelée `assert`, qui sert à écrire des tests. Elle prend un seul argument de type
`bool`. Si cet argument vaut `true`, elle ne fera rien. S’il vaut `false`, elle fera planter tout le programme.
On peut donc l’utiliser pour écrire une série d’assertions que l’on pense vraie. Ensuite, on lance notre code,
et s’il plante, on saura que quelque chose ne s’est pas passé comme prévu : soit nos tests sont mal écrits, soit
la fonction testée à un souci.

Voici un exemple d’utilisation simple :

```ocaml
let ajouter x y = x + y

assert (ajouter 2 3 = 5)
assert (ajouter 8 1 = 9)
assert (ajouter 3 -2 = 1)
assert (ajouter 7 7 = 10) (* Ce test est faux : notre programme va planter. *)
```

Dans cet exemple c’est le test qui est mal écrit, mais c’est beaucoup plus facile d’écrire un ensemble de tests
corrects que d’écrire une fonction correcte, donc c’est souvent l’inverse (la fonction est incorrecte) qui a lieu.
