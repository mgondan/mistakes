:- module(message, [message/3, praise/3, blame/3]).

:- use_module(i18n).
:- format_predicate(m, format_mathjax(_, _Symbol)).

format_mathjax(_, Symbol) :-
  mathml:jax(Symbol, M, []),
  format("$~w$", [M]).

message(M, Code, Res) :-
    M:msg(Code, Mask_Format),
    message_(Mask_Format, Res).

message_(Mask-Format, Res) :-
    !,
    format(string(Res), Mask, Format).

message_(String, String).

% New version
praise(M, Code, Res) :-
    lang(L),
    M:praise(L, Code, Mask_Format),
    !, message_(Mask_Format, Res).

praise(M, Code, Res) :-
    M:praise(Code, Mask_Format),
    message_(Mask_Format, Res).

blame(M, Code, Res) :-
    lang(L),
    M:blame(L, Code, Mask_Format),
    !, message_(Mask_Format, Res).

blame(M, Code, Res) :-
    M:blame(Code, Mask_Format),
    message_(Mask_Format, Res).
