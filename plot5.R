# load and use plyr library
library(plyr)
# load ggplot2 library for plotting
library(ggplot2)
# load sqldf library for joining data frames
library(sqldf)

# load data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get Baltimore motor vechicle emissions
baltimoreNEI <- sqldf("SELECT year, Emissions FROM NEI JOIN SCC USING(SCC) WHERE fips='24510' AND SCC.EI_Sector LIKE 'Mobile%'")

# calculate the total emission for each year
baltimoreEmissionByYear <- ddply(baltimoreNEI, ~year, summarise, sum=sum(Emissions))

# init a png device, the default resolution is 480x480 
png(filename="plot5.png")

# plot line diagram
qplot(year, sum, data= baltimoreEmissionByYear, geom="line") + ylab("Total Emission (tons)") + xlab("Year")

# close png device and save the file
dev.off()

