---
title: Les types sommes
prev: '/III/3-types-produits'
next: '/III/5-types-structures'
---

Cette façon de définir des types est sans doute la plus utile et la plus courante en OCaml,
et en programmation fonctionnelle en générale. Cette fois, on décrit différentes formes que peut
prendre notre type. On limite donc ses valeurs à un ensemble restreint, ayant chacun un sens différent.
Ces différentes façon de construire notre type s'appellent des **constructeurs**.

La syntaxe générale pour définir un type somme est la suivante :

```ocaml
type NOM = CONSTRUCTEUR_1 | CONSTRUCTEUR_2
```

On sépare donc les différents constructeurs par des `|`. Ici je n'en ai mis que deux, mais
on peut en avoir autant qu'on veut. Leurs noms sont écrits avec une majuscule, et on utilise
aussi des majuscules pour séparer les mots dans un même nom de constructeur : on écrira
`MonConstructeur` et pas `Mon_constructeur` par exemple.

Voyons un petit exemple :


