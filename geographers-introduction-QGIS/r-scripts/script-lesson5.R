#Script Lesson 5
# Lesson 5: Visualising spatial patterns in aggregated health data in R

setwd("C:/Users/nick/Documents/GIS/sdi-data")

library(sf)
library(tmap)

africa <- st_read("African_countries.shp")
health <- st_read("Health_districts.shp")

# qtm(africa) #commented out as takes a bit of time to display
qtm(health)

helminths <- read.csv("Uganda Helminths point data.csv")
head(helminths)

#remove data with missing lat & long
helminths <- helminths[-which(helminths$latitude == 99999),]

#make sf file
helminths_sf <- st_as_sf(helminths, coords = c('longitude', 'latitude'), 
                         crs = 4326)

qtm(helminths_sf)

tm_shape(health) + tm_polygons() +
  tm_shape(helminths_sf) + tm_dots()

#save helminths_sf
st_write(helminths_sf, "Uganda Helminths point data.shp")

### Aggregation of point spatial data to polygon

#create map
tm_shape(health) + tm_polygons() +
  tm_shape(helminths_sf) + tm_dots("sth_prevlance", palette = "YlOrRd", n = 7, 
                                   style = "jenks", size = 0.25)

## Aggregation of point data to health districts

# spatial join
health_helminths <- st_join(health, helminths_sf)

#remove columns we don't need
colnames(health_helminths)
health_helminths <- health_helminths[,c("IU_ID","sth_examined", "sth_positive")]

health_helminths_aggregated <- aggregate(x = health_helminths, by = list(health_helminths$IU_ID), FUN = sum)

#remove IUID column (which is sum of IDs, so irrelevant)
health_helminths_aggregated$IU_ID <- NULL
head(health_helminths_aggregated)
colnames(health_helminths_aggregated)[1] <- "IU_ID"
head(health_helminths_aggregated)

#calc prevlance
health_helminths_aggregated$sth_prevlance <- health_helminths_aggregated$sth_positive / health_helminths_aggregated$sth_examined

head(health_helminths_aggregated)

#In R, it's worth plotting a quick map to make sure the data have been processed reasonably well

qtm(health_helminths_aggregated)
tm_shape(health_helminths_aggregated) + tm_polygons("sth_prevlance", palette = "YlOrRd", n = 7, 
                                 style = "jenks")

#optional - four catagories 

# raster data
library(terra)

pop <- rast("uga_ppp_2020_UNadj_constrained.tif")
pop
plot(pop)
hist(pop)

plot(pop, axes=FALSE)

# zonal statistics

qtm(pop)

tm_shape(pop) + tm_raster()

tm_shape(health_helminths_aggregated) + tm_polygons() +
  tm_shape(pop) + tm_raster()  

#takes a some seconds - about 20 sec on my machine
zonal_stats <- extract(pop, health_helminths_aggregated, fun = "sum", na.rm = TRUE)

#add raster data back on to health
health_helminths_aggregated <- cbind(health_helminths_aggregated, zonal_stats)
head(health_helminths_aggregated)

qtm(health_helminths_aggregated, fill = "uga_ppp_2020_UNadj_constrained")

#save as a new shape file

# Calculating Helminths risk rate

health_helminths_aggregated$at_risk <- health_helminths_aggregated$sth_prevlance * health_helminths_aggregated$uga_ppp_2020_UNadj_constrained

head(health_helminths_aggregated)

qtm(health_helminths_aggregated, fill = "at_risk")

#map of prevlance

tm_shape(health_helminths_aggregated) + tm_polygons("sth_prevlance", palette = "Reds", n = 4, 
                             style = "fixed", breaks=c(0, 0.1, 0.2, 0.5, 1))


