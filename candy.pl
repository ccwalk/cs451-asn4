start :- hypothesis(Animal),
      write('I think the animal is '), % Adapt this text to your domain
      write(Animal),
	  write('.'),
      nl,
      undo.

/* how to ask questions */
ask(P) :-
    write('Does the Animal '), % Adapt this text to your domain
    write(P),
    write('? '),
    read(Answer),
    nl,
    ( (Answer == yes ; Answer == y) -> assert(yes(P)) ; assert(no(P)), fail).

/* how to ask questions and verify if not */
ask_no(P) :-
    write('Does the Animal '),  % Adapt this text to your domain
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

hypothesis('a lion')   :- lion, !.
hypothesis('a jaguar')   :- jaguar, !.
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

/* Animal identification rules   */
lion :- mammal, 
           carnivore, 
           verify_if('has yellow/orange fur'),
           verify_if('has a mane').
jaguar :- mammal, 
           carnivore, 
           verify_if('has yellow/orange fur'),
           verify_if('has black spots').
tiger :- mammal,  
         carnivore,
         verify_if('has yellow/orange fur'),
         verify_if('has black stripes').
giraffe :- ungulate, 
           verify_if('has a long neck'), 
           verify_if('has long legs').
zebra :- ungulate,  
         verify_if_not('has a long neck'), 
         verify_if('has black stripes').
horse :- ungulate,
         verify_if_not('has a long neck'), 
         verify_if_not('has black stripes').
penguin :- bird,
           verify_if_not('fly'), 
           verify_if('has stared in a animated movie and tv series').
ostrich :- bird,  
           verify_if_not('fly'), 
           verify_if('has a long neck').
turkey :- bird, 
        verify_if_not('fly'),
        verify_if('attended the first thanksgiving dinner').
vulture :- bird,
         verify_if('fly'),
         verify_if('carrion'),
         verify_if('has a long neck').
crow :- bird,
         verify_if('fly'),
         verify_if('carrion'),
         verify_if_not('has a long neck').

/* Classification rules shared by many animals */
mammal    :- verify_if('has fur or hair'), !.
mammal    :- verify_if('give milk').
bird      :- verify_if('has feathers'), !.
bird      :- verify_if('lay eggs').
carnivore :- verify_if('eats meat'), !.
carnivore :- verify_if('has sharp teeth'), 
             verify_if('has forward eyes').
ungulate :- mammal, 
            verify_if('has hooves').
