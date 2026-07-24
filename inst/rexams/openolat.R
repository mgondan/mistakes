library(exams)

myexam <- list(
  tratio="tratio.Rmd",
  pvalue="pvalue.Rmd")

exams2openolat(myexam,
  dir=".", name="mistakes", 
  edir=system.file("rexams", package="mistakes"),
  solutionswitch=TRUE)

library(exams2forms)
exams2webquiz(
  "tratio.Rmd", 
  dir=".",
  name="mistakes1", 
  edir=system.file("rexams", package="mistakes"))

exams2webquiz(
  "pvalue.Rmd", 
  dir=".",
  name="mistakes2", 
  edir=system.file("rexams", package="mistakes"))

