.onAttach <- function(libname, pkgname)
{
  if(!requireNamespace("rolog", quiet=TRUE))
    stop("Could not load R package rolog.")

  if(!rolog::rolog_ok())
    stop("Could not attach R package rolog.")

  rolog::consult(system.file("pl/mistakes.pl", package=pkgname))
  
  mathml::hook(error(.X), .X)
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
  {
    X <- once(call("message", expr[[2]], expression(X)))
    return(X$X)
  }

  if(expr[[1]] == "buggy")
  {
    X <- once(call("message", expr[[2]], expression(X)))
    return(X$X)
  }
  
  stop("feedback: expression should be expert/1 or buggy/1")
}

feedback <- function(expr)
  Vectorize(feedback1)(hooked(expr))

error <- function(expr)
  return(expr)

instead <- function(wrong, correct)
  return(wrong)