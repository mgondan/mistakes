% very basic i18n support until we have a better solution
:- module(i18n, [lang/1]).

lang(L) :-
  r_eval(lang(), L0),
  !, atom_string(L, L0).

% Silent
% lang(en).
