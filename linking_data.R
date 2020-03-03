# Link existing data to GRASS GIS as external data

# install packages
# run for the first time only if you don't have the packages already
# source("install.R")

# load rgrass7 package
library(sp)
library(rgrass7)
# tell rgrass7 to use sp not stars
use_sp()

# load additional helper GRASS-related functions
source("createGRASSlocation.R")

# ----- Specify path to GRASS GIS installation -----
grassExecutable <- "grass"
# You need to change the above to where GRASS GIS is on your computer.
# On Windows, it will look something like:
# grassExecutable <- "C:/Program Files/GRASS GIS 7.8/grass78.bat"

# ----- Specify path to data -----
dem <-  "dem.tif"
database <- "grassdata"
location <- "sdm"
mapset <- "PERMANENT"
# you need to change the above to where the data is and should be on your computer
# on Windows, it will look something like:
# dem <-  "C:/Users/gabor/OneDrive/Desktop/R_grassgis/dem.tif"
# database <- "C:/Users/gabor/grassdata"


# ----- Create GRASS location -----

# pick one option (here, we are using the file we have):

# A) create a new GRASS location based on georeferenced file
createGRASSlocation(grassExecutable = grassExecutable,
                    readProjectionFrom = dem,
                    database = database,
                    location = location)

# B) create a new GRASS location with EPSG code 4326
# createGRASSlocation(grassExecutable = grassExecutable,
#                     EPSG = 4326,
#                     database = database,
                      location = location)


# ----- Initialisation of GRASS -----
initGRASS(gisBase = getGRASSpath(grassExecutable),
          gisDbase = database,
          location = location,
          mapset = mapset,
          override = TRUE)


# ----- Link data, set external outputs, and create rasters -----
# Link the digital elevation model (DEM) to GRASS GIS
execGRASS("r.external", input=dem, output="dem")

# Tell GRASS GIS create external data instead of native data
execGRASS("r.external.out", directory=getwd(), format="GTiff", extension=".tif") # 

dem <- readRAST("dem", cat=FALSE) # load DEM to R

plot(dem, main = "Digital Elevation Model", col=terrain.colors(50)) # plot DEM

execGRASS("r.topidx", input = "dem", output = "twi") # calculate topographic wetness index (TWI)

execGRASS("r.slope.aspect", elevation="dem", slope="slope", aspect="aspect") # calculate slope, aspect

execGRASS("r.info", map="aspect") # show raster info
