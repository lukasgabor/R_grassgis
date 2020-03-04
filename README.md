# GRASS GIS in R

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/LukasGab/R_grassgis/master?urlpath=rstudio&filepath=R_grassgis.R)

Here we introduce how to work with GRASS GIS in R. In addition,
we introduce `createGRASSlocation` function which allows to create GRASS
location in R.

## Following the tutorial in Binder

If you use the above mybinder.org link, it will take you (possibly after some time) to an RStudio instance.
The code will run right away there without any changes.
The current working directory is set to the project directory and all paths in the script are relative to it,
or in case of GRASS GIS executable, GRASS GIS is available using the command *grass*.

Open and run file `R_grassgis.R` and possibly also `linking_data.R` if you are interested in avoiding
the need to import to and export from the GRASS GIS database.

## Following the tutorial on your desktop

Open the project in RStudio or explore the directory using your preferred tools.

Open the file `R_grassgis.R` and see the settings of the GRASS GIS executable and paths to data.
Adjust these as needed. Then you can run the file (possibly line by line to see and examine each step).

Additionally, you can also see and run file `linking_data.R` to see how external data can be linked to GRASS GIS
database which avoids the need for imports and exports.
