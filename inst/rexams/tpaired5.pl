:- module(tpaired5, []).

:- discontiguous intermediate/1, expert/4, buggy/4.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tpaired/3).
expert(X, Y, sigma, []) :-
    X = tpaired(Mu_D, Mu_0, S_T0),
    Y = sigma(Mu_D, Mu_0, dot(round(0.63, 2), S_T0)).

intermediate(sigma/3).
expert(X, Y, effsize, []) :-
    X = sigma(Mu_D, Mu_0, Sd),
    Y = effsize(dfrac(Mu_D - Mu_0, Sd)).

intermediate(effsize/1).
expert(X, Y, sample, []) :-
    X = effsize(D),
    A = denote(d, D, "with ~m denoting the standardized effect size."),
    Y = 'as.character'(ceiling(dfrac(9, A^2))).

% Mistakes
buggy(X, Y, sdt0, []) :-
    X = tpaired(Mu_D, Mu_0, S_T0),
    Y = sigma(Mu_D, Mu_0, S_T0).

buggy(X, Y, brackets, []) :-
    X = sigma(Mu_D, Mu_0, Sd),
    Y = effsize(Mu_D - dfrac(Mu_0, Sd)).

buggy(X, Y, mu0, []) :-
    X = sigma(Mu_D, _Mu_0, Sd),
    Y = effsize(dfrac(Mu_D, Sd)).

buggy(X, Y, nosquare, []) :-
    X = effsize(D),
    A = denote(d, D, "with ~m denoting the standardized effect size."),
    Y = 'as.character'(ceiling(dfrac(9, A))).

buggy(X, Y, indep, []) :-
    X = effsize(D),
    A = denote(d, D, "with ~m denoting the standardized effect size."),
    Y = 'as.character'(ceiling(dfrac(42, A^2))).

% Feedback
praise(en, sigma, "You have correctly calculated the standard deviation of the change score.").

praise(en, effsize, "You have correctly estimated the effect size.").

praise(en, sample, "You have correctly used the approximation formula for the sample size.").

blame(en, sdt0, "Careful, you used the standard deviation of the T0 measurements instead of calculating the $S_D$ of the change scores.").

blame(en, brackets, "Careful, you forgot to use parentheses when calculating the effect size.").

blame(en, mu0, "Careful, you forgot to subtract ~m."-[mu_0]).

blame(en, nosquare, "Careful, you forgot to square the effect size in the formula.").

blame(en, indep, "Careful, you used the approximation formula $N = 42/d^2$ suitable for an independent groups $t$-test."). 

