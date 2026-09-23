library(exams)

oodir <- "."
oldname <- "mistakes"
newname <- "fixed"

myexam <- list(
  lqnorm="lqnorm.Rmd",
  tratio="tratio.Rmd",
  pvalue="pvalue.Rmd")

exams2openolat(myexam,
  dir=oodir, name=oldname, 
  edir=system.file("rexams", package="mistakes"),
  solutionswitch=TRUE)

oldzip <- normalizePath(file.path(oodir, sprintf("%s.zip", oldname)), winslash="/")
newzip <- normalizePath(file.path(oodir, sprintf("%s.zip", newname)), winslash="/")
fix_feedback(oldzip, newzip)





library(exams2forms)
exams2webquiz(
  "lqnorm.Rmd", 
  dir=".",
  name="lqnorm", 
  edir=system.file("rexams", package="mistakes"))

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
