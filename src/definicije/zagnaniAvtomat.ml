type t = { avtomat : Avtomat.t; trak : Trak.t; stanje : Stanje.t; sklad : Sklad.t}

let pozeni avtomat trak =
  { avtomat; trak; stanje = Avtomat.zacetno_stanje avtomat; sklad = Avtomat.zacetni_sklad avtomat}

let avtomat { avtomat; _ } = avtomat
let trak { trak; _ } = trak
let stanje { stanje; _ } = stanje
let sklad { sklad; _ } = sklad

let korak_naprej { avtomat; trak; stanje; sklad } =
  if Trak.je_na_koncu trak then None
  else
    let stanje' =
      Avtomat.prehodna_funkcija avtomat stanje (Trak.trenutni_znak trak) (Sklad.vrh sklad)
    in
    match stanje' with
    | None -> None
    | Some (stanje', vrh') ->
        Some { avtomat; trak = Trak.premakni_naprej trak; stanje = stanje'; sklad = (Sklad.dodaj vrh' (Sklad.vzemi sklad)) }

let je_v_sprejemnem_stanju { avtomat; stanje; _ } =
  Avtomat.je_sprejemno_stanje avtomat stanje

