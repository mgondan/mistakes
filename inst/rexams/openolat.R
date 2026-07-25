library(exams)

myexam <- list(
  upnorm="upnorm.Rmd",
  tratio="tratio.Rmd",
  pvalue="pvalue.Rmd")

exams2openolat(myexam,
  dir=".", name="mistakes", 
  edir=system.file("rexams", package="mistakes"),
  solutionswitch=TRUE)

library(exams2forms)
exams2webquiz(
  "upnorm.Rmd", 
  dir=".",
  name="upnorm", 
  edir=system.file("rexams", package="mistakes"))

exams2webquiz(
  "tratio.Rmd", 
  dir=".",
  name="tratio", 
  edir=system.file("rexams", package="mistakes"))

exams2webquiz(
  "pvalue.Rmd", 
  dir=".",
  name="pvalue", 
  edir=system.file("rexams", package="mistakes"))

