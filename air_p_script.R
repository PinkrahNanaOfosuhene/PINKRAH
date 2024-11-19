library(readr)
library(ggplot2)
library(lubridate)
library(data.table)
library(openair)
library(dplyr)
library(zoo)
library(rio)
library(tidyverse)

# IMPORTING DATA
Pinkrah <- import('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/SUMMER_DATA.csv')

# Working on date and time
Pinkrah$date_time <- lubridate::mdy_hm(Pinkrah$date_time)

# Creating a column for season
Pinkrah <- cutData(Pinkrah , type = "season")

# Renaming variable name
Pinkrah = rename(Pinkrah, date = date_time)

library(openair) 
data(Pinkrah) 

# summaryPlot function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_summary_plot.png', width = 800, height = 600)


summaryPlot(Pinkrah, 
            avg.time = 'month', 
            col.data = "green", 
            col.dens = "yellow", 
            col.trend = "red", 
            colnames = "blue")

# Close the PNG device to save the file
dev.off()



# 2. Saving the timePlot as a PNG
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_time_plot.png', width = 800, height = 600)

#  timePlot function
timePlot(Pinkrah, 
         pollutant = c('pm25', 'pm10'), 
         avg.time = "day", 
         col = c("red", "blue"), 
         main = "Time Plot for PM2.5 and PM10")
dev.off()

# 3. Polar Plot function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_polar_plot.png', width = 800, height = 600)
polarPlot(Pinkrah, pollutant = "pm10", main = "Polar Plot of PM10")
dev.off()

# 4.  Calendar Plot function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_calendar_plot.png', width = 800, height = 600)
calendarPlot(Pinkrah, pollutant = "pm10", main = "Calendar Plot of PM10")
dev.off()

# 5. timeVariation plot function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_time_variation.png', width = 800, height = 600)
timeVariation(Pinkrah, 
              pollutant = c('pm25', 'pm10'), 
              main = "Time Variation of PM2.5 and PM10", 
              col = c("red", "blue"))
dev.off()

# 6. windRose function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_wind_rose.png', width = 800, height = 600)
windRose(Pinkrah, pollutant = "pm10", main = "Wind Rose for PM10")
dev.off()

# 7.scatterPlot function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_scatter_plot.png', width = 800, height = 600)
ggplot(Pinkrah, aes(x = pm25, y = pm10)) +
  geom_point(color = "blue") +
  labs(title = "Scatter Plot of PM2.5 vs PM10", x = "PM2.5", y = "PM10") +
  theme_minimal()
dev.off()

# 8. Correlation Plot function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_correlation_plot.png', width = 800, height = 600)
corPlot(Pinkrah, pollutant = c("pm25", "pm10", "temp", "rh"), 
        main = "Correlation Plot of PM2.5, PM10, Temperature, and RH")
dev.off()

# 9. sm0oth trend function
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_seasonal_plot.png', width = 800, height = 600)
smoothTrend(Pinkrah, pollutant = "pm25", main = "smoothtrend Plot of PM2.5")
dev.off()

# 10. linear relation function plot of pm25 and pm10
png('C:/Users/USER/Documents/Pinkrah_Nana_Ofosuhene/Pinkrah_linearRelation_plot.png', width = 800, height = 600)
linearRelation(Pinkrah, x = "pm25", y ="pm10", main = "linearRelation Plot of PM2.5 and PM10")
dev.off()

