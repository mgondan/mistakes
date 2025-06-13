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
expert(X, Y, twotailed, []) :-
    X = twotailed(T, DF), 
    Y = pt(dist('T', T, "two.sided"), DF, tail("two.sided")). 

buggy(X, Y, lower, []) :-
    X = twotailed(T, DF),
    Y = pt(instead(dist('T', T, "lower"), dist('T', T, "two.sided")), DF,
          instead(tail("lower"), tail("two.sided"))).

msg(paired, 
  "Correctly recognised the problem as a ~m-test for paired samples."-[t]).

msg(tratio, "Correctly identified the expression for the ~m-ratio."-[t]).

msg(twotailed, "Correctly determined the two-tailed ~m-value."-[p]).

msg(lower, "The result matches the lower one-tailed ~m-value."-[p]).