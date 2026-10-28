

#Importing library
library(mapview)
mapviewOptions(basemaps = c("OpenStreetMap"))



#Block Groups
bg_view <- mapview(block_groups, col.regions = "forestgreen",
                  layer.name = "Block Groups")
bg_view

#Victoria - gadm
victoria_view <- mapview(victoria, col.regions = "violet",
                        layer.name = "Victoria, Australia")
victoria_view

#Hospital Points
hospital_points_view <- mapview(hospital_points, col.regions = "darkred",
                               layer.name = "Hospitals", label = "city")
hospital_points_view

#Block Group Centroids
bg_centroids_view <- mapview(bg_centroids, col.regions = "black",
                            layer.name = "Block Group Centroids", cex = 0.5)+
  bg_view
bg_centroids_view

#Detailed Itineraries
itins_geos <- itins_subset$from_id
bg_centroids_itins = bg_centroids[bg_centroids$GEOID %in% itins_geos,]
itins_hospital = hospital_points$hospital_id[as.integer(itins_subset$to_id)]
hospital_points_itins = hospital_points[
  hospital_points$hospital_id %in% itins_hospital,
]


itins_view <- mapview(itins_subset, layer.name = "Routes") +
  mapview(bg_centroids_itins, col.regions = "black",
          layer.name = "Origins") +
  mapview(hospital_points_itins, col.regions = "darkred",
          layer.name = "Destination")
itins_view


#Isochrones
iso_view <- mapview(iso, layer.name = "Isochrones",
                   zcol = "isochrone",
                   burst = TRUE)
iso_view

sac_county_view <- mapview(sac_county, lwd = 2, layer.name = "Sacramento County")+
  mapview(ca_counties, alpha.regions = 0, lwd = 2, layer.name = "California")
sac_county_view

# dem_view = mapview(dem)
# dem_view
