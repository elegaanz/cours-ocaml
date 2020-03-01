---
title: Premiers pas en OCaml
illus: kindergarten.jpg
prev: '/I/1-presentation'
next: '/I/3-plus-de-types'
---

Vous allez maintenant écrire vos premières lignes d'OCaml !
Pour commencer, ouvrez un interpréteur (`utop` de préférence, mais ça peut être `ocaml` ou un interpréteur en ligne).

Dans l'interpréteur, toutes les commandes doivent se terminer par `;;` (deux points virgules à la suite).
OCaml sait ainsi quand est ce que vous avez fini d'écrire et qu'il peut exécuter votre code.
Si vous écrivez du code dans des fichiers, vous n'en aurez normalement pas besoin.

Essayez de taper un calcul simple pour commencer (validez avec *Entrée*) :

```ocaml
2 + 2;;
```

Normalement, l'interpréteur devrait vous répondre quelque chose comme :

```ocaml
- : int = 4
```

Pour le moment, seule la partie à droite du `=` nous intéresse : notre calcul a fonctionné, 2 et 2 font 4.
C'est un bon début ! Vous pouvez essayer d'autres opérateurs comme `*`, ou `-`.

Cependant, il y a des petites subtilités à saisir pour certains opéateurs :

- `/` donne le quotient de la division euclidienne (comme `//` en Python). Le résultat est donc un entier.
- `mod` correspond au `%` en Python : il donne le reste de la division euclidienne.

Et enfin, sans doute ce qui va être le plus perturbant dans un premier temps : ces opérateurs ne fonctonnent pas
avec des nombres flottants (les nombres à virgule). Si vous tapez ce calcul par exemple, vous aurez une erreur :

```ocaml
(* À partir de maintenant, je n'écrirais plus les ;; mais pensez à les mettre si besoin *)
2.8 + 0.2
```

Pour comprendre pourquoi nous avons cette erreur, il va falloir se pencher sur la définition d'une expression, et sur celle d'un type.

Une **expresion** est simplement un morceau de code que l'ordinateur peut interpréter, calculer, et dont il peut trouver la valeur.
En OCaml, tout ou presque est une expression. Mais si on prend l'exemple de Python :

```python
12 # C'est une expression, qui vaut simplement 12
12 + 7 # C'est un expression, qui vaut 19 (remarquez qu'elle est composée à partir d'autre expressions plus simple, comme 12 et 7)
print("Bonjour !") # C'est aussi une expression, même si elle vaut None (soit rien)

a = 12 # Cette ligne n'est pas une expression, "a = 12" n'a pas de valeur, c'est une juste une instruction
```

De manière générale, pour savoir si ce que vous avez sous les yeux est une expression, demandez vous :
*« Est ce que je pourrais enregistrer cette valeur dans une variable ? »*. Si on reprend nos trois exemples du dessus,
on voit bien que c'est possible pour les deux premières lignes mais pas pour la dernière :

```python
x = (12 + 7) # Pas de souci
y = (print("Bonjour !")) # C'est un peu plus étrange, parce qu'on a une variable qui ne contient « rien », mais ça marche
z = (a = 12) # Même si ça pourrait sembler logique dans un autre contexte, "a = 12" n'a pas de valeur, on ne peut pas l'enregistrer
```

Maintenant, nous allons parler des types. Un **type** est une information sur une expression qui nous renseigne sur les valeurs qu'elle
peut prendre. C'est un peu comme la notion d'ensemble en mathématiques.
Vous avez sans doute déjà vu quelques types en Python, comme `int` ou, `float` ou `str`. En OCaml, on retrouve aussi des types,
mais le système de type d'OCaml est bien plus avancé que celui de Python. Et en OCaml, toute expression a un type bien défini : on dit que
c'est un langage *fortement typé*.

Tout ceci n'explique pas pourquoi additionner deux nombres à virgules donne une erreur. La raison est que l'opérateur `+` d'OCaml s'attend
à trouver des expressions de type `int` des deux côtés, et pas autre chose. De même pour `-`, `*`, `/` et `mod`. Pour les flottants, on a des
opérateurs différents : `+.`, `-.`, `*.`, `/.` et `mod_float`.

Mais pourquoi s'embêter avec tout ça ? Python arrive très bien à mélanger les deux, pourquoi OCaml ne peut pas le faire ?

OCaml accorde une grande importance aux types, et il a tout le temps besoin de savoir quel est le type d'une expression.
Il ne peut pas être dans le flou. Ainsi, il peut s'assurer **avant même que vous lanciez votre code** si il contient des erreurs.
Prenons le code suivant en Python :

```python
liste = [1, 2, 3]
liste + "Oups" # Additioner une liste et du texte ? 🤔️
```

Python n'ayant pas la rigueur d'OCaml quand il s'agit de vérifier les types, il va lancer ce programme sans se poser de questions,
et il n'affichera une erreur qu'au moment où la ligne problématique sera exécutée. Dans cette exemple, le problème peut vite être
détecté, mais imaginez que vous avez le même souci au milieu de milliers de lignes de code, à l'intérieur de fonctions complexes…
Bref, un cauchemar pour trouver la source du bug !

En Ocaml, si vous essayez de faire une opération de ce style, vous allez immédiatement avoir une **erreur de type** avant que le code ne
se lance, évitant des tonnes de bugs en avance !

Mais pour pouvoir vérifier les types, OCaml a besoin de connaître le type de chaque expression. Utiliser les bons opérateurs l'aide dans cette tâche :
il sait qu'une addition avec `+` aura pour type `int` alors qu'une avec `+.` aura pour type `float`. Voilà pourquoi on ne peut pas utiliser le même opérateur
partout !
