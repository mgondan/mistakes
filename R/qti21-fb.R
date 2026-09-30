library(htmltools)

# Read zip archive with all the XML-files for a given task. Then invoke a
# Prolog script that extracts a <UL> from the global feedback and creates
# option-specific feedback from it.
#
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

# Format the feedback in nice HTML
#
format_feedback <- function(correct, explanations, praise, blame, extra)
{
  p_corr <- lapply(correct, FUN=tags$p)
  
  # Explanations are already in HTML format (e.g., include MathML), so we
  # just wrap them into a paragraph.
  #
  # Todo: this might be separated at the prolog end
  h_expl <- lapply(FUN=HTML, explanations)
  p_expl <- lapply(FUN=tags$p, h_expl)
  
  # Praise is a list of individual shoutouts, protect each of them and wrap
  # into an <UL>. Note: Do this only for nonempty lists.
  h_praise <- lapply(praise, FUN=lapply, HTML)
  li_praise <- lapply(h_praise, FUN=lapply, tags$li)
  ul_praise <- lapply(li_praise, FUN=tags$ul)
  hd_praise <- lapply(ul_praise, FUN=function(x) tagList(tags$em("Expert"), x))
  hd_praise <- ifelse(sapply(li_praise, FUN=length) == 0, ul_praise, hd_praise)

  # Same for buggy
  h_blame <- lapply(blame, FUN=lapply, HTML)
  li_blame <- lapply(h_blame, FUN=lapply, tags$li)
  ul_blame <- lapply(li_blame, FUN=tags$ul)
  hd_blame <- lapply(ul_blame, FUN=function(x) tagList(tags$em("Buggy"), x))
  hd_blame <- ifelse(sapply(li_blame, FUN=length) == 0, ul_blame, hd_blame)
  
  # Same for extra
  h_extra <- lapply(extra, FUN=lapply, HTML)
  li_extra <- lapply(h_extra, FUN=lapply, tags$li)
  ul_extra <- lapply(li_extra, FUN=tags$ul)
  hd_extra <- lapply(ul_extra, FUN=function(x) tagList(tags$em("Extra"), x))
  hd_extra <- ifelse(sapply(li_extra, FUN=length) == 0, ul_extra, hd_extra)
  
  mapply(p_corr, p_expl, hd_praise, hd_blame, hd_extra,
    FUN=tagList, SIMPLIFY=FALSE)
}

# Extract the relevant feedback from the query
#
# 
prepare <- function(task, S, N=length(S))
{
  if(length(S) == 0)
    stop("No solutions found.")
  
  a <- character(length(S))
  c <- logical(length(S))
  e <- character(length(S))
  p <- list(length(S))
  b <- list(length(S))
  ex <- list(length(S))
  for(i in 1:length(S))
  {
    Si <- S[[i]]$S
    Ri <- S[[i]]$R
    Pi <- S[[i]]$P
    Ei <- S[[i]]$E
  
    a[i] <- Ri
    if(is.numeric(Ri))
      a[i] <- sprintf("%.2f", Ri)
    c[i] <- all(expert(Pi))
    e[i] <- sprintf("The result matches the following expression: %s\n", mathml(Si))
    p[[i]] <- praise(task, Pi)
    b[[i]] <- blame(task, Pi)
    ex[[i]] <- feedback(task, Ei)
  }

  # Shuffle
  repeat
  { o <- sample(1:length(S), size=N)
    if(any(c[o]))
      break
  }

  list(alternatives=a[o], correct=c[o], explanations=e[o], praise=p[o],
    blame=b[o], extra=ex[o])
}