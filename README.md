# Skladovni avtomati s tremi skladi

Neformalna definicija.

Razlika od končnih avtomatov.

Razlika od skladovnih avtomatov z samo enim skladom

Specifičen primer za uporabo v projektni: primerjanje sintaktične pravilnosti izraza z števili od 0 do 9, oklepaji, ter znaki za operacije (+, -, x, /).

## Matematična definicija

Skladovni avtomat je matematično definiran kot nabor: $(Q, \Sigma, \Gamma_1, \Gamma_2, \Gamma_3 \delta, q_0, Z_1, Z_2, Z_3, F)$, kjer so

- $Q$ (končna) množica stanj,
- $\Sigma$ končna množica, imenovana *vhodna abeceda*
- $\Gamma_1, \Gamma_2, \Gamma_3$ končne množice, imenovane *skladovne abecede* posameznih skladov
- $\delta$ končna podmnožica $Q \times (\Sigma \cup \{\epsilon\}) \times \Gamma_1 \times \Gamma_2 \times \Gamma_3 \to \mathcal{P}(Q \times \Gamma_1^* \times \Gamma_2^* \times \Gamma_3^*)$, kjer je $\epsilon$ prazen niz in $\Gamma^\*_1, \Gamma^\*_2, \Gamma^\*_3$ množice vseh končnih nizov iz skladovnih abeced $\Gamma_1, \Gamma_2, \Gamma_3$
- $q_0 \in Q$ začetno stanje
- $Z_1 \in \Gamma_1$, $Z_2 \in \Gamma_2$, $Z_3 \in \Gamma_3$ začetni simboli posameznih skladov
- $F \subseteq Q$ množica sprejemnih stanj.

Še un tadrug del kako deluje tranzicijska relacija??

## Moj primer.

Mogoče ne brat tega ker je narobe

Skladovni avtomat, ki ga bom implementirala, preverja sintaktično pravilnost matematičnega izraza, ki vsebuje števke od 0 do 9 (ki lahko tvorijo tudi večja števila), znake za operacije +, -, x in /, ter oklepaja (, ). 

Proces gre nekako tako: vsi trije skladi imajo ob pričetku začetni znak 0, ki predstavlja začetek. Avtomat pogleda prvi znak, ki je lahko bodisi uklepaj bodisi števka. Če ni, gre avtomat v nesprejemljivo stanje. Če je znak števka, avtomat na prvi sklad shrani "N", če je uklepaj pa znak "1". (Kasneje bomm videli, da za zaklepaj na sklad postavi znak "2" in za operacijo znak "O".) Potem pogleda drugi znak. 

Kateri prehodi so sprejemljivi sem osnovala glede na smiselnost predhodnega znaka. V sintaktično pravilnem matematičnem izrazu, recimo, pred znakom za operacijo ne moremo imeti uklepaja ali še enega znaka za operacijo. Zato, ko sklad na prvi (oz. drugi) sklad postavi znak O, pogleda zadnji znak iz drugega (oz. prvega) sklada. Če je le-ta "2" ali "N", avtomat nadaljuje delovanje. Če pa je "1" ali "O", avtomat delovanje prekine.

Tretji sklad je namenjen preverjanju ujemanja oklepajev. Vsakič, ko na prvi ali drugi sklad zaipšemo "1", to zapišemo tudi na tretji sklad. Ko na prvi ali drugi sklad zapišemo "2", iz tretjega sklada vzamemo "1". Če avtomat iz sklada odstrani "0", gre v nesprejemno stanje. Če je ob koncu izvajanja na vrhu tretjega sklada kaj drugega kot "0", gre avtomat prav tako v nesprejemno stanje. 

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
