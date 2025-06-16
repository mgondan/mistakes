.onAttach <- function(libname, pkgname)
{
  if(!requireNamespace("rolog", quiet=TRUE))
    stop("Could not load R package rolog.")

  if(!rolog::rolog_ok())
    stop("Could not attach R package rolog.")

  rolog::consult(system.file("pl/mistakes.pl", package=pkgname))
  
  mathml::hook(error(.X), .X)
}

.expert1 <- function(expr)
{
  if(!is.call(expr))
    stop("expert: expression is not a call")
  
  expr[[1]] == "expert"
}

#' Check if a list includes only expert rules
#' (for internal use)
#'
#' @md
#' 
#' @param expr
#' list of R calls of the form expert/3 or buggy/3
expert <- Vectorize(.expert1)

.feedback1 <- function(expr)
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

#' Extract feedback from a list
#' (for internal use)
#'
#' @md
#' 
#' @param expr
#' list of R calls of the form expert/3 or buggy/3
#'
feedback <- function(expr)
  Vectorize(.feedback1)(hooked(expr))

#' Evaluate argument of error/1
#' (for internal use)
#'
#' @md
#' 
#' @param expr
#' R call of the form error/1
#'
error <- function(expr)
  return(expr)

#' Evaluate argument 2 of omit_right/3
#' (for internal use)
#'
#' @md
#' 
#' @param expr
#' R call of the form omit_right/3
#'
omit_right <- function(expr)
  substitute(expr)[[3]]

#' Evaluate argument of {}/1
#' (for internal use)
#'
#' @md
#' 
#' @param expr
#' R call
#'
`{}` <- function(expr)
  return(expr)

#' Evaluate arguments of ;/2
#' (for internal use)
#'
#' @md
#' 
#' @param expr1
#' R call
#'
#' @param expr2
#' R calls
#'
`;` <- function(expr1, expr2)
{
  expr1
  return(expr2)
}

#' Pretty print pvalue/1
#'
#' @md
#' 
#' @param x
#' number 0 < x < 1
#'
#' @examples
#' pvalue(0)
#' pvalue(0.002)
#' pvalue(0.062)
#' pvalue(0.212)
#' pvalue(1)
pvalue <- function(x)
{
  if(x > 0.995)
    return("1.0")
  
  if(x < 0.001)
    return("< 0.001")

  if(x < 0.10)
    return(sprintf("%.3f", x))
  
  return(sprintf("%.2f", x))
}
