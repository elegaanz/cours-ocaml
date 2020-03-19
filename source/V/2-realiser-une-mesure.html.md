---
title: Réaliser une mesure
prev: '/V/1-ecrire-une-specification'
next: '/V/3-autres-bonnes-pratiques'
illus: rulers.jpg
---

Quand on écrit du code récursif, il est parfois difficile de voir si notre fonction se termine bien pour tous les cas.
Or on voudrait bien éviter de se retrouver avec une fonction qui n’arrête pas de s’appeler elle-même indéfiniment.
On va donc écrire ce qu’on appelle une mesure, qui nous permet de facilement voir si une fonction diminue ou non.

Une **mesure** est une expression (généralement sous la forme d’une fonction) qui dépend des mêmes paramètres
que la fonction récursive à tester, et qui donne un `int`. Cette valeur doit être décroissante au fur et à mesure des appels
récursifs, c’est-à-dire que si on appelle successivement la mesure avec les mêmes arguments que la fonction récursive (en passant au
cas « précédent » à chaque fois donc), on aura bien une suite décroissante. En plus de ça, une mesure doit toujours donner un résultat
strictement positif.

Avec ces contraintes, on peut facilement s’assurer que notre fonction récursive se termine, grâce au théorème qui dit qu’une suite décroissante
et positive (donc minorée par 0) converge : à un moment on atteindra 0, ce qui signifie qu’on a atteint le cas de base.

Prenons un exemple. Voici une fonction qui fait la somme des entiers entre -3 et `x` :

```ocaml
let rec ma_somme x =
  if x = -3 then
    0
  else
    x + (ma_somme (x - 1))
```

On veut écrire une mesure de cette fonction. Il faut donc trouver une autre fonction :

1. qui dépende de `x` ;
2. qui donne un `int` ;
3. qui soit décroissante entre deux appels récursifs de `ma_somme` ;
4. qui soit toujours positive ;

On peut donc prendre :

```ocaml
let mesure x = x + 3
```

En effet, cette fonction dépend de `x` et donne un `int`. Pour ce qui est de la décroissance entre
deux appels récursifs, il faut prendre un exemple et voir comment `ma_somme` s’appelle elle-même.
Commençons avec `ma_somme 2` :

- `x` vaut d’abord `2` ;
- puis `x` vaut `1` ;
- puis `0` ;
- puis `-1` ;
- puis `-2` ;
- et enfin `-3` et la fonction s’arrête ;

Si on applique ces mêmes arguments à notre mesure on obtient :

- `mesure 2 = 5`
- `mesure 1 = 4`
- `mesure 0 = 3`
- `mesure -1 = 2`
- `mesure -2 = 1`
- `mesure -3 = 0`

Donc `mesure` donne bien des résultats strictement décroissants entre deux appels récursifs.

Prendre un exemple comme on l’a fait n’est pas la meilleure façon de prouver la décroissance d’une mesure.
Il vaut mieux observer que dans la fonction de base (ici `ma_somme`), l’appel récursif se fait avec une valeur
décroissante de `x`, et que la mesure est décroissante si son paramètre est décroissant.

Cependant, dans notre exemple, le dernier point (la mesure est positive) n’est pas vérifié : il est facile de voir qu’avec
-10 comme valeur de `x` on aura une mesure négative. C’est donc soit que notre mesure est mal chosie, soit que la fonction mesurée
a un problème.

Et en effet, elle a un problème : `ma_somme -10` bouclerait à l’infini. On peut donc corriger notre code en changeant l’égalité de `ma_somme`
par une inégalité et en ajoutant une condition à la mesure.

```ocaml
let ma_somme x =
  if x <= -3 then
    0
  else
    x + (ma_somme (x - 1))

let mesure x =
  if x < -3 then
    0
  else
    x + 3
```

Et voilà !

Parfois, on ne demandera pas d’écrire une mesure sous la forme d’une fonction, mais de simplement dire comment la réaliser :
par exemple dans le cas d’une fonction qui manipule une séquence, on dira souvent qu’on peut en réaliser une mesure en prenant
la taille de la liste.
