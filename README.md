# Skladovni avtomati

Projektna naloga vsebuje implementacijo skladovnih avtomatov. Skladovni avtomati so nadgradnja končnih avtomatov, ki vsebuje še sklad, na katerega lahko ob vsakem prebranem znaku iz niza avtomat naloži znake ali jih iz njega vzame. 

Glavni sestavni deli avtomata so njegova stanja, prehodi med njimi, sklad, ter trak, na katerem so simboli, ki jih avtomat bere. Avtomat delovanje prične v vnaprej določenem začetnem stanju. Nato prebere simbol s traka ter morebitni element na vrhu sklada in na osnovi tega izvede prehod v drugo stanje, ter morda doda ali vzame vrhnji element s sklada. Nato prebere naslednji simbol s traka in proces se ponovi. Proces se nato ponavlja, dokler na traku ne zmanjka simbolov. Avtomat potem niz bodisi sprejme bodisi ga ne, glede na to, v katerem od stanj se avtomat nahaja ko zmanjka simbolov na traku.

V svoji projektni nalogi bom kot primer skladovnega avtomata implementirala avtomat, ki sprejema nize, sestavljene iz znakov "(", ")", "[", "]", "{", in "}", in preverja njihovo sintaktično pravilnost. 

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

Implementirala bom skladovni avtomat, ki preverja sintaktično pravilnost niza z znaki "(", ")", "[", "]", "{", in "}". 
Vsak posamezen uklepaj mora imeti za sabo (nekje v nizu) ustrezen zaklepaj, poleg tega pa morajo biti oklepaji pravilno gnezdeni, tj. uklepaju ene vrste ne sme takoj slediti zaklepaj druge vrste. Avtomat bo torej sprejel niz "([{}])", ne bo pa sprejel nizov "[](", "({)}" ali "abcd".

Avtomat ima pet stanj: začetno (q0), push stanje (q1), pull stanje (q2), nesprejemno stanje (q3) ter sprejemno stanje (q4). Avtomat delovanje začne v začetnem stanju, na skladu pa je črka x. Ko avtomat prebere prvi znak, začetno stanje zapusti in se vanj ne vrača. Ko avtomat s traku prebere znak "(", "[" ali "{", na sklad naloži številko 1, 2 ali 3, glede na to, katerega od uklepajev je prebral, ter se premakne v stanje q1 (kar pomeni, da je pri zadnjem znaku nekaj naložil na sklad.) Ko prebere enega od zaklepajev, preveri kaj je na vrhu sklada. Če je na vrhu številka, ki pripada zaklepaju pripadajočemu uklepaju, avtomat to številko odstrani z vrha sklada in se premakne v stanje q2. Če ni, se avtomat premakne v nesprejemno stanje q3, iz katerega se potem ne vrne. Če je avtomat ob koncu niza v stanju q2, izvede še epsilonski prehod, ki preveri, če je kaj še ostalo na skladu. Če je tam samo črka "x", pomeni, da smo vse oklepaje pravilno zaprli, in avtomat gre v sprejemno stanje q4. Če je na skladu kakšna od številk, se avtomat prestavi v nesprejemno stanje.

## Navodila za uporabo.

Navodila za uporabo spletnega vmesnika. (ali tekstovnega..)

## Struktura datotek

Datoteke, kaj počnejo

## Viri

Informacije o skladovnih avtomatih: https://en.wikipedia.org/wiki/Pushdown_automaton

