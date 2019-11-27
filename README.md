# GRASS GIS in R

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/LukasGab/R_grassgis/link-external-data?urlpath=rstudio&filepath=R_grassgis.R)

Here we introduce how to work with GRASS GIS in R. In addition,
we introduce `createGRASSlocation` function which allows to create GRASS
location in R.

Instead of importing raster data to GRASS GIS and exporting them from it,
we link existing external data to GRASS GIS Database and also create
this linked external data when creating new raster data in GRASS GIS.
This removes the need to import and export the data and it does not
duplicate the data either saving disk space.
