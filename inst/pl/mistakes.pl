:- use_module(intermediate).

% Apply expert and buggy rules
step(X, Y, expert(Step)) :-
    expert(X, Y, Step).

step(X, Y, buggy(Step)) :-
    buggy(X, Y, Step).

% Enter expressions
step(X, Y, Step) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, Arg, Rest),
    search_(Arg, New, [Step]),
    nth1(Index, YArgs, New, Rest),
    compound_name_arguments(Y, Name, YArgs).
    
% Search through problem space
search_(X, X, []).

search_(X, Z, [Step | Path]) :-
    step(X, Y, Step),
    search_(Y, Z, Path).

search(X, Y, Path) :-
    search_(X, Y, Path),
    complete(Y).

% Remove duplicates due to permutation of steps
search_(X, Y, Path, Sorted, Res) :-
    search(X, Y, Path),
    sort(Path, Sorted),
    r_eval(Y, Res).

search(X, Y, Path, Res) :-
    findall((Y0 - P0) - (S0 - R0), search_(X, Y0, P0, S0, R0), All),
    sort(2, @<, All, Unique),
    member((Y - Path) - (_ - Res), Unique).
