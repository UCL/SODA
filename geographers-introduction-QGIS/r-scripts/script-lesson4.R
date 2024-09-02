# Script for Lesson 4

# data/script from lesson 3

setwd("~/work/2022-36-ucl-sdi-gis-training-material-shared/data/lesson-3-data")

library(sf)
library(tmap)

# read in data
africa <- st_read("African_countries.shp")
lga <- st_read("Local_Government_Authorities.shp")
national_boundary <- st_read("National_boundary.shp")
states <- st_read("state_boundaries.shp")

## Importing non-spatial data and performing attribute joins
poverty <- read.csv("nigeria_2014_poverty-admin-2.csv")
lga <- merge(lga, poverty, by.x = "LGA_ID", by.y = "GID_2")

tm_shape(lga) +
  tm_polygons("Poverty_Rate", title = "Poverty Rate", palette = "OrRd", n = 7,
              style = "jenks")

# update symboloygy to show state borders as well
# take 
# tm_shape(lga) +
#  tm_polygons("Poverty_Rate", title = "Poverty Rate", palette = "OrRd", n = 7,
#              style = "jenks")
#and combine with
#tm_shape(national_boundary) +
#  tm_borders() +
#  tm_shape(africa) +
#  tm_polygons("grey47") +
#  tm_shape(national_boundary) +
#  tm_borders(col = "black", lwd = 4) +
#  tm_shape(lga) + 
#  tm_polygons("grey87", border.col = "black", border.alpha = 0.5) +
#  tm_shape(states) +
#  tm_borders(col = "black", lwd = 2) 

tm_shape(national_boundary) +
  tm_borders() +
  tm_shape(africa) +
  tm_polygons("grey47") +
  tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
  tm_shape(lga) + 
  tm_polygons("Poverty_Rate", title = "Poverty Rate", palette = "OrRd", n = 7,
              style = "jenks", border.col = "black", border.alpha = 0.5) +
  tm_shape(states) +
  tm_borders(col = "black", lwd = 2) 

## add scale bar
tm_shape(national_boundary) +
  tm_borders() +
  tm_shape(africa) +
  tm_polygons("grey47") +
  tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
  tm_shape(lga) + 
  tm_polygons("Poverty_Rate", title = "Poverty Rate", palette = "OrRd", n = 7,
              style = "jenks", border.col = "black", border.alpha = 0.5) +
  tm_shape(states) +
  tm_borders(col = "black", lwd = 2) +
  #Add scale bar
  tm_scale_bar(width = 0.12, position = c("left", 0.01))

#numbers / words

#Add compass
## add scale bar
tm_shape(national_boundary) +
  tm_borders() +
  tm_shape(africa) +
  tm_polygons("grey47") +
  tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
  tm_shape(lga) + 
  tm_polygons("Poverty_Rate", title = "Poverty Rate", palette = "OrRd", n = 7,
              style = "jenks", border.col = "black", border.alpha = 0.5) +
  tm_shape(states) +
  tm_borders(col = "black", lwd = 2) +
  #Add scale bar
  tm_scale_bar(width = 0.12, position = c("left", 0.01)) +
  #add north arrow
  tm_compass(position = c(0.001, "top"))

## add legend simple
tm_shape(national_boundary) +
  tm_borders() +
  tm_shape(africa) +
  tm_polygons("grey47") +
  tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
  tm_shape(lga) + 
  tm_polygons("Poverty_Rate", title = "Poverty (rate)", palette = "OrRd", n = 7,
              style = "jenks", border.col = "black", border.alpha = 0.5, 
              legend.format = list(text.separator= "-")) +
  tm_legend(position = c(0.8, "bottom")) +
  tm_shape(states) +
  tm_borders(col = "black", lwd = 2) +
  #Add scale bar
  tm_scale_bar(width = 0.12, position = c("left", 0.01)) +
  #add north arrow
  tm_compass(position = c(0.001, "top"))

##add legend advanced
tm_shape(national_boundary) +
  tm_borders() +
  tm_shape(africa) +
  tm_polygons("grey47") +
  tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
  tm_shape(lga) + 
  tm_polygons("Poverty_Rate", title = "Poverty (%)", palette = "OrRd", n = 7,
              style = "jenks", border.col = "black", border.alpha = 0.5, 
              legend.format = list(text.separator= "-", fun=function(x) paste0(formatC(x * 100, digits=0, format="f")))) +
  tm_legend(position = c(0.82, "bottom")) +
  tm_shape(states) +
  tm_borders(col = "black", lwd = 2) +
  #Add scale bar
  tm_scale_bar(width = 0.12, position = c("left", 0.01)) +
  #add north arrow
  tm_compass(position = c(0.001, "top"))

#https://www.rdocumentation.org/packages/tmap/versions/3.3-3/topics/tm_fill
#https://www.jla-data.net/2017/09/20/2017-09-19-tmap-legend
# https://www.rdocumentation.org/packages/tmap/versions/3.3-3/topics/tm_layout

#inset map?

#export to file

m <- tm_shape(national_boundary) +
  tm_borders() +
  tm_shape(africa) +
  tm_polygons("grey47") +
  tm_shape(national_boundary) +
  tm_borders(col = "black", lwd = 4) +
  tm_shape(lga) + 
  tm_polygons("Poverty_Rate", title = "Poverty (%)", palette = "OrRd", n = 7,
              style = "jenks", border.col = "black", border.alpha = 0.5, 
              legend.format = list(text.separator= "-", fun=function(x) paste0(formatC(x * 100, digits=0, format="f")))) +
  tm_legend(scale = 1.4, position = c(0.80, "bottom")) +
  tm_shape(states) +
  tm_borders(col = "black", lwd = 2) +
  #Add scale bar
  tm_scale_bar(lwd = 2, width = 0.15, text.size = 1.6, position = c("left", 0.01)) +
  #add north arrow
  tm_compass(position = c(0.001, "top"), size = 3)

tmap_save(m)

#multiple map - see link. 

# link to Inkscape

# optional - 

#set tmap to view mode
#tmap_mode("view")
#plot using qtm
#qtm(sthelens)
#plot using tm_shape
#tm_shape(LSOA) +
  #Set colours and classification methods
#  tm_polygons("Total", title = "Total Population", palette = "Greens",
              style = "equal")
#return tmap to plot mode
#tmap_mode("plot")
