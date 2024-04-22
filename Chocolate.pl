start :- hypothesis(Candy),
      write('I think the candy is '), % Adapt this text to your domain
      write(Candy),
	  write('.'),
      nl,
      undo.

/* how to ask questions */
ask(P) :-
    write('Does the Candy '), % Adapt this text to your domain
    write(P),
    write('? '),
    read(Answer),
    nl,
    ( (Answer == yes ; Answer == y) -> assert(yes(P)) ; assert(no(P)), fail).

/* how to ask questions and verify if not */
ask_no(P) :-
    write('Does the Candy '),  % Adapt this text to your domain
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

hypothesis("a hershey's milk chocolate bar")   :- milkchocolate, !.
hypothesis('a white chocolate bar')   :- whitechocolate, !.
hypothesis('a dark chocolate bar')     :- darkchocolate, !.
hypothesis("a snicker's bar")   :- snickers, !.
hypothesis("a reese's bar")     :- reeses, !.
hypothesis('a peanut chews bar')    :- peanutchews, !.
hypothesis('a crunch bar')   :- crunch, !.
hypothesis('a kit kat')   :- kitkat, !.
hypothesis('a york peppermint patty') :- york, !.
hypothesis(unknown). % unknown

/* Candy identification rules   */

milkchocolate:- chocolate,
		plain,
		sweet,
		verify_if('have a lighter brown color').

whitechocolate:- chocolate,
		 plain,
		 sweet,
		 verify_if('have a white color').

darkchocolate:- chocolate,
		plain,
		savory.

snickers:- chocolate,
	   withinclusions,
	   nuts,
	   verify_if("have a name that's also a type of chuckle").

reeses:- chocolate,
	 withinclusions,
	 nuts,
	 verify_if('have a name that people pronounce incorrectly to make it rhyme').

peanutchews:- chocolate,
	      withinclusions,
	      nuts,
	      verify_if('also have molasses').

crunch:- chocolate,
	 withinclusions,
	 nonuts,
	 verify_if("have a name after the sound made when you take a bite").

kitkat:- chocolate,
	 withinclusions,
	 nonuts,
	 verify_if('have a history with Kourtney Kardashian').

york:- chocolate,
       withinclusions,
       nonuts,
       verify_if("have a minty flavor").





/* Classification rules shared by many candies */
chocolate          :- verify_if('contain chocolate'), !.
fruity             :- verify_if('have fruity flavor'), !.
plain              :- verify_if('like simplicity').
withinclusions     :- verify_if('think it is best when accompanied by others'), !.
sweet              :- verify_if('tend to be chosen by people with a sweet tooth').
savory             :- verify_if('have an air of sophistication'), !. 
nuts               :- verify_if('contain nuts').
nonuts             :- verify_if_not('contain nuts').

