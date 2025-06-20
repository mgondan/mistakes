library(exams)

myexam <- list(
  tratio="tratio.Rmd")

exams2openolat(myexam,
  dir=".", name="mistakes", 
  edir=system.file("rexams", package="mistakes"),
  solutionswitch = TRUE,
  envir=.GlobalEnv
)

library(exams2forms)
exams2webquiz(system.file("rexams/tratio.Rmd", package="mistakes"))
exams2webquiz(system.file("rexams/pvalue.Rmd", package="mistakes"))
