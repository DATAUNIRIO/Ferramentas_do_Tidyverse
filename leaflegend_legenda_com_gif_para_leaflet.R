library(leaflet)
library(leaflegend)
library(sf)
library(osmdata)

foodDrink <- opq(bbox= c(-122.367375,
                         47.643819,
                         -122.323258,
                         47.658698)) %>%
  add_osm_feature(key = 'amenity', 
                  value = c('restaurant', 'pub', 'cafe')) %>%
    osmdata_sf() %>%
  getElement('osm_points')

foodDrink <- foodDrink[!is.na(foodDrink$amenity), ]

iconSet <- awesomeIconList(
  pub = makeAwesomeIcon(
    icon = 'beer',
    library = 'fa',
    iconColor = 'gold',
    markerColor = 'red',
    iconRotate = 10
  ),
  cafe = makeAwesomeIcon(
    icon = 'coffee',
    library = 'ion',
    iconColor = '#000000',
    markerColor = 'blue',
    squareMarker = TRUE
  ),
  restaurant = makeAwesomeIcon(
    icon = 'cutlery',
    library = 'glyphicon',
    iconColor = 'rgb(192, 255, 0)',
    markerColor = 'darkpurple',
    spin = TRUE,
    squareMarker = FALSE
  )
)

leaflet(foodDrink) %>%
  addTiles() %>%
  addAwesomeMarkers(icon = ~iconSet[amenity],
                    group = ~amenity) %>%
  addLegendAwesomeIcon(iconSet = iconSet,
                       orientation = 'horizontal',
                       title = htmltools::tags$div(
                         style = 'font-size: 20px;',
                         'Horizontal Legend'),
                       labelStyle = 'font-size: 16px;',
                       position = 'bottomright',
                       group = 'Horizontal Legend') %>%
  addLegendAwesomeIcon(iconSet = iconSet,
                       orientation = 'vertical',
                       marker = FALSE,
                       title = htmltools::tags$div(
                         style = 'font-size: 20px;',
                         'Vertical Legend'),
                       labelStyle = 'font-size: 16px;',
                       position = 'bottomright',
                       group = 'Vertical Legend') %>%
  addLayersControl(baseGroups = sprintf('%s Legend', 
                                        c('Horizontal', 'Vertical')),
                   overlayGroups = c('pub', 'cafe', 'restaurant'),
                   options = layersControlOptions(collapsed = FALSE))