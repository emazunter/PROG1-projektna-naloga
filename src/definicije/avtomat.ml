type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  sklad : sklad;
  prehodi : (stanje * char * string * stanje * string list) list;
  zacetno_stanje : stanje;
  zacetni_sklad : sklad;
  sprejemna_stanja : stanje list;
}

let prazen_avtomat zacetno_stanje =
  {
    stanja = [ zacetno_stanje ];
    sklad = s;
    prehodi = [];
    zacetno_stanje;
    zacetni_sklad = Sklad.prazen;
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

let dodaj_prehod stanje1 prebrano vrh stanje2 nov_vrh avtomat =
  { avtomat with prehodi = (stanje1, prebrano, vrh, stanje2, nov_vrh) :: avtomat.prehodi }

let prehodna_funkcija avtomat stanje prebrano vrh =
  match
    List.find_opt
      (fun (stanje1, prebrano', vrh', stanje2, nov_vrh) -> stanje1 = stanje && prebrano = prebrano' && vrh = vrh')
      avtomat.prehodi
  with
  | None -> None
  | Some (_, _, _, stanje2, nov_sklad) -> Some (stanje2, nov_sklad)
  (* na seznamu prehodov najdeš takega ki ima pravo stanje, znake in vrneš Some novo stanje
  če obstaja ali None če ne *)

let zacetno_stanje avtomat = avtomat.zacetno_stanje
let seznam_stanj avtomat = avtomat.stanja
let seznam_prehodov avtomat = avtomat.prehodi

let je_sprejemno_stanje avtomat stanje =
  List.mem stanje avtomat.sprejemna_stanja

let preberi_niz avtomat q niz =
  let aux acc znak =
    match acc with None -> None | Some q -> prehodna_funkcija avtomat q znak
  in
  niz |> String.to_seq |> Seq.fold_left aux (Some q)

let sintaksa_oklepajev = 
  let q0 = Stanje.iz_niza "q0"
  and q1 = Stanje.iz_niza "q1"
  and q2 = Stanje.iz_niza "q2"
  and q3 = Stanje.iz_niza "q3"
  and q4 = Stanje.iz_niza "q4"
  in
  prazen_avtomat q0
  |> dodaj_nesprejemno_stanje q1
  |> dodaj_nesprejemno_stanje q2 
  |> dodaj_nesprejemno_stanje q3
  |> dodaj_nesprejemno_stanje q4
  |> dodaj_nesprejemno_stanje q5
  |> dodaj_nesprejemno_stanje q6
  |> dodaj_nesprejemno_stanje q7
  |> dodaj_prehod q0 '(' "" q1 ["1"]
  |> dodaj_prehod q0 '[' "" q2 ["2"]
  |> dodaj_prehod q0 '{' "" q3 ["3"]
  |> dodaj_prehod q1 '(' "1" q1 ["1"; "1"]
  |> dodaj_prehod q1 '[' "1" q2 ["2"; "1"]
  |> dodaj_prehod q1 '{' "1" q3 ["3"; "1"]
  |> dodaj_prehod q1 ')' "1" q4 []
  |> dodaj_prehod q1 ']' "1" q7 ["ne"]
  |> dodaj_prehod q1 '}' "1" q7 ["ne"]
  |> dodaj_prehod q2 '(' "2" q1 ["1"; "2"]
  |> dodaj_prehod q2 '[' "2" q2 ["2"; "2"]
  |> dodaj_prehod q2 '{' "2" q3 ["3"; "2"]
  |> dodaj_prehod q2 ')' "2" q7 ["ne"]
  |> dodaj_prehod q2 ']' "2" q5 []
  |> dodaj_prehod q2 '}' "2" q7 ["ne"]
  |> dodaj_prehod q3 '(' "3" q1 ["1"; "3"]
  |> dodaj_prehod q3 '[' "3" q2 ["2"; "3"]
  |> dodaj_prehod q3 '{' "3" q3 ["3"; "3"]
  |> dodaj_prehod q3 ')' "3" q7 ["ne"]
  |> dodaj_prehod q3 ']' "3" q7 ["ne"]
  |> dodaj_prehod q3 '}' "3" q6 []
  |> dodaj_prehod q4 '(' x q1 ["1"]






(* let zamenjaj = function
| "+" | "-" | "x" | "/" -> "o"
| "1" | "2" | "3" | "4" | "5" | "6" | "7" |"8" | "9" |"0" -> "n"
| "(" -> "u"
| ")" -> "z"
| x -> x

let dodaj_prehod_moj_avtomat stanje1 prebrano vrh stanje2 nov_vrh avtomat =
  let novo = zamenjaj prebrano in
   dodaj_prehod stanje1 novo vrh stanje2 nov_vrh avtomat

let preverjanje_pravilnosti =
  let zacetno = Stanje.iz_niza "zacetno"
  and stevilo = Stanje.iz_niza "stevilo"
  and operacija = Stanje.iz_niza "operacija"
  and uklepaj = Stanje.iz_niza "uklepaj"
  and zaklepaj = Stanje.iz_niza "zaklepaj" 
  and nesprejemno = Stanje.iz_niza "nesprejemno" in
  prazen_avtomat zacetno (Sklad.ustvari 'p') 
  |> dodaj_sprejemno_stanje zacetno
  |> dodaj_sprejemno_stanje zaklepaj
  |> dodaj_sprejemno_stanje stevilo
  |> dodaj_nesprejemno_stanje operacija
  |> dodaj_nesprejemno_stanje uklepaj
  |> dodaj_nesprejemno_stanje nesprejemno 
  |> dodaj_prehod_moj_avtomat zacetno p sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat zacetno o sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat zacetno n sklad stevilo sklad
  |> dodaj_prehod_moj_avtomat zacetno u sklad uklepaj sklad
  |> dodaj_prehod_moj_avtomat zacetno z sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat operacija o sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat operacija n sklad stevilo sklad
  |> dodaj_prehod_moj_avtomat operacija u sklad uklepaj (Sklad.dodaj "1" sklad)
  |> dodaj_prehod_moj_avtomat operacija z sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat stevilo o sklad operacija sklad
  |> dodaj_prehod_moj_avtomat stevilo n sklad stevilo sklad
  |> dodaj_prehod_moj_avtomat stevilo u sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat stevilo z ("1" :: sklad) zaklepaj sklad
  |> dodaj_prehod_moj_avtomat stevilo z ("p" :: sklad) nesprejemno (Sklad.dodaj "p" sklad)
  |> dodaj_prehod_moj_avtomat uklepaj o sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat uklepaj n sklad uklepaj ("1" :: sklad)
  |> dodaj_prehod_moj_avtomat uklepaj u sklad uklepaj ("1" :: sklad)
  |> dodaj_prehod_moj_avtomat uklepaj z sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat zaklepaj o ("1" :: sklad) operacija sklad
  |> dodaj_prehod_moj_avtomat zaklepaj o ("p" :: sklad) nesprejemno (Sklad.dodaj "p" sklad)
  |> dodaj_prehod_moj_avtomat zaklepaj n sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat zaklepaj u sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat zaklepaj z ("1" :: sklad) zaklepaj sklad
  |> dodaj_prehod_moj_avtomat zaklepaj z ("p" :: sklad) nesprejemno (Sklad.dodaj "p" sklad)
  |> dodaj_prehod_moj_avtomat nesprejemno o sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat nesprejemno n sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat nesprejemno u sklad nesprejemno sklad
  |> dodaj_prehod_moj_avtomat nesprejemno "z" sklad nesprejemno sklad *)

