# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

# setting wd
setwd("D:/Coursera/exdata-data-NEI_data")

# reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# only data for Baltimore
NEI.Boltimore <-NEI[NEI$fips == "24510",c(3:6)]

NEI.Boltimore_aggr <- aggregate(NEI.Boltimore$Emissions, by=list(Type =NEI.Boltimore$type,Year = NEI.Boltimore$year), FUN=sum)


ggplot(NEI.Boltimore_aggr ,aes(x=Year, y = x))+
  geom_point(aes( x=Year, y = x), data = NEI.Boltimore_aggr)+
  geom_line(aes(colour = Type), size = 2)+
  scale_fill_discrete(name="Types")+
  ylab("Total amount of PM2.5 emitted, in tons")

# saving to png file
png("plot3.png",  width = 480 ,height  = 480, units = "px")
ggplot(NEI.Boltimore_aggr ,aes(x=Year, y = x))+
  geom_point(aes( x=Year, y = x), data = NEI.Boltimore_aggr)+
  geom_line(aes(colour = Type), size = 2)+
  scale_fill_discrete(name="Types")+
  ylab("Total amount of PM2.5 emitted, in tons")
dev.off()
