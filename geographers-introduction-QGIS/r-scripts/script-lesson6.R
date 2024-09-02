# Script Lesson 6
# Lesson 6: Various spatial interpolation techniques in R

setwd("C:/Users/nick/Documents/GIS/sdi-data")

# Part 1: IDW 

library(sf)
library(tmap)

national_boundary <- st_read("National_boundary.shp")
qtm(national_boundary)
helminths_point <- st_read("Uganda Helminths point data.shp")
qtm(helminths_point)

tm_shape(national_boundary) + 
  tm_polygons() +
tm_shape(helminths_point) +
  tm_dots()

##  Using IDWs to predict the rates of Helminths

#load libraries
library(gstat)
library(xts)

#using sp currently

library(gstat) 
library(terra)
library(sp) 
library(rgdal)

# reproject to UTM 36 N - we need a projected coordinate system
# see for info https://gis.stackexchange.com/questions/58105/should-point-data-be-equidistant-projected-when-using-arcgis-idw-spatial-interpo

#read in data
P_latlng <- readOGR("Uganda Helminths point data.shp")

#reproject
P <- spTransform(P_latlng, CRS("+init=epsg:32636"))

qtm(P)

#create grid
grd              <- as.data.frame(spsample(P, "regular", n=50000))
names(grd)       <- c("X", "Y")
coordinates(grd) <- c("X", "Y")
gridded(grd)     <- TRUE  # Create SpatialPixel object
fullgrid(grd)    <- TRUE  # Create SpatialGrid object

# Add P's projection information to the empty grid
proj4string(P) <- proj4string(P) # Temp fix until new proj env is adopted
proj4string(grd) <- proj4string(P)

#timing
library(tictoc)
tic()
# Interpolate the grid cells using a power value of 2 (idp=2.0)
P.idw <- idw(sth_prv ~ 1, P, newdata=grd, idp = 2.0)
toc()

#IDW in lat-long 12.63 sec elapsed
#IDW in UTM 0.25 sec elapsed

# using a projected CRS would increase the speed of the IDW and kriging because the calculations needed would be much simpler. Try reprojting to UTM 36 N (??) XXXXX and see if you like. 

r       <- rast(P.idw)

# Plot
qtm(r)    

tm_shape(r["var1.pred"]) + 
  tm_raster(n=10,palette = "-RdBu",
            title="Predicted prevlance rate") + 
  tm_legend(legend.outside=TRUE)

# add national boundary as outline
tm_shape(r["var1.pred"]) + 
  tm_raster(n=10,palette = "-RdBu",
            title="Predicted prevlance rate") + 
tm_shape(national_boundary) + 
  tm_borders(col = "black", lwd = 1) +
  tm_legend(legend.outside=TRUE)
  
  
#crop out country boundary


#Part 2: KDE

#read data in
arson_latlng <- st_read("KEN_Arson_schools_2016.shp")
national_boundary <- st_read("geoBoundaries-KEN-ADM0.shp")
county_boundaries <- st_read("geoBoundaries-KEN-ADM1.shp")

tm_shape(national_boundary) + tm_polygons() +
  tm_shape(arson_latlng) + tm_dots()

#reproject UTM Zone 35 N (EPSG: 32635)
arson <- st_transform(arson_latlng, crs = 32635)
#show the data
qtm(arson)

#load library
library(SpatialKDE)

cell_size <- 5000
band_width <- 100000

#grid creation
grid <- create_grid_rectangular(arson, cell_size = cell_size, side_offset = band_width)

output <- kde(arson, band_width = band_width, kernel = "quartic", grid = grid)

tm_shape(output) +
  tm_polygons(col = "kde_value", palette = "viridis", title = "KDE Estimate")

tm_shape(output) +
  tm_polygons(col = "kde_value", palette = "viridis", title = "KDE Estimate") +
  tm_shape(arson) +
  tm_bubbles(size = 0.1, col = "red")

tm_shape(output) +
  tm_polygons(col = "kde_value", palette = "viridis", title = "KDE Estimate") +
  tm_shape(arson) +
  tm_dots(size = 0.01, col = "red") 
  


