# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make
# a plot answering this question.

# setting wd
setwd("D:/Coursera/exdata-data-NEI_data")

# reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# data preparing
Year = c(1999, 2002, 2005,2008)

Year_emissions <- c(
  sum(NEI$Emissions[NEI$year == Year[1] & NEI$fips == "24510"])
  ,sum(NEI$Emissions[NEI$year == Year[2] & NEI$fips == "24510"])
  ,sum(NEI$Emissions[NEI$year == Year[3] & NEI$fips == "24510"])
  ,sum(NEI$Emissions[NEI$year == Year[4] & NEI$fips == "24510"]))


plot(Year, Year_emissions, ylab = "Total amount of PM2.5 emitted, in tons", 
     type = "b", col = "red", main = 'Result for Baltimore City')

# saving to png file
png("plot2.png",  width = 480 ,height  = 480, units = "px")
plot(Year, Year_emissions, ylab = "Total amount of PM2.5 emitted, in tons", 
     type = "b", col = "red", main = 'Result for Baltimore City')
dev.off()



