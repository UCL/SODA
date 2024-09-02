# Script for Lesson 2

setwd("C:/Users/nick/Documents/GIS/lesson-2-data")

library(sf)
library(tmap)

# read in african countries shapefile
africa <- st_read("African_countries.shp")

# draw map
qtm(africa)

# read in cities shapefile
cities <- st_read("Major_cities.shp")

# read in roads shapefile
roads <- st_read("Major_roads.shp")

#plot all layers together
tm_shape(africa) +
  tm_polygons() +
  tm_shape(roads) +
  tm_lines() +
  tm_shape(cities) +
  tm_dots()

tm_shape(africa) +
  tm_polygons("wheat1") +
tm_shape(roads) +
  tm_lines("grey80", scale = 5) +
tm_shape(cities) +
  tm_dots(size = 1.5) 
