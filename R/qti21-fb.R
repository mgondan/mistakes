fix_feedback <- function(oldzip, newzip)
{
  tmp <- tempfile()
  dir.create(tmp)
  dir.create(file.path(tmp, "old"))
  dir.create(file.path(tmp, "new"))
  file.remove(newzip)
  
  wd <- setwd(file.path(tmp, "old"))
  system2("unzip", args=oldzip)
  setwd(tmp)
  rolog::once(call("fix_folder", "old", "new"))
  system2("zip", args=c("-j", newzip, "new/*"))
  setwd(wd)
}
