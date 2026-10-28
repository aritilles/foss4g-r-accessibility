

# #Joining population data to block groups
block_groups <- left_join(block_groups, total_pop, by = "GEOID")
colnames(block_groups)[15] = "Total_Pop" #Renaming the census column
access_30 <- access_30 %>% rename(GEOID = id) #Renaming the ID column
block_groups <- left_join(block_groups, access_30, by = "GEOID")

#Importing library
library(spdep)
#Testing for spatial autocorrelation among accessibility values

#Build contiguity neighbors (Queen)
#Create polygon neighbors with poly2nb():
bg_nb <- poly2nb(block_groups) # Queen contiguity (default)

#Visualize neighbor connectivity
bg_cent <- st_coordinates(st_centroid(block_groups))
plot(st_geometry(block_groups), border = "grey50", lwd = 0.4)
plot(bg_nb, bg_cent, add = TRUE, col = "red", lwd = 0.5)

#Convert neighbors → weights list
#Many tests in spdep use a listw object:
bgweightsw <- nb2listw(bg_nb, style = "W")  # row-standardized

#Moran's I of Accessible Hospitals
bg_moran <- moran.test(block_groups$accessibility, bgweightsw,
                      zero.policy = TRUE, na.action = na.exclude)


print(bg_moran$estimate)
print(bg_moran$p.value)

#Plot
bgMoranScatterplot = moran.plot(block_groups$accessibility, bgweightsw,
                                xlab = "Accessible Hospitals",
                                ylab = "Spatially Lagged Accessible Hospitals")
bgMoranScatterplot

