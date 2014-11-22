# load and use plyr library
library(plyr)

# load data set
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# calculate the total emission for each year
totalEmissionByYear <- ddply(NEI, ~year, summarise, sum=sum(Emissions))

# init a png device, the default resolution is 480x480 
png(filename="plot1.png")

# plot historgram on global active power
plot(totalEmissionByYear$year, totalEmissionByYear$sum, xlab="Year", ylab="Total Emission (tons)", type= "l")

# close png device and save the file
dev.off()

