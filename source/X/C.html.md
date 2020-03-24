---
title: Pour aller plus loin…
description: "Vous aimez OCaml et vous voudriez en apprendre plus sur ce sujet ? Voici quelques pistes."
illus: road.webp
---

Vous avez aimé ce cours, et vous avez envie de continuer à apprendre des choses sur OCaml, ou
de découvrir d’autres langages similaires ? Voici quelques pistes.

*Je mettrais à chaque fois des exemples du langage dont je parle pour
que vous puissiez juger rapidement si vous l’aimez ou pas (mais ne jugez pas uniquement
sur la syntaxe, regardez aussi les « idées » derrière).*

## Continuer avec OCaml : la programmation orientée objet

OCaml est en réalité une extension du langage Caml, qui lui ajoute une
couche de programmation **orientée objet**. Ces nouvelles fonctionnalités
offrent plein de possibilités pour concevoir des programmes, et [la documentation officielle d’OCaml](https://ocaml.org/learn/tutorials/objects.html)
peut vous aider à vous renseigner sur le sujet (en anglais seulement, malheureusement).

```ocaml
(* Définit une classe, le type d’un objet
* Ici une « pile » d’entiers : *)
class pile_entiers =
  object (self)
    val mutable la_liste = ( [] : int list )

    method empiler x =
      la_liste <- x :: la_liste

    method depiler =
      let resultat = List.hd la_liste in
      la_liste <- List.tl la_liste;
      resultat

    method peek =
      List.hd la_liste

    method taille =
      List.length la_liste
end

(* Crée un nouvel objet avec cette classe *)
let s = new stack_of_ints
(* Empile deux entiers sur la pile qu’on vient de créer *)
s#empiler 10
s#empiler 15
let x = s#depiler (* x vaut 15 *)
```

## Si vous avez aimé le côté fonctionnel : Haskell

Si vous avez bien aimé la programmation fonctionnelle, peut-être qu’Haskell vous plairait.
Ce langage est lui aussi fonctionnel, mais il pousse les concepts qu’on a étudiés avec OCaml
beaucoup plus loin, et il est beaucoup plus puissant si on le maîtrise bien.

Le tutoriel [« Apprendre le Haskell vous fera le plus grand bien »](http://lyah.haskell.fr/)
est la référence pour apprendre, et il est traduit en français ! La version originale en anglais
[est également disponible](http://learnyouahaskell.com/) si vous préférez. Les explications sont
claires et les illustrations toutes mignonnes !

```haskell
-- Une fonction récursive qui donne la taille d’une liste
taille :: (Num b) => [a] -> b
taille [] = 0
taille (_:suite) = 1 + taille suite

-- Les équivalent des List.map et List.filter
map (+3) [1,5,3,1,6]
filter (>3) [1,5,3,2,1,6,4,3,2,1]
```

Si vous aimez bien les langages de Microsoft :  F#
--------------------------------------------------

Peut-être que vous avez déjà programmé en C#, Visual Basic ou Visual C++, et
que vous aimez bien l’écosystème de Microsoft ? Si c’est le cas, je vous recommande
F#, qui est un langage fonctionnel très proche d’OCaml, mais qui peut s’utiliser avec tous
les modules dont vous avez l’habitude.

[La documentation officielle](https://docs.microsoft.com/fr-fr/dotnet/fsharp/) est probablement
le meilleur point de départ si vous voulez essayer.

```fsharp
// Une fonction récursive
// La syntaxe ressemble tellement à OCaml que cette fonction pourrait en être.
let rec sommeListe xs =
  match xs with
  | []    -> 0
  | y::ys -> y + sommeListe ys

// Affiche 6
System.Console.WriteLine (sommeListe [ 1 ; 2 ; 3 ])
```

## Si vous avez aimé le OCaml, et le C : Rust

Si vous avez fait du C (ce qui est sans doute le cas si vous suiviez l’UE d’INF203 en plus de celle d’INF201),
et que vous avez bien aimé certains aspects de ce langage (compilation pour des programmes plus rapides,
être plus proche de la mémoire, etc), je vous conseille Rust qui est à mi-chemin entre OCaml et C :
on a les mêmes performances qu’en C, mais avec des concepts proches de ceux d’OCaml comme les types énumérés
ou les fonctions d’ordre supérieur pour manipuler les listes (mais on retrouve aussi des concepts qui viennent du C
en plus des performances, comme les boucles).

[Ce tutoriel](https://blog.guillaume-gomez.fr/Rust/1/1) est un des mieux en français. Mais si vous n’avez pas peur de l’anglais,
[le livre de Rust](https://doc.rust-lang.org/stable/book/) est sans doute le meilleur tutoriel que vous trouverez sur Internet.

```rust
// Un type énuméré, comme en OCaml :
enum Liste<'a, A> {
    Fin,
    Element(A, &'a Liste<'a, A>),
}

// La fonction main, commen en C :
fn main() {
    let nombres = &[ 1, 2, 3, 4, 5 ]; // le & sert à créer une référence, comme en C
    let doubles = nombres.iter().map(|x| x * 2); // On a un équivalent du List.map d’OCaml
    for d in doubles { // Une boucle for (qui ressemble à celles de Python pour le coup)
        println!("{}", d);
    }
}
```
