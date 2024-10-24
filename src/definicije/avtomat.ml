type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  sklad : sklad;
  prehodi : (stanje * char * char * stanje * char list) list;
  epsilon_prehodi : ( stanje * char * stanje * char list ) list;
  zacetno_stanje : stanje;
  zacetni_sklad : sklad;
  sprejemna_stanja : stanje list;
}

let zacetni_sklad avtomat = avtomat.zacetni_sklad

let prazen_avtomat zacetno_stanje s =
  {
    stanja = [ zacetno_stanje ];
    sklad = s;
    prehodi = [];
    epsilon_prehodi = [];
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

let dodaj_epsilon_prehod stanje1 vrh stanje2 (nov_vrh : char list) avtomat =
  { avtomat with epsilon_prehodi = (stanje1, vrh, stanje2, nov_vrh) :: avtomat.epsilon_prehodi }

let prehodna_funkcija avtomat stanje prebrano vrh =
  match
    List.find_opt
      (fun (stanje1, prebrano', vrh', _, _) -> stanje1 = stanje && prebrano = prebrano' && vrh = vrh')
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

  (* 3. naredi funkcije za epsilon prehode
     5. uredi uno z ne-ji??*)

  let sintaksa_oklepajev = 
    let q0 = Stanje.iz_niza "q0"
    and q1 = Stanje.iz_niza "q1"
    and q2 = Stanje.iz_niza "q2"
    and q3 = Stanje.iz_niza "q3"
    and q4 = Stanje.iz_niza "q4"
    in
    prazen_avtomat q0 (Sklad.ustvari ['x'])
    |> dodaj_nesprejemno_stanje q1
    |> dodaj_sprejemno_stanje q2 
    |> dodaj_nesprejemno_stanje q3
    |> dodaj_sprejemno_stanje q4
    |> dodaj_prehod q0 '(' 'x' q1 ['1'; 'x']
    |> dodaj_prehod q0 '[' 'x' q1 ['2'; 'x']
    |> dodaj_prehod q0 '{' 'x' q1 ['3'; 'x']
    |> dodaj_prehod q0 ')' 'x' q3 ['N']
    |> dodaj_prehod q0 ']' 'x' q3 ['N']
    |> dodaj_prehod q0 '}' 'x' q3 ['N']
  
    |> dodaj_prehod q1 '(' '1' q1 ['1'; '1']
    |> dodaj_prehod q1 '[' '1' q1 ['2'; '1']
    |> dodaj_prehod q1 '{' '1' q1 ['3'; '1']
    |> dodaj_prehod q1 '(' '2' q1 ['1'; '2']
    |> dodaj_prehod q1 '[' '2' q1 ['2'; '2']
    |> dodaj_prehod q1 '{' '2' q1 ['3'; '2']
    |> dodaj_prehod q1 '(' '3' q1 ['1'; '3']
    |> dodaj_prehod q1 '[' '3' q1 ['2'; '3']
    |> dodaj_prehod q1 '{' '3' q1 ['3'; '3']

    |> dodaj_prehod q1 ')' '1' q2 []
    |> dodaj_prehod q1 ']' '1' q3 ['N']
    |> dodaj_prehod q1 '}' '1' q3 ['N']
    |> dodaj_prehod q1 ')' '2' q3 ['N']
    |> dodaj_prehod q1 ']' '2' q2 []
    |> dodaj_prehod q1 '}' '2' q3 ['N']
    |> dodaj_prehod q1 ')' '3' q3 ['N']
    |> dodaj_prehod q1 ']' '3' q3 ['N']
    |> dodaj_prehod q1 '}' '3' q2 []

    |> dodaj_prehod q2 '(' '1' q1 ['1'; '1']
    |> dodaj_prehod q2 '(' '2' q1 ['1'; '2']
    |> dodaj_prehod q2 '(' '3' q1 ['1'; '3']

    |> dodaj_prehod q2 '[' '1' q1 ['2'; '1']
    |> dodaj_prehod q2 '[' '2' q1 ['2'; '2']
    |> dodaj_prehod q2 '[' '3' q1 ['2'; '3']

    |> dodaj_prehod q2 '{' '1' q1 ['3'; '1']
    |> dodaj_prehod q2 '{' '2' q1 ['3'; '2']
    |> dodaj_prehod q2 '{' '3' q1 ['3'; '3']
    
    |> dodaj_prehod q2 ')' '1' q2 []
    |> dodaj_prehod q2 ']' '2' q2 []
    |> dodaj_prehod q2 '(' '3' q2 []
    |> dodaj_prehod q2 ')' '2' q3 ['N']
    |> dodaj_prehod q2 ']' '1' q3 ['N']
    |> dodaj_prehod q2 '(' '2' q3 ['N']
    |> dodaj_prehod q2 ')' '3' q3 ['N']
    |> dodaj_prehod q2 ']' '3' q3 ['N']
    |> dodaj_prehod q2 '(' '1' q3 ['N']

    |> dodaj_epsilon_prehod q2 'x' q4 ['x']
    |> dodaj_epsilon_prehod q2 '1' q3 ['x']
    |> dodaj_epsilon_prehod q2 '2' q3 ['x']
    |> dodaj_epsilon_prehod q2 '3' q3 ['x']