# Import and prepare data in GRASS GIS and model species distribution in R

# install packages
# run for the first time only if you don't have the packages already
# source("install.R")

source("helpers.R")

# load rgrass package
library(sp)
library(rgrass)

# ----- Specify path to GRASS GIS installation -----
grassExecutable <- "grass"
# You need to change the above to where GRASS GIS is on your computer.
# On Windows, it will look something like:
# grassExecutable <- "C:/Program Files/GRASS GIS 8.2/grass82.bat"

# ----- Specify path to data -----
dem <-  "dem.tif"
# you need to change the above to where the data is and should be on your computer
# on Windows, it will look something like:
# dem <-  "C:/Users/gabor/OneDrive/Desktop/R_grassgis/dem.tif"

# ----- Create GRASS location -----

library(terra)

r <- rast(dem)

# ----- Initialisation of GRASS -----
initGRASS(gisBase = getGRASSpath(grassExecutable),
          SG = r,
          override = TRUE)


# ----- Import and create rasters for modeling -----
execGRASS("r.external", input=dem, output="dem") # Import digital elevation model (DEM) to GRASS GIS

execGRASS("r.external.out", directory=getwd(), format="GTiff", extension=".tif") # 

# Load the DEM to R from GRASS GIS and plot it
dem <- read_RAST("dem", cat=FALSE) # load DEM to R
plot(dem, main = "Digital Elevation Model", col=terrain.colors(50)) # plot DEM

execGRASS("r.topidx", input = "dem", output = "twi") # calculate topographic wetness index (TWI)

execGRASS("r.slope.aspect", elevation="dem", slope="slope", aspect="aspect") # calculate slope, aspect

execGRASS("r.info", map="aspect") # show raster info

# ----- Load environmental data to R -----
library(raster)
# A) Directly from GRASS GIS (suboptimal choice here)
twi2 <- raster(read_RAST("twi", cat=FALSE))

# B) Load previously saved GeoTIFF files
twi <- raster("twi.tif")
slope <- raster("slope.tif")
dem <- raster("dem.tif")
aspect <- raster("aspect.tif")

# Compare twi and twi2 - Is data source same for both layers? If not, how it may impact next modeling? 

# ----- Species distribution modeling (SDM) -----
library(usdm)
library(dismo)

preds <- stack(slope, twi, aspect, dem) # stack environmental layers
suppressWarnings({
    plot(preds)
})

# VIF - Variance Inflation Factor; check the collinearity problem in environmental variables
v <- vifstep(preds);v
preds <- exclude (preds, v)

sp <- shapefile("virtualis.shp") # Load species data

bg <- randomPoints(preds, 1000, p = sp) # create background points

# Divide species data for testing and training the model
fold <- kfold(sp, k=5) # divide species occurrences to 5 folds (20% for testing the model)

test <- sp[fold == 1, ]
train <- sp[fold != 1, ]

# fit the bioclim model using environmental data (preds) and training species data (train)
bioclim.model <- bioclim(preds, train)

# predict probability species distribution
prediction <- predict(preds, bioclim.model)

par(mfrow = c(1, 1))

plot(prediction, main='Predicted Probability - Virtualis') # plot prediction
