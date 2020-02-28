---
title: Plus de types !
prev: '/I/2-premiers-pas'
next: '/I/4-les-fonctions'
---

Comme nous l'avons vu sur la page précédente, OCaml a un type pour les entiers (`int`),
et un pour les flottants (`float`), comme Python ! La seule différence est qu'il y a des
opérateurs différents pour ces types :

|                | `int`     | `float`             |
| -------------- | --------- | ------------------- |
| Exemples       | `2`, `-2` | `2.`, `1e3`, `3.14` |
| Addition       | `+`       | `+.`                |
| Soustraction   | `-`       | `-.`                |
| Multiplication | `*`       | `*.`                |
| Division       | `/`       | `/.`                |
| Modulo         | `mod`     | `mod_float`         |

Mais OCaml possède bien sûr d'autres types de base.

## Les booléens

Le type `bool` existe aussi en OCaml, et fonctionne à peu près de la même façon qu'en Python.
La principale différence est qu'on écrit `true` et `false` sans majuscules.
Les opérateurs logiques ne s'écrivent aussi pas de la même façon, mais leur fonctionnement est le même :

|             |                           |
| ----------- | ------------------------- |
| Et logique  | `&&`                      |
| Ou logique  | <code>&#124;&#124;</code> |
| Non logique | `not`                     |

Les opérateurs de comparaison sont quasiment les mêmes qu'en Python : `<`, `<=`, `>`, `>=`.
Seuls l'égalité et la différence changent : on utilisera respectivement `=` et `<>` en OCaml
(`==` et `!=` existent aussi, mais n'ont pas exactement le sens qu'on attend intuitivement).
Les opérateurs de comparaison ont l'avantage de fonctionner pour n'importe quel type,
tant que l'expression à droite et à gauche sont de même type (on peut comparer deux `int`, ou deux `float`,
mais pas un `int` et un `float`).

## Le texte

En OCaml, une distinction est faite entre un caractère seul et une châine de caractères.

- les premiers, de type `char` s'écrivent entre guillemets simples : `'a'` ;
- les seconds, sont de type `string` et s'écrivent avec des guillemets doubles : `"Bonjour !"`.

Attention, `'a'` et `"a"` sont donc différents. De plus, contrairement à Python qui supporte en plus
de la table ASCII les caractères Unicode (permettant d'avoir des accents, des caractères d'autres alphabets, des émojis, etc),
OCaml supporte mal l'Unicode : il vaut mieux éviter de mettre d'accents dans les textes qu'on manipulera.

Et, comme `+` sert à l'addition de deux entiers, l'opérateur pour concaténer deux `string` est `^`.

## Passer d'un type à l'autre

OCaml fournit plusieurs fonctions pour passer d'un type à un autre.
Elles ont toutes un nom de la forme `DEST_of_ORIG`, où `DEST` est le type de « destination »,
et « ORIG » le type d'origine. Par exemple, pour faire la conversion d'un `float` en `int`,
on utilisera `int_of_float`.

Vous ne savez pas encore appeler des fonctions pour l'instant, mais c'est l'objet de la page suivante !
