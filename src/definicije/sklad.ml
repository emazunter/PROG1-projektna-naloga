type t = {sklad: string list}

let ustvari x = [x]

let dodaj x sklad = x :: sklad

let vrh sklad = List.hd sklad