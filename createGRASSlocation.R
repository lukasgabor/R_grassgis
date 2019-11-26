createGRASSlocation <- function (grassExecutable, readProjection, EPSG, locationPath) {
  if (missing(EPSG)){
    readProjection = readProjection
    system(paste("\"", grassExecutable, "\"", " -c ", "\"", readProjection, "\"", " ", "\"", locationPath, "\"", " -e ", sep = ""))
  }
  else{
    system(paste("\"", grassExecutable, "\"", " -c ", "EPSG:", " ", "\"", locationPath, "\"", " -e ", sep = ""))
  }
}
