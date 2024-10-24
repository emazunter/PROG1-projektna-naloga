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

let prazen_avtomat zacetno_stanje s =
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

(* let preberi_niz avtomat q niz =
  let aux acc znak =
    match acc with None -> None | Some q -> prehodna_funkcija avtomat q znak
  in
  niz |> String.to_seq |> Seq.fold_left aux (Some q) *)


  let sintaksa_oklepajev = 
    let q0 = Stanje.iz_niza "q0"
    and q1 = Stanje.iz_niza "q1"
    and q2 = Stanje.iz_niza "q2"
    and q3 = Stanje.iz_niza "q3"
    and q4 = Stanje.iz_niza "q4"
    and q5 = Stanje.iz_niza "q5"
    in
    prazen_avtomat q0
    |> dodaj_nesprejemno_stanje q1
    |> dodaj_sprejemno_stanje q2 
    |> dodaj_nesprejemno_stanje q3
 (* kAJ PA ČE NSO DOBRO GNEZDENI OKLEPAJI *)
    |> dodaj_prehod q0 '(' "" q1 ["1"]
    |> dodaj_prehod q0 '[' "" q1 ["2"]
    |> dodaj_prehod q0 '{' "" q1 ["3"]
    |> dodaj_prehod q0 ')' "" q3 ["ne"]
    |> dodaj_prehod q0 ']' "" q3 ["ne"]
    |> dodaj_prehod q0 '}' "" q3 ["ne"]
  
    |> dodaj_prehod q1 '(' "1" q1 ["1"; "1"]
    |> dodaj_prehod q1 '[' "1" q1 ["2"; "1"]
    |> dodaj_prehod q1 '{' "1" q1 ["3"; "1"]
    |> dodaj_prehod q1 '(' "2" q1 ["1"; "2"]
    |> dodaj_prehod q1 '[' "2" q1 ["2"; "2"]
    |> dodaj_prehod q1 '{' "2" q1 ["3"; "2"]
    |> dodaj_prehod q1 '(' "3" q1 ["1"; "3"]
    |> dodaj_prehod q1 '[' "3" q1 ["2"; "3"]
    |> dodaj_prehod q1 '{' "3" q1 ["3"; "3"]

    |> dodaj_prehod q1 ')' "1" q2 []
    |> dodaj_prehod q1 ']' "1" q3 ["ne"]
    |> dodaj_prehod q1 '}' "1" q3 ["ne"]
    |> dodaj_prehod q1 ')' "2" q3 ["ne"]
    |> dodaj_prehod q1 ']' "2" q2 []
    |> dodaj_prehod q1 '}' "2" q3 ["ne"]
    |> dodaj_prehod q1 ')' "3" q3 ["ne"]
    |> dodaj_prehod q1 ']' "3" q3 ["ne"]
    |> dodaj_prehod q1 '}' "3" q2 []

    |> dodaj_prehod q2 '(' "1" q1 ["1"; "1"]
    |> dodaj_prehod q2 '(' "2" q1 ["1"; "2"]
    |> dodaj_prehod q2 '(' "3" q1 ["1"; "3"]

    |> dodaj_prehod q2 '[' "1" q1 ["2"; "1"]
    |> dodaj_prehod q2 '[' "2" q1 ["2"; "2"]
    |> dodaj_prehod q2 '[' "3" q1 ["2"; "3"]

    |> dodaj_prehod q2 '{' "1" q1 ["3"; "1"]
    |> dodaj_prehod q2 '{' "2" q1 ["3"; "2"]
    |> dodaj_prehod q2 '{' "3" q1 ["3"; "3"]
    
    |> dodaj_prehod q2 ')' "1" q2 []
    |> dodaj_prehod q2 ']' "2" q2 []
    |> dodaj_prehod q2 '(' "3" q2 []
    |> dodaj_prehod q2 ')' "2" q3 ["ne"]
    |> dodaj_prehod q2 ']' "1" q3 ["ne"]
    |> dodaj_prehod q2 '(' "2" q3 ["ne"]
    |> dodaj_prehod q2 ')' "3" q3 ["ne"]
    |> dodaj_prehod q2 ']' "3" q3 ["ne"]
    |> dodaj_prehod q2 '(' "1" q3 ["ne"]

  

(* let sintaksa_oklepajev = 
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
  |> dodaj_sprejemno_stanje q4
  |> dodaj_sprejemno_stanje q5
  |> dodaj_sprejemno_stanje q6
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
  
  |> dodaj_prehod q4 '(' vrh q1 ["1"; vrh]
  |> dodaj_prehod q4 '[' vrh q2 ["2"; vrh]
  |> dodaj_prehod q4 '{' vrh q3 ["3"; vrh]
  |> dodaj_prehod q4 ')' "1" q4 []
  |> dodaj_prehod q4 ']' "2" q5 []
  |> dodaj_prehod q4 '(' "3" q6 []
  |> dodaj_prehod q4 ')' "2" q7 ["ne"]
  |> dodaj_prehod q4 ']' "1" q7 ["ne"]
  |> dodaj_prehod q4 '(' "2" q7 ["ne"]
  |> dodaj_prehod q4 ')' "3" q7 ["ne"]
  |> dodaj_prehod q4 ']' "3" q7 ["ne"]
  |> dodaj_prehod q4 '(' "1" q7 ["ne"]

  |> dodaj_prehod q5 '(' vrh q1 ["1"; vrh]
  |> dodaj_prehod q5 '[' vrh q2 ["2"; vrh]
  |> dodaj_prehod q5 '{' vrh q3 ["3"; vrh]
  |> dodaj_prehod q5 ')' "1" q4 []
  |> dodaj_prehod q5 ']' "2" q5 []
  |> dodaj_prehod q5 '(' "3" q6 []
  |> dodaj_prehod q5 ')' "2" q7 ["ne"]
  |> dodaj_prehod q5 ']' "1" q7 ["ne"]
  |> dodaj_prehod q5 '(' "2" q7 ["ne"]
  |> dodaj_prehod q5 ')' "3" q7 ["ne"]
  |> dodaj_prehod q5 ']' "3" q7 ["ne"]
  |> dodaj_prehod q5 '(' "1" q7 ["ne"]

  |> dodaj_prehod q6 '(' vrh q1 ["1"; vrh]
  |> dodaj_prehod q6 '[' vrh q2 ["2"; vrh]
  |> dodaj_prehod q6 '{' vrh q3 ["3"; vrh]
  |> dodaj_prehod q6 ')' "1" q4 []
  |> dodaj_prehod q6 ']' "2" q5 []
  |> dodaj_prehod q6 '(' "3" q6 []
  |> dodaj_prehod q6 ')' "2" q7 ["ne"]
  |> dodaj_prehod q6 ']' "1" q7 ["ne"]
  |> dodaj_prehod q6 '(' "2" q7 ["ne"]
  |> dodaj_prehod q6 ')' "3" q7 ["ne"]
  |> dodaj_prehod q6 ']' "3" q7 ["ne"]
  |> dodaj_prehod q6 '(' "1" q7 ["ne"]
 *)
