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
