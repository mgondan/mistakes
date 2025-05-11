% Correct step from task to solution
expert(tratio(X, Mu, S, N), dfrac(X - Mu, S / sqrt(N)),
  "Correctly identified the expression for the $t$-ratio.").

intermediate(tratio/4).

% Mistakes
buggy(dfrac(X - Mu, S / SQRTN), X - dfrac(Mu, S) / SQRTN,
    "Please do not forget the parentheses around the numerator and the 
     denominator of a fraction.").

buggy(sqrt(N), N,
    "Please do not omit the square root around $N$.").
