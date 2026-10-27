library(exams)
library(mathml)
library(htmltools)
library(mistakes)

plfile <- file.path("rexams", sprintf("%s.pl", task))
rolog::consult(system.file(plfile, package="mistakes"))

hook(mu_D, subscript(mu, D))
hook(s_D, subscript(s, D))
hook(sd_t0, subscript(sd, T0))
hook(mu_0, subscript(mu, 0L))
hook(as.character(.X), .X)
hook(ceiling(.X), .X)

repeat
{
  mu_0 <- sample(10:15, 1)
  mu_D <- mu_0 + sample(1:8, 1)
  sd_t0 <- sample(5:15, 1)
  
  sd_D <- sd_t0 * 0.63  
  d = (mu_D - mu_0) / (sd_D)
  N = ceiling(9 / d^2)
  
  if(d<0.5 || d>3.0)
    next
  
  if(N<10 || N>1000)
    next

  Q <- substitute(search(task, tpaired(mu_D, mu_0, sd_t0),
                     .S, .R, .P, .E), list(task = as.name(task)))

  S <- findall(Q, options=list(preproc=as.rolog), env=environment())

  if(problems(S))
    next
  
  break
}

t <- prepare(task=task, S)
sol <- format_feedback(t$correct, t$explanations, t$praise, t$blame, t$extra)
sol <- lapply(sol, FUN=gsub, pattern="\\n", replacement="")
