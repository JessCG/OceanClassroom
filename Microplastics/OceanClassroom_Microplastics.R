### Load or install required package - ggplot2 ###
if (is.element("ggplot2", installed.packages())) {
  library(ggplot2)
} else {
  install.packages("ggplot2")
}

### Load or install required package - rnaturalearth ###
if (is.element("rnaturalearth", installed.packages())) {
  library(rnaturalearth)
} else {
  install.packages("rnaturalearth")
}

### Load or install required package - rnaturalearthdata ###
if (is.element("rnaturalearthdata", installed.packages())) {
  library(rnaturalearthdata)
} else {
  install.packages("rnaturalearthdata")
}

### Load or install required package - rgeos ###
if (is.element("rgeos", installed.packages())) {
  library(rgeos)
} else {
  install.packages("rgeos")
}

### Load world map ###
world <- ne_countries(scale = "medium", returnclass = "sf")

### Load CCE-LTER microplastic data ###
plastics <- read.table('Microplastics.csv', sep = ',', header = TRUE)

### Create map ###
print(ggplot(data = world) +
  geom_sf()+
  coord_sf(xlim = c(-160, -110), ylim = c(15, 40), expand = FALSE)+
  #geom_point(data = plastics, 
  #           aes(x = Longitude, y = Latitude, size = Abundance, fill = Period), 
  #           colour = "black", pch = 21)+
  #scale_fill_manual(values=c('black', 'orange2'))+  # Change fill color of dots
  ggtitle('Plastic concentration (number per cubic meter)')+  # Title
  geom_point(aes(-136.5, 24.4), shape = 8, size = 3.5, color = 'magenta3')+  # Add Tez's location
  xlab("Longitude")+  # x-axis label
  ylab("Latitude")+  # y-axis label
  theme_bw()+  # Remove grey background
  theme(plot.title = element_text(hjust = 0.5)))  # Center title

### Save the plot into your working directory ###
ggsave('OceanClassroom_MicroplasticsPlot.png', width = 7, height = 4)  # specify figure size
