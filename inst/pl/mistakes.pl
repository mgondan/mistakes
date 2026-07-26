:- module(mistakes, [search/6]).

:- reexport(message).
:- use_module(intermediate).
:- use_module(depends).
:- use_module(relevant).

% Apply expert and buggy rules
step(M, X, Y, expert(Step, Flags)) :-
    M:expert(X, Y, Step, Flags).

step(M, X, Y, buggy(Step, Flags)) :-
    M:buggy(X, Y, Step, Flags).

step(M, error(instead(X, Correct)), Y, Step) :-
    !,
    step(M, X, Y0, Step),
    Y = error(instead(Y0, Correct)).

step(M, error(omit_right(X)), Y, Step) :-
    !,
    X =.. [Op, A, B],
    step(M, A, A1, Step),
    Y0 =.. [Op, A1, B],
    Y = error(omit_right(Y0)).

% Enter expressions
step(M, X, Y, Step) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, A, Rest),
    step(M, A, A1, Step),
    nth1(Index, YArgs, A1, Rest),
    compound_name_arguments(Y, Name, YArgs).
    
% Search through problem space
search_(_, X, X, []).

search_(M, X, Z, [S | Steps]) :-
    step(M, X, Y, S),
    search_(M, Y, Z, Steps).

search(M, X, Y, Path) :-
    search_(M, X, Y, Path),
    complete(M, Y),
    depends(Path).

% Remove duplicates due to permutation of steps
search_(M, X, Y, Path, Sorted, Res) :-
    search(M, X, Y, Path),
    sort(Path, Sorted),
    r_eval(Y, Res).

search(M, X, Y, Res, Feedback, Extra) :-
    relevant_exp(M, X, Expert),
    relevant_bug(M, X, Buggy),
    append(Expert, Buggy, Relevant),
    findall((Y0 - P0) - (S0 - R0), search_(M, X, Y0, P0, S0, R0), All),
    sort(2, @<, All, Unique),
    member((Y - Path) - (_ - Res), Unique),
    intersection(Path, Relevant, Feedback),
    subtract(Path, Relevant, Extra).
