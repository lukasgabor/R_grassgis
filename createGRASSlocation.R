createGRASSlocation <- function (grassExecutable, readProjectionFrom, EPSG, locationPath) {
  if (missing(EPSG)){
    system(paste("\"", grassExecutable, "\"", " -c ", "\"", readProjectionFrom, "\"", " ", "\"", locationPath, "\"", " -e ", sep = ""))
  }
  else{
    system(paste("\"", grassExecutable, "\"", " -c ", "EPSG:", " ", "\"", locationPath, "\"", " -e ", sep = ""))
  }
}
