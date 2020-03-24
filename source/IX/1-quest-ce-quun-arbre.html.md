---
title: "Qu’est-ce qu’un arbre ?"
description: "Les arbres sont des structures de données courantes en programmation qui permettent de modéliser de nombreux problèmes. Nous allons apprendre à en créer et à en manipuler en OCaml."
illus: tree.webp
---

Un arbre est une plante ligneuse terrestre comportant un tronc sur lequel
s’insèrent des branches ramifiées portant le feuillage dont l’ensemble
forme le houppier, appelé aussi couronne.

Plus sérieusement, un arbre est une structure de donnée assez courante en informatique.
Ce nom a été choisi parce qu’il y a des ressemblances entre l’organisation d’un vrai arbre
et d’un arbre en informatique :

- Les deux ont une racine (enfin dans la vraie vie, c’est plutôt des racines) ;
- Si on remonte le long de ces racines, on arrive à un embranchement (choix entre plusieurs branches) ;
- Si on suit une de ces branches, on va arriver à un autre embranchement ;
- Et ainsi de suite jusqu’à ce qu’on arrive à une feuille.

Les arbres sont donc des structures récursives : on enchaîne les embranchements jusqu’à atteindre
une feuille. C’est un peu comme des listes, sauf qu’à chaque fois au lieu de continuer avec un seul
élément, on a plusieurs possibilités.

Cette structure de données est très utile dans certains cas, que ce soit pour représenter des hiérarchies,
ou pour permettre de réaliser certains algorithmes de manière efficace.

Voici un schéma d’un arbre avec deux branches à chaque embranchement :

![Un arbre](/images/tree.png)

Ici :

- les cercles gris sont les embranchements ;
- le plus gros d’entre eux est la racine de l’arbre ;
- les carrés jaunes sont les feuilles.

Mais cet arbre n’est qu’un exemple, on peut choisir de mettre plus ou moins de branches à chaque embranchement.

En OCaml, on enregistrera des données au niveau de chaque feuille et éventuellement au niveau de chaque embranchement.

## Encore un peu théorie : le vocabulaire des arbres

Les arbres ont un vocabulaire particulier[^plantes] pour les qualifier :

- Les embranchements sont généralement appelés **nœuds** ;
- Comme on l’a dit, le premier nœud est **la racine** ;
- Les données qu’on stocke à chaque nœud ou à chaque feuille sont **les étiquettes**, ou **le contenu** ;
- Les sous-arbres d’un nœud s’appellent **les enfants**, et inversement on parle aussi de **parents** ;
- **Une branche** est le chemin à suivre pour aller de la racine à une feuille ou un nœud donné. C’est donc une liste d’étiquettes ;
- **Le niveau** d’un nœud est la taille de la branche correspondante (autrement dit, à quelle profondeur il est dans l’arbre) ;
- **La profondeur** de l’arbre est le niveau maximal dans cet arbre ;
- Et enfin, **la taille** d’un arbre est le nombre d’éléments total dans un arbre ;

Ça fait beaucoup de nouveaux mots, mais ne vous inquiétez pas, on s’habitue.

## La pratique : définition d’un arbre en OCaml

On va essayer de représenter l’arbre schématisé au-dessus avec un type OCaml.
On va pour cela utiliser un type somme récursif.

```ocaml
type abre =
  | Feuille
  | Noeud of arbre * arbre
```

Ici, chaque nœud peut amener à deux enfants. Si on veut stocker des données à chaque feuille,
on peut rendre ce type polymorphe, et ajouter des données au constructeur `Feuille` :

```ocaml
type 'a arbre =
  | Feuille of 'a
  | Noeud of 'a arbre * 'a arbre
```

On peut aussi décider de rajouter des données à chaque nœud :

```
type 'a arbre =
  | Feuille of 'a
  | Noeud of 'a * 'a arbre * 'a arbre
```

Et on peut aussi ajouter un nombre quelconque d’enfants à chaque nœud, avec une liste :

```ocaml
type 'a arbre =
  | Feuille of 'a
  | Noeud of 'a * 'a arbre list
```

Bref, il n’y a pas qu’une seule façon de modéliser un arbre, et selon le problème qu’on cherche à
résoudre on n’utilisera pas tout à fait le même type.

Voici un exemple pour modéliser un arbre généalogique, où les données sont les noms
des personnes :

```ocaml
type arbre_gene =
  | Ancetre of string (* On est remonté tellement loin qu’on ne se souvient plus qui était les parents de cette personne *)
  | Personne of string * arbre_gene * arbre_gene (* On considère que tout le monde a deux parents *)

(* L’abre généalogique qui part de Jade et qui remonte jusqu’à ses grands parents *)
let arbre_de_jade =
  Personne(
    "Jade",
    Personne(
      "Jeanne",
      Ancetre("Jeanine"),
      Ancetre("Jean")
    ),
    Personne(
      "Jules",
      Ancetre("Julien"),
      Ancetre("Julie")
    )
  )
```

Ce n’est qu’un exemple d’utilisation des arbres, on peut aussi s’en servir pour
représenter une arborescence de fichiers dans un disque dur (les embranchements sont les dossiers et les feuilles
les fichiers), une hiérarchie (chaque embranchement correspond à un supérieur hiérarchique, et les feuilles à ceux qui sont en bas de l’échelle), etc.

Dans la suite, on va surtout parler d’arbres binaires, en particulier pour les algorithmes de recherche dans des listes.

[^plantes]: Parfois connu sous le nom de langage des plantes.
