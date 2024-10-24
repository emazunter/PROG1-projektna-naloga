# Skladovni avtomati

Projektna naloga vsebuje implementacijo skladovnih avtomatov. Skladovni avtomati so nadgradnja končnih avtomatov, ki vsebuje še sklad, na katerega lahko ob vsakem prebranem znaku iz niza avtomat naloži znake ali jih iz njega vzame. 

Glavni sestavni deli avtomata so njegova stanja, prehodi med njimi, sklad, ter trak, na katerem so simboli, ki jih avtomat bere. Avtomat delovanje prične v vnaprej določenem začetnem stanju. Nato prebere simbol s traka ter morebitni element na vrhu sklada in na osnovi tega izvede prehod v drugo stanje, ter morda doda ali vzame vrhnji element s sklada. Nato prebere naslednji simbol s traka in proces se ponovi. Proces se nato ponavlja, dokler na traku ne zmanjka simbolov. Avtomat potem niz bodisi sprejme bodisi ga ne, glede na to v katerem od stanj se avtomat nahaja ko zmanjka simbolov na traku.

Specifičen primer za uporabo v projektni: primerjanje sintaktične pravilnosti izraza

## Matematična definicija

Skladovni avtomat je matematično definiran kot nabor: $(Q, \Sigma, \Gamma, \delta, q_0, Z, F)$, kjer so

- $Q$ (končna) množica stanj,
- $\Sigma$ končna množica, imenovana *vhodna abeceda*
- $\Gamma$ končna množica, imenovana *skladovna abeceda*
- $\delta$ končna podmnožica $Q \times (\Sigma \cup \{\epsilon\}) \times \Gamma \to \mathcal{P}(Q \times \Gamma^\*)$, kjer je $\epsilon$ prazen niz in $\Gamma^\*$ množica vseh končnih nizov iz skladovne abecede
- $q_0 \in Q$ začetno stanje
- $Z \in \Gamma$ začetni simbol sklada
- $F \subseteq Q$ množica sprejemnih stanj.

Še un tadrug del kako deluje tranzicijska relacija??

## Moj primer.

Implementirala bom skladovni avtomat, ki preverja sintaktično pravilnost niza z gnezdenimi oklepaji, tj. z znaki (, ), [, ], {, in }. 

## Navodila za uporabo.

Navodila za uporabo spletnega vmesnika. (ali tekstovnega..)

## Struktura datotek

Datoteke, kaj počnejo

## Viri

Informacije o skladovnih avtomatih: https://en.wikipedia.org/wiki/Pushdown_automaton
Reddit ima vse odgovore: https://www.reddit.com/r/computerscience/comments/jy2hhe/where_we_use_pushdown_automata_exactly/
V bistvu mi odgovori iz Reddita niso bili všeč in iščem naprej: https://www.geeksforgeeks.org/applications-of-various-automata/

## Avtorji

To sem sexy jaz
