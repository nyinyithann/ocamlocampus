# Effect Handlers
>"An algebraic effect handler is a programming abstraction for manipulating control-flow in a first-class fashion. They generalise common abstractions such as exceptions, generators, asynchronous I/O, or concurrency, as well as other seemingly esoteric programming abstractions such as transactional memory and probabilistic computations. Operationally, effect handlers offer a form of first-class, restartable exception mechanism." -- [Concurrent Programming with Effect Handlers](https://github.com/ocamllabs/ocaml-effects-tutorial)

- [Effect handlers manual](https://v2.ocaml.org/releases/5.0/htmlman/effects.html#s%3Aeffects-basics)
- [effect.mli](https://github.com/ocaml/ocaml/blob/trunk/stdlib/effect.mli)

```OCaml
open Effect
open Effect.Deep

type _ Effect.t += Eff : int -> int Effect.t

let comp () = perform (Eff 0) + perform (Eff 1)

let _ = 
    let r = try_with comp () {
        effc =  fun (type c) (eff: c Effect.t) -> 
            match eff with 
            | Eff i -> Some(fun (k: (c, _ ) continuation) -> continue k (i + 1))
            | _ -> None } in 
    Printf.printf "/nThe Result is %d/n" r
```
