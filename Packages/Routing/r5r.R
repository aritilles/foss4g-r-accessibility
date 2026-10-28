

#Checking java version
system("java -version") #Must have Java 11 or higher
#install.packages('rJavaEnv')
#rJavaEnv::java_quick_install(version = 21)

#Allocating memory and importing library
options(java.parameters = '-Xmx12G') #"12G" refers to 12 GB of memory
library(r5r)

#Building transport network from pbf file
r5r_net <- build_network(
  data_path = "Data"  #Folder in my directory where the pbf file is found
)

#The function reads for a pbf file in the directory
#R5r also takes GTFS feeds as .zip files and .tif DEMs if in the directory

#Origins
origins <- bg_centroids %>%
  select(id = GEOID, lat, lon = long)

#Destinations
destinations <- hospital_points %>%
  select(id = hospital_id, lat, lon = long)

#Setting departure time (more relevant for routing with GTFS)
#If no departure time is set, r5r uses current system time
departure_time = as.POSIXct("2026-10-05 08:00:00")


# ttm <- travel_time_matrix(
#   r5r_net,
#   origins = origins,
#   destinations = destinations,
#   mode = "CAR",
#   departure_datetime = departure_time,
#   max_trip_duration = 45,   # minutes
# )

#Saving ttm object
#saveRDS(ttm,"Data/ttm.rds")
ttm = readRDS("Data/ttm.rds")

#Calculating 30 minute accessibility from travel time matrix
acc <- ttm %>%
  filter(travel_time_p50 <= 30) %>%
  group_by(from_id) %>%
  summarise(
    hospitals_reachable = n(),
  )

#Detailed itinerary example
# itins_subset <- detailed_itineraries(
#   r5r_net,
#   origins = origins[1:5,], # A subset of the first five origins
#   destinations = destinations[1:5,],
#   mode = "CAR",
#   departure_datetime = departure_time,
#   max_trip_duration = 45,
#   all_to_all = TRUE,
# )

# saveRDS(itins_subset, "Data/itins_subset.rds")
itins_subset <- readRDS("Data/itins_subset")

plot(itins_subset$geometry)

#Isochrone function
# iso <- isochrone(
#   r5r_net,
#   origins = origins[1,],   # A subset of one origin
#   mode = "CAR",
#   departure_datetime = departure_time,
#   cutoffs = c(15, 30, 45)
# )
# 
# saveRDS(iso, "Data/iso.rds")
iso <- readRDS("Data/iso.rds")

plot(iso$polygons[1:3,])

#Accessibility package
destinations$hospital_count = 1
library(accessibility)

#Calculating accessibility using accessibility function
#This was what was used in rest of analysis

# access <- accessibility(
#   r5r_net ,
#   origins = origins,
#   destinations = destinations,
#   opportunities_colnames = "hospital_count",
#   mode = "CAR",
#   departure_datetime = departure_time,
#   cutoffs = c(10,20,30),
#   max_trip_duration = 30
# )

# saveRDS(access, "Data/access.rds")
access <- readRDS("Data/access.rds")
access_30 <- access[access$cutoff == 30,]

origins <- st_join(origins, bg_centroids)

#Calculating access to population from hospitals
# pop_access <- accessibility(
#   r5r_net,
#   origins = destinations,
#   destinations = origins,
#   opportunities_colnames = "Total_Pop",
#   mode = "CAR",
#   departure_datetime = departure_time,
#   cutoffs = c(10,20,30),
#   max_trip_duration = 30
# )

#saveRDS(pop_access, "Data/pop_access.rds")
pop_access <- readRDS("Data/pop_access.rds")
