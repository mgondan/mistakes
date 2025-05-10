:- use_module(library(http/html_write)).

% Apply expert and buggy rules
step(X, Y, [expert(Step)]) :-
    expert(X, Y, Step).

step(X, Y, [buggy(Step)]) :-
    buggy(X, Y, Step).

% Enter expressions
step(X, Y, Path) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, Arg, Rest),
    search(Arg, New, Path),
    nth1(Index, YArgs, New, Rest),
    compound_name_arguments(Y, Name, YArgs).
    
% Search through problem space
search_(X, X, []).

search_(X, Z, Path) :-
    step(X, Y, Step),
    search_(Y, Z, Path0),
    append(Step, Path0, Path).

search(X, Y, [H | Path]) :-
    search_(X, Y, [H | Path]).