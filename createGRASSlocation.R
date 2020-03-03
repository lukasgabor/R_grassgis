createGRASSlocation <- function (grassExecutable, readProjectionFrom, EPSG, locationPath) {
  if (missing(EPSG)){
    system(paste("\"", grassExecutable, "\"", " -c ", "\"", readProjectionFrom, "\"", " ", "\"", locationPath, "\"", " -e ", sep = ""))
  }
  else{
    system(paste("\"", grassExecutable, "\"", " -c ", "EPSG:", " ", "\"", locationPath, "\"", " -e ", sep = ""))
  }
}

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
