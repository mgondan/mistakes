library(exams)
library(mathml)
library(htmltools)
library(mistakes)

plfile <- file.path("rexams", sprintf("%s.pl", task))
rolog::consult(system.file(plfile, package="mistakes"))

hook(d, mean(D))
hook(s_D, subscript(s, D))
hook(mu_0, subscript(mu, 0L))
hook(s_pool, subscript(s, "pool"))

repeat
{
  N <- sample(20:50, 1)
  mu_0 <- round(runif(1, 0.5, 1.5),1)
  
  mu_t0 <- round(runif(1, 0.5, 2.5), 1)
  s_t0 <- round(runif(1, 0.5, 1), 1)
  s_D <- round(runif(1, 0.4, 0.8)*s_t0, 1)
  
  t <- runif(1, 0.5, 3.0)
  
  d <- round(mu_0 + t * s_D / sqrt(N), 1)
  mu_eot <- d + mu_t0
  s_eot <- round(s_t0 + runif(1, -0.3, 0.3),1)
  tratio <- (d - mu_0) / (s_D / sqrt(N))
  
  if(tratio<0.5 || tratio>3.0)
    next
   
   Q <- substitute(search(task, tpaired(d, mu_0, s_D, N),
                     .S, .R, .P, .E), list(task = as.name(task)))
   S <- findall(Q, options=list(preproc=as.rolog), env=environment())
   
   if(problems(S))
     next
  
  break
}  
  
tab <- data.frame(T0 = c(mu_t0, s_t0),
                EOT= c(mu_eot, s_eot),
                D = c(d, s_D))
row.names(tab) <- c("Mean", "SD")


t <- prepare(task=task, S)
sol <- format_feedback(t$correct, t$explanations, t$praise, t$blame, t$extra)
sol <- lapply(sol, FUN=gsub, pattern="\\n", replacement="")