% Solution of the problem
intermediate(pvalue/5).
expert(X, Y, paired, []) :-
  X = pvalue(D, Mu, S, N, _Alpha),
  Y = { '<-'(t, tpaired(D, Mu, S, N)) 
        ; pvalue('<-'(p, twotailed(t, N-1)))
      }.

intermediate(tpaired/4).
expert(tpaired(X, Mu, S, N), dfrac(X - Mu, S / sqrt(N)), tratio, []).

intermediate(twotailed/2).
expert(twotailed(T, DF), 2 * pt(dist('T', T, "upper"), DF, tail("upper")), pvalue, []).

msg(paired, 
  "Correctly recognised the problem as a ~m-test for paired samples."-[t]).

msg(tratio, "Correctly identified the expression for the ~m-ratio."-[t]).

msg(pvalue, "Correctly determined the two-tailed ~m-value."-[p]).
