# Skladovni avtomati

Neformalna definicija.

Razlika od končnih avtomatov.

Primeri uporabe:
- Preverjanje, ali ima izraz pravilno število oklepajev.
- HANOJSKI STOLP??

Specifičen primer za uporabo v projektni.

## Matematična definicija

Skladovni avtomat je matematično definiran kot nabor sedmih elementov: $(Q, \Sigma, \Gamma \delta, q_0, Z, F)$, kjer je

- $Q$ (končna) množica stanj,
- $\Sigma$ končna množica, imenovana *vhodna abeceda*
- $\Gamma$ končna množica, imenovana *skladovna abeceda*
- $\delta$ končna podmnožica $Q \times \Gamma \times (\Sigma \cup \\{\epsilon\\}) \times Q \times \Gamma^\*$, oz *tranzicijske relacije* (kjer je $\epsilon$ prazen niz in $\Gamma^\*$ množica vseh končnih nizov iz skladovne abecede $\Gamma$
- $q_0 \in Q$ začetno stanje
- $Z \in \Gamma$ začetni simbol sklada
- $F \subseteq Q$ množica sprejemnih stanj.

Še un tadrug del kako deluje tranzicijska relacija??

## Navodila za uporabo.

Navodila za uporabo spletnega vmesnika.

## Struktura datotek

Datoteke, kaj počnejo

## Viri

Informacije o skladovnih avtomatih: https://en.wikipedia.org/wiki/Pushdown_automaton
Reddit ima vse odgovore: https://www.reddit.com/r/computerscience/comments/jy2hhe/where_we_use_pushdown_automata_exactly/
V bistvu mi odgovori iz Reddita niso bili všeč in iščem naprej: https://www.geeksforgeeks.org/applications-of-various-automata/

## Avtorji

To sem sexy jaz
