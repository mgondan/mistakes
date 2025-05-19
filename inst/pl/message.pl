:- module(message, [message/2]).

:- use_module(library(mathml)).

:- format_predicate(m, format_mathjax(_, _Symbol)).

format_mathjax(_, Symbol) :-
  mathml:jax(Symbol, M, []),
  format("$~w$", [M]).

message(Code, Res) :-
    msg(Code, Mask_Format),
    message_(Mask_Format, Res).

message_(Mask-Format, Res) :-
    !,
    format(string(Res), Mask, Format).

message_(String, String).

