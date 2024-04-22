start :- hypothesis(Candy),
      write('I think the candy is '), % Adapt this text to your domain
      write(Candy),
	  write('.'),
      nl,
      undo.

/* how to ask questions */
ask(P) :-
    write('Does the candy '), % Adapt this text to your domain
    write(P),
    write('? '),
    read(Answer),
    nl,
    ( (Answer == yes ; Answer == y) -> assert(yes(P)) ; assert(no(P)), fail).

/* how to ask questions and verify if not */
ask_no(P) :-
    write('Does the candy '),  % Adapt this text to your domain
    write(P),
    write('? '),
    read(Answer),
    nl,
    ( (Answer == yes ; Answer == y) -> assert(yes(P)),fail ; assert(no(P)) ).


:- dynamic yes/1,no/1.

/* Verifies if something = yes  */
verify_if(S) :-
   (yes(S) -> true ;
    (no(S) -> fail ;
     ask(S))).

/* Verifies if something = no */
verify_if_not(S) :-
   (yes(S) -> fail ;
    (no(S) -> true ;
     ask_no(S))).


/* undo all yes/no assertions so that we can reuse start again*/
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.

/* hypotheses to be tested, 
 when changing this code to other domains (music, serie, etc) 
 modify the rules bellow. */

hypothesis('sour patch')   :- sour_patch, !.
hypothesis('sour worms')   :- sour_worms, !.
hypothesis('a tiger')     :- tiger, !.
hypothesis('a giraffe')   :- giraffe, !.
hypothesis('a zebra')     :- zebra, !.
hypothesis('a horse')    :- horse, !.
hypothesis('a penguim')   :- penguin, !.
hypothesis('an ostrich')   :- ostrich, !.
hypothesis('a turkey') :- turkey, !.
hypothesis('a vulture') :- vulture, !.
hypothesis('a crow'):- crow, !.
hypothesis(unknown). % unknown

/* Candy identification rules   */
sour_patch :- sour, 
           gummies, 
	   fruity,
           verify_if('first theyre sour then theyre sweet'),
           verify_if('has a m').
sour_worms :- mammal, 
           carnivore, 
           verify_if('has yellow/orange fur'),
           verify_if('has black spots').
lemon_drops :- mammal,  
         carnivore,
         verify_if('has yellow/orange fur'),
         verify_if('has black stripes').
air_heads :- ungulate, 
           verify_if('has a long neck'), 
           verify_if('has long legs').
jawbreakers :- ungulate,  
         verify_if_not('has a long neck'), 
         verify_if('has black stripes').
spinners :- ungulate,
         verify_if_not('has a long neck'), 
         verify_if_not('has black stripes').
red_white_twists :- bird,
           verify_if_not('fly'), 
           verify_if('has stared in a animated movie and tv series').
werthers :- bird,  
           verify_if_not('fly'), 
           verify_if('has a long neck').
dum_dums :- bird, 
        verify_if_not('fly'),
        verify_if('attended the first thanksgiving dinner').
tootsie_pops :- bird,
         verify_if('fly'),
         verify_if('carrion'),
         verify_if('has a long neck').
crow :- bird,
         verify_if('fly'),
         verify_if('carrion'),
         verify_if_not('has a long neck').

/* Classification rules shared by many animals */
hard_candy    :- verify_if('has fur or hair'), !.
hard_candy    :- verify_if('give milk').
gummies      :- verify_if('chewy'), !.
gummies      :- verify_if('lay eggs').
fruity	     :- verify_if(' ') !.
chocolate :- verify_if('eats meat'), !.
sour  :- verify_if('has sharp teeth'), 
             verify_if('has forward eyes').
sweet :- mammal, 
            verify_if('has hooves').
salty :- verify_if(''), !.
savory :- verify_if(''), !.
caramel :- verify_if(''), !.
bubble_gum :- verify_if(''), !.
