# Cours d'OCaml alternatif

Ce cours a pour vocation d'être une alternative à l'UE d'INF201 de l'Université de Grenoble-Alpes.
En effet, cette UE est pour beaucoup assez ennuyante et a tendance à dégoûter les étudiant⋅e⋅s du langage, alors qu'il peut s'avérer très intéressant.
Nous ne savons pas si nous arriverons à faire mieux, mais ça ne coûte rien d'essayer.

Ce cours ne couvrira donc que les bases du langage OCaml, et s'adresse principalement aux personnes ayant des bases en Python.
Voici les points qui seront abordés :

- Introduction à la programmation fonctionnelle (de manière générale), comparaison avec l'impératif
- Présentation d'OCaml :
  - Historique
  - Pourquoi l'apprendre
  - Exemple de projets qui utilisent OCaml dans la vraie vie
- Différence entre spécification et implémentation
- Typage
  - Statique et fort
  - Types de base du OCaml
  - Inférence de types en OCaml
  - Opérateurs qui ne foncionnent qu'avec un type particulier (permet au compilateur et au lecteur de connaître le type même si il n'est pas indiqué explicitement)
- Déclaration de bindings ("let ... = ... in ...")
  - `and`
  - Portée
- If/else
- Pattern matching
- Modélisation :
  - Pourquoi et comment modéliser des informations ?
  - En OCaml : définition de types + création de fonctions les manipulant
- Création de types :
  - Synonymes
  - Produit
  - Algébriques
- Récursivité
  - Définition
  - "Bien fondée" (qu'est ce que c'est moche)
  - Mesures
  - Types récursifs

Et en annexe :
- Installation d'OCaml sous différentes plateformes (de préférence avec opam et utop).
- Configuration d'éditeurs courants (VSCode, Atom, Sublime Text, Vim, Emacs, etc).
- Des pistes pour aller plus loin (orienté objet en OCaml, Haskell, F#, etc).

Ressources utiles pendant la rédaction :
- [L'UE d'INF201](https://lig-membres.imag.fr/puitg/Ens/201/)
- [99 problèmes à résoudre en OCaml](https://ocaml.org/learn/tutorials/99problems.html)
- [L'UE COS326 de Princeton, cours de référence pour les anglophones](https://www.cs.princeton.edu/~dpw/courses/cos326-12/info.php)
