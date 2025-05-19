% Solution of the problem
intermediate(tratio/8).
expert(tratio(_, _, _, _, X, Mu, S, N), tpaired(X, Mu, S, N), paired).

intermediate(tpaired/4).
expert(tpaired(X, Mu, S, N), dfrac(X - Mu, S / sqrt(N)), tratio).

% Other steps
intermediate(tindep/5).
expert(tindep(T0, S_T0, EOT, S_EOT, N), 
    dfrac(T0 - EOT, 
      sqrt(denote(s_pool^2, var_pool(N, S_T0^2, N, S_EOT^2), "the pooled variance") * (1/N + 1/N))), 
    twosample).

% Mistakes
buggy(tratio(T0, S_T0, EOT, S_EOT, _, _, _, N), tindep(T0, S_T0, EOT, S_EOT, N), indep).

buggy(dfrac(X - Mu, S / SQRTN), X - dfrac(Mu, S) / SQRTN, paren).

buggy(sqrt(N), error(instead(N, sqrt(N))), sqrt(N)).

buggy(tratio(X, Mu, S, N), 
    dfrac(error(omit_right(X - Mu)), S / sqrt(N)), mu(Mu)).

buggy(tratio(X, Mu, S, N), 
    dfrac(error(omit_right(X - Mu)), S / sqrt(N)), mu(Mu)).

buggy(tratio(X, Mu, S, N), 
    dfrac(error(omit_right(X - Mu)), S / sqrt(N)), mu(Mu)).

% Feedback
msg(indep, "This is not a two-sample problem.").

msg(twosample, "(irrelevant) Correctly determined the expression for the two-sample ~m-test."-[t]).

msg(paired, "This is indeed a problem with paired samples.").

msg(tratio, "Correctly identified the expression for the ~m-ratio."-[t]).

msg(paren, "Please do not forget the parentheses around the numerator and 
    the denominator of a fraction.").

msg(sqrt(X), "Please do not omit the square root around ~m."-[X]).

msg(mu(Mu), "Do not omit the null hypothesis ~m in the ~m-ratio."-[Mu, t]).