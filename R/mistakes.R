.onAttach <- function(libname, pkgname)
{
  if(!requireNamespace("rolog", quiet=TRUE))
    stop("Could not load R package rolog.")

  if(!rolog::rolog_ok())
    stop("Could not attach R package rolog.")

  rolog::consult(system.file("pl/mistakes.pl", package=pkgname))
}

expert1 <- function(expr)
{
  if(!is.call(expr))
    stop("expert: expression is not a call")
  
  expr[[1]] == "expert"
}

expert <- Vectorize(expert1)

feedback1 <- function(expr)
{
  if(!is.call(expr))
    stop("feedback: expression is not a call")
  
  if(expr[[1]] == "expert")
    return(expr[[2]])
  
  if(expr[[1]] == "buggy")
    return(expr[[2]])
  
  stop("feedback: expression should be expert/1 or buggy/1")
}

feedback <- Vectorize(feedback1)