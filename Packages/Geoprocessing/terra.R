

#Importing libraries
library(terra)
library(geodata)

# Download a global DEM tile (SRTM)
dem <- elevation_30s(country = "United States", path = tempdir())

#Calculating and visualizing slope using terra
slope <- terrain(dem, v = "slope", unit = "degrees")
plot(slope, main = "Slope (degrees)")

# Quick visualization
plot(dem, main = "USA Elevation (SRTM)")