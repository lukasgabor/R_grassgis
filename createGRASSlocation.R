#' Create GRASS GIS location
#'
#' Calls GRASS GIS to create a new GRASS GIS location using either a
#' georeferenced file or EPSG code. The parent directories of the
#' provided *locationPath* need to exist.
#'
#' @param grassExecutable GRASS GIS executable (full path or command)
#' @param readProjectionFrom A geospatial file with CRS to use
#' @param EPSG EPSG code of a desired CRS
#' @param locationPath Full path to the new created location directory
createGRASSlocation <- function (grassExecutable, readProjectionFrom, EPSG, locationPath) {
  if (missing(EPSG)){
    system(paste("\"", grassExecutable, "\"", " -c ", "\"", readProjectionFrom, "\"", " ", "\"", locationPath, "\"", " -e ", sep = ""))
  }
  else{
    system(paste("\"", grassExecutable, "\"", " -c ", "EPSG:", EPSG, " ", "\"", locationPath, "\"", " -e ", sep = ""))
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
