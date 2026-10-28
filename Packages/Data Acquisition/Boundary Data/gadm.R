

#Importing library
library(geodata)

# Download GADM level 2 (Counties) for Australia
australia_gadm <- gadm(country = "AUS", level = 2, path = tempdir())

# Subsetting State of Victoria
victoria <- australia_gadm[australia_gadm$NAME_1 == "Victoria", ]

plot(victoria)
