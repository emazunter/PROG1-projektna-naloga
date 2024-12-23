type t = {sklad : string list}

let prazen =  {sklad = []}

let dodaj sez skl = 
  let rec dodaj_aux sez acc = match sez with
  | [] -> {sklad = acc}
  | gl :: rp -> dodaj_aux rp (gl :: acc) 
  in dodaj_aux sez skl.sklad

let ustvari x = dodaj x prazen

let vrh s = 
  match s.sklad with
  | [] -> ""  
  | gl :: _ -> gl  

let vzemi s = 
  match s.sklad with
  | [] -> {sklad = []}
  | _ :: rp -> {sklad = rp}

let je_prazen s =
  match s.sklad with
  | ["x"] -> true 
  | _ -> false     

