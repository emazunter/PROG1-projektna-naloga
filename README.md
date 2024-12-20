# Skladovni avtomati

Projektna naloga vsebuje implementacijo skladovnih avtomatov. Skladovni avtomati so nadgradnja končnih avtomatov, ki dodatno vsebuje še sklad, na katerega lahko avtomat naloži znake ali jih iz njega vzame. 

Glavni deli avtomata so njegova stanja, prehodi med njimi, sklad, ter trak, na katerem so simboli, ki jih avtomat bere. Avtomat delovanje prične v vnaprej določenem začetnem stanju. Nato prebere simbol s traka ter morebitni element na vrhu sklada in na osnovi tega izvede prehod v drugo stanje, ter morda doda ali vzame vrhnji element s sklada. Nato prebere naslednji simbol s traka in proces se ponovi. Proces se nato ponavlja, dokler na traku ne zmanjka simbolov. Avtomat potem niz bodisi sprejme bodisi ga ne, odvisno od stanja, v katerem se avtomat nahaja, ko zmanjka simbolov na traku.

V svoji projektni nalogi bom kot primer skladovnega avtomata implementirala avtomat, ki sprejema nize, sestavljene iz znakov "(" in ")", in preverja njihovo sintaktično pravilnost. 

## Matematična definicija

Skladovni avtomat je matematično definiran kot nabor: $(Q, \Sigma, \Gamma, \delta, q_0, Z, F)$, kjer so

- $Q$ (končna) množica stanj,
- $\Sigma$ končna množica, imenovana *vhodna abeceda*
- $\Gamma$ končna množica, imenovana *skladovna abeceda*
- $\delta$ končna podmnožica $\delta \subseteq Q \times (\Sigma \cup \\{\varepsilon\\}) \times \Gamma \times Q \times \Gamma^\*$, imenovana *tranzicijska relacija*, kjer je $\epsilon$ prazen niz in $\Gamma^\*$ množica vseh končnih nizov iz skladovne abecede
- $q_0 \in Q$ začetno stanje
- $Z \in \Gamma$ začetni simbol sklada
- $F \subseteq Q$ množica sprejemnih stanj.

Tranzicijsko relacijo lahko razumemo kot funkcijo, ki slika iz $Q \times (\Sigma \cup \{\epsilon\}) \times \Gamma$ v $\mathcal{P}(Q \times \Gamma^\*)$. Elementi množice $\delta$ so prehodi, ki "pogledajo" stanje avtomata, trenutni znak na traku in znak na vrhu sklada, ter "vrnejo" novo stanje in nov sklad - tj. prestavijo avtomat v novo stanje in dodajo ali vzamejo znak s sklada. 

## Moja implementacija

Implementirala bom skladovni avtomat, ki preverja sintaktično pravilnost niza, sestavnjenega iz znakov "(" in ")".
Vsak posamezen uklepaj mora imeti za sabo (nekje v nizu) pripadajoč zaklepaj, poleg tega pa morajo biti oklepaji pravilno gnezdeni. Avtomat bo torej sprejel nize "()()", "((()))", ne bo sprejel nizov "(", "(()", niz "abc" pa bo označil za neveljavnega.

Avtomat ima štiri stanja: *začetno* (q0), stanje *"zadnji znak je bil uklepaj"* (q1), *"zadnji znak je bil zaklepaj"* (q2), ter *neveljavno stanje* (q3). Avtomat delovanje začne v začetnem stanju, na skladu pa je črka x. Ko avtomat prebere prvi znak, začetno stanje zapusti in se vanj ne vrača. Ko avtomat prebere znak "(", se premakne v stanje q1, ter na sklad naloži "1". Ko avtomat prebere znak ")", s sklada pobere znak "1" in se premakne v stanje q2. Če avtomat prebere znak ")" in na skladu ni enke, se premakne v neveljavno stanje (q3), iz katerega se potem ne vrne. Če avtomat delovanje konča v stanju q1 ali q3, niza ne sprejme. Če delovanje konča v stanju q2 ali q0, preveri še, da je na vrhu sklada znak "x", torej da je sklad prazen. Če je na skladu karkoli drugega, avtomat niz zavrne. Če ni, je niz sprejet.

## Struktura datotek

Glavna mapa v projektu je *src*, ki se razveji na podmapi *definicije* in *tekstovniVmesik*.
V mapi *definicije* imamo datoteke: 
- *avtomat.ml*, v kateri so definirane osnovne funkcije za uporabo avtomata in moja implementacija skladovnega avtomata, ter njena signatura *avtomat.mli*
- *sklad.ml*, kjer so funkcije za uporabo sklada, in njena signatura *sklad.mli*
- *stanje.ml*, kjer je definiran tip stanja, in njena signatura *stanje.mli*
- *trak.ml, trak.mli, zagnaniAvtomat.ml in zagnaniAvtomat.mli*, ki v moji implementaciji **niso uporabljene**, vendar služijo za implementacijo traku v avtomat,

V mapi *tekstovniVmesik* pa se nahaja datoteka *tekstovniVmesnik.exe*, ki vsebuje implementacijo tekstovnega vmesnika.

## Navodila za uporabo

V *.ml* datotekah imamo program, s pomočjo katerega bi lahko implementirali poljuben determinističen skladovni avtomat. Moja implementacija se požene s pomočjo tekstovnega vmesnika. Vmesnik poženemo tako, da v terminal najprej napišemo "dune build", potem pa "dune exec ./tekstovniVmesnik.exe". Takrat se nam odpre tekstovni vmesnik, s katerim lahko potem interaktiramo.

## Viri

Informacije o skladovnih avtomatih: https://en.wikipedia.org/wiki/Pushdown_automaton

