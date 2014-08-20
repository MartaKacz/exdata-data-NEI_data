# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# setting wd
setwd("D:/Coursera/exdata-data-NEI_data")

# reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# data preparing
Year = c(1999, 2002, 2005,2008)
Year_emissions <- c(
  sum(NEI$Emissions[NEI$year == Year[1]])
  ,sum(NEI$Emissions[NEI$year == Year[2]])
  ,sum(NEI$Emissions[NEI$year == Year[3]])
  ,sum(NEI$Emissions[NEI$year == Year[4]]))

plot(Year, Year_emissions, ylab = "Total amount of PM2.5 emitted, in tons", 
     type = "b", col = "red")

# saving to png file
png("plot1.png",  width = 480 ,height  = 480, units = "px")
plot(Year, Year_emissions, ylab = "Total amount of PM2.5 emitted, in tons", 
     type = "b", col = "red")
dev.off()


  
  



