.onAttach <- function(libname, pkgname)
{
  if(!requireNamespace("rolog", quiet=TRUE))
    stop("Could not load R package rolog.")

  if(!rolog::rolog_ok())
    stop("Could not attach R package rolog.")

  rolog::consult(system.file("pl/mistakes.pl", package=pkgname))
}

tratio <- function()
{
  Q <- quote(search(tratio(x, mu, s, n), .S))
  unlist(findall(Q, options=list(preproc=as.rolog)))
}
