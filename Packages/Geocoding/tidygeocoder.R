

library(readr)
#Importing all hospitals
usa_hospitals <- read.csv("Data/Hospital_General_Information.csv")

#Filtering to hospitals in California or Nevada
# ca_nv_hospitals <- usa_hospitals %>%
#   filter(State %in% c("CA", "NV"))

ca_hospitals = usa_hospitals %>%
  filter(State == "CA")

#List of counties in study area and neighboring counties
# study_area_counties = c(counties,
#                         "Napa", "Lake", "Colusa", "Solano",
#                         "Contra Costa", "San Joaquin",
#                         "Amador", "Calaveras", "Alpine",
#                         "Nevada", "Sierra", "Butte",
#                         "Glenn", "Carson City", "Washoe",
#                         "Storey", "Douglas", "Lyon")

study_area_counties <- c("Sacramento", "Placer", "El Dorado", 
                        "Amador", "San Joaquin", "Contra Costa",
                        "Solano", "Yolo")

hospitals <- ca_hospitals %>%
  filter(County.Parish %in% toupper(study_area_counties))

#Importing library
library(tidygeocoder)

hospital_coords_osm <- geo(street = hospitals$Address,
                      city = hospitals$City.Town,
                      state = hospitals$State,
                      postalcode = hospitals$ZIP.Code,
                      method = "osm") #Can use different geocoding services
                                      #such as OSM or the Census

hospital_coords_census <- geo(street = hospitals$Address,
                      city = hospitals$City.Town,
                      state = hospitals$State,
                      postalcode = hospitals$ZIP.Code,
                      method = "census")

hospital_coords <- left_join(
  hospital_coords_osm,
  hospital_coords_census,
  by = "street"
) %>%
  mutate(
    city = coalesce(city.x, city.y),
    state = coalesce(state.x, state.y),
    postalcode = coalesce(postalcode.x, postalcode.y),
    lat = coalesce(lat.x, lat.y),
    long = coalesce(long.x, long.y)
  ) %>%
  select(street, city, state, postalcode, lat, long)

