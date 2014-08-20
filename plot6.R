# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?


# setting wd
setwd("D:/Coursera/exdata-data-NEI_data")

# reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# data for Boltimore
NEI.Boltimore <-NEI[NEI$fips == "24510",c(2,3:6)]

# I'm  using regular expressions for getting the scc values
first.step<- SCC$SCC[grep("^(.*)[mM]obile(.*)[rR]oad(.*)$", as.character(SCC$EI.Sector))]

SCC.code<-first.step

NEI.Boltimore<-NEI.Boltimore[as.factor(NEI.Boltimore[,1]) %in% SCC.code,]

NEI.Boltimore_aggr <- aggregate(NEI.Boltimore$Emissions, by=list(Year =NEI.Boltimore$year), FUN=sum)

# data for California
NEI.Calif <-NEI[NEI$fips == "06037",c(2,3:6)]
NEI.Calif<-NEI.Calif[as.factor(NEI.Calif[,1]) %in% SCC.code,]

NEI.Calif_aggr <- aggregate(NEI.Calif$Emissions, by=list(Year =NEI.Calif$year), FUN=sum)
NEI.Calif_aggr$City = "California"
NEI.Boltimore_aggr$City = "Boltimore"

# join the data
NEI_agrr<- rbind(NEI.Calif_aggr, NEI.Boltimore_aggr)

ggplot(NEI_agrr ,aes(x=Year, y = x))+
  geom_point(aes( x=Year, y = x), data = NEI_agrr)+
  geom_line(aes(colour =City), size = 2)+
  scale_fill_discrete(name="Types")+
  ylab("Total amount of PM2.5 emitted, in tons")+
  labs(title = "Emissions from motor vehicle sources in Boltimore and California")





# saving to png file
png("plot6.png",  width = 480 ,height  = 480, units = "px")
ggplot(NEI_agrr ,aes(x=Year, y = x))+
  geom_point(aes( x=Year, y = x), data = NEI_agrr)+
  geom_line(aes(colour =City), size = 2)+
  scale_fill_discrete(name="Types")+
  ylab("Total amount of PM2.5 emitted, in tons")+
  labs(title = "Emissions from motor vehicle sources in Boltimore and California")
dev.off()



