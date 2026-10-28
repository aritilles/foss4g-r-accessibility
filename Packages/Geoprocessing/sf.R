

#Importing library
library(sf) 

#Turning our geocoded coordinates into point geometries
hospital_points <- hospital_coords %>%
  st_as_sf(coords = c("long", "lat"), crs = 4326,
           remove = FALSE, na.fail = FALSE)

hospital_points <- hospital_points %>%
  mutate(hospital_id = row_number())  #Adding IDs for later


plot(block_groups$geometry)
plot(hospital_points$geometry, add = TRUE)

#Importing library
library(sf) 

#Transforming data into California Albers projection (EPSG: 3310)
st_crs(hospital_points)
hospital_points_3310 <- st_transform(hospital_points, 3310)

st_crs(block_groups)
block_groups_3310 <- st_transform(block_groups, 3310)

#Importing library
library(sf)

#Creating centroids from block groups
bg_centroids <- st_centroid(block_groups)

#Transforming the centroids to a chosen projection
bg_centroids <- st_transform(bg_centroids, 4326)

#Extracting lat/lon from block group centroids from geometry
coords <- st_coordinates(bg_centroids)

bg_centroids <- bg_centroids %>%
  mutate(
    long = coords[, "X"],
    lat  = coords[, "Y"]
  )

#Joining population data to block groups and filtering columns
bg_centroids <- left_join(bg_centroids, total_pop, by = "GEOID")
  
bg_centroids <- bg_centroids %>% select(GEOID, long, lat, NAME, B01003_001E)
colnames(bg_centroids)[5] = "Total_Pop" #Renaming the census column

#Exporting to Shapefile and GPKG
st_write(bg_centroids, "Data/bg_centroids.shp", append = FALSE)

st_write(bg_centroids, dsn = "Data/open_source_r.gpkg",
         layer = "bg_centroids",append = FALSE)
st_write(hospital_points, dsn = "Data/open_source_r.gpkg",
         layer = "hospital_points", append = FALSE)

#Reading in data from GPKG
bg_centroids_read <- st_read(dsn = "Data/open_source_r.gpkg", layer = "bg_centroids")
