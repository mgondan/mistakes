:- module(message, [message/2]).

message(Code, Res) :-
    msg(Code, Mask_Format),
    message_(Mask_Format, Res).

message_(Mask-Format, Res) :-
    !,
    format(string(Res), Mask, Format).

message_(String, String).