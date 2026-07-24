:- module(relevant, [relevant_exp/3, relevant_bug/3]).

:- use_module(depends).

% Apply expert and buggy rules
expert(M, X, Y, expert(Step, Flags)) :-
    M:expert(X, Y, Step, Flags).

% Enter expressions
expert(M, X, Y, Step) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, A, Rest),
    expert(M, A, A1, Step),
    nth1(Index, YArgs, A1, Rest),
    compound_name_arguments(Y, Name, YArgs).

% Same for buggy rules    
buggy(M, X, Y, buggy(Step, Flags)) :-
    M:buggy(X, Y, Step, Flags).

buggy(M, X, Y, Step) :-
    compound(X),
    compound_name_arguments(X, Name, XArgs),
    nth1(Index, XArgs, A, Rest),
    buggy(M, A, A1, Step),
    nth1(Index, YArgs, A1, Rest),
    compound_name_arguments(Y, Name, YArgs).

% Search through problem space
solve0(_, X, X, []).

solve0(M, X, Z, [S | Steps]) :-
    expert(M, X, Y, S),
    solve0(M, Y, Z, Steps).

solve(M, X, Y, Path) :-
    solve0(M, X, Y, Path),
    depends(Path).

% Collect paths with only expert rules
relevant_exp(M, X, Relevant) :-
    findall(P, solve(M, X, _, P), List),
    append(List, Paths),
    sort(Paths, Relevant).
    
% Collect paths with n expert rules and 1 buggy rule
relevant0(M, X, Bug) :-
    solve(M, X, Y, _),
    buggy(M, Y, _, Bug).

relevant_bug(M, X, Relevant) :-
    findall(Bug, relevant0(M, X, Bug), Bugs),
    sort(Bugs, Relevant).