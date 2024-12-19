type stanje = Stanje.t
type sklad = Sklad.t


type t = {
  stanja : stanje list;
  prehodi : (stanje * char * string * stanje * string list) list;
  zacetno_stanje : stanje;
  zacetni_sklad : sklad;
  sprejemna_stanja : stanje list;
}

let prazen_avtomat zacetno_stanje s =
  {
    stanja = [ zacetno_stanje ];
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

let dodaj_prehod stanje1 prebrano vrh stanje2 nov_vrh avtomat =
  { avtomat with prehodi = (stanje1, prebrano, vrh, stanje2, nov_vrh) :: avtomat.prehodi }

let prehodna_funkcija avtomat stanje prebrano vrh =
  print_endline ("Current state: " ^ Stanje.v_niz stanje);
  print_endline ("Input: " ^ Char.escaped prebrano);
  print_endline ("Stack top: " ^ String.escaped vrh);
  match
    List.find_opt
      (fun (stanje1, prebrano', vrh', _, _) -> stanje1 = stanje && prebrano = prebrano' && vrh = vrh')
      avtomat.prehodi
  with
  | None -> None
  | Some (_, _, _, stanje2, nov_vrh) ->
      print_endline ("Next state: " ^ Stanje.v_niz stanje2);
      Some (stanje2, nov_vrh)

let zacetno_stanje avtomat = avtomat.zacetno_stanje
let seznam_stanj avtomat = avtomat.stanja
let seznam_prehodov avtomat = avtomat.prehodi
let zacetni_sklad avtomat = avtomat.zacetni_sklad

let je_sprejemno_stanje avtomat stanje =
  List.mem stanje avtomat.sprejemna_stanja

let sintaksa_oklepajev =
  let q1 = Stanje.iz_niza "q1"
  and q2 = Stanje.iz_niza "q2"
  and q3 = Stanje.iz_niza "q3"
  and q0 = Stanje.iz_niza "q0"
  in
  prazen_avtomat q0 (Sklad.ustvari ["x"])
  |> dodaj_sprejemno_stanje q0
  |> dodaj_nesprejemno_stanje q1 
  |> dodaj_sprejemno_stanje q2 
  |> dodaj_nesprejemno_stanje q3
  |> dodaj_prehod q0 '(' "x" q1 ["1"; "x"]
  |> dodaj_prehod q0 ')' "x" q3 ["n"]
  |> dodaj_prehod q1 '(' "1" q1 ["1"; "1"]
  |> dodaj_prehod q1 ')' "1" q2 []
  |> dodaj_prehod q2 ')' "1" q2 []
  |> dodaj_prehod q2 ')' "x" q3 ["n"]
  |> dodaj_prehod q2 '(' "1" q1 ["1"]
  |> dodaj_prehod q2 '(' "x" q1 ["1"]