type t = {sklad : string list}

let prazen =  {sklad = []}

let dodaj x s = s with s.sklad = (x :: s.sklad)

let ustvari (x : string) = dodaj x prazen

let vrh s = match s.sklad with
| [] -> ""
| gl :: _ -> gl