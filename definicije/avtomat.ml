type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  sklad_1: sklad;
  sklad_2: sklad;
  prehodi : (stanje * char * char) list * (stanje * char list * char list) list
  zacetno_stanje : stanje;
  zacetni_sklad1: sklad;
  zacetni_sklad2: sklad;
  sprejemna_stanja : stanje list;
}

let prazen_avtomat zacetno_stanje s1 s2 =
  {
    stanja = [ zacetno_stanje ];
    sklad_1 = s1;
    sklad_2 = s2;
    prehodi = [];
    zacetno_stanje;
    zacetni_sklad1: s1;
    zacetni_sklad2: s2;
    sprejemna_stanja = [];
  }

let dodaj_nesprejemno_stanje stanje avtomat =
  { avtomat with stanja = stanje :: avtomat.stanja }

let dodaj_sprejemno_stanje stanje avtomat =
  {
    avtomat with
    stanja = stanje :: avtomat.stanja;
    sprejemna_stanja = stanje :: avtomat.sprejemna_stanja;
  }

let dodaj_prehod stanje1 prebrano vrh_s1 vrh_s2 stanje2 nov_s1 nov_s2 avtomat =
  { avtomat with prehodi = (stanje1, prebrano, vrh_s1, vrh_s2, stanje2, nov_s1, nov_s2) :: avtomat.prehodi }

let prehodna_funkcija avtomat stanje prebrano vrh_s1 vrh_s2 =
  match
    List.find_opt
      (fun (stanje1, prebrano', vrh_s1', vrh_s2', ostalo) -> stanje1 = stanje && prebrano = prebrano'
      && vrh_s1 = vrh_s1' && vrh_s2 = vrh_s2')
      avtomat.prehodi
  with
  | None -> None
  | Some (_, _, ostalo) -> Some ostalo
  (* na seznamu prehodov najdeš takega ki ima pravo stanje, znake in vrneš some novo stanje
  če obstaja ali none če ne *)

let zacetno_stanje avtomat = avtomat.zacetno_stanje
let seznam_stanj avtomat = avtomat.stanja
let seznam_prehodov avtomat = avtomat.prehodi

let je_sprejemno_stanje avtomat stanje =
  List.mem stanje avtomat.sprejemna_stanja

let enke_1mod3 =
  let q0 = Stanje.iz_niza "q0"
  and q1 = Stanje.iz_niza "q1"
  and q2 = Stanje.iz_niza "q2" in
  prazen_avtomat q0 |> dodaj_sprejemno_stanje q1
  |> dodaj_nesprejemno_stanje q2
  |> dodaj_prehod q0 '0' q0 |> dodaj_prehod q1 '0' q1 |> dodaj_prehod q2 '0' q2
  |> dodaj_prehod q0 '1' q1 |> dodaj_prehod q1 '1' q2 |> dodaj_prehod q2 '1' q0

(* let preberi_niz avtomat q niz =
  let aux acc znak =
    match acc with None -> None | Some q -> prehodna_funkcija avtomat q znak
  in
  niz |> String.to_seq |> Seq.fold_left aux (Some q) *)
