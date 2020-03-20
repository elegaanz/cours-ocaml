---
title: Présentation d’OCaml
---

Dans cette première partie, nous allons essayer de répondre aux questions « Qu’est-ce que c’est OCaml ? »
et « Pourquoi utiliser OCaml ? ». Si ces questions ne vous intéressent pas, vous pouvez directement passer
à la suite.

## Un peu d’histoire

L’Inria (*Institut National de Recherche en Informatique et Automatique*) est l’une des principales
organisations française dédiée à la recherche en informatique. En 1996, des chercheurs de l’Inria
publient la première version d’OCaml, qui dérive d’autres langages de la même famille : Caml Light,
Caml, et ML notamment.

Depuis, OCaml est devenu un langage important dans le paysage des langages *fonctionnels*, utilisé
dans les Universités du monde entier, mais aussi dans les entreprises.

## Un langage fonctionnel ?

Si vous êtes là, vous avez sans doute suivi l’UE INF101, qui utilise le langage Python pour nous apprendre
les bases de la programmation. Or Python, du moins dans l’utilisation qui en a été faite, est un langage
*impératif* (si vous n’avez pas suivi l’UE d’INF101, ce n’est pas grave, la plupart des langages comme C, C++,
Java, C#, etc. sont aussi plus ou moins impératifs). Un langage impératif a une certaine approche pour résoudre
un problème donné, qu’on ne pourra pas réutiliser avec les langages fonctionnels.

En effet, dans un langage fonctionnel, tout tourne autour des fonctions (quelle surprise).
Ainsi, on essaie au maximum de manipuler les données et de résoudre nos problèmes en utilisant des fonctions.
Concrètement, ça veut par exemple dire qu’on ne pourra pas utiliser de boucles.

J’imagine que vous vous demandez comment on peut arriver à réaliser de vrais programmes sans boucles,
mais ne vous inquiétez pas, il existe d’autres moyens de faire la même chose, juste avec des fonctions !

L’approche fonctionnelle peut sembler étrange, voire incompréhensible au début. Mais c’est une question d’habitude,
et dans certains cas, elle est même beaucoup plus agréable à utiliser que l’approche impérative (notamment pour manipuler des listes).

## OCaml dans la vraie vie

OCaml est un langage avec lequel il est possible de réaliser de vrais programmes (heureusement). Parmi ces utilisateurs
on retrouve par exemple Facebook, Jane Street (une entreprise de Wall Street), ou Airbus.

L’Inria a également utilisé OCaml pour créer le logiciel *Coq* qui permet de vérifier des théorèmes mathématiques à l’aide d’un ordinateur.

## Installer OCaml

[L’annexe A](/X/A) explique comment installer OCaml si vous voulez l’utiliser sur votre ordinateur.

Sinon, il existe [cet interpréteur en ligne](https://try.ocamlpro.com/) qui vous permettra de tester de petits programmes.
