type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  sklad_1: sklad;
  sklad_2: sklad;
  prehodi : (stanje * char * char) list * (stanje * char list) list
  zacetno_stanje : stanje;
  zacetni_sklad: sklad;
  sprejemna_stanja : stanje list;
}

let prazen_avtomat zacetno_stanje s1 =
  {
    stanja = [ zacetno_stanje ];
    sklad_1 = s1;
    prehodi = [];
    zacetno_stanje;
    zacetni_sklad1: s1;
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

let dodaj_prehod stanje1 prebrano vrh stanje2 nov_s avtomat =
  { avtomat with prehodi = (stanje1, prebrano, vrh, stanje2, nov_s) :: avtomat.prehodi }

let prehodna_funkcija avtomat stanje prebrano vrh =
  match
    List.find_opt
      (fun (stanje1, prebrano', vrh', ostalo) -> stanje1 = stanje && prebrano = prebrano' && vrh = vrh')
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

let preverjanje_pravilnosti =
  let zacetno = Stanje.iz_niza "zacetno"
  and n = Stanje.iz_niza "n"
  and o = Stanje.iz_niza "o"
  and u = Stanje.iz_niza "u"
  and z = Stanje.iz_niza "z" 
  and nesprejemno = Stanje.iz_niza "nesprejemno" in
  prazen_avtomat zacetno (Sklad.ustvari 'p') 
  |> dodaj_sprejemno_stanje zacetno
  |> dodaj_sprejemno_stanje z
  |> dodaj_sprejemno_stanje n
  |> dodaj_nesprejemno_stanje o
  |> dodaj_nesprejemno_stanje u
  let operacija = "+" | "-" | "x" | "/" 
  and stevilo = "1" | "2" | "3" | "4" | "5" | "6" | "7" |"8" | "9" |"0"
  and uklepaj = "("
  and zaklepaj = ")" in
  |> dodaj_prehod zacetno operacija sklad nesprejemno sklad
  |> dodaj_prehod zacetno stevilo sklad n sklad
  |> dodaj_prehod zacetno uklepaj sklad u sklad
  |> dodaj_prehod zacetno zaklepaj sklad nesprejemno sklad
  |> dodaj_prehod o operacija sklad nesprejemno sklad
  |> dodaj_prehod o stevilo sklad n sklad
  |> dodaj_prehod o uklepaj sklad u ("1" :: sklad)
  |> dodaj_prehod o zaklepaj sklad nesprejemno sklad
  |> dodaj_prehod n operacija sklad o sklad
  |> dodaj_prehod n stevilo sklad n sklad
  |> dodaj_prehod n uklepaj sklad nesprejemno sklad
  |> dodaj_prehod n zaklepaj ("1" :: sklad) z sklad
  |> dodaj_prehod n zaklepaj ("p" :: sklad) nesprejemno ("p" :: sklad)
  |> dodaj_prehod u operacija sklad nesprejemno sklad
  |> dodaj_prehod u stevilo sklad u ("1" :: sklad)
  |> dodaj_prehod u uklepaj sklad u ("1" :: sklad)
  |> dodaj_prehod u zaklepaj sklad nesprejemno sklad
  |> dodaj_prehod z operacija ("1" :: sklad) o sklad
  |> dodaj_prehod z operacija ("p" :: sklad) nesprejemno ("p" :: sklad)
  |> dodaj_prehod z stevilo sklad nesprejemno sklad
  |> dodaj_prehod z uklepaj sklad nesprejemno sklad
  |> dodaj_prehod z zaklepaj ("1" :: sklad) z sklad
  |> dodaj_prehod z zaklepaj ("p" :: sklad) nesprejemno ("p" :: sklad)
  |> dodaj_prehod nesprejemno operacija sklad nesprejemno sklad
  |> dodaj_prehod nesprejemno stevilo sklad nesprejemno sklad
  |> dodaj_prehod nesprejemno uklepaj sklad nesprejemno sklad
  |> dodaj_prehod nesprejemno zaklepaj sklad nesprejemno sklad



(* let preberi_niz avtomat q niz =
  let aux acc znak =
    match acc with None -> None | Some q -> prehodna_funkcija avtomat q znak
  in
  niz |> String.to_seq |> Seq.fold_left aux (Some q) *)
