#' Get path to GRASS GIS installation
#'
#' Asks GRASS GIS where is its installation directory on the system.
#'
#' @param grassExecutable GRASS GIS executable (full path or command)
#' @return Path to the installation
getGRASSpath <- function (grassExecutable) {
  command <- paste("\"", grassExecutable, "\" --config path", sep = "")
  path <- system(command, intern = TRUE)
  return(trimws(path))
}
