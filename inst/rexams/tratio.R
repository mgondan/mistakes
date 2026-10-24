library(exams)
library(mathml)
library(htmltools)
library(mistakes)

task <- "tratio"
plfile <- file.path("rexams", sprintf("%s.pl", task))
rolog::consult(system.file(plfile, package="mistakes"))

hook(d, mean(D))
hook(s_d, subscript(s, D))
hook(mu_d, subscript(mu, D))
hook(n, N)
hook(t0, mean("T0"))
hook(s_t0, subscript(s, "T0"))
hook(eot, mean("EOT"))
hook(s_eot, subscript(s, "EOT"))
hook(s_pool, subscript(s, "pool"))

var_pool <- function(n1, v1, n2, v2)
  frac((n1 - 1L) * v1 + (n2 - 1L) * v2, n1 + n2 - 2L)

hook(var_pool)

repeat
{
  n      <- as.integer(round(runif(1, min=20, max=45)))
  Id     <- 1:n
  T0     <- round(runif(n, min=15, max=40))
  EOT    <- round(T0 + runif(n, min=-10, max=2))
  mu_d   <- round(runif(1, min=2, max=5), 1)

  data   <- data.frame(Id, T0, EOT)
  t0     <- mean(data$T0)
  s_t0   <- sd(data$T0)
  eot    <- mean(data$EOT)
  s_eot  <- sd(data$EOT)
  d      <- mean(data$T0 - data$EOT)
  s_d    <- sd(data$T0 - data$EOT)
  tratio <- (d - mu_d) / (s_d / sqrt(n))
    
  if(abs(tratio) < 0.1)
    next
  if(abs(tratio) > 3.0)
    next
  tails  <- "two-tailed"
    
  alpha  <- 0.05
  
  Q <- quote(search(tratio, tratio(t0, s_t0, eot, s_eot, d, mu_d, s_d, n),
    .S, .R, .P, .E))
  S <- findall(Q, options=list(preproc=as.rolog), env=environment())

  if(problems(S))
    next

  break
}

t <- prepare(task=task, S) # 5 alternatives only
sol <- format_feedback(t$correct, t$explanations, t$praise, t$blame, t$extra)
sol <- lapply(sol, FUN=gsub, pattern="\\n", replacement="")