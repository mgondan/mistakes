% Check dependencies in flags
:- module(depends, [depends/1]).

% Check if there is a step for each dependency
depends(expert(_, Flags), Depends) :-
    findall(D, member(depends(D), Flags), Depends).

depends(buggy(_, Flags), Depends) :-
    findall(D, member(depends(D), Flags), Depends).

steps(expert(Step, _), Step).

steps(buggy(Step, _), Step).

depends(Path) :-
    maplist(depends, Path, Dep0),
    append(Dep0, Dep1),
    maplist(steps, Path, Steps),
    subtract(Dep1, Steps, []).