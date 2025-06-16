:- module(relevant, [relevant_exp/2, relevant_bug/2]).

:- use_module(depends).

% Apply expert and buggy rules
expert(X, Y, expert(Step, Flags)) :-
    expert(X, Y, Step, Flags).

% Enter expressions
expert(X, Y, Step) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, A, Rest),
    expert(A, A1, Step),
    nth1(Index, YArgs, A1, Rest),
    compound_name_arguments(Y, Name, YArgs).

% Same for buggy rules    
buggy(X, Y, buggy(Step, Flags)) :-
    buggy(X, Y, Step, Flags).

buggy(X, Y, Step) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, A, Rest),
    buggy(A, A1, Step),
    nth1(Index, YArgs, A1, Rest),
    compound_name_arguments(Y, Name, YArgs).

% Search through problem space
solve0(X, X, []).

solve0(X, Z, [S | Steps]) :-
    expert(X, Y, S),
    solve0(Y, Z, Steps).

solve(X, Y, Path) :-
    solve0(X, Y, Path),
    depends(Path).

% Collect paths with only expert rules
relevant_exp(X, Relevant) :-
    findall(P, solve(X, _, P), List),
    append(List, Paths),
    sort(Paths, Relevant).
    
% Collect paths with n expert rules and 1 buggy rule
relevant0(X, Bug) :-
    solve(X, Y, _),
    buggy(Y, _, Bug).

relevant_bug(X, Relevant) :-
    findall(Bug, relevant0(X, Bug), Bugs),
    sort(Bugs, Relevant).