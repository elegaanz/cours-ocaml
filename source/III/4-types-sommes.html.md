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

```ocaml
type taille = Petit | Moyen | Grand
type garniture = Vegetarien | Poulet | Boeuf
type sauce = Fromage | Algerienne | Curry | Harissa | Samurai | Blanche

type tacos = taille * garniture * sauce
```

Ici on a défini trois types sommes : `taille`, `garniture` et `sauce` (`tacos` est un type produit).
L'avantage des types sommes est qu'il est impossible de créer des valeurs en dehors des constructeurs qu'on
a défini : avec les types qu'on a implémenté au dessus, il n'y a pas moyen d'avoir un tacos « XXL »[^dommage]

Pour créer une valeur de ce type, on utilise ensuite le nom d'un des constructeurs :

```ocaml
let ma_sauce_favorite = Curry
```

On peut faire du pattern-matching sur une valeur qui a un type énuméré :

```ocaml
let prix_viande (v : viande) : float =
  match v with
  | Vegetarien -> 4.5
  | Poulet -> 5.0
  | Boeuf -> 6.0
```

Les égalités aussi fonctionnent, donc on peut utiliser les `if`/`else` :

```ocaml
let prix_taille (t : taille) : float =
  if taille = Petit then
    4.0
  else if taille = Moyen then
    5.0
  else
    5.5
```

Notez qu'on n'est pas obligé d'écrire la définition du type sur une seule ligne. Dès qu'il commence à y avoir
beaucoup de constructeurs, faire un retour à la ligne avant chaque `|` est même conseillé :

```ocaml
type region =
  | AuvergneRhoneAlpes
  | Bretagne
  | GrandEst
  | HautsDeFrance
  | IleDeFrance
  | NouvelleAquitaine
  | Occitanie
  | ProvenceAlpesCoteDAzur
(* etc. je les connais pas toutes, mais vous avez compris *)
```

## Associer des données aux constructeurs

On peut aussi, de manière optionelle, associer des informations à un constructeur. Pour préciser le type de
ces informations, on utilise le mot-clé `of` après le nom du constructeur, suivi du type qu'on veut.
Pour créer des valeurs avec ce constructeur, on précisera entre parenthèse après le nom du constructeur la valeur associée.

Par exemple, si on veut créer un type énuméré pour le résultat d'une fonction qui peut échouer, on pourrait faire :

```ocaml
type resultat =
  | Ok of float (* On devra associer un float avec le constructeur Ok *)
  | Erreur

(* On peut utiliser ce type pour implémenter une fonction de division qui ne plante pas.
 * En cas d'erreur, elle retournera juste Erreur, et on sera obligé de gérer le cas où la division a échoué ensuite *)
let div (x : float) (d : float) : resultat =
  if d = 0.0 then
    Erreur (* Division par 0 impossible *)
  else
    Ok(x /. d) (* C'est ici qu'on utilise notre constructeur avec des données associées *)
```

On peut aussi déconstruire les valeurs de ce genre de constructeurs, et donc les utiliser avec du
pattern-matching :


```ocaml
let ma_division = div 5. 2.

(* ma_division est de type resultat, donc on ne peut pas récupérer la valeur potentielle sans gérer
 * le cas où on a eu une Erreur. On peut donc être sûr que notre programme ne plantera pas. *)
match ma_division with
| Ok(res) -> "5 divisé par 2 donne : " ^ (string_of_float res)
| Erreur -> "On ne peut pas faire cette division !"
```

Les types qu'on associe au constructeur peuvent bien sûr être plus complexes : on peut utiliser
des types sommes, produits, etc.

## Différence entre type somme, énuméré et algébrique

Les types sommes sont aussi parfois appelés types énumérés ou types algébriques.
Il n'y a pas vraiment de différence en réalité, mais si elle vous est demandé lors d'un
contrôle d'INF201, sachez que :

- Si votre type n'a que des constructeurs « simples » (sans valeur associée), c'est un type énuméré ;
- Si il a au moins un constructeur avec une valeur associée, c'est un type somme.

[^dommage]: ce qui est bien dommage, il faudrait peut-être changer la définition de `taille`…
