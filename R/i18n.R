# Interim solution until we have proper gettext support
s <- function(id)
{
  if(Sys.getenv("LANGUAGE") %in% c("", "en", "en_GB", "en_US"))
    return(.en(id))
  
  if(Sys.getenv("LANGUAGE") %in% c("", "de", "de_DE", "de_AT"))
    return(.de(id))

  warning("LANGUAGE=", Sys.getenv("LANGUAGE"), " not supported.")  
  .en(id)
}

.en <- function(id)
{
  if(id == "result_match")
    return("The result matches the following expression: %s\n")
  
  warning("i18n/EN: UI element ", id, " not known.")
  return(id)
}

.de <- function(id)
{
  if(id == "result_match")
    return("Dein Ergebnis passt zu diesem Ausdruck: %s\n")
  
  warning("i18n/DE: UI element ", id, " not known.")
  return(id)
}
