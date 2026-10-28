

#Importing libraries
library(leaflet)
library(htmltools)

#Setting color palette 
pal <- colorNumeric(
  palette = "YlOrRd",
  domain  = block_groups$accessibility
)


labels <- sprintf(
  "<strong>%s</strong><br/>Hospitals reachable: %s<br/>Population: %s",
  block_groups$GEOID,
  block_groups$accessibility,   #Creating hover labels
  block_groups$Total_Pop
) |>
  lapply(HTML)

hospital_access_map <- leaflet(block_groups) |>
  addControl(
    html = "<div style='           #Creating Map title
              font-size:20px;
              font-weight:bold;
              color:black;
              padding:10px;
              border-radius:6px;
              text-align:center;
            '>
              Hospital Accessibility (30-Minute Travel Time)
            </div>",
    position = "topleft"
  ) |>
  addTiles() |> #Setting basemap, lots of different options!
  setView(-121.5, 38.5, 9) |> #setting view and zoom level
  addPolygons(
    fillColor = ~pal(accessibility),
    fillOpacity = 0.75,
    color = "white",
    weight = 0.6,
    opacity = 1,
    label = labels,
    highlightOptions = highlightOptions(
      weight = 2,
      color = "#FFFF00",
      bringToFront = TRUE
    )
  ) |>
  addLegend(     #Adding legend
    pal = pal,
    values = ~accessibility,
    title = "Hospitals reachable (30 min)",
    opacity = 0.9,
    position = "bottomleft"
  )
hospital_access_map

#Saving map as an html widget
library(htmlwidgets)

saveWidget(
  widget = hospital_access_map,
  file = "hospital_access_map.html",
  selfcontained = TRUE
)
