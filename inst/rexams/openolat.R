library(exams)

myexam <- list(
  ipnorm="ipnorm.Rmd",
  upnorm="upnorm.Rmd",
  lpnorm="lpnorm.Rmd",
  tratio="tratio.Rmd",
  pvalue="pvalue.Rmd")

exams2openolat(myexam,
  dir=".", name="mistakes", 
  edir=system.file("rexams", package="mistakes"),
  solutionswitch=TRUE)

library(exams2forms)
exams2webquiz(
  "ipnorm.Rmd", 
  dir=".",
  name="ipnorm", 
  edir=system.file("rexams", package="mistakes"))

exams2webquiz(
  "lpnorm.Rmd", 
  dir=".",
  name="lpnorm", 
  edir=system.file("rexams", package="mistakes"))

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
