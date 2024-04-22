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

/* hypotheses to be tested,  when changing this code to other domains (music, serie, etc) modify the rules bellow. */

hypothesis('tootsie pops')   :- tootsie_pops, !.
hypothesis('blow pops')   :- blow_pops, !.
hypothesis('dum dums')     :- dum_dums, !.
hypothesis('lifesavers')   :- lifesavers, !.
hypothesis('jolly ranchers')     :- jolly_ranchers, !.
hypothesis('warheads')    :- warheads, !.
hypothesis('sour patch')   :- sour_patch, !.
hypothesis('nerd clusters')   :- nerd_clusters, !.
hypothesis('gummy bears') :- gummy_bears, !.
hypothesis('starburst') :- starburst, !.
hypothesis('skittles'):- skittles, !.
hypothesis('laffy taffy') :- laffy_taffy, !.
hypothesis(unknown). % unknown

/* Candy identification rules   */
tootsie_pops:- fruity,
		hard,
		lollipop,
         	verify_if('known to count how many licks does it take to get to the center').	
blow_pops:- fruity, 
	    hard,
	    lollipop,
	    verify_if('able to become bubble gum').
dum_dums:-  fruity,
	    hard,
	    lollipop,
	    verify_if('the same name as a red velvet song').
lifesavers:- fruity,
	     hard,
             hard_candy,
	     verify_if('this candy can save your life'). 
jolly_ranchers :- fruity,
	 	  hard,
	          hard_candy,
 	 	  verify_if('have a name that is synonymous with happy farmers').
warheads:-  fruity,
	    hard,
	    hard_candy,
 	    verify_if('extreme'). 
sour_patch:- fruity,
	     soft,
	     gummies,
             verify_if('first sour then theyre sweet').
nerd_clusters:- fruity,
	   	soft,
           	gummies,
   	   	verify_if('have tiny multicolored candies known for being nerdy').
gummy_bears:- fruity,
	      soft,
	      gummies,
	      verify_if('belong in the happy world of Haribo').
starburst:- fruity,
	    soft,
            chews,
            verify_if('taste unexplainably juicy').
skittles:- fruity,
	   soft,
	   chews,
	   verify_if('taste like a rainbow').
laffy_taffy :- fruity,
	       soft,
	       chews,
               verify_if('chews'),
	       verify_if('has the worst flavor --banana').
milkchocolate:- chocolate,
                plain,
                sweet,
                verify_if_not('have a white color').

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


/* Classification rules shared by many candy */

fruity    	   :- verify_if('have a fruity flavor').
hard    	   :- verify_if('make teeth hurt when biting it').
soft		   :- verify_if_not('make teeth hurt when biting it').
lollipop 	   :- verify_if('come with a stick').
hard_candy 	   :- verify_if_not('come with a stick').
gummies 	   :- verify_if('squish easily').	
chews 		   :- verify_if_not('squish easily').

chocolate          :- verify_if('contain chocolate'), !.
plain              :- verify_if('have an air of simplicity and sophistication').
withinclusions     :- verify_if_not('have an air of simplicity and sophistication'), !.
sweet              :- verify_if('tend to be chosen by people with a sweet tooth').
savory             :- verify_if_not('tend to be chosen by people with a sweet tooth'), !.
nuts               :- verify_if('contain nuts').
nonuts             :- verify_if_not('contain nuts').

