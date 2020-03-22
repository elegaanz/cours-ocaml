---
title: Un peu de théorie
description: "Une brève introduction sur les types : pourquoi et comment les créer en OCaml."
---

Jusqu’à présent nous n’avons manipulé que des valeurs simples, qui utilisaient les types de base d’OCaml.
Mais quand on veut réaliser de vrais programmes, on a besoin de types plus complexes que juste des `int` ou des `string`.
Imaginez par exemple que vous créiez une application de messagerie. Vous pourriez modéliser un message avec
un simple `string`. Mais comment faire si vous voulez aussi garder en mémoire et manipuler le nom de la
personne qui a envoyé ce message ? Et les réactions à ce message ? Et sa date d’envoi ?

Quand les informations s’ajoutent, et deviennent plus complexe, on ne peut pas tout modéliser avec des types simples.
Faire des fonctions qui prennent toutes quinze arguments n’est pas vraiment faisable, surtout si vous décidez de
rajouter une information, et qu’il faut écrire un nouvel argument partout.

Heureusement, OCaml nous laisse créer nos propres types de données. Dans ce cours nous verrons 4 façons de créer un nouveau type :

- Avec des **types synonymes** ;
- Avec des **types produits** ;
- Avec des **types sommes** ;
- Avec des **types structurés** (en bonus par rapport au cours original).
