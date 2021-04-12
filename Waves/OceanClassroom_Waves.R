# Select the directory in which you put all the files to be 
# your working directory. Go to:
# Session > Set Working Directory > Choose Directory...

# Install ggplot2 if not already installed, otherwise load
if (is.element("ggplot2", installed.packages())) {
  library(ggplot2)
} else {
  install.packages("ggplot2")
}

# Load the wave data
SF <- read.table('CDIP142_SF_JuneJuly2020.csv', sep = ',', header = TRUE)
Tez <- read.table('CDIP158_CabrilloPoint_JuneJuly2020.csv', sep = ',', header = TRUE)
PS <- read.table('CDIP157_PointSur_JuneJuly2020.csv', sep = ',', header = TRUE)

# Convert data to date string
SF$PDT <- as.POSIXct(SF$PDT, tz = "America/Los_Angeles")
Tez$PDT <- as.POSIXct(Tez$PDT, tz = "America/Los_Angeles")
PS$PDT <- as.POSIXct(PS$PDT, tz = "America/Los_Angeles")

# Plot the wave data
print(ggplot()+
  geom_line(data = SF, aes(x = PDT, y = Hs, colour = '2'), size = 1)+
  # geom_line(data = Tez, aes(x = PDT, y = Hs, colour = '3'), size = 1)+
  # geom_line(data = PS, aes(x = PDT, y = Hs, colour = '1'), size = 1)+
  xlab('Date')+
  ylab('Wave height (m)')+
  # geom_vline(xintercept = as.POSIXct("2020-07-02 23:00:00 PDT"), colour = 'magenta3')+
  scale_color_manual(name = 'CDIP buoy:', labels = c("San Francisco", 
                                                     "Monterey Harbor (Tez)", "Point Sur"), 
                     values=c('steelblue1', 'magenta3', 'steelblue4'))+
  theme_bw()+
  theme(legend.position="top"))

# Save the plot into your working directory
ggsave('OceanClassroom_WavesPlot.png')
  
