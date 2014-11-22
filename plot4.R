# load and use plyr library
library(plyr)
# load ggplot2 library for plotting
library(ggplot2)
# load sqldf library for joining data frames
library(sqldf)

# load data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get coal data
coalNEI <- sqldf("SELECT year, Emissions FROM NEI JOIN SCC USING(SCC) WHERE SCC.EI_Sector=='Fuel Comb - Electric Generation - Coal'")

# calculate the total emission for each year
coalTotalEmissionByYear <- ddply(coalNEI, ~year, summarise, sum=sum(Emissions))

# init a png device, the default resolution is 480x480 
png(filename="plot4.png")

# plot line diagram
qplot(year, sum, data=coalTotalEmissionByYear, geom="line") + ylab("Total Emission (tons)") + xlab("Year")

# close png device and save the file
dev.off()

