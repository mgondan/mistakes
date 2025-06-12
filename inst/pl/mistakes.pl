:- use_module(intermediate).
:- use_module(message).
:- use_module(depends).
:- use_module(relevant).

:- multifile expert/4, buggy/4.

% Apply expert and buggy rules
step(X, Y, expert(Step, Flags)) :-
    expert(X, Y, Step, Flags).

step(X, Y, buggy(Step, Flags)) :-
    buggy(X, Y, Step, Flags).

step(error(instead(X, Correct)), Y, Step) :-
    !,
    step(X, Y0, Step),
    Y = error(instead(Y0, Correct)).

step(error(omit_right(X)), Y, Step) :-
    !,
    X =.. [Op, A, B],
    step(A, A1, Step),
    Y0 =.. [Op, A1, B],
    Y = error(omit_right(Y0)).

% Enter expressions
step(X, Y, Step) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, A, Rest),
    step(A, A1, Step),
    nth1(Index, YArgs, A1, Rest),
    compound_name_arguments(Y, Name, YArgs).
    
% Search through problem space
search_(X, X, []).

search_(X, Z, [S | Steps]) :-
    step(X, Y, S),
    search_(Y, Z, Steps).

search(X, Y, Path) :-
    search_(X, Y, Path),
    complete(Y),
    depends(Path).

% Remove duplicates due to permutation of steps
search_(X, Y, Path, Sorted, Res) :-
    search(X, Y, Path),
    sort(Path, Sorted),
    r_eval(Y, Res).

search(X, Y, Res, Feedback, Extra) :-
    relevant(X, Relevant),
    findall((Y0 - P0) - (S0 - R0), search_(X, Y0, P0, S0, R0), All),
    sort(2, @<, All, Unique),
    member((Y - Path) - (_ - Res), Unique),
    intersection(Path, Relevant, Feedback),
    subtract(Path, Relevant, Extra).
