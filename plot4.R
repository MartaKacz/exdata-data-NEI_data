# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# setting wd
setwd("D:/Coursera/exdata-data-NEI_data")

# reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# searching SCC Short.Name with Coal
first.step<-grep("(^|[^a-zA-Z])[Cc]oal[^a-zA-Z]",SCC$Short.Name,value=T)
# searching SCC Short.Name with Comb
second.step<-grep("(^|[^a-zA-Z])[Cc]omb[^a-zA-Z]",first.step,value=T)

SCC.code<-list()
for(i in 1: length(second.step))
{
  SCC.code[[i]]<-as.factor(SCC$SCC[second.step[i] == SCC$Short.Name])
}

SCC.code<-unlist(SCC.code)


NEI.COAL.COMB <-NEI[NEI$SCC %in% SCC.code,c(3:6)]

NEI.COAL.COMB_aggr <- aggregate(NEI.COAL.COMB $Emissions, by=list(Year = NEI.COAL.COMB $year), FUN=sum)


ggplot(NEI.COAL.COMB_aggr ,aes(x=Year, y = x))+
  geom_line(aes( x=Year, y = x), data = NEI.COAL.COMB_aggr)+
  ylab("Total amount of PM2.5 emitted, in tons")+
  labs(title = "Emissions from coal combustion-related")


# saving to png file
png("plot4.png",  width = 480 ,height  = 480, units = "px")
ggplot(NEI.COAL.COMB_aggr ,aes(x=Year, y = x))+
  geom_line(aes( x=Year, y = x), data = NEI.COAL.COMB_aggr)+
  ylab("Total amount of PM2.5 emitted, in tons")+
  labs(title = "Emissions from coal combustion-related")
dev.off()

