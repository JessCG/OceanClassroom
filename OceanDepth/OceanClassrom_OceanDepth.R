### Load or install required package - oce ###
if (is.element("oce", installed.packages())) {
  library(oce)
} else {
  install.packages("oce")
}

### Load or install required package - ocedata ###
if (is.element("ocedata", installed.packages())) {
  library(ocedata)
} else {
  install.packages("ocedata")
}

### Load or install required package - rgdal ###
if (is.element("rgdal", installed.packages())) {
  library(rgdal)
} else {
  install.packages("rgdal")
}

### Load coastline and water depth ###
data(coastlineWorldMedium)
data(topoWorld)

### Load Tez's location ###
track <- read.table('Track_Tez_Aug21.csv', sep = ',', header = TRUE)

### Interpolate ocean depth at Tez's location ###
track$Depth <- topoInterpolate(track$Longitude, track$Latitude, topoWorld)

### Open PDF file where map will be plotted ###
# pdf("Map_Tez.pdf", width=8, height=11)

### Set margins ###
par("mai" = c(1, 1, 0.5, 0.5), mfrow = c(2,1))

### Plot map California to Hawaii ###
mapPlot(coastlineWorldMedium, projection="+proj=merc",
        longitudelim = c(-160, -110),
        latitudelim = c(15, 40), grid = FALSE, col='grey',
        lonlabels = seq(-170, -100, by = 10),
        latlabels = seq(0, 90, by = 5), main = 'Tez\'s location')

mapImage(topoWorld, col=oceColorsGebco, breaks=seq(-6000, 0, 500), 
         filledContour = TRUE)

mapPolygon(coastlineWorldMedium, col='grey')

title(xlab = 'Longitude', ylab = 'Latitude')        # Axis labels

### Add Tez's location
# mapPoints(track$Longitude, track$Latitude, pch = 21,
#           col='black', bg='maroon1')

### Add Tez's starting point
# mapPoints(track$Longitude[1], track$Latitude[1], pch = 23, cex = 1.2,
#           col='black', bg='yellow')



### Plot water depth at Tez's location ###
plot(track$Longitude, -track$Depth/1000,             # Plot data
     type = 'l', 'col' = 'black',                    # Specify color 
     xlab = 'Longitude', ylab = 'Water depth (km)',  # Axis labels
     main = 'Water depth below Tez',                 # Title
     xlim = c(-160.1, -109.9), ylim = c(5.5, 0),     # Limits
     xaxt = 'n')                                     # Remove x-ticks

# Add points
points(track$Longitude, -track$Depth/1000, pch = 21, 
       col = 'black', bg = 'maroon1')                

# Customize x-ticks
axis(1, at = seq(-160, -110, by = 10), 
     labels = paste(seq(160, 110, by = -10), 'W', sep = ''))

# Add water surface in blue
lines(c(-170, -105), c(0,0), col = 'blue', lwd = 3)

# Add Tez's starting point
points(track$Longitude[1], -track$Depth[1]/1000, pch = 23, cex = 1.2,
       col = 'black', bg = 'yellow')

### Close PDF file ###
# dev.off()
