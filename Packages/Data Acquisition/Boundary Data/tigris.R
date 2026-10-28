

#Importing library
library(tigris)

#Importing block groups for our study area
block_groups <- block_groups(state = "California",
                            county = "Sacramento", year = 2024)

#Defining the counties in our study area
counties <- c("Sacramento", "Yolo", "El Dorado", "Placer", "Yuba", "Sutter")



plot(block_groups$geometry)

#Projecting our counties and filtering for Sacramento County
library(sf)
ca_counties <- st_transform(counties(state = "California"),4326)
sac_county <- st_transform(ca_counties %>% filter(NAME == "Sacramento"), 4326)
