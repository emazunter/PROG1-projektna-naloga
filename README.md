# Skladovni avtomati s tremi skladi

Neformalna definicija.

Razlika od končnih avtomatov.

Razlika od skladovnih avtomatov z samo enim skladom

Specifičen primer za uporabo v projektni: primerjanje sintaktične pravilnosti izraza z števili od 0 do 9, oklepaji, ter znaki za operacije (+, -, x, /).

## Matematična definicija

Skladovni avtomat je matematično definiran kot nabor devetih elementov: $(Q, \Sigma, \Gamma_1, \Gamma_2, \Gamma_3 \delta, q_0, Z, F)$, kjer so

- $Q$ (končna) množica stanj,
- $\Sigma$ končna množica, imenovana *vhodna abeceda*
- $\Gamma_1, \Gamma_2, \Gamma_3$ končne množica, imenovana *skladovne abecede* posameznih skladov
- $\delta$ končna podmnožica $Q \times (\Sigma \cup \{\epsilon\}) \times \Gamma_1 \times \Gamma_2 \times \Gamma_3 \to \mathcal{P}(Q \times \Gamma_1^* \times \Gamma_2^* \times \Gamma_3^*)$, kjer je $\epsilon$ prazen niz in $\Gamma^\*_1, \Gamma^\*_2, \Gamma^\*_3$ množice vseh končnih nizov iz skladovnih abeced $\Gamma_1, \Gamma_2, \Gamma_3$
- $q_0 \in Q$ začetno stanje
- $Z \in \Gamma$ začetni simbol sklada
- $F \subseteq Q$ množica sprejemnih stanj.

Še un tadrug del kako deluje tranzicijska relacija??

## Navodila za uporabo.

Navodila za uporabo spletnega vmesnika. (ali tekstovnega...)

## Struktura datotek

Datoteke, kaj počnejo

## Viri

Informacije o skladovnih avtomatih: https://en.wikipedia.org/wiki/Pushdown_automaton
Reddit ima vse odgovore: https://www.reddit.com/r/computerscience/comments/jy2hhe/where_we_use_pushdown_automata_exactly/
V bistvu mi odgovori iz Reddita niso bili všeč in iščem naprej: https://www.geeksforgeeks.org/applications-of-various-automata/

## Avtorji

To sem sexy jaz
