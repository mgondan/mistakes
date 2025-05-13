library(exams)

myexam <- list(tratio="tratio.Rmd")

exams2openolat(myexam,
  dir=".", name="mistakes", 
  edir=system.file("rexams", package="mistakes"),
  solutionswitch = TRUE,
  envir=.GlobalEnv
)