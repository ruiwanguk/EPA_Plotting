# load and use plyr library
library(plyr)
# load ggplot2 library for plotting
library(ggplot2)
# load sqldf library for joining data frames
library(sqldf)

# load data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get Baltimore and LA motor vechicle emissions
baltimoreNEI <- sqldf("SELECT year, Emissions FROM NEI JOIN SCC USING(SCC) WHERE fips='24510' AND SCC.EI_Sector LIKE 'Mobile%'")
laNEI <- sqldf("SELECT year, Emissions FROM NEI JOIN SCC USING(SCC) WHERE fips='06037' AND SCC.EI_Sector LIKE 'Mobile%'")

# calculate the total emission for each year
baltimoreEmissionByYear <- ddply(baltimoreNEI, ~year, summarise, sum=sum(Emissions))
laEmissionByYear <- ddply(laNEI, ~year, summarise, sum=sum(Emissions))

# annotate county
baltimoreEmissionByYear['County'] <- "Baltimore"
laEmissionByYear['County'] <- "LA"

# merge two data frames
countyEmissionByYear <- rbind(baltimoreEmissionByYear, laEmissionByYear)

# init a png device, the default resolution is 480x480 
png(filename="plot6.png")

# plot line diagram
ggplot(countyEmissionByYear, aes(year, sum, fill=County, col=County)) + geom_line() + xlab("Year") + ylab("Total Emission (tons)")

# close png device and save the file
dev.off()

