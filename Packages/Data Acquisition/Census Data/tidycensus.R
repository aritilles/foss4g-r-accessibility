

#Importing libraries
library(tidycensus)
library(dplyr)

#Downloading total population for our study area
total_pop <- get_acs(geography = "block group",
                    table = "B01003", #You can also select specific
                                      #variables if you know them
                                      #(e.g. B01003_01)
                    year = 2024,
                    state = "California",
                    county = "Sacramento",
                    output = "wide",
                    geometry = FALSE) %>%
  select(-ends_with("M"))  #dplyr function to remove margin of error columns
