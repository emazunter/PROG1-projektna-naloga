type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  sklad : sklad;
  prehodi : (stanje * char * char * stanje * char list) list;
  zacetno_stanje : stanje;
  zacetni_sklad : sklad;
  sprejemna_stanja : stanje list;
}

let prazen_avtomat zacetno_stanje s =
  {
    stanja = [ zacetno_stanje ];
    sklad = s;
    prehodi = [];
    zacetno_stanje;
    zacetni_sklad = s;
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
      (fun (stanje1, prebrano', vrh', stanje2, nov_sklad) -> stanje1 = stanje && prebrano = prebrano' && vrh = vrh')
      avtomat.prehodi
  with
  | None -> None
  | Some (_, _, _, stanje2, nov_sklad) -> Some (stanje2, nov_sklad)
  (* na seznamu prehodov najdeš takega ki ima pravo stanje, znake in vrneš some novo stanje
  če obstaja ali none če ne *)

let zacetno_stanje avtomat = avtomat.zacetno_stanje
let seznam_stanj avtomat = avtomat.stanja
let seznam_prehodov avtomat = avtomat.prehodi

let je_sprejemno_stanje avtomat stanje =
  List.mem stanje avtomat.sprejemna_stanja

let zamenjaj = function
| "+" | "-" | "x" | "/" -> "o"
| "1" | "2" | "3" | "4" | "5" | "6" | "7" |"8" | "9" |"0" -> "s"
| "(" -> "u"
| ")" -> "z"
| x -> x

let dodaj_prehod_moj_avtomat stanje1 prebrano vrh stanje2 nov_s avtomat =
  let novo = zamenjaj prebrano in
   dodaj_prehod stanje1 novo vrh stanje2 nov_s avtomat

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
  |> dodaj_nesprejemno_stanje nesprejemno 
  |> dodaj_prehod_moj_avtomat zacetno operacija sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat zacetno stevilo sklad n sklad
  |> dodaj_prehod_moj_avtomat zacetno uklepaj sklad u sklad
  |> dodaj_prehod_moj_avtomat zacetno zaklepaj sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat o operacija sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat o stevilo sklad n sklad
  |> dodaj_prehod_moj_avtomat o uklepaj sklad u (Sklad.dodaj "1" sklad)
  |> dodaj_prehod_moj_avtomat o zaklepaj sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat n operacija sklad o sklad
  |> dodaj_prehod_moj_avtomat n stevilo sklad n sklad
  |> dodaj_prehod_moj_avtomat n uklepaj sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat n zaklepaj ("1" :: sklad) z sklad
  |> dodaj_prehod_moj_avtomat n zaklepaj ("p" :: sklad) nesprejemno (Sklad.dodaj "p" sklad)
  |> dodaj_prehod_moj_avtomat u operacija sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat u stevilo sklad u ("1" :: sklad)
  |> dodaj_prehod_moj_avtomat u uklepaj sklad u ("1" :: sklad)
  |> dodaj_prehod_moj_avtomat u zaklepaj sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat z operacija ("1" :: sklad) o sklad
  |> dodaj_prehod_moj_avtomat z operacija ("p" :: sklad) nesprejemno (Sklad.dodaj "p" sklad)
  |> dodaj_prehod_moj_avtomat z stevilo sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat z uklepaj sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat z zaklepaj ("1" :: sklad) z sklad
  |> dodaj_prehod_moj_avtomat z zaklepaj ("p" :: sklad) nesprejemno (Sklad.dodaj "p" sklad)
  |> dodaj_prehod_moj_avtomat nesprejemno operacija sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat nesprejemno stevilo sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat nesprejemno uklepaj sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat nesprejemno zaklepaj sklad nesprejemno sklad


let preberi_niz avtomat q niz =
  let aux acc znak =
    match acc with None -> None | Some q -> prehodna_funkcija avtomat q znak
  in
  niz |> String.to_seq |> Seq.fold_left aux (Some q)
