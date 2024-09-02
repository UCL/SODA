# Script for Lesson 3

setwd("~/work/2022-36-ucl-sdi-gis-training-material-shared/data/lesson-3-data")

library(sf)
library(tmap)

# read in african countries shapefile
africa <- st_read("African_countries.shp")

# draw map
qtm(africa)

lga <- st_read("Local_Government_Authorities.shp")
qtm(lga)

national_boundary <- st_read("National_boundary.shp")
qtm(national_boundary)

states <- st_read("state_boundaries.shp")
qtm(states)

tm_shape(africa) +
  tm_polygons("wheat1") +
  tm_shape(lga) +
  tm_polygons() +
  tm_shape(national_boundary) +
  tm_polygons() 

#LGA hidden

#order is important - from bottom to top

#plotting multiple layers
tm_shape(africa) +
  tm_polygons("wheat1") +
  tm_shape(national_boundary) +
  tm_polygons() +
  tm_shape(states) +
  tm_polygons() +
  tm_shape(lga) + 
  tm_polygons()

# to zoom in, adjust the order. The Plots window is set to the first layer drawn. So swap Africa and national bounday
# then if you want the bottom later higher up, repeat it in the code

tm_shape(national_boundary) +
  tm_borders() +
tm_shape(africa) +
  tm_polygons("grey87") +
tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
tm_shape(lga) + 
  tm_polygons("tomato2", border.col = "black", border.alpha = 0.5) +
tm_shape(states) +
  tm_borders(col = "black", lwd = 2) 


#tm_borders instead of tm_polygons
#lwd
# indents
# alpha

# change africa to darker grey and lag to light grey? 
# exercise

tm_shape(national_boundary) +
  tm_borders() +
  tm_shape(africa) +
  tm_polygons("grey47") +
  tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
  tm_shape(lga) + 
  tm_polygons("grey87", border.col = "black", border.alpha = 0.5) +
  tm_shape(states) +
  tm_borders(col = "black", lwd = 2) 


## Importing non-spatial data and performing attribute joins

poverty <- read.csv("nigeria_2014_poverty-admin-2.csv")

head(poverty)

head(lga)

lga <- merge(lga, poverty, by.x = "LGA_ID", by.y = "GID_2")

head(lga)

## map construction

qtm(lga, fill = "Poverty_Rate")


#load the R Color Brewer library
library(RColorBrewer)
#display the palette
display.brewer.all()

tm_shape(lga) +
  tm_polygons("Poverty_Rate", palette = "Greens")

tm_shape(lga) +
  tm_polygons("Poverty_Rate", title = "Poverty Rate", palette = "OrRd", n = 7,
              style = "jenks")

