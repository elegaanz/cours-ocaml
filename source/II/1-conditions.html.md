---
title: if et else
illus: yew.jpg
description: "Une explication des conditions en OCaml, avec les mot-clés if et else."
---

*(L’image haut dessus c’est une branche d’if, voilà, c’est marrant)*

Comme en Python, OCaml dispose d’une structure conditionnelle, qui utilise elle aussi
les mot-clés `if` et `else`. La syntaxe est cependant un peu différente, car on ne
met pas de `:` pour entrer dans le bloc de la condition (ils servent en général à indiquer un type en OCaml),
mais on utilise le mot-clé `then`. La syntaxe ressemble donc globalement à :

```ocaml
if x then a else b
```

Pour plus de clarté, on écrira souvent cette expression sur plusieurs lignes, avec de l’indentation :

```ocaml
if x then
  a
else
  b
```

Dans cet exemple général, on a :

- `x` qui est une expression de type `bool`. Si elle vaut `true`, on renverra `a`. Sinon, on renverra `b` ;
- `a` qui est une expression d’un type quelconque ;
- `b` qui est une autre expression, qui doit être du même type que `a`.

En effet, en OCaml, toute expression doit avoir un type uniforme et bien défini. Et la structure `if`/`else`
étant aussi une expression, elle ne peut avoir qu’un seul type. À cause de cette règle, il n’est également pas
possible d’ignorer le `else` : il est obligatoire. Si on ne le mettait pas, on pourrait avoir une expression qui
a soit le même type que `a`, soit pas de type (noté `()` en OCaml). Le type ne serait donc pas uniforme.

Le fait que les conditions soient des expressions est parfois très pratique. On peut par exemple définir une
constante en fonction d’une condition :

```ocaml
let numero_departement = 38
let nom_departement = if numero_departement = 38 then
  "Isere"
else
  "Inconnu"
```

On peut aussi créer des équivalents au `elif` de manière transparente : l’expression qui suit le `else` peut très bien
être une condition aussi :

```ocaml
let numero_departement = 38
let nom_departement = if numero_departement = 38 then
  "Isere"
else if numero_departement = 19 then
  "Correze"
else
  "Inconnu"
```

Pour bien voir ce qui se passe avec ce `else if`, on peut réécrire la même chose avec des parenthèses :

```ocaml
let numero_departement = 38
let nom_departement = if numero_departement = 38 then
  "Isere"
else (
  if numero_departement = 19 then
    "Correze"
  else
    "Inconnu"
)
```

Les deux sont équivalents, et c’est exactement ce que fait OCaml quand on écrit `else if`.
