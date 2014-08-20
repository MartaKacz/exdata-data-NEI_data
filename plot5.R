#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


# setting wd
setwd("D:/Coursera/exdata-data-NEI_data")

# reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI.Boltimore <-NEI[NEI$fips == "24510",c(2,3:6)]

# I'm  using regular expressions for getting the scc values
first.step<- SCC$SCC[grep("^(.*)[mM]obile(.*)[rR]oad(.*)$", as.character(SCC$EI.Sector))]

SCC.code<-first.step

NEI.Boltimore<-NEI.Boltimore[as.factor(NEI.Boltimore[,1]) %in% SCC.code,]

NEI.Boltimore_aggr <- aggregate(NEI.Boltimore$Emissions, by=list(Year =NEI.Boltimore$year), FUN=sum)


ggplot(NEI.Boltimore_aggr ,aes(x=Year, y = x))+
  geom_line(aes( x=Year, y = x), data = NEI.Boltimore_aggr)+
  ylab("Total amount of PM2.5 emitted, in tons")+
  labs(title = "Emissions from from motor vehicle sources in Boltimore City")

# saving to png file
png("plot5.png",  width = 480 ,height  = 480, units = "px")
ggplot(NEI.Boltimore_aggr ,aes(x=Year, y = x))+
  geom_line(aes( x=Year, y = x), data = NEI.Boltimore_aggr)+
  ylab("Total amount of PM2.5 emitted, in tons")+
  labs(title = "Emissions from from motor vehicle sources in Boltimore City")
dev.off()


  