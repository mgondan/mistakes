:- module(intermediate, [complete/1]).

% Atoms (e.g. s_t0) are always complete
complete(X) :-
    atomic(X),
    !.

% Compounds are complete 
% - if they haven't been declared as intermediate 
% - and if all their arguments are complete
complete(X) :-
    compound(X),
    compound_name_arity(X, Name, Arity),
    not(user:intermediate(Name/Arity)),
    compound_name_arguments(X, Name, Arguments),
    maplist(complete, Arguments).
